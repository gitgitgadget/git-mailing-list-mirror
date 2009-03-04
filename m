From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Wed, 4 Mar 2009 14:34:33 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F07A1C@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F076D2@EXCHANGE.trad.tradestation.com> <alpine.DEB.2.00.0903041151440.8926@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Peter Krefting" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Mar 04 20:37:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lewti-0005CH-Ol
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 20:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347AbZCDTel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 14:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755810AbZCDTek
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 14:34:40 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:46490 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756644AbZCDTej convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 14:34:39 -0500
X-ASG-Debug-ID: 1236195275-418e01ae0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 30DC41EAAAF; Wed,  4 Mar 2009 14:34:36 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id 55KulTQBbc88fjJc; Wed, 04 Mar 2009 14:34:36 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Mar 2009 14:34:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
In-Reply-To: <alpine.DEB.2.00.0903041151440.8926@perkele.intern.softwolves.pp.se>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Thread-Index: Acmct4Rf0Y/p8XYdR1qRvEJov62GEgAJgA3g
X-OriginalArrivalTime: 04 Mar 2009 19:34:35.0698 (UTC) FILETIME=[400DD920:01C99D00]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236195276
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112238>

===Re:===
Yes, but I am unsure whether it [UTF-8] can be set as a thread locale
for the sake 
of file APIs.
===end===

Why wouldn't it?  If the ANSI forms simply allocate buffers and call
WideCharToMultiByte and MultiByteToWideChar, it should work with
anything those functions handles.  My only concern would be with buffer
length when converting to MultiByte, if it assumes a limit based on 2
bytes max per character.  But, it works with GB18030, which can have
4-byte characters.

It's certainly easy enough to try.

===Re:===
Yeah, but unfortunately it [GB18030] is explicitly documented that it is
only 
supported in MultiByteToWideChar, WideCharToMultiByte and some text
painting 
APIs in Windows, i.e the stdio functions and others may break horribly.
===end===

Code that works with the other multi-byte "ANSI" character sets, and GBK
in particular, will handle GB18030 "reasonably well" with no changes.
For example, printf ("xxx%sxxx", name), where each 'x' may actually be
any character, will work without problems -- it won't mis-identify the %
in the middle of a 4-byte character.  But printf ("%5s",name) will count
some of the characters in 'name' as two, and print less than 5 of them;
or worse yet, break a character in half.

I can't think of anything that breaks horribly.  Only situations that
involve counting them will have issues.

As empirical evidence, lots of Windows software works fine in China.
You need full GB18030 support to read a newspaper on the web, because
the 4-byte characters are mostly obscure and regional words, but also
proper nouns including the names of some prominent people (Prime
Minister or something like that; I don't remember exactly).  But mostly
you don't encounter them and chug along with GBK and the occasional '?'
where some character did not work.

--John

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
