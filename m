From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 3 Jun 2008 12:54:31 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806031244290.3473@woody.linux-foundation.org>
References: <200806030314.03252.jnareb@gmail.com> <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org> <200806030932.03051.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 21:56:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3cbk-0005iR-OR
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 21:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbYFCTyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 15:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbYFCTyg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 15:54:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51568 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754396AbYFCTye (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 15:54:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m53JsWO6007908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jun 2008 12:54:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m53JsVjR016806;
	Tue, 3 Jun 2008 12:54:31 -0700
In-Reply-To: <200806030932.03051.jnareb@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.386 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83695>



On Tue, 3 Jun 2008, Jakub Narebski wrote:
> On Tue, 3 June 2008, Linus Torvalds wrote:
> > 
> > Once you have 0, 1 or 2 parents, the logical progression is "many". 
> 
> Well, it of course depends on design.  For example Mercurial (from what
> I have read in the documentation) has fixed width (two element) parents
> array in revflog structure.

Sure. And git very much on purpose made all basic data structures be text. 

I'm a UNIX weenie, not some VMS hack. Fixed-sized records are evil.

[ Yes, I made the hashes fixed-size binary blobs in the tree object. In 
  retrospect, that was probably a mistake. Not a huge one, but it's one of 
  the few things in the basic data structure that I'm sorry for. It 
  seemed to make sense at the time. ]

I do like how you can have arbitrary parenthood (well, arbitrary on a 
data structure level - we do restrict it in practice). Maybe it's not a 
hugely important thing, but it does allow more than just plain merges.

IOW, I could well imagine having an extra parent pointer that is not a 
"data merge" pointer, but a "concept merge" - you could have branches that 
have commits that point back to not the data in the tree, but to 
particular commits in another branch.

One of the things I could imagine using git for is to have "annotation 
branches" for things like code review etc. They'd be a real branch in 
their own right and with their own history, but at the same time they 
could well want to point back to the "code branch" that they annotate by 
considering that another parent in a "non-data merge" (and yes, you'd 
obviously have to use a special merge strategy for things like that, but 
you'd likely integrate it in some "annotation tool chain" rather than 
anything else).

			Linus
