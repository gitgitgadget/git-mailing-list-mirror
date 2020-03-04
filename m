Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9770BC3F2D7
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DD520848
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVFURce7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbgCDLeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:34:14 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:53558 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbgCDLeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:34:14 -0500
Received: by mail-pj1-f52.google.com with SMTP id cx7so798318pjb.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z75zcX+dqdDEaAW4aSZfQzpTDkbSJMbravljvhZkQYw=;
        b=nVFURce7j2tKSn/4n9fQDb5GuvocPdpCvxzDmA+rPGzxDFWXunlgLdgn8ePDzsdUR/
         qLYI5JNHVtln8o78FA7jMPKYYeGJ+bYJIkVoWENiHDVxQRUmcvR4bJh/c5HfRQkaG4F1
         p2mSnzt1LMP4JckZYlEW+YEQKmZ+slo0ohLdDLJNnbn0blgvfp49M395GtrTFeedTTH2
         KFite4ubg8yVT/OkgnP/sOWy7A4DYiGvDfy+b/tyM/ySXGAHYoy+ML5jAXZ2YQQG+IB0
         lBpoZ8CJG+uTnWDwW5klYvm31hdX7YJEQyJVvcmfftJzt1MI3V/Ixm4gKpM2tISAWmAP
         WhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z75zcX+dqdDEaAW4aSZfQzpTDkbSJMbravljvhZkQYw=;
        b=JILPx4IJ/2+rxGvqT4Pf5clRnEvvvZUVVhh1HvT8DrRC0IvzyLinmJ7xnMKsszjjTR
         ++Oy4HSIn9D2l0I5SJf+bydvfCIo1j3ikpAanWUfLlrobd4DNFS50sAscDiPsRTCoGZW
         Ukjo5D9de+4guZ6keDyZSUT833qNdxfI/5l3F6vGmiA23+Ef9bwEkvfDlh56GP3QpAOJ
         rubuUygmNifrFxi/rvZzFzeDzFi9Ofh2f5TG9d5a0AyFQjAcU/FlQezWjDcUmBBfUxEu
         nwHFKgnYkCwmgxRuxDf9w5GWDp0as/4IFvdFDL/YfpW+vaicRQsRvAlEzOhqXLEfcuIX
         wL6g==
X-Gm-Message-State: ANhLgQ0FFgF0uwtBwg3S7PqQ6ZcO6RbYxG/KoNarUHcq6V7plw1DRYXs
        r6Gk5c04WhfkYyPHthClJ66ifoMHxF7bTQ==
X-Google-Smtp-Source: ADFU+vu/ETGr9QZ8j7VJJa8PPHZECoulO0X2pZz9sejtuivb1e29ekmzOUiWlIGM1TUzD/ozlCrpgQ==
X-Received: by 2002:a17:902:8492:: with SMTP id c18mr2794751plo.147.1583321650767;
        Wed, 04 Mar 2020 03:34:10 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id d77sm15350050pfd.109.2020.03.04.03.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 03:34:10 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] receive-pack: try `execute-commands --pre-receive`
Date:   Wed,  4 Mar 2020 19:33:08 +0800
Message-Id: <20200304113312.34229-4-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First we try to find the hook "execute-command--pre-receive" to check
permissions for special commands.  If the hook does not exist, will try
to find the hook "execute-commands" and run command `execute-commands
--pre-receive` instead.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c           | 30 ++++++++++----
 t/t5411-execute-commands-hook.sh | 68 +++++++++++++++++++++++---------
 2 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c97abfbcd3..241b1d4cfc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -683,20 +683,34 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct async muxer;
