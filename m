Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220C4C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjARMrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjARMqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C394306
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:52 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x10so46469539edd.10
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kTWzCHL6Dj42pkbke7fDrfNF5o2r53qWt9KXITmkXc=;
        b=VBor+BSy/DPXGzekg/BirdR/42RHfZKDxU1vz2O7aJekw4hQjZ9gd+MeLwtViNhxqX
         ahq9cHVie1UfGouWkhQ8rXDdaFiSJnRahMyL06nJp+3HwIcxoxRXMub0wOqEDwzZtuM8
         mZ3oc0CE93iLfxUCbXtVndhT3FxbpDl6fjKmf8bVaf9iSV+pHm/fm3YsI+lWQCKSsJ8R
         RKUcgPGtyln2wINEvUjC6tPfxZhp3PMrn1yCXJ1xdi1rd5iyKRsVSNJ06OR0uFgJMF3R
         phdygiJeQ6aa2UqGkG7vJPBbWQZhDx8UZ2vcIbI4Md3i/bJBRmHEFe0WDgm0MXt8Xnhc
         8GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kTWzCHL6Dj42pkbke7fDrfNF5o2r53qWt9KXITmkXc=;
        b=4SRuvNybGIEHWuddamOdBR+niyEE0mxy3NpTGeGBITTmWfi5mzc4E2vVcwyQtj7RUK
         N5iH4HmuCDp5pKVaz+hk+cabwucucMnf9VgGqZWpRpbg2eyv3mXATwB4ak7onzhc/wLS
         iSc66JVwQ8sBHZ1LzO8fN2zHkMg6G1v8BRWs6JRn2XrsNrHLLOiRtjZpixgShVFWYfKW
         Y0ozQPaU5in7jpNpb47UXdrTP2Da1Bqz6PYayrS008VhY7bTtzQpUXK3PFdv/2ooLXWj
         hJNNzQpVdkOTQbPMsYswfdl89zPYd4xmcbMYDoAr61bfn5a8svjXiMzJ70XYGuK7s4MN
         SsoA==
X-Gm-Message-State: AFqh2kqdcTK1abZErPoGQmUniSOSsavL+UzGaujMebN/lHzKjq6macyT
        JsWp8Mm+w1mw/QGrhX4KtJKErRbD1wnjlQ==
X-Google-Smtp-Source: AMrXdXtCCm7miM05eTFydlwYUMx2A5RonOB9hJ6Gvwym0F/mdg2FMrbzlT8RiXccI7RESi9kJL7x8Q==
X-Received: by 2002:aa7:c0d4:0:b0:48f:acd1:8da2 with SMTP id j20-20020aa7c0d4000000b0048facd18da2mr6975921edp.27.1674043730889;
        Wed, 18 Jan 2023 04:08:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 18/19] receive-pack: free() the "ref_name" in "struct command"
Date:   Wed, 18 Jan 2023 13:08:31 +0100
Message-Id: <patch-v5-18.19-3c3d48df04b-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since this code was introduced
in 575f497456e (Add first cut at "git-receive-pack", 2005-06-29), see
eb1af2df0b1 (git-receive-pack: start parsing ref update commands,
2005-06-29) for the later change that refactored the code to add the
"ref_name" member.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c                 | 10 ++++++++++
 t/t5405-send-pack-rewind.sh            |  1 +
 t/t5406-remote-rejects.sh              |  1 +
 t/t5507-remote-environment.sh          |  2 ++
 t/t5522-pull-symlink.sh                |  1 +
 t/t5527-fetch-odd-refs.sh              |  1 +
 t/t5560-http-backend-noserver.sh       |  1 +
 t/t5561-http-backend.sh                |  1 +
 t/t5562-http-backend-content-length.sh |  2 ++
 t/t5705-session-id-in-capabilities.sh  |  1 +
 10 files changed, 21 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a90af303630..451bad776c6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2032,6 +2032,15 @@ static struct command **queue_command(struct command **tail,
 	return &cmd->next;
 }
 
+static void free_commands(struct command *commands)
+{
+	while (commands) {
+		struct command *next = commands->next;
+		free(commands);
+		commands = next;
+	}
+}
+
 static void queue_commands_from_cert(struct command **tail,
 				     struct strbuf *push_cert)
 {
@@ -2569,6 +2578,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		run_receive_hook(commands, "post-receive", 1,
 				 &push_options);
 		run_update_post_hook(commands);
+		free_commands(commands);
 		string_list_clear(&push_options, 0);
 		if (auto_gc) {
 			struct child_process proc = CHILD_PROCESS_INIT;
diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
index 11f03239a06..1686ac13aa6 100755
--- a/t/t5405-send-pack-rewind.sh
+++ b/t/t5405-send-pack-rewind.sh
@@ -5,6 +5,7 @@ test_description='forced push to replace commit we do not have'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index dcbeb420827..d6a99466338 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -2,6 +2,7 @@
 
 test_description='remote push rejects are reported by client'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5507-remote-environment.sh b/t/t5507-remote-environment.sh
index e6149295b18..c6a6957c500 100755
--- a/t/t5507-remote-environment.sh
+++ b/t/t5507-remote-environment.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='check environment showed to remote side of transports'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up "remote" push situation' '
diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index bcff460d0a2..394bc60cb8e 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -2,6 +2,7 @@
 
 test_description='pulling from symlinked subdir'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # The scenario we are building:
diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
index e2770e4541f..98ece27c6a0 100755
--- a/t/t5527-fetch-odd-refs.sh
+++ b/t/t5527-fetch-odd-refs.sh
@@ -4,6 +4,7 @@ test_description='test fetching of oddly-named refs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # afterwards we will have:
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index d30cf4f5b83..f75068de648 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -4,6 +4,7 @@ test_description='test git-http-backend-noserver'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 HTTPD_DOCUMENT_ROOT_PATH="$TRASH_DIRECTORY"
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 9c57d843152..e1d3b8caed0 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -4,6 +4,7 @@ test_description='test git-http-backend'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index b68ec22d3fd..7ee9858a78b 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test git-http-backend respects CONTENT_LENGTH'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_lazy_prereq GZIP 'gzip --version'
diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
index ed38c76c290..b8a722ec27e 100755
--- a/t/t5705-session-id-in-capabilities.sh
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -2,6 +2,7 @@
 
 test_description='session ID in capabilities'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 REPO="$(pwd)/repo"
-- 
2.39.0.1225.g30a3d88132d

