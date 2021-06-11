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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDFBC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 20:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A69610F8
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 20:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFKUaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 16:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhFKUaY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 16:30:24 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A009C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 13:28:25 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id y18-20020a4ae7120000b02902496b7708cfso1007818oou.9
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCmgQTA8vUlmINLlEg31tFL57oqO1ePRo89bjMRLbJ0=;
        b=K2msLQqe/+leRAZgkmMUIdkprBqi9eRjNo8ZoMGB4a+XMv/otvSwOm1Dg6jHMOf6E+
         myBRFujV41afeX0BTadYemdoRYTjedegwxpJmF82knBWjCInRj6iQAWVWYO8s7umlXp+
         pRyOjCJOclUZw3l1WPmUj7wjqC48GdFDFDgmtL1Q9cLL1CisRyZNlLU9QuXi9oy18iCw
         Z7oAn696GLWWsFT7+KgXFCMxj9nFDDmGgcfoCUbkl3grBV7Ugyvmon5oV8XuigY0cn9c
         LPCSsk54Q8eWCPwX8Aik1hLmj3KOoMS2nF/NjNGUqZwCINgvGCrfWMLDHCKzcbOYlLjK
         LGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCmgQTA8vUlmINLlEg31tFL57oqO1ePRo89bjMRLbJ0=;
        b=EqzeDuWy3q8yuuLTlf23eUUyil3yeJwncqoz9bChqQGPpywUJCv5O71GXxU4+6/27Y
         q0Vo7RDlXeVz1jZqSEhx9+QxxmZC7Dk73LYvxc8oXarFnWh+zFOw4MhthUneLNdZ+NHd
         84EKiqnEg0fxmOIGdQGcrtkfqCjSDPMSGeCyZK4BVd3uqvTgLARtE20sCkH5RNh0fxhT
         n3OkLDcB9mlA/+oohJGbbkYlev4hVybNn+m3R4NQDnnFFwVm6pNaZmNImyywFFrbalTE
         ojFB3+YTSbXMnQznk6i4J9r1KOSrWCa54mGxcsBOfQE+jvxRLh5g42CapAVjDNUfKHiD
         o66Q==
X-Gm-Message-State: AOAM532duRgPVM9ZKhbs7pkoHkGtj3GtmC2daT+W6ye1eAPAnEuLqN2p
        jo0kwO4aEiW8SG4b094N8O+DwtQqB0u4CA==
X-Google-Smtp-Source: ABdhPJzWGwDp3SN5bKf3IXUjyvf6TRYWwnWD2uKoX7BM2Vas57MfSP82GgJZQVhs/eYrxFVC0bMYoQ==
X-Received: by 2002:a4a:5182:: with SMTP id s124mr4417744ooa.34.1623443304723;
        Fri, 11 Jun 2021 13:28:24 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 94sm1476750otj.33.2021.06.11.13.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:28:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] comments: avoid using the gender of our users
Date:   Fri, 11 Jun 2021 15:28:19 -0500
Message-Id: <20210611202819.47077-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611202819.47077-1-felipe.contreras@gmail.com>
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We generally avoid specifying the gender of our users in order to be
more politically correct, but sometimes due to lack of time and/or
creativity a few slip by.

Since by doing a little bit of rewording we can avoid this irrelevant
detail, let's do so.

Inspired-by: Derrick Stolee <dstolee@microsoft.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 commit.c    | 2 +-
 config.h    | 4 ++--
 date.c      | 2 +-
 pathspec.h  | 2 +-
 strbuf.h    | 4 ++--
 wt-status.c | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 8ea55a447f..143f472c0f 100644
--- a/commit.c
+++ b/commit.c
@@ -1178,7 +1178,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	/*
 	 * We could verify this signature and either omit the tag when
 	 * it does not validate, but the integrator may not have the
-	 * public key of the signer of the tag he is merging, while a
+	 * public key of the signer of the tag being merged, while a
 	 * later auditor may have it while auditing, so let's not run
 	 * verify-signed-buffer here for now...
 	 *
diff --git a/config.h b/config.h
index 9038538ffd..a2200f3111 100644
--- a/config.h
+++ b/config.h
@@ -450,8 +450,8 @@ void git_configset_init(struct config_set *cs);
 /**
  * Parses the file and adds the variable-value pairs to the `config_set`,
  * dies if there is an error in parsing the file. Returns 0 on success, or
- * -1 if the file does not exist or is inaccessible. The user has to decide
- * if he wants to free the incomplete configset or continue using it when
+ * -1 if the file does not exist or is inaccessible. The caller decides
+ * whether to free the incomplete configset or continue using it when
  * the function returns -1.
  */
 int git_configset_add_file(struct config_set *cs, const char *filename);
diff --git a/date.c b/date.c
index f9ea807b3a..5c35f2bdfe 100644
--- a/date.c
+++ b/date.c
@@ -908,7 +908,7 @@ int parse_expiry_date(const char *date, timestamp_t *timestamp)
 		/*
 		 * We take over "now" here, which usually translates
 		 * to the current timestamp.  This is because the user
-		 * really means to expire everything she has done in
+		 * really means to expire everything that has been done in
 		 * the past, and by definition reflogs are the record
 		 * of the past, and there is nothing from the future
 		 * to be kept.
diff --git a/pathspec.h b/pathspec.h
index fceebb876f..2341dc9901 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -108,7 +108,7 @@ struct pathspec {
  *
  * A similar process is applied when a new pathspec magic is added. The designer
  * lifts the GUARD_PATHSPEC restriction in the functions that support the new
- * magic. At the same time (s)he has to make sure this new feature will be
+ * magic while at the same time making sure this new feature will be
  * caught at parse_pathspec() in commands that cannot handle the new magic in
  * some cases. grepping parse_pathspec() should help.
  */
diff --git a/strbuf.h b/strbuf.h
index 223ee2094a..a86dcaaf44 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -337,8 +337,8 @@ const char *strbuf_join_argv(struct strbuf *buf, int argc,
  * placeholder is unknown, then the percent sign is copied, too.
  *
  * In order to facilitate caching and to make it possible to give
- * parameters to the callback, `strbuf_expand()` passes a context pointer,
- * which can be used by the programmer of the callback as she sees fit.
+ * parameters to the callback, `strbuf_expand()` passes a context
+ * pointer with any kind of data.
  */
 typedef size_t (*expand_fn_t) (struct strbuf *sb,
 			       const char *placeholder,
diff --git a/wt-status.c b/wt-status.c
index 42b6735716..ebc0c0da1a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -639,7 +639,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 		 * mode by passing a command line option we do not ignore any
 		 * changed submodule SHA-1s when comparing index and HEAD, no
 		 * matter what is configured. Otherwise the user won't be
-		 * shown any submodules she manually added (and which are
+		 * shown any submodules manually added (and which are
 		 * staged to be committed), which would be really confusing.
 		 */
 		handle_ignore_submodules_arg(&rev.diffopt, "dirty");
-- 
2.32.0

