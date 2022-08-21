Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D13C32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiHUOAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiHUN7l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF45623BDE
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n7so10297998wrv.4
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+TIeCK2o8Goojyff7ZcfpHsF40olPSlEXw7G4gQfmLE=;
        b=bLTv14LuTDIFAEx8f2e/2QoxDBIzxN04w//s+UCpjqL0YqGMEIOCbdsRMnscNrbWc6
         cZXZrxYWqEiD94CYE+g1ok8TWQRr9cS3Z8Nc5kp/U5ZSydmBXEzXmZDixgS/H/5qULNj
         yozqa5qYJb0EnQJE35tZz+JVae6NtJ/GCpTxtEt2PZ6OqU6ICUZxUyhfx04KLSjkdOGp
         RLmsatUzb5pky9z0CMEM9kJ3xZAv5mTjvsnezIyvaOIGBzojR3B8tHi0RvwNDE8j90Li
         XxBSDQpF12w0IpY4tFQoJId+mc3cJms+Lnw6KTt7KXf1M2QAbb19mVnpg4vhST3EUvQs
         Zv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+TIeCK2o8Goojyff7ZcfpHsF40olPSlEXw7G4gQfmLE=;
        b=Ei6LYk3Q91YDicbGFXQgYM6jgwtABtjCUr1zGoo6kTR7ttBjMM9VvPEIlVIwh0laCf
         sZcZx1pBnLm//j/7Nu1PCYW1eyVOafNhvEKl26kPqesBqvZX5v0hzA3nwI3RDcYmD2MS
         iHTNpmIal1YSVEIHIJTSBM0FFw/N9EsPO98+KHU+TbrfNLxjrh2OkP1MbGsWqkLHeIPL
         CYvTBwNx0QAxxLQ52UB3Le7QXT1dxkFKAV490olT7J5SzTid3grOT1QCSdTK6FQgK0yD
         +rvfxnKRgv54Unee1HItI6XdlUo01QCYtRzO+UN1NSh/qrLxr9OuuwTlRW+0sEUvrTjB
         CiJA==
X-Gm-Message-State: ACgBeo2K3saCCgOCr90ns7evoPZsO+5aYtCshyI5Li/RWt0yh0fX2rD9
        9XxoXteJNrxNNrPD52oXhX//JymH1+kO70kX
X-Google-Smtp-Source: AA6agR4FqomweBU3oHymKL4q2SeQWgOrF1W5ECJJEkBmr3j9Wnjvw7DWRGj657Y1gMZVBPwXpD4GFw==
X-Received: by 2002:adf:f88c:0:b0:225:4c23:6788 with SMTP id u12-20020adff88c000000b002254c236788mr2793372wrp.140.1661090338075;
        Sun, 21 Aug 2022 06:58:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 31/32] submodule--helper: libify even more "die" paths for module_update()
Date:   Sun, 21 Aug 2022 15:57:40 +0200
Message-Id: <patch-v3-31.32-1694ccfe882-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in a preceding commit the get_default_remote_submodule() and
remote_submodule_branch() functions would invoke die(), and thus leave
update_submodule() only partially lib-ified. We've addressed the
former of those in a preceding commit, let's now address the latter.

In addition to lib-ifying the function this fixes a potential (but
obscure) segfault introduced by a logic error in
1012a5cbc3f (submodule--helper run-update-procedure: learn --remote,
2022-03-04):

We were assuming that remote_submodule_branch() would always return
on-NULL, but if the submodule_from_path() call in that function fails
we'll return NULL. See its introduction in
92bbe7ccf1f (submodule--helper: add remote-branch helper, 2016-08-03).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 41 ++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9e4069b36cb..65909255760 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2267,42 +2267,49 @@ static int run_update_procedure(struct update_data *ud)
 	return run_update_command(ud, subforce);
 }
 
-static const char *remote_submodule_branch(const char *path)
+static int remote_submodule_branch(const char *path, const char **branch)
 {
 	const struct submodule *sub;
-	const char *branch = NULL;
 	char *key;
+	*branch = NULL;
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 	if (!sub)
-		return NULL;
+		return die_message(_("could not initialize submodule at path '%s'"),
+				   path);
 
 	key = xstrfmt("submodule.%s.branch", sub->name);
-	if (repo_config_get_string_tmp(the_repository, key, &branch))
-		branch = sub->branch;
+	if (repo_config_get_string_tmp(the_repository, key, branch))
+		*branch = sub->branch;
 	free(key);
 
-	if (!branch)
-		return "HEAD";
+	if (!*branch) {
+		*branch = "HEAD";
+		return 0;
+	}
 
-	if (!strcmp(branch, ".")) {
+	if (!strcmp(*branch, ".")) {
 		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
 
 		if (!refname)
-			die(_("No such ref: %s"), "HEAD");
+			return die_message(_("No such ref: %s"), "HEAD");
 
 		/* detached HEAD */
 		if (!strcmp(refname, "HEAD"))
-			die(_("Submodule (%s) branch configured to inherit "
-			      "branch from superproject, but the superproject "
-			      "is not on any branch"), sub->name);
+			return die_message(_("Submodule (%s) branch configured to inherit "
+					     "branch from superproject, but the superproject "
+					     "is not on any branch"), sub->name);
 
 		if (!skip_prefix(refname, "refs/heads/", &refname))
-			die(_("Expecting a full ref name, got %s"), refname);
-		return refname;
+			return die_message(_("Expecting a full ref name, got %s"),
+					   refname);
+
+		*branch = refname;
+		return 0;
 	}
 
-	return branch;
+	/* Our "branch" is coming from repo_config_get_string_tmp() */
+	return 0;
 }
 
 static int ensure_core_worktree(const char *path)
@@ -2437,7 +2444,9 @@ static int update_submodule(struct update_data *update_data)
 		code = get_default_remote_submodule(update_data->sm_path, &remote_name);
 		if (code)
 			return code;
-		branch = remote_submodule_branch(update_data->sm_path);
+		code = remote_submodule_branch(update_data->sm_path, &branch);
+		if (code)
+			return code;
 		remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
 
 		if (!update_data->nofetch) {
-- 
2.37.2.1279.g64dec4e13cf

