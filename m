From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: unchecked uses of strdup
Date: Thu, 6 Apr 2006 16:11:22 +0200
Message-ID: <81b0412b0604060711o57fb110cm5fa559c0fd785a66@mail.gmail.com>
References: <20060403221841.25097.18242.stgit@dv.roinet.com>
	 <7vzmj2b3w3.fsf@assigned-by-dhcp.cox.net>
	 <20060404105818.GA17326@mars.ravnborg.org>
	 <1144165927.30675.32.camel@dv> <87d5fwau3z.fsf_-_@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 06 16:12:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRVCp-0002pV-UV
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 16:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWDFOLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 10:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWDFOLY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 10:11:24 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:19101 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932114AbWDFOLX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 10:11:23 -0400
Received: by pproxy.gmail.com with SMTP id f28so160331pyf
        for <git@vger.kernel.org>; Thu, 06 Apr 2006 07:11:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=esgkhfHsrrbW6qQTlql8yn2i1Sul5CubmO9M0Ie7MWc+TbYOeo7kia7ALpLJaJf5NP/FyMnNwJe9v88B/LEN99f6cWnvU0C4Nispq5qz1dEqRHokGmkGYAS2a2TYv6UCJJDP51SSOTRECFkkxIWc6MYQOiy/ERIyzfR8g9gCAjc=
Received: by 10.35.17.8 with SMTP id u8mr243852pyi;
        Thu, 06 Apr 2006 07:11:22 -0700 (PDT)
Received: by 10.35.41.18 with HTTP; Thu, 6 Apr 2006 07:11:22 -0700 (PDT)
To: "Jim Meyering" <jim@meyering.net>
In-Reply-To: <87d5fwau3z.fsf_-_@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18470>

On 4/5/06, Jim Meyering <jim@meyering.net> wrote:
> There are pretty many uses of strdup in git's sources.
> Here's one that can cause trouble if it ever returns NULL:
>
>     [from fsck-objects.c]
>     static int fsck_head_link(void)
>     {
>             unsigned char sha1[20];
>             const char *git_HEAD = strdup(git_path("HEAD"));
>             const char *git_refs_heads_master = resolve_ref(git_HEAD, sha1, 1);
>
> The problem is that resolve_ref does an unconditional `stat'
> on the parameter corresponding to the maybe-NULL git_HEAD.

That's actually alright (aside a nice core file). Worse are the cases
where a NULL would cause some "normal" behaviour, e.g. arguments,
which have a meaning for NULL value.
