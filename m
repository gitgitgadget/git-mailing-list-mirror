Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3A8C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiCINTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiCINTX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BAB179264
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:59 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p9so2956981wra.12
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zqgN6PyQg+3srJo009vad6F2EKj0rAzah0mvKa1Aa+U=;
        b=Fxj9UqK0iy/TsAeeI17iB+Laky2m1+rb32+fqsgS/tMWS9Htbvyhj0LQ/GFyu+KCOA
         6/SWDZzRT8ZuWexK22FBQaUVTQxgGerQWtBcZR9rv9t02W8y91rHVhRkWhrpkGSNBKBV
         ZGQx4zRYW968HV3W8nHnTkeCfb1ZD5MxvlCgQzL0tbPXemjqcUPFc3E5m6pKEAPhNCe/
         ghnP5itx3zf8uWTUNFVqpuZQQdyd9CCmWqEbU5SLAgDJj760nRXYMm0J5BKusDFf/yXN
         JPpikBgFJH9stIr4zpAhrmB7ZnCzK6vJFoOTX8++BLbh8dAb1wFkLoKWA1qQ627LwyW5
         pX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqgN6PyQg+3srJo009vad6F2EKj0rAzah0mvKa1Aa+U=;
        b=S9wQ+UqudHCm9WbDwP/9loxBdgFRbcwuAbX/gzJ1MXH/MdBAkc/6V7LUSfQyu/+KvU
         PAAJvrDKt+LIOkCJT0SXrhZXiphqZS30l4zx4Dgvkfi4aDM+pMoqW0E8f6cZ6yugBJgu
         w91fpzB+36v/PbHZXKNMDT1S1hwZqCcqRjMQKzHL5sNAFgZnOXpTQAOWLs+xS0npLquN
         sluk6aLe718sPg4cWc8/FYttuHE4OnSAA3bsqpzJk4stdkuWqFdKWqMcuoxqvTWyilx6
         NOtmchvQioBE2T5Dhva4d6hkF38t3xprfwVYRKUDiCbtEy7VGxmzjRATQhVRsteyTs/X
         ITgA==
X-Gm-Message-State: AOAM532oCMfSxjUfoOn5aAJZZ0A+qqef8KEE1tGo8iQcur7i+F6no9Nb
        cKeeuKG/yczhecK8xzgKVuDA8yrTlQwSmw==
X-Google-Smtp-Source: ABdhPJwbnbKXM/opleL0I5Migv+r8l4c1s12gvRxoSZRyGuf0OQS5u5n5JtWJgbG2dfBWDcxRg+ZZw==
X-Received: by 2002:a5d:588e:0:b0:203:77d2:af48 with SMTP id n14-20020a5d588e000000b0020377d2af48mr2263341wrf.214.1646831877971;
        Wed, 09 Mar 2022 05:17:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/24] revisions API: have release_revisions() release "mailmap"
Date:   Wed,  9 Mar 2022 14:16:46 +0100
Message-Id: <patch-16.24-1a988c96371-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"prune_data" in the "struct ref_info".

The log family of functions now calls the clear_mailmap() function
added in fa8afd18e5a (revisions API: provide and use a
release_revisions(), 2021-09-19), allowing us to whitelist some tests
with "TEST_PASSES_SANITIZE_LEAK=true".

Unfortunately having a pointer to a mailmap in "struct rev_info"
instead of an embedded member that we "own" get a bit messy, as can be
seen in the change to builtin/commit.c.

When we free() this data we won't be able to tell apart a pointer to a
"mailmap" on the heap from one on the stack. As seen in
ea57bc0d41b (log: add --use-mailmap option, 2013-01-05) the "log"
family allocates it on the heap, but in the find_author_by_nickname()
code added in ea16794e430 (commit: search author pattern against
mailmap, 2013-08-23) we allocated it on the stack instead.

Ideally we'd simply change that member to a "struct string_list
mailmap" and never free() the "mailmap" itself, but that would be a
much larger change to the revisions API.

