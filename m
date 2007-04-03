From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 16:12:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031553080.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org> 
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com> 
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> 
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home>  <7vzm5pur7g.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.64.0704031357470.6730@woody.linux-foundation.org>
 <db69205d0704031549g7273da53g817f885705735db2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Chris Lee <clee@kde.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:13:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYsC4-0007Cl-3Q
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 01:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946023AbXDCXNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 19:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946026AbXDCXNg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 19:13:36 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47750 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946023AbXDCXNf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 19:13:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33NCXPD026421
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 16:12:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33NCWWA006053;
	Tue, 3 Apr 2007 16:12:33 -0700
In-Reply-To: <db69205d0704031549g7273da53g817f885705735db2@mail.gmail.com>
X-Spam-Status: No, hits=-0.453 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43694>



On Tue, 3 Apr 2007, Chris Lee wrote:
>
> git-index-pack --paranoid --stdin --fix-thin paranoid.pack < 
> 5.28s user 0.24s system 98% cpu 5.592 total
> 
> git-index-pack --stdin --fix-thin trusting.pack < 
> 5.07s user 0.12s system 99% cpu 5.202 total

Ok, that's not a big enough of a difference to care.

> So, in my case, at least... not really much of a difference, which is
> puzzling.

It's entirely possible that the object lookup is good enough to not be a 
problem even for huge packs, and it really only gets to be a problem when 
you actually unpack all the objects.

In that case, the only real case to worry about is indeed the "alternates" 
case (or if people actually use a shared git object directory, but I don't 
think anybody really does - alternates just work well enough, and shared 
object directories are painful enough that I doubt anybody *really* uses 
it).

> I also mailed out the DVD with the repo on it to hpa today, so
> hopefully by tomorrow he'll get it. (He's not even two cities over,
> and I suspect I could have just driven it to his place, but that might
> have been a little awkward since I've never met him.)

Heh. Ok, good. I'll torrent it or something when it's up.

> Anyway, so, hopefully once he gets it he can put it up somewhere that
> you guys can grab it. For reference, the KDE repo is pretty big, but a
> "real" conversion of the repo would be bigger; the one that I've been
> playing with only has the KDE svn trunk, and only the first 409k
> revisions - there are, as of right now, over 650k revisions in KDE's
> svn repo. So, realistically speaking, a fully-converted KDE git repo
> would probably take up at least 6GB, packed, if not more. Subproject
> support would probably be *really* helpful to mitigate that.

Sure. I think subproject support is likely the big "missing feature" of 
git right now. The rest is "details", even if they can be big and involved 
details.

But even at only 409k revisions, it's still going to be an order of 
magnitude bigger than what the kernel is, exactly *because* it's such a 
disaster from a maintenance setup standpoint, and it's going to be a 
useful real-world test-case. So whether that is a "good" git archive or 
not, it's going to be useful.

Long ago we used to be able to look at the historic Linux archive as an 
example of a "big" archive, but it's not actually all that much bigger 
than the normal Linux archive any more, and we've pretty much fixed the 
problems we used to have.

[ The historical pack-file is actually smaller, but that's because it was 
  done with a much deeper delta-chain to make it small: the historical 
  archive still has more objects in it than the current active git kernel 
  tree - but it's only in the 20% range, not "20 *times* bigger" ]

The Eclipse tree was useful (and I think we already improved performance 
for you thanks to working with it - I don't know how much faster the 
delta-base cache made things for you, but I'd assume it was at *least* by 
the factor-of-2.5 that we saw on Eclipse), but the KDE is bigger *and* 
deeper (the eclipse tree is 1.7GB, and 136k revisions in the main branch, 
so the KDE tree is more than twice the revisions).

		Linus
