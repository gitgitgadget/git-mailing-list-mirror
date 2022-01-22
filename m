Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D4C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiAVV42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbiAVV4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:16 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E839C06173D
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v6so6478063wra.8
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F9CLSZjha85LciqxPUUtBN1WTgwQfn25n79BuZOw90Q=;
        b=LUNIEUpYvhexCHZToLwy/+OxynVnUHKS9nsMILTz/kt2BpQ+9dh4rX3rWLr6nWeVrC
         XF267EGwOrSYaY0d+pB20sdtucHVFJNj9n3J0bBmXTcDDDYe8wzuo2CcWO+yjdBIf4g8
         xv6U9fcXqd4Xv63SB2MFds2vuo0O3ihc9+FT+NPFwsjyHPvbGs80Yb02jTb1FTa92CyM
         2NolNsiTAZckBuHgpBQ0/RCT4b9sk3DK3iIQDrc8iEVHFjHIZxVeBQjuPBbYRFzSL704
         GS2NVDdLxa4db3a1UIP9PEoOtjVw5nrmfekSutiNUf48hk4dHvPKJOY/3rXL/xp4wlbb
         vOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F9CLSZjha85LciqxPUUtBN1WTgwQfn25n79BuZOw90Q=;
        b=PmGpHYUN4wGvetAx+dYuiye8x+r0R+02eVrtmrepsqjnULKXyzNHe8dzKq3jVyJoli
         yu4MUzBFiKK82HxF6K69H9tYknc/2fNs1NryfOjYeaMXNiZrxfpoc19dYPg0okvNfL+U
         ImxX+qUExHOHMnR69DsBEaVLXAzUdGvnb6dgLHTw1LjFy/7dlz44FilN89R9U4/fXAgb
         a2zcyAl7iGty5S6p2Kr1xEQaOcFLouOcgFfLWdFs71jzEGFMehSfQFjPNq7xmBWxGAeL
         tkt8Ys/ofSn4LhxWj3j8/YX0aZ0486oILQB09mKFfXMq4yoZe72uo44fdnkWjEk36iJ0
         MtAA==
X-Gm-Message-State: AOAM5339JWwkm+naharAWwHcPigU24vhY7FsXMc5rsXo9a5VA/Qi1uis
        d4xe1NMBH7yb484fFHXd7MPl4ezh4tI=
X-Google-Smtp-Source: ABdhPJzDDJJR9A6zwjyuQHWuyH07gl9f/FrI67cHv8culsEcyKW/TSgZ+sMlSYLwcLjuAuKfvG2kGQ==
X-Received: by 2002:adf:e445:: with SMTP id t5mr8719275wrm.537.1642888573962;
        Sat, 22 Jan 2022 13:56:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm13898191wmh.6.2022.01.22.13.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:13 -0800 (PST)
Message-Id: <ba8a50f03cba3f3fcd734be5a75b6657f8f8029d.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:56:01 +0000
Subject: [PATCH 11/12] merge-tree: add a --allow-unrelated-histories flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Folks may want to merge histories that have no common ancestry; provide
a flag with the same name as used by `git merge` to allow this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt |  5 +++++
 builtin/merge-tree.c             |  7 ++++++-
 t/t4301-merge-tree-real.sh       | 24 +++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index beb08269a70..df10a5963c7 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -52,6 +52,11 @@ OPTIONS
 	default is to include these messages if there are merge
 	conflicts, and to omit them otherwise.
 
+--allow-unrelated-histories::
+	merge-tree will by default error out if the two branches specified
+	share no common history.  This flag can be given to override that
+	check and make the merge proceed anyway.
+
 OUTPUT
 ------
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 7aa7f9fd54a..98441d5e05b 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -394,6 +394,7 @@ static int trivial_merge(const char *base,
 struct merge_tree_options {
 	int real;
 	int trivial;
+	int allow_unrelated_histories;
 	int show_messages;
 	int exclude_oids_and_modes;
 };
@@ -440,7 +441,7 @@ static int real_merge(struct merge_tree_options *o,
 	 * merge_incore_recursive in merge-ort.h
 	 */
 	common = get_merge_bases(parent1, parent2);
-	if (!common)
+	if (!common && !o->allow_unrelated_histories)
 		die(_("refusing to merge unrelated histories"));
 	for (j = common; j; j = j->next)
 		commit_list_insert(j->item, &merge_bases);
@@ -504,6 +505,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &o.exclude_oids_and_modes,
 			   N_("list conflicted files without oids and modes"),
 			   PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "allow-unrelated-histories",
+			   &o.allow_unrelated_histories,
+			   N_("allow merging unrelated histories"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
index e921115cd2a..a0447410655 100755
--- a/t/t4301-merge-tree-real.sh
+++ b/t/t4301-merge-tree-real.sh
@@ -37,7 +37,13 @@ test_expect_success setup '
 	>whatever/empty &&
 	git add numbers greeting whatever/empty &&
 	test_tick &&
-	git commit -m other-modifications
+	git commit -m other-modifications &&
+
+	git switch --orphan unrelated &&
+	>something-else &&
+	git add something-else &&
+	test_tick &&
+	git commit -m first-commit
 '
 
 test_expect_success 'Content merge and a few conflicts' '
@@ -138,4 +144,20 @@ test_expect_success 'Check conflicted oids and modes without messages' '
 	test_cmp conflicted-file-info actual
 '
 
+test_expect_success 'error out by default for unrelated histories' '
+	test_expect_code 128 git merge-tree --write-tree side1 unrelated 2>error &&
+
+	grep "refusing to merge unrelated histories" error
+'
+
+test_expect_success 'can override merge of unrelated histories' '
+	git merge-tree --write-tree --allow-unrelated-histories side1 unrelated >tree &&
+	TREE=$(cat tree) &&
+
+	git rev-parse side1:numbers side1:greeting side1:whatever unrelated:something-else >expect &&
+	git rev-parse $TREE:numbers $TREE:greeting $TREE:whatever $TREE:something-else >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

