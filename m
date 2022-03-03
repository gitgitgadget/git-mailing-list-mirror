Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865D5C433FE
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiCCA7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiCCA6x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:53 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA26156785
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:58:09 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id k130-20020a628488000000b004f362b45f28so2190158pfd.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5/J/TQNvnprNfyNbTTu8oTUqdxY0t77pvG2ZrTX88sY=;
        b=qVlF2ZcTOv4G4cwuGfLFSx0vuaqL3A9aETwgZQveRQbZ0IX+Pw5m13i8SE9eOshFYJ
         cFyhAT+aC7TJAhhvZQZRcG7tR64gzUl9TPh5QaODM5dKGnzYH7BGI4Z1FF5gmG4WtKvE
         hdmPe7tqy3mI2XjGaooq3gS4mR3y/WaoVpbjB34wm4Fn8cpHuE+epgkfqScRPYIzXxjc
         kZHh2g7pGo6cBxc/qPqsSbSm6cBdWu8VOROA4/4EiO0l9l0QSd9Eg9WExQhDLLbYZHoZ
         emL52YEH4uTzaC+IQJzKEqyMuQkzFrUfl5Lv5UTnruCIg7panmhxPuzkky4mcyRkl9T9
         9cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5/J/TQNvnprNfyNbTTu8oTUqdxY0t77pvG2ZrTX88sY=;
        b=Soz6jK/l2cQc0SlmI8yKNEXAmaWpGyfP1iQmncX/15drJLEyVzeLpkGxmWxnJl/3Zn
         R7Mzs2i+kZnObwLumWB3Pc84JXjpxlqD+asANr4k0zcpGvy3lzpSZmLwnaN5CQtdMjiD
         U1lsuUV0nXNRHc93Dw1YK4GwlpT2xpZ3eY0YAK3qFk4PFUDgzqrz5pGoFEfpnPHeYv9F
         tKz2RDFVpknNlTBpYGWLNY21pG8krENjKIcnWPFVXfzWNu2WkrGhH95x886d/Ws++c6E
         GgyNO7Avy+9zz20s2dEbIJFSztAEx/0KZsRfBxdEQPRGfLrKymkXQ79Z47GF0frq0HQy
         tnyw==
X-Gm-Message-State: AOAM5322RJ94Ldp7PkTZY7x88XUiG+9eH//RbzYT5DlIeZdrT4qOB9G1
        l68BDbYCazlrtOhG1Ol4hGdGCyv1hge8nVQvSZ0CcHTszhjmMnnzbQVntfWx9VjAdaW8DAUZMhE
        4HvWT5byM6xt7ogsClFQwdQ7q2GrCteDftLEbTOpsKkpYbY2MhZrZiKyKe61txsA=
X-Google-Smtp-Source: ABdhPJwmXwK/5cIEmgAQFS9pFUfHfvOS8W4CAos6FOAcH7qZwNBjqsLgopOlvqaXODGNw/Jx5orE4BRedGMGjA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:920f:0:b0:378:9ef8:7978 with SMTP id
 o15-20020a63920f000000b003789ef87978mr15068496pgd.587.1646269088614; Wed, 02
 Mar 2022 16:58:08 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:27 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-14-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 13/13] submodule--helper update-clone: check for --filter
 and --init
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git submodule update --filter" also requires the "--init" option. Teach
update-clone to do this usage check in C and remove the check from
git-submodule.sh.

In addition, change update-clone's usage string so that it teaches users
about "git submodule update" instead of "git submodule--helper
update-clone" (the string is copied from git-submodule.sh). This should
be more helpful to users since they don't invoke update-clone directly.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 20 +++++++++++++++++++-
 git-submodule.sh            |  5 -----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 296ab80bf2..bef9ab22d4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2545,7 +2545,12 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
+		N_("git submodule [--quiet] update"
+		" [--init [--filter=<filter-spec>]] [--remote]"
+		" [-N|--no-fetch] [-f|--force]"
+		" [--checkout|--merge|--rebase]"
+		" [--[no-]recommend-shallow] [--reference <repository>]"
+		" [--recursive] [--[no-]single-branch] [--] [<path>...]"),
 		NULL
 	};
 	suc.prefix = prefix;
@@ -2556,6 +2561,19 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
+
+	if (filter_options.choice && !suc.init) {
+		/*
+		 * NEEDSWORK: Don't use usage_with_options() because the
+		 * usage string is for "git submodule update", but the
+		 * options are for "git submodule--helper update-clone".
+		 *
+		 * This will no longer be an issue when "update-clone"
+		 * is replaced by "git submodule--helper update".
+		 */
+		usage(git_submodule_helper_usage[0]);
+	}
+
 	suc.filter_options = &filter_options;
 
 	if (update)
diff --git a/git-submodule.sh b/git-submodule.sh
index 51be7c7f7e..aa8bdfca9d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -356,11 +356,6 @@ cmd_update()
 		shift
 	done
 
-	if test -n "$filter" && test "$init" != "1"
-	then
-		usage
-	fi
-
 	{
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update-clone \
 		${GIT_QUIET:+--quiet} \
-- 
2.33.GIT

