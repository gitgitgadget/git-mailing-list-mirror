Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EB4C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386921AbhLFQTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357463AbhLFQS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:18:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24555C08E886
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:11:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so10800087wmj.5
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZ/21kSufmPE1z6dLC3YKlsyjbpoRbO28TtrBRfXmSI=;
        b=RqWFkUFc3WmjKVtBIk/JsbDifu9b50pk9mPZYVDztKZt3BVqDyGVfVkOIGxKYuqQ5S
         WiPWAvmZgNk2mK7ZBbyCQMmjqpe/WLGcTPaapZsmd/WxnMLR/pNKx62BqrlhRdV3S8s9
         HBlnBQHnzBZ7TRs5n+miki7z/ioLfngDBmW2NSeaKeh6cEeqCnuJLfaDPS91X64XrD9u
         /yTDirWpo2TkWTzmYrjbSL1YBesEed6EzY9duOXNZDVpVdfUsnuj25uWZzHpgQ3ytJEt
         dh7gCrN0NeStzIh2RpwA4oy+vRNwj0F9/sety4MtAxsjh3ehcZo6JfhWUR3umnILqZ/V
         FiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZ/21kSufmPE1z6dLC3YKlsyjbpoRbO28TtrBRfXmSI=;
        b=kmLZSXo5LVGsw4tYqn6zNvEGkehHMaMitg+fv/cN8kQ8oph+kUHpmoQ3gbdw3Nkpue
         uad8raNChdD1FXTO9Q44e7wrVYMWytQ9uN7ECfcX6uBwo6Vmo6LrKnZWnUhVABNCsd3H
         RTiDXA7jJAYhM4AD+snM9I1fBNiTgaduGMhJh23Rd72Id75Kfaok9itDwi9VDgBYa/bd
         3L4GYF7eWXY5jlpx0bj1flFqTfzXTsK9XTHCGBeE5XKbAZfOgBZ3Ikuy0QQeTsuF9+FQ
         oRChpWixl0IexD2DaB8sQceYr1cnd4Rn9abQfpcUZ1y7Osjzt1fqFydaYrzerk90G78k
         9Stw==
X-Gm-Message-State: AOAM531hEsrKlk5bZdUWwYjHgn7aBRV5QPZZLAnvHjiXJQrpLqZO5ljS
        x/aiAy+cz/rgIbRN9kiW29YZeWqbpG7hMg==
X-Google-Smtp-Source: ABdhPJwci+PBtDLQpYA8GlJq1PzEQJdreJcC2jdqdYAiNwTe5DFnpIOLQD7ObCLgrZ9aKUjA+ikk5A==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr39867170wmh.164.1638807080228;
        Mon, 06 Dec 2021 08:11:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e24sm12187008wra.78.2021.12.06.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:11:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v1] common-main.c: call exit(), don't return
Date:   Mon,  6 Dec 2021 17:11:03 +0100
Message-Id: <patch-v1-1.1-6fedf9969b6-20211206T161001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the main() function to call "exit()" instead of ending with a
"return" statement. The "exit()" function is our own wrapper that
calls trace2_cmd_exit_fl() for us, from git-compat-util.h:

	#define exit(code) exit(trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))

That "exit()" wrapper has been in use ever since ee4512ed481 (trace2:
create new combined trace facility, 2019-02-22).

This changes nothing about how we "exit()", as we'd invoke
"trace2_cmd_exit_fl()" in both cases due to the wrapper, this change
makes it easier to reason about this code, as we're now always
obviously relying on our "exit()" wrapper.

There is already code immediately downstream of our "main()" which has
a hard reliance on that, e.g. the various "exit()" calls downstream of
"cmd_main()" in "git.c".

We even had a comment in "t/helper/test-trace2.c" that seemed to be
confused about how the "exit()" wrapper interacted with uses of
"return", even though it was introduced in the same trace2 series in
a15860dca3f (trace2: t/helper/test-trace2, t0210.sh, t0211.sh,
t0212.sh, 2019-02-22), after the aforementioned ee4512ed481. Perhaps
it pre-dated the "exit()" wrapper?

Let's also update both the documentation and comments accordingly: The
documentation added in e544221d97a (trace2:
Documentation/technical/api-trace2.txt, 2019-02-22) already said of
the "exit" event that "[it] is emitted when git calls `exit()". But
the "main()" example then called trace2_cmd_exit(). Let's have it
invoke "exit()" instead, as the code in "common-main.c" now does.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

