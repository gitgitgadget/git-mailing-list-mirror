Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335F3ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 15:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiIUPf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiIUPeh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 11:34:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC759C222
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 08:31:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso3987731wms.5
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=MabCfAzJk6F4sT/W3jKTzGUQFzPyLFyB/Yzr4hMqRlE=;
        b=YeiamJNTBF45njL/0u4Sfh8wcINfblydN6CBBoDmKEgJ2vev1W8sfRDrgBpfLPcnir
         USEaiB8d7DG1Cy5LqWbqZ1KTn2bIygKmVIBcMcZ2EHXNYL12XJiPOF1D19UkCORN23gN
         RCv3+S6G/ffJASK9H48EWuoaPRj2HxNPH3HlIEkjQ2XBqGTlggKUeF69VSzi+7/xcf1x
         jMAZVIzSB/u5KpVMCF/kLDjg7TyYOxHr9/TOIXoONMp44Cz9S3Slr+dbWwPf5C2YYvPD
         eAW+iv+sOT/UpS0bJE/sg1Ofa1ct+Is42A89JSYWuNh+uugr0dERuet+/ZAZF2/l7F4Q
         Lnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=MabCfAzJk6F4sT/W3jKTzGUQFzPyLFyB/Yzr4hMqRlE=;
        b=XZkzzADS80rho03BYUdm/EU4+AoazBcnZnC7rI28HiDAQvAuUyK7SUdLasZvtVyviC
         bLQlp0YJDqb4kkMq+kLRZH0vv+9KKUZqIPsSA4ZZeQ1VmmBmfqX46zXeKbO/acnVP7i9
         T56b5vLKoFkqoYLgsE2wsesg04CyfmXpiqb5FnCss++a9qICPm/ZGNGI9U1EcbefJcHn
         sClMaSUngKxCMOE7ADlE4anuU9RK4cMQe4X1t6aCo68jKBMwBJueRUcUQaeE7oFWouzk
         4lv3dkoN9B+EOViiRCvFr7Gdma3VjnbTW2THdL70Y9rcixd9Ecmft9u8FCHC+EriDuoM
         hDdg==
X-Gm-Message-State: ACrzQf3fEpui/HKs1CiRGE8Vsce4IX5ctNwxNvlkiaSWGVUmah9cFS3u
        srs3bNSwz2Q7jl25r/Eg/VpH8Z+spNY=
X-Google-Smtp-Source: AMsMyM5wtHMgrXlYNyLutpgd2KKSygPbL8lgx7y5KW1/AHOYKmAKp3gRl9Zn+YW+BY9A/Etf5nX/cw==
X-Received: by 2002:a05:600c:1f0d:b0:3b4:ba4d:272a with SMTP id bd13-20020a05600c1f0d00b003b4ba4d272amr6490309wmb.105.1663774249741;
        Wed, 21 Sep 2022 08:30:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l30-20020a05600c1d1e00b003a601a1c2f7sm3655540wms.19.2022.09.21.08.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:30:49 -0700 (PDT)
Message-Id: <pull.1362.git.1663774248660.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Sep 2022 15:30:48 +0000
Subject: [PATCH] merge-tree: fix segmentation fault in read-only repositories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Independent of the question whether we want `git merge-tree` to report a
tree name even when it failed to write the tree objects in a read-only
repository, there is no question that we should avoid a segmentation
fault.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    merge-tree: fix segmentation fault in read-only repositories
    
    Turns out that the segmentation fault reported by Taylor
    [https://lore.kernel.org/git/YyopQD+LvPucnz3w@nand.local/] happened
    while testing merge-ort in a read-only repository, and that the upstream
    version of git merge-tree is as affected as GitHub's internal version.
    
    Note: I briefly considered using the OID of the_hash_algo->empty_tree
    instead of null_oid() when no tree object could be constructed. However,
    I have come to the conclusion that this could potentially cause its own
    set of problems because it would relate to a valid tree object even if
    we do not have any valid tree object to play with.
    
    Also note: The question I hinted at in the commit message, namely
    whether or not to try harder to construct a tree object even if we
    cannot write it out, maybe merits a longer discussion, one that I think
    we should have after v2.38.0 is released, so as not to distract from
    focusing on v2.38.0.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1362%2Fdscho%2Fmerge-tree-in-read-only-repos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1362/dscho/merge-tree-in-read-only-repos-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1362

 builtin/merge-tree.c             | 4 +++-
 t/t4301-merge-tree-write-tree.sh | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ae5782917b9..25c7142a882 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -412,6 +412,7 @@ static int real_merge(struct merge_tree_options *o,
 	struct commit_list *merge_bases = NULL;
 	struct merge_options opt;
 	struct merge_result result = { 0 };
+	const struct object_id *tree_oid;
 
 	parent1 = get_merge_parent(branch1);
 	if (!parent1)
@@ -446,7 +447,8 @@ static int real_merge(struct merge_tree_options *o,
 	if (o->show_messages == -1)
 		o->show_messages = !result.clean;
 
-	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
+	tree_oid = result.tree ? &result.tree->object.oid : null_oid();
+	printf("%s%c", oid_to_hex(tree_oid), line_termination);
 	if (!result.clean) {
 		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
 		const char *last = NULL;
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 28ca5c38bb5..e56b1ba6e50 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -810,4 +810,12 @@ test_expect_success 'can override merge of unrelated histories' '
 	test_cmp expect actual
 '
 
+test_expect_success 'merge-ort fails gracefully in a read-only repository' '
+	git init --bare read-only &&
+	git push read-only side1 side2 &&
+	test_when_finished "chmod -R u+w read-only" &&
+	chmod -R a-w read-only &&
+	test_must_fail git -C read-only merge-tree side1 side2
+'
+
 test_done

base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
-- 
gitgitgadget
