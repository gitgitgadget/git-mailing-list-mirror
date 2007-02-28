From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Add a testcase for the safety of pull-policy='pull'.
Date: Wed, 28 Feb 2007 22:48:51 +0100
Message-ID: <20070228214851.GC4149@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070225220853.31361.7201.stgit@gandelf.nowhere.earth> <b0943d9e0702270625o5a9ef8b4xd0fa5df68e2b805a@mail.gmail.com> <20070227210906.GH4045@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0702271538q32e6a9d5y6ac73adfc4854ab6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 22:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMWh7-0001hP-GC
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 22:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbXB1VtE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 16:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbXB1VtE
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 16:49:04 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:53335 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932463AbXB1VtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 16:49:01 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 3AF43395A;
	Wed, 28 Feb 2007 22:48:59 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 29C811F08A; Wed, 28 Feb 2007 22:48:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0702271538q32e6a9d5y6ac73adfc4854ab6@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41010>

On Tue, Feb 27, 2007 at 11:38:45PM +0000, Catalin Marinas wrote:
> >> BTW, push --undo now requires a status --reset beforehand.
> >
> >Oh, I had not noticed that.  Why so ?  It's not like if "push --undo"
> >would lose any valuable data...
> 
> I added it so that one cannot remove the local changes by doing a
> "push --undo" in error. You would have to explicitly ask for local
> changes removing with status --reset.

At least, the message in that case should probably be made better,
when undoing to avoid having to resolve a conflict: the message says I
cannot undo because I have a conflict, whereas it is the exact reason
why I want to undo.
Especially, since the conflict markers are now auto-recorded, we could
simply allow undo in that case.

> >What strikes me most in this case is the difference in behaviour
> >between this type of conflict (conflict marked in index, so needs an
> >operation outside the current scope of stgit to proceed), with a
> >regular stgit conflict that occurs during a push (index clean,
> >conflict info not available to tools written for regular GIT).
> 
> I think this is a valid GIT conflict as the upstream tree re-wrote the
> history and git-pull will trigger a 3-way merge.

I do not discuss the validity of the conflict.  I'm just emphasizing
that it makes it hard to handle things in stgit, with *any*
post-rebase processing being skipped.  For now we seem to have nothing
critical for that workflow (I'll surely end up with deactivating the
orig-base check for pull-policy=pull), but that may cause more trouble
later, eg. when implementing transactions.


> If you would always use git-fetch + stgit-rebase, there wouldn't be
> any problem.

Sure, that's why I'm lobbying for this policy to be the default :)


> (BTW, I just added a patch for a 2-way interactive merge as well).

Sounds great - I just had an add/add conflict today on 0.12.1 when
trying to play with "resolved -i", and it loudly complained it had no
ancestor to play with.  Sounds like a perfect usage for 2-way merges.

Best regards,
-- 
Yann.
