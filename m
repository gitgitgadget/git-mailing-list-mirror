From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-checkout changes the index but not the checked out files?
Date: Mon, 23 Apr 2007 07:53:57 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704230747110.9964@woody.linux-foundation.org>
References: <46a038f90704221625k216864cdwb2b35bc035fac7e9@mail.gmail.com> 
 <7virbokmx1.fsf@assigned-by-dhcp.cox.net>  <46a038f90704221717i8e5c1bkff066dcbdb0a0523@mail.gmail.com>
  <7vabx0kk4z.fsf@assigned-by-dhcp.cox.net>
 <46a038f90704221745h1bf2955cyfb40f6e8c08a336d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 16:54:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfzvh-0004MF-KG
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 16:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXDWOyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 10:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbXDWOyK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 10:54:10 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:51676 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751861AbXDWOyJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 10:54:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3NErwUs023382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2007 07:53:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3NErvjL017172;
	Mon, 23 Apr 2007 07:53:57 -0700
In-Reply-To: <46a038f90704221745h1bf2955cyfb40f6e8c08a336d@mail.gmail.com>
X-Spam-Status: No, hits=-3.039 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45328>



On Mon, 23 Apr 2007, Martin Langhoff wrote:
> 
> The _really_ strange bit is that it was attempting to merge 2 heads of
> the same name. It'd probably be something to block...

No, "git-read-tree -m A B" is not a "merge" in the sense you're thinking, 
it's a "fast-forward merge", ie just a "move from A to B"

So read-tree has three "merges": a one-way merge (which just merges with 
the old index _stat_ contents but otherwise just reads in the new tree), a 
two-way merge (a "move from A to B") that checks that all paths that are 
different in the two trees match the index in the old one, and the "real"
merge, aka the three-way thing (and even that is actially "four-way", 
since it also checks the index for matchingness)

So when we move from one head to another, we do that two-way thing. And if 
A and B are the same, doesn't really do anything, but there's also no 
point to try to avoid doing it.

		Linus
