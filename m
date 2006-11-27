X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Idea for rebase strategy
Date: Mon, 27 Nov 2006 01:26:35 -0800
Message-ID: <7vfyc5i6k4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0611270108160.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyc5l24t.fsf@assigned-by-dhcp.cox.net>
	<456AA9B2.8050409@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 09:26:58 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456AA9B2.8050409@shadowen.org> (Andy Whitcroft's message of
	"Mon, 27 Nov 2006 09:02:42 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32406>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gocl7-0008CP-Cj for gcvg-git@gmane.org; Mon, 27 Nov
 2006 10:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757549AbWK0J0h (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 04:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757545AbWK0J0g
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 04:26:36 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:60288 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1757549AbWK0J0g
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 04:26:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127092635.IACH296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Mon, 27
 Nov 2006 04:26:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rlSj1V00u1kojtg0000000; Mon, 27 Nov 2006
 04:26:44 -0500
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> writes:

>> 
>>        A---B---C---D---E topic
>>       /       /
>>   ---X---o---Y---Z master
>>                   \
>>                    A'--B'--C'--D' topic'
>
> Interestingly this trivial situation seems to works pretty much as is.
> A "git rebase --onto master X topic" (at least in my trivial test case)
> replayed A and B, squashed C as a noop, and copied D and E.  I did not
> need any information from the reflog.  Of course the reflog is a good
> way to find X as its first transaction but I did not need it to drive
> replay.

That is only because the pictures are showing the degenerated
case for simplicity, and the defect that the current rebase does
not even look at any merges is hidden by the fact that the merge
in the example C becomes no-op in the rebased history.  C could
be somewhere not between X and Z, in which case replaying the
merge becomes necessary.  Also when following from E to traverse
down the history of topic, at point C, you need to tell which of
B or Y are on the topic, and that's where you would rely on
ref-log.


