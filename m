Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD7FC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiCYRcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbiCYRbL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:31:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F63657A0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:29:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so2932535wmq.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dscfyNry56q2ZYd+U9DaYii61bAeG8If9fRgWf8f1KU=;
        b=cmcsqNu40RDj4JfCcUjvCws0udmgi+kZtGydftTbUy35L1ARj7YJj1DmF5mtXksWIv
         i0bgitBSgUjBJTAZQdnw9rYVWHk17xktHQ+wmXMr3lV1NFV0x0/LKpjy9xoyUUDuaqMx
         Z75MXNSxSDQc233pTm9QmkVEX6DgRTXdSLOOm3dyvkpluGqnZxJkZNxuapYQilMdrsfW
         UIYIpWWKpxpENKqy0YUuUxNfFDw0KX+Yf5w4TZxzDijfYLT3IE6v1KZcE/R6UBG1zd9B
         oFqHMeiLgPeaT9Sk19QRq37aRWx0yhVT2EWoN8X7Jxwef0xWX1oLaADILBER3SZ993ux
         0m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dscfyNry56q2ZYd+U9DaYii61bAeG8If9fRgWf8f1KU=;
        b=K6lWxlIZcFL43hC8GNqQLjB7/XcWcCTxVaaxeWtqEpzAHaAQNQihcHRHk618jfUkwh
         IQGsWffJN9VtgBVwTlWK6oDE/F0KjxLZcnF5WBvz/yHlod5zlRvgbAigaAu/G6jI62Xt
         E6OXVuNGk87501T3ngTjpSxeD/C470xijF4o2+C2DWUYKJflhFwd4XeZj6GoJfwep2LG
         uPYsymQ7nm2x5cDrChhnXf3v7U5udGAoiYU/QN7U/nBK/7gIb3FoCAAiYGOJQ/zFg8pS
         Jm4RFfp7XmB1RXkLBIEfeiWnMS90+FGQM6ZQ4NTG014uGt9uOh3Qn7aSbD+U3KmMxla6
         OqHQ==
X-Gm-Message-State: AOAM531cJWrBxfsHz5U6+ygn9VFz4YH8i/giekoHF+f0UKaMZrEofjvJ
        A24jahygu3cqj1hVNQnDWyOPP4PsE/FmxQ==
X-Google-Smtp-Source: ABdhPJxbrDERCdA0hGIdZjNLMQT0TFp7rUTldOq0FTWG7zqxJtgdkYBNInGeX1OSh/YCKf0K4v2F+w==
X-Received: by 2002:a05:600c:1c84:b0:38c:abf0:c1c8 with SMTP id k4-20020a05600c1c8400b0038cabf0c1c8mr10829058wms.111.1648228787660;
        Fri, 25 Mar 2022 10:19:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 17/27] revisions API: have release_revisions() release "mailmap"
Date:   Fri, 25 Mar 2022 18:18:41 +0100
Message-Id: <patch-v3-17.27-65803961ee2-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"mailmap" in the "struct rev_info".

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
 builtin/commit.c                   | 5 ++---
 revision.c                         | 9 +++++++++
 t/t0056-git-C.sh                   | 1 +
 t/t3302-notes-index-expensive.sh   | 1 +
 t/t4055-diff-context.sh            | 1 +
 t/t4066-diff-emit-delay.sh         | 1 +
 t/t7008-filter-branch-null-sha1.sh | 1 +
 7 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c7eda9bbb72..cd6cebcf8c8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1100,7 +1100,6 @@ static const char *find_author_by_nickname(const char *name)
 	struct rev_info revs;
 	struct commit *commit;
 	struct strbuf buf = STRBUF_INIT;
-	struct string_list mailmap = STRING_LIST_INIT_NODUP;
 	const char *av[20];
 	int ac = 0;
 
@@ -1111,7 +1110,8 @@ static const char *find_author_by_nickname(const char *name)
 	av[++ac] = buf.buf;
 	av[++ac] = NULL;
 	setup_revisions(ac, av, &revs, NULL);
-	revs.mailmap = &mailmap;
+	revs.mailmap = xmalloc(sizeof(struct string_list));
+	string_list_init_nodup(revs.mailmap);
 	read_mailmap(revs.mailmap);
 
 	if (prepare_revision_walk(&revs))
@@ -1122,7 +1122,6 @@ static const char *find_author_by_nickname(const char *name)
 		ctx.date_mode.type = DATE_NORMAL;
 		strbuf_release(&buf);
 		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
-		clear_mailmap(&mailmap);
 		release_revisions(&revs);
 		return strbuf_detach(&buf, NULL);
 	}
diff --git a/revision.c b/revision.c
index 84b47552a3e..8520823d503 100644
--- a/revision.c
+++ b/revision.c
@@ -2931,10 +2931,19 @@ static void release_revisions_commit_list(struct rev_info *revs)
 	}
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
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index bb5fea02a03..d0c4d38b4d4 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -8,6 +8,7 @@ test_description='Test commit notes index (expensive!)'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_repo () {
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
index 9ba9f24ad2f..93fbc92b8db 100755
--- a/t/t7008-filter-branch-null-sha1.sh
+++ b/t/t7008-filter-branch-null-sha1.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 test_description='filter-branch removal of trees with null sha1'
+
 . ./test-lib.sh
 
 test_expect_success 'setup: base commits' '
-- 
2.35.1.1509.ge4eeb5bd39e

