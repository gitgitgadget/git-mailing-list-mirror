Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B53C10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 03:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F8A208E4
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 03:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHaCN5NJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCJDyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 23:54:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38054 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgCJDyl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 23:54:41 -0400
Received: by mail-io1-f66.google.com with SMTP id s24so11404188iog.5
        for <git@vger.kernel.org>; Mon, 09 Mar 2020 20:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbLKhBORPaTs/o0qR0ko9/l7uQVTCqzyWfjYBFKe6rM=;
        b=kHaCN5NJ6t5VzUlTKDz7ML2DPRcWZogvYopbQd3GZi+6YYIt2+GnYfzcL9E6r3+11I
         9Mz+7WnW0sfbk8ONREIEjmLKGQfG85J1OPv+kdZvZbKn8Q8Pik8gvCumMidz+3igwSR/
         pg4nxipJIRyV6yBzwVHt5Plc+hDgPOoE2ASI/lZ5kyh7n+EJyIFypdVkXIZc3qTg/D9s
         Qmnd6VtG9JowkhGiJOFhZIwJvHmZtXi27FkkRLYQNQdqKvRW9KL6s7rOa/occDVqviXw
         c2raBoj78ejpodGa0QpXkN++mdl1IBxiW0PyZV1VydiI3Nk/NCuMR7jE5rDFwY9JG8zr
         OZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbLKhBORPaTs/o0qR0ko9/l7uQVTCqzyWfjYBFKe6rM=;
        b=CF/szQeUSPdJL1q4m6POPCnGSP0VoC0hDZ6YiuOj2YLs53mehqQwwq8CtobhLJfLkO
         qCmRjx6WBAaPLecw36Ne4OZ+6HxvA4ja5aPLQWh+yg73qK0tbaP5BusC6K7/W0FskFap
         SG80Lx0h8Gzh2kli5sjpAmaZVTysEWyEFOVZR8I4RnztPRcDPcjJBhPxna+znfEqkPv2
         Xug+GSY5CibPLJvo8ox1XEAoK0MTku4tqOSTpuyAQWFAThsTq4l0WuP94Qqcx2Uu0+sW
         fz8K16f0hMVbt8rYMWe8hivx/nEwz77fJabEPUfTWRADX2ewcU/pdd+v786X9kDRg84N
         DmaQ==
X-Gm-Message-State: ANhLgQ0ye7ZRr4cj4QKZG8wVeltDWpPhVgbZrVytZ66oHCdShTGhO2Oy
        vnHKw+Nu14tx9ZyploSVEEHvIj90aFk=
X-Google-Smtp-Source: ADFU+vt85ZJwPop3/hjvj6JBFn+yQ6h1rYQLuDoXYDZr4tyiePGEC7QDgDieMKwIsNWSMTeDL+xxeA==
X-Received: by 2002:a02:2713:: with SMTP id g19mr9579162jaa.28.1583812480091;
        Mon, 09 Mar 2020 20:54:40 -0700 (PDT)
Received: from viper.med.utah.edu ([2601:681:4100:375e:c6b3:1ff:fed3:9881])
        by smtp.gmail.com with ESMTPSA id y10sm7764565ily.26.2020.03.09.20.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 20:54:39 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, rcdailey.lists@gmail.com, newren@gmail.com,
        rsbecker@nexbridge.com, gitster@pobox.com, annulen@yandex.ru,
        tytso@mit.edu
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5] pull: warn if the user didn't say whether to rebase or to merge
Date:   Mon,  9 Mar 2020 21:54:20 -0600
Message-Id: <20200310035420.1658876-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Often novice Git users forget to say "pull --rebase" and end up with an
unnecessary merge from upstream. What they usually want is either "pull
--rebase" in the simpler cases, or "pull --ff-only" to update the copy
of main integration branches, and rebase their work separately. The
pull.rebase configuration variable exists to help them in the simpler
cases, but there is no mechanism to make these users aware of it.

