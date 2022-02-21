Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED44EC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 09:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiBUJOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:14:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347625AbiBUJNN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 04:13:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F00A26125
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 01:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645434376;
        bh=J6qUt6nEzY1FQ90tDn2LqLldpZKhjTG7Q2r2fTHfVpI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ky5M67heinwRxLbhHnihddj3jsUu2V/QxUEMqKfaPMGMtcT4Hp1JEmMWVCNayhhmO
         Vp5nUVlDRHLStcx24FujQREnS805MJfyen5PH6e23Z3MEry3FHsOPxxPAanxyfiSB9
         hEWVOoBEHhN6VE90xJKMJzoKtNIzHnMvmYKQkiPI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowGU-1o2Zwn3aHe-00qRwK; Mon, 21
 Feb 2022 10:06:15 +0100
Date:   Mon, 21 Feb 2022 10:06:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Altmanninger <aclopte@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
In-Reply-To: <CABPp-BH_TiJaDpn2+VVjCb83NEFjL9teSk06+YiZyFGiTu8Lpg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202210956430.26495@tvgsbejvaqbjf.bet>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com> <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com> <xmqqy22tx8t1.fsf@gitster.g>
 <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com> <xmqqh79hvsgn.fsf@gitster.g> <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com> <20220203104241.yvfragan6ucecfjl@gmail.com>
 <CABPp-BH_TiJaDpn2+VVjCb83NEFjL9teSk06+YiZyFGiTu8Lpg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:z3ng5AoJsupq0NoNNA30uZVuszYc85KBrHQMfUQhk9Yr+YUZtRE
 5Gnt6iwxN5at77DFjQu7IrDF7bA6+XhMGxj8VHEYEUFh3sRnQcVLjCq1pYlBkUCP3D8Z44B
 Wu9ODlIskGl8Fxttu20LR7A+Fc6feE5qNdEjJeF7brXgHQYjg8FYyKGe+bIXfAp3aYmIKtZ
 71rtKNpXeeOGy87b7q/3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IMLqMyTemk8=:upOsl1A1osoooBWhftCI/3
 V/LyxPQ7AsogI2/UiJZ4n4xCbPdmg1Fvm/M6LDZYBP2WA8rIy0b36IqFtALTSJGb0kQmWG3y/
 ST0gK4PMCrtU1YjYd9lIF9tjTIjkqFo6hPwYFpe7r6nIov1+qsqj9nhfw7lN77WHyXFifqYw6
 /hUS+rUDz2EN9UDbrt/aDdjCQ3lpppqD/SD2EgNSplRDgOpjV5EPPlFpK8Nrc4w2vnFMR3ZjO
 7TmmK/T0hUxOg2R0kht/GlAaZGC3SCZuDwi+/m7V+MusdW2OaUTFR421671r/21B2p3WKLj+e
 CQUMOPd4oGoCu1yPqiHMCyVP2KNDWoEpFZM7iJVl65i4y9hhVjBIxhlqQYCoO5rnJPV7/TDNl
 ucWoBtT2P+QNPh76qlYFyn2Hlis+G/lCgKQGNJ4Hpwnec81a18hmb4pEI8Z8FKvboCIQPOzV6
 pO67fYmKbJRPSVXWe+WuPeY7xyFnpkrADSv6FzA3enU+k8qXyEvpIWrmveiRy+fzTuAr+O17w
 4DqxdFii+oY0Dfs3i7dFKFVmidkkTH5GxbpYMdyYaMZlbzgt8lsKCRjL6U8zQtF7etVviCtgy
 zxsVXlgTNPYMDFnuVW8zS4hGsoKeOUbEC3ASKIqElgaVuO09sUPlZbIMn9b632SLN6MAx8NAF
 YhBxkfvGLygEUii08+9akoJ/p+Pn+gO3KiyEPDJHe6PN27okGNahD8vSwpRSvy/vCbJroQ+LA
 iH7vuvDOPvZYihgHYxTTnxkNyi4BbGQMjzWyPw1R2QlWzjaXhB3abNvRcjKJk8mkA/Xv1oJXq
 hLk5e+5+FirHN4J2duIxe83kgjtutifeGAcqDTyK5DXtE3UIvbHj6FBfII2VFJJm1ri/lhv1n
 yFuKkEfRLetTnF3MPAGeFHB2Vwj1Q44T9wcxrn3ifAm66MnSFSNJPgizuJqTVqdvFNOuLb5KL
 tjIM2P9jRItuuffFvkZflmGEGjFbe9LdHLG2p1zNcZoJEjhKZsEYtjX+bX+PjpZnEwQQ6C4gM
 /80N7bSnLZA17JeJWX42Q0xqFEOxbpn509f+SiIi/pwx56QOJuu99G5DJnaeggNF33/hsgXv3
 IFka/NIevofI/k=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 3 Feb 2022, Elijah Newren wrote:

