From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: proper way to merge?
Date: Mon, 2 Mar 2009 17:44:12 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F07452@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F06FDA@EXCHANGE.trad.tradestation.com> <3e8340490903020033l78329c82la186cadaa528bc32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Bryan Donlan" <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 23:46:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeGtf-0008Hz-Cj
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 23:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbZCBWoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 17:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbZCBWoR
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 17:44:17 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:44274 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbZCBWoR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 17:44:17 -0500
X-ASG-Debug-ID: 1236033854-57d3015e0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 4559F1DA90B; Mon,  2 Mar 2009 17:44:14 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id QiD5vFRvvUpENad2; Mon, 02 Mar 2009 17:44:14 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Mar 2009 17:44:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: proper way to merge?
In-Reply-To: <3e8340490903020033l78329c82la186cadaa528bc32@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: proper way to merge?
Thread-Index: AcmbEaOlMBVm3hdZRoSK0mLWQYxTBAAdboNg
X-OriginalArrivalTime: 02 Mar 2009 22:44:13.0491 (UTC) FILETIME=[68EBC830:01C99B88]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236033854
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111971>

===Re:===
So, if I understand correctly, you've manually applied (manually
applying diffs or something?) your changes from the release branch to
the dev branch, and now want to inform git of what happened?

If so, you could commit what you have now, use a graft to change its
parentage, then git-filter-branch to actually update the commit
object. Something like this, I believe:
git commit -m 'Merge .....'
echo '<full 40-character commit ID of the merge> <parent on the dev
branch> <parent on the release branch>' >> .git/info/grafts
git-filter-branch dev~..dev
## You can remove (that line from) .git/info/grafts now

In the future, you may want to perform this sort of incremental merge
by simply git merging intermediate revisions in the release branch.
===end===

That's very interesting.  I did not find 'grafts' in the documentation,
but I looked for it now that I know about it.  So you can add another
parent to the graph just by adding a line to that file.  BTW,
filter-branch isn't available on msysgit.  But leaving it in that grafts
file should be OK -- is that pushed/pulled with everything else?

--John


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