We have code that needs to hand an existing "mailmap" to a "struct
rev_info", while we could change all of that, let's not go there
now.

The complexity isn't in the ownership of the "mailmap" per-se, but
that various things assume a "rev_info.mailmap == NULL" means "doesn't
want mailmap", if we changed that to an init'd "struct string_list
we'd need to carefully refactor things to change those assumptions.

Let's instead always free() it, and simply declare that if you add
such a "mailmap" it must be allocated on the heap. Any modern libc
will correctly panic if we free() a stack variable, so this should be
safe going forward.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c                   | 6 +++---
 revision.c                         | 9 +++++++++
 t/t0056-git-C.sh                   | 1 +
 t/t4055-diff-context.sh            | 1 +
 t/t4066-diff-emit-delay.sh         | 1 +
 t/t7008-filter-branch-null-sha1.sh | 2 ++
 6 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 74388a6b9a1..9a6f38db165 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1097,7 +1097,7 @@ static const char *find_author_by_nickname(const char *name)
 	struct rev_info revs;
 	struct commit *commit;
 	struct strbuf buf = STRBUF_INIT;
-	struct string_list mailmap = STRING_LIST_INIT_NODUP;
+	struct string_list *mailmap = xmalloc(sizeof(struct string_list));
 	const char *av[20];
 	int ac = 0;
 
@@ -1108,7 +1108,8 @@ static const char *find_author_by_nickname(const char *name)
 	av[++ac] = buf.buf;
 	av[++ac] = NULL;
 	setup_revisions(ac, av, &revs, NULL);
-	revs.mailmap = &mailmap;
+	string_list_init_nodup(mailmap);
+	revs.mailmap = mailmap;
 	read_mailmap(revs.mailmap);
 
 	if (prepare_revision_walk(&revs))
@@ -1119,7 +1120,6 @@ static const char *find_author_by_nickname(const char *name)
 		ctx.date_mode.type = DATE_NORMAL;
 		strbuf_release(&buf);
 		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
-		clear_mailmap(&mailmap);
 		release_revisions(&revs);
 		return strbuf_detach(&buf, NULL);
 	}
diff --git a/revision.c b/revision.c
index 475901d77e3..2050a691683 100644
--- a/revision.c
+++ b/revision.c
@@ -2926,12 +2926,21 @@ static void release_revisions_commit_list(struct rev_info *revs)
 	revs->commits = NULL;
 }
 
+static void release_revisions_mailmap(struct string_list *mailmap)
+{
+	if (!mailmap)
+		return;
+	clear_mailmap(mailmap);
+	free(mailmap);
+}
+
 void release_revisions(struct rev_info *revs)
 {
 	if (!revs)
 		return;
 	release_revisions_commit_list(revs);
 	object_array_clear(&revs->pending);
+	release_revisions_mailmap(revs->mailmap);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
index 2630e756dab..752aa8c9454 100755
--- a/t/t0056-git-C.sh
+++ b/t/t0056-git-C.sh
@@ -2,6 +2,7 @@
 
 test_description='"-C <path>" option and its effects on other path-related options'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success '"git -C <path>" runs git from the directory <path>' '
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 741e0803c1a..73048d0a526 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -5,6 +5,7 @@
 
 test_description='diff.context configuration'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4066-diff-emit-delay.sh b/t/t4066-diff-emit-delay.sh
index a1de63b77f8..0ecb3915412 100755
--- a/t/t4066-diff-emit-delay.sh
+++ b/t/t4066-diff-emit-delay.sh
@@ -4,6 +4,7 @@ test_description='test combined/stat/moved interaction'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test covers a weird 3-way interaction between "--cc -p", which will run
diff --git a/t/t7008-filter-branch-null-sha1.sh b/t/t7008-filter-branch-null-sha1.sh
index 9ba9f24ad2f..0ce8fd2c895 100755
--- a/t/t7008-filter-branch-null-sha1.sh
+++ b/t/t7008-filter-branch-null-sha1.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='filter-branch removal of trees with null sha1'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: base commits' '
-- 
2.35.1.1295.g6b025d3e231

