Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82E1C25B07
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiHIMJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiHIMJg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:09:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BB12496A
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:09:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 17so11132341plj.10
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 05:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Yv2qhpmBEk1Bg/+XwVRamZCKWZS5jjqJjW/IPe623Y=;
        b=bep7bVsmkv3O/nn++YNiHoXYam5jgQORh0oyPFa41TBmxzNG0V0a0E3CYpPezKrZ5L
         ZXVNMprotbkxLDHu1myErUw0cz9iJA1x919g0HeTfg3XRa9jp22E/0Ssn4+l8JDUGCLC
         rv9SQAngZJKnzOtoDG29/aXiNJ7G3XkYh48tyjckeBCeTYAgSuHQrvoi+UFIIlCrMJyp
         OJ1pyI68CDn5g/S0n29pmjIHi9XHfAmtHzWC5VNQJBF7is0ynz7nVoaWL0DmrDsoo+8e
         dk7V3CYJZA0GRucx8lpbhccG3opLxVrjbPIZ/f9V5ANEBDErkmhiBjAbY7BbRVMVxsOE
         DAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Yv2qhpmBEk1Bg/+XwVRamZCKWZS5jjqJjW/IPe623Y=;
        b=Q4ZLEzXt5EW+zwCid1uNcyna0VC53gPBh6ZS47ISpW3e9kUgFNiJjVSIdOUP23gF6Z
         nVCAwnTFkfebLcw5iMq7rhEUeXpjIt9Fi2+wmzVPia2QXI9SUf9jst4m2C5FT92rYJDo
         3unk/1yN5m5pUOA0+m01GgRXCvw1jFrGylBMlN2FQ/Xp1jp0Z1tiTpzcUYtdUSmfJEsT
         QxsCqryx1MidTEiuN15Us85Vba3eUGFs1SZy4T51GV9R9tRSRsuLcYcEfv+HngmlW+QU
         +ER4cOuc3IIk/HBrUs/Nazv0Xghi6GSS56DP5D1ESIXD8SdPyt0enuKZ13ug9lPt9rGA
         k2ww==
X-Gm-Message-State: ACgBeo2Qowl1e4EDau6xjPivykIVkMCGY1zXp4cuRUK1Ws8QYdzkvAbF
        WwhAtRmx8f6ikcuD7bbF4m+zKWgb0iTwgw==
X-Google-Smtp-Source: AA6agR5gFj0lamdlqtxF6t5DitR2bp5VQHAE0oKoUcLMdkDAjgYXq5qigBaAmxf3q3ARXnloWccUgg==
X-Received: by 2002:a17:90b:514:b0:1f5:59b2:fceb with SMTP id r20-20020a17090b051400b001f559b2fcebmr26144472pjz.82.1660046975069;
        Tue, 09 Aug 2022 05:09:35 -0700 (PDT)
Received: from ffyuanda.localdomain ([120.239.67.140])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b0016d10267927sm10511485pll.203.2022.08.09.05.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:09:34 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 1/9] t7002: add tests for moving from in-cone to out-of-cone
Date:   Tue,  9 Aug 2022 20:09:02 +0800
Message-Id: <20220809120910.2021413-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add corresponding tests to test that user can move an in-cone <source>
to out-of-cone <destination> when --sparse is supplied.

Such <source> can be either clean or dirty, and moving it results in
different behaviors:

A clean move should move <source> to <destination> in the index (do
*not* create <destination> in the worktree), then delete <source> from
the worktree.

A dirty move should move the <source> to the <destination>, both in the
working tree and the index, but should *not* remove the resulted path
from the working tree and should *not* turn on its CE_SKIP_WORKTREE bit.

Also make sure that if <destination> exists in the index (existing
check for if <destination> is in the worktree is not enough in
in-to-out moves), warn user against the overwrite. And Git should force
the overwrite when supplied with -f or --force.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/t7002-mv-sparse-checkout.sh | 198 ++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 71fe29690f..1ac78edde6 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -290,4 +290,202 @@ test_expect_success 'move sparse file to existing destination with --force and -
 	test_cmp expect sub/file1
 '
 
