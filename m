Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40756C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D257611C3
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbhJFKEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbhJFKEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:04:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA638C061768
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:02:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m22so7185536wrb.0
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aVDBHg2ZjgRKkToP/9wPKD6q8rs7xYNR0A4KKhM9PRU=;
        b=X4/5bAI3FXcDF6BV4aZxPfU6ck5DWvO0LQORoIdIaVEtQavy2zGDmtawl+kPM9D6Fn
         nFsf5UhMu+MrpOaIlx95O0tHuxizi9EvjjprdFJCRHCCQeyAG9RFr3WnLSlEo4Sk2qku
         wEm3BarlCt6bPYpvdZVdhcbHmiCYn9x7fzWcrVIWkYVcH8Y1rsT0AQ6n6bcyRrRzyY0X
         qqwE6sGhIms9Jt9beNfhTmxc/lszix6OnP/VJofn/uktyRgJQx//7etkAQqXNWrIEWi7
         5N0bJm0xpgcj+uNOK3j8YVzL+dohff3mXPfEe9YrwsclbEo07Mc4WyG0hxv2/NJ5sI/y
         PpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aVDBHg2ZjgRKkToP/9wPKD6q8rs7xYNR0A4KKhM9PRU=;
        b=Hw8qCJaKItYgxqNwUAnphbqQATc9vBmLYCh6sgPoB1K5lzRFe5PAwsPoydXTJ1bZD+
         guNqbOc9GvGHtCwafT3GGPwt1aS41PD54Kvwd0m5XWi4AALPYyzpDt9vuUG0F+hb2jD1
         kBgoYBW6i0WZtoxxRajSevtSpRDY9DrJQyf2BDQhIJwf7l4kLhLZJf6P8bsrifwJUs+m
         r8bBKVoJWGut2k9J32UheSPTCGDWJtDE12s9pnsRhDcpCsXpZKxhaHdA4LaoDj5jB5gt
         yqv1KiP++19bhIjRuMtPKDkLCmZty9OxT7lhVB6jc1JYRNVCCcP+d/TqTt7w6UpXEqo0
         o6AQ==
X-Gm-Message-State: AOAM53291osLmS4p585HWY1RQra/W5tFypbVCNrJyZEdisdL5D0Cn7mT
        oDY7AfH6TlouBqXy64Ou7uTMlEtVMh5pgg==
X-Google-Smtp-Source: ABdhPJy4B0/yjO//0HBcol8E4rgNGFL/HLP+mTaGcfho6YJYlhRF2kE4m63Q0Kb/5G66c60DkvhVyA==
X-Received: by 2002:adf:8bca:: with SMTP id w10mr17732963wra.43.1633514553116;
        Wed, 06 Oct 2021 03:02:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h18sm5515279wmq.23.2021.10.06.03.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:02:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/7] ls-files: fix a trivial dir_clear() leak
Date:   Wed,  6 Oct 2021 12:02:23 +0200
Message-Id: <patch-5.7-58b5bc67435-20211006T095426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
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
index e6d415e077a..0fecfa3b0c1 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -674,6 +674,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			 N_("suppress duplicate entries")),
 		OPT_END()
 	};
+	int ret = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(ls_files_usage, builtin_ls_files_options);
@@ -777,16 +778,12 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
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
2.33.0.1441.gbbcdb4c3c66

