From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 5 May 2006 20:15:41 +0200
Message-ID: <20060505181540.GB27689@pasky.or.cz>
References: <20060505005659.9092.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 20:15:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc4p7-00005g-9c
	for gcvg-git@gmane.org; Fri, 05 May 2006 20:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWEESOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 14:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWEESOc
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 14:14:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63213 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751196AbWEESO3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 14:14:29 -0400
Received: (qmail 12597 invoked by uid 2001); 5 May 2006 20:15:41 +0200
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20060505005659.9092.qmail@science.horizon.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19621>

Dear diary, on Fri, May 05, 2006 at 02:56:59AM CEST, I got a letter
where linux@horizon.com said that...
> But, as Linus has pointed out, this is a very partial solution which
> introduces a lot of difficulties elsewhere.  File renaming is a subset of
> the general class of code reorganizations.  Source files will be split,
> merged, and have functions moved back and forth.  You want the patch to
> find the code it applies to even if that code was moved.
> 
> And that can be done by taking a more global view of the patch.
> Identical file names is only a heuristic.  If the hunk on branch A
> can't find a place to apply on the same file in branch B, then
> you have to look a little harder, either at changes from branch B
> that introduce matching code elsewhere, or perhaps looking
> through history for a change that removed the match from the
> obvious place to see if it added a match elsewhere.

There are really two distinctions here which should be kept separate:
automatic vs. explicit movement tracking and file-level vs.
subfile-level movement tracking.

The automatic vs. explicit movement tracking is a lot more
controversial. Explicit movement tracking is pretty easy to provide for
file-level movements, it's just that the user says "I _did_ move file
A to file B" (I never got the Linus' argument that the user has no idea
- he just _performed_ the move, also explicitly, by calling *mv).

However, I guess the explicit movement tracking completely fails if you
go sub-file (without being extremely bothersome for the user) - you
would have to have control over the editor and the clipboard and even
then I'm not sure if you could reach any sensible results.

I still dislike automated movement tracking for whole files, but I'm
conciliated with it. Because it is probably the only really sensible way
to implement subfile-level tracking.  It would not be hard to implement
using pickaxe (actually, I believe it was near the top of Junio's TODO
few weeks ago) and a similarity detector comparing new and old version
(if it's dissimilar enough, check if that or a similar hunk was not
added somewhere else in the same commit; well, at least the idea
sounds simple).

One obvious problem are ambiguities - several similar files are renamed
to other similar files and now how do you decide which version to
choose? Merge the change to all the new files? Only to some? Panic?
I wonder how does the current recursive strategy deal with that.
Of course, this case sounds quite artificial and rare for whole files,
but I suspect that it will be much more common once you do not deal with
files but just hunks, moving bits of code around.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
