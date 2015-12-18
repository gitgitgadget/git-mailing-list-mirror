From: Mike Hommey <mh@glandium.org>
Subject: Re: RefTree: Alternate ref backend
Date: Fri, 18 Dec 2015 10:36:03 +0900
Message-ID: <20151218013603.GA13717@glandium.org>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
 <20151217221045.GA8150@sigill.intra.peff.net>
 <CAJo=hJsSgU6yOFZMac85jkOtw9TXWXh0Ext4-Gb1TsSXqROn4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 18 03:19:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9ke8-0001tm-Sp
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 03:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966097AbbLRCTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 21:19:49 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:59136 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965253AbbLRCTs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 21:19:48 -0500
X-Greylist: delayed 2599 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Dec 2015 21:19:43 EST
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <glandium@glandium.org>)
	id 1a9jxj-0003cB-Lj; Fri, 18 Dec 2015 10:36:03 +0900
Content-Disposition: inline
In-Reply-To: <CAJo=hJsSgU6yOFZMac85jkOtw9TXWXh0Ext4-Gb1TsSXqROn4g@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282692>

On Thu, Dec 17, 2015 at 02:28:01PM -0800, Shawn Pearce wrote:
> On Thu, Dec 17, 2015 at 2:10 PM, Jeff King <peff@peff.net> wrote:
> > On Thu, Dec 17, 2015 at 01:02:50PM -0800, Shawn Pearce wrote:
> >
> >> I started playing around with the idea of storing references directly
> >> in Git. Exploiting the GITLINK tree entry, we can associate a name to
> >> any SHA-1.
> >
> > Gitlink entries don't imply reachability, though. I guess that doesn't
> > matter if your ref backend says "no, really, these are the ref tips, and
> > they are reachable".
> 
> Exactly. This works with existing JGit because it swaps out the ref
> backend. When GC tries to enumerate the roots (current refs), it gets
> these through the ref backend by scanning the tree recursively. The
> packer itself doesn't care where those roots came from.
> 
> Same would be true for any other pluggable ref backend in git-core. GC
> has to ask the ref backend, and then trust its reply. How/where that
> ref backend tracks that is an implementation detail.
> 
> >  But you could not push the whole thing up to
> > another server and expect it to hold the whole graph.
> 
> Correct, pushing this to another repository doesn't transmit the
> graph. If the other repository also used this for its refs backend,
> its now corrupt and confused out of its mind. Just like copying the
> packed-refs file with scp. Don't do that. :)
> 
> > Which is not strictly necessary, but to me seems like the real advantage
> > of using git objects versus some other system.
> 
> One advantage is you can edit HEAD symref remotely. Commit a different
> symlink value and push. :)
> 
> I want to say more, but I'm going to hold back right now. There's more
> going on in my head than just this.
> 
> > Of course, the lack of reachability has advantages, too. You can
> > drop commits pointed to by old reflogs without rewriting the ref
> > history.
> 
> Yes.

Related thread: "Allowing weak references to blobs and strong references
to commits" http://marc.info/?l=git&m=142779648816577&w=2

Mike
