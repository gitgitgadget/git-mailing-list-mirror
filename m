From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <planche2k@googlemail.com>
Subject: Re: [PATCH/resend] Fix use of hardlinks in "make install"
Date: Sat, 30 Aug 2008 10:59:36 +0200
Message-ID: <66B007DD-F970-43E5-BA38-6138E553C93A@googlemail.com>
References: <81b0412b0808280704h585b6cb4nf03e509de0159a91@mail.gmail.com> <81b0412b0808280717u78c5ccf8ne1413c701ed8edd9@mail.gmail.com> <20080830002032.GA14522@steel.home>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 11:01:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZMKa-0007Ph-GJ
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 11:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbYH3JAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 05:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbYH3JAF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 05:00:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:30290 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYH3JAB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 05:00:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so746000fgg.17
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=WrwoMkdbiWhi8/b86myoaqsMp/tXkoUFB3Z6DlgraJw=;
        b=Evxv7x+5Lbr3U5gQYT7JnhD9yeViw6x2V9OELRxQygg7Yi8SCFn93/ZQDGkwOHR17G
         GcvSTaZTu8ZBVBcCPW678+VhjMLxlzZpBlvQnDNyRy2iMOUDpxN6ToW31AVLjpuoNhGv
         x0Z/RWxvHDaliE/SbtEEqplZIaPd39UMESM6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=wUFpzD1CZOtq23pT9hJbQWgWFKSV0+1qXC5XiLKgrzGSMZ0o9BDGcq5KgZAlmcepPl
         mLbJr5P276Vt6lWgC15xFrefVIk5pJdh19kko/BdFoPZi4+MlW8LADobcTuvVt1QEaVa
         1WEreYyDdY8N9oUzlMHwRgO8r+xMBKfZJ5Pv4=
Received: by 10.86.98.14 with SMTP id v14mr2791430fgb.74.1220086800573;
        Sat, 30 Aug 2008 02:00:00 -0700 (PDT)
Received: from ?10.0.1.1? ( [91.18.70.30])
        by mx.google.com with ESMTPS id e20sm3244897fga.1.2008.08.30.01.59.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 01:59:59 -0700 (PDT)
In-Reply-To: <20080830002032.GA14522@steel.home>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94360>


Am 30.08.2008 um 02:20 schrieb Alex Riesen:

> The code failed to filter-out git-add properly on platforms were $X is
> not empty (ATM there is only one such a platform).
>
> Than it tried to create a hardlink to the file ($execdir/git-add) it  
> just
> removed (because git-add is first in the BUILT_INS), so ln failed (but
> because stderr was redirected into /dev/null the error was never  
> seen), and
> the whole install ended up using "ln -s" instead.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---

> Well, as usual, simple fix for a trivial typo caused by existence of  
> an
> idiotic platform.
>
> Makefile |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index bf400e6..20f028f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1379,7 +1379,7 @@ endif
> 	{ $(RM) "$$execdir/git-add$X" && \
> 		ln git-add$X "$$execdir/git-add$X" 2>/dev/null || \
> 		cp git-add$X "$$execdir/git-add$X"; } && \
> -	{ $(foreach p,$(filter-out git-add,$(BUILT_INS)), $(RM) "$$execdir/ 
> $p" && \
> +	{ $(foreach p,$(filter-out git-add$X,$(BUILT_INS)), $(RM) "$ 
> $execdir/$p" && \
> 		ln "$$execdir/git-add$X" "$$execdir/$p" 2>/dev/null || \
> 		ln -s "git-add$X" "$$execdir/$p" 2>/dev/null || \
> 		cp "$$execdir/git-add$X" "$$execdir/$p" || exit;) } && \
> -- 
> 1.6.0.1.152.g6969c

Your patch seems to work on Haiku, don't have a MinGW setup to test.  
Sorry for the breakage.

Andreas
