X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Thu, 07 Dec 2006 23:36:52 -0800
Message-ID: <7vhcw6n8iz.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	<7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
	<20061207221503.GA4990@steel.home>
	<7vr6vbqqzh.fsf@assigned-by-dhcp.cox.net>
	<20061208052705.GA4318@steel.home>
	<7vzm9ynahc.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0612072327x77477584jb9131b26b0854f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 07:37:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <81b0412b0612072327x77477584jb9131b26b0854f2@mail.gmail.com>
	(Alex Riesen's message of "Fri, 8 Dec 2006 08:27:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33668>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsaI3-0008KA-Cf for gcvg-git@gmane.org; Fri, 08 Dec
 2006 08:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425081AbWLHHgy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 02:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425085AbWLHHgy
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 02:36:54 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:36089 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1425081AbWLHHgx (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 02:36:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208073653.ITEO15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Fri, 8
 Dec 2006 02:36:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id w7d31V00M1kojtg0000000; Fri, 08 Dec 2006
 02:37:04 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

"Alex Riesen" <raa.lkml@gmail.com> writes:

>> The current code for "diff-index --cached" reads the whole tree
>> into the index as stage #1 entries (diff-lib.c::run_diff_index),
>> and then compares stage #0 (from the original index contents)
>> and stage #1 (the tree parameter from the command line).  Even
>> if you stop at the first mismatch, you would already have paid
>> the overhead to open and read all tree objects before even
>> starting the comparison.
>
> But I don't have to pay for the overhead of comparing all
> entries, if I can stop at first mismatch and exit with non-0.

Bench it if you doubt me.

I'd bet that the time spent in comparison between stages inside
index (and remember, you are not generating textual diff, only
comparing the SHA-1) is dwarfed by the overhead of populating
the stage #1 of the index with what is read from all the tree
objects.

