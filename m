Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D4EC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjAJFp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjAJFoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:32 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8D241D6E
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:44:08 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qk9so25816384ejc.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uso+ZOOlGJiUguFVqdie08BryGf/LseLSoyR9v5Tzw=;
        b=JAKEEbPF7pyuxxXyGBFI0LZi6e18nDsjl/N10y/KwvwSAgO48NAewTugeUJsy9z1yH
         Pc27a1C6eJvPdDLpZvv+87a9G4Gqo9KoEknGDOAvxK9ygh+APsyHYliLXoBQpkJT/VCe
         OZ9IHFdYYuPp3IIZdLAqdxL5ipyWdPg692cVmuuBBXsKxlzbaoEuncgWRjAg2o/CVXPn
         jNkzeAnThLf5zfwQzW3/pXS4HvlmH2zC8vGKF/wZx4r+/ma2JZYMTclKYn9SYJL2iPrx
         9DBwzSRxrJXpkYxHYbfgjAJx4RSjYLyhuqEG3gFQ3/taFjENKk+XH8V6y/QjtPdGZ2QG
         wGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uso+ZOOlGJiUguFVqdie08BryGf/LseLSoyR9v5Tzw=;
        b=0v/OgAFyECdX4Xx8wbXw6GTa0fB532kExWdAn1RdJ2G69gs7HCgI4/VvGme7lq/jR5
         F1EWelYE3zKa0QKcGT4F0/tD7TXSb9paZwRd7cYMlUDfEbI1GVYzV6DxGrQEFF/fGd3z
         dZHVTXfU3gRhQAmS/nvEsgDqf8xRjDEecLQsemyEyHn2uKOnPRkcBnOPX/BqUFgrt/ML
         fm0wlHTcDu2/fDGBnRjDQlGLdspbktjLjaFHMfQS0B4ahOOy90oOXHZNbhCOaN9aT4HJ
         H3xTIcZgx0MiQx9Fu+sJurO0fTuOwU5zCpB/yMsaqyfvrrFWae6r+3/K0QuP+CYH01QR
         IoKQ==
X-Gm-Message-State: AFqh2kpIMqnWLRaJjvgBnzWnhJjtxxRbANXPIUqzSgR9ORIWAdvFVs28
        Cb70OwMAxDVYnl0b4VJ9wEhaKH+P2b60YA==
X-Google-Smtp-Source: AMrXdXuvP5cQaettN5avoRc3y1TrIetz7f2xMd1cpqTNmhGgaboxFc7m5cJvzCzsyPamHL2ZCcn+Cw==
X-Received: by 2002:a17:907:d004:b0:7c0:f213:4485 with SMTP id va4-20020a170907d00400b007c0f2134485mr57581156ejc.73.1673329447313;
        Mon, 09 Jan 2023 21:44:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:44:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 18/19] receive-pack: free() the "ref_name" in "struct command"
Date:   Tue, 10 Jan 2023 06:43:38 +0100
Message-Id: <patch-v3-18.19-3e4b12cb623-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
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
 builtin/receive-pack.c                | 10 ++++++++++
 t/t5405-send-pack-rewind.sh           |  1 +
 t/t5406-remote-rejects.sh             |  1 +
 t/t5507-remote-environment.sh         |  2 ++
 t/t5522-pull-symlink.sh               |  1 +
 t/t5527-fetch-odd-refs.sh             |  1 +
 t/t5705-session-id-in-capabilities.sh |  1 +
 7 files changed, 17 insertions(+)

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
2.39.0.1195.gabc92c078c4