The diffstat here is neutral, and as noted this changes no behavior,
so this isn't really needed for anything.

But as argued above I think this makes things a lot easier for readers
of the code. I've had at least a couple of traces through git's
execution from command-main.c downwards and thought that the "exit()"
calls in git.c might be a bug, until I (re-)discovered that we're
defining an exit() wrapper via a macro.

It might be a good follow-up at some point to see if we could hoist
some of the cleanups we do in run_builtin() to to this level. I.e. the
code referenced in my 338abb0f045 (builtins + test helpers: use return
instead of exit() in cmd_*, 2021-06-08) (and similar).

Even that code could probably do with some tweaks, e.g. we should
probably try to fflush() stdout/stderr even if we're about to return
non-zero (now we'll only do it on success).

But for now this is one small readability improvement to some code
central to git's execution.

A version of this was originally submitted as
https://lore.kernel.org/git/RFC-patch-07.21-3f897bf6b0e-20211115T220831Z-avarab@gmail.com/;
range-diff against that initial version below.

Range-diff against v0:
1:  3f897bf6b0e ! 1:  6fedf9969b6 common-main.c: call exit(), don't return
    @@ Metadata
      ## Commit message ##
         common-main.c: call exit(), don't return
     
    -    Refactor the main() function so that we always take the same path
    -    towards trace2_cmd_exit() whether exit() is invoked, or we end up in
    -    the "return" in the pre-image. This contains no functional change, and
    -    is only intended for the benefit of readers of the code, who'll now be
    -    pointed to our exit() wrapper.
    -
    -    Since ee4512ed481 (trace2: create new combined trace facility,
    -    2019-02-22) we've defined "exit" with a macro to call
    -    trace2_cmd_exit() for us in "git-compat-util.h". So in cases where an
    -    exit() is invoked (such as in several places in "git.c") we don't
    -    reach the trace2_cmd_exit() in the pre-image. This makes it so that
    -    we'll always take that same exit() path.
    +    Change the main() function to call "exit()" instead of ending with a
    +    "return" statement. The "exit()" function is our own wrapper that
    +    calls trace2_cmd_exit_fl() for us, from git-compat-util.h:
    +
    +            #define exit(code) exit(trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
    +
    +    That "exit()" wrapper has been in use ever since ee4512ed481 (trace2:
    +    create new combined trace facility, 2019-02-22).
    +
    +    This changes nothing about how we "exit()", as we'd invoke
    +    "trace2_cmd_exit_fl()" in both cases due to the wrapper, this change
    +    makes it easier to reason about this code, as we're now always
    +    obviously relying on our "exit()" wrapper.
    +
    +    There is already code immediately downstream of our "main()" which has
    +    a hard reliance on that, e.g. the various "exit()" calls downstream of
    +    "cmd_main()" in "git.c".
    +
    +    We even had a comment in "t/helper/test-trace2.c" that seemed to be
    +    confused about how the "exit()" wrapper interacted with uses of
    +    "return", even though it was introduced in the same trace2 series in
    +    a15860dca3f (trace2: t/helper/test-trace2, t0210.sh, t0211.sh,
    +    t0212.sh, 2019-02-22), after the aforementioned ee4512ed481. Perhaps
    +    it pre-dated the "exit()" wrapper?
    +
    +    Let's also update both the documentation and comments accordingly: The
    +    documentation added in e544221d97a (trace2:
    +    Documentation/technical/api-trace2.txt, 2019-02-22) already said of
    +    the "exit" event that "[it] is emitted when git calls `exit()". But
    +    the "main()" example then called trace2_cmd_exit(). Let's have it
    +    invoke "exit()" instead, as the code in "common-main.c" now does.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## Documentation/technical/api-trace2.txt ##
    +@@ Documentation/technical/api-trace2.txt: Initialization::
    + ----------------
    + int main(int argc, const char **argv)
    + {
    +-	int exit_code;
    +-
    + 	trace2_initialize();
    + 	trace2_cmd_start(argv);
    + 
    +-	exit_code = cmd_main(argc, argv);
    +-
    +-	trace2_cmd_exit(exit_code);
    +-
    +-	return exit_code;
    ++	/* Our exit() will call trace2_cmd_exit_fl() */
    ++	exit(cmd_main(argc, argv));
    + }
    + ----------------
    + 
    +
      ## common-main.c ##
     @@ common-main.c: int main(int argc, const char **argv)
      
    @@ common-main.c: int main(int argc, const char **argv)
     +	 */
     +	exit(result);
      }
    +
    + ## t/helper/test-trace2.c ##
    +@@ t/helper/test-trace2.c: static int print_usage(void)
    +  *    [] the "cmd_name" event has been generated.
    +  *    [] this writes various "def_param" events for interesting config values.
    +  *
    +- * We further assume that if we return (rather than exit()), trace2_cmd_exit()
    +- * will be called by test-tool.c:cmd_main().
    ++ * It doesn't matter if we "return" here or call "exit()", since our
    ++ * "exit()" is a wrapper that will call trace2_cmd_exit_fl. It would
    ++ * matter if we bypassed it and called "_exit()". Even if it doesn't
    ++ * matter for the narrow case of trace2 testing, let's be nice to
    ++ * test-tool.c's "cmd_main()" and common-main.c's "main()" and
    ++ * "return" here.
    +  */
    + int cmd__trace2(int argc, const char **argv)
    + {
    +
    + ## trace2.h ##
    +@@ trace2.h: void trace2_cmd_start_fl(const char *file, int line, const char **argv);
    +  */
    + int trace2_cmd_exit_fl(const char *file, int line, int code);
    + 
    +-#define trace2_cmd_exit(code) (trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
    +-
    + /*
    +  * Emit an 'error' event.
    +  *

 Documentation/technical/api-trace2.txt | 9 ++-------
 common-main.c                          | 9 ++++++---
 t/helper/test-trace2.c                 | 8 ++++++--
 trace2.h                               | 2 --
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index bb13ca3db8b..568a909222a 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -828,16 +828,11 @@ Initialization::
 ----------------
 int main(int argc, const char **argv)
 {
-	int exit_code;
-
 	trace2_initialize();
 	trace2_cmd_start(argv);
 
-	exit_code = cmd_main(argc, argv);
-
-	trace2_cmd_exit(exit_code);
-
-	return exit_code;
+	/* Our exit() will call trace2_cmd_exit_fl() */
+	exit(cmd_main(argc, argv));
 }
 ----------------
 
