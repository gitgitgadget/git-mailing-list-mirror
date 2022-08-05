Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E5BC00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 14:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbiHEOPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 10:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiHEOPj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 10:15:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152AA634F
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 07:15:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h34-20020a05600c49a200b003a5165eae0fso1344391wmp.4
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QaKqPvh3DiwPfU8t101EsAp25N70ze7Xxf4NXdw94Gk=;
        b=KGZiu8ED9nevmrmBHXrq+0wrPNFi/71IQ9KGCK6Qa9bgTDQk8SfU7RUklGthY55NNN
         7GC9yrj1fRP9tuQnLIwC4kRKs2gDZsVrxx8SjsmdBEiuKWF+eF0R8ZkqsaQezLNsDGA2
         1rYi4JRQXJ4I+bSMComAWIn0v7JRQpCMjdoeyDqSdIcT6tw3hTTTp04RZyFVoBrmxa8b
         ptU/hTg+MIL02w/AwPU7qC1YyeZ/jZEt72XbMLWhCSiNFPMnjLSW5Ewp5dIfE14lkv4+
         cgxHDxZHwbadxLjonuyL9VQfW5K3mD0i7xJwGNp14vyVmxYe0LxU1v0PKkGCznDll8HY
         Rrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QaKqPvh3DiwPfU8t101EsAp25N70ze7Xxf4NXdw94Gk=;
        b=Z7sRMliI+I6QhldNl4EO3m+JdxE1oHM/xySxnAKtiyBrLxK+hKFE/H3DJiN049ZFmU
         rctExrX4saamzHPgX0JmBjZ+tGrQe6b1LXgfIEp0EYG84D6ZFvLk58tChSVHf24MbDWM
         4IUPyT+Kj7GB4qnAxgXYafOWhLx56srsluOat9NUSvDF2CXdS7sZjU46NkM+AZPfDr9s
         kgdsPNJbRtXYqotJhQVaCeoKx9fQxDbd8WAYukRYo22gV8wKB+l1+HWO/Km4K3bNcQdt
         XIwS5HCKmVJBX168GbSoN3Er8fkFesr8IdrUjldSghhpvF17Oc5QAox9tQChaiM/b5/6
         LPMg==
X-Gm-Message-State: ACgBeo1B7LVCYjseqXuZqLer+p6tDGVpku2W4rJgouUG5oLGjz7OF2aj
        ggRfGS0QxfHCQ8xR9dtRsaHzL1Pfl+/iRA==
X-Google-Smtp-Source: AA6agR6O7+ypaB3T67I7WmgOj/uPM8WXy8Cfbmflr48VOzYqaYYM8aUivSkRqqMlWEX5Mj2QG9jA1Q==
X-Received: by 2002:a05:600c:34c6:b0:3a3:2549:1905 with SMTP id d6-20020a05600c34c600b003a325491905mr4722574wmq.204.1659708936242;
        Fri, 05 Aug 2022 07:15:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d52cd000000b0021d7fa77710sm3904865wrv.92.2022.08.05.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:15:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Ilya K <me@0upti.me>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] hook API: don't segfault on strbuf_addf() to NULL "out"
Date:   Fri,  5 Aug 2022 16:15:33 +0200
Message-Id: <patch-1.1-2450e3e65cf-20220805T141402Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1283.g2c56c4202c5
In-Reply-To: <0015309-00f1-9b44-023c-001ee3f242e4@0upti.me>
References: <0015309-00f1-9b44-023c-001ee3f242e4@0upti.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a logic error in a082345372e (hook API: fix v2.36.0 regression:
hooks should be connected to a TTY, 2022-06-07). When it started using
the "ungroup" API added in fd3aaf53f71 (run-command: add an "ungroup"
option to run_process_parallel(), 2022-06-07) it should have made the
same sort of change that fd3aaf53f71 itself made in
"t/helper/test-run-command.c".

The correct way to emit this "Couldn't start" output with "ungroup"
would be:

	fprintf(stderr, _("Couldn't start hook '%s'\n"), hook_path);

But we should instead remove the emitting of this output. As the added
test shows we already emit output when we can't run the child. The
"cannot run" output here is emitted by run-command.c's
child_err_spew().

So the addition of the "Couldn't start hook" output here in
96e7225b310 (hook: add 'run' subcommand, 2021-12-22) was always
redundant. For the pre-commit hook we'll now emit exactly the same
output as we did before f443246b9f2 (commit: convert
{pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22) (and
likewise for others).

We could at this point add this to the pick_next_hook() callbacks in
hook.c:

	assert(!out);
	assert(!*pp_task_cb);

And this to notify_start_failure() and notify_hook_finished() (in the
latter case the parameter is called "pp_task_cp"):

	assert(!out);
	assert(!pp_task_cb);

But let's leave any such instrumentation for some eventual cleanup of
the "ungroup" API.

Reported-by: Ilya K <me@0upti.me>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

As suspected I needed to bounce this off the CI once to due to the
OS-specific messaging around failed hooks, it passes now:
https://github.com/avar/git/actions/runs/2802782493

 hook.c          |  7 -------
 t/t1800-hook.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/hook.c b/hook.c
index d113ee7faae..a493939a4fc 100644
--- a/hook.c
+++ b/hook.c
@@ -62,9 +62,6 @@ static int pick_next_hook(struct child_process *cp,
 	strvec_push(&cp->args, hook_path);
 	strvec_pushv(&cp->args, hook_cb->options->args.v);
 
-	/* Provide context for errors if necessary */
-	*pp_task_cb = (char *)hook_path;
-
 	/*
 	 * This pick_next_hook() will be called again, we're only
 	 * running one hook, so indicate that no more work will be
@@ -80,13 +77,9 @@ static int notify_start_failure(struct strbuf *out,
 				void *pp_task_cp)
 {
 	struct hook_cb_data *hook_cb = pp_cb;
-	const char *hook_path = pp_task_cp;
 
 	hook_cb->rc |= 1;
 
-	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
-		    hook_path);
-
 	return 1;
 }
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 210f4298872..64096adac7e 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -151,4 +151,30 @@ test_expect_success TTY 'git commit: stdout and stderr are connected to a TTY' '
 	test_hook_tty commit -m"B.new"
 '
 
+test_expect_success 'git hook run a hook with a bad shebang' '
+	test_when_finished "rm -rf bad-hooks" &&
+	mkdir bad-hooks &&
+	write_script bad-hooks/test-hook "/bad/path/no/spaces" </dev/null &&
+
+	# TODO: We should emit the same (or at least a more similar)
+	# error on Windows and !Windows. See the OS-specific code in
+	# start_command()
+	if test_have_prereq !WINDOWS
+	then
+		cat >expect <<-\EOF
+		fatal: cannot run bad-hooks/test-hook: ...
+		EOF
+	else
+		cat >expect <<-\EOF
+		error: cannot spawn bad-hooks/test-hook: ...
+		EOF
+	fi &&
+	test_expect_code 1 git \
+		-c core.hooksPath=bad-hooks \
+		hook run test-hook >out 2>err &&
+	test_must_be_empty out &&
+	sed -e "s/test-hook: .*/test-hook: .../" <err >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.37.1.1283.g2c56c4202c5

