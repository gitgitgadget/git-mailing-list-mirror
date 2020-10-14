Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02142C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8689B22258
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kerkV2Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgJOByj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732412AbgJOByi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:54:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04469C08EADA
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k9so1090145ybf.18
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tYBIp72At1pPq2NwvWzTuSgSJkDuk44JQzLmJTw7OgE=;
        b=kerkV2Ep5ZlYTv4FdXs89FdAByqAILzCv9Lo49Seaz85ZOoQ2cLhauSWMVW9NrLg4k
         jnETXGmQWqGVCkzpqnENdniVImJLWyq1MhekKfo7ZAp0qHQdzlhobqKJM5UlOcsb9TTc
         iG4yIs3SUVccZX6bV0IcS4XyVHFqFB1kStqQ+DXcA56RBq33ZlkkRXL5Q6i+h6zrLlow
         QA3XAhtdzNOfZ14/LAkb9wLsZVpJXwgeiaBxcLv6MO4RyaVLhq571nBQS7OqOTi4CeZs
         yQ9VZiACCNWMvmRo3q7ee3OCmc/X+GAOm2QykVfMgZ+sjNXNyqRU+EtARCOnf+qkSd3K
         1kTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tYBIp72At1pPq2NwvWzTuSgSJkDuk44JQzLmJTw7OgE=;
        b=kTn/sIcRV7fiGggr6Nw5/TMIJ4120X3Qiot9mgxu6R3V1jHo9Z3NYJkUdbhRhOL15S
         GoT79uvNLf6dxN8JQWiuqNnCujePUl6iKqBx4FPfIyHNWkxrvM0pLS6tG/9MLM5h1yPx
         X+BCgT5TpHgJHKd74JZdVFSSxYP1txLd41kWH8sQyHxiLnQqulLPeq9i97BkHEgAesPe
         i0TUm1BDwNIWemoL497G9EYLqLykvUC7df0ty6l2W3YljarOQalTxUvyUJQxQQfR2S87
         lDuVLF9eLh7rh+kb1SRHAcXCvdqdEMSWGUofKD6RG5DRnGcQ8bF3stz+0VnXqm8Cvp7H
         C8JA==
X-Gm-Message-State: AOAM533rfWCs22Z+Cesi1kgSNJH6embi8MRqIMWJYLn6FD3ARfuTpbdU
        nSomVDYCzbp+2yjepj9vnmNAJHnss0XVxwmkRx6xUJ5swhrmCuzusIyywwuRWWcjACF5lVOlN7T
        RPF/LW9ddSGInlgBW3Cyh0zklMfKCiua2Ta5XdHRIKGRD9YhSxbKYsU5ej7DTvfI1rw/P1KUo6w
        ==
X-Google-Smtp-Source: ABdhPJzmzCdQqzPYV+sfnJXLlwEG30QyxbBQAB+szCqKPPPpwPf0UFrqowLpETYHtwwk6oKwARRz9Y38efQL8hkZSoY=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:6f89:: with SMTP id
 k131mr1632826ybc.21.1602717907165; Wed, 14 Oct 2020 16:25:07 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:24:45 -0700
In-Reply-To: <20201014232447.3050579-1-emilyshaffer@google.com>
Message-Id: <20201014232447.3050579-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201014232447.3050579-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH v5 6/8] parse-options: parse into strvec
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