-	const char *argv[2];
+	const char *argv[3];
 	int code;
 
 	argv[0] = find_hook(hook_name);
 	if (!argv[0]) {
-		if (feed_state->hook_must_exist) {
-			rp_error("cannot to find hook '%s'", hook_name);
-			return 1;
-		} else
-			return 0;
+		char *hook_helper;
+		char *opt;
+
+		opt = strstr(hook_name, "--");
+		if (opt) {
+			hook_helper = xstrdup(hook_name);
+			hook_helper[opt - hook_name] = '\0';
+			argv[0] = find_hook(hook_helper);
+			free(hook_helper);
+		}
+		if (!argv[0]) {
+			if (feed_state->hook_must_exist) {
+				rp_error("cannot to find hook '%s'", hook_name);
+				return 1;
+			} else
+				return 0;
+		}
+		argv[1] = opt;
+		argv[2] = NULL;
+	} else {
+		argv[1] = NULL;
 	}
 
-	argv[1] = NULL;
-
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
diff --git a/t/t5411-execute-commands-hook.sh b/t/t5411-execute-commands-hook.sh
index b6444ca047..0bf14e702d 100755
--- a/t/t5411-execute-commands-hook.sh
+++ b/t/t5411-execute-commands-hook.sh
@@ -64,6 +64,11 @@ test_expect_success "setup hooks" '
 
 	printf >&2 "execute: execute-commands\n"
 
+	if test \$# -gt 0 && test "\$1" = "--pre-receive"
+	then
+		printf >&2 ">> pre-receive mode\n"
+	fi
+
 	while read old new ref
 	do
 		printf >&2 ">> old: \$old, new: \$new, ref: \$ref.\n"
@@ -183,13 +188,15 @@ test_expect_success "add back the execute-commands hook" '
 '
 
 test_expect_success "push one special ref: refs/for/a/b/c" '
+	mv $bare/hooks/execute-commands--pre-receive $bare/hooks/execute-commands--pre-receive.ok &&
 	(
 		cd work &&
 		git push origin HEAD:refs/for/a/b/c/my/topic
 	) >out 2>&1 &&
 	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
 	cat >expect <<-EOF &&
-	remote: execute: execute-commands--pre-receive
+	remote: execute: execute-commands
+	remote: >> pre-receive mode
 	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/a/b/c/my/topic.
 	remote: execute: execute-commands
 	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/a/b/c/my/topic.
@@ -208,7 +215,8 @@ test_expect_success "push two special references" '
 	) >out 2>&1 &&
 	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
 	cat >expect <<-EOF &&
-	remote: execute: execute-commands--pre-receive
+	remote: execute: execute-commands
+	remote: >> pre-receive mode
 	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
 	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/a/b/c/my/topic.
 	remote: execute: execute-commands
@@ -228,13 +236,21 @@ test_expect_success "new execute-commands hook (fail with error)" '
 
 	printf >&2 "execute: execute-commands\n"
 
+	if test \$# -gt 0 && test "\$1" = "--pre-receive"
+	then
+		printf >&2 ">> pre-receive mode\n"
+	fi
+
 	while read old new ref
 	do
 		printf >&2 ">> old: \$old, new: \$new, ref: \$ref.\n"
 	done
 
-	printf >&2 "fail to run execute-commands\n"
-	exit 1
+	if test \$# -eq 0
+	then
+		printf >&2 "fail to run execute-commands\n"
+		exit 1
+	fi
 	EOF
 	chmod a+x $bare/hooks/execute-commands
 '
@@ -248,7 +264,8 @@ test_expect_success "successfully push normal ref, and fail to push special refe
 	) >out 2>&1 &&
 	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
 	cat >expect <<-EOF &&
-	remote: execute: execute-commands--pre-receive
+	remote: execute: execute-commands
+	remote: >> pre-receive mode
 	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
 	remote: execute: pre-receive hook
 	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
@@ -284,7 +301,8 @@ test_expect_success "all mixed refs are failed to push in atomic mode" '
 	) >out 2>&1 &&
 	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
 	cat >expect <<-EOF &&
-	remote: execute: execute-commands--pre-receive
+	remote: execute: execute-commands
+	remote: >> pre-receive mode
 	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
 	remote: execute: pre-receive hook
 	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
