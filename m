From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] URL rewrite in .gitmodules
Date: Tue, 20 Oct 2015 10:33:35 -0700
Message-ID: <xmqqio618mxc.fsf@gitster.mtv.corp.google.com>
References: <DCA9FD0F-252B-4CD7-9137-395771CBC62E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 19:33:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zoan9-0005Ao-U6
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 19:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbbJTRdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 13:33:40 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36342 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbJTRdi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 13:33:38 -0400
Received: by pacfv9 with SMTP id fv9so28391955pac.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=q1fsGiYKsoEpjdPuOksiTnk38X8G4q/t/5/2Zcs6l8A=;
        b=PMJ9TEBM6PCbLBjimjAy1Wv4YWcWbG4X3CqZZ9V7cO/b6zzI4s8MmR7j+oVkuQ9bAN
         KUF04slbbZWzdiv5DrDk/O/ZQMuJSl38gb/Lnr9q18fHG0w2tW1EodXavAjpsl4VTfbv
         q/rRn2KMQlaB0wXGRnicmgTBzocD28wFXbxcwmWO5ysc8GCCtoavg7kqDQkbYzZh7/ld
         fORbvsFsJj2MwcY/Tj2nUhBLpvvWYHMLj4cpBTVr8liFTjSuu/vhwWGxSPHUyrqDabsE
         TqHCitFMjxmIpCNBBRwI5fNd6/uwdKz8yC0XYLJUg/+O8MzRPUP1RRmTGHTqXcjbMyR0
         gjxA==
X-Received: by 10.66.101.9 with SMTP id fc9mr5302766pab.19.1445362418178;
        Tue, 20 Oct 2015 10:33:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id ns1sm4816421pbc.67.2015.10.20.10.33.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 10:33:36 -0700 (PDT)
In-Reply-To: <DCA9FD0F-252B-4CD7-9137-395771CBC62E@gmail.com> (Lars
	Schneider's message of "Mon, 19 Oct 2015 21:28:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279928>

Lars Schneider <larsxschneider@gmail.com> writes:

> If not, what do you think about a patch that adds a "url" section
> similar to the one in git config to a .gitmodules file?
>
> Example:
> ----------
> [submodule "git"]
> 	path = git
>         url=git://github.com/larsxschneider/git.git
>
> [url "mycompany.com"]
>         insteadOf = outside.com
> ----------

It is unclear to me if you are adding the last two (or three,
counting the blank before) lines to your company's private fork of
the opensource project, but if that is the case, then that would
defeat your earlier desire:

> ... I also would prefer not to do this as I want to use the
> very same hashes as defined by the "upstream" ...

wouldn't it?

I do not think this topic is specific to use of submodules.  If you
want to encourage your engineers to fetch from nearby mirrors you
maintain, you would want a forest of url.mine.insteadof=theirs for
the external repositories that matter to you specified by
everybody's $HOME/.gitconfig, and one way to do so would be to have
them use the configuration inclusion.  An item in your engineer
orientation material could tell them to add

	[include]
		path = /usr/local/etc/git/mycompany.urlrewrite

when they set up their "[user] name/email" in there.

And you can update /usr/local/etc/git/mycompany.urlrewrite as
needed.
