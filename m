Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6D3C4167B
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 12:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiLTMnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiLTMnE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 07:43:04 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D680C1CFE2
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m19so8590741wms.5
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDeV4GVeBwo8GeLUmGbBP9Kp3rbdYeGp+Yoo2c8FYXk=;
        b=QaTinUA8eSZtBULmnY/MXDb8YzqbyPEjfD/ZqYFE0ffRNWKPKMYZj5qib+SnVrG3Xf
         vC/uCMbRn7+TiGzBeY0tupD6b8h84PcahoF2RVaQL5jkvegQskEmBqICt18sKWGGtX5y
         tPoLg5d1bpbPUoe8UPcCBxrWACMXC/yJ9QnzZAbs99olSG6Uh0Thp2HHGkuptzGQH+Ty
         1ZMyDgSMOijuPZXYEe2CqNuZ/tH5DLNTWYwvlPq7NIeyYXyEBvGO1RTHYFg3fnQRY2I2
         BVUOataKXayt+ec9EjASUsx2PPrHxE9suSwso14OZhUnY7eTXdw6kl+i3BUK+ZT02H4F
         9frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDeV4GVeBwo8GeLUmGbBP9Kp3rbdYeGp+Yoo2c8FYXk=;
        b=gXJbBdYBfmPDk3L/YtMfWwoxX12P4JppLIN01/wPBjBRcGOxDwyc6l8qpDBEDPvOaF
         mX243FnCRbnS3SWClnG1qn3SMeosxLR0LeIYmJ6V1fB1Kf3eqVFDfXcW9r4dKh9EBTei
         Xai4VDYI+98owofUzwSQ2ocJizphIFoLP7+8cbx13LjznuLhtN4zosoipkUIY72/isWx
         MtyZ3jk39D8DIzt/eJPzEFWyKhJFxj+tdK0OnhU25ewbWl1ycLAajgja927wrDXU6YFu
         6SbWiKOPMz3NOc+U8KvMc5sXwsmgR7FIKaFjjy5ipc1zEmJNaUpvmpRWAa8FIejGFMu7
         bvkA==
X-Gm-Message-State: AFqh2krhFUY59JbxDDbylbhhR+tONKGbbIwoHFRGcdZN5IddM0OF1NMi
        zZqQl+TDzvKSrF/n8z7BMxRWWsjHmtZXsg==
X-Google-Smtp-Source: AMrXdXthASjzYWR+txkd7AtwxvF9N5HFsT/fHQY8LjPKAMbUfARlIb8S+kRe+riovX2seFjEyDX6xg==
X-Received: by 2002:a05:600c:5124:b0:3d6:10e:68a8 with SMTP id o36-20020a05600c512400b003d6010e68a8mr973286wms.0.1671540003273;
        Tue, 20 Dec 2022 04:40:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003d355ad9bb7sm9630759wmq.20.2022.12.20.04.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:40:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/9] read-tree + fetch tests: test failing "--super-prefix" interaction
Date:   Tue, 20 Dec 2022 13:39:49 +0100
Message-Id: <patch-v5-2.9-5fa05492b62-20221220T104519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.g08bce9674be
In-Reply-To: <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Ever since "git fetch --refetch" was introduced in 0f5e8851737 (Merge
branch 'rc/fetch-refetch', 2022-04-04) the test being added here would
fail. This is because "restore" will "read-tree .. --reset <hash>",
which will in turn invoke "fetch". The "fetch" will then die with:

	fatal: fetch doesn't support --super-prefix

This edge case and other "--super-prefix" bugs will be fixed in
subsequent commits, but let's first add a "test_expect_failure" test
for it. It passes until the very last command in the test.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5616-partial-clone.sh | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 037941b95d2..2846ec6629c 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -644,6 +644,49 @@ test_expect_success 'repack does not loosen promisor objects' '
 	grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
+test_expect_failure 'lazy-fetch in submodule succeeds' '
+	# setup
+	test_config_global protocol.file.allow always &&
+
+	test_when_finished "rm -rf src-sub" &&
+	git init src-sub &&
+	git -C src-sub config uploadpack.allowfilter 1 &&
+	git -C src-sub config uploadpack.allowanysha1inwant 1 &&
+
+	# This blob must be missing in the subsequent commit.
+	echo foo >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule one" &&
+	SUB_ONE=$(git -C src-sub rev-parse HEAD) &&
+
+	echo bar >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule two" &&
+	SUB_TWO=$(git -C src-sub rev-parse HEAD) &&
+
+	test_when_finished "rm -rf src-super" &&
+	git init src-super &&
+	git -C src-super config uploadpack.allowfilter 1 &&
+	git -C src-super config uploadpack.allowanysha1inwant 1 &&
+	git -C src-super submodule add ../src-sub src-sub &&
+
+	git -C src-super/src-sub checkout $SUB_ONE &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject one" &&
+
+	git -C src-super/src-sub checkout $SUB_TWO &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject two" &&
+
+	# the fetch
+	test_when_finished "rm -rf client" &&
+	git clone --filter=blob:none --also-filter-submodules \
+		--recurse-submodules "file://$(pwd)/src-super" client &&
+
+	# Trigger lazy-fetch from the superproject
+	git -C client restore --recurse-submodules --source=HEAD^ :/
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.39.0.1071.g97ce8966538