> On Thu, Feb 3, 2022 at 2:42 AM Johannes Altmanninger <aclopte@gmail.com>=
 wrote:
> >
> > On Wed, Feb 02, 2022 at 04:18:39PM -0800, Elijah Newren wrote:
> > > On Wed, Feb 2, 2022 at 2:01 PM Junio C Hamano <gitster@pobox.com> wr=
ote:
> > > >
> > > > Elijah Newren <newren@gmail.com> writes:
> > > >
> > > > > Yes, you are reading right.  I think the cherry-pick/rebase
> > > > > replacement actually deserves a separate command from what merge=
s
> > > > > should use; replaying a sequence of commits just has a number of=
 UI
> > > > > differences and abilities that I think pull it in a different
> > > > > direction.
> > > >
> > > > I completely disagree.  Each individual step in a sequence of
> > > > replaying commits in order (or in reverse order) should be
> > > > scriptable as a single merge-tree that takes "apply the change to =
go
> > > > from A^ to A on X".  Sequencing and placing UI around it is a job
> > > > for the script that drives merge-tree.
> > >
> > > Adding such an ability to merge-tree would be trivial -- it basicall=
y
> > > involves just two things: (1) accepting one extra argument, and (2)
> > > calling merge_incore_nonrecursive() instead of
> > > merge_incore_recursive().
> > >
> > > However, I think forking a subprocess for every merge of a series of
> > > commits is a completely unreasonable overhead, so even if we provide
> > > such an option to merge-tree, I still want a separate plumbing-ish
> > > tool that does non-worktree/non-index replaying of commits which is
> > > not written as a driver of merge-tree.  That other tool should just
> > > call merge_incore_nonrecursive() directly.  And such a tool, since i=
t
> > > should handle an arbitrary number of commits, should certainly be ab=
le
> > > to handle just one commit.  From that angle, it feels like adding
> > > another mode to merge-tree would just be a partial duplication of th=
e
> > > other tool.
> >
> > I wonder how the UI of a tool that does non-worktree/non-index cherry-=
picks
> > will look like.  I'd expect it to produce the same output as merge-tre=
e,
> > except cherry-pick should probably output a commit OID, not a tree.
> >
> > Maybe we want a unified command that produces commits from any sequenc=
e of
> > merge/cherry-pick/revert/reword steps. The obvious UI would use someth=
ing
> > like the rebase-todo list as input.  For example:
> >
> >         $ echo '
> >         pick commit1
> >         reword commit2  # edit commit message in $GIT_EDITOR
> >         merge commit3 -m "log message"
> >         ' | git create-commit commit0
> >         <OID of final commit>
> >
> > we start from commit0 and apply steps one-by-one. Obviously, one unsol=
ved
> > problem is how to pass parameters like commit messages if no editor sh=
ould
> > be invoked (my sketch uses -m).
> > If any of the steps fails when merging merge, then we get the tree wit=
h
> > conflicts
> >
> >         $ echo '
> >         pick commit1
> >         pick commit2
> >         pick commit-that-does-not-apply
> >         ' | git create-commit commit0
> >         <OID of commit after step 2>
> >         <OID of toplevel tree after failed merge>
> >         <Conflicted file info>
> >         <Informational messages>
> >
> > Replaying a series of commits might look like this:
> >
> >         $ echo 'pick commit1 ^commit0' | git create-commit new-base
> >
> > I'm concluding that this is a difficult UI problem
>
> I agree.  I've got a lot of thoughts on it, and some work in progress
> towards it (https://github.com/newren/git/tree/replay -- _very_ hacky,
> not even close to alpha quality, lots of fixup commits, todo comments,
> random brain dump files added to the tree, based on a previous round
> of this patch series, not updated for weeks, etc., etc.)