diff --git a/common-main.c b/common-main.c
index 71e21dd20a3..eafc70718a5 100644
--- a/common-main.c
+++ b/common-main.c
@@ -51,7 +51,10 @@ int main(int argc, const char **argv)
 
 	result = cmd_main(argc, argv);
 
-	trace2_cmd_exit(result);
-
-	return result;
+	/*
+	 * We define exit() to call trace2_cmd_exit_fl() in
+	 * git-compat-util.h. Whether we reach this or exit()
+	 * elsewhere we'll always run our trace2 exit handler.
+	 */
+	exit(result);
 }
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index f93633f895a..9954010bc89 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -262,8 +262,12 @@ static int print_usage(void)
  *    [] the "cmd_name" event has been generated.
  *    [] this writes various "def_param" events for interesting config values.
  *
- * We further assume that if we return (rather than exit()), trace2_cmd_exit()
- * will be called by test-tool.c:cmd_main().
+ * It doesn't matter if we "return" here or call "exit()", since our
+ * "exit()" is a wrapper that will call trace2_cmd_exit_fl. It would
+ * matter if we bypassed it and called "_exit()". Even if it doesn't
+ * matter for the narrow case of trace2 testing, let's be nice to
+ * test-tool.c's "cmd_main()" and common-main.c's "main()" and
+ * "return" here.
  */
 int cmd__trace2(int argc, const char **argv)
 {
diff --git a/trace2.h b/trace2.h
index 0cc7b5f5312..73876781294 100644
--- a/trace2.h
+++ b/trace2.h
@@ -110,8 +110,6 @@ void trace2_cmd_start_fl(const char *file, int line, const char **argv);
  */
 int trace2_cmd_exit_fl(const char *file, int line, int code);
 
-#define trace2_cmd_exit(code) (trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
-
 /*
  * Emit an 'error' event.
  *
-- 
2.34.1.898.g5a552c2e5f0

