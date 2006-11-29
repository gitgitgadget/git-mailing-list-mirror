X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Tue, 28 Nov 2006 16:57:00 -0800
Message-ID: <7v1wnnysrn.fsf@assigned-by-dhcp.cox.net>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611261652520.30076@woody.osdl.org>
	<Pine.LNX.4.63.0611280040480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v7ixge8j2.fsf@assigned-by-dhcp.cox.net>
	<20061128131139.GA10874@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 00:57:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061128131139.GA10874@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 28 Nov 2006 08:11:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32605>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpDl5-0001Ww-Kr for gcvg-git@gmane.org; Wed, 29 Nov
 2006 01:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758261AbWK2A5E (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 19:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758285AbWK2A5D
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 19:57:03 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:16586 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1758261AbWK2A5B
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 19:57:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061129005701.IYUP18207.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Tue, 28
 Nov 2006 19:57:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id sQwU1V00F1kojtg0000000; Tue, 28 Nov 2006
 19:56:29 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Just for fun, I took a look at what we might see by ordering commits by
> their "amount of blamedness". That is, the count of lines introduced by
> a commit which were not later superseded. The script I used is below:
>
> #!/bin/sh
>
> start=$1; shift
> end=$1; shift
>
> start_sha1=`git-rev-parse $start^{}`
> git-rev-list --parents $start..$end >revs
> echo $start_sha1 >>revs
> for i in `git-diff --raw -r $start $end | cut -f2`; do
>   echo blaming $i... >&2
>   git-blame -l -S revs $i | cut -d' ' -f1
> done |
>   grep -v $start_sha1 |
>   sort | uniq -c | sort -rn |
>   while read count hash; do
>     echo "$count `git-rev-list --max-count=1 --pretty=oneline $hash`"
>   done
>
> The top 15 for v1.4.3 to v1.4.4 are:
>
> 1604 6973dcaee76ef7b7bfcabd2f26e76205aae07858 Libify diff-files.

Something is SERIOUSLY wrong.

That commit is not even between v1.4.3 and v1.4.4.



