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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9D8C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E55461285
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbhFIN4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhFIN4x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 09:56:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D54C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 06:54:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so4340970wmd.5
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qldbng1At8975bUUmMegsEkSH3mVCBszRelsv5etKoM=;
        b=XXZrgBkHvzM/AE3RjvJZ+mNDoFAtwyoK2uDZ+TOk7JnZuWdo4WLZhAF/fJ98KPTjO5
         3QQXnsdTfpCV2aCwh11M2t8/O557GcHqfCgpGgF+P4YRri7zMU9+4MdKiyz3M931xK1e
         gCbbCpPku0rGsMa2Al1+SdNCSf436vd124oxBzDox53EuswAuWFYFO0rt35/vmqRGF/P
         Fy7aR9aLebR+BKcgVBB0CnJzVtyBouXuArvJJ2C7fyPVlfvD2dtyR8vVkqOkwQgBdyFT
         TwrYQPPK4q6xsRTwAV8fUiJMovM0nfX4S/xbzAPyGGTYV5Pxz2/n0pVjT/Yd8kQNMOe4
         5PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qldbng1At8975bUUmMegsEkSH3mVCBszRelsv5etKoM=;
        b=k94c3GGK12xU7ZTxKny+cylsVlrabiNqMlne6HxOEvLt8LYkU7UnW72gxStUnNcZ9v
         5ygWCz9UZyoq+z8nWwimFBH8aiFArWEX90vnsDd0xVYKyj52Aqij884K53HGYYWePiFB
         e3x7oKxlUlD45h6cwvMY965NM59kPgFBqPvFHlNwqsuPOGgkbzYa6qVtcerp3uaQMdGg
         TL8DXHoVvES2gyjKkwxxFvaSV9iCKu9SOVTuioKsr41TjvrLZ/Sy2VsD56xgJae0JR6V
         0xFS3gizE6PNEIMGJgGwVA82pR7wgesqa8RTODLvZRQiUlUdScU/1cuY0RTQKR+mQ7Hi
         BWwg==
X-Gm-Message-State: AOAM530YBmxQLXkQrDwt1MEvE9cH7Fu1BskMEKXwAiWRg26u2PuxpD5i
        fcPwAzb7j4y5QCuJ37oalPAw2ESAguU=
X-Google-Smtp-Source: ABdhPJx4SM7Pwekl3rbHB9wikngyOPLkxPsvXIHIyG3rQ85tm11dXDQzjY4JHcDsMXN5JKxuIiAykQ==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr16695713wmq.13.1623246881543;
        Wed, 09 Jun 2021 06:54:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18sm6357952wmh.38.2021.06.09.06.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:54:41 -0700 (PDT)
Message-Id: <f611603718ab61b56ba430ece7367453161c6406.1623246879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Jun 2021 13:54:36 +0000
Subject: [PATCH v2 2/4] *: use singular they in comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Several comments in our code refer to an anonymous user with "he/him" or
"she/her" pronouns, and the choice between the two is arbitrary.

Replace these uses with "they/them" which universally includes all
potential readers.

Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c    | 2 +-
 config.h    | 2 +-
 date.c      | 2 +-
 pathspec.h  | 2 +-
 strbuf.h    | 2 +-
 wt-status.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

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
index 9038538ffdcb..7107b41a8933 100644
--- a/config.h
+++ b/config.h
@@ -451,7 +451,7 @@ void git_configset_init(struct config_set *cs);
  * Parses the file and adds the variable-value pairs to the `config_set`,
  * dies if there is an error in parsing the file. Returns 0 on success, or
  * -1 if the file does not exist or is inaccessible. The user has to decide
- * if he wants to free the incomplete configset or continue using it when
+ * if they want to free the incomplete configset or continue using it when
  * the function returns -1.
  */
 int git_configset_add_file(struct config_set *cs, const char *filename);
diff --git a/date.c b/date.c
index f9ea807b3a9f..2da0f80b9bfa 100644
--- a/date.c
+++ b/date.c
@@ -908,7 +908,7 @@ int parse_expiry_date(const char *date, timestamp_t *timestamp)
 		/*
 		 * We take over "now" here, which usually translates
 		 * to the current timestamp.  This is because the user
-		 * really means to expire everything she has done in
+		 * really means to expire everything they have done in
 		 * the past, and by definition reflogs are the record
 		 * of the past, and there is nothing from the future
 		 * to be kept.
diff --git a/pathspec.h b/pathspec.h
index fceebb876f7a..6e84099bea22 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -108,7 +108,7 @@ struct pathspec {
  *
  * A similar process is applied when a new pathspec magic is added. The designer
  * lifts the GUARD_PATHSPEC restriction in the functions that support the new
- * magic. At the same time (s)he has to make sure this new feature will be
+ * magic. At the same time they have to make sure this new feature will be
  * caught at parse_pathspec() in commands that cannot handle the new magic in
  * some cases. grepping parse_pathspec() should help.
  */
diff --git a/strbuf.h b/strbuf.h
index 223ee2094af8..b543e354f0ed 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -338,7 +338,7 @@ const char *strbuf_join_argv(struct strbuf *buf, int argc,
  *
  * In order to facilitate caching and to make it possible to give
  * parameters to the callback, `strbuf_expand()` passes a context pointer,
- * which can be used by the programmer of the callback as she sees fit.
+ * which can be used by the programmer of the callback as they see fit.
  */
 typedef size_t (*expand_fn_t) (struct strbuf *sb,
 			       const char *placeholder,
diff --git a/wt-status.c b/wt-status.c
index 42b673571696..bd7ef3e4fd02 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -639,7 +639,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 		 * mode by passing a command line option we do not ignore any
 		 * changed submodule SHA-1s when comparing index and HEAD, no
 		 * matter what is configured. Otherwise the user won't be
-		 * shown any submodules she manually added (and which are
+		 * shown any submodules they manually added (and which are
 		 * staged to be committed), which would be really confusing.
 		 */
 		handle_ignore_submodules_arg(&rev.diffopt, "dirty");
-- 
gitgitgadget

