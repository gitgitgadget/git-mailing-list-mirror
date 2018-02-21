Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 129641F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeBUSwB (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:52:01 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41917 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbeBUSv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:51:59 -0500
Received: by mail-wr0-f196.google.com with SMTP id f14so7356806wre.8
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 10:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peuzm9B5RbeP13/VRI9SQ0PnosVEnpWRR0OzK8C6dig=;
        b=LGwG4bSXLF85DEbC8kncHhUO4hKkAkATsakvCv43zfpXtavYQ5RHLiIzoggydMGfw8
         k5HY3j8o0nhkf67oNOITwTqZo3WtYXjqOuNpuDurOdPw2+pmEQp2iQ6nIC9Zd1mXRlGP
         Gj/qGzQ7PFxhlzdmWqazB+9YuMhqd9NiV2FfLDHuJxYuPIasoZ6/QQ73KEoNn/fo3eTq
         QakRWyy1Kd8ZAqeYcCfrhqcsN6KVG990EQ3GcdgbJ1z4ExtZ5v+0tx7S4w+FY2wtbz/K
         tr3+qFBwgqgf0PSbs6rxq0FoNjSe73pXKeDVZf6HqXQIF6KoxlDXElB6a/FmETuNmYZ7
         ZK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peuzm9B5RbeP13/VRI9SQ0PnosVEnpWRR0OzK8C6dig=;
        b=hY/fUmFtVWPIC6dLS6NKElO/jGTlAo4qyU7FjKUjUCtJzFY3rTj5g5QSZtMEsk/2YO
         iRxmOeTwtLXK3kHFz1z9od0tYSev0n9WKaVH1ee2XPjsR+tnH4X/rKbZMbN9ux756KHy
         cB62RvYUIr+tvF35cz5u/nem+0CY+LqvtlNiohlm1j69pgZbYKKIunshaIbUL1LdU6oj
         Rz1/ygdqC0Ak5S+JnGYBISZ9/LKOsz1AICz9CbsIM/8fVJdle/VDFUs0o4npyU2oUZ0i
         q6FC2sVKGRdoU4iJMBNNXjcd5nKn6KWBYktoNcIHCS6Q9xduR9hs+ViyHMFl5C83151R
         RejA==
X-Gm-Message-State: APf1xPC5CGiWZOygk2uHd9P80f2T6wxhgZIpRwraRPK4o+IssG5t2XiT
        /0VFIjdG4SBGdu8cBuxf9VfD++bB
X-Google-Smtp-Source: AH8x2272ihFFqE0lG3wRboKu0ozXTYqel9bdKhBADmqhBQHji6gpsGvFpH7/XiufhKnuvcbO1RR0ZA==
X-Received: by 10.28.87.1 with SMTP id l1mr2723421wmb.32.1519239117481;
        Wed, 21 Feb 2018 10:51:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 128sm5224964wmi.20.2018.02.21.10.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Feb 2018 10:51:56 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] config: respect `pager.config` in list/get-mode only
Date:   Wed, 21 Feb 2018 19:51:43 +0100
Message-Id: <7ed0f6c3881535c2b87663ccc85705f5503ed8d2.1519238410.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519238410.git.martin.agren@gmail.com>
References: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com> <cover.1519238410.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to de121ffe5 (tag: respect `pager.tag` in list-mode only,
2017-08-02), use the DELAY_PAGER_CONFIG-mechanism to only respect
`pager.config` when we are listing or "get"ing config.

We have several getters and some are guaranteed to give at most one line
of output. Paging all getters including those could be convenient from a
documentation point-of-view. The downside would be that a misconfigured
or not so modern pager might wait for user interaction before
terminating. Let's instead respect the config for precisely those
getters which may produce more than one line of output.

`--get-urlmatch` may or may not produce multiple lines of output,
depending on the exact usage. Let's not try to recognize the two modes,
but instead make `--get-urlmatch` always respect the config. Analyzing
the detailed usage might be trivial enough here, but could establish a
precedent that we will never be able to enforce throughout the codebase
and that will just open a can of worms.

This fixes the failing test added in the previous commit. Also adapt the
test for whether `git config foo.bar bar` and `git config --get foo.bar`
respects `pager.config`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-config.txt |  5 +++++
 t/t7006-pager.sh             | 10 +++++-----
 builtin/config.c             | 10 ++++++++++
 git.c                        |  2 +-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 14da5fc157..249090ac84 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -233,6 +233,11 @@ See also <<FILES>>.
 	using `--file`, `--global`, etc) and `on` when searching all
 	config files.
 
+CONFIGURATION
+-------------
+`pager.config` is only respected when listing configuration, i.e., when
+using `--list` or any of the `--get-*` which may return multiple results.
+
 [[FILES]]
 FILES
 -----
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index a46a079339..95bd26f0b2 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -245,13 +245,13 @@ test_expect_success TTY 'git branch --set-upstream-to ignores pager.branch' '
 	! test -e paginated.out
 '
 
-test_expect_success TTY 'git config respects pager.config when setting' '
+test_expect_success TTY 'git config ignores pager.config when setting' '
 	rm -f paginated.out &&
 	test_terminal git -c pager.config config foo.bar bar &&
-	test -e paginated.out
+	! test -e paginated.out
 '
 
-test_expect_failure TTY 'git config --edit ignores pager.config' '
+test_expect_success TTY 'git config --edit ignores pager.config' '
 	rm -f paginated.out editor.used &&
 	write_script editor <<-\EOF &&
 		touch editor.used
@@ -261,10 +261,10 @@ test_expect_failure TTY 'git config --edit ignores pager.config' '
 	test -e editor.used
 '
 
-test_expect_success TTY 'git config --get respects pager.config' '
+test_expect_success TTY 'git config --get ignores pager.config' '
 	rm -f paginated.out &&
 	test_terminal git -c pager.config config --get foo.bar &&
-	test -e paginated.out
+	! test -e paginated.out
 '
 
 test_expect_success TTY 'git config --get-urlmatch defaults to not paging' '
diff --git a/builtin/config.c b/builtin/config.c
index ab5f95476e..a732d9b56c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -48,6 +48,13 @@ static int show_origin;
 #define ACTION_GET_COLORBOOL (1<<14)
 #define ACTION_GET_URLMATCH (1<<15)
 
+/*
+ * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
+ * one line of output and which should therefore be paged.
+ */
+#define PAGING_ACTIONS (ACTION_LIST | ACTION_GET_ALL | \
+			ACTION_GET_REGEXP | ACTION_GET_URLMATCH)
+
 #define TYPE_BOOL (1<<0)
 #define TYPE_INT (1<<1)
 #define TYPE_BOOL_OR_INT (1<<2)
@@ -594,6 +601,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (actions & PAGING_ACTIONS)
+		setup_auto_pager("config", 0);
+
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (config_with_options(show_all_config, NULL,
diff --git a/git.c b/git.c
index c870b9719c..e5c9b8729d 100644
--- a/git.c
+++ b/git.c
@@ -389,7 +389,7 @@ static struct cmd_struct commands[] = {
 	{ "column", cmd_column, RUN_SETUP_GENTLY },
 	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-	{ "config", cmd_config, RUN_SETUP_GENTLY },
+	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
 	{ "credential", cmd_credential, RUN_SETUP_GENTLY },
 	{ "describe", cmd_describe, RUN_SETUP },
-- 
2.16.2.246.ga4ee44448f

