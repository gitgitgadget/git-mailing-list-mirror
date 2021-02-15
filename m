Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F60C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267C464DDA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhBOPrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhBOPp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4C1C061794
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id a132so171450wmc.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOUQxhcdhCaGf/O5jFWwCNwL+C49UskrpGE3NVYUJM4=;
        b=fTxSb4NsmkIljgPOHw4cy7YkqD4edGCs0o1bmj+dbAuYghpV64JgDLTC0Wc0HN4FHz
         /K3TYHOuefIAAB4Fp70F53UaKGSW/LcqTZZwHUgoS9icJxLQ2fNZnwPGI+zMe5nZQ5ha
         2Vhr90Z00iuBjrtb8HU4WSOyQSvlVnbS1JheuQuunqkJ42V6a6UYK30aaHEsYkKYm5s+
         MLaYNsl0Ns+Zxn2O5maVLGWERnObP4wopAoeptY8bFa6yj9n7wclrXnJOzH/u9IOb9DC
         Q9mhk1P3oUtss2uredhtAi/RMmF++llkIFVgNOE320M/Iwy+FMlK7LzLeuGSHTHMj8r4
         3Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOUQxhcdhCaGf/O5jFWwCNwL+C49UskrpGE3NVYUJM4=;
        b=LHbs5Q8+T0pnjI60wcU3PWmZT7LgP8xVoPEsC7MfJ0aWuIEqbSK9I+XMGtZ2MJYp3N
         Z5/Hl9CpFhu5PLJeUCcTQvsRrH2BWvNyjIuYVxt/fepfximtKc0f4m6z87dZg3IUiA1a
         SRWB7dIcUU48vJ+tuGBKaftrsygIZuZe/apkfqZTqrpJv8e9DUH5K8leZXcNS8ckxNCj
         plyoTB9kLEufxbt/K2m/NrS6nrvbFWTdh2YNxL6bSZrpeQC2TJqc2v09z0Nf+qtsMrqE
         nfnlYEQ466waHcvgyvApgl52dK8hS/FjqMLyE53Y2TfuDbb5JZ+lyq0kInOz978lB4To
         fbiA==
X-Gm-Message-State: AOAM530E5j049PoMn8AM8if+wKCvCFUo8H1mq8cP+j6r5tCiUDigJHvn
        /ChSmp4ecTOUUOijPvWhUijf/6PFhrQ4QA==
X-Google-Smtp-Source: ABdhPJw093lpKK0d930jvMx+DM277GcEpnjbkEmEnlFm8yG3cmuGL/2OuRcC5Xdnn/GFPKY8dExL4g==
X-Received: by 2002:a05:600c:33a7:: with SMTP id o39mr14915510wmp.10.1613403886148;
        Mon, 15 Feb 2021 07:44:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/27] userdiff: refactor away the parse_bool() function
Date:   Mon, 15 Feb 2021 16:44:01 +0100
Message-Id: <20210215154427.32693-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 6680a0874f (drop odd return value semantics from
userdiff_config, 2012-02-07) we have not cared about the return values
of parse_tristate() or git_config_bool() v.s. falling through in
userdiff_config(), so let's do so in those cases to make the code
easier to read.

Having a wrapper function for git_config_bool() dates back to
d9bae1a178 (diff: cache textconv output, 2010-04-01) and
122aa6f9c0 (diff: introduce diff.<driver>.binary, 2008-10-05), both of
which predated the change in 6680a0874f which made their return values
redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 userdiff.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 3f81a2261c..c147bcbb17 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -275,19 +275,12 @@ static int parse_funcname(struct userdiff_funcname *f, const char *k,
 	return 0;
 }
 
-static int parse_tristate(int *b, const char *k, const char *v)
+static void parse_tristate(int *b, const char *k, const char *v)
 {
 	if (v && !strcasecmp(v, "auto"))
 		*b = -1;
 	else
 		*b = git_config_bool(k, v);
-	return 0;
-}
-
-static int parse_bool(int *b, const char *k, const char *v)
-{
-	*b = git_config_bool(k, v);
-	return 0;
 }
 
 int userdiff_config(const char *k, const char *v)
@@ -312,16 +305,17 @@ int userdiff_config(const char *k, const char *v)
 		return parse_funcname(&drv->funcname, k, v, 0);
 	if (!strcmp(type, "xfuncname"))
 		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
-	if (!strcmp(type, "binary"))
-		return parse_tristate(&drv->binary, k, v);
 	if (!strcmp(type, "command"))
 		return git_config_string(&drv->external, k, v);
 	if (!strcmp(type, "textconv"))
 		return git_config_string(&drv->textconv, k, v);
-	if (!strcmp(type, "cachetextconv"))
-		return parse_bool(&drv->textconv_want_cache, k, v);
 	if (!strcmp(type, "wordregex"))
 		return git_config_string(&drv->word_regex, k, v);
+	/* Don't care about the parse errors for these, fallthrough */
+	if (!strcmp(type, "cachetextconv"))
+		drv->textconv_want_cache = git_config_bool(k, v);
+	if (!strcmp(type, "binary"))
+		parse_tristate(&drv->binary, k, v);
 
 	return 0;
 }
-- 
2.30.0.284.gd98b1dd5eaa7

