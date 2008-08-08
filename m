From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Show of hands, how many set USE_NSEC
Date: Fri, 8 Aug 2008 09:57:18 -0700
Message-ID: <20080808165718.GG9152@spearce.org>
References: <20080808163455.GE9152@spearce.org> <alpine.DEB.1.00.0808081854120.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRVIE-0007zj-K3
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbYHHQ5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYHHQ5U
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:57:20 -0400
Received: from george.spearce.org ([209.20.77.23]:55345 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbYHHQ5T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:57:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D7F0D38420; Fri,  8 Aug 2008 16:57:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808081854120.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91696>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 8 Aug 2008, Shawn O. Pearce wrote:
> 
> > I'm trying to come up with a sane way for jgit to realize it should 
> > truncate the milliseconds out of a timestamp before it comes to the 
> > index record.
> 
> You could add a config variable.

I was thinking a gitconfig (e.g. jcore.usensec) to enable the tv_nsec
usage (ok, well milliseconds only) in that repository, or globally
(if in ~/.gitconfig).

I also thought about looking at the index records to see if the
tv_nsec fields were always 0.  If all of them were 0 it would be a
good indication that the filesystem doesn't support that level of
granularity, or that whoever last wrote this index doesn't support
that level of granularity.  But this is a very expensive operation
to perform, relatively speaking.

> I hope that soon, we no longer need to 
> share the same index between C Git and JGit (I hope for a delta 
> pack implementation in Java...)

I fail to see what the DIRC (.git/index) file format and its cache
of tv_sec/tv_nsec has to do with delta pack implementation in Java.
Or are you saying that you could stop using C Git in certain cases
if you had delta pack generation in Java?

Really I'd just like to scrap the entire DIRC file format and do
it over again.  Having the flat namespace is nuts.  Linus and I
really disagree here, and since I have never produced code for C
Git to replace it (and prove why its better) I think he has me in
his kill file now.  :)

-- 
Shawn.
