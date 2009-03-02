From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: proper way to merge?
Date: Mon, 2 Mar 2009 18:08:54 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F07466@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 00:11:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeHHK-0000gH-CL
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 00:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbZCBXJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 18:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbZCBXJA
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 18:09:00 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:46462 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbZCBXI7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 18:08:59 -0500
X-ASG-Debug-ID: 1236035336-2a2603710000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id 732A91DA9D2
	for <git@vger.kernel.org>; Mon,  2 Mar 2009 18:08:56 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id 2HQ4eqlynFfcEATD for <git@vger.kernel.org>; Mon, 02 Mar 2009 18:08:56 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Mar 2009 18:08:55 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: proper way to merge?
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: proper way to merge?
Thread-Index: Acmbi9vO05CDnCMbQo+ZgFzMcW99Pg==
X-OriginalArrivalTime: 02 Mar 2009 23:08:55.0724 (UTC) FILETIME=[DC6696C0:01C99B8B]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236035336
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111975>

Thanks for the input, JohnFlux and Bryan.

Here's what I found worked.

First of all, the overall concept that changes to the repository are
never destructive (as long as you remember where you were) is
liberating.  It's beyond the confidence of an "undo" feature.  Really,
nothing I do can change any of the existing objects and their
interrelationship.  Using the reflog and lightweight tags, and the
feature that gitk still knows the nodes even after the labels move,
makes it easy to experiment on.

Basically, I cherry-picked the commits from "rel" to "dev" and fixed
them as I went.  Leaving it at that, I'd forever see duplicate commits
with the same comments but different actual commits, so things like "git
log here..there" will recognize the equality.

So, to make it look like I actually used the merge command, I did this:

1) I reset back to the original dev before my patching.  The default
reset, mixed, left the working tree unchanged and didn't do anything to
the index either.

2) git merge rel -s ours
That created a new node with the topology I wanted, but didn't actually
do anything.

3) add all the changed files, and "amend" the commit.


I suppose --no-commit would do the same thing as amending, but this way
I saw (in getk) that it really did what I wanted, instead of trusting
the multiple parentage to just be waiting somehow.

If keeping things in the working directory to carry between the steps
gives you the willies, remember that you can always reset --hard back to
where you were before doing (1).  Either because you tagged it just in
case, can find it using HEAD@{something}, or still see it on the screen
in gitk.

But, another approach would be to do the (fake) merge first, and then
keep amending it with the individual changes you pick from the other
branch.  I don't like that because the tree will show something that's
not true, until you are all done.  I want everything to be correct and
not lying if I get interrupted and leave it that way for a while.

Comments welcome.  I'm trying to get my act together before I start
evangelizing to the rest of the team.

--John
(excuse the footer; it's not my choice)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
