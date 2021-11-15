Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48191C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3743561A40
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346881AbhKOXfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352949AbhKOXSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C6C03E036
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d27so33594137wrb.6
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sqgk+sdbf4iPtslXol8PI/PtfQxIvAnUs//LDk601wA=;
        b=h6kGX79w4O4DRUPFEZStkxNFXblyGydlTh0B3UwcefORvAFltVrk6yItL+90weq+he
         Xhb8ZG/0jG8s89FpPIEUpqKWvXMVrnYsx5nbT55JrCY2cWa8it/LmTuDY2uq0Pn6ea82
         8FEMl28vA95goFLOcye3SrQ3661j/Z//Xa70bkkuIWtRgxHcyxvoPM6VGDLHHNKgqF91
         P86S+Th2pCMbunQk16vZxUtPKdB3421mFrVoDh8xmaYZ1IlwjEZG7nXjO8WwU02/0yDn
         AFQvkPfq/H6gjZMNr0HqeZR+M3/k/sn4fXCizCAU7nnudmj4w3dr0wmbnyvTEbVjyjTU
         lW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sqgk+sdbf4iPtslXol8PI/PtfQxIvAnUs//LDk601wA=;
        b=v/zM5rLX6f46IJIjlT3B83QSNcfl9E7vUlb6toUYyluiOi7h0aYRKkqQVsAvIFBWeB
         LVj7Uj/1in+fIt7dCnBZh+4Q/oWKEO52L3VP0H6SXlzqKJTFBr2/uJUmxBBX0WvPoNyQ
         boFc8cDSyykwqps8fqa7iOy5tr1qf5QjuSAH700hmDKzv+pX6FsV9Y+fMwlIk20O7Dil
         bIseR/MekfRMUaiDenHOF+5JeEtrFdqNBKnrUZ7NpuM/gFPyjfdTxequ+66aQHoc+r0X
         XA+GqxRO4fAIis2gVqx7P/ISf+64LT5rSzCSS8jaUhN3myGeOO3DM9kLLkmxisFeHa5v
         hnnw==
X-Gm-Message-State: AOAM531P6tYNY5CjhGUejiQAKgzr7BEA0s0n/RD65v8dmEVQWJKwhNMP
        gM4ATy4pzYo84vJ/O047fOa9Pv5uf5KdaA==
X-Google-Smtp-Source: ABdhPJyZpgC2s6HxlxzLGnJLCeAUMOkgDaIHPMQA/TPaHYKWnes8eUR49nTb3EEzq4XUgJFkPXZ3zw==
X-Received: by 2002:adf:f787:: with SMTP id q7mr3102690wrp.1.1637014720571;
        Mon, 15 Nov 2021 14:18:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 09/21] parse-options.[ch] API: use bug() to improve error output
Date:   Mon, 15 Nov 2021 23:18:19 +0100
Message-Id: <RFC-patch-09.21-9c6af87c6c9-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we run into bugs in parse-options.c usage it's good to be able to
note all the issues we ran into before dying, which is why we have the
optbug() function.

Let's instead use the bug() helper function that's newly added to
usage.c to do the same thing, which cuts down on the verbosity of
parse_options_check().

In addition change the use of BUG() in that function to bug(), we'll
be dying soon enough, but always want exhaustive error reporting from
the function.

Let's also use bug() instead of BUG() in preprocess_options() and
parse_options_start_1() (which is called shortly after
preprocess_options()). Since the BUG_if_bug() is called at the end of
parse_options_start_1() we won't miss it, and even if we did the
invocation in common-main.c would trigger.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 54 ++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 8bc0a21f1d7..54cbd382cb5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -14,15 +14,15 @@ enum opt_parsed {
 	OPT_UNSET = 1<<1,
 };
 
-static int optbug(const struct option *opt, const char *reason)
+static void optbug(const struct option *opt, const char *reason)
 {
-	if (opt->long_name) {
-		if (opt->short_name)
-			return error("BUG: switch '%c' (--%s) %s",
-				     opt->short_name, opt->long_name, reason);
-		return error("BUG: option '%s' %s", opt->long_name, reason);
-	}
-	return error("BUG: switch '%c' %s", opt->short_name, reason);
+	if (opt->long_name && opt->short_name)
+		bug("switch '%c' (--%s) %s", opt->short_name,
+		    opt->long_name, reason);
+	else if (opt->long_name)
+		bug("option '%s' %s", opt->long_name, reason);
+	else
+		bug("switch '%c' %s", opt->short_name, reason);
 }
 
 static const char *optname(const struct option *opt, enum opt_parsed flags)
