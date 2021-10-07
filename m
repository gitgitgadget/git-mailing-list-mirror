Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260D5C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA80610A2
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbhJGKEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 06:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbhJGKDr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 06:03:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9025C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:01:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s15so17342946wrv.11
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLwdtBxAy3TuMS8O0Q2YjANTkopE8aeEZv9gddah1GU=;
        b=kk8G98L7p+5q4PoSyz4nqjsVWVl/C78qE1v7U1ORQrn4eAtSnflozfo4mkghfxq2Vr
         wgyy9Dc+8NxL5c7jzvZtIV+7AdHI4A9+RKCWudJgr3zNt8ZmoazrI1yLlHpLjfHIxhH6
         m/j7N4xkAsuRo/WFvh1gJYIgaq3c+u36h5J1EW3WrZ3vA8VyWB8H2XzyPh6uDqCGI02p
         JQ6sBCWYJ7Xr7aqsklzSWr5Df8WxAZLdkkod2P4QzDUCs8gIlXS8MHXzXst43GTF018g
         8g4btWQO1Mjp5p/QIK5DsqKofdHz6HVJ+W77HyC1Iy234XDa17ifa1+woLIaA4tMNzD0
         yUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLwdtBxAy3TuMS8O0Q2YjANTkopE8aeEZv9gddah1GU=;
        b=hc36wTWiCxt7973nd5eHDXrJxjS8y3jn0wySbuL5BxXktLLTsX3loFEJUle6rvDPMq
         Jr5qRhsyIcMUuN7oFmBx1weztg4kZEdmsu6M5sB7Q1W2zqvLmAwqEDfvc1GM2h85eGDR
         boaZw3gp5Us5PGd90ghtAWtk6P5gm9tr+Ji29JNYL9/hvjyptyeEX+2Ah0Vp/WlVaFqg
         LC+QiICE1ZHqnOsNPiY/q6b1SXPbWI4He8I9zJygqQFMkiWmQScCfCVkee5zxykFwCfX
         yUlkFqZgbqkMNmwa+vy+Ql9ZGYasXxYkL/4826w9OTtE2P0jqiOxUXI/jj983UHY5gBd
         WHCg==
X-Gm-Message-State: AOAM531X2yrhAMWPE7suat2AySEnfcKX9CIXH3sD1ar+vMJA9LhCvb4a
        Z94HtV/YSjWbMh2brzagTyEfzoMJmhq2Ow==
X-Google-Smtp-Source: ABdhPJzi21+asQG2Ag5cnO8s5dbSPkdHFjwRMboZkKTrsBm6bIYdBEPz+VEqkq7Qlhy/iBB2peJqsA==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr2815739wmk.113.1633600909285;
        Thu, 07 Oct 2021 03:01:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f16sm628559wrr.53.2021.10.07.03.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:01:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/7] ls-files: fix a trivial dir_clear() leak
Date:   Thu,  7 Oct 2021 12:01:35 +0200
Message-Id: <patch-v2-5.7-73cf1018953-20211007T100014Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an edge case that was missed when the dir_clear() call was added
in eceba532141 (dir: fix problematic API to avoid memory leaks,
2020-08-18), we need to also clean up when we're about to exit with
non-zero.

That commit says, on the topic of the dir_clear() API and UNLEAK():

    [...]two of them clearly thought about leaks since they had an
    UNLEAK(dir) directive, which to me suggests that the method to
    free the data was too unclear.

I think that 0e5bba53af7 (add UNLEAK annotation for reducing leak
false positives, 2017-09-08) which added the UNLEAK() makes it clear
that that wasn't the case, rather it was the desire to avoid the
complexity of freeing the memory at the end of the program.

This does add a bit of complexity, but I think it's worth it to just
fix these leaks when it's easy in built-ins. It allows them to serve
as canaries for underlying APIs that shouldn't be leaking, it
encourages us to make those freeing APIs nicer for all their users,
and it prevents other leaking regressions by being able to mark the
entire test as TEST_PASSES_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c                | 13 +++++--------
 t/t3005-ls-files-relative.sh      |  1 +
 t/t3020-ls-files-error-unmatch.sh |  2 ++
 t/t3700-add.sh                    |  1 +
 t/t7104-reset-hard.sh             |  1 +
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a2000ed6bf2..fcc685947f9 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -672,6 +672,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			 N_("suppress duplicate entries")),
 		OPT_END()
 	};
+	int ret = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(ls_files_usage, builtin_ls_files_options);
@@ -775,16 +776,12 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (show_resolve_undo)
 		show_ru_info(the_repository->index);
 
-	if (ps_matched) {
-		int bad;
-		bad = report_path_error(ps_matched, &pathspec);
-		if (bad)
-			fprintf(stderr, "Did you forget to 'git add'?\n");
-
-		return bad ? 1 : 0;
+	if (ps_matched && report_path_error(ps_matched, &pathspec)) {
+		fprintf(stderr, "Did you forget to 'git add'?\n");
+		ret = 1;
 	}
 
 	dir_clear(&dir);
 	free(max_prefix);
-	return 0;
+	return ret;
 }
diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index 727e9ae1a44..6ba8b589cd0 100755
--- a/t/t3005-ls-files-relative.sh
+++ b/t/t3005-ls-files-relative.sh
@@ -5,6 +5,7 @@ test_description='ls-files tests with relative paths
 This test runs git ls-files with various relative path arguments.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'prepare' '
diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index 124e73b8e60..2cbcbc0721b 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -9,6 +9,8 @@ This test runs git ls-files --error-unmatch to ensure it correctly
 returns an error when a non-existent path is provided on the command
 line.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 4086e1ebbc9..283a66955d6 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -5,6 +5,7 @@
 
 test_description='Test of git add, including the -- option.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test the file mode "$1" of the file "$2" in the index.
diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index 7948ec392b3..cf9697eba9a 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -2,6 +2,7 @@
 
 test_description='reset --hard unmerged'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.33.0.1446.g6af949f83bd

