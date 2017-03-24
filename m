Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183D220958
	for <e@80x24.org>; Fri, 24 Mar 2017 05:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbdCXFqm (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 01:46:42 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34015 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdCXFqk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 01:46:40 -0400
Received: by mail-pg0-f67.google.com with SMTP id w20so1010094pgc.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 22:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s0KAvCmp+/fRKHw+DTEYtVAiwz85tJHisZbN4GpYF+Y=;
        b=o5tVPmL/uMC25GRn8ddeK8B4+RC6fMSH8/gvj/R+dTKrlrJL+O0muxNktJDG995zWB
         xtM6S1SIt/psmgb5Q/tGvjllCAvBas0HdDX0XO6XN69f5t1OIC6GcBeaNKbgLHLErex5
         In3a6PB1z29/7RqSjynk2NFDkSAzr+FHoHzXf/aolEHhlueWOyXNaQ/eRreCKFg8dDRZ
         vXrvgKTWwoSC8eO0NCLkMoKk7z0WIBDi2/j4/NevBuktH1Sm9dlGoxUKwPltw+F6mNfu
         1DruFN6hEQS6msXVfmZuD8wXkF9ImFTosR67iUULQLCFKH9O7fS8LIuMF+Z8+Jkk9DFG
         Bh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s0KAvCmp+/fRKHw+DTEYtVAiwz85tJHisZbN4GpYF+Y=;
        b=S1oSpMzi4EXGuZ50O3Me+fZ6wiy2jMzyH1KpXmmgvrGrM93uLV4rLCPnwoTVe8M5R5
         OKphOHAG4t/B/gTnYJ56v5KVWQS+X+PgvgJKdoAVQKFqCmCOT26Nb3W5VgWVFnHs2JC0
         6YAyIywDRm6v77Um2E6lsXmn5cdjSe609iezOHe4qycci8L/9Sg6zd73+M2On6xNH3UL
         eHJpFtfNrFA7ngA19PX7xcY6HiRv5AC5gU5IzHJMys+HbsB8+AWmUdpmJVQfJZqucoHV
         6lIiJw7Gfs7VUgGEg8Mrh5VFiAWsS/7vSTEuTHkxKevbu8huaJrcnGlE/mKq7P+E7qPW
         5yAQ==
X-Gm-Message-State: AFeK/H1kCxv/8phF+Vfz2CbjmhJhzMOm24FAY6Kh0V4GzAQWf5oo0qFa+2j91iHn8Tj/vw==
X-Received: by 10.84.224.131 with SMTP id s3mr8542299plj.162.1490334399443;
        Thu, 23 Mar 2017 22:46:39 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4101:1302::bd0])
        by smtp.gmail.com with ESMTPSA id e70sm1706360pfh.84.2017.03.23.22.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 22:46:37 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] log: if --decorate is not given, default to --decorate=auto
Date:   Thu, 23 Mar 2017 23:46:31 -0600
Message-Id: <20170324054631.21622-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/log.c  |  9 ++++++++-
 t/t4202-log.sh | 10 +++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 281af8c1e..d755a5960 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -52,6 +52,11 @@ struct line_opt_callback_data {
 	struct string_list args;
 };
 
+static int auto_decoration_style(void)
+{
+	return (isatty(1) || pager_in_use()) ? DECORATE_SHORT_REFS : 0;
+}
+
 static int parse_decoration_style(const char *var, const char *value)
 {
 	switch (git_config_maybe_bool(var, value)) {
@@ -67,7 +72,7 @@ static int parse_decoration_style(const char *var, const char *value)
 	else if (!strcmp(value, "short"))
 		return DECORATE_SHORT_REFS;
 	else if (!strcmp(value, "auto"))
-		return (isatty(1) || pager_in_use()) ? DECORATE_SHORT_REFS : 0;
+		return auto_decoration_style();
 	return -1;
 }
 
@@ -405,6 +410,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		if (decoration_style < 0)
 			decoration_style = 0; /* maybe warn? */
 		return 0;
+	} else {
+		decoration_style = auto_decoration_style();
 	}
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 48b55bfd2..f57799071 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -4,6 +4,7 @@ test_description='git log'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
+. "$TEST_DIRECTORY/lib-terminal.sh"
 
 test_expect_success setup '
 
@@ -520,7 +521,7 @@ test_expect_success 'log --graph with merge' '
 '
 
 test_expect_success 'log.decorate configuration' '
-	git log --oneline >expect.none &&
+	git log --oneline --no-decorate >expect.none &&
 	git log --oneline --decorate >expect.short &&
 	git log --oneline --decorate=full >expect.full &&
 
@@ -576,6 +577,13 @@ test_expect_success 'log.decorate configuration' '
 
 '
 
+test_expect_success TTY 'log output on a TTY' '
+	git log --oneline --decorate >expect.short &&
+
+	test_terminal git log --oneline >actual &&
+	test_cmp expect.short actual
+'
+
 test_expect_success 'reflog is expected format' '
 	git log -g --abbrev-commit --pretty=oneline >expect &&
 	git reflog >actual &&
-- 
2.12.0

