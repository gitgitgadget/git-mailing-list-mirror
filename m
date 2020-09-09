Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7ACC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E842177B
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="R9MoF8pB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgIIAuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgIIAuB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 20:50:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41713C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 17:49:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j20so874239ybt.10
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 17:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nhZYNCfrc7LBG0PG1IIHge72kRRdZrR0w3xUUNmrkO0=;
        b=R9MoF8pBGF3FCk0DUyQKVgz/HnRa39m2fdOxRkUapW1BNk6vQ4lv9ZRCuHPnCh4Qdz
         AcXzsEldW1/0OkwiWOKDFTPRp/lM6wKu957tC8Yy6kG0wMV6wW8p9oAHULSU9R+sIrR8
         8SE/MoK67NqEZJyfKrS3CYRza2Av+l0591xVaLnRCEqTuv3X9ByqK3ucM2PtpR2tSO2Q
         w9Z29QNBLs445HXqWmqVwS5Ze+4DcWGqp7VZqgNUHhTpJn6WLhK21kTrjozBJZ+pLzRk
         /gQ4qYlJA9aFDKJP3CX8c/QSRwC3jhB1ulsZ0DTaIAgX8kGQQk5QIcP8gtt1a+dtWzi7
         Wd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nhZYNCfrc7LBG0PG1IIHge72kRRdZrR0w3xUUNmrkO0=;
        b=txLMXXxA/Lak3tZjS+yeZycBhyo1cUmYBK3tDnv0L/OV2mK+CfYQSA9rSVs7YM3rNh
         DR6OGBh21bnzYO51TCRiUWhaHL5RCk2p2GE7t8KhwOZ2c9IoUhsRf8OXTNaTAfFfhbbo
         746aJXQpg7z9jhbE6ki0IOC+f1AnM//N6tYO4bLB0vjmv7F2aHIhbl6oxnY9RbC7oxan
         BxAXuOwB0A3nHiCCKB5MLlIcyKdtoNxhX8FjRjt8iJ3dPWTV4i+OSBZBI/QFxW5j/pbV
         uIqKIFqpIJKw4S6+ErW+WP8WxXGQifqbf4NuxOgrOuZMa2XX1qHa+4e8wtHuow0jpzbZ
         cz8Q==
X-Gm-Message-State: AOAM533OzoRz9dHCNzchazlnOzuTYwfp4ZSOIH3uThEfWTF0mqOeD742
        +NfI3htxuKsALW0IaQ3dIYwduEpBrIHLe7vQgzlV9Wf6QCG6N4ihNT9khVF4uPqtYgpsjcIeDpL
        Lo5Kt1FGsOKks8W/rUfBHg7zAZtdSNEDI1QLs4X/1it5WK2nCQGQMNs/BV/x+pgpLxFWVRYKgYQ
        ==
X-Google-Smtp-Source: ABdhPJwUKf3hD+TcsmSPmXi0Ect3wB56VFqkSie0w1Ht72Se/kkNcRy6QTlIMQsgWGYAvUw7gJk6MvcO0vtCITx3G3s=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:2611:: with SMTP id
 m17mr14666ybm.442.1599612598351; Tue, 08 Sep 2020 17:49:58 -0700 (PDT)
Date:   Tue,  8 Sep 2020 17:49:35 -0700
In-Reply-To: <20200909004939.1942347-1-emilyshaffer@google.com>
Message-Id: <20200909004939.1942347-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200909004939.1942347-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v4 5/9] parse-options: parse into strvec
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
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
 Documentation/technical/api-parse-options.txt |  5 +++++
 parse-options-cb.c                            | 16 ++++++++++++++++
 parse-options.h                               |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 5a60bbfa7f..b4f1fc4a1a 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -173,6 +173,11 @@ There are some macros to easily define options:
 	The string argument is stored as an element in `string_list`.
 	Use of `--no-option` will clear the list of preceding values.
 
+`OPT_ARGV_ARRAY(short, long, &struct argv_array, arg_str, description)`::
+	Introduce an option with a string argument.
+	The string argument is stored as an element in `argv_array`.
+	Use of `--no-option` will clear the list of preceding values.
+
 `OPT_INTEGER(short, long, &int_var, description)`::
 	Introduce an option with integer argument.
 	The integer is put into `int_var`.
diff --git a/parse-options-cb.c b/parse-options-cb.c
index d9d3b0819f..d2b8b7b98a 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -205,6 +205,22 @@ int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
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
index 46af942093..177259488b 100644
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

