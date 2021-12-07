Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A75DC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 10:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhLGKR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 05:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhLGKR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 05:17:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C37C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 02:13:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i5so28417648wrb.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 02:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iN2sizviNeo7alt8kn457w5eCpStJHqP5tvSyQeiK5g=;
        b=MvdnVwRAJyiB+/vvhZ1os+UKdcovyyCEO9PcTg6mIFzO9+ovT7jsQnAnEOLD9NqUCC
         okUlrxvij7HGVqNI9EcR0+r7DhK3VwsKNM423sdsGR2fGdjGSTiI9fLJUersk4xBkaxp
         csTUJB3AXcQiVdi75Q5xm7HSYhF+2L7kreHYdYQ11BDsERYLoY+jc67ZV61lERk0pZ97
         7L2jk4OKFjQ1+94OSlQ6x6Ob30sDFPyO+HQhk8tKSfDFrv1d99tRyIe6tL3W93UEaRFf
         1gTZ4BQG2SqGpWvetCTKiPJsutymrESNQRPj6YrzDYLItWFRVD6AK6M7gXIAcd3fQFY2
         lfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iN2sizviNeo7alt8kn457w5eCpStJHqP5tvSyQeiK5g=;
        b=Q7hVHB/KaCX4l/Wqv/v/AEyDXN9dvUdu6xmp70SafMFjuoCDSJVP7YQSTwvpHr9TvR
         hUSb1q0QnButjsQ5o0mGa1T6kyyrT+9rFHwnftaiVgve6rdZ8VWGpjPqSoAW4xp2r2t8
         193wXK6hJQiH3ypbQiVOZDV/e6IQP46C0p2SFOXWgcG0o5bkhRjJXWo78P+R5UfUhv1t
         CR4O0DFoaNS39omJsHH4YaZGGPEF+P+ULWA37RzZ9H6vPFE/oBDG8Ua7gRz+CLLOKYHO
         kVc9Gk4n+rrVR/wyx3MsRXIvG9Xd5uLtM8hM25CUGCdnIYg3w/a3RGDCh/Axpfuy1MTw
         5bbw==
X-Gm-Message-State: AOAM531fYb490D1B/BebQNXBeO0+rGFqq7QCAVWi8fEo3fLKhPeVc8E2
        HPDw5fF4zmMxM9hTz3grPgv8SBfcQNoqYw==
X-Google-Smtp-Source: ABdhPJy32v6Sz3VMzYX36eFb0ytCpJDFZkS2ss/mEV1pNRrRbbp8H2mgmAMtDQv8K3CPuv/JdFsa0g==
X-Received: by 2002:a5d:64e7:: with SMTP id g7mr46986884wri.350.1638872035216;
        Tue, 07 Dec 2021 02:13:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g13sm19032046wrd.57.2021.12.07.02.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 02:13:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] common-main.c: call exit(), don't return
Date:   Tue,  7 Dec 2021 11:13:51 +0100
Message-Id: <patch-v2-1.1-4f52ecc94ba-20211207T101207Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <patch-v1-1.1-6fedf9969b6-20211206T161001Z-avarab@gmail.com>
References: <patch-v1-1.1-6fedf9969b6-20211206T161001Z-avarab@gmail.com>
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

This change makes the "trace2_cmd_exit()" macro orphaned, we now
always use "trace2_cmd_exit_fl()" directly, but let's keep that
simpler example in place. Even if we're unlikely to get another
"main()" other than the one in our "common-main.c", there's some value
in having the API documentation and example discuss a simpler version
that doesn't require an "exit()" wrapper macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Junio: I think this addresses all the feedback you had on the v1 in
[1]. Thanks for the review.

I wasn't sure what trade-off to strike with leaving that small amount
of dead in-tree code, but per the updated commit message I think it
makes sense to have the API docs discuss the simpler example & keep
the macro, as you suggest.

1. https://lore.kernel.org/git/xmqqzgpdfub1.fsf@gitster.g/

Range-diff against v1:
1:  6fedf9969b6 ! 1:  4f52ecc94ba common-main.c: call exit(), don't return
    @@ Commit message
         t0212.sh, 2019-02-22), after the aforementioned ee4512ed481. Perhaps
         it pre-dated the "exit()" wrapper?
     
    -    Let's also update both the documentation and comments accordingly: The
    -    documentation added in e544221d97a (trace2:
    -    Documentation/technical/api-trace2.txt, 2019-02-22) already said of
    -    the "exit" event that "[it] is emitted when git calls `exit()". But
    -    the "main()" example then called trace2_cmd_exit(). Let's have it
    -    invoke "exit()" instead, as the code in "common-main.c" now does.
    +    This change makes the "trace2_cmd_exit()" macro orphaned, we now
    +    always use "trace2_cmd_exit_fl()" directly, but let's keep that
    +    simpler example in place. Even if we're unlikely to get another
    +    "main()" other than the one in our "common-main.c", there's some value
    +    in having the API documentation and example discuss a simpler version
    +    that doesn't require an "exit()" wrapper macro.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## Documentation/technical/api-trace2.txt ##
    -@@ Documentation/technical/api-trace2.txt: Initialization::
    - ----------------
    - int main(int argc, const char **argv)
    - {
    --	int exit_code;
    --
    - 	trace2_initialize();
    - 	trace2_cmd_start(argv);
    - 
    --	exit_code = cmd_main(argc, argv);
    --
    --	trace2_cmd_exit(exit_code);
    --
    --	return exit_code;
    -+	/* Our exit() will call trace2_cmd_exit_fl() */
    -+	exit(cmd_main(argc, argv));
    - }
    - ----------------
    - 
    -
      ## common-main.c ##
     @@ common-main.c: int main(int argc, const char **argv)
      
    @@ t/helper/test-trace2.c: static int print_usage(void)
       *
     - * We further assume that if we return (rather than exit()), trace2_cmd_exit()
     - * will be called by test-tool.c:cmd_main().
    -+ * It doesn't matter if we "return" here or call "exit()", since our
    -+ * "exit()" is a wrapper that will call trace2_cmd_exit_fl. It would
    -+ * matter if we bypassed it and called "_exit()". Even if it doesn't
    -+ * matter for the narrow case of trace2 testing, let's be nice to
    -+ * test-tool.c's "cmd_main()" and common-main.c's "main()" and
    -+ * "return" here.
    ++ * We return from here and let test-tool.c::cmd_main() pass the exit
    ++ * code to common-main.c::main(), which will use it to call
    ++ * trace2_cmd_exit().
       */
      int cmd__trace2(int argc, const char **argv)
      {
    -
    - ## trace2.h ##
    -@@ trace2.h: void trace2_cmd_start_fl(const char *file, int line, const char **argv);
    -  */
    - int trace2_cmd_exit_fl(const char *file, int line, int code);
    - 
    --#define trace2_cmd_exit(code) (trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
    --
    - /*
    -  * Emit an 'error' event.
    -  *

 common-main.c          | 9 ++++++---
 t/helper/test-trace2.c | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

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
index f93633f895a..59b124bb5f1 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -262,8 +262,9 @@ static int print_usage(void)
  *    [] the "cmd_name" event has been generated.
  *    [] this writes various "def_param" events for interesting config values.
  *
- * We further assume that if we return (rather than exit()), trace2_cmd_exit()
- * will be called by test-tool.c:cmd_main().
+ * We return from here and let test-tool.c::cmd_main() pass the exit
+ * code to common-main.c::main(), which will use it to call
+ * trace2_cmd_exit().
  */
 int cmd__trace2(int argc, const char **argv)
 {
-- 
2.34.1.898.g5a552c2e5f0

