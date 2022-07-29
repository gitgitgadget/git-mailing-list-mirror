Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C37EC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiG2I0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiG2I0I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:26:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0DE2980A
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id p10so891928wru.8
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WA3CTnIhIwO/ApTR4uUqeq6vPIIaH9HzuC3FpFJFngE=;
        b=LwhpAq8y1+pQxliPgqiHIhE+nfL/yTwy36Bfcgg5n2YtyALMv/YLoD9Y7WJ7I2yJ6f
         pBIxv9wKjVS6sGwUGqwJ5ofQECe9IvVQVxzuEuooNeFzQqnB5loojJPAyFcQSFuVwqHl
         1nqVaPb4C3IyglbOEHWFe1VW2u+bVB+RDCGCkAYcYWwVzc8N30n+THZJ5R+JH5MhfVXP
         W/sHUn7OmlYufT3SKYvQk8tXFfDOrQj/CLYHq9MLgk1uh7b5JobozqWJZkZRoExgqGyS
         T1OH+PHl3S/4xz7rlwsRNVmJ8SRe+5IyG/kyPnRZEvGXRwcGmDVc3xPwUPUQ8QNmbN29
         X7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WA3CTnIhIwO/ApTR4uUqeq6vPIIaH9HzuC3FpFJFngE=;
        b=1H2GJTbCQygh0I17zcJtL8b3LOqJsgu2sEluVKz8VomFEplR6cDe3jdddB5MwnEOTu
         Mqpm4c+k7cn6GqjbAJou1y8D+bd9Vw/0leohlZeml6yJtLYz/yPIkUmugZOMVNhhYkm8
         P3CTNn3/pcWa5JD6kqikvBcqZ5WLcTvYEawICC/Qm/Bu33UqXd2xOXKTwed7bwuW8B8a
         0rb2Oz0e3M0wl07Zv1bIOq/hOZdWnfY3/+VQAYrcjK2mDK9ABmNIWBYnlV4Gzx1ecYn7
         ocZMIPusE8yHP7f43vbV3FOmZibDhQ0zm7Gya4whTClyesuJLmHlEnuiYG5L99L3nOX6
         RhvA==
X-Gm-Message-State: ACgBeo2OCHQ8xP5RzxonLmPMYoSzHUlLK26KTfoaBOkZw7oQ9dPZ9nI/
        ZIZCCjk+5yZGI9Z4/vaGKFe9fwppe67Esg==
X-Google-Smtp-Source: AA6agR5J77A7PMSROvKhCEs9/f8dLnKFRJceOOnC42+/jsvD8y4BciG1xcd3saLCXxVm0s+80aA6zw==
X-Received: by 2002:a5d:5a96:0:b0:21e:6120:edeb with SMTP id bp22-20020a5d5a96000000b0021e6120edebmr1568563wrb.121.1659083163432;
        Fri, 29 Jul 2022 01:26:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2994802wrh.17.2022.07.29.01.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:26:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/9] log docs: de-duplicate configuration sections
Date:   Fri, 29 Jul 2022 10:25:53 +0200
Message-Id: <patch-v2-7.9-08d98767384-20220729T081959Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
References: <cover.1657819649.git.matheus.bernardino@usp.br> <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/log.txt | 18 +++++++++++++-----
 Documentation/git-log.txt    | 33 +++++----------------------------
 2 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 456eb07800c..12ede8e31b8 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -1,12 +1,11 @@
-log.abbrevCommit::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
-	override this option with `--no-abbrev-commit`.
-
 log.date::
 	Set the default date-time mode for the 'log' command.
 	Setting a value for log.date is similar to using 'git log''s
 	`--date` option.  See linkgit:git-log[1] for details.
++
+If the format is set to "auto:foo" and the pager is in use, format
+"foo" will be the used for the date format. Otherwise "default" will
+be used.
 
 log.decorate::
 	Print out the ref names of any commits that are shown by the log
@@ -45,6 +44,11 @@ log.showRoot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
+log.abbrevCommit::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
+	override this option with `--no-abbrev-commit`.
+
 log.showSignature::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--show-signature`.
@@ -53,3 +57,7 @@ log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
 	assume `--no-use-mailmap`. True by default.
++
+The behavior of `log.mailmap` is impacted by the setting of the more
+general 'mailmap.*' configuration variables, i.e. `mailmap.file` and
+`mailmap.blob`.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index ed802bb8e12..69c4e13833d 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -42,6 +42,9 @@ OPTIONS
 	shown. The option `--decorate` is short-hand for `--decorate=short`.
 	Default to configuration value of `log.decorate` if configured,
 	otherwise, `auto`.
++
+This output may be colored. See `color.ui` in linkgit:git-config[1]
+and `color.decorate` there and in the "CONFIGURATION" section below.
 
 --decorate-refs=<pattern>::
 --decorate-refs-exclude=<pattern>::
@@ -199,36 +202,10 @@ i18n.logOutputEncoding::
 	Defaults to the value of `i18n.commitEncoding` if set, and UTF-8
 	otherwise.
 
-log.date::
-	Default format for human-readable dates.  (Compare the
-	`--date` option.)  Defaults to "default", which means to write
-	dates like `Sat May 8 19:35:34 2010 -0500`.
-+
-If the format is set to "auto:foo" and the pager is in use, format
-"foo" will be the used for the date format. Otherwise "default" will
-be used.
-
-log.follow::
-	If `true`, `git log` will act as if the `--follow` option was used when
-	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
-
-log.showRoot::
-	If `false`, `git log` and related commands will not treat the
-	initial commit as a big creation event.  Any root commits in
-	`git log -p` output would be shown without a diff attached.
-	The default is `true`.
-
-log.showSignature::
-	If `true`, `git log` and related commands will act as if the
-	`--show-signature` option was passed to them.
-
-mailmap.*::
-	See linkgit:git-shortlog[1].
-
 include::includes/cmd-config-section-rest.txt[]
 
+include::config/log.txt[]
+
 include::config/notes.txt[]
 
 GIT
-- 
2.37.1.1196.g8af3636bc64

