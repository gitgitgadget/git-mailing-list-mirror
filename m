From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 12:59:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703271254190.6730@woody.linux-foundation.org>
References: <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
 <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net>
 <20070326233603.GL22773@admingilde.org> <20070327112549.GA12178@informatik.uni-freiburg.de>
 <20070327115029.GC12178@informatik.uni-freiburg.de> <20070327155306.GQ22773@admingilde.org>
 <20070327172216.GA24200@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0703271124590.6730@woody.linux-foundation.org>
 <20070327194233.GA28229@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0703271250130.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Waitz <tali@admingilde.org>,
	Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 22:00:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWHq8-0001Ua-6j
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 22:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965310AbXC0UAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbXC0UAP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 16:00:15 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40713 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965310AbXC0UAN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 16:00:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2RJxNU2011760
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Mar 2007 12:59:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2RJxMPM026466;
	Tue, 27 Mar 2007 12:59:22 -0700
In-Reply-To: <Pine.LNX.4.64.0703271250130.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.468 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43302>



On Tue, 27 Mar 2007, Linus Torvalds wrote:
> 
> In other words, I don't think that's an argument for or against sharing 
> the object database. You should *always* be able to share the object 
> database by setting GIT_OBJECT_DIR if you want (or by using alternates). 
> But that's independent of whether you are a sub/supermodule..

In fact, I suspect that you might well have a situation where there are 
more objects to be shared "across" superproject boundaries than within 
them.

For example, say that I'm a mirror site, and I mirror two different 
distributions, both of which use superprojects (but *different* 
superprojects!) to track their distro stuff.

Obviously, the top-level setup is likely totally different, and they 
probably differ a bit in which subprojects they have too, but in many 
cases, those two *different* superprojects will have subprojects that 
could often share 99% of all their objects not within the superproject, 
but individually *across* superprojects.

So you would not want to have a object store that is tied to the 
superproject, but you might well want to have each superproject share the 
object store for the subprojects that they have in common. The "kernel" 
subproject in the "ubuntu" superproject might want to share the object 
store for the "linux-2.6" subproject in the Fedora 7 superproject.

(Similarly, there migh be sharing with totally *individual* projects, ie 
you might want to make both just have an alternate that points 
directly to the "official" tree that is in neither of the two 
superprojects and that I maintain separately).

		Linus
