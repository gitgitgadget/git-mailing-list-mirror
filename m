Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43162C3DA79
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiL3CTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiL3CTB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:19:01 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41531704D
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l29so21832785edj.7
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nwErfZ9e0+06NjDReS67pXkkZGuuUIAdXmxQ+5kqvE=;
        b=WFkMLk41rqntnEz318jhuOTCCOb5pw67pmI+cSDUnYjEywf5SAI4iXEyxx8kuPtAIK
         IMeT57Jt71R/1KnbhmlIFBvXS/uM8/RftIyYikOwPMGqeprjijnMP0kAqaGXoGNru7fo
         3o8jCUV4GwUePlDSIH05B9ciMKkkX4QnIB+Oe4mM2KFuxdgwFOQbIf1okMMfW9vf1+Qp
         XPEjm5Phvu7SDpA4GllZDUM4PvG9MABigicH6XpRkbV9asDYUWOp67YgY3T5GNkqqZb8
         JoLysrpJuaP+veouEM5s6zDZZaD6kRq30aJBZqPraxe7eosZF9c1A9wn2oMDr+3yvrOv
         8H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nwErfZ9e0+06NjDReS67pXkkZGuuUIAdXmxQ+5kqvE=;
        b=yTWtVHKNJ5uLWX6fC3FurOyqeCUhAbQT9ap7suasiqegs6L1hVIMj607OnnwQI4mAf
         QXmT9vKwfIb1UdL8i8kbGnakS1pude2MtAnfFB2Nh+EzwA6jMf0SmH7njn1CZzYqoAMd
         cQcQY0lXK8Y8XJkChGtjGdKnasD3zbDscA3qWgWbqb03x0z2QO6bwrqeaHFRe2zCf+A3
         kzQawEg1u1JY5B0vbhahR0vF958HI9uSLYTdTW842cW+YlVmi5N1TJZ/CkUp3UIUah0C
         roFXyTD8ttv0UOiEzlfVYb0JA51dWqXGMdR+Yk/2FTjUMvF3G0LPX15eZAaxsKs6+bBB
         o33g==
X-Gm-Message-State: AFqh2ko5X/vpTVSuiA7E8eywK2Wz7tqk0ZpzRDANdGdtnuDPPcwMLM3v
        ghkAjXKxXRIrUyFdkq88Fr7nj/l/NNHqQw==
X-Google-Smtp-Source: AMrXdXu008S9q90PTYQBvhEBfBi+IK5HsarkIM2u63I+rEw1/CQtsHYzJsDh7wupwTj1uvYXE/XN9A==
X-Received: by 2002:aa7:cd04:0:b0:46b:cb37:117b with SMTP id b4-20020aa7cd04000000b0046bcb37117bmr22802830edw.39.1672366736989;
        Thu, 29 Dec 2022 18:18:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 19/20] receive-pack: free() the "ref_name" in "struct command"
Date:   Fri, 30 Dec 2022 03:18:34 +0100
Message-Id: <patch-v2-19.20-fa5d657312f-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
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
2.39.0.1153.g589e4efe9dc

