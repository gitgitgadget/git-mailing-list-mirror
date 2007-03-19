From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 13:34:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703191323490.6730@woody.linux-foundation.org>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <alpine.LFD.0.83.0703191427140.18328@xanadu.home>
 <Pine.LNX.4.64.0703191145530.6730@woody.linux-foundation.org>
 <200703192102.20258.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Steven Grimm <koreth@midwinter.com>,
	John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:35:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTOZO-0001JP-5j
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 21:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbXCSUfB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 16:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbXCSUfB
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 16:35:01 -0400
Received: from smtp.osdl.org ([65.172.181.24]:54865 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932504AbXCSUe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 16:34:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2JKYScD006857
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 13:34:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2JKYRe9016510;
	Mon, 19 Mar 2007 12:34:27 -0800
In-Reply-To: <200703192102.20258.robin.rosenberg.lists@dewire.com>
X-Spam-Status: No, hits=-0.481 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42670>



On Mon, 19 Mar 2007, Robin Rosenberg wrote:
> 
> How about this simple receipe for defeating rename tracking (real world):
> 
> User needs to modify A. User renames A to OLD_A within his/her IDE. SCM
> records the rename. User now uses SaveAs to restore A, and SCM detects the 
> *NEW* file A.

Well, the thing is, I don't think that's a very strong argument against 
rename tracking.

You can always make trivial examples of when something goes wrong. 
Computers (and SCM's) are stupid, and they simply do what they are told. 
Just about *any* policy can be trivially show to be "totally broken" by 
having a user do something - usually something very simple - that breaks 
it on purpose.

Similarly, I don't think it's hard to show examples of where git's 
"content is king" does something that the user thinks could be done much 
better. And similarly, I don't think that's an argument against the 
content model that git uses.

No, the reason I like the content model is that there is never any hidden 
state that doesn't matter for the user. If you're a physicist, you could 
say that yhere is never any "action at a distance" with git. There are no 
hidden linkages that aren't obvious in the source tree that you commit or 
work on.

In contrast, the very *definition* of "explicit rename tracking" is to 
track those hidden linkages. They aren't visible to the developer, except 
when they clash, and that very invisibility is what makes both mistakes so 
easy (anybody who claims that they never do a rename as a del/add pair is 
simply lying or not doing very interesting development) *and* it is what 
makes handling merges so hard (because when there is a conflict, the 
conflict isn't actually in anything that is *visible*!).

I also pretty much guarantee that the reason git development has been so 
fast, stable and trouble-free comes exactly from the simple conceptual 
mindset and very concrete implementation. There simply are never any 
subtle issues. Content is content is content. It has no "history". Yes, 
git shows history, but it's literally a "series of snapshots", and the 
trees that are checked out are totally history-less. 

In contrast, if you have file rename tracking, then those trees are no 
longer stateless - they have an implied history associated with them, that 
matters. It's largely *invisible*, but that just makes it worse!

			Linus
