Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398D6C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A01122AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgLVADs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVADr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:03:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9FFC0611C5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d187so15869762ybc.6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tYBIp72At1pPq2NwvWzTuSgSJkDuk44JQzLmJTw7OgE=;
        b=JeUmfwTV0dWITO3SyzdQRYlmsRb5VIPo0ZyVbeEo6Mt15og8mjGOXdW7JnUFeApqKE
         NADhDOb9hu7524WGJVJ8fUhgUxJbxt95eQP01iCYtZPyheSd9J32b/5qxWtavwBAq3km
         CDPbdrVmY7thLIeUb4gy5kbwSjsAJRTAhpqMGSauCPa+p0aRwN8nUKRo+R5gL/cK2wTa
         kvqOcYhpgKWsDTqGU/g72pt5z13a0bj0AMLMoqSjWvSko+NvJW++pCk5OQlV/1DEEX1v
         eR5/GvU6JX5VxUw5hGLxrKHHd1HMttkTqbBdSkJ59HCBW3IYchmTDZPVntm1Tvq5wiml
         zTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tYBIp72At1pPq2NwvWzTuSgSJkDuk44JQzLmJTw7OgE=;
        b=dgYuL5Hvno2deB3XAH5/tn2V3xumYJ+sKiu6etP2ieZhl8Hx4Ee36y22CUwV6Ys3fj
         VfinNR/VXIg6c9XSmlyPEbMLIYTU6uDI3ws35O/Uni9Xq3Od21DU7dnjuqEOGN/c+pmb
         RTUJ++jDnVR3LKTgo54VsbSVQlCXW22UNjf+TN6RQwJtmRk0PF9r77F0EvJZvEy1TjrV
         /Pvytc/P+haQjth8fUHRhdy+TnQpC6u73jpG4YPMAIjM+V9gi0t4v+piE/VPBlhU63xS
         TMA/J+fy/JTk59kAT9AXqksjPMHMimXDAeaFt8mp9fzx0s+eJKnEq3ZFPOHTJR1cAQGu
         3NnA==
X-Gm-Message-State: AOAM5336W51pkWvzu0DnOrADKYBRrHAJWgv+tRCeSesLc7HM7QpsxEzE
        B4L+v2lsM0wMLEk6UeikenFpwF9eYB5Xupi2epBC7HmS6vi/VlAfMCi04Etarp6cm28+Y+2l6RI
        CiPAw3xMngia6QOCDYdrmJd2KRbc+JBXT+zzEHPfLi8g4spqlCsFEJxLwrt4QgiUj1w1yM0JIOg
        ==
X-Google-Smtp-Source: ABdhPJyCRj3HEw7bXs9gv5pB/vK2ev4FRo/XX4FxVNtUNmPkp8Vh3rSKUM0qLMmFvyQ5XhvphF6KzDws1HboqTWjPVU=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:ae14:: with SMTP id
 a20mr26796830ybj.410.1608595357796; Mon, 21 Dec 2020 16:02:37 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:10 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 07/17] parse-options: parse into strvec
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse-options already knows how to read into a string_list, and it knows
how to read into an strvec as a passthrough (that is, including the
argument as well as its value). string_list and strvec serve similar
purposes but are somewhat painful to convert between; so, let's teach
parse-options to read values of string arguments directly into an
strvec without preserving the argument name.

This is useful if collecting generic arguments to pass through to
another command, for example, 'git hook run --arg "--quiet" --arg
"--format=pretty" some-hook'. The resulting strvec would contain
{ "--quiet", "--format=pretty" }.

The implementation is based on that of OPT_STRING_LIST.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Since v4, fixed one or two more places where I missed the argv_array->strvec
    rename.

 Documentation/technical/api-parse-options.txt |  5 +++++
 parse-options-cb.c                            | 16 ++++++++++++++++
 parse-options.h                               |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 5a60bbfa7f..679bd98629 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -173,6 +173,11 @@ There are some macros to easily define options:
 	The string argument is stored as an element in `string_list`.
 	Use of `--no-option` will clear the list of preceding values.
 
+`OPT_STRVEC(short, long, &struct strvec, arg_str, description)`::
+	Introduce an option with a string argument.
+	The string argument is stored as an element in `strvec`.
+	Use of `--no-option` will clear the list of preceding values.
+
 `OPT_INTEGER(short, long, &int_var, description)`::
 	Introduce an option with integer argument.
 	The integer is put into `int_var`.
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 4542d4d3f9..c2451dfb1b 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -207,6 +207,22 @@ int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+int parse_opt_strvec(const struct option *opt, const char *arg, int unset)
+{
+	struct strvec *v = opt->value;
+
+	if (unset) {
+		strvec_clear(v);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	strvec_push(v, arg);
+	return 0;
+}
+
 int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
 {
 	return 0;
diff --git a/parse-options.h b/parse-options.h
index 7030d8f3da..75cc8c7c96 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -177,6 +177,9 @@ struct option {
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
+#define OPT_STRVEC(s, l, v, a, h) \
+				    { OPTION_CALLBACK, (s), (l), (v), (a), \
+				      (h), 0, &parse_opt_strvec }
 #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_EXPIRY_DATE(s, l, v, h) \
@@ -296,6 +299,7 @@ int parse_opt_commits(const struct option *, const char *, int);
 int parse_opt_commit(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
+int parse_opt_strvec(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
 enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const struct option *,
-- 
2.28.0.rc0.142.g3c755180ce-goog

