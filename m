Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82054C07E9B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD56613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhGEMfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhGEMfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:37 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E4CC06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:33:00 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t3so20600878oic.5
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZoMKVva73JHVGxMxaqbEh6QZSE+ZTuXKR7SfYFIxWk=;
        b=cbX8q7CNoMVUqGtIUELzj0I1RRy7jptTI6JlDKh0KOw74lrg+jrmgZfaG0qqdMpkIs
         GDTEIT16nLaX/TJ2fiOLdgs4T/fMWKS4CO4SMfQW3dobnOBh5NyZPapivNWjS4Fa7ism
         tvEvVmZ++Byy3Bh9XRF2YwgFLYkvyjwEl8Ub8a2+PCr9xmjyZoPSTHUMFFOgGMffU0Oe
         2xNyynH7R1C5GFuTLRevNEGJAmKuclCPkRWLgYaWOct2OLJkewDtoX/sb7Lp+jel+25c
         clxaGijefc0q5FaOjjb51PwJTUkw3xOS6urOPF6qL7/k6OpBuL6wCa45gSTY7B9gQKSv
         ia8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZoMKVva73JHVGxMxaqbEh6QZSE+ZTuXKR7SfYFIxWk=;
        b=ECRGkw3TPiW/JED8yifAAOJMjKO72DUwvu+f49dUz2flwoswb5wIzVK+644M1VDFfx
         FXeju147mnsQRRTR3IZ4EwXi2yL7uzRddie/M1I7DuuNwvAc3hctZ5A/Uu1VwNP8ldK3
         Bltqsplb5xOdcsJ72EYNbVftcjGSVnclRjqtb3ZtN1HV3+LeXaZBm9i5yqXjrxWe7qCn
         f4gN8MHqB1u//XLpUZJHDfIBeJnVQCIRyEagICwVf4dKwPkkKQSRmWwu68Dz81JhZPO3
         TwghQV1e6mNmajpYzslL56UVticdvGRH9lFO6BKT+jkiN4Y1YLO1IwLf8XXxR3QgBfJJ
         TU6g==
X-Gm-Message-State: AOAM53047Ul0yLsR7sgeA/oWl9R5OdAFW87X//foaQDKtD5KPl4qxGPQ
        P6xOBZwczmYRaXYsxkRHi7fxUQlSHYWtsQ==
X-Google-Smtp-Source: ABdhPJxwJMUVdun17P5vKw5uy31W9Q2XFrYzJtaTEjobdjSjr6NjBKpf5bPzCdLxMCHbnrypWKbqww==
X-Received: by 2002:a05:6808:1312:: with SMTP id y18mr10051633oiv.82.1625488379564;
        Mon, 05 Jul 2021 05:32:59 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id v7sm2234535ooj.46.2021.07.05.05.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 28/35] pull: add pull.mode=fast-forward
Date:   Mon,  5 Jul 2021 07:32:02 -0500
Message-Id: <20210705123209.1808663-29-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is very typical for Git newcomers to inadvertently create merges and
worse; pushing them. This is one of the reasons many experienced users
prefer to avoid 'git pull', and recommend newcomers to avoid it as well.

To escape these problems--and keep 'git pull' useful--it has been
suggested that 'git pull' barfs by default if the merge is
non-fast-forward, which unfortunately would break backwards
compatibility.

This patch leaves everything in place to enable this new mode, but it
only gets enabled if the user specifically configures it:

  pull.mode = fast-forward

Later on this mode can be enabled by default.

For *some* of the long discussions you can read:

https://lore.kernel.org/git/742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com/
https://lore.kernel.org/git/20130522115042.GA20649@inner.h.apk.li
https://lore.kernel.org/git/1377988690-23460-1-git-send-email-felipe.contreras@gmail.com
https://lore.kernel.org/git/4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/branch.txt |  4 +--
 Documentation/config/pull.txt   |  4 +--
 builtin/pull.c                  |  6 ++++-
 rebase.c                        |  2 ++
 rebase.h                        |  3 ++-
 t/t5520-pull.sh                 | 44 +++++++++++++++++++++++++++++++++
 6 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 5f412caf62..a61c80c90b 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -103,8 +103,8 @@ branch.<name>.updateMode::
 
 branch.<name>.pullMode::
 	When `git pull` is run, this determines the mode of operation,
