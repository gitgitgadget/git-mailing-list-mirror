Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7FBC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D875B64E4B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBWHdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhBWHc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 02:32:57 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2B1C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 23:32:16 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id i8so16089544iog.7
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 23:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLFDKkt662bL3weIi3CXemQii4p7CzO74+Y2KgfQS4Y=;
        b=OP26Vv9CgAmZFHcV+RbrMo5o6orVXEUIuQAkwJQ69J50c9qEVtmk/9vZ0LORC+MMzB
         0h8ikRsPE4OPz9ABvdAaXE0rykGN3GTgNB9gTvkKAKOGBMYRe9+U9lso4b3E0Ro/VaXp
         Ou4KSoHQxKD9jJLcNaXwdgfUav4JHbI8Jne4svDv51dK2UPWYsvocXwRMbhSwTRfHR4c
         AdtV+6CPCwvrE7JLMvkHFhpYRW93CzbvsLuFAIx/cY/3hsBL+PI0zv3vWlMN9kSrp6YF
         XpQfKTT6aewiUNW8VMvyT25CCSuMFOtA6q1SEOBuTdZvKkEdNRgLDoF68L6dSeX6DXBI
         Phog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qLFDKkt662bL3weIi3CXemQii4p7CzO74+Y2KgfQS4Y=;
        b=swoVwdp3op+KXi+9VwssUoA2ceZAFYvmvE4Qcxg8j8Qh1T7chyYWBj/FV3oLXxkw1I
         w4Rww7S66hjvoq69t7Cp1KYgb81frM9PEDgQoIXogiWMSwsg/IU3JZOe0gD+GCBiVg+i
         PMRj2bU2SIbIkBdEsWi9K+9aFYsKNN2bD6iX0u6t1QaJ3DBoQsrAfpItzkehC0jHowcm
         GcJb8r/gSP/fGqVhYJ25IlOaj000r27cJZiqwgEuTokzn7UtWatII3WjwcKj4OQjhwdj
         tiYh5u9+k4WynWu+izy7zlW7z1y8HS4aL0YFD6VBaIhc9Obl9qJSuAewiAXVJLc3Wd+R
         kx6A==
X-Gm-Message-State: AOAM532wf7irCWNiFGzc/ZmCkerJP4DTXIm2bi3D6SmyfWQlHvKR7mFk
        LPmyBS7leuldE80RMHvaJCcR5IY/j7A=
X-Google-Smtp-Source: ABdhPJybOEPD9VRnufs60vwunsLppkw78WSDBYR5rmFN6cKH/uKR++JbqP0e4/Y4Ndd+Qlmq6kutNQ==
X-Received: by 2002:a5e:c60b:: with SMTP id f11mr19158401iok.52.1614065535799;
        Mon, 22 Feb 2021 23:32:15 -0800 (PST)
Received: from localhost.localdomain (097-070-162-226.res.spectrum.com. [97.70.162.226])
        by smtp.gmail.com with ESMTPSA id u14sm14057411ilv.0.2021.02.22.23.32.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 23:32:15 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Clement Moyroud <clement.moyroud@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] maintenance: fix incorrect `maintenance.repo` path with bare repository
Date:   Tue, 23 Feb 2021 02:31:07 -0500
Message-Id: <20210223073107.40675-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The periodic maintenance tasks configured by `git maintenance start`
invoke `git for-each-repo` to run `git maintenance run` on each path
specified by the multi-value global configuration variable
`maintenance.repo`. Because `git for-each-repo` will likely be run
outside of the repositories which require periodic maintenance, it is
mandatory that the repository paths specified by `maintenance.repo` are
absolute.

Unfortunately, however, `git maintenance register` does nothing to
ensure that the paths it assigns to `maintenance.repo` are indeed
absolute, and may in fact -- especially in the case of a bare repository
-- assign a relative path to `maintenance.repo` instead. Fix this
problem by converting all paths to absolute before assigning them to
`maintenance.repo`.

