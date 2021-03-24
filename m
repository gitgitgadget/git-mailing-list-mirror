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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376B3C433E0
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1237E619E8
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhCXBte (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhCXBtR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:49:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB13DC061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so1968442wma.0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJnSQMnh843enh3yUqpHBLuQVn38HOT/pGGhs4YbbUo=;
        b=PNICXLlO1WHpGEp57YvzguvxYCzP9cVuOO7iXlm5wLHmdsSUSEZfi/C5A6azOauyb9
         IEewgnOXLmIIMizKwCMDTcfTDQ7tqk25FeeuKclEM+ujzHi2D0ha20B4S6QioklEGtk1
         G729QRYMxwTNLze6zXcZSW4gGbO18owQgC5HTXdO6cTSNSb+lEyqbV6R7mfTzpZuCIvF
         HZZAWZA8y+G94K5t01ugsDwLkKe+EnwvDt1JHRv/VdneWZkzpHxjNjbev+NlwoQpm27l
         ktAePaH25jijiTzRIIXD5EMJwWiOzC9ueHBmqej4ye7ymt9kCjz2WetPCDGTKdPhGJLv
         iQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJnSQMnh843enh3yUqpHBLuQVn38HOT/pGGhs4YbbUo=;
        b=OJkdbMQcto6d1fq4rNAhTb5S0q8mMHiaYjQUczK1AoHiY9ddUJxaw6sfEggiTFrWWX
         RK9Jc/QR9D51Seb2DEnE7XutVg4tpINZi+l9hJCoBxGst1aWXlJGx2DRV0JLaj/nty9z
         YZaUKdx50FAYWL6273jIkbKbe7sZyfd9mXyznzm94qQbYeh8WOikxuC97IAXGAfftMeY
         6pQTlfW2umolLH+EOewml4kI85arc9veoec4htTZo3Vgoy1ROBY3liL8tRERV7jFLPhg
         OXv5ewZ8L8jqs0Va1TjcBI9JjGgOojSHCC5x3lzr1UQ+aYe3ppTKhxfvIdYARB1QOMeh
         DovQ==
X-Gm-Message-State: AOAM531vhsXcKbq/TMJaIrHcTuV9khknTJ7uVXVo1IcWwpKYWhH5Xpk3
        exR9xWkz61uliDiDOq5Rvb5u/hLmHNde/Q==
X-Google-Smtp-Source: ABdhPJzL9xn7J0kBF6ffnm2vkUo9aMh+2vYm/ZdpzMVNJldro6D05lv9JUX6ugtMKlJtXBPW2QJjPw==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr562262wme.161.1616550555118;
        Tue, 23 Mar 2021 18:49:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y205sm598177wmc.18.2021.03.23.18.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:49:14 -0700 (PDT)
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
Subject: [PATCH v4 01/10] userdiff: refactor away the parse_bool() function
Date:   Wed, 24 Mar 2021 02:48:43 +0100
Message-Id: <patch-01.11-fb7346cd296-20210324T014604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com> <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
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
index 3f81a2261c5..c147bcbb173 100644
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
2.31.0.366.ga80606b22c1

