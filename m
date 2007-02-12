From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT discards local commits on "stg pull"
Date: Mon, 12 Feb 2007 21:26:34 +0100
Message-ID: <20070212202634.GX4266@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net> <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 21:28:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGhmN-00006Q-85
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 21:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965318AbXBLU15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 15:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965365AbXBLU15
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 15:27:57 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:33625 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965318AbXBLU14 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 15:27:56 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BEBAF4A369;
	Mon, 12 Feb 2007 21:27:53 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 9A75A1F084; Mon, 12 Feb 2007 21:26:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39435>

On Mon, Feb 12, 2007 at 09:31:28AM +0000, Catalin Marinas wrote:
> On 12/02/07, Pavel Roskin <proski@gnu.org> wrote:
> >I have been bitten by a strange bug/feature of StGIT, and it looks like
> >it's not only counterintuitive, but also inconsistent with git.
> >
> >I have a repository available over ssh and I push to it from several
> >places. Sometimes I make a commit and forget to push it.  Then I run "stg
> >pull" to make sure my repository is up to date.
> >
> >The result is that the repository is rebased back to the last remote
> >commit. It's very easy to miss.  There is no warning.  Everything looks
> >just like an update from the remote.
> >
> >The example below shows that git-pull keeps my commit, but "stg pull"
> >discards it by rebasing back to the remote ID.
> 
> I think this is a "feature"

No, I agree it's a bug.  Rebasing after a fetch should allow this
workflow to work as well.  If the parent branch is not a rewinding
one, we should ensure there is nothing lost.  And even for rewinding
branches, we should probably keep track of the existence of commits,
so we can warn and nothing gets lost without knowing.

That makes me think that in most cases, an "stg commit" is done to be
pushed to a remote repo, as symetric operation to "stg pull".
Probably we could add support for this sort of operation (similar to
"stg-cvs commit" from my script).


> but we should've probably leave the
> original behaviour as the default. Maybe we should also have this
> per-branch rather than per-repository.

Right, having it per-branch would allow, eg. to declare something like
git-svn as the way to pull from a given branch, while using different
backends for other branches.


> I agree that for the rebasing case, we should have some warning if
> fast-forwarding of the stack's base is not possible so that you could
> run 'stg uncommit'.

Right.  "rebase --undo" could help too.

best regards,
-- 
Yann.
