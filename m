Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CCBC77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 17:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjD1RWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjD1RWO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 13:22:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6973126
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 10:22:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559d30ec7fcso577097b3.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682702532; x=1685294532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvF2aaNGeLXz9xv0DaPPApaLcQBMnowgmUMaL8wG5/I=;
        b=Vrvi1bmbzWXdOEvRjS6eLx1jQzYGp5UtmeCXMhiEJzpx2zF6H9gVdBa8BN+x1SPGJ/
         CBLMvYwd9Lg6I8HWA86bRHxpyRF0T9Qpcb53OiN/rkwQp1Wy9ny4c/WX63rXIENvxBOr
         FW0+rP+3hZM2FcptvSnqtqoPy4dcUs9vYdSgadSaTe4CUfyPhaJdClQnH9tFh5D22xbn
         n2yemXg2BWkbdpny9+Ydc/qg8Wadopd9MInCWHnmANVQuMv/lZpudn2sS6zKtpVi9hwO
         0Q8Hr7X78hO6od936fL4o8Ltj2rPbNWAoMKJfjbKgNUzjXz8TV6vzQ1imezWT7YIOtUE
         0H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682702532; x=1685294532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvF2aaNGeLXz9xv0DaPPApaLcQBMnowgmUMaL8wG5/I=;
        b=TSd9Ap8FcTpiK5LIrBR3FoqAwuicsp2swQee8CSeMmTWTUxWaANhuo4pZz+QmVdmwX
         cUkasGYzeQsyC2/v1tj/RDJv9hkLLWqrGHIoiak0oDQO/HsjLoDsZf3LtDUBXB3JqXXc
         Wps7OVTepNq7uE/kylrdZv85NOm4byL9HeuRe8Zr7eia1QWZZaCKB8DWEcEUopneoxrv
         2YNv6mmD8in0tKh/WminQsP5bS9TgfLYbPcoMxCKH5qUK+bszev4QggX3n9e51t1MBu+
         JJJUdceshR4/godkHBgGnjgy+Vgdk/BEtqzqa6XMz+Lw8Ej5SI4SjCr0SWwPmiCiHhrd
         tDYA==
X-Gm-Message-State: AC+VfDykcvMt3pJiaGZSsuOp9piancEqV6NFCklp0uFBw+/KMK/CgQFa
        NLoAzTQenjYzcXgyRB3QkA1S4u3lk1ltwq5uui+Ikkf+bnA0cvQ7jfR911ZrkyooisMqxZt056G
        JfZ/KT8oCX55rRUJHtoSJbIYFHURcvnbQ0UdfnC0Pe7Nd6FnNHpHuctCm67Mu46A=
X-Google-Smtp-Source: ACHHUZ7E1suJjv7V9+glQ0Y8ksvxYRGkJ3PPYagvx6Z8hs2WgOIvCV+M5ruzb9cqN0WRn+ENHzX5F3v//0JQnQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:202:d2c3:4cc2:f9f7:57a9])
 (user=steadmon job=sendgmr) by 2002:a81:c742:0:b0:552:e3fa:6756 with SMTP id
 i2-20020a81c742000000b00552e3fa6756mr3552790ywl.2.1682702532125; Fri, 28 Apr
 2023 10:22:12 -0700 (PDT)
Date:   Fri, 28 Apr 2023 10:22:10 -0700
In-Reply-To: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
Mime-Version: 1.0
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <b548d96db7052dc2cb664922fa2003fe068843cf.1682702058.git.steadmon@google.com>
Subject: [PATCH v2] setup: trace bare repository setups
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     chooglen@google.com, gitster@pobox.com
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

Cleaned up some test-style issues since V1.

Range-diff against v1:
1:  cb72bca46c ! 1:  b548d96db7 setup: trace bare repository setups
    @@ t/t0035-safe-bare-repository.sh: TEST_PASSES_SANITIZE_LEAK=true
     -expect_accepted () {
     -	git "$@" rev-parse --git-dir
     +expect_accepted_implicit () {
    -+	test_when_finished "rm \"$pwd/trace.perf\"" &&
    ++	test_when_finished 'rm "$pwd/trace.perf"' &&
     +	GIT_TRACE2_PERF="$pwd/trace.perf" git "$@" rev-parse --git-dir &&
     +	grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
     +}
     +
     +expect_accepted_explicit () {
    -+	test_when_finished "rm \"$pwd/trace.perf\"" &&
    -+	GIT_DIR="$@" GIT_TRACE2_PERF="$pwd/trace.perf" git rev-parse --git-dir &&
    ++	test_when_finished 'rm "$pwd/trace.perf"' &&
    ++	GIT_DIR="$1" GIT_TRACE2_PERF="$pwd/trace.perf" git rev-parse --git-dir &&
     +	! grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
      }
      
      expect_rejected () {
     -	test_must_fail git "$@" rev-parse --git-dir 2>err &&
     -	grep -F "cannot use bare repository" err
    -+	test_when_finished "rm \"$pwd/trace.perf\"" &&
    ++	test_when_finished 'rm "$pwd/trace.perf"' &&
     +	test_env GIT_TRACE2_PERF="$pwd/trace.perf" \
     +		test_must_fail git "$@" rev-parse --git-dir 2>err &&
     +	grep -F "cannot use bare repository" err &&
    @@ t/t0035-safe-bare-repository.sh: TEST_PASSES_SANITIZE_LEAK=true
      
      test_expect_success 'setup bare repo in worktree' '
     @@ t/t0035-safe-bare-repository.sh: test_expect_success 'setup bare repo in worktree' '
    + 	git init --bare outer-repo/bare-repo
      '
      
    - test_expect_success 'safe.bareRepository unset' '
    +-test_expect_success 'safe.bareRepository unset' '
     -	expect_accepted -C outer-repo/bare-repo
    -+	expect_accepted_implicit -C outer-repo/bare-repo
    - '
    - 
    +-'
    +-
      test_expect_success 'safe.bareRepository=all' '
      	test_config_global safe.bareRepository all &&
     -	expect_accepted -C outer-repo/bare-repo

 setup.c                         |  1 +
 t/t0035-safe-bare-repository.sh | 31 +++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 10 deletions(-)

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
index 11c15a48aa..993f5bdc7d 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -7,13 +7,24 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 pwd="$(pwd)"
 
-expect_accepted () {
-	git "$@" rev-parse --git-dir
+expect_accepted_implicit () {
+	test_when_finished 'rm "$pwd/trace.perf"' &&
+	GIT_TRACE2_PERF="$pwd/trace.perf" git "$@" rev-parse --git-dir &&
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
@@ -21,13 +32,9 @@ test_expect_success 'setup bare repo in worktree' '
 	git init --bare outer-repo/bare-repo
 '
 
-test_expect_success 'safe.bareRepository unset' '
-	expect_accepted -C outer-repo/bare-repo
-'
-
 test_expect_success 'safe.bareRepository=all' '
 	test_config_global safe.bareRepository all &&
-	expect_accepted -C outer-repo/bare-repo
+	expect_accepted_implicit -C outer-repo/bare-repo
 '
 
 test_expect_success 'safe.bareRepository=explicit' '
@@ -47,7 +54,7 @@ test_expect_success 'safe.bareRepository in the repository' '
 
 test_expect_success 'safe.bareRepository on the command line' '
 	test_config_global safe.bareRepository explicit &&
-	expect_accepted -C outer-repo/bare-repo \
+	expect_accepted_implicit -C outer-repo/bare-repo \
 		-c safe.bareRepository=all
 '
 
@@ -60,4 +67,8 @@ test_expect_success 'safe.bareRepository in included file' '
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

