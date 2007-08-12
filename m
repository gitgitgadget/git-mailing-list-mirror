From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 13:21:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708121315310.30176@woody.linux-foundation.org>
References: <85ir7kq42k.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org>
 <854pj4o8k5.fsf@lola.goethe.zz> <20070812195126.GA17914@informatik.uni-freiburg.de>
 <85k5s0msei.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Uwe Kleine-K?nig <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 22:22:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJwn-00009h-IN
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 22:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbXHLUV6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 16:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753379AbXHLUV6
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 16:21:58 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35289 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753276AbXHLUV5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 16:21:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CKLiBj008125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Aug 2007 13:21:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CKLcMh020184;
	Sun, 12 Aug 2007 13:21:38 -0700
In-Reply-To: <85k5s0msei.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.74 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55720>



On Sun, 12 Aug 2007, David Kastrup wrote:
> >
> > rev-list doesn't try to draw a line from each commit to its parents.
> 
> Well, that's what --topo-order is somewhat about, but it might
> actually not do much together with --all.

No, --topo-order works with --all too. In fact, to some degree, it's 
*especially* useful with --all, since having multiple tips makes the whole 
topological sort all the more interesting, and also usually makes the end 
result more interesting (ie it's often much more interestign to visualize 
two or more branches together, just to see the *relationships* between the 
branches, and see what is shared.

And yes, it keeps track of every single commit, and computes the 
relationships between them. So it does indeed "draw the line", except it 
can do so in a rather dense and optimized set of data structures.

(That's one reason I love coding in C: it may be more effort, but you can 
tune your data structures in ways you seldom can in higher-level 
languages, and git-rev-list and the object representation is some of the 
most tuned code in git).

> 20 bytes of payload for a commit number.  Make a usable hashing data
> structure for it, adds perhaps another 20 bytes.  Links to all parents
> are 4 bytes each.  All in all, we won't need more than 64 bytes per
> commit.

Yeah, that's the rough ballpark (except for 64-bit architectures, the 
links are all 8 bytes, but we're pretty careful). See "object.h" for most 
of the details.

			Linus
