Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B66C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5389B6101A
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhFGLPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFGLPD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 07:15:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F64C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 04:13:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l2so17157230wrw.6
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQWf4eeFH1Qjm+Nc57wxilQLLzOYX22gWm7ebftvENU=;
        b=DiltdBz5k5b6+S7nRXQHcwbk9qUO2647xibbAtCfBPv7Qto1KfN8rHM1ixPBy6ZIWh
         fONQPogWwLsvNfnjxsX6fxqHCN6p9dp9wiWGgauD8wtV0XWau4DCP071vOyCamvPoNDt
         bVC2bzgavUasDQlO7EK2PUkAJQ/0LCesRuK4rkH+YoSY0PjNopaYXHCczknZoqE7X9zi
         D93kcKKmtTROwmPy4IreJBikttTEw3HzYGUJCVqAnFvbfRIGBzY5IguP9UvdU5LU71bK
         yR+nW8z0QK5tBPrdXknZowgwuzQfYD3asDVMasYnAd1K1EdzGl8DLBQYXl7bCLtC3iPI
         +EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQWf4eeFH1Qjm+Nc57wxilQLLzOYX22gWm7ebftvENU=;
        b=Nwc2DSoZTGbdK2JWwSQxVTfluJalmYjPVxensNaIieuKRuwGp3vmax2KXyJkhOyZXy
         EMCtDYBgegU1nRs6B/zA8D08mckIDNgnP8qDkGBq9FNvD3d2S4alXQMHBCQzeXe60HiZ
         x3GI/ol5HkKqRDujRkdtJRJDUOhkaHF3JFKuvaEyIhqAzRlYTY+HcO2bbPcDwYzYFHO+
         G7F1AqF/xHFGXJrDY64ZI42h9yiK3qEG4MWQyE73gKDyMgZcFQjSVOR69jV52lDokw4p
         GeR/K6qs51UK0JsWymYmCmDSEIwmN5M1MTm9UgebV2FScXX0tn7a9hNE1CbyzIr5SeQH
         c4Iw==
X-Gm-Message-State: AOAM531sancmrXc3G2/Ux2ZAq1jGUmpWSyG1NjecbK9GaYb5JiFThY9Z
        tCIPIhWbW74yYiy7ezG2MGzewzeNTTiIWQ==
X-Google-Smtp-Source: ABdhPJxtzp73X0BsUq1YGfneyme+2ZGGWkVjVjoIyIkTHmpWmlatiCyaAdQmXjXQMqYTWMFyMs5srg==
X-Received: by 2002:a5d:4f05:: with SMTP id c5mr16760151wru.341.1623064380307;
        Mon, 07 Jun 2021 04:13:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l10sm15552184wrm.2.2021.06.07.04.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:12:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] builtins + test helpers: use return instead of exit() in cmd_*
Date:   Mon,  7 Jun 2021 13:12:48 +0200
Message-Id: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change various cmd_* functions to use "return" instead of exit() to
indicate an exit code. On Solaris with SunCC the compiler legitimately
complains about these, since we'll e.g. skip the cleanup (e.g. closing
fd's, erroring if we can't) in git.c's run_builtin() when we exit()
directly like this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A trivial issue noticed in my pre-v2.32.0 testing that I wanted to
leave until after the release.

 builtin/difftool.c          | 5 ++---
 builtin/merge-ours.c        | 2 +-
 builtin/mktree.c            | 2 +-
 t/helper/test-hash-speed.c  | 2 +-
 t/helper/test-hash.c        | 2 +-
 t/helper/test-match-trees.c | 2 +-
 t/helper/test-reach.c       | 2 +-
 7 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 89334b77fb..6a9242a803 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -675,7 +675,7 @@ static int run_file_diff(int prompt, const char *prefix,
 		"GIT_PAGER=", "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL,
 		NULL
 	};
-	int ret = 0, i;
+	int i;
 
 	if (prompt > 0)
 		env[2] = "GIT_DIFFTOOL_PROMPT=true";
@@ -686,8 +686,7 @@ static int run_file_diff(int prompt, const char *prefix,
 	strvec_push(&args, "diff");
 	for (i = 0; i < argc; i++)
 		strvec_push(&args, argv[i]);
-	ret = run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
-	exit(ret);
+	return run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
 }
 
 int cmd_difftool(int argc, const char **argv, const char *prefix)
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 4594507420..a745c32ae4 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -29,5 +29,5 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 		die_errno("read_cache failed");
 	if (index_differs_from(the_repository, "HEAD", NULL, 0))
 		exit(2);
-	exit(0);
+	return 0;
 }
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 891991b00d..ae78ca1c02 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -189,5 +189,5 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 		used=0; /* reset tree entry buffer for re-use in batch mode */
 	}
 	strbuf_release(&sb);
-	exit(0);
+	return 0;
 }
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index 432233c7f0..f40d9ad0c2 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -57,5 +57,5 @@ int cmd__hash_speed(int ac, const char **av)
 		free(p);
 	}
 
-	exit(0);
+	return 0;
 }
diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index 0a31de66f3..261c545b9d 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -54,5 +54,5 @@ int cmd_hash_impl(int ac, const char **av, int algo)
 		fwrite(hash, 1, algop->rawsz, stdout);
 	else
 		puts(hash_to_hex_algop(hash, algop));
-	exit(0);
+	return 0;
 }
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index b9fd427571..4079fdee06 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -23,5 +23,5 @@ int cmd__match_trees(int ac, const char **av)
 	shift_tree(the_repository, &one->object.oid, &two->object.oid, &shifted, -1);
 	printf("shifted: %s\n", oid_to_hex(&shifted));
 
-	exit(0);
+	return 0;
 }
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index cda804ed79..2f65c7f6a5 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -166,5 +166,5 @@ int cmd__reach(int ac, const char **av)
 		print_sorted_commit_ids(list);
 	}
 
-	exit(0);
+	return 0;
 }
-- 
2.32.0.rc3.434.gd8aed1f08a7

