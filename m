From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] revert: fix buffer overflow in insn sheet parser
Date: Thu, 20 Oct 2011 04:09:12 -0500
Message-ID: <20111020090912.GA21471@elie.hsd1.il.comcast.net>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
 <1319058208-17923-4-git-send-email-artagnon@gmail.com>
 <7v8vogbgai.fsf@alter.siamese.dyndns.org>
 <20111020080328.GA12337@elie.hsd1.il.comcast.net>
 <4E9FE061.3080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 11:09:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGocv-0000Fb-RE
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 11:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab1JTJJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 05:09:21 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61100 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab1JTJJU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 05:09:20 -0400
Received: by ggnb1 with SMTP id b1so2566395ggn.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5dtDnlUP0R8ouolXU3nEaDV+djVlM1s4C3W4xCYrIrQ=;
        b=po1csIcFpdwYoJ4HiAJaJpthHkHw787z0Wj6sQObg8ZxZtwj6baao6l8hr5R2/GSIO
         GtXwfBGPbp0cRJge/1HaszC5MWsR4z0vaoF12A0HhgpPkfOtfSm58cvoSJJnKRsPO3K3
         SMNS/BP4TI6ST77h1klTDZUALopIOjEXalOUo=
Received: by 10.42.148.198 with SMTP id s6mr17930695icv.56.1319101759983;
        Thu, 20 Oct 2011 02:09:19 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bu33sm22079125ibb.11.2011.10.20.02.09.18
        (version=SSLv3 cipher=OTHER);
        Thu, 20 Oct 2011 02:09:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E9FE061.3080601@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184017>

Ramkumar Ramachandra wrote:

> Okay.  How about putting this after 5/6?
>
> -- 8< --
> Subject: [PATCH] t3510: guard against buffer overflows in parser
> 
> To guard against a buffer overflow in the parser, verify that
> instruction sheets with overly long object names are parsed.

Looks good, except I would explain it differently, to avoid referring
to hypothetical implementation details ("What buffer overflow?"):

	test: git cherry-pick --continue should cope with long object names

	A naive implementation that uses a commit-id-shaped buffer
	to store the word after "pick" in .git/sequencer/todo lines
	would crash often.  Our implementation is not so naive, but
	add a test anyway to futureproof it.

Or:

	test: make sure the "cherry-pick --continue" buffer overflow doesn't come back

	Before commit ..., "git cherry-pick --continue" would overflow
	under ... circumstance.  Add a test to make sure it doesn't
	happen again.

Though the implementation is actually better than that --- it can even
cope with a valid object name (e.g., a long name of a branch, or
something like "HEAD^{/refs.c: ensure struct whose member}") that is
that long, without truncating it.  So if you have time for it, I think
it would be worth a test where the "git cherry-pick --continue"
succeeds, too.

Thanks,
Jonathan
