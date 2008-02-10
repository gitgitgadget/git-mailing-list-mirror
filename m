From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sun, 10 Feb 2008 12:50:17 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802101241590.2896@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org> <alpine.LSU.1.00.0802100110450.11591@racer.site> <alpine.LFD.1.00.0802092016540.2732@xanadu.home> <alpine.LSU.1.00.0802100130090.11591@racer.site>
 <m3myq8fwdx.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:51:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJ9O-0007Su-9e
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbYBJUvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 15:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbYBJUvL
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:51:11 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57248 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753011AbYBJUvK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 15:51:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1AKoIIO009858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Feb 2008 12:50:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1AKoIMp013676;
	Sun, 10 Feb 2008 12:50:18 -0800
In-Reply-To: <m3myq8fwdx.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.726 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73413>



On Sun, 10 Feb 2008, Jakub Narebski wrote:
> 
> P.S. Would having generation + roots be enough?

I'm wavering here. Maybe just "generation" works (the longest path from 
any root), because what we are looking for is essentially "guarantee that 
this commit cannot possibly be reached from that other commit", and I 
guess a simple generation count actually does work for that (if the 
generation of "x" is smaller than the generation of "y", we definitely 
cannot reach y from x).

At the same time, I'm still not really convinced we need to add the 
redundant info. I do think I *should* have designed it that way to start 
with (and I thought so two years ago - blaah), so the strongest reason for 
"we should add generation numbers" at least for me is that I actually 
think it's a GoodThing(tm) to have.

But adding it is a pretty invasive thing, and would force people to 
upgrade (it really isn't backwards compatible - old versions of git would 
immediately refuse to touch archives with even just a single top commit 
that has a generation number in it, unless we'd hide it at the end of the 
buffer and just uglify things in general).

So even if it does work, the advantage isn't big enough for me to think 
it's really worth it. I'd *really* prefer to not have a flag day here, and 
the fact is, it's redundant information _and_ it fundamentally doesn't 
work with grafting anyway, so even if we were able to start from scratch, 
we'd then have to seriously consider dropping grafts.

So let's work at not needing it, rather than argue whether we could use it 
or not ;)

		Linus
