Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91158C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BF021D7E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZjLEJeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfLTRKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:10:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38796 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfLTRKE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:10:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id i16so8932456edr.5
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2JEXhwGUVRLLJpUud1IhPUL7oLLf8yvjPJeIKO5vHjg=;
        b=dZjLEJeYrDY0me3SoUMjzSiZtZNxrXcHX1g0n3FSGStJpF3k3dNHVc+PEr9JM2vhVr
         pdryhe/VzpkXGDbEwVxP6Ks2q2aVxzqfcfhRbfRrinCtsXe+76kU4ol9fSixecMJZoBQ
         tbd9muAj3wiqoNxchQw5dd1Zfig+3fIQLpRO3YvQ5aM0OKotSHPwnO8NvYLv7XMbV9JV
         xnJkl7gzk35DTxzJswjssNucCiBouMz2nihvc3fGLnx3jeocencqedsIpc1zrTMyqBoL
         5/If0LYjA5xU2yLnJEHyU8/Uj0NTn1FIHcQ+uFaxLU/5/6W7pv049GWcTUHmlM0wGTb1
         TScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2JEXhwGUVRLLJpUud1IhPUL7oLLf8yvjPJeIKO5vHjg=;
        b=r0tce+E3789Gf+9YM+KHja3h8qmsQuwcVTfduIrIq8mz9IHFwq04zP22hqUHdVuUMO
         JyQBnW3mcSSXe4AmR8bnjuLyDBr2XOD6ZWh9LFeTUQ78IPaLmSQIgB+vl2y7W3XgNucU
         6HcWEP+reV3iuUKu5xiMMoPrUDf132Ez8RYwxEMqRcYT8H/4Z9mXiHOKkJBD9w1dS9x6
         59olrSPDn1wfdXm7Lp/c714xuS9AbahaMAD2LBLovzVHKTA1qlu95dCXCKuVukSsyyYR
         RtMXsypP13wYtbj61hasNtt9ySepkzI36R1nG4bmVnaA/B+xdAL7aZ5XRVnaPI+HhCbB
         mB/g==
X-Gm-Message-State: APjAAAVQ5AFrTjULdVlVr9HGeMfGI9pD3oLcjP+q3e/0U+ildnpf2Q1A
        9TxeaJnmkFze6RzfjrN22V46JY/B
X-Google-Smtp-Source: APXvYqxec/5IuZrOHGVsW+xLywIj7DknZ0vFns2sGM2ag7rsnYKVhHNoDY/yw13YBwC1IBBAzS+GmQ==
X-Received: by 2002:a17:906:c28b:: with SMTP id r11mr17217379ejz.291.1576861801171;
        Fri, 20 Dec 2019 09:10:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm1140238ejb.43.2019.12.20.09.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:10:00 -0800 (PST)
Message-Id: <04db4472d36041f42766c00f84414ac9fb81d885.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:47 +0000
Subject: [PATCH 14/15] rebase: make the backend configurable via config
 setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/rebase.txt |  8 ++++++++
 builtin/rebase.c                | 31 ++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index d98e32d812..e6ae30c999 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -5,6 +5,14 @@ rebase.useBuiltin::
 	is always used. Setting this will emit a warning, to alert any
 	remaining users that setting this now does nothing.
 
+rebase.backend::
+	Default backend to use for rebasing.  Possible choices are
+	'am' or 'merge' (note that the merge backend is sometimes also
+	refered to as the interactive backend or the interactive
+	machinery elsewhere in the docs).  Also, in the future, if the
+	merge backend gains all remaining capabilities of the am
+	backend, this setting may become unused.
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ab9e16b206..eaa5eac59e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -60,6 +60,7 @@ enum empty_type {
 struct rebase_options {
 	enum rebase_type type;
 	enum empty_type empty;
+	const char *default_backend;
 	const char *state_dir;
 	struct commit *upstream;
 	const char *upstream_name;
@@ -103,6 +104,7 @@ struct rebase_options {
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
+		.default_backend = "am",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
@@ -1298,6 +1300,10 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.backend")) {
+		return git_config_string(&opts->default_backend, var, value);
+	}
+
 	return git_default_config(var, value, data);
 }
 
@@ -1932,9 +1938,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (strcmp(options.git_am_opts.argv[i], "-q"))
 				break;
 
-		if (is_interactive(&options) && i >= 0)
-			die(_("cannot combine am options with either "
-			      "interactive or merge options"));
+		if (i >= 0) {
+			if (is_interactive(&options))
+				die(_("cannot combine am options with either "
+				      "interactive or merge options"));
+			else
+				options.type = REBASE_AM;
+		}
+	}
+
+	if (options.type == REBASE_UNSPECIFIED) {
+		if (!strcmp(options.default_backend, "merge"))
+			options.type = REBASE_MERGE;
+		else if (!strcmp(options.default_backend, "am"))
+			options.type = REBASE_AM;
+		else
+			die(_("Unknown rebase backend: %s"),
+			    options.default_backend);
 	}
 
 	switch (options.type) {
@@ -1947,10 +1967,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.state_dir = apply_dir();
 		break;
 	default:
-		/* the default rebase backend is `--am` */
-		options.type = REBASE_AM;
-		options.state_dir = apply_dir();
-		break;
+		BUG("options.type was just set above; should be unreachable.");
 	}
 
 	if (options.empty == EMPTY_UNSPECIFIED) {
-- 
gitgitgadget

