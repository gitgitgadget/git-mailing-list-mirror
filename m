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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD04C47095
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C492461003
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhFGQ7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFGQ7o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:59:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07059C061787
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 09:57:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id y7so13796695wrh.7
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nm/2AwtFy1DKF7JqvzcW9DsPFQd3dcAuO4FMF5hidwQ=;
        b=fL44ykkjcfp0r1AIExnUDAJd72VFWHNGw2ho3d+POLcHyYq3ST10Zk4+y5CMtCGIsQ
         E5BLG2vgAV5eJDxvHKQITHgnD8cjFGfNlFlpH8Yefej37nCDVwk2CO4bzpjFQPe+MvMm
         38SOa/rPYjOBkjmKIlx38G5PGHw095rH1clkznTm0/V50pWn4FM6HubH6Jzw6nD3HWxZ
         7nLrbosKfY57YM70WpwpAbvm0tGR8rjrB1Wkuo5UYr8v2OkmIY1PsC30OflT/ZuGe12Z
         k9x3IPVbBbO8V+ejb4CCUjT9/UYDdaL6RQy3SdCCiaRm4irALWidu0Bdii5KPc6RTBMf
         KWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nm/2AwtFy1DKF7JqvzcW9DsPFQd3dcAuO4FMF5hidwQ=;
        b=tkmpjUTYE5txXsQlQM0XlPGxxgMTinKjMO1Y/W3vgTM7d6J2wZKwIdQwB7ymxweIEq
         rRLXnt3dnIPOtf5bxlfkx+oYu8O6sc2fGzLBZbcSfNuOd8lNB9po3b96S93Qwz+4O/0N
         1VPf01oWDQAGrUiiJBorxDeMfHBnvKt6qZE57kV+IAE735jQj5XxhZoKkCA5LXOAGFoF
         4oB7LRlxOzJ8SATrEkPci1rUfreicP0EvrcKMo/Z2jqLIrG9CMzeJxjZT9lCeGIi/Jhi
         Hd4Ee4STkoLn7GSMU1MIM4CadlJXITtN8+QHnZ31Wi/R1JKAeeNQV6QKEMs3mmhVAMH6
         1SnA==
X-Gm-Message-State: AOAM532GU5prtYjH7Bkp0H9DZRtrxWothLOVVG4IKeGnSaCmoH6aluTA
        JG5S+fNCMGOfiGLVIXhepT7V59eGTOg=
X-Google-Smtp-Source: ABdhPJwpZIAIOch4HbEopOR2AJTrOOPYLV6j5Pw3vs6xUvhYV4RL6Fs3kJ2bzZs2FdvoI+EjgowbdA==
X-Received: by 2002:a5d:5271:: with SMTP id l17mr17918423wrc.142.1623085071694;
        Mon, 07 Jun 2021 09:57:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5sm16963654wrm.15.2021.06.07.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:57:51 -0700 (PDT)
Message-Id: <b36e3f99716bf3976fc886df684c300e17566c79.1623085069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.git.1623085069.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 16:57:46 +0000
Subject: [PATCH 2/4] *: use singular they in comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c                                 | 2 +-
 config.h                                 | 2 +-
 contrib/hooks/multimail/git_multimail.py | 4 ++--
 date.c                                   | 2 +-
 pathspec.h                               | 2 +-
 strbuf.h                                 | 2 +-
 wt-status.c                              | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 8ea55a447fa9..35e93abce6ae 100644
--- a/commit.c
+++ b/commit.c
@@ -1178,7 +1178,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	/*
 	 * We could verify this signature and either omit the tag when
 	 * it does not validate, but the integrator may not have the
-	 * public key of the signer of the tag he is merging, while a
+	 * public key of the signer of the tag they are merging, while a
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
diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/multimail/git_multimail.py
index f563be82fc7e..5932a3354f26 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -3219,7 +3219,7 @@ class GitoliteEnvironmentLowPrecMixin(
     def get_repo_shortname(self):
         # The gitolite environment variable $GL_REPO is a pretty good
         # repo_shortname (though it's probably not as good as a value
-        # the user might have explicitly put in his config).
+        # the user might have explicitly put in their config).
         return (
             self.osenv.get('GL_REPO', None) or
             super(GitoliteEnvironmentLowPrecMixin, self).get_repo_shortname()
@@ -3361,7 +3361,7 @@ def get_pusher(self):
                 # __submitter into an RFC 2822 string already.
                 return re.match(r'(.*?)\s*<', self.__submitter).group(1)
             else:
-                # Submitter has no configured email, it's just his name.
+                # Submitter has no configured email, it's just their name.
                 return self.__submitter
         else:
             # If we arrive here, this means someone pushed "Submit" from
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

