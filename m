Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817EAC33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D3F20702
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKYuFyJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgA2Dea (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:34:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55700 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgA2Dea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 22:34:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so4668931wmj.5
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 19:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9CUzl0rHQdbRJxpIuAydt9GCzWcDHQJjIx/7G/9ruxs=;
        b=uKYuFyJVdrpYQo8OYpusrtAUAFea/9iETCPyz14wQFuewPJk2gxnHce/YqM6BSTtaj
         PCSshDsWLXY7IKns51KRMCLWKxXZTQjuACH4lgoW5QgIPdJ3Xu7Tn39YI/MtX1hQpMfF
         5ShQAOCEuK7GrsdMGw7XIdOPLwBywmMU8jgogOl1HHkEaujmFtpwxjHNAA1vvr+pkveT
         dnmPKNCINHDUG1Gwi4bSHWfiz6CEduPCJUfkJ6gJk0IMcjnHqPIBLOPcDGBjgTXg+RQx
         c0d1vDhEAvBD2qnKOk4VfY73i0kNESfvSTgNAfD6FbcZKM00O/EZAlpVkSLdE1aB6P/B
         cAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9CUzl0rHQdbRJxpIuAydt9GCzWcDHQJjIx/7G/9ruxs=;
        b=Ty2t6z/n+8RTZ+pFvUV7uwb0aK/QgVKfzWVO3aM4AuBQIgL4TZ7zjA5AvAxeQumRCS
         jpU6bsZRdMRRG7RZx2ZY4kz6ywDCzGTLAvuOGu3zyRIM/4eobr2lvjbJP9V8WdzH2jkq
         LHHR2z9NZ/8cMQZvo+kAszRAdJLdHV7bNWUGxg7Fn1XOmqB09sn7vEAQRxfW5Cu2+k0z
         87tx/dCSHDq/xhORZf9u4/SxJQccoyx6R+5lPkeh3Fu7xT9ELIgnVKijoUP7HaZSxSZD
         JnTPbhgtxe1cXIwhgv/ztWFG9t5ux5Benu3iuHNFr9U8SLnyQVJu+D5xfy+4YaFqfqDV
         s+Vw==
X-Gm-Message-State: APjAAAUbk/pJv59kHA7fthYRZoYdNdKD9E0OG4F/72LijFfDlDGE6E6k
        JLxv6PnURafkLc2Wfrt2Oth394/W
X-Google-Smtp-Source: APXvYqxdLnw5KgZqzJ9t42ORdUtUr5QhTLek27mO1WbRFpzxjhoPGl5Ikfywd+qQs5mhTzXxdmspFQ==
X-Received: by 2002:a1c:9dce:: with SMTP id g197mr8226948wme.23.1580268867749;
        Tue, 28 Jan 2020 19:34:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm587100wmc.47.2020.01.28.19.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 19:34:27 -0800 (PST)
Message-Id: <18f92f70cf249a246dfc128dec093c8cd95e2f00.1580268865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
References: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
        <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jan 2020 03:34:20 +0000
Subject: [PATCH v6 1/6] config: fix typo in variable name
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

