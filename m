Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB0901F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750769AbdGYVj6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:39:58 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33472 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdGYVjz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:55 -0400
Received: by mail-pf0-f180.google.com with SMTP id s70so63048894pfs.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cIKeVLGYyxfGnz/BHkQltwg+QZX+31MnKCXrd/Mc06I=;
        b=SPiX1rTy0S/sg2+5dAZNUd5rh0Op2ipqY/Bc0Azjf0AFWmb3TZwE9fM1drZ5NjPXM8
         UbCyXWUtidR4F6xOpA0U/gixtL+om6JlepZo7kOf5Xrcq+tnFATrsnnRFKjE+cWPnQcy
         SnI+FSwpnfDZxS5h0bz/LmhWs732B9IhvGJfSbedtv8iK2rvCa6KptgvW4OWc3EMFVkn
         jophTknolR+U2TBqEAO/bCELIHnloQmN3mBSg+/aUhcvYLztP2krhl5LyABmupZmD58v
         LVDJpOCunQcwamPR50ux/ibsJy5dQ7SWzitWc1itrAMOcj1S4evhU62X3JhBtC+aM5gz
         zvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cIKeVLGYyxfGnz/BHkQltwg+QZX+31MnKCXrd/Mc06I=;
        b=G5axJ/gmb53Ve9itHU655cXoBnmJ0YR8hA8W/vVtLjDCo0wtrFH3Zz+mbtSWnQaL6w
         Azw9kLO2p3xhgQIFjQQhygeN40pE7FVa14SnOo9Rf7QmVBbyXY+yDqGAottvax+eaT6W
         ONBRw88kgXbTlVg1GZbQsyJ2cfg03N5NZBCkCytj5/Gv+F/etJaAJwL7Jda5Y2wdV74S
         EuA6SNXcssoX3n874KHQrF59AipR40a4MQ0+YTRBmLgFgA5fHUqXDXYungDoY5geERSe
         xQDIySmldYyJIMxKeVWAQxv2DMBwuUOHR4FW89mYLHATmrh41W6cvELDfsdcSdoJrjvH
         Kp5A==
X-Gm-Message-State: AIVw111w40WH126zSXz8dnoyMwe/3SkHOmK5FgLpgt/qtVtpa+8fWvYc
        HfGcs5S6H+CJZkinMSpnPw==
X-Received: by 10.98.87.195 with SMTP id i64mr20300189pfj.175.1501018794001;
        Tue, 25 Jul 2017 14:39:54 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:52 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 09/15] submodule: remove submodule_config callback routine
Date:   Tue, 25 Jul 2017 14:39:22 -0700
Message-Id: <20170725213928.125998-10-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the last remaining caller of 'submodule_config()' as well as the
function itself.

With 'submodule_config()' being removed the submodule-config API can be
a little simpler as callers don't need to worry about whether or not
they need to overlay the repository's config on top of the
submodule-config.  This also makes it more difficult to accidentally
add non-submodule specific configuration to the .gitmodules file.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c |  1 -
 submodule.c                 | 25 ++-----------------------
 submodule.h                 |  1 -
 3 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 25f471ba1..c16249e30 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1196,7 +1196,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 			     git_submodule_helper_usage, 0);
 
 	gitmodules_config();
-	git_config(submodule_config, NULL);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
diff --git a/submodule.c b/submodule.c
index 13380fed1..f63940347 100644
--- a/submodule.c
+++ b/submodule.c
@@ -180,27 +180,6 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 	}
 }
 
-/* For loading from the .gitmodules file. */
-static int git_modules_config(const char *var, const char *value, void *cb)
-{
-	if (starts_with(var, "submodule."))
-		return parse_submodule_config_option(var, value);
-	return 0;
-}
-
-/* Loads all submodule settings from the config. */
-int submodule_config(const char *var, const char *value, void *cb)
-{
-	if (!strcmp(var, "submodule.recurse")) {
-		int v = git_config_bool(var, value) ?
-			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
-		config_update_recurse_submodules = v;
-		return 0;
-	} else {
-		return git_modules_config(var, value, cb);
-	}
-}
-
 /* Cheap function that only determines if we're interested in submodules at all */
 int git_default_submodule_config(const char *var, const char *value, void *cb)
 {
@@ -271,8 +250,8 @@ void gitmodules_config_oid(const struct object_id *commit_oid)
 	struct object_id oid;
 
 	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
-		git_config_from_blob_oid(submodule_config, rev.buf,
-					 &oid, NULL);
+		git_config_from_blob_oid(gitmodules_cb, rev.buf,
+					 &oid, the_repository);
 	}
 	strbuf_release(&rev);
 }
diff --git a/submodule.h b/submodule.h
index f17ca1e34..1c6b2ab4e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,7 +41,6 @@ extern int remove_path_from_gitmodules(const char *path);
 extern void stage_updated_gitmodules(void);
 extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
 		const char *path);
-extern int submodule_config(const char *var, const char *value, void *cb);
 extern int git_default_submodule_config(const char *var, const char *value, void *cb);
 
 struct option;
-- 
2.14.0.rc0.400.g1c36432dff-goog

