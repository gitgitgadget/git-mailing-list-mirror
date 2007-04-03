From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 16:29:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031624090.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031657130.28181@xanadu.home>
 <Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031735470.28181@xanadu.home>
 <Pine.LNX.4.64.0704031511580.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031836350.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:30:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYsSC-0000OL-CM
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 01:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992499AbXDCXaL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 19:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946036AbXDCXaL
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 19:30:11 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48356 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946034AbXDCXaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 19:30:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33NTDPD026888
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 16:29:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33NT9hf006373;
	Tue, 3 Apr 2007 16:29:11 -0700
In-Reply-To: <alpine.LFD.0.98.0704031836350.28181@xanadu.home>
X-Spam-Status: No, hits=-0.453 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43697>



On Tue, 3 Apr 2007, Nicolas Pitre wrote:
> 
> Are hard numbers like 7% overhead (because right now that's all we have) 
> really worth it against bad _perceptions_?

If it actually stays at just 7% even with large repos (and the numbers 
from Chris seem to say that it doesn't get worse - in fact, it may be that 
the lookup gets relatively more efficient for a large repo thanks to the 
log(n) costs), I agree that 7% probably isn't worth worrying about when 
weighed against "guaranteed no SHA1 collision". Especially as long as 
you'd normally only hit it when your real performance issue is going to be 
the network.

So especially if we can make sure that the *local* case is ok, where the 
network isn't going to be the bottleneck, I think we can/should do the 
paranoia.

That's especially true as it is also the local case where the 7% has 
already been shown to be just the best case, with the worst case being 
many hundred percent (and memory use going up from 55M to 280M in one 
example), thanks to us actually *finding* the objects.

			Linus
