Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FCEC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBFXJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjBFXIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:54 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6889D32E65
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:27 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hx15so38654840ejc.11
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCb5ktRN7aM+Yj7TI/WzQB2i0lEXwNq1MPN4nQl7XPc=;
        b=UZoMW8ngumIqyJWjRonAEoASDfj3N+bbbZXrzfm3zjZAiRnI1i6zeo3AGVChUZ/DMj
         ea/WnY0teOpiAWY3UNYr8B+uw2qbJZM/9dHVi35cykHUZP5c78B6OQ3kNNnqlgAyOPgv
         K7R440oeC//lLrkCXs5GhiusazyrnL+zgGuGCkYwNrruMnoExLosqZhac0837DcBUSP1
         bPCR4fzfPUNAfCTTKxNu7RWqkmMfGO2TofzgfCKAxWfYZL6woEfasWTgVyymMpEC9M/c
         1pL/q8nxrEwe4CBi5JblhDlvcywQVqkf/okPFOh3D3DgLjC1tjRV9CmGvf2M47SOiG+c
         18qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCb5ktRN7aM+Yj7TI/WzQB2i0lEXwNq1MPN4nQl7XPc=;
        b=ofOAsuN1LBDnuWU4Pl4wFlduYYlku/2NqWXbkaMZMDclm16vO0c4LT7nTadsGlDJ0T
         O9j7jpMkaPTO63dB91xo+rWG7K/Pga6uZri1LMaMqZwCz0ogvzpMRcDK9I03+2/odlVc
         SHDDQhNfyR2KVdwRj1ocf8J3RNAyiR5K4l2/FW8ohVszvyZnY2iB43JAj7RFIq9Ngc+j
         DFqfpdQuyY2hiDUh+EJUXn+uDFCzAoPsxG/U/iOhljKzu+P4GiSqoC7gsb0WDwvJnC7O
         lKCbyQN8YKEsWcOWo5xXix8QIK1WQEKfUolOGgdpiljJ9JvsRj3IosfHTFeECCtWXmXl
         f2iA==
X-Gm-Message-State: AO0yUKVTHs6TfLVqxuWNHwewb9MKhMr47EdklO7w4Zju6+E7/jOisMwJ
        QpsP+MGathnkVm87ELTMeTLO3Mdc8xYrpM5Q
X-Google-Smtp-Source: AK7set/N+q9tX9gfzEqptNolMPpR2BM7bJnDZIwO+GJjFaIKaGO6TMBwnTvAVFnL2HqE5QnVlDu0Mw==
X-Received: by 2002:a17:906:3009:b0:896:427b:148 with SMTP id 9-20020a170906300900b00896427b0148mr1180506ejz.1.1675724905702;
        Mon, 06 Feb 2023 15:08:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 17/19] receive-pack: release the linked "struct command *" list
Date:   Tue,  7 Feb 2023 00:07:52 +0100
Message-Id: <patch-v7-17.19-b02ece0d36b-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since this code was introduced
in [1]. Later in [2] we started using FLEX_ALLOC_MEM() to allocate the
"struct command *".

1. 575f497456e (Add first cut at "git-receive-pack", 2005-06-29)
2. eb1af2df0b1 (git-receive-pack: start parsing ref update commands,
   2005-06-29)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c                 | 11 +++++++++++
 t/t5405-send-pack-rewind.sh            |  1 +
 t/t5406-remote-rejects.sh              |  1 +
 t/t5507-remote-environment.sh          |  2 ++
 t/t5522-pull-symlink.sh                |  1 +
 t/t5527-fetch-odd-refs.sh              |  1 +
 t/t5560-http-backend-noserver.sh       |  1 +
 t/t5561-http-backend.sh                |  1 +
 t/t5562-http-backend-content-length.sh |  2 ++
 t/t5705-session-id-in-capabilities.sh  |  1 +
 10 files changed, 22 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a90af303630..cd5c7a28eff 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2032,6 +2032,16 @@ static struct command **queue_command(struct command **tail,
 	return &cmd->next;
 }
 
+static void free_commands(struct command *commands)
+{
+	while (commands) {
+		struct command *next = commands->next;
+
+		free(commands);
+		commands = next;
+	}
+}
+
 static void queue_commands_from_cert(struct command **tail,
 				     struct strbuf *push_cert)
 {
@@ -2569,6 +2579,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
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
2.39.1.1425.gac85d95d48c

