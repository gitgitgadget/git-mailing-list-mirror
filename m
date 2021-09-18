Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496DCC433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DEBE610F7
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbhIRXEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 19:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbhIRXEN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 19:04:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C689DC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:02:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y198-20020a1c7dcf000000b0030b69a49fe9so1040471wmc.1
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zhBArD7PqyLyxVK2f2ws846ey9m8rsBoKAlGG4gZDsE=;
        b=Z7PMIPqvbk2R0ArhOiERPMtctvMxdXUtBDiKgt8NjJSQhcQYcT3XQ793idohIuuegz
         lHU0NcBRootFEB37tUMyot33EPnpH3qIFHLyHNBeaVQ1DkdY9ajWy1arUvfUsvm9VQvT
         pwZvkNjmBMQ+AtCuUN8hkyzgiJNTXd6h/OCgwOZaKPIYlTIucMQcm9J+uGVNnP+R9nOi
         pM6iyUzEikGfkhegj9fxtVHjz2XYr0cQfl9ys5oS88EDdHusIeqmetc+Jj6n5Ltyu2DM
         l7ch8SlbF8fmcNddKVXft0CbG17pugrNbU8RdkxOjTio5tq45a68/0XNYhcBJ3owrs65
         mnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zhBArD7PqyLyxVK2f2ws846ey9m8rsBoKAlGG4gZDsE=;
        b=aTDk3KkRrID2ePtziQ45WLZBdsTaTq8j47s051Klribk7Kv76WC4f2uHBaZgn0A8KF
         f9AwuwKFce7GpUWC0taLQbmu0uiYRFCK2oY3qumAdBx1sYn5sAnzux8KpGlUqw6c28fW
         9ol8al36heyQROutHN5NGCJ8gTv7NL65XrfbF8K3OdFpkzYEu9VATbSieQcJACZcH6LS
         C8tTP0fHfejTOYuTStiJFKBZ3KN2UT93ySOtVbkwNhpl6oZXktu2GY+GY7zKO0l6Ql0W
         Nw7Kulz1KzaTd9qKHPp52LsPxvrT7b2T7jT04f2VNFOaJwIy74X75gtzBbHEBsleomMU
         lrhA==
X-Gm-Message-State: AOAM531Xnk03wr/GFINuXaqCHnIBztrAiLCUrYR0pyOdoqGVDVFcF5e3
        L/iJhN2otfwXqS8Kqrhbhr7l3RHHn00=
X-Google-Smtp-Source: ABdhPJytQEAPrdn28b39BVU9/8F8L8qDMGmM4lFXxrU0dsDOSTWw1FEeTNGSPJgX1oLX2jdXILkr6w==
X-Received: by 2002:a7b:cf0b:: with SMTP id l11mr16838385wmg.176.1632006167280;
        Sat, 18 Sep 2021 16:02:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm14936221wmc.14.2021.09.18.16.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 16:02:46 -0700 (PDT)
Message-Id: <90aee68e14adb503c41760265b619a2d70720c2a.1632006164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.git.1632006164.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com>
        <pull.1036.v3.git.git.1632006164.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 23:02:44 +0000
Subject: [PATCH v3 2/2] update documentation for new zdiff3 conflictStyle
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/merge.txt     |  9 ++++++++-
 Documentation/git-checkout.txt     |  3 +--
 Documentation/git-merge-file.txt   |  3 +++
 Documentation/git-merge.txt        | 32 +++++++++++++++++++++++++-----
 Documentation/git-rebase.txt       |  6 +++---
 Documentation/git-restore.txt      |  3 +--
 Documentation/git-switch.txt       |  3 +--
 Documentation/technical/rerere.txt | 10 +++++-----
 builtin/checkout.c                 |  2 +-
 9 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index e27cc639447..99e83dd36e5 100644
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
+	the conflict region when those matching lines appear near either
+	the beginning or end of a conflict region.
 
 merge.defaultToUpstream::
 	If merge is called without any commit argument, merge the upstream
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b1a6fe44997..85c3d3513f7 100644
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
index f8560326132..7e9093fab60 100644
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
index e4f3352eb58..e8cecf5a51d 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -240,7 +240,8 @@ from the RCS suite to present such a conflicted hunk, like this:
 
 ------------
 Here are lines that are either unchanged from the common
-ancestor, or cleanly resolved because only one side changed.
+ancestor, or cleanly resolved because only one side changed,
+or cleanly resolved because both sides changed the same way.
 <<<<<<< yours:sample.txt
 Conflict resolution is hard;
 let's go shopping.
@@ -261,16 +262,37 @@ side wants to say it is hard and you'd prefer to go shopping, while the
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
index 506345cb0ed..dd9830dc5f8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -741,9 +741,9 @@ information about the rebased commits and their parents (and instead
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
index 55bde91ef9e..5964810caa4 100644
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
index 5c438cd5058..5c90f76fbe3 100644
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
index af5f9fc24f9..35d45414339 100644
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
index 8c69dcdf72a..a0b0fac6a68 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1519,7 +1519,7 @@ static struct option *add_common_options(struct checkout_opts *opts,
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
 		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
-			   N_("conflict style (merge or diff3)")),
+			   N_("conflict style (merge, diff3, or zdiff3)")),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
-- 
gitgitgadget
