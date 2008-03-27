From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: symbolic link management in git-archive
Date: Thu, 27 Mar 2008 18:34:30 +0000 (UTC)
Message-ID: <loom.20080327T175844-199@post.gmane.org>
References: <loom.20080327T112740-539@post.gmane.org> <7v3aqcb02s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jewwg-0006BH-Mh
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 19:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013AbYC0Sep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 14:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755874AbYC0Sep
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 14:34:45 -0400
Received: from main.gmane.org ([80.91.229.2]:45400 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755570AbYC0Seo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 14:34:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jewvu-0003gu-BT
	for git@vger.kernel.org; Thu, 27 Mar 2008 18:34:38 +0000
Received: from host45-62-dynamic.6-87-r.retail.telecomitalia.it ([87.6.62.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Mar 2008 18:34:38 +0000
Received: from sergio.callegari by host45-62-dynamic.6-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Mar 2008 18:34:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.6.62.45 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78359>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Sergio Callegari <sergio.callegari <at> gmail.com> writes:
> 
> > I guess the answer is "no" or "not yet", but is there a way to tell the
> > zip
> > backend of git-archive to follow symbolic links rather than to store 
> > them?
> 
> I am not sure what you mean.  Are you tracking a symbolic link X that
> points at Y in your revision and expecting git-archive to include 
> whatever
> happens to be at Y (which may or may not even exist) when you run the
> command?

Yes, this is the case.

> If that is the case, the answer is "no" and "will never happen".  If you
> are tracking a symbolic link X that points at Y, the information git
> tracks is the fact that there is a symbolic link X that points at Y,

... I obviously agree with this!

> and
> not what Y happens to look like at a random moment.

Well, certainly if the zip backend of git-archive in addition to the -1 ... -9
switches also supported a --dereference switch, I would not run git-archive
--format=zip --dereference at "random moments".  I would run it when I am sure
that things pointed at by the symbolic links in the tracked project actually
point at sensible things.

> Change to Y is not
> tracked by git

Unless Y is also in the tracked project...

> so why should you get different output from git-archive of
> the same revision before and after you modify Y which is not part of the
> revision to begin with?

Basically, because if I make a zip archive instead of a git bundle, I want to
store (and probably give to someone else) a copy of what _I see_ at a certain
instant in time which might not exactly coincide with the tracked state.

Note that if Y is outside of the tracked project and I make an archive, and then
I give the archive to my friend X, Mr. X will see the same symbolic link, but
still a completely and randomly different content than I do, depending on where
he is unpacking the archive.

But to get to a more practical case, my situation is this:

I have a project where I need to have the same content in multiple places,
otherwise development tools are not happy.
Since I do most of the development on Linux, I use symbolic links. This is very
good, not just because I save space, but particularly because I am sure that the
content cannot loose coherency (which would be very bad) at the different
places.

Every now and then, to distribute snapshots of the project, I run git archive to
make a zip file, that I give to other people.  Unfortunately, some of them use
Windows, where the symbolic links appear as one-liner text files. And obviously
they cannot compile anything and they complain.

So I would like git archive to be able to make zip archives with the symbolic
links /resolved/.

what I am asking is not to modify the standard behaviour of git archive to
follow links, rather to have a switch to activate the dereferencing behaviour
only when needed.  In the end git archive is a nice shorthand for a checkout and
a successive run of zip or tar and both zip and tar have a switch to control
this dereferencing behaviour (BTW, zip on my distro dereferences by default, the
switch is to store symbolic links).

Sergio