Just chiming in that I find that very exciting. But it's a tangent, and
slightly distracting from the topic at hand, so I would like to ask to
focus back on server-side merges.

> > and having a merge-tree command that accepts a "common ancestor"
> > parameter could make it easier to experiment.  Of course that depends
> > on who is experimenting.
>
> I think that would result in experiments and eventually full-blown
> scripts designed around forking subprocesses for every merge, and
> pushes us back into the world of having a scripted-rebase again.  Yes,
> I know people can transliterate shell back to C; it seems to always be
> done as a half-way measure with the forking just being done from C or
> have other UI-warts guided by the shell design.  In fact, *that* was
> the primary reason for me not providing a merge-tree option based on
> merge_incore_nonrecursive(), despite how trivial it'd be to provide
> it.  If someone wanted a merge_incore_nonrecursive() mode for
> merge-tree for reasons other than attempting to build a
> rebase/cherry-pick replacement based on it, then I'd be much happier
> to provide it.
>
> If someone wants to experiment with what a plumbing-ish
> rebase/cherry-pick would look like, the _right_ way to do it would be
> making using of merge_incore_nonrecursive() directly.  If they want
> example code, I already provided some a year and a half ago and got it
> merged into git.git in the form of t/helper/test-fast-rebase.c.  My
> "replay" branch is based on that code, but (a) moves it from t/helper
> to a real builtin, (b) removes the hardcoded very strict input, (c)
> removes the line of code doing the index & working tree updates, and
> (d) modifies the output to be a more plumbing-ish style.

I actually implemented that so I could provide apples-to-apples
speed comparisons between libgit2 and merge-ort:

