From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Distribution of longest common hash prefixes
Date: Tue, 3 Apr 2007 16:22:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031613210.6730@woody.linux-foundation.org>
References: <86y7laitlz.fsf@blue.stonehenge.com> <86r6r2isva.fsf@blue.stonehenge.com>
 <m3r6r1jsmq.fsf@lugabout.jhcloos.org> <867istcrhr.fsf@blue.stonehenge.com>
 <20070403172123.GD27706@spearce.org> <Pine.LNX.4.64.0704031046150.6730@woody.linux-foundation.org>
 <7vhcrxz5a8.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704031529300.28181@xanadu.home>
 <7vhcrxw6h5.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704031635100.28181@xanadu.home>
 <20070403230846.GB8479@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	Peter Eriksen <s022018@student.dtu.dk>
To: Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:23:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYsLU-0004Vn-JB
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 01:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbXDCXXU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 19:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945915AbXDCXXU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 19:23:20 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48063 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbXDCXXT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 19:23:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33NMkPD026697
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 16:22:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33NMf3j006232;
	Tue, 3 Apr 2007 16:22:42 -0700
In-Reply-To: <20070403230846.GB8479@dspnet.fr.eu.org>
X-Spam-Status: No, hits=-0.453 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43695>



On Wed, 4 Apr 2007, Olivier Galibert wrote:
> 
> Isn't the number of objects an order of magnitude bigger than the
> number of commits?  Well, I guess that depends on your workflow...

Judging by the kernel tree, it's not an order of magnitude, although it's 
fairly close:

	[torvalds@woody linux]$ git rev-list --all | wc -l
	51156

	[torvalds@woody linux]$ git rev-list --all --objects | wc -l
	444265

So you have about 50k commit objects, and about 390k "other" objects. 
About 7.7 "other" objects per commit. Not quite an order-of-magnitude, but 
close.

Part of the reason for this is that the kernel people tend to encourage 
lots of smaller commits over single large commits, so we have lots of 
commits.

To counter-act that somewhat, the kernel tree is also pretty deep, so a 
lot of the "other" objects are actually the tree objects that create the 
directory structure - it's quite normal to have a single file (blob) 
change, and then three new trees that lead up to that file, and the one 
commit that explains it.

Other projects - like git itself - have relatively fewer tree objects, 
which is probably why the ratio for git itself is just 3.04 "other" 
objects for each commit (ie on average, commits probably touch two blobs 
and the top-level tree - about 10 commits, and 30k non-commit objects).

So repo layout matters. Iirc, last I did the statistics, the git 
repository had more blobs than trees, while the kernel repo had more trees 
than blobs. And the commits-to-other-objects is obviously fairly different 
as a result (I think both git and the kernel have the "many small changes" 
approach, so they're similar in that respect).

Other repositories probably have more "big changes". Especially if you 
create the repo initially by importing just big releases over time, you'll 
have relatively few commits, and lots of blob/tree changes. 

			Linus
