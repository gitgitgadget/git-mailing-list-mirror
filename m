Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2B31F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 18:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfKMSzm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 13:55:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44278 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfKMSzm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 13:55:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id g3so3761351ljl.11
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lSMbK8DbBv6LFG6/5tYxZtgJWUWauZdxGnoUHUnrV/A=;
        b=FW2Z6bnznmnqyMslA2neCtQXZ+Bo4+F370nJRQQZ39dHdp2VONS9oTOMW8lX+nM+Gt
         1ou6bFz2Pkl3nrJKsmm2+zxUjB+3SsaVztTsiduNdjvoYIsitis8pAhsgfNjrHMMJ+tV
         p9QYYHjJMmYFKvjfpcRFxY5nclBbI1Rh44tRXx3r/ex1y/lMiPu1D2mjNr3lXD3EmwIQ
         MDOr8m9rNcwUEMWoxie4TdowHc3EXihSdQo3z0jn1cnIA/y0HK7ylybktu1l2IHRAXOs
         W1oXctDV2Y6zVQ53oax0Q2kZEh0aQoavWNC7rCZc+J6t375F3ZVTWqdIqw6dkAF2fBAw
         MxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSMbK8DbBv6LFG6/5tYxZtgJWUWauZdxGnoUHUnrV/A=;
        b=GeKNwGeX1AJhucYmOj6r6hFAThZ00ePPmJMsUvn4x2AhGcGCS/8VWEKGEvng7mylks
         DxW6/Nl0ADmLw7C+2tJQ30Qr/0UhAXp1ZvdgE+mJLICyux1B82VN9EOtkigI6VPE0MHe
         JAIRl7iABGUeDA4lr0o0e16cMcBQiWEmOesV7yeDYXog71bAM/upVvEoT9tJTBcHopzC
         ZdxeWaCG5k6lShqqzQ0Ad8Ao7sYUHwp0t0bZU9cukHoh+t/9o9ihczLrtAJa7thDftkB
         cYBAC1oWLxU6reP3exbVUF2v2edkxfaA7o+MZPvYeA2R2vqHc5NV++TCjxG/vw5W4CRg
         bsuQ==
X-Gm-Message-State: APjAAAWJOsT26v8+qgdNbIUfZ/LK2Ul4gPXJZAFRwIp/uVlfTCTHBJn4
        9lSUGBakJHE3KgCfRRYpAzZs2C1Z
X-Google-Smtp-Source: APXvYqxzxBHlxc7Qz3g1NWwVbrC4hlhYlLFXWwr+YQ3OyE9sUklfSAwrl4gd4H+2d8wqvqpOEGJNyw==
X-Received: by 2002:a2e:6e15:: with SMTP id j21mr3715421ljc.17.1573671339999;
        Wed, 13 Nov 2019 10:55:39 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c24sm1422765lfm.20.2019.11.13.10.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:55:39 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/8] builtin/config: extract `handle_value_regex()` from `get_value()`
Date:   Wed, 13 Nov 2019 19:55:02 +0100
Message-Id: <c4bcb32299291549d82c0544937a647c5000ad64.1573670565.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1573670565.git.martin.agren@gmail.com>
References: <cover.1573670565.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a self-contained and fairly large chunk of code which will soon
gain a few more lines. Prepare by extracting it into a separate
function.

This whole chunk is wrapped in "if (regex_)" -- rewrite it into an early
return path in the new helper function to reduce indentation.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 I copy the "xmalloc(sizeof(regex_t))" anti-pattern verbatim. We will
 lose it in the next patch.

 builtin/config.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 98d65bc0ad..e675ae0640 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -280,6 +280,28 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 	return format_config(&values->items[values->nr++], key_, value_);
 }
 
+static int handle_value_regex(const char *regex_)
+{
+	if (!regex_) {
+		regexp = NULL;
+		return 0;
+	}
+
+	if (regex_[0] == '!') {
+		do_not_match = 1;
+		regex_++;
+	}
+
+	regexp = (regex_t*)xmalloc(sizeof(regex_t));
+	if (regcomp(regexp, regex_, REG_EXTENDED)) {
+		error(_("invalid pattern: %s"), regex_);
+		FREE_AND_NULL(regexp);
+		return CONFIG_INVALID_PATTERN;
+	}
+
+	return 0;
+}
+
 static int get_value(const char *key_, const char *regex_)
 {
 	int ret = CONFIG_GENERIC_ERROR;
@@ -317,20 +339,9 @@ static int get_value(const char *key_, const char *regex_)
 		}
 	}
 
-	if (regex_) {
-		if (regex_[0] == '!') {
-			do_not_match = 1;
-			regex_++;
-		}
-
-		regexp = (regex_t*)xmalloc(sizeof(regex_t));
-		if (regcomp(regexp, regex_, REG_EXTENDED)) {
-			error(_("invalid pattern: %s"), regex_);
-			FREE_AND_NULL(regexp);
-			ret = CONFIG_INVALID_PATTERN;
-			goto free_strings;
-		}
-	}
+	ret = handle_value_regex(regex_);
+	if (ret)
+		goto free_strings;
 
 	config_with_options(collect_config, &values,
 			    &given_config_source, &config_options);
-- 
2.24.0

