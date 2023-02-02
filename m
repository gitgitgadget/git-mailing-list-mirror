Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F3DC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjBBJyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjBBJxt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211D42CFF5
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso894339wms.4
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCUVq8Ly+j2m0SakiS1nf66ZRSF/UKj6a5BQSnVZHZE=;
        b=k3noSsu4yOsq/SdpgayDZNECR24CDx1+bFNvELhIX4wU+VySOJqgVqNwbxCYA3/Byr
         n74MDmHq2pWnm+EbjwA7QU9mvU1QUq/4XDvU0f5S0fGwUaMp8lelqdiY2bk6hPnR8EdB
         bi55WXyXMjCdwnojIALB9tFiZkKbLT9efOTxt0uRlSmiXwFSjipYjOx8nQDFEtsNr7i0
         WHi3vHaOm1Tjd32qHXjIDl0B4YQK6IkkW+l6fP0O4vOfudhvC6fBND0qPFjwO0DAidQX
         pJnApIl7CPCdUM2zhvWzhb+Cd7gejinFmi27BfA5BHrj3OESn/UNqLWAPF7G35R8mNBn
         2l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCUVq8Ly+j2m0SakiS1nf66ZRSF/UKj6a5BQSnVZHZE=;
        b=NGPRdfy60nS0+ywVs31FmLw3L4QVu7MBnVZ933jmEfp6cv3cV0FmeENGSKgTthYBGj
         jABkz5vKZe81xX3tPQfsQ/IQdh791/CiprTmCV6LT3B4DzCU5mMbE04KY4Ww7ieJUut/
         dEiD4+sgOraBHqv/lK9Gvb6tDJT3B34Z4RZYPDTFE+8wdvaV57DQqPhF4d2B7FYe7Ymt
         hRuaRnN7yfYqv7L4kdSQATseXaYIK0xSJICtpZq+d8mSc4plv0Td7gLonfSk2WC8Q3/a
         piRxaclDJbmTFA2Zl7RbefQzB1CgQR+dFWlIXKQ7QAO0d3L/uvLQY6zhxDr+ya65rGhL
         B9PQ==
X-Gm-Message-State: AO0yUKXwtOIW9HjQJHq5YV1u1WmBslMJ7W04uL8tBBp3ls1bmePHmKJS
        tbTI8Ee5bdC7uyG2uHISBLfLo+7YkP/A6M9Z
X-Google-Smtp-Source: AK7set+tYHvYhxzTx5sGFimSA4iAdM9BLrFiapea12svhbJVtWY+gjAFEBb568G2xuK4VOVlbaXsNA==
X-Received: by 2002:a05:600c:600c:b0:3db:1afd:ac36 with SMTP id az12-20020a05600c600c00b003db1afdac36mr5665178wmb.32.1675331594189;
        Thu, 02 Feb 2023 01:53:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 17/19] receive-pack: free() the "ref_name" in "struct command"
Date:   Thu,  2 Feb 2023 10:52:48 +0100
Message-Id: <patch-v6-17.19-4b2db91f5cb-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since this code was introduced
in 575f497456e (Add first cut at "git-receive-pack", 2005-06-29). See
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
2.39.1.1392.g63e6d408230

