Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E656AC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjEARan (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEARal (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:30:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC281AF
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:30:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so3279624276.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 10:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682962239; x=1685554239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4bhUXFbiF4bDBth8+0aT6+Ugv+0NCjmWHyJojJZImE=;
        b=TEXz6SO5mmCv+GkMKqhITi4ensHvLiqBaEiaNV/maImGBJ362kajzmu2JNwumO/a8j
         es0aoM85h2dSaXq6OcaQyFvkkv19fhnTU6BR40BJdw0g4Qrxa5/1/yQkuOHTJyuawFs7
         2YHCT7RPKUas4EVqVC4L0je8+BZOOGIaISgfAAv7zJnaKDJBIZjPaaGPb91TrdtJAKz3
         6CTieeBYL0WY7PpGn89RvuprYYPxEWedUcmvfxSVk/gTamAqkTy4ueKF9dhRy5vL+duM
         tFOoMeMJVujO6vge+OlknZejB+hbQIGB1epF+YWtArsbbGjOJR7clbZjRPInjss5Q+Em
         e40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962239; x=1685554239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4bhUXFbiF4bDBth8+0aT6+Ugv+0NCjmWHyJojJZImE=;
        b=lA0ipmx/r5jGY2P9rD8VDG/VZIYZ8jdSuAjbSN58fzHvPxkerVYVqw485hY0L8IM4m
         3XAyt6qR0U+6bAhCj66/Y2aoqQDTpMJ6kHLCL7Zal7Fc6gGsETMyQKaRTNY67wtZtFoO
         ZL+C5SQb3zpzvR2tPiwPCvSwlnLFxKFXAeCZruwUTOxtB8QU6NFilfxfogLEVEyz3AvF
         yzzAmxY/YSy9Xvm8NrZV219JUW1O3b12au6f5OPGIcXBLwDoA51d2PcNfqG6WVCFBMhJ
         zPjfd0KwRm+Ybuzo7Xsi2Ba7X2h2QhqoLD5DDuJ9qYSVi8YAhmt57nwr9klLwkR2JUde
         iNIQ==
X-Gm-Message-State: AC+VfDy9XvNOwzEmKkhpp4QmhkhKI8ipw8CiLmN20BMKnrV383bueGXL
        TwaFpicyPpRV06yePf4G++rRROai6HClTegBTYLjvUw5bw8duNyMXHTZEWoK57PJniJoRGBU7yz
        zG/4+dmK57PvzobKkzTyzEyaYVuF+Ufcg7JG9bWt9ELcN+RI9P6cmLmgW3XlFxvQ=
X-Google-Smtp-Source: ACHHUZ6qsmehp73fg2zLMAyuUSff4LiLKCIrA5K3eqRJAffecrMtSSX/CVLvgolNxGZb8V/dGXSBQ1O5PAXxSg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:202:38fe:5256:e952:c2a3])
 (user=steadmon job=sendgmr) by 2002:a25:5305:0:b0:b92:5a75:9f55 with SMTP id
 h5-20020a255305000000b00b925a759f55mr8769617ybb.1.1682962239082; Mon, 01 May
 2023 10:30:39 -0700 (PDT)
Date:   Mon,  1 May 2023 10:30:37 -0700
In-Reply-To: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
Mime-Version: 1.0
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <e98be8e7f703fc741e06d9208545abc8c24d1a4a.1682962110.git.steadmon@google.com>
Subject: [PATCH v3] setup: trace bare repository setups
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chooglen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

safe.bareRepository=explicit is a safer default mode of operation, since
it guards against the embedded bare repository attack [1]. Most end
users don't use bare repositories directly, so they should be able to
set safe.bareRepository=explicit, with the expectation that they can
reenable bare repositories by specifying GIT_DIR or --git-dir.

However, the user might use a tool that invokes Git on bare repositories
without setting GIT_DIR (e.g. "go mod" will clone bare repositories
[2]), so even if a user wanted to use safe.bareRepository=explicit, it
wouldn't be feasible until their tools learned to set GIT_DIR.

To make this transition easier, add a trace message to note when we
attempt to set up a bare repository without setting GIT_DIR. This allows
users and tool developers to audit which of their tools are problematic
and report/fix the issue.  When they are sufficiently confident, they
would switch over to "safe.bareRepository=explicit".

Note that this uses trace2_data_string(), which isn't supported by the
"normal" GIT_TRACE2 target, only _EVENT or _PERF.

[1] https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com/
[2] https://go.dev/ref/mod

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
I'm sending a lightly-adapted version of Glen's tracing patch because
Glen will be on vacation next week and we'd like to get this upstream
ASAP.

Changes in V3: added a test_unconfig test case for safe.bareRepository
Changes in V2: cleaned up test-style issues.

