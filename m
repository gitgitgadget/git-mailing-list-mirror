Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E404DC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 14:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiGSOK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbiGSOKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 10:10:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7663558C5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:28:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s21so14707448pjq.4
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZYBSi74GfGuu3qxJxRKdH6JFmWGBv1dEXqpD4MhYV+c=;
        b=eeByAxzFkqsyfHkIBj0bfpYE8HEKmGZ2MBG6To+lUVoqQ+1eHxofnQbPEhD/i6ZSl7
         IBwUmZF/UYZ0yheCuDAOMWIHSYJ3SUkXY9/GcnJHY/GFsYvIbkKUkcLCdsW+sHvIcOPE
         x2PVYTqjh3hkdUPB0PrVRAGA9L2t0LCOy4mZCAFiS8L/YKFNYr3KnzCP/+p8/+UcnCYw
         EqjevzbbyVqxc+aBZBb8YWImV7Tu3q0YcIFXi/2k1eWSzaUbNAv9HJ6sTO/fHhEifOi0
         2faZcmWRisID2jW3UF4U8STpDKgWGJapBHumBprDNcySyd13SZZAH6E9rBKxpIRNXFsn
         6cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZYBSi74GfGuu3qxJxRKdH6JFmWGBv1dEXqpD4MhYV+c=;
        b=CpsPY8snHH9TRJRt7BPWs/ZApuXnqSRLHN3KWsC99YdhrCEjBFD4h4At2eYOFMRQEB
         ucUs6AsfO31z5dpzyIF7rAbl17Acqu64u7nIByEMwy91OLKoPuN0GgyeevPqQv3JfWeQ
         HrObfIMgb336eSOZ7arjUzx+2LWm+M7FPuT8Y2HAvzGqHPF90ODSMDQKSRfC0xGJVoRn
         oMtfFrhm7WVG944teL+lsjkLMapAzpgOg3TqEKBHsZhj87HEfTjj03GisUuFoaOwZUlT
         OgBVdIKauvu+C46QuLtYlagBqWyJoVXsv1b5mEP52cOtnjObjphGqZk9ZiXFKR/9Mjup
         hlww==
X-Gm-Message-State: AJIora+Zh1k4Kvc7GZ3dzGHMsssI0/RR3qh2tqz2pdbEgz85MJ/wG8EE
        DesphSc53tp5KvkJMPiI/Y4rx6xKEbze5uc9
X-Google-Smtp-Source: AGRyM1sp7GMiR+iYoE//FxIaWJ2f3tX6IOVVQXttYGcRoNaN/0h7iVF40L3X8VdLKmnkYF45mptaVg==
X-Received: by 2002:a17:902:e84e:b0:16c:773:9daf with SMTP id t14-20020a170902e84e00b0016c07739dafmr33521958plg.43.1658237335114;
        Tue, 19 Jul 2022 06:28:55 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.227.243])
        by smtp.gmail.com with ESMTPSA id r9-20020a170902be0900b0016be834d544sm624424pls.237.2022.07.19.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 06:28:54 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 1/7] t7002: add tests for moving from in-cone to out-of-cone
Date:   Tue, 19 Jul 2022 21:28:03 +0800
Message-Id: <20220719132809.409247-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add corresponding tests to test that user can move an in-cone <source>
to out-of-cone <destination> when --sparse is supplied.

Such <source> can be either clean or dirty, and moving it results in
different behaviors:

A clean move should move the <source> to the <destination>, both in the
working tree and the index, then remove the resulted path from the
working tree, and turn on its CE_SKIP_WORKTREE bit.

A dirty move should move the <source> to the <destination>, both in the
working tree and the index, but should *not* remove the resulted path
from the working tree and should *not* turn on its CE_SKIP_WORKTREE bit.
Instead advise user to "git add" this path and run "git sparse-checkout
reapply" to re-sparsify that path.

Also make sure that if <destination> exists in the index (existing
check for if <destination> is in the worktree is not enough in
in-to-out moves), warn user against the overwrite. And Git should force
the overwrite when supplied with -f or --force.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/t7002-mv-sparse-checkout.sh | 148 +++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 1 deletion(-)

diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 71fe29690f..c27fcdbfd0 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -28,12 +28,25 @@ test_expect_success 'setup' "
 	updated in the index:
 	EOF
 
-	cat >sparse_hint <<-EOF
+	cat >sparse_hint <<-EOF &&
 	hint: If you intend to update such entries, try one of the following:
 	hint: * Use the --sparse option.
 	hint: * Disable or modify the sparsity rules.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
+
+	cat >dirty_error_header <<-EOF &&
+	The following paths have been moved outside the
+	sparse-checkout definition but are not sparse due to local
+	modifications.
+	EOF
+
+	cat >dirty_hint <<-EOF
+	hint: To correct the sparsity of these paths, do the following:
+	hint: * Use \"git add --sparse <paths>\" to update the index
+	hint: * Use \"git sparse-checkout reapply\" to apply the sparsity rules
+	hint: Disable this message with \"git config advice.updateSparsePath false\"
+	EOF
 "
 
 test_expect_success 'mv refuses to move sparse-to-sparse' '
@@ -290,4 +303,137 @@ test_expect_success 'move sparse file to existing destination with --force and -
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
+	! grep -x "H sub/d" actual &&
+	grep -x "S folder1/d" actual
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
+	! grep -x "H sub/file1" actual &&
+	grep -x "S folder1/file1" actual &&
+
+	# compare file content before move and after move
+	echo "sub/file1 overwrite" >expect &&
+	git ls-files -s -- folder1/file1 | awk "{print \$2}" >oid &&
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
+	cat dirty_error_header >expect &&
+	echo "folder1/d" >>expect &&
+	cat dirty_hint >>expect &&
+	test_cmp expect stderr &&
+
+	test_path_is_missing sub/d &&
+	test_path_is_file folder1/d &&
+	git ls-files -t >actual &&
+	! grep -x "H sub/d" actual &&
+	grep -x "H folder1/d" actual
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
+	test_path_is_missing sub/dir &&
+	test_path_is_missing folder1 &&
+	git ls-files -t >actual &&
+	! grep -x "H sub/dir/e" actual &&
+	grep -x "S folder1/dir/e" actual
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
+	cat dirty_error_header >expect &&
+	echo "folder1/dir/e2" >>expect &&
+	echo "folder1/dir/e3" >>expect &&
+	cat dirty_hint >>expect &&
+	test_cmp expect stderr &&
+
+	test_path_is_missing sub/dir &&
+	test_path_is_missing folder1/dir/e &&
+	test_path_is_file folder1/dir/e2 &&
+	test_path_is_file folder1/dir/e3 &&
+	git ls-files -t >actual &&
+	! grep -x "H sub/dir/e" actual &&
+	! grep -x "H sub/dir/e2" actual &&
+	! grep -x "H sub/dir/e3" actual &&
+	grep -x "S folder1/dir/e" actual &&
+	grep -x "H folder1/dir/e2" actual &&
+	grep -x "H folder1/dir/e3" actual
+'
+
 test_done
-- 
2.37.0