-	possible values are 'merge' and 'rebase'. See `pull.mode` for doing this
-	in a non branch-specific manner.
+	possible values are 'fast-forward', 'merge', and 'rebase'.
+	See `pull.mode` for doing this in a non branch-specific manner.
 
 branch.<name>.description::
 	Branch description, can be edited with
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index 3fb9bfdfea..7b3dddf4d4 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -32,8 +32,8 @@ for details).
 pull.mode::
 	When "git pull" is run, this determines if it would either merge or
 	rebase the fetched branch. The possible values are 'merge',
-	and 'rebase'. See "branch.<name>.pullMode" for setting this on a
-	per-branch basis.
+	'rebase', and 'fast-forward'. See "branch.<name>.pullMode" for setting
+	this on a per-branch basis.
 
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
diff --git a/builtin/pull.c b/builtin/pull.c
index bb3c0b55f9..295c13fbe8 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -979,7 +979,7 @@ static void show_advice_pull_non_ff(void)
 		 "\n"
 		 "  git config pull.mode merge  # the default strategy\n"
 		 "  git config pull.mode rebase\n"
-		 "  git config pull.ff only     # fast-forward only\n"
+		 "  git config pull.mode fast-forward\n"
 		 "\n"
 		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
 		 "preference for all repositories. You can also pass --rebase, --merge,\n"
@@ -1023,6 +1023,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		switch (mode) {
 		case PULL_MODE_MERGE:
+		case PULL_MODE_FAST_FORWARD:
 			opt_rebase = REBASE_FALSE;
 			break;
 		case PULL_MODE_REBASE:
@@ -1113,6 +1114,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
+	if (mode == PULL_MODE_FAST_FORWARD && !can_ff)
+		die(_("The pull was not fast-forward, either merge or rebase.\n"));
+
 	if (!opt_rebase && !can_ff) {
 		if (opt_verbosity >= 0)
 			show_advice_pull_non_ff();
diff --git a/rebase.c b/rebase.c
index bdfca49886..9fe99b5b16 100644
--- a/rebase.c
+++ b/rebase.c
@@ -40,6 +40,8 @@ enum pull_mode_type pull_mode_parse_value(const char *value)
 		return PULL_MODE_MERGE;
 	else if (!strcmp(value, "rebase") || !strcmp(value, "r"))
 		return PULL_MODE_REBASE;
+	else if (!strcmp(value, "fast-forward") || !strcmp(value, "f"))
+		return PULL_MODE_FAST_FORWARD;
 
 	return PULL_MODE_INVALID;
 }
diff --git a/rebase.h b/rebase.h
index 5ab8f4ddd5..e66a73feb4 100644
--- a/rebase.h
+++ b/rebase.h
@@ -17,7 +17,8 @@ enum pull_mode_type {
 	PULL_MODE_INVALID = -1,
 	PULL_MODE_DEFAULT = 0,
 	PULL_MODE_MERGE,
-	PULL_MODE_REBASE
+	PULL_MODE_REBASE,
+	PULL_MODE_FAST_FORWARD
 };
 
 enum pull_mode_type pull_mode_parse_value(const char *value);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 59894dd15a..7ea558651d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -869,4 +869,48 @@ test_expect_success 'git pull --rebase against local branch' '
 	test_cmp expect file2
 '
 
+setup_other () {
+	test_when_finished "git checkout main && git branch -D other test" &&
+	git checkout -b other $1 &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard main
+}
+
+setup_ff () {
+	setup_other main
+}
+
+setup_non_ff () {
+	setup_other main^
+}
+
+test_expect_success 'fast-forward (pull.mode=fast-forward)' '
+	setup_ff &&
+	git -c pull.mode=fast-forward pull
+'
+
+test_expect_success 'non-fast-forward (pull.mode=fast-forward)' '
+	setup_non_ff &&
+	test_must_fail git -c pull.mode=fast-forward pull
+'
+
+test_expect_success 'non-fast-forward with merge (pull.mode=fast-forward)' '
+	setup_non_ff &&
+	git -c pull.mode=fast-forward pull --merge
+'
+
+test_expect_success 'non-fast-forward with rebase (pull.mode=fast-forward)' '
+	setup_non_ff &&
+	git -c pull.mode=fast-forward pull --rebase
+'
+
+test_expect_success 'non-fast-forward error message (pull.mode=fast-forward)' '
+	setup_non_ff &&
+	test_must_fail git -c pull.mode=fast-forward pull 2> error &&
+	test_i18ngrep "The pull was not fast-forward" error
+'
+
 test_done
-- 
2.32.0.36.g70aac2b1aa