Range-diff against v2:
1:  b548d96db7 ! 1:  e98be8e7f7 setup: trace bare repository setups
    @@ t/t0035-safe-bare-repository.sh: TEST_PASSES_SANITIZE_LEAK=true
     +expect_accepted_implicit () {
     +	test_when_finished 'rm "$pwd/trace.perf"' &&
     +	GIT_TRACE2_PERF="$pwd/trace.perf" git "$@" rev-parse --git-dir &&
    ++	# Note: we're intentionally only checking that the bare repo has a
    ++	# directory *prefix* of $pwd
     +	grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
     +}
     +
    @@ t/t0035-safe-bare-repository.sh: TEST_PASSES_SANITIZE_LEAK=true
      
      test_expect_success 'setup bare repo in worktree' '
     @@ t/t0035-safe-bare-repository.sh: test_expect_success 'setup bare repo in worktree' '
    - 	git init --bare outer-repo/bare-repo
      '
      
    --test_expect_success 'safe.bareRepository unset' '
    + test_expect_success 'safe.bareRepository unset' '
     -	expect_accepted -C outer-repo/bare-repo
    --'
    --
    ++	test_unconfig --global safe.bareRepository &&
    ++	expect_accepted_implicit -C outer-repo/bare-repo
    + '
    + 
      test_expect_success 'safe.bareRepository=all' '
      	test_config_global safe.bareRepository all &&
     -	expect_accepted -C outer-repo/bare-repo

 setup.c                         |  1 +
 t/t0035-safe-bare-repository.sh | 32 +++++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index 59abc16ba6..458582207e 100644
--- a/setup.c
+++ b/setup.c
@@ -1352,6 +1352,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		}
 
 		if (is_git_directory(dir->buf)) {
+			trace2_data_string("setup", NULL, "implicit-bare-repository", dir->buf);
 			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT)
 				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
index 11c15a48aa..038b8b788d 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -7,13 +7,26 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 pwd="$(pwd)"
 
-expect_accepted () {
-	git "$@" rev-parse --git-dir
+expect_accepted_implicit () {
+	test_when_finished 'rm "$pwd/trace.perf"' &&
+	GIT_TRACE2_PERF="$pwd/trace.perf" git "$@" rev-parse --git-dir &&
+	# Note: we're intentionally only checking that the bare repo has a
+	# directory *prefix* of $pwd
+	grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
+}
+
+expect_accepted_explicit () {
+	test_when_finished 'rm "$pwd/trace.perf"' &&
+	GIT_DIR="$1" GIT_TRACE2_PERF="$pwd/trace.perf" git rev-parse --git-dir &&
+	! grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
 }
 
 expect_rejected () {
-	test_must_fail git "$@" rev-parse --git-dir 2>err &&
-	grep -F "cannot use bare repository" err
+	test_when_finished 'rm "$pwd/trace.perf"' &&
+	test_env GIT_TRACE2_PERF="$pwd/trace.perf" \
+		test_must_fail git "$@" rev-parse --git-dir 2>err &&
+	grep -F "cannot use bare repository" err &&
+	grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
 }
 
 test_expect_success 'setup bare repo in worktree' '
@@ -22,12 +35,13 @@ test_expect_success 'setup bare repo in worktree' '
 '
 
 test_expect_success 'safe.bareRepository unset' '
-	expect_accepted -C outer-repo/bare-repo
+	test_unconfig --global safe.bareRepository &&
+	expect_accepted_implicit -C outer-repo/bare-repo
 '
 
 test_expect_success 'safe.bareRepository=all' '
 	test_config_global safe.bareRepository all &&
-	expect_accepted -C outer-repo/bare-repo
+	expect_accepted_implicit -C outer-repo/bare-repo
 '
 
 test_expect_success 'safe.bareRepository=explicit' '
@@ -47,7 +61,7 @@ test_expect_success 'safe.bareRepository in the repository' '
 
 test_expect_success 'safe.bareRepository on the command line' '
 	test_config_global safe.bareRepository explicit &&
-	expect_accepted -C outer-repo/bare-repo \
+	expect_accepted_implicit -C outer-repo/bare-repo \
 		-c safe.bareRepository=all
 '
 
@@ -60,4 +74,8 @@ test_expect_success 'safe.bareRepository in included file' '
 	expect_rejected -C outer-repo/bare-repo
 '
 
+test_expect_success 'no trace when GIT_DIR is explicitly provided' '
+	expect_accepted_explicit "$pwd/outer-repo/bare-repo"
+'
+
 test_done

base-commit: 2807bd2c10606e590886543afe4e4f208dddd489
-- 
2.40.1.495.gc816e09b53d-goog

