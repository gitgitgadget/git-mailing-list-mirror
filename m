Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585DEC433F5
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 10:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJAK2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 06:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJAK2R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 06:28:17 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAC910053
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 03:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664620088; bh=PU8jp4oq4J41oqJopvFVNO/wN0Ol66QaGM5gaLHkggs=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=fMAVu1dbEhEyXrvToWMocW2HxxE1cqvYI8prS7FmC59ko22jK/mAjSPQOqoxRu+yC
         QWkPMQEYrwgsK5juJXubCycdjZ9eAJfoX2MD2LwsbDD8M4e+QKx2BioRPv4jvs4QMQ
         vQg1VitA/B6OpJ/bE8srbuLKU947OC6w2Mca0KSBmLqY3VNGRaRxiEcM60CwpuwBtv
         gS6iKBeiBIcxRj300DfefXeu4g6ikEY92oBa7mTUshflsR0KLefdoofQ3BWmAIKNop
         SgwyGoJDGQ1e9lvTnos/1hioREndIM1qKFdr97HfIxW24LKeEeSdwAhvTPaSU7ToEL
         SA1TbiLz4fdXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHmm4-1oT2KM1SFi-00FHWn; Sat, 01
 Oct 2022 12:28:08 +0200
Message-ID: <0cf042fa-aa6f-4e3e-5982-3354c1cab677@web.de>
Date:   Sat, 1 Oct 2022 12:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: [PATCH v3 3/3] diff: support ^! for merges
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
 <16c49d20-cafc-4b48-3c6b-e11c74c29abb@web.de>
In-Reply-To: <16c49d20-cafc-4b48-3c6b-e11c74c29abb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fJ5CKMSen/1bgrD/A74q/vdmaUbnvJGhMpnJG00ejFA6x62DLZ8
 uyibfYRlp7ra/dSSGB+i7uQ/lFD5/qvyujBNffn2O2qac9eexbDquITgn5oBq0a+E02mY/9
 fPHdw6JP5uBKHm5Jz9pwmGw3SGwz7oWi0XMVqxCT4hC8lLv18L43CtP7UEt4nIgPfUrsi//
 Z2TDlXXm5rneCYoZ/f8ZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l1k9ogg6iUw=:FCVYxO206T/zbJkSaA8hG6
 ChtSdnIz7g17VKr2jcLnb62hoBE+RkDbyy6/rsj6mPV3RMorJ4AwdXOuMpgm5tC+7SFGQldVC
 EnXs+wYUu7Qudw08jxEwmJozL9/6ZdfsfVZYYaTHiTffIqYy6Rwwj6wHHXfTAlUSZ3Ijvm+bS
 7AtvS8AtJPvM9g2GnYuVlRDf1/IzEB3NAW6DNsJIbevIRPm+ljs1KfNN/6FTv1CNrF7AOgtu0
 IrDCC0DdaM75aejQVZVrJlpoea/S0TXhE1dZDZPsjPLNGhqO8+Gj5491Rhn+rOtdlmt/ExZsn
 7RWBqs9sYrwRwW5A9Ml2HUA+ZSR6JB5urrY6sbUZaIAptKy7ioewOS2j+vElyyLd9GCqIzull
 j3rXVWyaj30soj2LmQ6oCyu4IYgHvnVTfKI+qlqYLysxPa+b/MUQpHgdlWAaqyctDseDIN00J
 ABER/WjVrfgyezB1xpkXNtvG24y+1N/MauugYA50DPXry7Mr8TW7Tp332hIXZXyI6nbryBVrH
 6PJlPVKYbm2m+kC32yVtpZ44G6pZ5GXlDbDd+7Veg8yH8Qh2KhQWnxyAAvLDSjwKz+8SGwhqL
 h3B8Nb/U4Clmw7qvY2Eumglf5hm9DbhtvOwFqrhKhZ95Yud4oSUuOx0lNePLIe+ba+Oo2hrlX
 bb178akLmxBdCNJWzsKx7ppfejxs5VqSRh1rUoA+ZnGAt2opwctf9cNB6D9SISPhPetnRaxgv
 YpTKzJ6549A2WgLD2oV3x5mked2Vd19UHAPbLLz1RAxyQUTIAhsbSnxNBA1yUrz1vche/01kI
 VeCrImpMWmo9CzOdJfk3wq5Cfy5O+ZX7MRx5Ar88FYYrMMVkFPYpzpVr/epuzi4cONyHlM1Px
 lFLNEEZ09pEUPCpVyzjsKguu1NvFWgVWtG0EmBXEOnyynCffsyI9OqxXWRS5H7YhDaO0tqSaX
 YZNBwYJU0/zcYe21K4KvF1NvzANMuCgB4vU9apVntU+gPXjaViqET44+U3cOmez2/ZbXSsRrG
 teTceVTFCjCfxEytHw0moWYS8DMEEijQAXik4KKBMx4CLw1ofTTeovqADJTyEwupQy6QQD9O0
 hkqigmKKc/cLRrccxwwirmTZlGRuC6rZmn9JvdpJwc7osP+FWw1L8yY0XtVA8FSda5lnd52Ep
 /WnRE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

