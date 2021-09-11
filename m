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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFCCC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1033F611B0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhIKRFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhIKRFG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 13:05:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9C5C061756
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 10:03:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u16so7500655wrn.5
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zfWfPHMgm9u0K05BRsjEU1HqAMdMoIlWuokdizgG1MM=;
        b=nBKw9oSfBsBgUy6UR0FXW+Rzw6XG07Ex1IQFlXqyTe7bnpQT4fH69VAneWnOfzylh/
         /g5i83y7WwhUlS9AhAjAgcFvoZKhTGykCebLOipDPHC2qN5BzvTQJU5HmGRBOgGkN1tZ
         anaJ2JaDUR+L7LORmFqEwZSDe3CqbINfrkgiMohUfYY+9RGwLJ20DAsCB7vk2+AvkZXv
         CDlyHTzQSguzeOl+NVW2/sKrzqQCw4oGKh6TtLXfz3PN4rBIilHUEzfd9AbWEnzEmChI
         ar/1hERtiRpCo7gd3FY5/uO8Ah3T3xqBnWHhQhIKj3XLAgWsiIesxw4kvzd5rIVOs3sD
         OD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zfWfPHMgm9u0K05BRsjEU1HqAMdMoIlWuokdizgG1MM=;
        b=0YVJg97YVhSIuw/kvx64eRdGLQYpEirt9dUfxN6hFZPfAhMgYxM/jFNX1MODEdbkZx
         TdSgOWaJsdaza9dRTPCjmELRtT0K5RAU929P1MbTw1z/lxlqcfY9y8cRrhi7a+dDDy/y
         QC472XvTSmMQB/CtCnhJn/xw8AlGwFkKWS6A/L2+pHp9pikPVTF4rQr/+4pALXI44Pjp
         WSHbvf/kG6TInQvo9BoNtUgkqPQIK/UWh81jXRMbXN4Bw2+NcpTTF9GY2JsFEusB4wOf
         3ampMMjxu9LQy0IHgvvvmE92muTIOYAT3q9UP9rAW62o9qN9p/tm0sn4KB0CQg5iHSxl
         FZjQ==
X-Gm-Message-State: AOAM533XbiEEU/VzTjZ7nTJj7TGFbztRWjGzdeenbCQjVvGTZf1yUT3N
        PIlLcN1OQrwbaOyab+VmlzcMWRoudrQ=
X-Google-Smtp-Source: ABdhPJxX1IQyYAd7ePQTS7ZhEVysK8YRj5IwmY56hEBeDmvrEW5w/cT44JGTt6v9GmBuQpG4VxOYRg==
X-Received: by 2002:adf:d08d:: with SMTP id y13mr4019253wrh.156.1631379831703;
        Sat, 11 Sep 2021 10:03:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8sm2148015wms.32.2021.09.11.10.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 10:03:51 -0700 (PDT)
Message-Id: <9ce7246c0e94ab8e73a4e87c11bdc2968d1e56b2.1631379829.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
        <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Sep 2021 17:03:49 +0000
Subject: [PATCH v2 2/2] update documentation for new zdiff3 conflictStyle
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
index cb2ed589075..52d79117ef8 100644
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
index 3819fadac1f..259e1ac2cf0 100644
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
index 55af6fd24e2..a61742c8f98 100644
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
index f4cd7747d35..45606936c32 100644
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
-- 
gitgitgadget
