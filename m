Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392E6C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 19:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjEJTHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 15:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJTHk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 15:07:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFED30D5
        for <git@vger.kernel.org>; Wed, 10 May 2023 12:07:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f42c86543bso16604605e9.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683745656; x=1686337656;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ICipGXq+9cJyJzPWo4zvh/E8ySUgzThaHZFMhMiuTVM=;
        b=NB0L6458iiJbdmF3mzPt9bi53JIN0wmKvzVOSIPNGZDpsMuB5tt8t2JebcGON1OcpE
         INPpE72zm8aMm5pRHM0Yet7P/pRRRyUFr5IGpKoSFHaJy3IJtepBaHbTgETDHqDSCxId
         EVYHkHgO4IOLJbNdIsxrxpAv78lZY/0F11lwPaeV8w7ItczdNmW7XlVERD8yWaFjZm8h
         x+p31sHDu38uxfX3d9Cp4uMxRp4ZmSu4WrbRUscXVkw8M1S37nlaEaZktZimNqDkyJb/
         6QlOpc0tn8Tz8gzkEr8ZiPjqyqNN/OEPBW7sG4dDgFwAocVjHT1wbgLc7cwBBASwTKa4
         Xqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683745656; x=1686337656;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICipGXq+9cJyJzPWo4zvh/E8ySUgzThaHZFMhMiuTVM=;
        b=l6576H9BXRpkFz1qFGgMau+Btq8joyyPH2reGDhphjWcZ17e7FjrmTW+uQ01MDWY50
         RU1WZHE4ffZhaRx3yYMLmxgNLDDQYlEUk37dNTfHNfUHXxozb45b6ot+9QQ88eZtG1Of
         OssDnFvp3OYHRUHdqhyrzI9u9IMQOM91jhvKzqJZkOtbFby933zgp/acfEHWJEUn0vTj
         b+YvmtcqBbGgYOKPM2+uFEP5CKYlu3Z2oGH7NA47p2Y53ohJiQbFFtCAsvR29PRprFvi
         jJhipLf1sDUd671TwllC6pux3HdwnKWIUmrAnzqO7Q7nBQ6xcIRJkMI9xNHYXr9xHVEB
         R14Q==
X-Gm-Message-State: AC+VfDwTT1U4VZdeID/eRhkJPkzpR31JIFFDkUzK3WzZ9mIJDzJD6cCo
        9eMYVR6T997XIh0xRWBzVAF04hAJd78=
X-Google-Smtp-Source: ACHHUZ5L2ceXPPd7H/GYt8Yk8shQXnDtO//Z6VFWpWHUYjVVoAhsbe2MtD8cwJSpEBsZz10/CW/v4Q==
X-Received: by 2002:a05:600c:2294:b0:3f4:2a69:408 with SMTP id 20-20020a05600c229400b003f42a690408mr4882243wmf.17.1683745655974;
        Wed, 10 May 2023 12:07:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11-20020adfe58b000000b002f22c44e974sm18102647wrm.102.2023.05.10.12.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 12:07:35 -0700 (PDT)
Message-Id: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 May 2023 19:07:34 +0000
Subject: [PATCH] merge-tree: load default git config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, christian.couder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'git merge-tree' command handles creating root trees for merges
without using the worktree. This is a critical operation in many Git
hosts, as they typically store bare repositories.

This builtin does not load the default Git config, which can have
several important ramifications.

In particular, one config that is loaded by default is
core.useReplaceRefs. This is typically disabled in Git hosts due to
the ability to spoof commits in strange ways.

Since this config is not loaded specifically during merge-tree, users
were previously able to use refs/replace/ references to make pull
requests that looked valid but introduced malicious content. The
resulting merge commit would have the correct commit history, but the
malicious content would exist in the root tree of the merge.

The fix is simple: load the default Git config in cmd_merge_tree().
This may also fix other behaviors that are effected by reading default
config. The only possible downside is a little extra computation time
spent reading config. The config parsing is placed after basic argument
parsing so it does not slow down usage errors.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    merge-tree: load default git config
    
    This patch was reviewed on the Git security list, but the impact seemed
    limited to Git forges using merge-ort to create merge commits. The
    forges represented on the list have deployed versions of this patch and
    thus are no longer vulnerable.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1530%2Fderrickstolee%2Fstolee%2Frefs-replace-upstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1530/derrickstolee/stolee/refs-replace-upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1530

 builtin/merge-tree.c  |  3 +++
 t/t4300-merge-tree.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index aa8040c2a6a..b8f8a8b5d9f 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -17,6 +17,7 @@
 #include "merge-blobs.h"
 #include "quote.h"
 #include "tree.h"
+#include "config.h"
 
 static int line_termination = '\n';
 
@@ -628,6 +629,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	if (argc != expected_remaining_argc)
 		usage_with_options(merge_tree_usage, mt_options);
 
+	git_config(git_default_config, NULL);
+
 	/* Do the relevant type of merge */
 	if (o.mode == MODE_REAL)
 		return real_merge(&o, merge_base, argv[0], argv[1], prefix);
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index c52c8a21fae..57c4f26e461 100755
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

base-commit: 5597cfdf47db94825213fefe78c4485e6a5702d8
-- 
gitgitgadget
