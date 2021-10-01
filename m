Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A92CC4332F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B7461A3A
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354527AbhJAObO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354523AbhJAObL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4472C06177E
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so11404626wmq.1
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iu6PdNVjwT2fgh+AgFM/fZ1uWdEaqpsZmyTf+3G3ZgM=;
        b=kVurZfwEs+d5mBYOyz0i9BtLKb5khLBF+O7W1iXwzCwzhO2qzjHY/5GXCUoDhwxNrK
         Z0iBV5ei/4JDkDUQY+T15PxasPeoykyj3JIFLBYTfZCpNnOrlyHP9YSsrKqKQ3VQTPPn
         NWTGoflgQPR7nAC7bBqKHzrQ5VTR8wUcQnaHv1MrGbk9//6VY+f2JOpLgys2Yu441J9g
         5Lvz66RuCKgUDoYnWNMCIgSJ/jYizvcZKFWkc8mFD0UNwi0TccJQA7bNud+lysng+yNh
         ClJmkyALMEPifRX31MQ+9QYMfNVljQ7Vxuxp3DWSpAYNp9CaRD7EYt5QRXDDRHqRDZ5D
         EEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iu6PdNVjwT2fgh+AgFM/fZ1uWdEaqpsZmyTf+3G3ZgM=;
        b=vBsVUbOvF8SkEEpe2+ZrrkReVxJox0iAnriBAWdF/J7kiXX45BlIq5JamhgkVmgGIC
         3GnI2HaMEsVY2vnFTe395nubV47zVwed+VPcCdOuKPYtabzfMYG/w2a3VUix22kw8nMy
         NlyUt4ZdtxPfM0AMLB+rH9YBnH29X+z2O0+Dkpdj5xSsV2kqmKU7hgd3bagZl4IKOqjB
         iMNjFbHnRWYu7vaNtavkOxH8NAyaAIgSStedXwtjGT6q4eC5ooAxhOgGl1oDFb98q8EB
         LU1VsX/LzHQUbgVvXr2UxwWqoB5k2jkzA83xCY65L1UUWgnGsgwG+MnQGOaAFqQyt+7g
         L4ug==
X-Gm-Message-State: AOAM532R/xMWAt2At337eHUjaTGUPtSPAYqnsy7ahHqcJv42POQw3S+B
        43yUQBYb4fgIBm16Uq3VsxUGuaIqLhVQtw==
X-Google-Smtp-Source: ABdhPJy4mXZkS8al9FTyzJrit1VOBVSEBEDFnVl8gbXoURmguUE/U3CP8NWLn6eI5+l8hIf1nhcf1g==
X-Received: by 2002:a05:600c:3585:: with SMTP id p5mr5029342wmq.110.1633098565128;
        Fri, 01 Oct 2021 07:29:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/11] parse-options.c: use exhaustive "case" arms for "enum parse_opt_type"
Date:   Fri,  1 Oct 2021 16:29:11 +0200
Message-Id: <patch-v2-05.11-467828780d0-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code in get_value(), parse_options_check() etc. to do away with
the "default" case in favor of exhaustively checking the relevant
fields.

The added "return -1" is needed for the GCC version commented on
inline, my local clang 11.0.1-2 does not require it. Let's add it for
now to appease GCC.

The added "special types" etc. comments correspond to the relevant
comments and ordering on the "enum parse_opt_type". Let's try to keep
the same order and commentary as there where possible for
clarity. This doesn't reach that end-state, and due to the different
handling of options it's probably not worth it to get there, but let's
match its ordering where it's easy to do so.

There was a discussion about whether this was worth the added
verbosity, as argued in[1] I think it's worth it for getting
compile-time checking when adding new option types. We *should* have
tests for some of these, but e.g. in the show_gitcomp() case one might
run through the whole test suite and only hit a missing case at the
end on the completion tests.

This technically changes the handling of OPTION_END, but it's
obviously the right thing to do. We're calling this code from within a
loop that uses OPTION_END as a break condition, so it was never caught
by the "default" case.

So let's make encountering OPTION_END a BUG(), just like it already is
in the get_value() handling added in 4a59fd13122 (Add a simple option
parser., 2007-10-15).

