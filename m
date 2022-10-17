Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C7DC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 12:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJQMKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiJQMKH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 08:10:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD691EAC6
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u10so18162200wrq.2
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emTznePtSGl6JWuuq2u4y67G03bEQqTRv4fnOhZLO3c=;
        b=XctQ1gdYLk50OStNcQhhD8b9C9iimbei5NUg8AvD3fvpGSv4HJb0TgUhS1UtuvKMID
         24nOABrSXTq0R2FBOUGt1MA7n0pM33IjMr5kkTdyxGvZ6xHLf8/KSfSHxMqSwIq5yTqJ
         ow8zC+9nk/dN6TWcQFUViAHj1rCp33wSYY/zR4f0/c1d0e2d6i/hCpSKaj+a84hvPjq2
         I2ZggK1/mxqgPA7HKsHogi+JHNBMZ/C1gW42OCn9kwhS1lhWjcl3G0cbAuMxN6AebirN
         vnAF3M1josAwU0lnOlaqq9AF6TpWOeNjkQ5B+Ngg6wbQI8CqKaomUiMy9gSUp2l+S6e+
         sj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emTznePtSGl6JWuuq2u4y67G03bEQqTRv4fnOhZLO3c=;
        b=hkIAFSvkqCZFryEDPI1L2Mhtwkk1v2sLaMxx26GqSWF0RlCAp4lUaSxzzT0GaECocc
         jwpUn14GJayklRrY1bMjbB8kDxVMXUZ0f5V+WJmhtdHPOWcNo/nPl+Z/iVeYzKrwyTc5
         r9ZRSYhBhyJsoIjNyAwl4DNePrm/pW0IAcC+c18kDcOwbrVZnqEMxqtnXnqhklFpk/kZ
         iPkHxJL+TFxpu0hs0X9FcEzeMHxLxL1/1jYAcUNN8iPcVp7m3PyuZVdvFoCFQt2qPP/I
         MHpIviRw6artjk6hYt6IOcQnQsCxROBJFHLZf0IoxAnqVFZbW7o2ePHiIwjqeDQiR/JP
         KSbw==
X-Gm-Message-State: ACrzQf2VQIKXc0628J2RQIJi3RPoha+Gns5dxPH3/s8Lpy/stBlf5oP2
        RDhwIngDpOgQiqBGyoMLXJ644R9ew82gEw==
X-Google-Smtp-Source: AMsMyM48Yyn0ioZaB4jEccOdgjKhpyTak3C6l1f5SLVwnqzki93WCEvnhMGwIAoW6rMkNsdz3hpLIA==
X-Received: by 2002:a05:6000:1861:b0:232:2471:d405 with SMTP id d1-20020a056000186100b002322471d405mr6014848wri.130.1666008581021;
        Mon, 17 Oct 2022 05:09:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm10028770wma.45.2022.10.17.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:09:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/10] submodule: don't use a subprocess to invoke "submodule--helper"
Date:   Mon, 17 Oct 2022 14:09:25 +0200
Message-Id: <patch-10.10-81f138e460c-20221017T115544Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1091.gf9d18265e59
In-Reply-To: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a preceding commit we created "builtin/submodule.c" and faithfully
tried to reproduce every aspect of "git-submodule.sh", including its
invocation of "git submodule--helper" as a sub-process.

Let's do away with the sub-process and invoke
"cmd_submodule__helper()" directly. Eventually we'll want to do away
with "builtin/submodule--helper.c" altogether, but let's not do that
for now to avoid conflicts with other in-flight topics. Even without
those conflicts the resulting diff would be large. We can leave that
for a later cleanup.

This speeds up invocations of all "git submodule" commands, E.g. a
trivial "foreach" command on git.git is around 1.50 times
faster[1]. For more expensive commands this'll make less of a
difference, as the fixed cost of invoking the sub-process will be
amortized away.

	$ git hyperfine -L rev HEAD~1,HEAD -s 'make CFLAGS=-O3' './git submodule foreach "echo \$name"'
	Benchmark 1: ./git submodule foreach "echo \$name"' in 'HEAD~1
	  Time (mean ± σ):       9.7 ms ±   0.1 ms    [User: 7.6 ms, System: 2.1 ms]
	  Range (min … max):     9.4 ms …  10.2 ms    285 runs

	Benchmark 2: ./git submodule foreach "echo \$name"' in 'HEAD
	  Time (mean ± σ):       6.6 ms ±   0.1 ms    [User: 5.1 ms, System: 1.5 ms]
	  Range (min … max):     6.2 ms …   7.2 ms    414 runs

	Summary
	  './git submodule foreach "echo \$name"' in 'HEAD' ran
	    1.48 ± 0.04 times faster than './git submodule foreach "echo \$name"' in 'HEAD~1'

