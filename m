Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59476C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB7D61139
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbhI1NQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbhI1NQU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7BDC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so2249944wmq.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lYsVGCBZyb5BeYgYOZ3qFR9LXWcBnJzeMIMOD9Z6XWs=;
        b=AkyktUnFtwwSmzvPxp3H56YKIks8TBKShpb3RAZYNBdBjLlhJgyFSuZuVtua0oFS3V
         iO4n7WNLDWQANQhIchQNjejt75tlnhMgzyOCm5x+QUCHzIHR/LB2Gooh+C9eykvwQrWX
         CL3pONwn1o+d1NXBnrq7zWmVypjfL0FlzQQI6g5eRQbdpVsupzEM4qPzHbp29DHMP5rr
         7Ro2qOdg0EX+zP1ycNIZR11DVLtDE571aOpzcaqksUVgh6OagS6ikOVpuj8WwFiJS6Bn
         q1DUmv7A8fxLOIx+77Qud4COioLhXoKdellbs3NKCw9FmUQLUOe1FQjqA570E/9ashej
         MQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lYsVGCBZyb5BeYgYOZ3qFR9LXWcBnJzeMIMOD9Z6XWs=;
        b=Ha08hxhgjvC2UPdJiz3ie4SBk97pRAdDR0CvLJQDg4vZm4oALHY76V62alBtE51xRm
         waEkpTK8EQ8CfxF8ptYQwpJpRG9IX5BzWn7SM3V7jrphYUziQRREbOBf2LkrpnUzwI14
         qHHWzViBcw6JrnVuZ79yDggVSeLCVMY4CylBWmJcKlZRBZkZGWesSj/QMZV3T+Q9iQI2
         xzmmj/luXJeVLoaMquO2ezBh7rOP47z7qiZcnxMltlSo7BRrAkhP9ihWxJnUntxG6VT8
         IRrGLLNMEC4tPRSpR3BJkKjZ8rEGJC1pvTPveFQr/ahctzryDbn1ent3+2ZGqH7GbH5F
         Abpg==
X-Gm-Message-State: AOAM530NJ+uTrBcgpDvpa4W1OIt/RtvYJYxb/BgSTsSleX/VrCTG6bGg
        ul4lADEyJYMT6BWfoKDbrkbrVDhquMsQpQ==
X-Google-Smtp-Source: ABdhPJx3Kh1e3UYCakzaXXOTMDkxHOS+rgxQ9FHkrtcFSej+b3JDQTORw8PPQvCbyKEv1S62A8TLdg==
X-Received: by 2002:a7b:cb96:: with SMTP id m22mr2005732wmi.127.1632834879726;
        Tue, 28 Sep 2021 06:14:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm2617981wmh.31.2021.09.28.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:14:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] parse-options.c: use exhaustive "case" arms for "enum parse_opt_type"
Date:   Tue, 28 Sep 2021 15:14:25 +0200
Message-Id: <patch-04.10-624a19000e1-20210928T130905Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1339.g53eae12fb46
In-Reply-To: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 parse-options.h |  2 +-
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 799cd884f2b..733cbfa8821 100644
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
@@ -468,8 +473,15 @@ static void parse_options_check(const struct option *opts)
 			BUG("OPT_ALIAS() should not remain at this point. "
 			    "Are you using parse_options_step() directly?\n"
 			    "That case is not supported yet.");
-		default:
-			; /* ok. (usually accepts an argument) */
+
+		case OPTION_BITOP:
+		case OPTION_END:
+		case OPTION_FILENAME:
+		case OPTION_GROUP:
+		case OPTION_INTEGER:
+		case OPTION_MAGNITUDE:
+		case OPTION_STRING:
+			break;
 		}
 		if (opts->argh &&
 		    strcspn(opts->argh, " _") != strlen(opts->argh))
@@ -543,7 +555,15 @@ static void show_negated_gitcomp(const struct option *opts, int show_all,
 		case OPTION_SET_INT:
 			has_unset_form = 1;
 			break;
-		default:
+		/* special types */
+		case OPTION_END:
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
@@ -593,7 +613,20 @@ static int show_gitcomp(const struct option *opts, int show_all)
 				break;
 			suffix = "=";
 			break;
-		default:
+		/* special types */
+		case OPTION_END:
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
2.33.0.1340.ge9f77250f2b

