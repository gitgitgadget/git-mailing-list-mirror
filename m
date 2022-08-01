Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8578C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiHAVPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiHAVPH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:15:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27A4402D9
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:15:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so6121013wmm.4
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 14:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y51TaP+IJMtsFUvRMGdpsaRCdcGTfrxNBDRErSskFqQ=;
        b=eARG2ILz0+0z3oE1ZHSlBYRFRNqkDKv4jZ3Xolj8BqpfBbJbPE/kAxfyf4xjz+n2BY
         +IVE+tscjavnbbrEviirWBi4AvaqeWVZPf6hn5xvfudsnF9ee5q3cit0yLHKYhBCA0oC
         hLguQ59DsLu301qCougB+WjysswMRyxt38uGCKGMrd2EL+x0/vvW9M9phxJ5qDoN+hif
         HTt3cKj9ZGipOnmf/yLUfsShfSOXRbpArxidxw3q/Pbh7w/UKWnxSoT53CPIrrc0aOJa
         rNBfXDFLl6ToukiCyBjgZcBqGp4M8sfhhr7J6ctH6NzCM1LeHzeTYngpgS+e6cQdonAT
         0czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y51TaP+IJMtsFUvRMGdpsaRCdcGTfrxNBDRErSskFqQ=;
        b=ar4r3FSjMni5av9hvZPO3uwthb/5nZtTcNxfvH/S9vOSjQSMEuQNKXJJawHZm5v4ON
         ESFShftFipG9BJTuX5TcAU8lLrDNN/CuKVg3xvmmzxQgxTQea6czFnIgJ5EjSxczcz6d
         taW3zNMlbs+PsvjTJRkSaBmKaSqh2jS9D8P5sUMbgLaZiOjjuLs22c3+S6h0PmYdyE2W
         xSBoiIdWlayP/WMukZSr5yy6unaSBws3LC3rIYZyv1iJrwtzu/7DscXf0HG5/ceTkGfD
         LXzHTHlz+I61c6jKOdMrahqpIhhD8jSI+asgjo4hgxBZYmDOvyqLmM+zwRk8g4jauKf3
         bw7g==
X-Gm-Message-State: AJIora+I6xUogqkLE+txrmKghraWGSV262XJZkJ+HHgjrEl7VJCA1bIP
        bsFkWLVBJuTtiY5g0d7GOBxRPyaUt7o=
X-Google-Smtp-Source: AGRyM1vicj8YTEta+VtvSG8pdpRfKuI5bxiofvqN7OCEhB+fmsyrJRpZRqC1qSEOoC2olfwsGvstQg==
X-Received: by 2002:a05:600c:22da:b0:3a3:3139:d8ff with SMTP id 26-20020a05600c22da00b003a33139d8ffmr12350853wmg.178.1659388504072;
        Mon, 01 Aug 2022 14:15:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0021b970a68f9sm12908835wrr.26.2022.08.01.14.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:15:03 -0700 (PDT)
Message-Id: <4bc290fbf43e0193aae288b79249014d899ea34a.1659388498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 21:14:55 +0000
Subject: [PATCH 4/7] builtin/bugreport.c: add directory to archiver more
 gently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

If a directory added to the '--diagnose' archiver does not exist, warn and
return 0 from 'add_directory_to_archiver()' rather than failing with a fatal
error. This handles a failure edge case where the '.git/logs' has not yet
been created when running 'git bugreport --diagnose', but extends to any
situation where a directory may be missing in the '.git' dir.

Now, when a directory is missing a warning is captured in the diagnostic
logs. This provides a user with more complete information than if 'git
bugreport' simply failed with an error.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/bugreport.c  |  8 +++++++-
 t/t0091-bugreport.sh | 11 ++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 720889a37ad..dea11f91386 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -176,12 +176,18 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 				     const char *path, int recurse)
 {
 	int at_root = !*path;
-	DIR *dir = opendir(at_root ? "." : path);
+	DIR *dir;
 	struct dirent *e;
 	struct strbuf buf = STRBUF_INIT;
 	size_t len;
 	int res = 0;
 
+	if (!file_exists(at_root ? "." : path)) {
+		warning(_("directory '%s' does not exist, will not be archived"), path);
+		return 0;
+	}
+
+	dir = opendir(at_root ? "." : path);
 	if (!dir)
 		return error_errno(_("could not open directory '%s'"), path);
 
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 3cf983aa67f..e9db89ef2c8 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -78,7 +78,7 @@ test_expect_success 'indicates populated hooks' '
 	test_cmp expect actual
 '
 
-test_expect_failure UNZIP '--diagnose creates diagnostics zip archive' '
+test_expect_success UNZIP '--diagnose creates diagnostics zip archive' '
 	test_when_finished rm -rf report &&
 
 	git bugreport --diagnose -o report -s test >out &&
@@ -98,4 +98,13 @@ test_expect_failure UNZIP '--diagnose creates diagnostics zip archive' '
 	grep "^Total: [0-9][0-9]*" out
 '
 
+test_expect_success '--diagnose warns when archived dir does not exist' '
+	test_when_finished rm -rf report &&
+
+	# Remove logs - not guaranteed to exist
+	rm -rf .git/logs &&
+	git bugreport --diagnose -o report -s test 2>err &&
+	grep "directory .\.git/logs. does not exist, will not be archived" err
+'
+
 test_done
-- 
gitgitgadget

