Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE403C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbiKHSSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiKHSSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:18:01 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415D271E
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:17:59 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id t25so40764381ejb.8
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exGndAERXOkPXMewQ/pAmX0sNDJ2fBE+GXdKUxkq/5k=;
        b=KeNJ+VOErWf7VGqCqsgrqnlFbOIrApDa9ghxhud+kBmAg3QdJD7L6+nd6RQqHg36rW
         00dOaEyF6KNd/JGElS0Y01bftoxVJKZsUe0Mo27lS2Z3qOJPph6ZCL1uw3ppCzIFia8q
         h1Tl9WSa+YzlarGExebLc46yrhF921x7Xd7eZVa+Saf42MQcobg7ShoRxs+ioWLwfzO0
         lUHuUiyqgOsJ0NIJ003PZX58dbX7TojHesXdyrJENkOOn3EVVx5HOH1l5jtiQgyz8Sz5
         eL5qa/5F8GaiJgiteCMUWxpUqT4xSR0XNs38ZztODbHkFsGfkyxpY3nTmJUs6RdAAGOE
         2QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exGndAERXOkPXMewQ/pAmX0sNDJ2fBE+GXdKUxkq/5k=;
        b=4JBPVMI4FGuyQDE/AIE1AZ9qA2WhB9WMmDONZW5mada9K1erRyx5lFOmsqQyDgPUr+
         RNra23s+/ClZY+1GMD3hm2WIaTILaFrZHxo4QAUdyLVvROn4ca3jFHe3KQoHUCUbHgz6
         xJwLy/AMygBGlh7OCAqbHzNmxlEorYCQbG+l1sUpZXXBeykpfnF1ha0ZZL6Mnh3CV1Yo
         ZpL7u/UjqsBCDGKuct9Z1DftMqAhiKDVJmFlXOl7VldcC2Wm8g4H3LwRS7ZOp9teWpQL
         z2dSUenR6rPOsZkBvKy1W4Zq2RelN3ifIpdL2mBw3y7wQqdvV/KH/paLvsek8yfsMzRO
         rpWQ==
X-Gm-Message-State: ANoB5plauS2yqBc0dgTr8WWMCfoRy1h+bnEfvBf1hfu3cxal4HgT7ZBK
        Oloe6UVXRfL75iYKXxB+xfNbzmwozVR6Rg==
X-Google-Smtp-Source: AA0mqf483dkPopbQ1Ph/iVXRg4blRpEhd2v4kLhnJplnzI4PB9475OQiD365tJsZ5oKdeVU9Ded0ew==
X-Received: by 2002:a17:906:cec6:b0:7ae:71d4:352 with SMTP id si6-20020a170906cec600b007ae71d40352mr8944651ejb.65.1667931478293;
        Tue, 08 Nov 2022 10:17:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:17:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/15] built-ins & libs & helpers: add/move destructors, fix leaks
Date:   Tue,  8 Nov 2022 19:17:42 +0100
Message-Id: <patch-v2-06.15-698a335b1a3-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix various leaks in built-ins, libraries and a test helper here we
were missing a call to strbuf_release(), string_list_clear() etc, or
were calling them after a potential "return".

Comments on individual changes:

- builtin/checkout.c: Fix a memory leak that was introduced in [1]. A
  sibling leak introduced in [2] was recently fixed in [3]. As with [3]
  we should be using the wt_status_state_free_buffers() API introduced
  in [4].

- builtin/repack.c: Fix a leak that's been here since this use of
  "strbuf_release()" was added in a1bbc6c0176 (repack: rewrite the shell
  script in C, 2013-09-15). We don't use the variable for anything
  except this loop, so we can instead free it right afterwards.

- builtin/rev-parse: Fix a leak that's been here since this code was
  added in 21d47835386 (Add a parseopt mode to git-rev-parse to bring
  parse-options to shell scripts., 2007-11-04).

- builtin/stash.c: Fix a couple of leaks that have been here since
  this code was added in d4788af875c (stash: convert create to builtin,
  2019-02-25), we strbuf_release()'d only some of the "struct strbuf" we
  allocated earlier in the function, let's release all of them.

- ref-filter.c: Fix a leak in 482c1191869 (gpg-interface: improve
  interface for parsing tags, 2021-02-11), we don't use the "payload"
  variable that we ask parse_signature() to populate for us, so let's
  free it.

- t/helper/test-fake-ssh.c: Fix a leak that's been here since this
  code was added in 3064d5a38c7 (mingw: fix t5601-clone.sh,
  2016-01-27). Let's free the "struct strbuf" as soon as we don't need
  it anymore.

1. c45f0f525de (switch: reject if some operation is in progress,
   2019-03-29)
