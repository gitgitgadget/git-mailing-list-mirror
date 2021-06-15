Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50BCC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 05:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884D06140F
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 05:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhFOFSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 01:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhFOFSV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 01:18:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427F5C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 22:16:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c18-20020a05600c0ad2b02901cee262e45fso293176wmr.4
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 22:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6QvKThN8hRAHWWPOdsalmFMedj3mFw2/ShAVQwVUW08=;
        b=emKWN5ex+AGy1VsHgign2i4bWm8/wm5PU4XXPgvVg/igFLWeICnbVy/FAnXFZO+xhe
         JSusC9aqCVLiRmz51GeHAcMRpGYoMueJZnJh8pZLAgwKzdrDu67RS3VbS3DYjw+YZdIV
         f5GzfYkFeuYQczpf9rVMhSU8zPQxppQ+CR85sLCRzA6Sp8n4tXGaubwBXY9lnW24MeCt
         NqAOxGEUthaIaAS/U2z6Pdb078Vs+cE83xq+L/ji3VcRD5Hlm5jLsBY6gjLIukriGPM5
         1kYqHLkLi04ZABPI740bKoTLI+0Jm76dim7vwvfN5/UtEpr38U/eko8gth8rMwpMGLWG
         K2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6QvKThN8hRAHWWPOdsalmFMedj3mFw2/ShAVQwVUW08=;
        b=FrWI59zEP+LTxcv3ucyINHEmY9cjaegabs8NnfwKy6vqz0Pu/ugA9Hlr8s0XVbGxqc
         Emgnk2K2wLa0O/sxysMDmYtxAEBsYTxu3ueArYAfo/Ap5KE+K5snyEdAanm+BMOVcp3W
         iHUFs7kn9e1dhzEprMw53XBufi/K/LBXgFo+Qm1PxEczGR089JEw+l3Lbvxm1erT54nk
         jK35EuHM+0XUJKzJD6Ko9t/+vpJLalKRown/mrJt81A14LDJt+Oy5H4u9oRmlayxdCjK
         berijILqTt4RtUE/OsDtjzafdOCfXNctUn0879QTH71YLMZRDss8MTbhZJQDi3ycgmG0
         thhw==
X-Gm-Message-State: AOAM533mJPanH93wUDpxY/lxVnzIU71RwXW2FW6Tb2Eqn4WuSOzn1IGX
        Idk/8qS+Ag6njuzulaplFnY7A1Q3f9M=
X-Google-Smtp-Source: ABdhPJwirA0LnrAwDexqmQB+BHxABh7X3zUXHFVhVZfQwjFyLZZFzYVMKWiIaw+HB8qsda4lutmVAQ==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr19971125wmj.109.1623734173613;
        Mon, 14 Jun 2021 22:16:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm14829455wmq.4.2021.06.14.22.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 22:16:13 -0700 (PDT)
Message-Id: <50e82a7a32c1cc5c1d2282f6f5b2b32a8ce7444f.1623734171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 05:16:10 +0000
Subject: [PATCH 2/2] update documentation for new zdiff3 conflictStyle
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/merge.txt         |  9 +++++++-
 Documentation/git-checkout.txt         |  3 +--
 Documentation/git-merge-file.txt       |  3 +++
 Documentation/git-merge.txt            | 32 ++++++++++++++++++++++----
 Documentation/git-rebase.txt           |  6 ++---
 Documentation/git-restore.txt          |  3 +--
 Documentation/git-switch.txt           |  3 +--
 Documentation/technical/rerere.txt     | 10 ++++----
 builtin/checkout.c                     |  2 +-
 contrib/completion/git-completion.bash |  4 ++--
 10 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index cb2ed589075b..7ab289f35c7f 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -4,7 +4,14 @@ merge.conflictStyle::
 	shows a `<<<<<<<` conflict marker, changes made by one side,
 	a `=======` marker, changes made by the other side, and then
 	a `>>>>>>>` marker.  An alternate style, "diff3", adds a `|||||||`
-	marker and the original text before the `=======` marker.
+	marker and the original text before the `=======` marker.  The
+	"merge" style tends to produce smaller conflict regions than diff3,
+	both because of the exclusion of the original text, and because
+	when a subset of lines match on the two sides they are just pulled
+	out of the conflict region.  Another alternate style, "zdiff3", is
+	similar to diff3 but removes matching lines on the two sides from
+	the conflict region when those matching lines appear near the
+	beginning or ending of a conflict region.
 
 merge.defaultToUpstream::
 	If merge is called without any commit argument, merge the upstream
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b1a6fe449973..85c3d3513f74 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -265,8 +265,7 @@ When switching branches with `--merge`, staged changes may be lost.
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values are
-	"merge" (default) and "diff3" (in addition to what is shown by
-	"merge" style, shows the original contents).
+	"merge" (default), "diff3", and "zdiff3".
 
 -p::
 --patch::
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index f85603261325..7e9093fab60d 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -70,6 +70,9 @@ OPTIONS
 --diff3::
 	Show conflicts in "diff3" style.
 