+test_expect_failure 'move clean path from in-cone to out-of-cone' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	setup_sparse_checkout &&
+
+	test_must_fail git mv sub/d folder1 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo "folder1/d" >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+
+	git mv --sparse sub/d folder1 2>stderr &&
+	test_must_be_empty stderr &&
+
+	test_path_is_missing sub/d &&
+	test_path_is_missing folder1/d &&
+	git ls-files -t >actual &&
+	! grep "^H sub/d\$" actual &&
+	grep "S folder1/d" actual
+'
+
+test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	setup_sparse_checkout &&
+	echo "sub/file1 overwrite" >sub/file1 &&
+	git add sub/file1 &&
+
+	test_must_fail git mv sub/file1 folder1 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo "folder1/file1" >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+
+	test_must_fail git mv --sparse sub/file1 folder1 2>stderr &&
+	echo "fatal: destination exists in the index, source=sub/file1, destination=folder1/file1" \
+	>expect &&
+	test_cmp expect stderr &&
+
+	git mv --sparse -f sub/file1 folder1 2>stderr &&
+	test_must_be_empty stderr &&
+
+	test_path_is_missing sub/file1 &&
+	test_path_is_missing folder1/file1 &&
+	git ls-files -t >actual &&
+	! grep "H sub/file1" actual &&
+	grep "S folder1/file1" actual &&
+
+	# compare file content before move and after move
+	echo "sub/file1 overwrite" >expect &&
+	git ls-files -s -- folder1/file1 | awk "{print \$2}" >oid &&
+	git cat-file blob $(cat oid) >actual &&
+	test_cmp expect actual
+'
+
+# This test is testing the same behavior as the
+# "move clean path from in-cone to out-of-cone overwrite" above.
+# The only difference is the <destination> changes from "folder1" to "folder1/file1"
+test_expect_failure 'move clean path from in-cone to out-of-cone file overwrite' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	setup_sparse_checkout &&
+	echo "sub/file1 overwrite" >sub/file1 &&
+	git add sub/file1 &&
+
+	test_must_fail git mv sub/file1 folder1/file1 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo "folder1/file1" >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+
+	test_must_fail git mv --sparse sub/file1 folder1/file1 2>stderr &&
+	echo "fatal: destination exists in the index, source=sub/file1, destination=folder1/file1" \
+	>expect &&
+	test_cmp expect stderr &&
+
+	git mv --sparse -f sub/file1 folder1/file1 2>stderr &&
+	test_must_be_empty stderr &&
+
+	test_path_is_missing sub/file1 &&
+	test_path_is_missing folder1/file1 &&
+	git ls-files -t >actual &&
+	! grep "H sub/file1" actual &&
+	grep "S folder1/file1" actual &&
+
+	# compare file content before move and after move
+	echo "sub/file1 overwrite" >expect &&
+	git ls-files -s -- folder1/file1 | awk "{print \$2}" >oid &&
+	git cat-file blob $(cat oid) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'move directory with one of the files overwrite' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	mkdir -p folder1/dir &&
+	touch folder1/dir/file1 &&
+	git add folder1 &&
+	git sparse-checkout set --cone sub &&
+
+	echo test >sub/dir/file1 &&
+	git add sub/dir/file1 &&
+
+	test_must_fail git mv sub/dir folder1 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo "folder1/dir/e" >>expect &&
+	echo "folder1/dir/file1" >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+
+	test_must_fail git mv --sparse sub/dir folder1 2>stderr &&
+	echo "fatal: destination exists in the index, source=sub/dir/file1, destination=folder1/dir/file1" \
+	>expect &&
+	test_cmp expect stderr &&
+
+	git mv --sparse -f sub/dir folder1 2>stderr &&
+	test_must_be_empty stderr &&
+
+	test_path_is_missing sub/dir/file1 &&
+	test_path_is_missing sub/dir/e &&
+	test_path_is_missing folder1/file1 &&
+	git ls-files -t >actual &&
+	! grep "H sub/dir/file1" actual &&
+	! grep "H sub/dir/e" actual &&
+	grep "S folder1/dir/file1" actual &&
+
+	# compare file content before move and after move
+	echo test >expect &&
+	git ls-files -s -- folder1/dir/file1 | awk "{print \$2}" >oid &&
+	git cat-file blob $(cat oid) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'move dirty path from in-cone to out-of-cone' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	setup_sparse_checkout &&
+	echo "modified" >>sub/d &&
+
+	test_must_fail git mv sub/d folder1 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo "folder1/d" >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+
+	git mv --sparse sub/d folder1 2>stderr &&
+
+	test_path_is_missing sub/d &&
+	test_path_is_file folder1/d &&
+	git ls-files -t >actual &&
+	! grep "^H sub/d\$" actual &&
+	grep "H folder1/d" actual
+'
+
+test_expect_failure 'move dir from in-cone to out-of-cone' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	setup_sparse_checkout &&
+
+	test_must_fail git mv sub/dir folder1 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo "folder1/dir/e" >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+
+	git mv --sparse sub/dir folder1 2>stderr &&
+	test_must_be_empty stderr &&
+
+	test_path_is_missing folder1 &&
+	git ls-files -t >actual &&
+	! grep "H sub/dir/e" actual &&
+	grep "S folder1/dir/e" actual
+'
+
+test_expect_failure 'move partially-dirty dir from in-cone to out-of-cone' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	setup_sparse_checkout &&
+	touch sub/dir/e2 sub/dir/e3 &&
+	git add sub/dir/e2 sub/dir/e3 &&
+	echo "modified" >>sub/dir/e2 &&
+	echo "modified" >>sub/dir/e3 &&
+
+	test_must_fail git mv sub/dir folder1 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo "folder1/dir/e" >>expect &&
+	echo "folder1/dir/e2" >>expect &&
+	echo "folder1/dir/e3" >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+
+	git mv --sparse sub/dir folder1 2>stderr &&
+
+	test_path_is_missing folder1/dir/e &&
+	test_path_is_file folder1/dir/e2 &&
+	test_path_is_file folder1/dir/e3 &&
+	git ls-files -t >actual &&
+	! grep "H sub/dir/e" actual &&
+	! grep "H sub/dir/e2" actual &&
+	! grep "H sub/dir/e3" actual &&
+	grep "S folder1/dir/e" actual &&
+	grep "H folder1/dir/e2" actual &&
+	grep "H folder1/dir/e3" actual
+'
+
 test_done
-- 
2.37.0

