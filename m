Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22424C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbjEKV4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjEKV4M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:56:12 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7501C3C1B
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:56:10 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ab611e57c2so1165056a34.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683842169; x=1686434169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nveOpIQQN7dROak3PV1Ry6ipewOh0IRFYeRGBlbV3Gs=;
        b=UmJyWWg7EenJ+Fg1EtghIzk2TIOmKBszhJCSi40TOgvAG1pNKxTmufRfI+5LNb6GcU
         gFp7CLEazjnlKEVKWF/AJbzvwWjekr3uXIh9bVJqo4MbJ9wBQJDyAEGthfyI5cO2Q4zj
         YPdinSZ32jbj6vEEvOXH1UtWRC41t0zMrqQ5IVTz/kwZu+PPXzNLE1zO3JRnPNBSEW9d
         PyUqWNmEXVBQxYbxpDpkWb8XFUb3Raefp5Gc1oqOngIPogxC+mo/+9sKrAQ7XxDu05b1
         T8ZDIqv9PEiQGfHbreuuIKCW4TzBo6XdYaiiswc3DOJwMwlSlI4h7N9uQXv1aPKFXyD1
         RXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683842169; x=1686434169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nveOpIQQN7dROak3PV1Ry6ipewOh0IRFYeRGBlbV3Gs=;
        b=DQH/dEGSrI2muFjZqnM5AyqNsBfG3uEXeTfDCWF2ReNWS5srKA/GdQfKQuxdWK/Jiu
         e1gnNN7vBL2YCubQsN++Ae8F3fdT/9HKwvCKVqeurxcerhfox9hD3FRQ791HYKgNVUHK
         x18sP2i65+4RfEMIdjPu9q6/o0QukpD2xQz3fl1J7/VfVFswIWCKRKHNk8xl5Staqu3Y
         NSVkUKP7OzCjb2EvemhhQW4izyk7l3LjpcqMJVHEpZGm81awb5D6vAPRohyciCp9EUBn
         hm6COUECMzLhF77TL3apDjxL/xfJQXXJsb35FnTDbSnmFwPvCUlJaZiMS62iptGlriMs
         5u/g==
X-Gm-Message-State: AC+VfDwTR+S0Z7njcJgZ1jpqwpclIgfyQ546/Imue7M/Ofb/61V0r6x7
        /0FewXXGs392CuDCsNAoNyDN2N1u8q4=
X-Google-Smtp-Source: ACHHUZ70QyE0Mh9tzCP8v09hFzXeThi6wMA4DE1mJFKW1M1mvip6eKl/NyNrNfS3ql4Rl039xp4R5A==
X-Received: by 2002:a9d:5c11:0:b0:6ab:2918:8185 with SMTP id o17-20020a9d5c11000000b006ab29188185mr3967166otk.5.1683842169459;
        Thu, 11 May 2023 14:56:09 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d7843000000b006a5f7285a53sm7716495otm.6.2023.05.11.14.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:56:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] merge-tree: load config correctly
Date:   Thu, 11 May 2023 15:56:08 -0600
Message-Id: <20230511215608.1297686-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When real merges were implemented in 1f0c3a29da (merge-tree: implement
real merges, 2022-06-18), init_merge_options was called after doing
get_merge_parent, which means core.useReplaceRefs was not parsed at the
moment the commit objects were parsed, and thus essentially this option
was ignored.

This configuration is typically disabled in git hosts due to the ability
to spoof commits in strange ways. Users are able to use refs/replace/
references to make pull requests that look valid but introduce malicious
content. The resulting merge has the correct commit history, but the
malicious content exists in the root tree of the merge.

To fix this let's simply load the configuration before any call to
get_merge_parent().

Cc: Elijah Newren <newren@gmail.com>
Tests-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge-tree.c  |  4 ++--
 t/t4300-merge-tree.sh | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index aa8040c2a6..b405cf448f 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -424,6 +424,8 @@ static int real_merge(struct merge_tree_options *o,
 	struct merge_result result = { 0 };
 	int show_messages = o->show_messages;
 
+	init_merge_options(&opt, the_repository);
+
 	parent1 = get_merge_parent(branch1);
 	if (!parent1)
 		help_unknown_ref(branch1, "merge-tree",
@@ -434,8 +436,6 @@ static int real_merge(struct merge_tree_options *o,
 		help_unknown_ref(branch2, "merge-tree",
 				 _("not something we can merge"));
 
-	init_merge_options(&opt, the_repository);
-
 	opt.show_rename_progress = 0;
 
 	opt.branch1 = branch1;
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index c52c8a21fa..57c4f26e46 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -334,4 +334,22 @@ test_expect_success 'turn tree to file' '
 	test_cmp expect actual
 '
 
+test_expect_success 'merge-tree respects core.useReplaceRefs=false' '
+	test_commit merge-to &&
+	test_commit valid base &&
+	git reset --hard HEAD^ &&
+	test_commit malicious base &&
+
+	test_when_finished "git replace -d $(git rev-parse valid^0)" &&
+	git replace valid^0 malicious^0 &&
+
+	tree=$(git -c core.useReplaceRefs=true merge-tree --write-tree merge-to valid) &&
+	merged=$(git cat-file -p $tree:base) &&
+	test malicious = $merged &&
+
+	tree=$(git -c core.useReplaceRefs=false merge-tree --write-tree merge-to valid) &&
+	merged=$(git cat-file -p $tree:base) &&
+	test valid = $merged
+'
+
 test_done
-- 
2.40.0+fc1

