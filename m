Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49816C25B08
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 03:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiHEDF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 23:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiHEDFx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 23:05:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD73563A6
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 20:05:51 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 12so1589498pga.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OP4gxRN95WA3vVC9PD6S/XeOgjAFyckDw637atYtixo=;
        b=eVgaFKjwHlPFAvCWnbrVzAo6yqvmqLhQEfTJMQVm8GElXj/efxDVbFO2hC0Hs7tGL8
         fnTSX9LjemPEpTgSDJ8G0AZuu3LMKvEYZRTitkEdTxso5Q6OiY2ELZtkafTIGUrama3f
         TMMFA3YllCgt986a/1dGsYlO6HGzxyAsI0tk+KDXxdwQVoW2cZd1c7/FO6gpUGccNo36
         aQ9NzuEGcBMIOXjSeOJq34Si3z28mqjLydvuCP3Vu1EeFuZZjJd4aEGDEQm+L6pri6/2
         emV3NPOow+QpGXKaCR8VBSWcRCCZoi3gVzAYl05OpdAm62UaiZ3mtakknWPyHckOpEK2
         fmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OP4gxRN95WA3vVC9PD6S/XeOgjAFyckDw637atYtixo=;
        b=DeVikznngmQrO3bECMTJp3y/DOMkfEmvQxxSdnBaGU2nfEhjfM6m+vcMncBz4TY47l
         VP0TyOVQGNhXLX5Sw5QiUfgwxvTEqOg2feT606Og3NkWV3ustPr1z7NMW3vo81Gk7yG1
         JQM+D60wKqgxRSqwpYcSzG/a+MIrdEQ20ypv3qzQpkk25hnSPJM70ygnBwX02QJQvK6G
         3R/IjXVqssU8hflJfxL7k/xMx8lxKKrK3b2rSrNkLjxaazFd0qR4NNApPYEwXB4b4Op6
         YGyYBT4SSCrwyt1fovi40FGksMdN0OrQj64d6zADKpd06ZdcnWhrbtJvU7Y5yW6Y4HSq
         OUqQ==
X-Gm-Message-State: ACgBeo3WF/3JpfEa2qj+vPbfKG/fMft+DmrZ4qg+ULV32bot0cJ/eALc
        hHrLalIbreTxypE98IaKR2XSIBGNr5Y3VRxM
X-Google-Smtp-Source: AA6agR4Eox1QErelP4RjE26UK6WjXv3WqCDhuwCHgyEbVxJNHgkdut3NRglb6jSbotxDo98Y310Y0w==
X-Received: by 2002:a05:6a00:1ad3:b0:52b:37ac:4435 with SMTP id f19-20020a056a001ad300b0052b37ac4435mr4845787pfv.25.1659668751110;
        Thu, 04 Aug 2022 20:05:51 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.229.239])
        by smtp.gmail.com with ESMTPSA id i6-20020a654d06000000b0040df0c9a1aasm570234pgt.14.2022.08.04.20.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:05:50 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 1/9] t7002: add tests for moving from in-cone to out-of-cone
Date:   Fri,  5 Aug 2022 11:05:20 +0800
Message-Id: <20220805030528.1535376-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
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

Also make sure that if <destination> exists in the index (existing
check for if <destination> is in the worktree is not enough in
in-to-out moves), warn user against the overwrite. And Git should force
the overwrite when supplied with -f or --force.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/t7002-mv-sparse-checkout.sh | 122 ++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 71fe29690f..9b3a9ab4c3 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -290,4 +290,126 @@ test_expect_success 'move sparse file to existing destination with --force and -
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

