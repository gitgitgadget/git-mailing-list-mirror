From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Distribution of longest common hash prefixes
Date: Tue, 3 Apr 2007 12:27:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031219430.6730@woody.linux-foundation.org>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
 <Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
 <86bqi6kae7.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
 <86y7laitlz.fsf@blue.stonehenge.com> <86r6r2isva.fsf@blue.stonehenge.com>
 <m3r6r1jsmq.fsf@lugabout.jhcloos.org> <867istcrhr.fsf@blue.stonehenge.com>
 <20070403172123.GD27706@spearce.org> <Pine.LNX.4.64.0704031046150.6730@woody.linux-foundation.org>
 <7vhcrxz5a8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	Peter Eriksen <s022018@student.dtu.dk>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 21:27:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYofR-0000Qm-MT
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 21:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966108AbXDCT13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 15:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966114AbXDCT13
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 15:27:29 -0400
Received: from smtp.osdl.org ([65.172.181.24]:38303 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966108AbXDCT12 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 15:27:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33JR9PD020098
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 12:27:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33JR2kw001044;
	Tue, 3 Apr 2007 12:27:04 -0700
In-Reply-To: <7vhcrxz5a8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43641>



On Tue, 3 Apr 2007, Junio C Hamano wrote:
> 
> Are you hinting to update sha1_name.c::get_sha1() so that we do
> not accept abbreviated non-commit object names?

No, but it might be nice if we had some fairly graceful way of handling 
abbreviated SHA1's that ended up being ambiguous (maybe they weren't 
ambiguous in the original context, but became ambiguous later).

Some way of just listing the alternatives, and sorting - and showing - by 
type (so that if you know it's supposed to be a commit, you can trivially 
pick it out from other objects that happen to collide in the first <n> 
digits).

Right now we can do it with

	git-rev-list --objects --all | grep '^<abbrev-sha1>'

but that's actually not even correct (maybe the reason sha1_name decided 
it was ambiguous was due to an _unreachable_ SHA1?), and it's also very 
inefficient.

We could have some helper that just looked things up (it's easy enough to 
look up all potential SHA1 matches both in the filesystem and in a 
pack-file - no need for any rev-list thing that lists all objects).

Is this a pressing concern? Absolutely not. I don't think we've ever had 
any real problems with this, and you *can* do it by hand with a bit of 
inefficient scripting right now..

			Linus
