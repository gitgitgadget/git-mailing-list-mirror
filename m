Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D85C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiKHOLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiKHOLA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:11:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EC9E00
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:10:53 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l11so22657533edb.4
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7EIfXb+evNa2DxzTVkmKdfzzC/1yKboLreR9fERdsg=;
        b=d2ftEYehkWAMqQbfKPEbqedhdqD3DFD2uPvXbVM2DJZY87e8gQQrXbYGgPMN0Lmn+h
         A3MuQ3B241wzQtS4mcrrb/wTqzHC3dVIx4qS61jCLyzWvRmUD59n8gGlxkxQb/at6Yix
         7BKrv9krVYafITfYm6q4LC4g3xzH6FMg4ejitc6MoDkvmd6U6yP9ddQvZTrTiStgwLo4
         2fdcBhCji8aEpspumLTiL2KlhAn4pp6lk38Y0fclcrDz9+bDOJKP3cFyoCq74f3VSLRI
         ef+sVtbLykP9PCG7+9T+c+3f+a6G8rEft66vxRNnQM7kJmh53B7iMh15G77NZHkWXph1
         lKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7EIfXb+evNa2DxzTVkmKdfzzC/1yKboLreR9fERdsg=;
        b=j7PCf+PvSF70ZFrn4vylvDwna7tovTUwz6RwUB8cUydWT1yJnha13Y8O4gKtbrODdb
         E0UYDzvkPBvpn1lT+Hjw2RJiQeDdToGPCcqgzdxEul5qpMHCuqXEJ2GqI0EfI91FivWW
         OL7aNPN9YQnROVKhLVaBczqaP++x5l9zdaAFKguWz7vlhNA1n618gONLIFY5HF11/EyW
         XXI8Ocfu3iLalD5lUiO+M4NTJr90bgKaRfaSGqDZY3DJzh1vUoY1eSd4N7FM4Kd4mC6k
         m9oJm8SPhiwmLdzhRPo5XXcBfYs3XH4Psa2BYykinIUCorPo1/mJz68K5/lKsoFiUNub
         OmwA==
X-Gm-Message-State: ACrzQf2Dhm/x2ZpPWiER4wB387dQ0ySIHWNC3tygJUPW9qx9gw2iTpZW
        Th+bArhtTB+fS3c+vWCWgFKW9oNrxy3nIA==
X-Google-Smtp-Source: AMsMyM6gevmaS1AHg8FaOv5u/LXwPAuXCelnmlB1tGVwhW6YEIL82mWG69VkuQ6XJowaRh3zXj6UmA==
X-Received: by 2002:a05:6402:5250:b0:461:e870:850f with SMTP id t16-20020a056402525000b00461e870850fmr55542313edd.404.1667916651693;
        Tue, 08 Nov 2022 06:10:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906369000b0078d9c2c8250sm4683666ejc.84.2022.11.08.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:10:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/9] submodule--helper: fix  a memory leak in "status"
Date:   Tue,  8 Nov 2022 15:10:34 +0100
Message-Id: <patch-v2-3.9-a3529d7f9e0-20221108T140501Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "status" sub-command was leaking the "struct strvec" it was
setting up for the reasons explained in f92dbdbc6a8 (revisions API:
don't leak memory on argv elements that need free()-ing, 2022-08-02),
so let's use the "free_removed_argv_elements" option to
setup_revisions() to fix the leak.

Even if we did that, clobbering the "diff_files_args.nr" with the
return value of setup_revisions() would leave leaks in place, but we
can just stop clobbering it.

Ever since that code was added in a9f8a37584a (submodule: port
submodule subcommand 'status' from shell to C, 2017-10-06) we've had
no reason to modify the "nr" member ("argc" at the time): The next use
of "diff_files_args" after this is the "strvec_clear()" at the end of
the function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 7 ++++---
 t/t7422-submodule-output.sh | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6250b95a6f7..ee6f2d34cba 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -616,6 +616,9 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	int diff_files_result;
 	struct strbuf buf = STRBUF_INIT;
 	const char *git_dir;
+	struct setup_revision_opt opt = {
+		.free_removed_argv_elements = 1,
+	};
 
 	if (!submodule_from_path(the_repository, null_oid(), path))
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
@@ -649,9 +652,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.abbrev = 0;
-	diff_files_args.nr = setup_revisions(diff_files_args.nr,
-					     diff_files_args.v,
-					     &rev, NULL);
+	setup_revisions(diff_files_args.nr, diff_files_args.v, &rev, &opt);
 	diff_files_result = run_diff_files(&rev, 0);
 
 	if (!diff_result_code(&rev.diffopt, diff_files_result)) {
diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index 1e9cdf1a68e..ab946ec9405 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -2,6 +2,7 @@
 
 test_description='submodule --cached, --quiet etc. output'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t3100.sh
 
-- 
2.38.0.1464.gea6794aacbc

