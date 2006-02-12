From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix object re-hashing
Date: Sun, 12 Feb 2006 10:10:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602121006360.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Feb 12 19:10:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Lfp-0000je-RX
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 19:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWBLSKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 13:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWBLSKK
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 13:10:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751094AbWBLSKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 13:10:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1CIA3DZ015372
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Feb 2006 10:10:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1CIA21j014483;
	Sun, 12 Feb 2006 10:10:03 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16005>



On Sun, 12 Feb 2006, Linus Torvalds wrote:
> 
> I actually didn't see any of this trigger in real life, so maybe my 
> analysis is wrong. Junio? Johannes?

Btw, if it does trigger, the behaviour would be that a subsequent object 
lookup will fail, because the last old slot would be NULL, and a few 
entries following it (likely just a couple - never mind that the event 
triggering in the first place is probably fairly rare) wouldn't have 
gotten re-hashed down.

As a result, we'd allocate a new object, and have _two_ "struct object"s 
that describe the same real object. I don't know what would get upset, but 
git-fsck-index certainly would be (one of them would likely be marked 
unreachable, because lookup wouldn't find it, but you might have other 
issues too).

			Linus
