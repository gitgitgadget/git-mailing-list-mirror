From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 16:49:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506301611000.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 22:52:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do61V-0006vJ-RB
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 22:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbVF3U6q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 16:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbVF3U4e
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 16:56:34 -0400
Received: from iabervon.org ([66.92.72.58]:44804 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263150AbVF3UvA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 16:51:00 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Do5yC-0005SO-00; Thu, 30 Jun 2005 16:49:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jun 2005, Linus Torvalds wrote:

> On Thu, 30 Jun 2005, Daniel Barkalow wrote:
> > 
> > The right solution probably involves getting each pack file you push to
> > the mirrors as well as to the master. They'll probably update no less
> > frequently than you push, and they should go through a series of states
> > which matches the master, so it's not necessary to have anything smart on
> > master sending them, and they only have to unpack the files they get (and
> > update the refs afterward).
> 
> Hmm, yes. That would work, together with just fetching the heads.
> 
> It won't _really_ solve the problem, since the pushed pack objects will
> grow at a proportional rate to the current objects - it's just a constant
> factor (admittedly a potentially fairly _big_ constant factor)  
> improvement both in size and in number of files.
>
> So the mirroring ends up getting slowly slower and slower as the number of 
> pack files go up. In contrast, a git-aware thing can be basically 
> constant-time, and mirroring expense ends up being relative to the size of 
> the change rather than the size of the repository.
> 
> But mirroring just pack-files might solve the problem for the forseeable 
> future, so..

Whenever it gets slow, you could replace all the old packs with a single
new pack containing all the old objects; and master could repack whenever
it has a lot of pack files. That's pretty close to O(n) in change size.

Alternatively, having a reverse-ordered list of pack files would mean that
mirrors could just go through that list until they found one they already
had, and stop there, which would really be O(n).

	-Daniel
*This .sig left intentionally blank*
