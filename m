Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FBFECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiHaXTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiHaXSw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0AA1037E1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e13so19222147wrm.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Uq0C+dZrVb4mtBQ15qg+F6gPAcsIySojqkrl3I8Lz14=;
        b=N6e0RFTYAhBrexDHnVAeQqtY4XRV8vOF+9+jHs7s/4W+i1pAse80tSlU4CldCjMwRB
         9tMPCz7VuGw0ylSoNb/w8fqbZLqfXKqJd29qcoyYjiuFnCwTX9s+WCZsXALnTfEWllPE
         798afTG74WF9gRn1pNhDYwA63JFEn394vA+za5Bi2oBqgSU/hG3bmD9fBdPfGpMA7Jn6
         dzQKfUaUeEpVqMcqvz3oxFBDQWB+lM8tupO/PTVmgY7VjAz/B614svNRIm/6ehp9/ouf
         3x2gpSw3FuQFICW51u+s6F5LhWHb3DIMMP9+fORSh7LCty/03StzMEf306nt90H5Aos9
         TmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Uq0C+dZrVb4mtBQ15qg+F6gPAcsIySojqkrl3I8Lz14=;
        b=T9w7r6LyeJsTN4EfvBGye/0tYkdtTHB+nyeqEjwpb+qd3geVy0nWC4xhWiRjHaxmLc
         9mcG/+cEx+mQWOTTIAx/SwmrfG7QcEYVYTr2oB/ih9giVcAHgYwtRN/Oh/d8g7PhdSgQ
         zpnMqtALGChewCz/pS1RJFhW3hh+1zkEQPznflvl1p4DpQCbd1L/3llTEXtH7tHbz68v
         s/3iNWt+5yO6U5jXjiwPShUFVuEdHYkCg7UQ6PPLdUnPzujZ1yTBse1Nni+/ktPWMQcu
         L9GOhmxyztFSOEyV2Hc5yKbQMhBzne2HnSA8BEA3aXWKxQcNJyb6JVD34lBqYKErx7C2
         q70Q==
X-Gm-Message-State: ACgBeo2ivH2pi6pvUpNVlzaoyU+xUOTGfccobllnaRZbmzNdr/R7I1tH
        M/pzX1ZoDwLl6MxKjxKjwgcTzgmzKSvqJg==
X-Google-Smtp-Source: AA6agR6Q4o3+BxFROTU6coBPqyJBRW3rC/+dJwScZMAXK6cUTN71i/kr5EYlb5BC0ifrVLB/yj/Hyg==
X-Received: by 2002:a5d:47a9:0:b0:226:e849:4373 with SMTP id 9-20020a5d47a9000000b00226e8494373mr4238942wrb.57.1661987925998;
        Wed, 31 Aug 2022 16:18:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 32/33] submodule--helper: libify even more "die" paths for module_update()
Date:   Thu,  1 Sep 2022 01:18:14 +0200
Message-Id: <patch-v4-32.33-3254a8ca6eb-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
non-NULL, but if the submodule_from_path() call in that function fails
we'll return NULL. See its introduction in
92bbe7ccf1f (submodule--helper: add remote-branch helper,
2016-08-03). I.e. we'd previously have segfaulted in the xstrfmt()
call in update_submodule() seen in the context.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 41 ++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9de3a3c921a..3f822eac3a1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2268,42 +2268,49 @@ static int run_update_procedure(const struct update_data *ud)
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
@@ -2439,7 +2446,9 @@ static int update_submodule(struct update_data *update_data)
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
2.37.3.1420.g76f8a3d556c

