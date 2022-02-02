Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114FFC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbiBBHfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbiBBHfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:35:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F856C061763
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h21so36591560wrb.8
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6P8p3UrrMLUBxcnuyQxuozseE287fxxGacDfprCvR48=;
        b=ItN+4O4b0ln5iMNA6pawn/Su0MSgqMTXGTShPlGK01zH6T4jqwrrui4LpGuco/GxX0
         4AXQB7PCpo0rq/82DD0CsQnUW4kMPDeeijMYL77mvHX+OpuXf++Wm90pLY5qtqueWPVR
         kzt4n0of1ym33pEW9azE4gcsJ+mlAzv6vLFp6j5J9TX8tYGG4x9UNGqMHIBLMeuMomh5
         Xi+a/rUmbZnjfDdr9k7ac2hhfhaxodyqcKj6JuePdbuSGsx81H3p5nwFoVhFQ+2rocck
         zLdLpN5bTLdvig7Aq2+nifcb/4V8rM21SPbuED5caK8kWN6Ynx31whIwqTdWj5F2PoWQ
         Vlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6P8p3UrrMLUBxcnuyQxuozseE287fxxGacDfprCvR48=;
        b=Hr4V/+vbJ/5wWaWynRxGxHKGu98jpgBwGcZAF0JNauYPkYGDRc8j2bzLXiEbFT+QLD
         SdFPUH9jpu/duA/KFgHcvKYVCFVsWyrQCw1T7Gi+akV1U+H+3oCePxvwlnch5kf8Rvgt
         2EkzTX/etDYjeQ2fzdTIqYia+A6y4NO85wy+eZyhcnkpcssIVqVl2GLqn9W9tiD6rUvT
         UJlOT9QBmZlFlVDP8b8LhNbsvuntkJA6zf4zXm0LKpu/11BcRPdEm1vlWIIxpCQgEVCh
         jCAYh5vOCi9yNjxP9K4XTrnxkI4N83QwPdeY57b/C3V3R1QAqGIn8Eu8J5SyAegCqzRn
         OLgw==
X-Gm-Message-State: AOAM530h2CSSOh7fPU5yAQ7Ei9eTMix6usNeXBcXnxxK3eAsnHm84S/X
        sZnzArjvPHSrVtGgLed78uD/GvVWWnA=
X-Google-Smtp-Source: ABdhPJxLwUP73nI3sgHLdsPuu+BwCOcnEDr+/30W9C9b/NUwD9pWN8iJJk3nS8yqV+EerG9naa1kBw==
X-Received: by 2002:a5d:64c4:: with SMTP id f4mr25142039wri.278.1643787294889;
        Tue, 01 Feb 2022 23:34:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm3838873wma.22.2022.02.01.23.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:54 -0800 (PST)
Message-Id: <c854ecb5f4a456cbf3fe89ac4611e301e1ccf0b4.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:40 +0000
Subject: [PATCH v3 14/15] merge-tree: add a --allow-unrelated-histories flag
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
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
 t/t4301-merge-tree-write-tree.sh | 24 +++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 02f766716f9..e6a9ff2768b 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -55,6 +55,11 @@ OPTIONS
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
index 7e55f0fa301..58c0ddc5a32 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -393,6 +393,7 @@ static int trivial_merge(const char *base,
 
 struct merge_tree_options {
 	int mode;
+	int allow_unrelated_histories;
 	int show_messages;
 	int exclude_modes_oids_stages;
 };
@@ -430,7 +431,7 @@ static int real_merge(struct merge_tree_options *o,
 	 * merge_incore_recursive in merge-ort.h
 	 */
 	common = get_merge_bases(parent1, parent2);
-	if (!common)
+	if (!common && !o->allow_unrelated_histories)
 		die(_("refusing to merge unrelated histories"));
 	for (j = common; j; j = j->next)
 		commit_list_insert(j->item, &merge_bases);
@@ -496,6 +497,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &o.exclude_modes_oids_stages,
 			   N_("list conflicted files without modes/oids/stages"),
 			   PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "allow-unrelated-histories",
+			   &o.allow_unrelated_histories,
+			   N_("allow merging unrelated histories"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index f89d87c26b7..4de089d976d 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -38,7 +38,13 @@ test_expect_success setup '
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
@@ -179,4 +185,20 @@ test_expect_success 'NUL terminated conflicted file "lines"' '
 	test_cmp expect actual
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

