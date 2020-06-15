Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F0C433E1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CD2206B7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2Wi+QdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgFOMua (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729884AbgFOMuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03B2C08C5C3
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id y17so16964736wrn.11
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W/m6HY9KQHDha+1BHPlpIM4OyWS0ZCoBQlE87VpXdr4=;
        b=Y2Wi+QdNXPhcp7AvXl/FBeRrh9nO2V9RwULLzRuVhxP/JE+QhrWBtwCQ3ZB+ZqxRYe
         CvO1/KX5etaLu9oRe2cJcY/TdyW4aY+a+5Gas2Tr4tAN3raR/QAmZH1xFtCQ3+jXDId5
         JfAzEjcBeAOOHYq+cE4yxCD/JpqXvd5Q4be30tzgtXn7tp2ZykLzRLfwg9CDUh17kg+k
         dFuFuRGvvOzAzUQSmXCVwGsam2aJddD38CqnfG4Qgp9EFLI5pIjkI5bTYGpWg0kCkpeG
         kTJXt+O12gkWfwYdaYHdVAIvbBIpwgCPMa52d+NT0Cso//zbYyi/J+jwd9qAPmkX4hpc
         2ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W/m6HY9KQHDha+1BHPlpIM4OyWS0ZCoBQlE87VpXdr4=;
        b=muDnmZ1WehEj7YYhmkZ/XhCtEtH8u1kWLdaxskqqTR2ECpabTSsNpGEGAvSTbUsyun
         A35WHKzULo0EvA47AFBm7U0aviEbXQYbvhUC/ifMXHSsA/Vwo7ndksBHr67qKyHvxZVq
         sAH9FDg2XDPSIUzMkrTy5ArxDbMhosk57cVM4TcW9ylVQPO0U0kPBfakO2sxOv5zfBlm
         YNWGWnDb8K5wOIPKlfsWP3gRgQi5bL9BkguArwA2rBvmjIR2dfYeqQ6frbVi9tfmwsDv
         MnZn0UGu+qGKzPLdSu+pj4rqcSMCpmF42QZsNA51YH9ps78znk8l8qs34wyfifmBzjAH
         Owag==
X-Gm-Message-State: AOAM530a9CT31WLWp5dvms5pbpgxEInTDRxyHAMUXhp2E8IjNIt+BTMW
        oyfhSm3ffVS9p4Fgj/KPRcqOEMoG
X-Google-Smtp-Source: ABdhPJxnrP6ds+9Cp9eiFAkSCUwNxl34OlgpcGRidJ0rwADJVqoXa8uhIZCaDu1yMfpSD00bSfMK6g==
X-Received: by 2002:a5d:5389:: with SMTP id d9mr30733356wrv.77.1592225422241;
        Mon, 15 Jun 2020 05:50:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c81sm23214363wmd.42.2020.06.15.05.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:21 -0700 (PDT)
Message-Id: <ca1c63c3e012edde26b4f0c67175ca53f4d29e08.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:08 +0000
Subject: [PATCH v2 04/12] git_main_branch_name(): optionally report the full
 ref name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to introduce the first caller of that function (`git
fast-export`) that wants a full ref name instead of the short branch
name.

To make this change easier to review, let's refactor the function
accordingly without mixing in the actual first call using the new flag.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fmt-merge-msg.c    |  2 +-
 refs.c             | 12 ++++++++----
 refs.h             |  8 ++++++--
 send-pack.c        |  2 +-
 transport-helper.c |  2 +-
 5 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 43f4f829242..03dba905643 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -451,7 +451,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
 			strbuf_addf(out, " of %s", srcs.items[i].string);
 	}
 
-	main_branch = git_main_branch_name();
+	main_branch = git_main_branch_name(0);
 	if (!strcmp(main_branch, current_branch))
 		strbuf_addch(out, '\n');
 	else
diff --git a/refs.c b/refs.c
index f1854cffa2f..7da3ac178c4 100644
--- a/refs.c
+++ b/refs.c
@@ -560,8 +560,9 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
 		argv_array_pushf(prefixes, *p, len, prefix);
 }
 
-char *repo_main_branch_name(struct repository *r)
+char *repo_main_branch_name(struct repository *r, int flags)
 {
+	int full_name = flags & MAIN_BRANCH_FULL_NAME;
 	const char *config_key = "core.mainbranch";
 	const char *config_display_key = "core.mainBranch";
 	const char *fall_back = "master";
@@ -570,7 +571,10 @@ char *repo_main_branch_name(struct repository *r)
 	if (repo_config_get_string(r, config_key, &name) < 0)
 		die(_("could not retrieve `%s`"), config_display_key);
 
-	ret = name ? name : xstrdup(fall_back);
+	if (full_name)
+		ret = xstrfmt("refs/heads/%s", name ? name : fall_back);
+	else
+		ret = name ? name : xstrdup(fall_back);
 
 	if (check_refname_format(ret, REFNAME_ALLOW_ONELEVEL))
 		die(_("invalid branch name: %s = %s"),
@@ -582,9 +586,9 @@ char *repo_main_branch_name(struct repository *r)
 	return ret;
 }
 
-char *git_main_branch_name(void)
+char *git_main_branch_name(int flags)
 {
-	return repo_main_branch_name(the_repository);
+	return repo_main_branch_name(the_repository, flags);
 }
 
 /*
diff --git a/refs.h b/refs.h
index a207ef01348..96472f9a9f5 100644
--- a/refs.h
+++ b/refs.h
@@ -157,9 +157,13 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 /*
  * Retrieves the name of the main (or: primary) branch of the given
  * repository.
+ *
+ * The result is an allocated string. Unless the flags ask for a short name, it
+ * will be prefixed with "refs/heads/".
  */
-char *git_main_branch_name(void);
-char *repo_main_branch_name(struct repository *r);
+#define MAIN_BRANCH_FULL_NAME (1<<0)
+char *git_main_branch_name(int flags);
+char *repo_main_branch_name(struct repository *r, int flags);
 
 /*
  * A ref_transaction represents a collection of reference updates that
diff --git a/send-pack.c b/send-pack.c
index 2532864c812..898720511d0 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -405,7 +405,7 @@ int send_pack(struct send_pack_args *args,
 	}
 
 	if (!remote_refs) {
-		char *branch_name = git_main_branch_name();
+		char *branch_name = git_main_branch_name(0);
 
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
 			"Perhaps you should specify a branch such as '%s'.\n",
diff --git a/transport-helper.c b/transport-helper.c
index 8c8f40e322d..7a54e5b2fb2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1044,7 +1044,7 @@ static int push_refs(struct transport *transport,
 	}
 
 	if (!remote_refs) {
-		char *branch_name = git_main_branch_name();
+		char *branch_name = git_main_branch_name(0);
 
 		fprintf(stderr,
 			_("No refs in common and none specified; doing nothing.\n"
-- 
gitgitgadget

