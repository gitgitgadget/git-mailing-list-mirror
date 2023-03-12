Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85003C74A4B
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjCLUJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjCLUJb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:09:31 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0BD25975
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:09:11 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id e21so8106402oie.1
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678651743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uddwbV73cueW/OWJ+6VEnddoNYFBuFaamptQ2RSOxlo=;
        b=C7Vg7Fw/bAPBIp83KueO8XifgwDUPvWcy0T37sldQ7hUXVc7cOVWHuuNYc2s+X0F0O
         I0ooyS8BewVN/1+lTi1eLVohaX0dzLAccqe3YFUbA7+ZbHxydWHQil23dp9UfO/UCcNw
         2wSsDk0fm/0kyT0NnC3yNdg2lP8sA71o+lK+vrH85nECkY7oyYkqdTOErYgu02gybLbg
         4eSVp8Zle/qEx5Qk34uTgCgkGU15MZayS7LXJe/dW1vSOq0kduPGmv3OAnAD9Xr9h3ju
         fIeq5uWbdBVMJz8sYKBrGeyKS39BqVo+Wb6y9DH+puDexeAofaXaxe9ojAOUZponmqLj
         9vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678651743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uddwbV73cueW/OWJ+6VEnddoNYFBuFaamptQ2RSOxlo=;
        b=Z5HWkJBI8R5Y6qlj20iM1r4qiM0T8tfjGdJ0TEbTG3aZxT3u8qc3kHRvxLQNQaEuT3
         bfLnFRE7ZxFGyhRzR5dbAZ8s0GFESj6GxmVmDYFdDwBy10pZi4T9ZseIi0Lcctdp3it5
         v4uhx6XwyFa3U5jQ3u5ClMfrYK2hwtmKwfANDxrYXmXU7DrYJXvCXELxy0G+SBI00zVH
         MCrBbvSWZJhELssHUgEf0ZcyLNQllS0v89MdEJnFPXMloR58nG4riBrXfyHE5KCWNvVr
         AAH4iYVRXvrWjwY8Hr0on3rS+boNeYwDMCND4Rfqhn8KgZ5YwkvJRqq6J6V+PxXsM9UQ
         54lA==
X-Gm-Message-State: AO0yUKUFFmE3VifGUzW5+BNPqMl+4ZqAl6jvOv9DOcX3QPTs36DPzkPM
        oaUA9RtwQhq+7mnRryAvlQ896UPBjlY=
X-Google-Smtp-Source: AK7set9k9c98BTPvg6eX92M0G1aNoTIoMsew6sTbQP+7vZJ3NZMtsRre782gtKZkpETajLyuxtaJkg==
X-Received: by 2002:a05:6808:d8:b0:384:2357:dccd with SMTP id t24-20020a05680800d800b003842357dccdmr13806110oic.40.1678651742711;
        Sun, 12 Mar 2023 13:09:02 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k2-20020a056808068200b00383f0773beasm2356416oig.52.2023.03.12.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:09:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/5] perf: grep: avoid unused prereq
Date:   Sun, 12 Mar 2023 14:08:55 -0600
Message-Id: <20230312200856.323688-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230312200856.323688-1-felipe.contreras@gmail.com>
References: <20230312200856.323688-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no point in setting PERF_GREP_ENGINES_THREADS if we are going
to check it ourselves.

Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/perf/p7820-grep-engines.sh        | 9 ++-------
 t/perf/p7821-grep-engines-fixed.sh  | 9 ++-------
 t/perf/p7822-grep-perl-character.sh | 7 +------
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
index 336424cb00..f80fdcb5e2 100755
--- a/t/perf/p7820-grep-engines.sh
+++ b/t/perf/p7820-grep-engines.sh
@@ -22,11 +22,6 @@ etc.) we will test the patterns under those numbers of threads.
 test_perf_large_repo
 test_checkout_worktree
 
-if test -n "$GIT_PERF_GREP_THREADS"
-then
-	test_set_prereq PERF_GREP_ENGINES_THREADS
-fi
-
 for pattern in \
 	'how.to' \
 	'^how to' \
@@ -47,7 +42,7 @@ do
 		else
 			prereq=""
 		fi
-		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
+		if test -z "$GIT_PERF_GREP_THREADS"
 		then
 			test_perf "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern'" \
 				--prereq "$prereq" "
@@ -64,7 +59,7 @@ do
 		fi
 	done
 
-	if ! test_have_prereq PERF_GREP_ENGINES_THREADS
+	if test -z "$GIT_PERF_GREP_THREADS"
 	then
 		test_expect_success "assert that all engines found the same for$GIT_PERF_7820_GREP_OPTS '$pattern'" '
 			test_cmp out.basic out.extended &&
diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
index 79b1b9f8b2..f25b4976ea 100755
--- a/t/perf/p7821-grep-engines-fixed.sh
+++ b/t/perf/p7821-grep-engines-fixed.sh
@@ -16,11 +16,6 @@ etc.) we will test the patterns under those numbers of threads.
 test_perf_large_repo
 test_checkout_worktree
 
-if test -n "$GIT_PERF_GREP_THREADS"
-then
-	test_set_prereq PERF_GREP_ENGINES_THREADS
-fi
-
 for pattern in 'int' 'uncommon' 'æ'
 do
 	for engine in fixed basic extended perl
@@ -31,7 +26,7 @@ do
 		else
 			prereq=""
 		fi
-		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
+		if test -z "$GIT_PERF_GREP_THREADS"
 		then
 			test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" --prereq "$prereq" "
 				git -c grep.patternType=$engine grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine' || :
@@ -46,7 +41,7 @@ do
 		fi
 	done
 
-	if ! test_have_prereq PERF_GREP_ENGINES_THREADS
+	if test -z "$GIT_PERF_GREP_THREADS"
 	then
 		test_expect_success "assert that all engines found the same for$GIT_PERF_7821_GREP_OPTS $pattern" '
 			test_cmp out.fixed out.basic &&
diff --git a/t/perf/p7822-grep-perl-character.sh b/t/perf/p7822-grep-perl-character.sh
index 87009c60df..2b73d41e2b 100755
--- a/t/perf/p7822-grep-perl-character.sh
+++ b/t/perf/p7822-grep-perl-character.sh
@@ -11,11 +11,6 @@ etc.) we will test the patterns under those numbers of threads.
 test_perf_large_repo
 test_checkout_worktree
 
-if test -n "$GIT_PERF_GREP_THREADS"
-then
-	test_set_prereq PERF_GREP_ENGINES_THREADS
-fi
-
 for pattern in \
 	'\\bhow' \
 	'\\bÆvar' \
@@ -24,7 +19,7 @@ for pattern in \
 	'\\w{12}\\b'
 do
 	echo '$pattern' >pat
-	if ! test_have_prereq PERF_GREP_ENGINES_THREADS
+	if test -z "$GIT_PERF_GREP_THREADS"
 	then
 		test_perf "grep -P '$pattern'" --prereq PCRE "
 			git -P grep -f pat || :
-- 
2.39.2.13.g1fb56cf030

