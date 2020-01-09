Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEE3C32771
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE82206ED
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+YTdLZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgAIKQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:16:46 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36774 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbgAIKQq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 05:16:46 -0500
Received: by mail-wm1-f53.google.com with SMTP id p17so2173932wma.1
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 02:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=saMlTNkKEqcBRL5aUOy1TDYQZGXm7gjU9li+Opxvdcs=;
        b=U+YTdLZll/44S6WAZI5h2HsJQRXXwUkIkeb6hBBLF3VygAM1gm6tUXxSiTZk5gQ4kU
         8pc5VGoa4U0shEzh0/zb8bDzh9uhDkI8gYKvnnvnzaRHlRwEqqjy/f+o0n6jHrLAr56H
         PmOgVGwbx2HQJU6id9iCmj+7t5wNDiDnmj9qoZv50YtNteoadK747meyFaS5TMzQQ+AZ
         355Ib7EUnxacbAgOMIIDZlHumMYh1nGKfLU++mqwRt+UzLz2xE9UtrtGgwbkN6v5Kk+B
         ATKLsgDnhZWxnNXwTqmih+SjI0arwCCw7AF5CFgWrcHdYCPNVhKbOB+VwUcsqNV0M52X
         h7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=saMlTNkKEqcBRL5aUOy1TDYQZGXm7gjU9li+Opxvdcs=;
        b=GDxAe3Uj0Aqv7wY9pHbcr609IqYNs+dxsCZz2PjSNRL8uEmEbwtN4BuCXTjHjTMOEy
         K7SaZdxMuMQMHYJwp9w05F+obGF9QqbddbRRbilfU+02rinBpN7eTrfhgZRVQUCWWd8l
         pmIP5CgEsmQbRHhLiPv4QUqYgpTPElwm0JXCtAu8+TBo5RLFewoj8A5kQLM5/3pVXdLq
         1bqGh0ajBKLOm7ltBvsHA86WhLyVE3gOI9ZrbxJIYDhvVX2GBAWx8/DYMz3ArVRggVYn
         vd+jdCZTwFk9M+3jA6dpfTZgHXrFj1/Er0psBbzZ2pNM8QycPQ5Poe6N0n9WklYSCODi
         A1zg==
X-Gm-Message-State: APjAAAUb9LSSMD32MhgTlo+4W5kr5Mas+rMjRKXqxFyYDpPA4cvxQNIi
        Js2Q1leqAL/SgMlSd+LxERBfOyae
X-Google-Smtp-Source: APXvYqzSIXpj5tk7U7yPUJQFh9Dd3UVQKc2zUhJv0WQ2rwNOweUdS0ehkNDZNuWivQh+Bm1+UKAnXg==
X-Received: by 2002:a05:600c:24ca:: with SMTP id 10mr3767935wmu.4.1578565004376;
        Thu, 09 Jan 2020 02:16:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y20sm2281239wmi.25.2020.01.09.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:16:43 -0800 (PST)
Message-Id: <b40480f03a5643761bd06d4b9c495a99b98a1ac8.1578565001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
        <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jan 2020 10:16:38 +0000
Subject: [PATCH v2 1/4] config: fix typo in variable name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

In git config use of the end_null variable to determine if we should be
null terminating our output.  While it is correct to say a string is
"null terminated" the character is actually the "nul" character, so this
malapropism is being fixed.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 builtin/config.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 98d65bc0ad..52a904cfb1 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -29,7 +29,7 @@ static int use_worktree_config;
 static struct git_config_source given_config_source;
 static int actions, type;
 static char *default_value;
-static int end_null;
+static int end_nul;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
@@ -151,7 +151,7 @@ static struct option builtin_config_options[] = {
 	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
-	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
+	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
@@ -178,11 +178,11 @@ static void check_argc(int argc, int min, int max)
 
 static void show_config_origin(struct strbuf *buf)
 {
-	const char term = end_null ? '\0' : '\t';
+	const char term = end_nul ? '\0' : '\t';
 
 	strbuf_addstr(buf, current_config_origin_type());
 	strbuf_addch(buf, ':');
-	if (end_null)
+	if (end_nul)
 		strbuf_addstr(buf, current_config_name());
 	else
 		quote_c_style(current_config_name(), buf, NULL, 0);
@@ -678,7 +678,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_options.git_dir = get_git_dir();
 	}
 
-	if (end_null) {
+	if (end_nul) {
 		term = '\0';
 		delim = '\n';
 		key_delim = '\n';
-- 
gitgitgadget

