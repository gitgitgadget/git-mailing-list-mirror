From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: About git and the use of SHA-1
Date: Mon, 28 Apr 2008 18:15:16 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804281732370.19665@iabervon.org>
References: <200804281829.11866.henrikau@orakel.ntnu.no> <alpine.LNX.1.00.0804281515480.19665@iabervon.org> <200804282329.21336.henrikau@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Henrik Austad <henrikau@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Tue Apr 29 00:16:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqbdo-0000ob-0Z
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 00:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965906AbYD1WPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 18:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965902AbYD1WPU
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 18:15:20 -0400
Received: from iabervon.org ([66.92.72.58]:46474 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965898AbYD1WPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 18:15:18 -0400
Received: (qmail 17758 invoked by uid 1000); 28 Apr 2008 22:15:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Apr 2008 22:15:16 -0000
In-Reply-To: <200804282329.21336.henrikau@orakel.ntnu.no>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80630>

On Mon, 28 Apr 2008, Henrik Austad wrote:

> On Monday 28 April 2008 21:34:50 Daniel Barkalow wrote:
> > On Mon, 28 Apr 2008, Henrik Austad wrote:
> > > Hi list!
> > >
> > > As far as I have gathered, the SHA-1-sum is used as a identifier for
> > > commits, and that is the primary reason for using sha1.  However, several
> > > places (including the google tech-talk featuring Linus himself) states
> > > that the id's are cryptographically secure.
> > >
> > > As discussed in [1], SHA-1 is not as secure as it once was (and this was
> > > in 2005), and I'm wondering - are there any plans for migrating to
> > > another hash-algorithm? I.e. SHA-2, whirlpool..
> >
> > No. The cryptographic security we care about is that it's impractical to
> > come up with another set of content that hashes to the same value as a
> > given set of content. The known attacks on SHA-1 (and more broken earlier
> > hashes in the same general class) only allow the attacker to produce two
> > files that will collide. Now, it's true that this would allow somebody to
> > produce a commit where some people see the "good" blob and some people see
> > the "evil" blob, but (a) the "good" blob contains some large chunk of
> > random data, which is a major red flag by itself, and (b) all of these
> > people have to be taking data from the attacker.
> 
> yes, I can see that point, but I was thinking more along the line of:
> 
> 1) clone repo
> 2) add malicious code
> 3) add a huge block of comment, ifdef-block etc somewhere obscure in the code 
> and keep adding random data untill hash matches a well-known release.
> 4) publish repo, or even worse, change central repo

All known methods for step 3, even on hashes considered long broken, will 
take until the heat death of the universe. The latest I can find is that, 
if you use MD4 (which is weak enough that you can find collisions as 
quickly as you can do two hashes), there's a 1 in a quadrillion chance 
that your message is weak and somebody could find a replacement with the 
same hash using known techniques. (With a plausible amount of work, an 
attacker could take a file and modify it only slightly, and find a 
replacement for that, but this again requires the attacker to have some 
non-trivial input to what gets put in the official tree, which leaves 
the attacker as the responsible party for that object).

SHA-1 is enough stronger that the latest attacks are still unable to do 
with the current available computing power in years what can be done to 
MD4 in milliseconds. So it's highly unlikely that somebody will break 
SHA-1 more thoroughly than MD4 is broken any time soon.

> > If somebody gives you some source, and it's got some large random chunk in
> > it, and the behavior of the object depends on the content of this chunk,
> > and it's unspecified where this chunk comes from, you should be aware
> > that they might be able to swap this chunk for a different chunk. But such
> > a file is pretty blatantly malicious anyway.
> 
> True, but this actually means you have to verify *everything*, even though the 
> hash checks out.

If you don't verify *everything* when the hash checks out, the attacker 
will just send you a properly-constructed commit with a back door in the 
code. While you're looking for directly-inserted security holes in the 
code, you can probably notice if there's some big hunk of line noise in a 
comment that might make the file vulnerable to replacement.

	-Daniel
*This .sig left intentionally blank*
