Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB2BC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46EE460FF3
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhGTUBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhGTTeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:34:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DE0C0613E4
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d2so27369940wrn.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V5tQXeDD5Ip25tVwsuX5B5DgwU8YJNO0LVj8v6MyCLw=;
        b=QK8poySLxDwdZRdy/2iVWDWsF96i7hW1CrSrKdF/tAMk+hbOhZWmeSqTq9t9Roqkr/
         F/BHhdFZg/GJ7aL0Krtckjrq1QCYH+2pLd+NceAJs0++DId3kZ1M+xrui1tXEq+I8eQO
         3tEXj7tVYC90irhdiiI+IBCW8vhYaKXOxvqzCcEtLFkCT9kEcuI3KYIa7ffffQOmqv9p
         VaNDSGYBU8YfkAbOD4o4wW6bPG35E7HfjUv8WheKzUBDxBKZkIXiZEQpcUySRBi+6NHK
         rSpJMEwI7Hsnac23boqVClwPvviMANwOqMz41Lysw5Z9Opv6u56hYPR+lGyL8+JdHnHo
         nhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V5tQXeDD5Ip25tVwsuX5B5DgwU8YJNO0LVj8v6MyCLw=;
        b=SHxF4lUo3XYutF/ypSk+yVEflUa20KbRAANpkYHN8seNa6GCvQ1zhlK7LFofCkgxbk
         zdcMeixvDHe3LEYMQiQR/lAtExBwL05DKv5iZesVVk0+skG5b0MXni9LmasFI+Z/COat
         3Z65I9goeUxCmzTTg2pgv/xvI9EQdJX8BGBLz5GCgx6JWooRxTRXG3EESkc4BPS2QfYa
         HbbAh+M1RXXCw2uKS1gLYtJIzH38ELCUvfS2XZujG8Zcce9Ro/pKibgSeW7M0tQneLj0
         5g7A5Ar97FFHmwKJdS6mgIWGasSOnkcq/PpOQOjFLmruIMhFjk5tyy/HMz0rTiPDpl++
         cRaw==
X-Gm-Message-State: AOAM532W1IfOG2wzATpNQ6ArjG80lIMnRfaVw3dbo5lBcBxprqoIIK7C
        OWfdObT0z892t2uudZ1q43hWoSbmbt4=
X-Google-Smtp-Source: ABdhPJxstizRdWRiA696OoVsfMpYlpmHj8zXwKZJ+QZ6hnDPVQFdOwOEyCiWEXzr+6bM37NJJvOdjg==
X-Received: by 2002:adf:e805:: with SMTP id o5mr5665784wrm.321.1626812086382;
        Tue, 20 Jul 2021 13:14:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm28823090wrg.18.2021.07.20.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:14:46 -0700 (PDT)
Message-Id: <71e301501c88399711a1bf8515d1747e92cfbb9b.1626812081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
        <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 20:14:41 +0000
Subject: [PATCH v2 7/7] unpack-trees: resolve sparse-directory/file conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When running unpack_trees() with a sparse index, we attempt to operate
on the index without expanding the sparse directory entries. Thus, we
operate by manipulating entire directories and passing them to the
unpack function. In the case of the 'git checkout' command, this is the
twoway_merge() function.

There are several cases in twoway_merge() that handle different
situations. One new one to add is the case of a directory/file conflict
where the directory is sparse. Before the sparse index, such a conflict
would appear as a list of file additions and deletions. Now,
twoway_merge() initializes 'current', 'oldtree', and 'newtree' from
src[0], src[1], and src[2], then sets 'oldtree' to NULL because it is
equal to the df_conflict_entry. The way to determine that we have a
directory/file conflict is to test that 'current' and 'newtree' disagree
on being sparse directory entries.

When we are in this case, we want to resolve the situation by calling
merged_entry(). This allows replacing the 'current' entry with the
'newtree' entry. This is important for cases where we want to run 'git
checkout' across the conflict and have the new HEAD represent the new
file type at that path. The first NEEDSWORK comment dropped in t1092
demonstrates this necessary behavior.

However, we still are in a confusing state when 'current' corresponds to
a staged change within a sparse directory that is not present at HEAD.
This should be atypical, because it requires adding a change outside of
the sparse-checkout cone, but it is possible. Since we are unable to
determine that this is a staged change within twoway_merge(), we cannot
add a case to reject the merge at this point. I believe this is due to
the use of df_conflict_entry in the place of 'oldtree' instead of using
the valud at HEAD, which would provide some perspective to this
decision. Any change that would allow this differentiation for staged
entries would need to involve information further up in unpack_trees().