While at it, also fix `git maintenance unregister` to convert paths to
absolute, as well, in order to ensure that it can correctly remove from
`maintenance.repo` a path assigned via `git maintenance register`.

Reported-by: Clement Moyroud <clement.moyroud@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Reported by Clement here:
https://lore.kernel.org/git/CABXAcUzRhkeQhVtwtx-NBR0hbkoo=aCTwN464Dsj8680GPMDxw@mail.gmail.com/

builtin/gc.c           | 50 ++++++++++++++++++++++++++++--------------
 t/t7900-maintenance.sh | 13 +++++++++++
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6db9cb39e6..ef7226d7bc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1461,11 +1461,23 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	return maintenance_run_tasks(&opts);
 }
 
+static char *get_maintpath(void)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *p = the_repository->worktree ?
+		the_repository->worktree : the_repository->gitdir;
+
+	strbuf_realpath(&sb, p, 1);
+	return strbuf_detach(&sb, NULL);
+}
+
 static int maintenance_register(void)
 {
+	int rc;
 	char *config_value;
 	struct child_process config_set = CHILD_PROCESS_INIT;
 	struct child_process config_get = CHILD_PROCESS_INIT;
+	char *maintpath = get_maintpath();
 
 	/* Disable foreground maintenance */
 	git_config_set("maintenance.auto", "false");
@@ -1478,40 +1490,44 @@ static int maintenance_register(void)
 
 	config_get.git_cmd = 1;
 	strvec_pushl(&config_get.args, "config", "--global", "--get",
-		     "--fixed-value", "maintenance.repo",
-		     the_repository->worktree ? the_repository->worktree
-					      : the_repository->gitdir,
-			 NULL);
+		     "--fixed-value", "maintenance.repo", maintpath, NULL);
 	config_get.out = -1;
 
-	if (start_command(&config_get))
-		return error(_("failed to run 'git config'"));
+	if (start_command(&config_get)) {
+		rc = error(_("failed to run 'git config'"));
+		goto done;
+	}
 
 	/* We already have this value in our config! */
-	if (!finish_command(&config_get))
-		return 0;
+	if (!finish_command(&config_get)) {
+		rc = 0;
+		goto done;
+	}
 
 	config_set.git_cmd = 1;
 	strvec_pushl(&config_set.args, "config", "--add", "--global", "maintenance.repo",
-		     the_repository->worktree ? the_repository->worktree
-					      : the_repository->gitdir,
-		     NULL);
+		     maintpath, NULL);
+
+	rc = run_command(&config_set);
 
-	return run_command(&config_set);
+done:
+	free(maintpath);
+	return rc;
 }
 
 static int maintenance_unregister(void)
 {
+	int rc;
 	struct child_process config_unset = CHILD_PROCESS_INIT;
+	char *maintpath = get_maintpath();
 
 	config_unset.git_cmd = 1;
 	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
-		     "--fixed-value", "maintenance.repo",
-		     the_repository->worktree ? the_repository->worktree
-					      : the_repository->gitdir,
-		     NULL);
+		     "--fixed-value", "maintenance.repo", maintpath, NULL);
 
-	return run_command(&config_unset);
+	rc = run_command(&config_unset);
+	free(maintpath);
+	return rc;
 }
 
 static const char *get_frequency(enum schedule_priority schedule)
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 286b18db3c..2412d8c5c0 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -632,4 +632,17 @@ test_expect_success 'fails when running outside of a repository' '
 	nongit test_must_fail git maintenance unregister
 '
 
+test_expect_success 'register and unregister bare repo' '
+	test_when_finished "git config --global --unset-all maintenance.repo || :" &&
+	test_might_fail git config --global --unset-all maintenance.repo &&
+	git init --bare barerepo &&
+	(
+		cd barerepo &&
+		git maintenance register &&
+		git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
+		git maintenance unregister &&
+		test_must_fail git config --global --get-all maintenance.repo
+	)
+'
+
 test_done
-- 
2.30.1.766.gb4fecdf3b7

