Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2591C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 14:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjBIOfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjBIOfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 09:35:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559EB366AD
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 06:35:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r2so1963083wrv.7
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 06:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyM6qpM0Bnn2LUpOXrqzACk8oZTK+FyytgxrawmbsAk=;
        b=WYOXR/BHoHl4tlDx4zBmaz5895kHctS3/9hDcgU0S6S4IxiYCGdsvHY7LBsKPVtbST
         3blLig8tGzqGyLmrj8LP6OShqNbfp2obgSbKjD9PHFk2SLofKpMC1Yz0Z4S+y0HhDlaT
         lmrZX2yhlV3e1bDZ2AOvw/G85tDSYjGkZqmBywhD/wBy6k+iiWLwXNI0PwjrBsnknM3H
         FrkeIDiZHI1eXGONUVvH6hIIqiUrwGgqPkkUXE0WFNlRoWyaNAKkayd1kdW8v9swLVf2
         QMk6UrpN46/Z35C9YIj84y4jV57FfVWHZxxe6YJYaB10L+YCOBSQwvsVFzHzJkuSz/kc
         Od6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyM6qpM0Bnn2LUpOXrqzACk8oZTK+FyytgxrawmbsAk=;
        b=pqlefwTKPHFqr2R3phaKCWJ8rQ0m5+hjs4E5mGmkoZ4L2xoLrwO3QYa/hhqWuzxEDk
         W9mbcc3wlRDpq3zWSVobFfAUc2rPms60wZkuLKyjCoCZxXDpVClBa0mCTBHYK5tIRDCm
         qcwisAGb0wUX45wHHBYC7nwYB5WeOkzdYx4dkAZQ1Mja5nynGFLpyhMt3+n+4u8ZEi/N
         ZFGJnuOb9XqNk2+JzkeK6PmY7CZXpcPEO1Z81CZIkyIip04eJlM0/vv+BrWXAUTyNLHD
         PZl7XztC3UwOIAo6Q/cFaJANly5qjX+iYOIbRMBoYdJ0q7FZR8uyYsJBG64q5oKXn/or
         tvzw==
X-Gm-Message-State: AO0yUKUxgoSljPIoSDphch3m4r65pIaXgIWutydRe4YKU9+huM2THswr
        Q74ZnB5/ngJP/6qO4/ynU76RIPvPfLLpTLIu
X-Google-Smtp-Source: AK7set8e0tcIto8zzWc4mCuim5Kqj61hHjmvAOkEySkjkjGme6a86GKqSf/brfeDNyvnpQbM7ibuUQ==
X-Received: by 2002:adf:dc92:0:b0:2c4:3c6e:be32 with SMTP id r18-20020adfdc92000000b002c43c6ebe32mr2240018wrj.27.1675953310670;
        Thu, 09 Feb 2023 06:35:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002c3d814cc63sm1391477wrx.76.2023.02.09.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 06:35:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Max Gautier <max.gautier@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] {am,commit-tree,verify-{commit,tag}}: refactor away config wrapper
Date:   Thu,  9 Feb 2023 15:35:05 +0100
Message-Id: <patch-1.2-d93c160dcbc-20230209T142225Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-0.2-00000000000-20230209T142225Z-avarab@gmail.com>
References: <+TqEM21o+3TGx6D@coredump.intra.peff.net> <cover-0.2-00000000000-20230209T142225Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit these config functions became mere wrappers
for git_default_config(), so let's invoke it directly instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c            | 7 +------
 builtin/commit-tree.c   | 7 +------
 builtin/verify-commit.c | 7 +------
 builtin/verify-tag.c    | 7 +------
 4 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 40126b59c54..fccf40f8ee7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2312,11 +2312,6 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 	return 0;
 }
 
-static int git_am_config(const char *k, const char *v, void *cb UNUSED)
-{
-	return git_default_config(k, v, NULL);
-}
-
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
@@ -2440,7 +2435,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(usage, options);
 
-	git_config(git_am_config, NULL);
+	git_config(git_default_config, NULL);
 
 	am_state_init(&state);
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index f6a099d601c..c0bbe9373d0 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -37,11 +37,6 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
 	commit_list_insert(parent, parents_p);
 }
 
-static int commit_tree_config(const char *var, const char *value, void *cb)
-{
-	return git_default_config(var, value, cb);
-}
-
 static int parse_parent_arg_callback(const struct option *opt,
 		const char *arg, int unset)
 {
@@ -118,7 +113,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(commit_tree_config, NULL);
+	git_config(git_default_config, NULL);
 
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage_with_options(commit_tree_usage, options);
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 3c5d0b024c9..7aedf10e856 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -52,11 +52,6 @@ static int verify_commit(const char *name, unsigned flags)
 	return run_gpg_verify((struct commit *)obj, flags);
 }
 
-static int git_verify_commit_config(const char *var, const char *value, void *cb)
-{
-	return git_default_config(var, value, cb);
-}
-
 int cmd_verify_commit(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
@@ -67,7 +62,7 @@ int cmd_verify_commit(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_verify_commit_config, NULL);
+	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_commit_options,
 			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index ecffb069bf1..5c00b0b0f77 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -19,11 +19,6 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-static int git_verify_tag_config(const char *var, const char *value, void *cb)
-{
-	return git_default_config(var, value, cb);
-}
-
 int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
@@ -36,7 +31,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_verify_tag_config, NULL);
+	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
-- 
2.39.1.1475.gc2542cdc5ef

