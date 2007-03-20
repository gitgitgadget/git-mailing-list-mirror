From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Mon, 19 Mar 2007 21:11:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703192052380.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
 <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
 <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703200400230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070320032947.GA29145@spearce.org> <20070320034020.GB29145@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 05:11:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTVhN-0002gx-En
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 05:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbXCTELq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 00:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933973AbXCTELq
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 00:11:46 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44789 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933247AbXCTELq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 00:11:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2K4BBcD021581
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 21:11:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2K4B9Av025274;
	Mon, 19 Mar 2007 20:11:10 -0800
In-Reply-To: <20070320034020.GB29145@spearce.org>
X-Spam-Status: No, hits=-0.977 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42700>



On Mon, 19 Mar 2007, Shawn O. Pearce wrote:
>
> DrNick suggested on #git to try flipping the isspace test around.
> This is a smaller change and generated the same ~3.60 seconds run
> as Dscho's patch.  I like DrNick's version better.  ;-)

For me, the result seems to be in the noise.

It may be due to running on Core 2. It's not very sensitive to 
micro-optimizations like this. It definitely makes sense to test the 
*stable* test first, since that will help branch prediction (the 
"isspace()" test is *not* very predictable), so I don't disagree with the 
patch, but I suspect it depends a lot on the microarchitecture just how 
much it matters.

Do you perhaps have a P4? It has a very bad branch mispredict penalty, so 
putting the predictable branch first could explain the big difference you 
see..

Dscho's bigger patch probably helps more on an in-order architecture, and 
should be equally good on a P4 (or Opteron). On Core 2, neither of the 
patches seem to make a huge difference.

			Linus
