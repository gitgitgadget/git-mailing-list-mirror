Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEE4C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 02:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiF3CiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiF3Chx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 22:37:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BD224BFD
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:37:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s206so8127453pgs.3
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRW9QNmQJR07WHGrS+cRatkXvEi8pyOQnwtXDuaN2Vs=;
        b=BRuqwAkFeU522GDRD8NDiCjNw9nZugAtJYRcRecMgTG3zyqjm1QdzCF7xh87YkU1jn
         gyHp2jOZcl7b3mQQMclaVkkctBBo32MluwFqu4FnXyqRono6dMEnKSy7tEgqhycOx1gV
         zkeeY6SoSqokGM8AtxGePA9CMXanMVR0QKEltMiMxvyu7TxXpfZCg27EGTkfkZhabzxg
         ZaX8Rdl9PpzxAra68e7r/rXmivnQhYcsRM8U09eR6qSsB1JTkB9q5SWp7aBxfaMBmPmc
         N0XRCwdIWfk1UFX0WPO9usUOebq46m8Cs7fKP7kG5zc51481lj3K+vqxCpBs4mcX+iGs
         xa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRW9QNmQJR07WHGrS+cRatkXvEi8pyOQnwtXDuaN2Vs=;
        b=taUQTU2yqGtjRib+lAdl/t5a5yJwZ9MgDWIRix5u8qi5r81jNVYRVK1uyhzblIJ39h
         VFf9688hZP7c0P92mTZcEwrIoPf6VVzpxJCdssYe1L9aVNvh2hKTFZ5A4o30Eaw6jBOO
         +V/HM0wJRp82m32+MmDFKg1P9yT/coyd8ef8s48ObTBu4cn4/2J/Ap2orcLhsIBdnBzG
         4JFAcAgsKuf0Enu4rD94UTNm/Xu2+r8ru3nswaU0s4iYPf3mBrt837i/dPP44KJBVjOq
         HPjceIQNV4sTisLvlN4ez24FkyW7JbLN1hjWUv7medKViULm2+g53dTSWpLTotxePPSh
         myKg==
X-Gm-Message-State: AJIora8OsajOJGKVmiCliu3cJfSfg37Mwr8l1hZimg0Cc/BJAV55fwQV
        DIucrhYPNSSGEkJZA+TbYt2RLu0Iqf8=
X-Google-Smtp-Source: AGRyM1vLOS8P6wW+9sEgEEbGDmfVaZ3jqCgq4kYevoPC8WyG2yx6U2oTyhNt39vGjhayyhOnr0ANyQ==
X-Received: by 2002:aa7:947a:0:b0:528:ba5:290c with SMTP id t26-20020aa7947a000000b005280ba5290cmr2526951pfq.55.1656556671858;
        Wed, 29 Jun 2022 19:37:51 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.226.29])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm12157509pls.100.2022.06.29.19.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 19:37:51 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 2/8] t1092: mv directory from out-of-cone to in-cone
Date:   Thu, 30 Jun 2022 10:37:31 +0800
Message-Id: <20220630023737.473690-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test for "mv: add check_dir_in_index() and solve general dir check
issue" in this series.

This change tests the following:

1. mv <source> as a directory on the sparse index boundary (where it
   would be a sparse directory in a sparse index).
2. mv <source> as a directory which is deeper than the boundary (so
   the sparse index would expand in the cache_name_pos() method).

These tests can be written now for correctness, but later the first case
can be updated to use the 'ensure_not_expanded' helper in t1092.

Suggested-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f9f8c988bb..5eef799e25 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1828,4 +1828,29 @@ test_expect_success 'checkout behaves oddly with df-conflict-2' '
 	test_cmp full-checkout-err sparse-index-err
 '
 
+test_expect_failure 'mv directory from out-of-cone to in-cone' '
+	init_repos &&
+
+	# <source> as a sparse directory (or SKIP_WORKTREE_DIR without enabling
+	# sparse index).
+	test_all_match git mv --sparse folder1 deep &&
+	test_all_match git status --porcelain=v2 &&
+	test_sparse_match git ls-files -t &&
+	git -C sparse-checkout ls-files -t >actual &&
+	grep -e "H deep/folder1/0/0/0" actual &&
+	grep -e "H deep/folder1/0/1" actual &&
+	grep -e "H deep/folder1/a" actual &&
+
+	test_all_match git reset --hard &&
+
+	# <source> as a directory deeper than sparse index boundary (where
+	# sparse index will expand).
+	test_sparse_match git mv --sparse folder1/0 deep &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_sparse_match git ls-files -t &&
+	git -C sparse-checkout ls-files -t >actual &&
+	grep -e "H deep/0/0/0" actual &&
+	grep -e "H deep/0/1" actual
+'
+
 test_done
-- 
2.35.1

