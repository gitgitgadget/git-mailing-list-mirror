Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8672C433E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A840F2075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uu+h6A/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgG1WZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgG1WZM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 18:25:12 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF08C0619D2
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:25:12 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j11so636466pje.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hE/wVrBcrLU6WTTzcQ1lC2cg0JGbTP43UeGVUpoFtZc=;
        b=uu+h6A/glA0271OO9MrnIfMzMsUDVWrXak7BZiAS+T5VsY1lwwpF6ceIFWyzRxQcuB
         5Nsiov5B73Z3AFzty9FuaG1svRQ0lfqTAPVHUlCATakVZ0770SwL9u7ThNPeNeGcZvWL
         5iMIaNSS0JdF+YuAtr6NBm8kpOC9oQ4fNxNVPvISl6vKYmo9NWmmTuaMN/50X82r1ulk
         a/Ukv/W48nkRk5IMHiRa7bddI1JZ3MKCAAgtwqvz0r5DuMqz2iDpMvdV/PKwOLjDeY0+
         S1XM8Qd+sTNk7V0J/7dIRzTpzn5CiVWBnUOu7HB882MO68W5jAYrFRaKhtPlZYMKReo3
         bpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hE/wVrBcrLU6WTTzcQ1lC2cg0JGbTP43UeGVUpoFtZc=;
        b=ggGK3eUScTHsg89ZnmcFoNljHO8Yshwkd92p8RnxL05yBXOFTTL2HitR+4b//Pbovm
         BWAGbS7z6JlszuQ8K3JWVABz4tSdgSGrHghg6vSikyHkYY3+JQWNsD00ZEJ+hhtORM8e
         snhSlTGigKAOuQuHU3P0qHVe546S/kmGfOLxW9LuWAk7P+ci1Fa1qvwJ0iddTeTv1hm9
         icy38p93IrUQwwf2vziRkqpCiKZ6GodW/heGzRAqTxWKkQhjltjAoOLxyPTJpWvkGi48
         x0gRodAnwrMzehw4POXodytiumx+yyytDdRYoxgRPZDqVvwGlT0InjqXqb1mW9R0vUjb
         A5gQ==
X-Gm-Message-State: AOAM533LG+7f7qd3p1va3rawAkiNOKYz4L4rlmRKFNx8SFciYS6LR8ET
        vFSBBQ+SQsu6aX0mEQSfmxPlXLPx4SaIUuvJbo04rr+hHPhNX+hYoKxpTLtHuHhXCc34vhmhvYw
        zR6SKmy2xafC0rq8jShQ9mkoC87nM484r3N9CrUw/hhLkgJmZlapIiph387z3yz3CsxhswRbPNA
        ==
X-Google-Smtp-Source: ABdhPJwyro/YxCMmbpZBUiUPOb0E1DXaZhAOcB2qoKDMYaTplB7VWvM8Q4coVdIWyIAM/Oq+GrDYSxHqn56e6SzOoH8=
X-Received: by 2002:a17:90b:3807:: with SMTP id mq7mr6054903pjb.221.1595975111917;
 Tue, 28 Jul 2020 15:25:11 -0700 (PDT)
Date:   Tue, 28 Jul 2020 15:24:54 -0700
In-Reply-To: <20200728222455.3023400-1-emilyshaffer@google.com>
Message-Id: <20200728222455.3023400-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200728222455.3023400-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [RFC PATCH v3 5/6] parse-options: parse into argv_array
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse-options already knows how to read into a string_list, and it knows
how to read into an argv_array as a passthrough (that is, including the
argument as well as its value). string_list and argv_array serve similar
purposes but are somewhat painful to convert between; so, let's teach
parse-options to read values of string arguments directly into an
argv_array without preserving the argument name.

This is useful if collecting generic arguments to pass through to
another command, for example, 'git hook run --arg "--quiet" --arg
"--format=pretty" some-hook'. The resulting argv_array would contain
{ "--quiet", "--format=pretty" }.

The implementation is based on that of OPT_STRING_LIST.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/technical/api-parse-options.txt |  5 +++++
 parse-options-cb.c                            | 16 ++++++++++++++++
 parse-options.h                               |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 2e2e7c10c6..1e97343338 100644
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
index 86cd393013..94c2dd397a 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -205,6 +205,22 @@ int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+int parse_opt_argv_array(const struct option *opt, const char *arg, int unset)
+{
+	struct argv_array *v = opt->value;
+
+	if (unset) {
+		argv_array_clear(v);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	argv_array_push(v, arg);
+	return 0;
+}
+
 int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
 {
 	return 0;
diff --git a/parse-options.h b/parse-options.h
index 46af942093..e2e2de75c8 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -177,6 +177,9 @@ struct option {
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
+#define OPT_ARGV_ARRAY(s, l, v, a, h) \
+				    { OPTION_CALLBACK, (s), (l), (v), (a), \
+				      (h), 0, &parse_opt_argv_array }
 #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_EXPIRY_DATE(s, l, v, h) \
@@ -296,6 +299,7 @@ int parse_opt_commits(const struct option *, const char *, int);
 int parse_opt_commit(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
+int parse_opt_argv_array(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
 enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const struct option *,
-- 
2.28.0.rc0.142.g3c755180ce-goog

