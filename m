Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A741BC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DEB3613DA
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhFOONj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhFOONX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 10:13:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95288C0613A4
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:11:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q5so18545751wrm.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Dw1HJSLJAyxT+7lYCLicwFIMmj5JMWgxMnTQoyremeE=;
        b=QgHpDGtHOdzp7Sclwy4Z8FV+mRll1HLL+kyVobeVdvTQDUM1ia0b3jfXEu8Z3WzFqS
         GBsqbZEvKGGlEHEZSUYCITRTOh+NWSge8pk5l3sTjhTTGvv10csc2UhD+zjSaQ+hOy8c
         hzWeUgW2CDrjMkac2XNh0uF2z6ocGF5ifVYJKcTFEO8mfIexJ2kgwaHw8x4lRskcLrPn
         w4/RhCDuIgq+XfncYInCpBJlJDe4QOSMjUvkwFvkwF12WfhcDz4VK+MmPIRwIP7Ddlj1
         P/DOI/Hc7ocbS0aaU5EJACwhdBprAEhrGRY//9I0Gb0JnmWsRMJXhlRFoUWX6vowrURQ
         U3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Dw1HJSLJAyxT+7lYCLicwFIMmj5JMWgxMnTQoyremeE=;
        b=NXyyEnZLk9qpIuNR5QMegwwJeM6gL2U534/1vyK6DuSd+axjIwgHWC00VsL7ZrvTzc
         y+yUT+Vcs33dv1FJjsFf7016nLolrH6Ef0JqDZ+X+eHb5g8tO8PuY4u/z2coS4mT8HOe
         cE2VbPZfjz7Vs5KMJujpqixN0uroSHzFnNR4QYb+ccdhS9hcETVIGbNKaG539RReDgc6
         yP0o+u62TZoyfkJkXva0blYql5qYGIN4oALaICyCWwlutIcwuZFASdlmwjeQs4QzCpas
         0BpwaHuK+4RzrD2g9KAra4CdOByqZXqA0gYvw2+hF2krr/hLkYE1A8LqZVsxLV2fvdBe
         aPbg==
X-Gm-Message-State: AOAM530ZPeqpwbRoXBbmSw//RKnEJvEGWwDgH3u9Rut63zTjuuH/2o3g
        pHr9ZeQLNf9U3X5VjvSqrrH4CBiVkMM=
X-Google-Smtp-Source: ABdhPJzy7ItDXLK7sjVyOVuMzR2aONH2DeNyAqrW7zKR8sowyuko5paTu/k4Tj5caWsDT93C6fxNWw==
X-Received: by 2002:adf:e38e:: with SMTP id e14mr3400433wrm.384.1623766276162;
        Tue, 15 Jun 2021 07:11:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 89sm19704565wrq.14.2021.06.15.07.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:11:15 -0700 (PDT)
Message-Id: <57d8486ab7c842842ca95fb51437ff7a1d693481.1623766273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
From:   "Felipe Contreras via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 14:11:10 +0000
Subject: [PATCH v3 2/4] comments: avoid using the gender of our users
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

We generally avoid specifying the gender of our users in order to be
more inclusive, but sometimes a few slip by due to habit.

Since by doing a little bit of rewording we can avoid this irrelevant
detail, let's do so.

Inspired-by: Derrick Stolee <dstolee@microsoft.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c    | 2 +-
 config.h    | 4 ++--
 date.c      | 2 +-
 pathspec.h  | 2 +-
 strbuf.h    | 4 ++--
 wt-status.c | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 8ea55a447fa9..143f472c0f24 100644
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
index 9038538ffdcb..a2200f311156 100644
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
index f9ea807b3a9f..c55ea47e96ad 100644
--- a/date.c
+++ b/date.c
@@ -908,7 +908,7 @@ int parse_expiry_date(const char *date, timestamp_t *timestamp)
 		/*
 		 * We take over "now" here, which usually translates
 		 * to the current timestamp.  This is because the user
-		 * really means to expire everything she has done in
+		 * really means to expire everything that was done in
 		 * the past, and by definition reflogs are the record
 		 * of the past, and there is nothing from the future
 		 * to be kept.
diff --git a/pathspec.h b/pathspec.h
index fceebb876f7a..2341dc990102 100644
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
index 223ee2094af8..a86dcaaf44d1 100644
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
index 42b673571696..ebc0c0da1a84 100644
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
gitgitgadget

