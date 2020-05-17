Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCCDC433E1
	for <git@archiver.kernel.org>; Sun, 17 May 2020 06:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A053A20735
	for <git@archiver.kernel.org>; Sun, 17 May 2020 06:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udlg0H+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgEQGab (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 02:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgEQGaa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 02:30:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB5BC061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 23:30:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i15so7949392wrx.10
        for <git@vger.kernel.org>; Sat, 16 May 2020 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7hrb9rt8MXfRijWdeXjf6Hcsg7KqppbSs4hF2rUTeXg=;
        b=udlg0H+OgZ6IP8kcQ6KiaHu7k+xl1VOYPSZ7xzGxWA2yuvr3o10gsb6tB15h0nCpyl
         K2hr1jbdfnzokc9TzMxKC+1u7tskzU5K2+nl0Io4R/z6BGSuHPeM0Kf9ZSvhw+pCr2m/
         zv6q/16f3QKlqydkQioCdXT6IM885S1iWRmLMAH3gPYmjpqQmWKCrJeK9sv7nNoSyyr+
         K347KkHj58U27beca1ONkRcFbZOQZp6p18BOVkMgRJNunfz0x5q8JTB2O6QlqKeLFhC7
         nb3wthM/ME4ZdXNh41S868fQPlsfzW+w51fpOsNHjITXK4TK+ZQ8oIW3/n0M22geHI+U
         /6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7hrb9rt8MXfRijWdeXjf6Hcsg7KqppbSs4hF2rUTeXg=;
        b=dbW7pk6GCaylzaQanfBYRt02xN/jpc51PW1ovUO4pFuSA+ufwqLLV+9TbVEYtwj/Jn
         yZg/vRKIxUmX/qrXtl9u68FjtGay7VuLPHDbD7grxXzA+zdcPsJ2Yp8pSnD53u36nuL3
         K9k2/OFLy9hAcl77HjVgoE3rAzSW3yC9bpwKHFoo1DMVUPuFqwFIl0yhzUk/jHJk92nA
         0KLkVcXjjhx+/yHw3b+5FY7HY/1hQxbgC0MzDEnyVMbYfINk0rw0dprklRjB/4OBbtGJ
         D5j1j6pCD5Pv+x5VR+TzOQxTmvrYdtXuWHsSa/pQMaXyRBhW1rVvFRZQ22b+RnnvKuRi
         hFtg==
X-Gm-Message-State: AOAM531/71C+LJ4F/58aDm+b56AaciJHh7WowSciKuuGGS0EGLoeC7QW
        KkRCbE/SQoilMvs8FscsS5hp9P53
X-Google-Smtp-Source: ABdhPJx8OF2WyIHOu6Co0Sp4hmiK7M7JCggNbxTuk11HRoXuE/OLlsL33bEw/q21jk7Eh6Zrftl/0A==
X-Received: by 2002:adf:d849:: with SMTP id k9mr12894356wrl.304.1589697027511;
        Sat, 16 May 2020 23:30:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5sm10559349wrr.93.2020.05.16.23.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 23:30:27 -0700 (PDT)
Message-Id: <f9cbdcdeacff3c86a4bce6b43ef105c7aab2fcd3.1589697023.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.631.v2.git.1589697023.gitgitgadget@gmail.com>
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
        <pull.631.v2.git.1589697023.gitgitgadget@gmail.com>
From:   "Guillaume Galeazzi via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 May 2020 06:30:22 +0000
Subject: [PATCH v2 2/3] submodule--helper.c: add populated to foreach
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Guillaume G." <guillaume.galeazzi@gmail.com>,
        Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Guillaume Galeazzi <guillaume.galeazzi@gmail.com>

On a repository with some submodules not initialised, one may need to
run a command only for not initilaised submodule or vice-versa. This
change, add the flag `--[no-]populated` to subcommand `foreach` of `git
submodule--helper`.

Signed-off-by: Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
---
 builtin/submodule--helper.c  | 14 ++++++++------
 t/t7407-submodule-foreach.sh | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4b17e3b3b11..eb17e8c5293 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -451,11 +451,12 @@ struct foreach_cb {
 	int quiet;
 	int recursive;
 	int active_only;
+	int populated_only;
 };
 
 #define FOREACH_BOOL_FILTER_NOT_SET -1
 
-#define FOREACH_CB_INIT { .active_only=FOREACH_BOOL_FILTER_NOT_SET }
+#define FOREACH_CB_INIT { .active_only = FOREACH_BOOL_FILTER_NOT_SET, .populated_only = 1 }
 
 static void runcommand_in_submodule(const struct cache_entry *list_item,
 				    struct foreach_cb *info)
@@ -475,9 +476,6 @@ static void runcommand_in_submodule(const struct cache_entry *list_item,
 		die(_("No url found for submodule path '%s' in .gitmodules"),
 			displaypath);
 
-	if (!is_submodule_populated_gently(path, NULL))
-		goto cleanup;
-
 	prepare_submodule_repo_env(&cp.env_array);
 
 	/*
@@ -554,7 +552,6 @@ static void runcommand_in_submodule(const struct cache_entry *list_item,
 				displaypath);
 	}
 
-cleanup:
 	free(displaypath);
 }
 
@@ -571,6 +568,9 @@ static void runcommand_in_submodule_filtered_cb(const struct cache_entry *list_i
 			return;
 	}
 
+	if (info->populated_only != is_submodule_populated_gently(path, NULL))
+		return;
+
 	runcommand_in_submodule(list_item, info);
 }
 
@@ -586,11 +586,13 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 			 N_("Recurse into nested submodules")),
 		OPT_BOOL(0, "active", &info.active_only,
 			 N_("Call command depending on submodule active state")),
+		OPT_BOOL(0, "populated", &info.populated_only,
+			 N_("Call command depending on submodule populated state")),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper foreach [--quiet] [--recursive] [--[no-]active] [--] <command>"),
+		N_("git submodule--helper foreach [--quiet] [--recursive] [--[no-]active] [--[no-]populated] [--] <command>"),
 		NULL
 	};
 
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 57c5ae70c8d..be6cd80d464 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -80,6 +80,21 @@ test_expect_success 'test basic "submodule foreach" usage' '
 	test_i18ncmp expect actual
 '
 
+sub2sha1=$(cd super/sub2 && git rev-parse HEAD)
+
+cat > expect <<EOF
+Entering 'sub2'
+$pwd/clone-foo2-sub2-$sub2sha1
+EOF
+
+test_expect_success 'test "submodule--helper foreach --no-populated" usage' '
+	(
+		cd clone &&
+		git submodule--helper foreach --no-populated "echo \$toplevel-\$name-\$path-\$sha1" > ../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
 cat > expect <<EOF
 Entering 'sub3'
 $pwd/clone-foo3-sub3-$sub3sha1
-- 
gitgitgadget

