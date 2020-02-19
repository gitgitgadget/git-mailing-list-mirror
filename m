Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2205AC34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E123720675
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9xVJGMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgBSQOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:14:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33228 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgBSQOE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:14:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so717931wmc.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 08:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uUIb95tsG3/5nd2WAuAHsCbhEA1nqoQa0F31tEEtT/M=;
        b=s9xVJGMgseQHAPbtfyPERSjAUoS44KJTN3MnMHGFwzvFBzN2CW2oOxRLs+JBd7hyph
         NKLjtJJXacBysv8Z+GVINutXJ2wSCTXJXNu8j8xXB1F6qU8VZ5oMbE3hOWWykwOHh4X7
         mhDPTo7Gcb0mSM0T2VMAEjUcfIbtrCoSNeR6KL3o5KVM3cGqpdiQZka2KIlaE1zinxZj
         /77XXOOb7bc83ZyCOKjt9QHDME7CmpxkewSnINcliEabXyoVdfF7wh8uUnzPESnD7xgv
         ECGCY5KP14sCnbNwwTtax8VvCv6K0l12nQ00R2r8UTe/AOBZzStj7HqU23WQEKcpSGE5
         sa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uUIb95tsG3/5nd2WAuAHsCbhEA1nqoQa0F31tEEtT/M=;
        b=MiOUWpBQE9VvmdV7+QbQqFfWhFyLSQtaTFYpYHN7sSd+T7CaV6gkFUm4Ls8MPpLBhe
         o5WL4vB+iz9KhQR8SGCkUD1J/H3yt3IxlXT9UdbBeB+guhz0/GvuhxlSw5zKMHH7e94W
         Nzkp0RX6apfEewnCAhOlkLG3zR6iNiJUoPq6Tyx1tAqBlGeWfRyCR9rlLuWIZY0AQUTP
         /0oCebpeYu0GQe8jLjGEWtlszEv8D3wn+AD8yZaKt1hPH0wJ5Jzp6yAxTTEz9cBPunKn
         cyWfiwlaQp0z7tQFtEj5LQOxpG130l3d5T1vp4lf7l2dbJfAlduoE+ZymeHm07dPmGos
         pfRQ==
X-Gm-Message-State: APjAAAVOX+uL1CAilNdd19FSsyOMbhL8IxUa+PguS+6Ru+4+8I/HA59e
        86sUIuZEcya+k7CbTw5XQKDEsadV
X-Google-Smtp-Source: APXvYqxNiD19kNNvEzKcRsOSg2M08jhDrouzcV7IZSryytHten6MdvqmrLU2HngosjyZ4EuOO3B7kg==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr10409416wmj.7.1582128841421;
        Wed, 19 Feb 2020 08:14:01 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id w7sm376771wmi.9.2020.02.19.08.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:14:00 -0800 (PST)
From:   pbonzini@redhat.com
To:     git@vger.kernel.org
Cc:     bfields@redhat.com
Subject: [PATCH 1/4] parse-options: convert "command mode" to a flag
Date:   Wed, 19 Feb 2020 17:13:49 +0100
Message-Id: <20200219161352.13562-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219161352.13562-1-pbonzini@redhat.com>
References: <20200219161352.13562-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

OPTION_CMDMODE is essentially OPTION_SET_INT plus the extra check
that the variable had not set before.  In order to allow custom
processing, change it to OPTION_SET_INT plus a new flag that takes
care of the check.  This works as long as the option value points
to an int.

