X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Build in shortlog
Date: Sat, 11 Nov 2006 13:36:05 -0800
Message-ID: <7virhlis3e.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0610221322370.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 11 Nov 2006 21:36:34 +0000 (UTC)
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0610221322370.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 22 Oct 2006 13:23:31 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31241>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj0WX-0001Yy-VG for gcvg-git@gmane.org; Sat, 11 Nov
 2006 22:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947310AbWKKVgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 16:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947309AbWKKVgI
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 16:36:08 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47847 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1754877AbWKKVgG
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 16:36:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061111213606.MTJZ27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sat, 11
 Nov 2006 16:36:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id lZcB1V00M1kojtg0000000; Sat, 11 Nov 2006
 16:36:12 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/path-list.c b/path-list.c
> index 0c332dc..f8800f8 100644
> --- a/path-list.c
> +++ b/path-list.c
> @@ -57,7 +57,7 @@ struct path_list_item *path_list_insert(
>  	int index = add_entry(list, path);
>  
>  	if (index < 0)
> -		index = 1 - index;
> +		index = -1 - index;
>  
>  	return list->items + index;
>  }

This part looks like a genuine bugfix and unrelated to
shortlog.

Many callers of path_list_insert() seem to ignore its return
value, but merge_recursive.c seems to use it in three places, to
find an entry to hang cached rename information to in
insert_stage_data().

I haven't come up with an example to demonstrate the breakage of
not having this fix in the existing git-merge-recursive, but I
think this needs to be applied to even 'maint'.


