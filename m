Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6111208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 23:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbdIEXIu (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 19:08:50 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34887 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbdIEXIt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 19:08:49 -0400
Received: by mail-pf0-f170.google.com with SMTP id g13so10047074pfm.2
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/ubOZc9VaWfuivCUahzxv9YASbzKe81TJdr0dbt098=;
        b=ZBD+nQW3sHNpaBkh7moP6C6rLA4mk6pOCpq6xiUwX8up2GMw5/aajrZqdxkrWpmO9/
         mdtG8tqxdFet+LwlECbpFwuFc7pLhGubTF6lueRshAxM9raZRY0V6tZtRcMb97sNMmd3
         NL4ndpwTvtI5SM3nj9trBsKi42ZZ11QvK6HPgdKeWTxVDqTKpytnmhiEoqVr4xnBJW8X
         G86ltja4e0ZRpeks9ALwEaSsSgP1KvuqS83vMmZiKq/DjG2wGnamBre1+tJ758UlVitS
         gN2x6LJVaGOL8p/45Q+UMAZwBz7XZOj9EZx6u2zQT5zjSEh7AqcfwD/Lrw6e6e2zojL3
         txqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a/ubOZc9VaWfuivCUahzxv9YASbzKe81TJdr0dbt098=;
        b=LrLbSl4erhQgqZplsXiIyN5nRyCwPfJy/lHtLZHMgb5Q88vUpmuhQE5vFlTLHDn8Y3
         iBDE8yTavkusoeZqbczEDD2LLKQKCOwTALau1iDNGXMDzO7RRoHAZ92xzJF1/I+pKPta
         XlVX1AjHLhZqSOfK9QvoIzR8h6+RWASs9yAdWIrrdyaJ3HSHqLtYZPNDnCjVKw2yRL9Y
         9kjQ+FZxqNRyI5KucaOBUXBSyzFRAJqbNd3E6H0UyVj4q7y9JUHrcavcKPG8TZxS4g9B
         kBoUprrymNCiVBSLiSRJ7ZPirSmEln0O413BWwCgJZ9jubhcv9tLcNvC3m653kRDR8Lh
         8fQA==
X-Gm-Message-State: AHPjjUgB7hxd0s8CDujHNQdgjNtxRuipJDZHe/RT4SJWYR93etD/4GgU
        RApTPq4KQLn/LHS+
X-Google-Smtp-Source: ADKCNb6IQN/hGX43z8zxtiUA49mV/YirMCJaI2nahZwKSPH3k4IZCC83YsZgZl+9DMiM/Z6kdv6h9Q==
X-Received: by 10.98.200.72 with SMTP id z69mr5481154pff.304.1504652928744;
        Tue, 05 Sep 2017 16:08:48 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:68f1:5dd3:a20b:9946])
        by smtp.gmail.com with ESMTPSA id e19sm50460pfl.146.2017.09.05.16.08.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 05 Sep 2017 16:08:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCH] parse-options: warn developers on negated options
Date:   Tue,  5 Sep 2017 16:08:45 -0700
Message-Id: <20170905230845.17108-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When compiling with -DDEVELOPER set (enabled via the Makefile DEVELOPER
switch), inspect options if they are negated and warn about them.

 1. Negated options are usually are problem down the maintenance road:
    When a new negated option ("--no-foo") is introduced, then the option
    can be negated at run time("--no-no-foo"), which is usually confusing
    for boolean options.
 2. The handling of negated values (specifically double negations), usually
    require more brain power to get it right. In code that we own, we
    should strive to avoid double negatives ("!no_foo").

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  #leftoverbits
  
  I was wondering if such a patch may be of value eventually (after all
  occurrences of "no-" options are fixed).
  This patch disallows all no- options, but we could be more open and allow
  --no-options that have the NO_NEG bit set.

 Makefile        | 3 ++-
 parse-options.c | 6 ++++++
 parse-options.h | 7 +++++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index aba0f5a0f9..9b87093f99 100644
--- a/Makefile
+++ b/Makefile
@@ -433,7 +433,8 @@ DEVELOPER_CFLAGS = -Werror \
 	-Wpointer-arith \
 	-Wstrict-prototypes \
 	-Wunused \
-	-Wvla
+	-Wvla \
+	-DDEVELOPER
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
diff --git a/parse-options.c b/parse-options.c
index 0dd9fc6a0d..08db926adf 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -403,6 +403,12 @@ static void parse_options_check(const struct option *opts)
 		if (opts->argh &&
 		    strcspn(opts->argh, " _") != strlen(opts->argh))
 			err |= optbug(opts, "multi-word argh should use dash to separate words");
+#if DEVELOPER
+		if ((opts->flags & PARSE_OPT_ERR_NEGATED) &&
+		    !strcmp("no-", opts->long_name))
+			BUG("Get %s fixed! double negation possible",
+			    opts->long_name);
+#endif
 	}
 	if (err)
 		exit(128);
diff --git a/parse-options.h b/parse-options.h
index af711227ae..9dc07fd9bb 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -38,7 +38,8 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
-	PARSE_OPT_SHELL_EVAL = 256
+	PARSE_OPT_SHELL_EVAL = 256,
+	PARSE_OPT_ERR_NEGATED = 512
 };
 
 struct option;
@@ -124,7 +125,9 @@ struct option {
 				      (h), PARSE_OPT_NOARG }
 #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (i) }
-#define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
+#define OPT_BOOL(s, l, v, h)        { OPTION_SET_INT, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG|PARSE_OPT_ERR_NEGATED, \
+				      NULL, 1 }
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
-- 
2.14.0.rc0.3.g6c2e499285