That work should be done, sometime, because we are further confusing the
behavior of a directory/file conflict when staging a change in the
directory. The two cases 'checkout behaves oddly with df-conflict-?' in
t1092 demonstrate that even without a sparse-checkout, Git is not
consistent in its behavior. Neither of the two options seems correct,
either. This change makes the sparse-index behave differently than the
typcial sparse-checkout case, but it does match the full checkout
behavior in the df-conflict-2 case.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 24 ++++++++++++------------
 unpack-trees.c                           | 11 +++++++++++
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 79b4a8ce199..91e30d6ec22 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -396,14 +396,14 @@ test_expect_success 'diff with renames and conflicts' '
 	done
 '
 
-# NEEDSWORK: the sparse-index fails to move HEAD across a directory/file
-# conflict such as when checking out df-conflict-1 and df-conflict2.
 test_expect_success 'diff with directory/file conflicts' '
 	init_repos &&
 
 	for branch in rename-out-to-out \
 		      rename-out-to-in \
 		      rename-in-to-out \
+		      df-conflict-1 \
+		      df-conflict-2 \
 		      fd-conflict
 	do
 		git -C full-checkout reset --hard &&
@@ -667,10 +667,7 @@ test_expect_success 'checkout behaves oddly with df-conflict-1' '
 	git -C sparse-checkout checkout df-conflict-1 \
 		1>sparse-checkout-out \
 		2>sparse-checkout-err &&
-
-	# NEEDSWORK: the sparse-index case refuses to change HEAD here,
-	# but for the wrong reason.
-	test_must_fail git -C sparse-index checkout df-conflict-1 \
+	git -C sparse-index checkout df-conflict-1 \
 		1>sparse-index-out \
 		2>sparse-index-err &&
 
@@ -684,7 +681,11 @@ test_expect_success 'checkout behaves oddly with df-conflict-1' '
 	test_cmp expect full-checkout-out &&
 	test_cmp expect sparse-checkout-out &&
 
+	# The sparse-index reports no output
+	test_must_be_empty sparse-index-out &&
+
 	# stderr: Switched to branch df-conflict-1
+	test_cmp full-checkout-err sparse-checkout-err &&
 	test_cmp full-checkout-err sparse-checkout-err
 '
 
@@ -719,17 +720,15 @@ test_expect_success 'checkout behaves oddly with df-conflict-2' '
 	git -C sparse-checkout checkout df-conflict-2 \
 		1>sparse-checkout-out \
 		2>sparse-checkout-err &&
-
-	# NEEDSWORK: the sparse-index case refuses to change HEAD
-	# here, but for the wrong reason.
-	test_must_fail git -C sparse-index checkout df-conflict-2 \
+	git -C sparse-index checkout df-conflict-2 \
 		1>sparse-index-out \
 		2>sparse-index-err &&
 
 	# The full checkout deviates from the df-conflict-1 case here!
 	# It drops the change to folder1/larger-content and leaves the
-	# folder1 path as-is on disk.
+	# folder1 path as-is on disk. The sparse-index behaves the same.
 	test_must_be_empty full-checkout-out &&
+	test_must_be_empty sparse-index-out &&
 
 	# In the sparse-checkout case, the checkout deletes the folder1
 	# file and adds the folder1/larger-content file, leaving all other
@@ -741,7 +740,8 @@ test_expect_success 'checkout behaves oddly with df-conflict-2' '
 	test_cmp expect sparse-checkout-out &&
 
 	# Switched to branch df-conflict-1
-	test_cmp full-checkout-err sparse-checkout-err
+	test_cmp full-checkout-err sparse-checkout-err &&
+	test_cmp full-checkout-err sparse-index-err
 '
 
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 0a5135ab397..309c1352f5d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2619,6 +2619,17 @@ int twoway_merge(const struct cache_entry * const *src,
 			 same(current, oldtree) && !same(current, newtree)) {
 			/* 20 or 21 */
 			return merged_entry(newtree, current, o);
+		} else if (current && !oldtree && newtree &&
+			   S_ISSPARSEDIR(current->ce_mode) != S_ISSPARSEDIR(newtree->ce_mode) &&
+			   ce_stage(current) == 0) {
+			/*
+			 * This case is a directory/file conflict across the sparse-index
+			 * boundary. When we are changing from one path to another via
+			 * 'git checkout', then we want to replace one entry with another
+			 * via merged_entry(). If there are staged changes, then we should
+			 * reject the merge instead.
+			 */
+			return merged_entry(newtree, current, o);
 		} else
 			return reject_merge(current, o);
 	}
-- 
gitgitgadget
