Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E55AC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1518960F6E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbhJHTK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhJHTJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:09:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E1C061766
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:07:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o20so32571980wro.3
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGwGO7cbz8PSOPTEr6z7+Rtm6ZchfBTB4hsKgYPyY1k=;
        b=Hq6qCu8QpqPtO6WlibeoZfvE41OGfoKwajhxJVbfrbYynlTXTJOtg5EaW47g6ODhhk
         ByO7dSzt6uEhtRJ6RumJlMx05c8DftZUCnhg/sc2yrIGWWQ/OXlBkWjMgmeMMoI5Pqm3
         XWn2O3Pd+4nLg5v8iE0gdSEqxr2DPt1KrWyTopKEklbFV8gS3FjQvtaMMi0oUuOgt7RD
         FpElvqzX+VQikwnAJZvhx+YAl76W6mg+S5u8i6cV6fFbWHU/zrZmykLsNLXOqnK2DXJ3
         ETm4UPX/NXGCFbM2wKfcxPGJTujnH1jBRgmBYHAKRe+DfLuBOrp62RhjwgiFe6mD4Iea
         U6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGwGO7cbz8PSOPTEr6z7+Rtm6ZchfBTB4hsKgYPyY1k=;
        b=66WNC72/mcLxkXWXUYWM/TDvLJs5beQOprCM6CQ5UpFMjk6g0jqPmQsZjvqxYr0k8I
         PYW+57DXS3yCyFBGhhdVNq/bSbY3VUpMZVzWy78SP36IZZrcXc/Qfpy32mg8CXc4z1ST
         aYt3hi2G9NsCIewfDNTSf4bAgq/5oVoG9rsfne9nYEnOuEsx3TE2CKosyJx0ufe7z1Fi
         l7SszkoTMkbg83qON43Shj/RK+5vTIE0FXC5tcKLSKU4J4zV5H7IuKfUsjO09wvTDgga
         DMQw/PsgScA/AQRoKdb9qPWVLLIYCjX4ft8rtiDkSz8+pRP6bMODzDr6+7tPram594qE
         skaw==
X-Gm-Message-State: AOAM532q8bg6Qmb63IVkiMxnltBP1NDnzAdFVwTdO9Hu2PIwFyo8pxwe
        l+kuAC1sYdMuVxEv+UDuIzwP9DXAe+9bJA==
X-Google-Smtp-Source: ABdhPJwrQQwntAwg7IN36bw8pUx6VTxNXHtRFWbN5t2c+whWu4J3hgeUnOMMUUH4gW2rUmH7gCViXw==
X-Received: by 2002:a5d:47c3:: with SMTP id o3mr6360768wrc.25.1633720073601;
        Fri, 08 Oct 2021 12:07:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm169882wrc.51.2021.10.08.12.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:07:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/10] parse-options.c: move optname() earlier in the file
Date:   Fri,  8 Oct 2021 21:07:42 +0200
Message-Id: <patch-v3-06.10-7afdb22885d-20211008T190536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for making "optname" a static function move it above
its first user in parse-options.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e33700d6e71..9e2da8383d7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -22,6 +22,21 @@ int optbug(const struct option *opt, const char *reason)
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
+const char *optname(const struct option *opt, int flags)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	strbuf_reset(&sb);
+	if (flags & OPT_SHORT)
+		strbuf_addf(&sb, "switch `%c'", opt->short_name);
+	else if (flags & OPT_UNSET)
+		strbuf_addf(&sb, "option `no-%s'", opt->long_name);
+	else
+		strbuf_addf(&sb, "option `%s'", opt->long_name);
+
+	return sb.buf;
+}
+
 static enum parse_opt_result get_arg(struct parse_opt_ctx_t *p,
 				     const struct option *opt,
 				     int flags, const char **arg)
@@ -1006,18 +1021,3 @@ void NORETURN usage_msg_opt(const char *msg,
 	fprintf(stderr, "fatal: %s\n\n", msg);
 	usage_with_options(usagestr, options);
 }
-
-const char *optname(const struct option *opt, int flags)
-{
-	static struct strbuf sb = STRBUF_INIT;
-
-	strbuf_reset(&sb);
-	if (flags & OPT_SHORT)
-		strbuf_addf(&sb, "switch `%c'", opt->short_name);
-	else if (flags & OPT_UNSET)
-		strbuf_addf(&sb, "option `no-%s'", opt->long_name);
-	else
-		strbuf_addf(&sb, "option `%s'", opt->long_name);
-
-	return sb.buf;
-}
-- 
2.33.0.1446.g6af949f83bd

