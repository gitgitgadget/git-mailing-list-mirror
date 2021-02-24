Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF0BC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F8A64F06
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhBXTwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhBXTwf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:52:35 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92889C06174A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:54 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w11so3025969wrr.10
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Rvh4hAsuNIY5q8/Hrg8zm9NG8tGeOydExh1lmkMrio=;
        b=XoL7Ip0oeGTWYJJAJPCcuMoej5a8y1WSTL4tQcpQkqE4lxRrFp/UvOErdhJvrOqAsz
         xH0VaKVADZW4dAI6sYdcz5ViwvhtfCf9IinZxvBhXfG6MqW2Pu+aFRdrHrOOCKNrTWXc
         15I6Ny8IVOhJyG3zpmrnDR7iAeNZbW80kMJ5oawuasN+R3rAgeB/1RQX0CxNZsiuUX11
         hpYia6Q6ado4xU4AlDucnbMClX8QppXrev7FaMLiua1VPmwUgTu0DiV50JXc/nLUcKse
         SbZvn3BMt/flb2Xq+8/fKepaEybLq4ytzJIiTYMgVWzkRI894EKsy8H+xKEs0qjuu9IF
         G8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Rvh4hAsuNIY5q8/Hrg8zm9NG8tGeOydExh1lmkMrio=;
        b=DGrsAnkG8MA0X3oVcirzIXtoFBNZiy6WQwluDd1r7FmbXh7RbLQU0dAIsKjttsbUD2
         GBgYS+8dJwsSVheExLvKHY/t8SuYIa6kn4NlrS1ON+TO3II7R+tEjXSOgRGJpP1xT/vE
         LOD0vE4lxx/0S6IwGja+qoXatNpzObNIZ9KzSWvyaUDb4pWhSfjmIxWOeHHFoxlaPMwC
         m3rDfseCmQQrnEwX0LQpodgtWCxfgawZdMts/Xk16CBEUID+gD6oqZajHnpUxIVmpjyP
         t/vJaWBXsGpGa69lZ8oseD53SSHRk8epdC4yYrLSW2pWfDZhOPrC//xUYqprxU1w4ahI
         61yQ==
X-Gm-Message-State: AOAM5331sClsiz5V2yfnJqkSnPPRjT+WbuZKUffwiAJYooBJkAOfIkv3
        M3+rgLpFaoIQy8KHpQlzZ7/sQDKhq2HZ4g==
X-Google-Smtp-Source: ABdhPJw91/4csQ7TBRAfctvfiL1KAwjoNo7OBgXVO3GBzcyq0c7I/mtVenREfVnvLmgRTc/Pyk8ayg==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr13519730wrt.370.1614196312994;
        Wed, 24 Feb 2021 11:51:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:51:52 -0800 (PST)
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
Subject: [PATCH v3 01/35] userdiff: refactor away the parse_bool() function
Date:   Wed, 24 Feb 2021 20:50:55 +0100
Message-Id: <20210224195129.4004-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
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
2.30.0.284.gd98b1dd5eaa7

