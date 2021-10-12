Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7944C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 14:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99125610C7
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 14:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbhJLOc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbhJLOc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 10:32:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD8C06161C
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 07:30:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e3so33928145wrc.11
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLujjciZZ2pT7WKD2jFZTNaF/vyzr1U9vbILgiSbAdY=;
        b=XaHSkj+4/c1f9JowODc4UhgGnk4Qzouq4hwXA3iR5P3MKA8d60vCkuPmO5y0yUR1Ua
         Xq7PuyUhUlOFY898N2XW6WULW7h02nXdZcBoUrjXiBGuqZSXmcTWkPklZG5T8dN4JiG0
         Mxm912H3Y7KBers8C9qihQ8lrwxuCERBXzA9/mVNoVmTzXRK+TmsL7sXjN9Ze1R8iJdN
         57cVmrfGaZEMS1NLeOA5TmChyfmcn/K0jnJLsYGLmoJHhRwWhiPDIsgDTk7HCvRIAGBf
         3idocQ72INPbr4xZxCY4EVcFuiB4W/Ph3kJcsp1yhn+Z0HySjRZSTQA9Pds45H5Nyczf
         6LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLujjciZZ2pT7WKD2jFZTNaF/vyzr1U9vbILgiSbAdY=;
        b=1OjXrQEPtoPio+Ez4URj10INAVtAAOWdcdbB0ysoVpxyViN0+m4lbd+L0+IHKVflda
         ayVs0LUUn60Ybvt4TaANlPrvCZ9zyseDUz8i3WBH8RNwimg9NgzH6bRYe0srL3ijGYEP
         vm5OUCu8fpJyAy7Jj4wYQNT48P9d9/yM9hNmnnsxLRSNtHS1FHC89G1pI9GjdCA/qz7R
         K/rV6l6E1FiBKSwcrQY7sVI0nhfv2vcpfVbBYQr4b/1dXy2aDzxLzRohDRbrx2IlVCzx
         0GAZTCbxS1i1aFsE8BMPTDZggsF3oYP7vzq4Si30amfinOdM9YEQ0uvV1HvYWo88hCgb
         UBUg==
X-Gm-Message-State: AOAM532aYg+iBJZp2uMlo88DdqyJF5iYwT1miSiv3ufnW7cZttCxK33I
        hSmh5dbsXbdTevimUDiXK9ZfcbhFdLmJ9g==
X-Google-Smtp-Source: ABdhPJyQlwClzHmOklv5g9lC5/w7EpRAFwaq7wKvJ5t+dQfeH+6ReMJzrTHir/+1bGp84NvDXfBYxg==
X-Received: by 2002:adf:a190:: with SMTP id u16mr32082100wru.114.1634049052982;
        Tue, 12 Oct 2021 07:30:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm3149791wmi.1.2021.10.12.07.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 07:30:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] unwritable tests: assert exact error output
Date:   Tue, 12 Oct 2021 16:30:48 +0200
Message-Id: <patch-v2-1.2-74bc5568c88-20211012T142950Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-v2-0.2-00000000000-20211012T142950Z-avarab@gmail.com>
References: <patch-2.2-56b20f6024b-20211009T133354Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20211012T142950Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for fixing a regression where we started emitting some
of these error messages twice, let's assert what the output from "git
commit" and friends is now in the case of permission errors.

As noted in [1] using test_expect_failure to mark up a TODO test has
some unexpected edge cases, e.g. we don't want to break --run=3 by
skipping the "test_lazy_prereq" here. This pattern allows us to test
just the test_cmp (and the "cat", which shouldn't fail) with the added
"test_expect_failure", we'll flip that to a "test_expect_success" in
the next commit.

1. https://lore.kernel.org/git/87tuhmk19c.fsf@evledraar.gmail.com/T/#u

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0004-unwritable.sh | 47 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 37d68ef03be..3627ce367c0 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -19,27 +19,66 @@ test_expect_success setup '
 test_expect_success POSIXPERM,SANITY 'write-tree should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	chmod a-w .git/objects .git/objects/?? &&
-	test_must_fail git write-tree
+	test_must_fail git write-tree 2>out.write-tree
+'
+
+test_lazy_prereq WRITE_TREE_OUT 'test -e "$TRASH_DIRECTORY"/out.write-tree'
+test_expect_success WRITE_TREE_OUT 'write-tree output on unwritable repository' '
+	cat >expect <<-\EOF &&
+	error: insufficient permission for adding an object to repository database .git/objects
+	fatal: git-write-tree: error building trees
+	EOF
+	test_cmp expect out.write-tree
 '
 
 test_expect_success POSIXPERM,SANITY,!SANITIZE_LEAK 'commit should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	chmod a-w .git/objects .git/objects/?? &&
-	test_must_fail git commit -m second
+	test_must_fail git commit -m second 2>out.commit
+'
+
+test_lazy_prereq COMMIT_OUT 'test -e "$TRASH_DIRECTORY"/out.commit'
+test_expect_failure COMMIT_OUT 'commit output on unwritable repository' '
+	cat >expect <<-\EOF &&
+	error: insufficient permission for adding an object to repository database .git/objects
+	error: Error building trees
+	EOF
+	test_cmp expect out.commit
 '
 
 test_expect_success POSIXPERM,SANITY 'update-index should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	echo 6O >file &&
 	chmod a-w .git/objects .git/objects/?? &&
-	test_must_fail git update-index file
+	test_must_fail git update-index file 2>out.update-index
+'
+
+test_lazy_prereq UPDATE_INDEX_OUT 'test -e "$TRASH_DIRECTORY"/out.update-index'
+test_expect_success UPDATE_INDEX_OUT 'update-index output on unwritable repository' '
+	cat >expect <<-\EOF &&
+	error: insufficient permission for adding an object to repository database .git/objects
+	error: file: failed to insert into database
+	fatal: Unable to process path file
+	EOF
+	test_cmp expect out.update-index
 '
 
 test_expect_success POSIXPERM,SANITY 'add should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	echo b >file &&
 	chmod a-w .git/objects .git/objects/?? &&
-	test_must_fail git add file
+	test_must_fail git add file 2>out.add
+'
+
+test_lazy_prereq ADD_OUT 'test -e "$TRASH_DIRECTORY"/out.add'
+test_expect_success ADD_OUT 'add output on unwritable repository' '
+	cat >expect <<-\EOF &&
+	error: insufficient permission for adding an object to repository database .git/objects
+	error: file: failed to insert into database
+	error: unable to index file '\''file'\''
+	fatal: updating files failed
+	EOF
+	test_cmp expect out.add
 '
 
 test_done
-- 
2.33.0.1567.g7b23ce7ed9e

