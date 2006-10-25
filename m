X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] xdiff: Do not consider lines starting by # hunkworthy
Date: Tue, 24 Oct 2006 17:16:28 -0700
Message-ID: <7vmz7lfdwj.fsf@assigned-by-dhcp.cox.net>
References: <20061025000708.2753.74523.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 00:16:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061025000708.2753.74523.stgit@machine.or.cz> (Petr Baudis's
	message of "Wed, 25 Oct 2006 02:07:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30018>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcWRd-0006IR-D4 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 02:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422852AbWJYAQa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 20:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422859AbWJYAQa
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 20:16:30 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:5289 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1422852AbWJYAQ3
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 20:16:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025001629.ZGQK12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Tue, 24
 Oct 2006 20:16:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eQGC1V0021kojtg0000000 Tue, 24 Oct 2006
 20:16:12 -0400
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> This will be probably controversial but in my personal experience, the
> amount of time this is the right thing to do because of #defines is negligible
> compared to amount of time it is wrong, especially because of #ifs and #endifs
> in the middle of functions and also because of comments at the line start when
> it concerns non-C files.
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
>
>  xdiff/xemit.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 714c563..4f20075 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -86,8 +86,7 @@ static void xdl_find_func(xdfile_t *xf, 
>  		if (len > 0 &&
>  		    (isalpha((unsigned char)*rec) || /* identifier? */
>  		     *rec == '_' ||	/* also identifier? */
> -		     *rec == '(' ||	/* lisp defun? */
> -		     *rec == '#')) {	/* #define? */
> +		     *rec == '(')) {	/* #define? */
>  			if (len > sz)
>  				len = sz;
>  			if (len && rec[len - 1] == '\n')

I'd either omit the opening parenthesis or fix the comment ;-).

More seriously, I'd rather just match default GNU diff behaviour
to use isalpha, underscore or '$'.  I do not particularly like
to have '$' but I feel it is the easiest to match a prior art in
cases like this because I do not have to defend my position when
somebody says "Why do you include '#'???  It makes no sense!".
Since I do not care too much about it, being able to just say
"Well we match what GNU diff does by default." is a good thing.



