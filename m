Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C08207D6
	for <e@80x24.org>; Thu,  4 May 2017 21:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbdEDVoB (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 17:44:01 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34324 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdEDVoA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 17:44:00 -0400
Received: by mail-pf0-f174.google.com with SMTP id e64so13471718pfd.1
        for <git@vger.kernel.org>; Thu, 04 May 2017 14:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AKb07ta5wlHywhZUtm5P6B5NuzM7PhnlCODm7aJu5to=;
        b=lBlNz2foficWJ8dwUg0gkKaBHFu3xzbYppahAhfBYnNN+PaKGp/EQIwrK7kmDB+dh1
         kvTfsWGsSENVz1BBQQa9aKX/knEt/NdG38v3QNlNbfDePpyX8YKl7KWP/KzfqrtIUWG0
         paTGGXUhbgtDS1G7Eoy60MJ7QJiIeBsDGHmGMwiWV22IUIwH0lfBmpwlrwW70SjGnTLH
         r47cGAZIIgaeZ6Dg2LclsDRZpqBoujulwDkJRoyilgGZhMyaY4XQYHGXHbVgwpoInFY3
         1FUpZwX8V+Qazu20xU/gpgklAbMbmLE6tKLtoKQLBv2EAPpRJQyB7IDxf7dGDdL32rSz
         16zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AKb07ta5wlHywhZUtm5P6B5NuzM7PhnlCODm7aJu5to=;
        b=okWB4pRtHsSg5fpk/UeB7BF/1BQye4KCraBRqZxlyruZ+aescnuLazCsYr+hckbk77
         ylvRamSS0CLwZQEe+3fvb6zp9QzBQWYBKpL33gSD2KOERzxnPzH3yu2y2QIkq3bgjW6Z
         iHhIGQPss2Py8YSNPyLPpsjn75Si9WTVC8gFa5zLWqvzpGjQZ9xQFbN5FgidjaUfhR6O
         0IG198opnQ2I3nFeRjHbAH6iYxyhKM6WB6OSsXKySy4nRdlrpUrmAPQnMNu0ZztGVVd+
         A8qG9yuPg3qtzbFNn+wkyBIhUQIhiWEQzk2WMtJa0vq4ZgICTQ12+VEUc64Z2xAFZ8AP
         R0dA==
X-Gm-Message-State: AN3rC/5WPCk1l55GrubUQbY432mulu1xmcZutu0ej3YKyPGMkrNlb8YL
        Ql91jkNtHs5dRwE3
X-Received: by 10.98.72.86 with SMTP id v83mr12946152pfa.29.1493934239768;
        Thu, 04 May 2017 14:43:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:fc48:3ee2:65ef:6206])
        by smtp.gmail.com with ESMTPSA id z5sm6636084pfd.76.2017.05.04.14.43.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 May 2017 14:43:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jacob.keller@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RESEND PATCH] diff: recurse into nested submodules for inline diff
Date:   Thu,  4 May 2017 14:43:55 -0700
Message-Id: <20170504214355.14179-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc2.1.g058096e1fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fd47ae6a5b (diff: teach diff to display submodule difference with an
inline diff, 2016-08-31) was introduced, we did not think of recursing
into nested submodules.

When showing the inline diff for submodules, automatically recurse
into nested submodules as well with inline submodule diffs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is a resend of 
https://public-inbox.org/git/20170331231733.11123-3-sbeller@google.com/

In the cover letter of that patch, I said I would want to redo the tests with
scrubbed output. However given the widespread use of unscrubbed output,
I think this is fine as-is to include.

Thanks,
Stefan

 submodule.c                                  |  3 +-
 t/t4060-diff-submodule-option-diff-format.sh | 41 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index d3299e29c0..2d56a9562e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -554,7 +554,8 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 	cp.no_stdin = 1;
 
 	/* TODO: other options may need to be passed here. */
-	argv_array_push(&cp.args, "diff");
+	argv_array_pushl(&cp.args, "diff", "--submodule=diff", NULL);
+
 	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index d4a3ffa69c..33ec26d755 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -775,4 +775,45 @@ test_expect_success 'diff --submodule=diff with moved nested submodule HEAD' '
 	test_cmp expected actual
 '
 
+test_expect_success 'diff --submodule=diff recurses into nested submodules' '
+	cat >expected <<-EOF &&
+	Submodule sm2 contains modified content
+	Submodule sm2 a5a65c9..280969a:
+	diff --git a/sm2/.gitmodules b/sm2/.gitmodules
+	new file mode 100644
+	index 0000000..3a816b8
+	--- /dev/null
+	+++ b/sm2/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "nested"]
+	+	path = nested
+	+	url = ../sm2
+	Submodule nested 0000000...b55928c (new submodule)
+	diff --git a/sm2/nested/file b/sm2/nested/file
+	new file mode 100644
+	index 0000000..ca281f5
+	--- /dev/null
+	+++ b/sm2/nested/file
+	@@ -0,0 +1 @@
+	+nested content
+	diff --git a/sm2/nested/foo8 b/sm2/nested/foo8
+	new file mode 100644
+	index 0000000..db9916b
+	--- /dev/null
+	+++ b/sm2/nested/foo8
+	@@ -0,0 +1 @@
+	+foo8
+	diff --git a/sm2/nested/foo9 b/sm2/nested/foo9
+	new file mode 100644
+	index 0000000..9c3b4f6
+	--- /dev/null
+	+++ b/sm2/nested/foo9
+	@@ -0,0 +1 @@
+	+foo9
+	EOF
+	git diff --submodule=diff >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.13.0.rc1.18.g9ce9a66034