=2D- snip --
=46rom 6a865c691810b67dc15ddb57ad110bd6fdfc2f12 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 28 Jan 2022 23:28:20 +0100
Subject: [PATCH] merge-tree: optionally force a simple 3-way merge

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 builtin/merge-tree.c | 72 ++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 22 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 58c0ddc5a3..1007aaaede 100644
=2D-- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -396,6 +396,7 @@ struct merge_tree_options {
 	int allow_unrelated_histories;
 	int show_messages;
 	int exclude_modes_oids_stages;
+	const char *nonrecursive_base;
 };

 static int real_merge(struct merge_tree_options *o,
@@ -409,34 +410,58 @@ static int real_merge(struct merge_tree_options *o,
 	struct merge_options opt;
 	struct merge_result result =3D { 0 };

-	parent1 =3D get_merge_parent(branch1);
-	if (!parent1)
-		help_unknown_ref(branch1, "merge-tree",
-				 _("not something we can merge"));
-
-	parent2 =3D get_merge_parent(branch2);
-	if (!parent2)
-		help_unknown_ref(branch2, "merge-tree",
-				 _("not something we can merge"));
-
 	init_merge_options(&opt, the_repository);

 	opt.show_rename_progress =3D 0;

-	opt.branch1 =3D branch1;
-	opt.branch2 =3D branch2;
+	if (o->nonrecursive_base) {
+		struct object_id base_oid, head_oid, merge_oid;
+		struct tree *base_tree, *head_tree, *merge_tree;
+
+		opt.ancestor =3D "(base)";
+		opt.branch1 =3D "(branch1)";
+		opt.branch2 =3D "(branch2)";
+
+		if (get_oid_treeish(o->nonrecursive_base, &base_oid))
+			die("could not parse base '%s'", o->nonrecursive_base);
+		base_tree =3D parse_tree_indirect(&base_oid);
+		if (get_oid_treeish(branch1, &head_oid))
+			die("could not parse head '%s'", branch1);
+		head_tree =3D parse_tree_indirect(&head_oid);
+		if (get_oid_treeish(branch2, &merge_oid))
+			die("could not parse merge '%s'", branch2);
+		merge_tree =3D parse_tree_indirect(&merge_oid);
+
+		merge_incore_nonrecursive(&opt,
+					  base_tree, head_tree, merge_tree,
+					  &result);
+	} else {
+		parent1 =3D get_merge_parent(branch1);
+		if (!parent1)
+			help_unknown_ref(branch1, "merge-tree",
+					 _("not something we can merge"));
+
+		parent2 =3D get_merge_parent(branch2);
+		if (!parent2)
+			help_unknown_ref(branch2, "merge-tree",
+					 _("not something we can merge"));
+
+		opt.branch1 =3D branch1;
+		opt.branch2 =3D branch2;

-	/*
-	 * Get the merge bases, in reverse order; see comment above
-	 * merge_incore_recursive in merge-ort.h
-	 */
-	common =3D get_merge_bases(parent1, parent2);
-	if (!common && !o->allow_unrelated_histories)
-		die(_("refusing to merge unrelated histories"));
-	for (j =3D common; j; j =3D j->next)
-		commit_list_insert(j->item, &merge_bases);
+		/*
+		 * Get the merge bases, in reverse order; see comment above
+		 * merge_incore_recursive in merge-ort.h
+		 */
+		common =3D get_merge_bases(parent1, parent2);
+		if (!common && !o->allow_unrelated_histories)
+			die(_("refusing to merge unrelated histories"));
+		for (j =3D common; j; j =3D j->next)
+			commit_list_insert(j->item, &merge_bases);
+
+		merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
+	}

-	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
 	if (result.clean < 0)
 		die(_("failure to merge"));

@@ -501,6 +526,9 @@ int cmd_merge_tree(int argc, const char **argv, const =
char *prefix)
 			   &o.allow_unrelated_histories,
 			   N_("allow merging unrelated histories"),
 			   PARSE_OPT_NONEG),
+		OPT_STRING(0, "force-non-recursive-base", &o.nonrecursive_base,
+			   N_("base-tree"),
+			   N_("force a simple three-way merge")),
 		OPT_END()
 	};

=2D- snap --

I do strongly agree that this should _not_ enter core Git's code, I just
provide this in case someone else wants to play with merge-ort on the
server side in an existing code base.

> We'll certainly have discussions on what that should look like.  But a
> plumbing-ish replacement for merge was much simpler, and made sense to
> do first.  I would prefer to concentrate on getting that hammered down
> first.  Then I'll start discussions on a plumbing-ish
> rebase/cherry-pick.  And if that doesn't fulfill all the needs that
> folks think they want out of merge-tree, then we can add a
> merge_incore_nonrecursive()-based mode to merge-tree.  It's all
> coming, but having fought transliterations-of-scripts in
> merge-recursive.c, sequencer.c, stash.c, rebase.c, etc. for years I
> really, really don't want any more of that.  Let's end that insanity.

Being the driving force behind many a "built-in-ification" of scripted
commands, I wholeheartedly agree. You can still see the fall-out of
designing commands in a scripted fashion, without any way to represent
data structures other than strings. I wish we had come up with a better
design to prototype commands than to write shell scripts. But I have to
admit that even I do not have any better idea than to work on a proper API
for libgit.a (which has historically invariably seen push-back from
Junio).

While I agree that this discussion is a valuable one, right now I would
like to focus on getting the server-side merges done, and once that has
happened, move on to the replay/sequencer/API discussion (which will
probably be a big one, not so much for technical reasons but more for all
too human ones).

Ciao,
Dscho