revision.c::handle_revision_arg_1() resolves <rev>^! by first adding the
negated parents and then <rev> itself.  builtin_diff_combined() expects
the first tree to be the merge and the remaining ones to be the parents,
though.  This mismatch results in bogus diff output.

Remember the first tree that doesn't belong to a parent and use it
instead of blindly picking the first one.  This makes "git diff <rev>^!"
consistent with "git show <rev>^!".

Reported-by: Tim Jaacks <tim.jaacks@garz-fricke.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-diff.txt |  8 ++++----
 builtin/diff.c             | 23 ++++++++++++++++++-----
 t/t4038-diff-combined.sh   | 10 ++++++++++
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 85ae6d6d08..52b679256c 100644
=2D-- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -79,10 +79,10 @@ If --merge-base is given, use the merge base of the tw=
o commits for the

 	This form is to view the results of a merge commit.  The first
 	listed <commit> must be the merge itself; the remaining two or
-	more commits should be its parents.  A convenient way to produce
-	the desired set of revisions is to use the `^@` suffix.
-	For instance, if `master` names a merge commit, `git diff master
-	master^@` gives the same combined diff as `git show master`.
+	more commits should be its parents.  Convenient ways to produce
+	the desired set of revisions are to use the suffixes `^@` and
+	`^!`.  If A is a merge commit, then `git diff A A^@`,
+	`git diff A^!` and `git show A` all give the same combined diff.

 'git diff' [<options>] <commit>..<commit> [--] [<path>...]::

diff --git a/builtin/diff.c b/builtin/diff.c
index 54bb3de964..0e49919735 100644
=2D-- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -209,7 +209,7 @@ static int builtin_diff_tree(struct rev_info *revs,
 static int builtin_diff_combined(struct rev_info *revs,
 				 int argc, const char **argv,
 				 struct object_array_entry *ent,
-				 int ents)
+				 int ents, int first_non_parent)
 {
 	struct oid_array parents =3D OID_ARRAY_INIT;
 	int i;
@@ -217,11 +217,18 @@ static int builtin_diff_combined(struct rev_info *re=
vs,
 	if (argc > 1)
 		usage(builtin_diff_usage);

+	if (first_non_parent < 0)
+		die(_("no merge given, only parents."));
+	if (first_non_parent >=3D ents)
+		BUG("first_non_parent out of range: %d", first_non_parent);
+
 	diff_merges_set_dense_combined_if_unset(revs);

-	for (i =3D 1; i < ents; i++)
-		oid_array_append(&parents, &ent[i].item->oid);
-	diff_tree_combined(&ent[0].item->oid, &parents, revs);
+	for (i =3D 0; i < ents; i++) {
+		if (i !=3D first_non_parent)
+			oid_array_append(&parents, &ent[i].item->oid);
+	}
+	diff_tree_combined(&ent[first_non_parent].item->oid, &parents, revs);
 	oid_array_clear(&parents);
 	return 0;
 }
@@ -385,6 +392,7 @@ int cmd_diff(int argc, const char **argv, const char *=
prefix)
 	int i;
 	struct rev_info rev;
 	struct object_array ent =3D OBJECT_ARRAY_INIT;
+	int first_non_parent =3D -1;
 	int blobs =3D 0, paths =3D 0;
 	struct object_array_entry *blob[2];
 	int nongit =3D 0, no_index =3D 0;
@@ -543,6 +551,10 @@ int cmd_diff(int argc, const char **argv, const char =
*prefix)
 				continue;
 			obj->flags |=3D flags;
 			add_object_array(obj, name, &ent);
+			if (first_non_parent < 0 &&
+			    (i >=3D rev.cmdline.nr || /* HEAD by hand. */
+			     rev.cmdline.rev[i].whence !=3D REV_CMD_PARENTS_ONLY))
+				first_non_parent =3D ent.nr - 1;
 		} else if (obj->type =3D=3D OBJ_BLOB) {
 			if (2 <=3D blobs)
 				die(_("more than two blobs given: '%s'"), name);
@@ -590,7 +602,8 @@ int cmd_diff(int argc, const char **argv, const char *=
prefix)
 					   &ent.objects[0], &ent.objects[1]);
 	} else
 		result =3D builtin_diff_combined(&rev, argc, argv,
-					       ent.objects, ent.nr);
+					       ent.objects, ent.nr,
+					       first_non_parent);
 	result =3D diff_result_code(&rev.diffopt, result);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 9a292bac70..2ce26e585c 100755
=2D-- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -80,11 +80,21 @@ test_expect_success 'check combined output (1)' '
 	verify_helper sidewithone
 '

+test_expect_success 'check combined output (1) with git diff <rev>^!' '
+	git diff sidewithone^! -- >sidewithone &&
+	verify_helper sidewithone
+'
+
 test_expect_success 'check combined output (2)' '
 	git show sidesansone -- >sidesansone &&
 	verify_helper sidesansone
 '

+test_expect_success 'check combined output (2) with git diff <rev>^!' '
+	git diff sidesansone^! -- >sidesansone &&
+	verify_helper sidesansone
+'
+
 test_expect_success 'diagnose truncated file' '
 	>file &&
 	git add file &&
=2D-
2.37.3
