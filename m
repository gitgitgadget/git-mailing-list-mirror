Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2CEC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352272AbiCaBOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352277AbiCaBOU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E921E6663B
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so31530006wrc.13
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKSNs9JsWw8wf38pLaw6o8K84BCNd8VOfAmdPxGlmFA=;
        b=WPVfUtpTS6SXCSIwGyrcTUyjMi82ZnLDfbayxTJUlsZQxZFhStvsxE5871PLaX9eBV
         x3yCQZERCj33kCatHlMDP0pK1nqfXTeN90CWo9mn3pJH15Rc0WQj4uH4TgPGNDX1++Rl
         L2jyNcXfWNGpO7fqHCWkL6P/zEvkVHLX30s8nY2xU45u6cox9LnaiG/JFKF3bfhTuN0f
         2DvlZWpb5VVmOZFwHURgxWE7fFcRXRTscAhl85Q2vXKtI8uCbm8YseqWUP4I8IJkd2dX
         uXrKBPRbYtFs7ZIpEzFn+gK1RgFS5/G4kVyl5y6A1ImsfFmuywU6JAan1f3FAD+SA6YL
         C6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKSNs9JsWw8wf38pLaw6o8K84BCNd8VOfAmdPxGlmFA=;
        b=h0WdlcOsJ2auBzjgNdUvBzN9bhOWNbJKEiS7Cmdr9Tept92lPSQJax7OuzSCoZkgze
         Jcdf0Ny1ON3JwwRTTtoW2k5uw9uBBc25hTD0dvhhOCBqbOscL14rpJneTdqQzTBHRSiT
         vZW9S7d+YswW7gxsJy9NLbfQ+VNR6VmzcqPWNt8JO+cx4sj9QKlcHAXQ+8xFiVJSsqRg
         AVe/hPWQvZ1aLE1WezyO4NIS/9l3EGjFWc0WMTFA/VCuLSJzHJuhCxmh6vujPf9J463z
         sF4pFMhuOLR64AgZqG2Q/+WIDq784K8we0LiaHpf+ZMR5bo5zPKFKbMc5g4KSG/zMCc7
         iCjA==
X-Gm-Message-State: AOAM530Hve56mqRXjd7xLBBpk9ZH6ZqQ1t0HqxdrNnCiTc++BchhBNfV
        v8Vqhl1AzfwhT9UD33N6A+Sq2fZv4DsfpA==
X-Google-Smtp-Source: ABdhPJwz4mqsVuhpENbvLB30ZtVcau7SnF4stCJ4kyFyxupCWS7VK+mvUGqMQ5WS3oipn8jO0un2aA==
X-Received: by 2002:adf:c188:0:b0:1e6:8ecb:ea5a with SMTP id x8-20020adfc188000000b001e68ecbea5amr1892786wre.711.1648689140201;
        Wed, 30 Mar 2022 18:12:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:19 -0700 (PDT)
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
Subject: [PATCH v4 17/27] revisions API: have release_revisions() release "mailmap"
Date:   Thu, 31 Mar 2022 03:11:22 +0200
Message-Id: <patch-v4-17.27-f67f1f5a575-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
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
index 394e2dcdd90..965e913ebba 100644
--- a/revision.c
+++ b/revision.c
@@ -2935,10 +2935,19 @@ static void release_revisions_commit_list(struct rev_info *revs)
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
2.35.1.1557.g4e3e9cdb5e0

