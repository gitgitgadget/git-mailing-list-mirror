Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0386EC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 16:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987F5206F9
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 16:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNo3LsXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390421AbgKXQon (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 11:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389515AbgKXQon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 11:44:43 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63621C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 08:44:41 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cq7so21570545edb.4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 08:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wpv1d1POj7qsPzxhnEKnE0zg4gLwW5YwBc52keAnnVw=;
        b=NNo3LsXhLnJSFK/YXgg6uupYL4JRoh2ocE5oh0+e7Im2uBVxD5ECTmW/JN2zDKFKnV
         7DlH6k/BJ34V//ghyOoDqzJYU/+VMOKrJnB+JJ9huq/CKFHfc8o+dis046ExDtmBHLPj
         XXAWA5MxAPSlvq5hFL3lXxML0uzFmjoTTQxenZF7/4EFSQzNs5kswEF/2cDscAtJgBrR
         /Cj3NcoceV0d75xauMXBb/1QOl1Jy0snZa4JmLedVyg/o3NlhJ/0TSxYxWWgI7JKeMAZ
         S9pFZ/B5zHpvJP9g/mMWTFBqCMN4VL8CXaUWGueZkEDER0dolIu93WqSbGEt3WMkYox8
         LGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpv1d1POj7qsPzxhnEKnE0zg4gLwW5YwBc52keAnnVw=;
        b=kbanuRPTLTTHoCz1RCLTfWsllGq0WQ/4nc3x39b17BrIyM2BE2ampdZaTwQEHYhHVy
         GAUJeEoK8R18p++90ggyK6/jVPd0VYctEnVDTEYRBSqPb7iwo5g9BMGhMt/7ghojVF1N
         LiaeH5U8+RZ9fbryh2hnqvimyUiJxtItmPhFT6jN9PySFkmlz6zl2yPjcKr70L5xK8bs
         ERhqSDn+A8RWSpoBz3fdm4F2FATyD3bRMPGjBRg+HaoMWEpchxf0bGOhUxQAtqp+B5k3
         ceJSpYSVveJ/prt+ygsmajpXp59LhZjsVbdJECAWmBTmITHTm6zIKf4ecMZHQMfOm4YU
         DhqQ==
X-Gm-Message-State: AOAM531YI2fzlfAnztC5ZTuC76WyL4He9Zjnt5m/VJtSdFpjEViqMzUL
        kcNa1QsqzfridpYQl8+L6PuKnXROZq6gobLP
X-Google-Smtp-Source: ABdhPJwJfTg12l9KOa584NSQ0jBFiBNhmL3CKxjIT/Hsm+wmkeF0OXLRfl/U8gcOAfzL0JIehTavOA==
X-Received: by 2002:a05:6402:22e3:: with SMTP id dn3mr5044117edb.136.1606236279792;
        Tue, 24 Nov 2020 08:44:39 -0800 (PST)
Received: from contrib-buster.auto1.local ([79.140.115.35])
        by smtp.gmail.com with ESMTPSA id c8sm7347884edr.29.2020.11.24.08.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 08:44:39 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
Date:   Tue, 24 Nov 2020 16:44:05 +0000
Message-Id: <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.29.2.505.g04529851e5
In-Reply-To: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git maintenance run" and "git maintenance start" commands holds a
file-based lock at the .git/maintenance.lock and .git/schedule.lock
respectively. These locks are used to ensure only one maintenance process
is executed at the time as both operations involves writing data into
the git repository.

The path to the lock file is built using the "the_repository->objects->odb->path"
that results in SEGFAULT when we have no repository available as
"the_repository->objects->odb" is set to NULL.

Let's teach the maintenance_run_tasks() and update_background_schedule() to return
an error and fails the command when we have no repository available.

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>

---
 builtin/gc.c           | 14 ++++++++++++--
 t/t7900-maintenance.sh |  5 +++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3d258b60c2..d133d93a86 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1265,9 +1265,14 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 {
 	int i, found_selected = 0;
 	int result = 0;
+	char *lock_path;
 	struct lock_file lk;
 	struct repository *r = the_repository;
-	char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);
+
+	if (!r || !r->gitdir)
+		return error(_("not a git repository"));
+
+	lock_path = xstrfmt("%s/maintenance", the_repository->objects->odb->path);
 
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
 		/*
@@ -1513,8 +1518,13 @@ static int update_background_schedule(int run_maintenance)
 	FILE *cron_list, *cron_in;
 	const char *crontab_name;
 	struct strbuf line = STRBUF_INIT;
+	char *lock_path;
 	struct lock_file lk;
-	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
+
+	if (!the_repository || !the_repository->gitdir)
+		return error(_("not a git repository"));
+
+	lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
 
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
 		return error(_("another process is scheduling background maintenance"));
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d9e68bb2bf..bb3556888d 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -441,4 +441,9 @@ test_expect_success 'register preserves existing strategy' '
 	test_config maintenance.strategy incremental
 '
 
+test_expect_success 'run and start command fails when no git repository' '
+	test_must_fail git -C /tmp/ maintenance run &&
+	test_must_fail git -C /tmp/ maintenance start
+'
+
 test_done
-- 
2.29.2.505.g04529851e5