@@ -309,7 +327,8 @@ test_expect_success "push mixed references successfully" '
 	) >out 2>&1 &&
 	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
 	cat >expect <<-EOF &&
-	remote: execute: execute-commands--pre-receive
+	remote: execute: execute-commands
+	remote: >> pre-receive mode
 	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
 	remote: execute: pre-receive hook
 	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
@@ -336,22 +355,30 @@ test_expect_success "restore remote master branch" '
 	test_cmp expect actual
 '
 
-test_expect_success "new execute-commands--pre-receive hook (declined version)" '
-	mv $bare/hooks/execute-commands--pre-receive $bare/hooks/execute-commands--pre-receive.ok &&
-	cat >$bare/hooks/execute-commands--pre-receive <<-EOF &&
+test_expect_success "new execute-commands hook (pre-receive declined)" '
+	mv $bare/hooks/execute-commands $bare/hooks/execute-commands.ok &&
+	cat >$bare/hooks/execute-commands <<-EOF &&
 	#!/bin/sh
 
-	printf >&2 "execute: execute-commands--pre-receive\n"
+	printf >&2 "execute: execute-commands\n"
+
+	if test \$# -gt 0 && test "\$1" = "--pre-receive"
+	then
+		printf >&2 ">> pre-receive mode\n"
+	fi
 
 	while read old new ref
 	do
 		printf >&2 ">> old: \$old, new: \$new, ref: \$ref.\n"
 	done
 
-	printf >&2 ">> ERROR: declined in execute-commands--pre-receive\n"
-	exit 1
+	if test \$# -gt 0 && test "\$1" = "--pre-receive"
+	then
+		printf >&2 ">> ERROR: declined in execute-commands--pre-receive\n"
+		exit 1
+	fi
 	EOF
-	chmod a+x $bare/hooks/execute-commands--pre-receive
+	chmod a+x $bare/hooks/execute-commands
 '
 
 test_expect_success "cannot push two special references (declined)" '
@@ -363,7 +390,8 @@ test_expect_success "cannot push two special references (declined)" '
 	) >out 2>&1 &&
 	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
 	cat >expect <<-EOF &&
-	remote: execute: execute-commands--pre-receive
+	remote: execute: execute-commands
+	remote: >> pre-receive mode
 	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
 	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
 	remote: >> ERROR: declined in execute-commands--pre-receive
@@ -380,7 +408,8 @@ test_expect_success "cannot push mixed references (declined)" '
 	) >out 2>&1 &&
 	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
 	cat >expect <<-EOF &&
-	remote: execute: execute-commands--pre-receive
+	remote: execute: execute-commands
+	remote: >> pre-receive mode
 	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
 	remote: >> ERROR: declined in execute-commands--pre-receive
 	EOF
@@ -388,8 +417,8 @@ test_expect_success "cannot push mixed references (declined)" '
 '
 
 test_expect_success "new pre-receive hook (declined version)" '
-	mv $bare/hooks/execute-commands--pre-receive $bare/hooks/execute-commands--pre-receive.fail &&
-	mv $bare/hooks/execute-commands--pre-receive.ok $bare/hooks/execute-commands--pre-receive &&
+	mv $bare/hooks/execute-commands $bare/hooks/execute-commands.fail &&
+	mv $bare/hooks/execute-commands.ok $bare/hooks/execute-commands &&
 	mv $bare/hooks/pre-receive $bare/hooks/pre-receive.ok &&
 	cat >$bare/hooks/pre-receive <<-EOF &&
 	#!/bin/sh
@@ -415,7 +444,8 @@ test_expect_success "cannot push mixed references (declined)" '
 	) >out 2>&1 &&
 	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
 	cat >expect <<-EOF &&
-	remote: execute: execute-commands--pre-receive
+	remote: execute: execute-commands
+	remote: >> pre-receive mode
 	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
 	remote: execute: pre-receive hook
 	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
-- 
2.25.1.362.g51ebf55b93

