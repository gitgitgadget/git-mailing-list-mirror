From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation: reset: add some missing tables
Date: Wed, 6 Jan 2010 08:31:21 +0100
Message-ID: <201001060831.21959.chriscool@tuxfamily.org>
References: <20100105055831.3539.26382.chriscool@tuxfamily.org> <7vwrzx3v4z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 08:28:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSQJx-0000O4-8Q
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 08:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997Ab0AFH2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 02:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752485Ab0AFH2k
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 02:28:40 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:49199 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab0AFH2j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 02:28:39 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4953A81803B;
	Wed,  6 Jan 2010 08:28:28 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 058D98180E2;
	Wed,  6 Jan 2010 08:28:26 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vwrzx3v4z.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136242>

On mardi 05 janvier 2010, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > and while at it also explain why --merge option is disallowed in some
> > cases.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  Documentation/git-reset.txt |   35 +++++++++++++++++++++++++++++------
> >  1 files changed, 29 insertions(+), 6 deletions(-)
> >
> > I must say that I find it a bit strange (and difficult to explain) that
> > we have:
> >
> >       working index HEAD target         working index HEAD
> >       ----------------------------------------------------
> >        B       C     C    C     --merge   B       C     C
> >
> > while in the other cases, when it is allowed, --merge is like --hard.
>
> That is probably because you don't explain what --merge option is _for_
> well enough to your readers.  If the reader understands it is to reset
> away a half-merged conflicted result, starting from a potentially dirty
> work tree, then it would be very obvious that the above is the right
> thing to do.
>
> As a prerequisite, the reader should be aware (otherwise they should read
> some introductory git books, or
> http://gitster.livejournal.com/29060.html) that a mergy operation can
> stop without completing a merge in two ways:
>
>  - If a path that is involved in a mergy operation has local changes in
>    the work tree, or if the index is dirty, the operation stops _without_
>    doing anything.
>
>  - If all paths that are involved in a mergy operation are clean in the
>    work tree, the operation is attempted.  If a conflict happens at the
>    content level, the operation leaves the paths in conflicted state in
>    the index and leaves the conflict markers in the files in the work
>    tree.  Be _very_ aware that even in this case, cleanly automerged
> paths are updated in the index and the work tree.
>
> In the first case, you do not have to run "reset --merge", as nothing was
> done by the mergy operation (it happens to be safe to "reset --merge", as
> the only thing you lose is a partial add, which you can easily redo from
> the files in the working tree).
>
> In the latter case, there are four classes of paths:
>
>  (1) Ones that are not involved in the merge at all, and were clean from
>      the beginning.  The work tree file, the index and the HEAD would
>      match.
>
>      w=C i=C H=C
>
>  (2) Ones that are not involved in the merge at all, but were dirty when
>      you started the mergy operation.  They have your local changes in
> the work tree that you wanted to keep across the mergy operation.
>
>      w=B i=C H=C
>
>  (3) Ones that are involved in the merge, and were cleanly merged.  By
>      definition, these paths did _not_ have local changes in the work
> tree (otherwise the mergy operation would have stopped without doing
> anything).  These are updated in the index and the files in the work tree
> matches the index after the mergy operation stops.
>
>      w=B i=B H=C
>
>  (4) Ones that are involved in the merge, and were conflicted.  Again, by
>      definition, these paths did _not_ have local changes in the work
> tree These are left in the index as conflicted, and the files in the work
> tree have conflict markers after the mergy operation stops.
>
>      w=X i=U H=C
>
> "reset --merge HEAD" is about going back to the state before you started
> this mergy operation.  You don't need to do anything to paths in (1), and
> you want to reset paths in (3) and (4) back to the HEAD.
>
> Think what you want to do to (2).  By definition, they weren't involved
> in the mergy operation (otherwise you couldn't have come this far), so
> the difference between the index and the work tree is purely your local
> changes, untouched by the mergy operation, and have not even been updated
> in "cvs update" style.  The right thing to do is simply leave them as
> they are.
>
>     Side note.  Explained in the opposite way, if the work tree file is
>     different from the index and the index is not unmerged, the
> difference _only_ could have come from the local change before you
> started your mergy operation.  Any other change to the work tree files
> done by any mergy operation will be matched to the index.  So w=B i=C in
> (2) will immediately tell you that the change is a local one that is
> unrelated to the merge.
>
> By the way, people often say that the index is good because it allows you
> to make partial commits (i.e. "add -p"), but at the same time have this
> mistaken notion that it is the _primary_ benefit of the index.  Actually,
> a lot more important benefit of the index is (3) above.  When you are
> dealing with a large merge with many paths, often a lot of them automerge
> cleanly while some gives you conflicts.  The automerged results are added
> to the index and you do not have to see them in "git diff" (as their
> files and the index match), to allow you concentrate on the conflicted
> ones very easily.

Thanks for your explanations.
Christian.
