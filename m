X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-blame: handling of revisions and filenames
Date: Wed, 29 Nov 2006 10:29:07 -0800
Message-ID: <7v8xhuqf7w.fsf@assigned-by-dhcp.cox.net>
References: <20061115215225.GA4595@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 18:29:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061115215225.GA4595@steel.home> (Alex Riesen's message of
	"Wed, 15 Nov 2006 22:52:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32655>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpUBN-0006EH-OR for gcvg-git@gmane.org; Wed, 29 Nov
 2006 19:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967520AbWK2S3L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 13:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967523AbWK2S3L
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 13:29:11 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51159 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S967520AbWK2S3I
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 13:29:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061129182907.ROPF18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Wed, 29
 Nov 2006 13:29:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id siVG1V00c1kojtg0000000; Wed, 29 Nov 2006
 13:29:17 -0500
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

fork0@t-online.de (Alex Riesen) writes:

> And I afraid the patch has a small chance of crashing: I don't check
> if there is enough space in argv (don't actually even know how to),

Actually this is a safe thing to do because we already know (and
removed) the "path" argument from the command line at that
point.  If the original command line did not have "path" we have
already rejected it.  So unk at that point never exceeds argc.

> diff --git a/builtin-blame.c b/builtin-blame.c
> index 066dee7..83c8905 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -1787,6 +1787,7 @@ int cmd_blame(int argc, const char **arg
>         /* Now we got rev and path.  We do not want the path pruning
>          * but we may want "bottom" processing.
>          */
> +       argv[unk++] = "--";
>         argv[unk] = NULL;
>  
>         init_revisions(&revs, NULL);

Thanks.
