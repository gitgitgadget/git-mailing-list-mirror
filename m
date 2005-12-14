From: Petr Baudis <pasky@suse.cz>
Subject: Re: Tracking files across tree reorganizations
Date: Thu, 15 Dec 2005 00:45:04 +0100
Message-ID: <20051214234504.GL22159@pasky.or.cz>
References: <43A08B8F.1000901@zytor.com> <20051214223656.GJ22159@pasky.or.cz> <43A0A6E1.9070903@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 00:45:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmgJC-0004G0-P3
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 00:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVLNXpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 18:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVLNXpJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 18:45:09 -0500
Received: from w241.dkm.cz ([62.24.88.241]:64463 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965103AbVLNXpH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 18:45:07 -0500
Received: (qmail 22390 invoked by uid 2001); 15 Dec 2005 00:45:04 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43A0A6E1.9070903@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13661>

Dear diary, on Thu, Dec 15, 2005 at 12:12:33AM CET, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> said that...
> Petr Baudis wrote:
> >Hah, here we go again. :-)
> >
> >Dear diary, on Wed, Dec 14, 2005 at 10:15:59PM CET, I got a letter
> >where "H. Peter Anvin" <hpa@zytor.com> said that...
> >
> >>Did anything ever happen with that?
> >
> >Linus is against it.
> >
> 
> I don't think so.  Linus is against the user having to explicitly record 
> the moves, but we can detect the moves at the point of reorganization.

Linus' <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>:

 - you're doing the work at the wrong point for _another_ reason. You're
   freezing your (crappy) algorithm at tree creation time, and basically
   making it pointless to ever create something better later, because
   even if hardware and software improves, you've codified that "we have
   to have crappy information".

  I tend to agree with this now - although I disagree about his
performance point in the mail; but we can cache the autodetection
results out of commit objects to improve the performance, if it's
worth it (and I suspect it actually isn't, if you don't care about
the "A renamed to B and new A introduced, both in the same commit"
case).

  Note that the intent of the explicit rename recording is to really
record file reorganizations, not code refactoring. When you just
reorganize your tree, Linus' "meaningless special case" becomes very
meaningful, because at such point all the code inside the file travels.
But if you just move big chunks of code around and rename files based on
prevailing code origin or something (that's a weird thing to do but I've
seen people do it), then that's probably where the file as a whole
shouldn't be marked renamed.

  To encourage this practice, I might check the similarities of the
renamed files at the time of recording them, and print a big fat warning
to the user if it's less than say 90% or so. But I think that the huge
majority of cases where people want to rename is when they reorganize
their trees and move files as a whole, and that's why it's so useful
to support explicit renames recording.

> >Cogito will do it anyway ;-), when someone sends me a nice patch or when
> >I get to it (probably not very soon). I imagine it like this:
> >
> >(a) User can explicitly note file moves / renames. We follow those notes.
> >Probably the most viable for recording the notes is appending them at
> >the tail of the commit message.
> >
> >(b) If there are no notes for the given commit, we do the rename
> >autodetection already implemented in GIT. If it yields something,
> >we follow it.
> 
> I don't see anything in Linus' posts that says (b) is unacceptable.

  If we do it at the walk time, not commit time - I didn't emphasize
that in my previous mail while I should have.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
