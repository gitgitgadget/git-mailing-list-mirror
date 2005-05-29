From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [COGITO PATCH] Fix cg-log and cg-status for non-GNU sed/sort
Date: Mon, 30 May 2005 01:16:52 +0200
Message-ID: <20050529231652.GX1036@pasky.ji.cz>
References: <20050529230011.30885.qmail@web41201.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 01:15:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcWzL-0004vy-DI
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVE2XRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVE2XRA
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:17:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10885 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261394AbVE2XQ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 19:16:57 -0400
Received: (qmail 19828 invoked by uid 2001); 29 May 2005 23:16:52 -0000
To: Mark Allen <mrallen1@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20050529230011.30885.qmail@web41201.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 30, 2005 at 01:00:10AM CEST, I got a letter
where Mark Allen <mrallen1@yahoo.com> told me that...
> Here're a couple of pretty simple patches against cg-log and cg-status (two cogito
> commands I use a lot) for the non-GNU (or at least older, forked GNU) tools on Darwin.

> @@ -148,10 +148,10 @@
>                                 fi
> 
>                                 date=(${rest#*> })
> -                               pdate="$(showdate $date)"
> +                               pdate="$(date -u -r $date)"

Hmm, coudlnt' showdate be fixed instead then? And $date is not a file so
-r $date makes no sense to me - what am I missing?

>                                 if [ "$pdate" ]; then
> -                                       echo -n $color$key $rest | sed "s/>.*/> $pdate/"
> -                                       echo $coldefault
> +                                       echo -n $color$key $rest | sed "s/>.*/> $pdate/"
> +                                       echo -n $coldefault

I'm lost on this one too. Why do you introduce the -n?

>                                 else
>                                         echo $color$key $rest $coldefault
>                                 fi
> @@ -168,11 +168,8 @@
>                                 if [ -n "$list_files" ]; then
>                                         list_commit_files "$tree1" "$tree2"
>                                 fi
> -                               echo; sed -re '
> -                                       / *Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/
> -                                       / *Acked-by:.*/Is//'$colsignoff'&'$coldefault'/
> -                                       s/./    &/
> -                               '
> +                               echo; sed -e "/ *Signed-off-by:.*/s/ *Signed-off-by:.*/$colsignoff&$coldefault/" -e"/
> +*Acked-by:.*/s/ *Acked-by:.*/$colsignoff&$coldefault/" -e "s/./    &/"
> +

Is it necessary to take away the newlines? What is the real problem,
actually? Just the I flag?

Could you please sign the patch off, and send it as text/plain or inline the
message body?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