It's also worth noting that some users were using e.g. "git
submodule--helper list" directly for performance reasons[2]. With
31955475d1c (submodule--helper: remove unused "list" helper,
2022-09-01) released with v2.38.0 the "list" command was no longer
provided. Users who had to switch to "git submodule--helper foreach"
were given a command that (on my system) is around 6.5x slower.

Now the "foreach" is around 0.10x slower (due to the slight shell
overhead), with 31955475d1c reverted on top of this:

	$ hyperfine './git submodule--helper list' './git submodule foreach --quiet "echo \$name"' --warmup 10
	Benchmark 1: ./git submodule--helper list
	  Time (mean ± σ):       6.4 ms ±   0.1 ms    [User: 5.0 ms, System: 1.5 ms]
	  Range (min … max):     6.2 ms …   7.2 ms    427 runs

	Benchmark 2: ./git submodule foreach --quiet "echo \$name"
	  Time (mean ± σ):       7.0 ms ±   0.1 ms    [User: 4.8 ms, System: 2.3 ms]
	  Range (min … max):     6.8 ms …   7.4 ms    390 runs

	Summary
	  './git submodule--helper list' ran
	    1.10 ± 0.03 times faster than './git submodule foreach --quiet "echo \$name"'

I think it would make sense to implement a "--format" option for "git
submodule foreach" to help anyone who cares about that remaining
performance (and to improve the API, e.g. by supporting "-z"), but as
far as performance goes this makes the runtime acceptable again.

The pattern in "cmd_submodule_builtin()" of saving "struct strvec"
arguments to a "struct string_list" and free()-ing them after the
"argv" has been modified by "cmd_submodule__helper()" is new, without
it we'd get various already-passing tests failing under SANITIZE=leak.

1. Using the "git hyperfine" wrapper for "hyperfine":
   https://lore.kernel.org/git/211201.86r1aw9gbd.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/87czatrpyb.fsf@bernoul.li/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule.c b/builtin/submodule.c
index ca8e273b6e9..13e7064b03f 100644
--- a/builtin/submodule.c
+++ b/builtin/submodule.c
@@ -119,12 +119,40 @@ static void setup_helper_args(int argc, const char **argv, const char *prefix,
 	strvec_pushv(args, argv);
 }
 
+static int cmd_submodule_builtin(struct strvec *args, const char *prefix)
+{
+	size_t i;
+	struct string_list to_free = STRING_LIST_INIT_DUP;
+	int ret;
+
+	/*
+	 * The cmd_submodule__helper() will treat the argv as
+	 * its own and modify it, so e.g. for "git submodule
+	 * add" the "add" argument will be removed, and we'll
+	 * thus leak from the strvec_push()'s in
+	 * setup_helper_args().
+	 *
+	 * So in lieu of some generic "snapshot for a free"
+	 * API for "struct strvec" squirrel away the pointers
+	 * to free with string_list_clear() later.
+	 */
+	for (i = 0; i < args->nr; i++)
+		string_list_append_nodup(&to_free, (char *)args->v[i]);
+
+	ret = cmd_submodule__helper(args->nr, args->v, prefix);
+
+	string_list_clear(&to_free, 0);
+	free(strvec_detach(args));
+
+	return ret;
+}
+
 int cmd_submodule(int argc, const char **argv, const char *prefix)
 {
 	int opt_quiet = 0;
 	int opt_cached = 0;
 	int opt_recursive = 0;
-	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strvec args = STRVEC_INIT;
 	struct option options[] = {
 		OPT__QUIET(&opt_quiet, N_("be quiet")),
 		OPT_BOOL(0, "cached", &opt_cached,
@@ -141,13 +169,10 @@ int cmd_submodule(int argc, const char **argv, const char *prefix)
 	 * Tell the rest of git that any URLs we get don't come
 	 * directly from the user, so it can apply policy as appropriate.
 	 */
-	strvec_push(&cp.env, "GIT_PROTOCOL_FROM_USER=0");
-	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
-			  opt_recursive, &cp.args, options);
+	xsetenv("GIT_PROTOCOL_FROM_USER", "0", 1);
 
-	cp.git_cmd = 1;
-	cp.no_stdin = 0; /* for git submodule foreach */
-	cp.dir = startup_info->original_cwd;
+	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
+			  opt_recursive, &args, options);
 
-	return run_command(&cp);
+	return cmd_submodule_builtin(&args, prefix);
 }
-- 
2.38.0.1091.gf9d18265e59