Add testcases while at it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 parse-options.c               | 20 +++++++++-----------
 parse-options.h               |  8 ++++----
 t/helper/test-parse-options.c |  2 ++
 t/t0040-parse-options.sh      | 18 ++++++++++++++++++
 4 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index a0cef401fc..c6e9e2733b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -61,7 +61,7 @@ static enum parse_opt_result opt_command_mode_error(
 	 */
 	for (that = all_opts; that->type != OPTION_END; that++) {
 		if (that == opt ||
-		    that->type != OPTION_CMDMODE ||
+		    !(that->flags & PARSE_OPT_CMDMODE) ||
 		    that->value != opt->value ||
 		    that->defval != *(int *)opt->value)
 			continue;
@@ -95,6 +95,14 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 	if (!(flags & OPT_SHORT) && p->opt && (opt->flags & PARSE_OPT_NOARG))
 		return error(_("%s takes no value"), optname(opt, flags));
 
+	/*
+	 * Giving the same mode option twice, although unnecessary,
+	 * is not a grave error, so let it pass.
+	 */
+	if ((opt->flags & PARSE_OPT_CMDMODE) &&
+	    *(int *)opt->value && *(int *)opt->value != opt->defval)
+		return opt_command_mode_error(opt, all_opts, flags);
+
 	switch (opt->type) {
 	case OPTION_LOWLEVEL_CALLBACK:
 		return opt->ll_callback(p, opt, NULL, unset);
@@ -130,16 +138,6 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 		*(int *)opt->value = unset ? 0 : opt->defval;
 		return 0;
 
-	case OPTION_CMDMODE:
-		/*
-		 * Giving the same mode option twice, although is unnecessary,
-		 * is not a grave error, so let it pass.
-		 */
-		if (*(int *)opt->value && *(int *)opt->value != opt->defval)
-			return opt_command_mode_error(opt, all_opts, flags);
-		*(int *)opt->value = opt->defval;
-		return 0;
-
 	case OPTION_STRING:
 		if (unset)
 			*(const char **)opt->value = NULL;
diff --git a/parse-options.h b/parse-options.h
index 1d60205881..fece5ba628 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -18,7 +18,6 @@ enum parse_opt_type {
 	OPTION_BITOP,
 	OPTION_COUNTUP,
 	OPTION_SET_INT,
-	OPTION_CMDMODE,
 	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
@@ -47,7 +46,8 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LITERAL_ARGHELP = 64,
 	PARSE_OPT_SHELL_EVAL = 256,
 	PARSE_OPT_NOCOMPLETE = 512,
-	PARSE_OPT_COMP_ARG = 1024
+	PARSE_OPT_COMP_ARG = 1024,
+	PARSE_OPT_CMDMODE = 2048
 };
 
 enum parse_opt_result {
@@ -168,8 +168,8 @@ struct option {
 #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
-#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
+#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
 #define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
 				      N_("n"), (h), PARSE_OPT_NONEG }
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index af82db06ac..2051ce57db 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -121,6 +121,8 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
 		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
+		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", 1),
+		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", 2),
 		OPT_CALLBACK('L', "length", &integer, "str",
 			"get length of <str>", length_callback),
 		OPT_FILENAME('F', "file", &file, "set file to <file>"),
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 9d7c7fdaa2..7f4c15a52b 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -23,6 +23,8 @@ usage: test-tool parse-options <options>
     -j <n>                get a integer, too
     -m, --magnitude <n>   get a magnitude
     --set23               set integer to 23
+    --mode1               set integer to 1 (cmdmode option)
+    --mode2               set integer to 2 (cmdmode option)
     -L, --length <str>    get length of <str>
     -F, --file <file>     set file to <file>
 
@@ -324,6 +326,22 @@ test_expect_success 'OPT_NEGBIT() works' '
 	test-tool parse-options --expect="boolean: 6" -bb --no-neg-or4
 '
 
+test_expect_success 'OPT_CMDMODE() works' '
+	test-tool parse-options --expect="integer: 1" --mode1
+'
+
+test_expect_success 'OPT_CMDMODE() detects incompatibility' '
+	test_must_fail test-tool parse-options --mode1 --mode2 >output 2>output.err &&
+	test_must_be_empty output &&
+	grep "incompatible with --mode" output.err
+'
+
+test_expect_success 'OPT_CMDMODE() detects incompatibility with something else' '
+	test_must_fail test-tool parse-options --set23 --mode2 >output 2>output.err &&
+	test_must_be_empty output &&
+	grep "incompatible with something else" output.err
+'
+
 test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
 	test-tool parse-options --expect="boolean: 6" + + + + + +
 '
-- 
2.21.1