+--zdiff3::
+	Show conflicts in "zdiff3" style.
+
 --ours::
 --theirs::
 --union::
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3819fadac1f1..259e1ac2cf0c 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -238,7 +238,8 @@ from the RCS suite to present such a conflicted hunk, like this:
 
 ------------
 Here are lines that are either unchanged from the common
-ancestor, or cleanly resolved because only one side changed.
+ancestor, or cleanly resolved because only one side changed,
+or cleanly resolved because both sides changed the same way.
 <<<<<<< yours:sample.txt
 Conflict resolution is hard;
 let's go shopping.
@@ -259,16 +260,37 @@ side wants to say it is hard and you'd prefer to go shopping, while the
 other side wants to claim it is easy.
 
 An alternative style can be used by setting the "merge.conflictStyle"
-configuration variable to "diff3".  In "diff3" style, the above conflict
-may look like this:
+configuration variable to either "diff3" or "zdiff3".  In "diff3"
+style, the above conflict may look like this:
 
 ------------
 Here are lines that are either unchanged from the common
-ancestor, or cleanly resolved because only one side changed.
+ancestor, or cleanly resolved because only one side changed,
 <<<<<<< yours:sample.txt
+or cleanly resolved because both sides changed the same way.
 Conflict resolution is hard;
 let's go shopping.
-|||||||
+||||||| base:sample.txt
+or cleanly resolved because both sides changed identically.
+Conflict resolution is hard.
+=======
+or cleanly resolved because both sides changed the same way.
+Git makes conflict resolution easy.
+>>>>>>> theirs:sample.txt
+And here is another line that is cleanly resolved or unmodified.
+------------
+
+while in "zdiff3" style, it may look like this:
+
+------------
+Here are lines that are either unchanged from the common
+ancestor, or cleanly resolved because only one side changed,
+or cleanly resolved because both sides changed the same way.
+<<<<<<< yours:sample.txt
+Conflict resolution is hard;
+let's go shopping.
+||||||| base:sample.txt
+or cleanly resolved because both sides changed identically.
 Conflict resolution is hard.
 =======
 Git makes conflict resolution easy.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 55af6fd24e27..a61742c8f98f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -740,9 +740,9 @@ information about the rebased commits and their parents (and instead
 generates new fake commits based off limited information in the
 generated patches), those commits cannot be identified; instead it has
 to fall back to a commit summary.  Also, when merge.conflictStyle is
-set to diff3, the apply backend will use "constructed merge base" to
-label the content from the merge base, and thus provide no information
-about the merge base commit whatsoever.
+set to diff3 or zdiff3, the apply backend will use "constructed merge
+base" to label the content from the merge base, and thus provide no
+information about the merge base commit whatsoever.
 
 The merge backend works with the full commits on both sides of history
 and thus has no such limitations.
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 55bde91ef9e5..5964810caa41 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -92,8 +92,7 @@ in linkgit:git-checkout[1] for details.
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values
-	are "merge" (default) and "diff3" (in addition to what is
-	shown by "merge" style, shows the original contents).
+	are "merge" (default), "diff3", and "zdiff3".
 
 --ignore-unmerged::
 	When restoring files on the working tree from the index, do
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 5c438cd50587..5c90f76fbe35 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -137,8 +137,7 @@ should result in deletion of the path).
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values are
-	"merge" (default) and "diff3" (in addition to what is shown by
-	"merge" style, shows the original contents).
+	"merge" (default), "diff3", and "zdiff3".
 
 -q::
 --quiet::
diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index af5f9fc24f93..35d454143399 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -14,9 +14,9 @@ conflicts before writing them to the rerere database.
 
 Different conflict styles and branch names are normalized by stripping
 the labels from the conflict markers, and removing the common ancestor
-version from the `diff3` conflict style. Branches that are merged
-in different order are normalized by sorting the conflict hunks.  More
-on each of those steps in the following sections.
+version from the `diff3` or `zdiff3` conflict styles.  Branches that
+are merged in different order are normalized by sorting the conflict
+hunks.  More on each of those steps in the following sections.
 
 Once these two normalization operations are applied, a conflict ID is
 calculated based on the normalized conflict, which is later used by
@@ -42,8 +42,8 @@ get a conflict like the following:
     >>>>>>> AC
 
 Doing the analogous with AC2 (forking a branch ABAC2 off of branch AB
-and then merging branch AC2 into it), using the diff3 conflict style,
-we get a conflict like the following:
+and then merging branch AC2 into it), using the diff3 or zdiff3
+conflict style, we get a conflict like the following:
 
     <<<<<<< HEAD
     B
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f4cd7747d35d..45606936c328 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1524,7 +1524,7 @@ static struct option *add_common_options(struct checkout_opts *opts,
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
 		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
-			   N_("conflict style (merge or diff3)")),
+			   N_("conflict style (merge, diff3, or zdiff3)")),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 859455929814..8489ca394970 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2445,7 +2445,7 @@ _git_switch ()
 
 	case "$cur" in
 	--conflict=*)
-		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
 		;;
 	--*)
 		__gitcomp_builtin switch
@@ -2886,7 +2886,7 @@ _git_restore ()
 
 	case "$cur" in
 	--conflict=*)
-		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
 		;;
 	--source=*)
 		__git_complete_refs --cur="${cur##--source=}"
-- 
gitgitgadget
