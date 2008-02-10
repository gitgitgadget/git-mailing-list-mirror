From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] repack vs re-clone
Date: Sun, 10 Feb 2008 15:50:46 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802101452550.2732@xanadu.home>
References: <e5bfff550802100025k616ccff5ib2917d283eeb0ff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gi mailing list <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:51:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJ90-0007JV-4d
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbYBJUus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 15:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbYBJUus
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:50:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46631 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbYBJUur (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:50:47 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW100CTTJ8MHDC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Feb 2008 15:50:46 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <e5bfff550802100025k616ccff5ib2917d283eeb0ff0@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73412>

On Sun, 10 Feb 2008, Marco Costalba wrote:

> Sometime I found myself re-cloning entirely a repository, as example
> the Linux tree, instead of repackaging my local copy.
> 
> The reason is that the published Linux repository is super compressed
> and to reach the same level of compression on my local copy I would
> need to give my laptop a long night running.

No.  I really doubt the public Linux repository is compressed with 
anything but the default repack settings.

And on my average PC by today's standards (P4 @ 3GHz with 1GB memory), 
repacking the Linux repo takes less than 6.5 minutes, and peak RSS is 
around 450MB.

> So it happens to be just faster to re-clone the whole thing by upstream.

Only if you're lucky to have a fast connection to the net with a high 
transfer quota.

> Also repackaging a big repo in the optimal way is not so trivial, you
> need to understand quite advanced stuff like window depth and so on
> and probably the pack parameters used upstream are easily better then
> what you could 'guess' trying yourself. Or simply you don't have
> enough RAM as would be needed.

If such is your case, why would you fully repack your repo in the first 
place?  Simply running 'git gc' should be quite good enough for people 
uninterested in the "advanced" stuff.  The repack that 'git gc' uses 
will happily reuse existing packed data from upstream.



> On the other end it would be interesting to know, before to start the
> new clone, what is the real advantage of this, i.e. what is the
> repository size upstream.

You can already query the remote repository directory listing and figure 
it out.  For example:

lftp -c 'open http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack && ls'

And you'll note that even upstream isn't always fully packed in advance.

> So I would like to ask if anyone would consider useful:
> 
> - A command like 'git info' or something like that that prints size of
> local and upstream repository (among possibly other things)
> 
> - An option like 'git repack --clone' to instruct git to download and
> use current upstream packs instead of trying to recreate new ones.

I think that would be a very bad idea.  Not only this is rather 
unnecessary (either you can aford to repack locally, or you live with 
the upstream provided packing and repack incrementally which is pretty 
good enough), but it is also really bad resource wise (that'll end up 
only wasting net bandwitdh and CPU cycles on the server).


Nicolas