@@ -440,28 +440,27 @@ static void check_typos(const char *arg, const struct option *options)
 
 static void parse_options_check(const struct option *opts)
 {
-	int err = 0;
 	char short_opts[128];
 
 	memset(short_opts, '\0', sizeof(short_opts));
 	for (; opts->type != OPTION_END; opts++) {
 		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
 		    (opts->flags & PARSE_OPT_OPTARG))
-			err |= optbug(opts, "uses incompatible flags "
-					"LASTARG_DEFAULT and OPTARG");
+			optbug(opts, "uses incompatible flags "
+			       "LASTARG_DEFAULT and OPTARG");
 		if (opts->short_name) {
 			if (0x7F <= opts->short_name)
-				err |= optbug(opts, "invalid short name");
+				optbug(opts, "invalid short name");
 			else if (short_opts[opts->short_name]++)
-				err |= optbug(opts, "short name already used");
+				optbug(opts, "short name already used");
 		}
 		if (opts->flags & PARSE_OPT_NODASH &&
 		    ((opts->flags & PARSE_OPT_OPTARG) ||
 		     !(opts->flags & PARSE_OPT_NOARG) ||
 		     !(opts->flags & PARSE_OPT_NONEG) ||
 		     opts->long_name))
-			err |= optbug(opts, "uses feature "
-					"not supported for dashless options");
+			optbug(opts, "uses feature "
+			       "not supported for dashless options");
 		switch (opts->type) {
 		case OPTION_COUNTUP:
 		case OPTION_BIT:
@@ -470,22 +469,22 @@ static void parse_options_check(const struct option *opts)
 		case OPTION_NUMBER:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
-				err |= optbug(opts, "should not accept an argument");
+				optbug(opts, "should not accept an argument");
 			break;
 		case OPTION_CALLBACK:
 			if (!opts->callback && !opts->ll_callback)
-				BUG("OPTION_CALLBACK needs one callback");
+				bug("OPTION_CALLBACK needs one callback");
 			if (opts->callback && opts->ll_callback)
-				BUG("OPTION_CALLBACK can't have two callbacks");
+				bug("OPTION_CALLBACK can't have two callbacks");
 			break;
 		case OPTION_LOWLEVEL_CALLBACK:
 			if (!opts->ll_callback)
-				BUG("OPTION_LOWLEVEL_CALLBACK needs a callback");
+				bug("OPTION_LOWLEVEL_CALLBACK needs a callback");
 			if (opts->callback)
-				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
+				bug("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
 			break;
 		case OPTION_ALIAS:
-			BUG("OPT_ALIAS() should not remain at this point. "
+			bug("OPT_ALIAS() should not remain at this point. "
 			    "Are you using parse_options_step() directly?\n"
 			    "That case is not supported yet.");
 		default:
@@ -493,10 +492,8 @@ static void parse_options_check(const struct option *opts)
 		}
 		if (opts->argh &&
 		    strcspn(opts->argh, " _") != strlen(opts->argh))
-			err |= optbug(opts, "multi-word argh should use dash to separate words");
+			optbug(opts, "multi-word argh should use dash to separate words");
 	}
-	if (err)
-		exit(128);
 }
 
 static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
@@ -518,11 +515,12 @@ static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
 	    (flags & PARSE_OPT_STOP_AT_NON_OPTION) &&
 	    !(flags & PARSE_OPT_ONE_SHOT))
-		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
+		bug("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
 	if ((flags & PARSE_OPT_ONE_SHOT) &&
 	    (flags & PARSE_OPT_KEEP_ARGV0))
-		BUG("Can't keep argv0 if you don't have it");
+		bug("Can't keep argv0 if you don't have it");
 	parse_options_check(options);
+	BUG_if_bug();
 }
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
@@ -673,7 +671,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 		source = newopt[i].value;
 
 		if (!long_name)
-			BUG("An alias must have long option name");
+			bug("An alias must have long option name");
 		strbuf_addf(&help, _("alias of --%s"), source);
 
 		for (j = 0; j < nr; j++) {
@@ -694,7 +692,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 		}
 
 		if (j == nr)
-			BUG("could not find source option '%s' of alias '%s'",
+			bug("could not find source option '%s' of alias '%s'",
 			    source, newopt[i].long_name);
 		ctx->alias_groups[alias * 3 + 0] = newopt[i].long_name;
 		ctx->alias_groups[alias * 3 + 1] = options[j].long_name;
-- 
2.34.0.rc2.809.g11e21d44b24