2. 2708ce62d21 (branch: sort detached HEAD based on a flag,
   2021-01-07)
3. abcac2e19fa (ref-filter.c: fix a leak in get_head_description,
   2022-09-25)
4. 962dd7ebc3e (wt-status: introduce wt_status_state_free_buffers(),
   2020-09-27).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c                   | 2 ++
 builtin/rebase.c                     | 3 +++
 builtin/repack.c                     | 2 +-
 builtin/rev-parse.c                  | 1 +
 builtin/stash.c                      | 2 ++
 ref-filter.c                         | 1 +
 t/helper/test-fake-ssh.c             | 1 +
 t/t3409-rebase-environ.sh            | 1 +
 t/t3428-rebase-signoff.sh            | 1 +
 t/t3433-rebase-across-mode-change.sh | 1 +
 10 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a132392fbe..659dd5c4309 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1470,6 +1470,8 @@ static void die_if_some_operation_in_progress(void)
 		      "or \"git worktree add\"."));
 	if (state.bisect_in_progress)
 		warning(_("you are switching branch while bisecting"));
+
+	wt_status_state_free_buffers(&state);
 }
 
 static int checkout_branch(struct checkout_opts *opts,
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4d6839a5785..6a831320313 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1828,10 +1828,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_release(&revisions);
 	free(options.reflog_action);
 	free(options.head_name);
+	strvec_clear(&options.git_am_opts);
 	free(options.gpg_sign_opt);
 	free(options.cmd);
 	free(options.strategy);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
+	string_list_clear(&exec, 0);
+	string_list_clear(&strategy_options, 0);
 	return !!ret;
 }
diff --git a/builtin/repack.c b/builtin/repack.c
index 10e23f9ee1f..fb3ac197426 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -956,6 +956,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		item = string_list_append(&names, line.buf);
 		item->util = populate_pack_exts(item->string);
 	}
+	strbuf_release(&line);
 	fclose(out);
 	ret = finish_command(&cmd);
 	if (ret)
@@ -1124,7 +1125,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
-	strbuf_release(&line);
 
 	return 0;
 }
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8f61050bde8..e0244d63de6 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -530,6 +530,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	strbuf_addstr(&parsed, " --");
 	sq_quote_argv(&parsed, argv);
 	puts(parsed.buf);
+	strbuf_release(&parsed);
 	return 0;
 }
 
diff --git a/builtin/stash.c b/builtin/stash.c
index bb5485b4095..8a64d564a19 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1686,8 +1686,10 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 	}
 
 done:
+	strbuf_release(&patch);
 	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
+	strbuf_release(&untracked_files);
 	return ret;
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 914908fac52..b40b76c3806 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1358,6 +1358,7 @@ static void find_subpos(const char *buf,
 
 	/* parse signature first; we might not even have a subject line */
 	parse_signature(buf, end - buf, &payload, &signature);
+	strbuf_release(&payload);
 
 	/* skip past header until we hit empty line */
 	while (*buf && *buf != '\n') {
diff --git a/t/helper/test-fake-ssh.c b/t/helper/test-fake-ssh.c
index 12beee99ad2..d5e511633ab 100644
--- a/t/helper/test-fake-ssh.c
+++ b/t/helper/test-fake-ssh.c
@@ -17,6 +17,7 @@ int cmd_main(int argc, const char **argv)
 	f = fopen(buf.buf, "w");
 	if (!f)
 		die("Could not write to %s", buf.buf);
+	strbuf_release(&buf);
 	for (i = 0; i < argc; i++)
 		fprintf(f, "%s%s", i > 0 ? " " : "", i > 0 ? argv[i] : "ssh:");
 	fprintf(f, "\n");
diff --git a/t/t3409-rebase-environ.sh b/t/t3409-rebase-environ.sh
index 83ffb39d9ff..acaf5558dbe 100755
--- a/t/t3409-rebase-environ.sh
+++ b/t/t3409-rebase-environ.sh
@@ -2,6 +2,7 @@
 
 test_description='git rebase interactive environment'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index f6993b7e14d..e1b1e947647 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -5,6 +5,7 @@ test_description='git rebase --signoff
 This test runs git rebase --signoff and make sure that it works.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # A simple file to commit
diff --git a/t/t3433-rebase-across-mode-change.sh b/t/t3433-rebase-across-mode-change.sh
index 05df964670f..c8172b08522 100755
--- a/t/t3433-rebase-across-mode-change.sh
+++ b/t/t3433-rebase-across-mode-change.sh
@@ -2,6 +2,7 @@
 
 test_description='git rebase across mode change'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.38.0.1467.g709fbdff1a9