Issue a warning message when no --[no-]rebase option from the command
line and no pull.rebase configuration variable is given. This will
inconvenience those who never want to "pull --rebase", who haven't had
to do anything special, but the cost of the inconvenience is paid only
once per user, which should be a reasonable cost to help a number of new
users.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v5:
- Supress warning when --quiet is given
- Ensure that pull option tests still test what they're supposed to test
- Add tests for the new warning
---
 builtin/pull.c               | 16 +++++++++++++++
 t/t5521-pull-options.sh      | 22 ++++++++++-----------
 t/t7601-merge-pull-config.sh | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3e624d1e00..e42665b681 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -327,6 +327,22 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
+	if (opt_verbosity >= 0 &&
+	    (!opt_ff || strcmp(opt_ff, "--ff-only"))) {
+		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
+			"discouraged. You can squelch this message by running one of the following\n"
+			"commands sometime before your next pull:\n"
+			"\n"
+			"  git config pull.rebase false  # merge (the default strategy)\n"
+			"  git config pull.rebase true   # rebase\n"
+			"  git config pull.ff only       # fast-forward only\n"
+			"\n"
+			"You can replace \"git config\" with \"git config --global\" to set a default\n"
+			"preference for all repositories. You can also pass --rebase, --no-rebase,\n"
+			"or --ff-only on the command line to override the configured default per\n"
+			"invocation.\n"));
+	}
+
 	return REBASE_FALSE;
 }
 
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index ccde8ba491..159afa7ac8 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -11,10 +11,10 @@ test_expect_success 'setup' '
 	 git commit -m one)
 '
 
-test_expect_success 'git pull -q' '
+test_expect_success 'git pull -q --no-rebase' '
 	mkdir clonedq &&
 	(cd clonedq && git init &&
-	git pull -q "../parent" >out 2>err &&
+	git pull -q --no-rebase "../parent" >out 2>err &&
 	test_must_be_empty err &&
 	test_must_be_empty out)
 '
@@ -30,10 +30,10 @@ test_expect_success 'git pull -q --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull' '
+test_expect_success 'git pull --no-rebase' '
 	mkdir cloned &&
 	(cd cloned && git init &&
-	git pull "../parent" >out 2>err &&
+	git pull --no-rebase "../parent" >out 2>err &&
 	test -s err &&
 	test_must_be_empty out)
 '
@@ -46,10 +46,10 @@ test_expect_success 'git pull --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v' '
+test_expect_success 'git pull -v --no-rebase' '
 	mkdir clonedv &&
 	(cd clonedv && git init &&
-	git pull -v "../parent" >out 2>err &&
+	git pull -v --no-rebase "../parent" >out 2>err &&
 	test -s err &&
 	test_must_be_empty out)
 '
@@ -62,25 +62,25 @@ test_expect_success 'git pull -v --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v -q' '
+test_expect_success 'git pull -v -q --no-rebase' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
-	git pull -v -q "../parent" >out 2>err &&
+	git pull -v -q --no-rebase "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test_must_be_empty err)
 '
 
-test_expect_success 'git pull -q -v' '
+test_expect_success 'git pull -q -v --no-rebase' '
 	mkdir clonedqv &&
 	(cd clonedqv && git init &&
-	git pull -q -v "../parent" >out 2>err &&
+	git pull -q -v --no-rebase "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test -s err)
 '
 test_expect_success 'git pull --cleanup errors early on invalid argument' '
 	mkdir clonedcleanup &&
 	(cd clonedcleanup && git init &&
-	test_must_fail git pull --cleanup invalid "../parent" >out 2>err &&
+	test_must_fail git pull --no-rebase --cleanup invalid "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test -s err)
 '
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index c6c44ec570..0f97828cd0 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -27,6 +27,44 @@ test_expect_success 'setup' '
 	git tag c3
 '
 
+test_expect_success 'pull.rebase not set' '
+	git reset --hard c0 &&
+	git pull . c1 2>err &&
+	test_i18ngrep "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=false' '
+	git reset --hard c0 &&
+	test_config pull.ff false &&
+	git pull . c1 2>err &&
+	test_i18ngrep "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=only' '
+	git reset --hard c0 &&
+	test_config pull.ff only &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --rebase given' '
+	git reset --hard c0 &&
+	git pull --rebase . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --no-rebase given' '
+	git reset --hard c0 &&
+	git pull --no-rebase . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --ff-only given' '
+	git reset --hard c0 &&
+	git pull --ff-only . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
-- 
2.25.1