1. https://lore.kernel.org/git/87tui3vk8y.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 parse-options.h |  2 +-
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e33700d6e71..dedd40efec5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -219,9 +219,14 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 				     optname(opt, flags));
 		return 0;
 
-	default:
+	/* special types */
+	case OPTION_END:
+	case OPTION_GROUP:
+	case OPTION_NUMBER:
+	case OPTION_ALIAS:
 		BUG("opt->type %d should not happen", opt->type);
 	}
+	return -1; /* gcc 10.2.1-6's -Werror=return-type */
 }
 
 static enum parse_opt_result parse_short_opt(struct parse_opt_ctx_t *p,
@@ -443,6 +448,9 @@ static void parse_options_check(const struct option *opts)
 			err |= optbug(opts, "uses feature "
 					"not supported for dashless options");
 		switch (opts->type) {
+		case OPTION_END:
+			BUG("unreachable");
+
 		case OPTION_COUNTUP:
 		case OPTION_BIT:
 		case OPTION_NEGBIT:
@@ -468,8 +476,14 @@ static void parse_options_check(const struct option *opts)
 			BUG("OPT_ALIAS() should not remain at this point. "
 			    "Are you using parse_options_step() directly?\n"
 			    "That case is not supported yet.");
-		default:
-			; /* ok. (usually accepts an argument) */
+
+		case OPTION_BITOP:
+		case OPTION_FILENAME:
+		case OPTION_GROUP:
+		case OPTION_INTEGER:
+		case OPTION_MAGNITUDE:
+		case OPTION_STRING:
+			break;
 		}
 		if (opts->argh &&
 		    strcspn(opts->argh, " _") != strlen(opts->argh))
@@ -532,6 +546,9 @@ static void show_negated_gitcomp(const struct option *opts, int show_all,
 			continue;
 
 		switch (opts->type) {
+		case OPTION_END:
+			BUG("unreachable");
+
 		case OPTION_STRING:
 		case OPTION_FILENAME:
 		case OPTION_INTEGER:
@@ -543,7 +560,14 @@ static void show_negated_gitcomp(const struct option *opts, int show_all,
 		case OPTION_SET_INT:
 			has_unset_form = 1;
 			break;
-		default:
+		/* special types */
+		case OPTION_GROUP:
+		case OPTION_NUMBER:
+		case OPTION_ALIAS:
+		/* options with no arguments */
+		case OPTION_BITOP:
+		/* options with arguments (usually) */
+		case OPTION_LOWLEVEL_CALLBACK:
 			break;
 		}
 		if (!has_unset_form)
@@ -578,6 +602,8 @@ static int show_gitcomp(const struct option *opts, int show_all)
 			continue;
 
 		switch (opts->type) {
+		case OPTION_END:
+			BUG("unreachable");
 		case OPTION_GROUP:
 			continue;
 		case OPTION_STRING:
@@ -593,7 +619,19 @@ static int show_gitcomp(const struct option *opts, int show_all)
 				break;
 			suffix = "=";
 			break;
-		default:
+		/* special types */
+		case OPTION_NUMBER:
+		case OPTION_ALIAS:
+
+		/* options with no arguments */
+		case OPTION_BIT:
+		case OPTION_NEGBIT:
+		case OPTION_BITOP:
+		case OPTION_COUNTUP:
+		case OPTION_SET_INT:
+
+		/* options with arguments (usually) */
+		case OPTION_LOWLEVEL_CALLBACK:
 			break;
 		}
 		if (opts->flags & PARSE_OPT_COMP_ARG)
diff --git a/parse-options.h b/parse-options.h
index d931300f4d6..a1c7c86ad30 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -264,7 +264,7 @@ struct parse_opt_ctx_t {
 	const char **out;
 	int argc, cpidx, total;
 	const char *opt;
-	int flags;
+	enum parse_opt_flags flags;
 	const char *prefix;
 	const char **alias_groups; /* must be in groups of 3 elements! */
 	struct option *updated_options;
-- 
2.33.0.1374.gc8f4fa74caf

