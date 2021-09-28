Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C634FC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B072C61139
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbhI1NQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240688AbhI1NQW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7F8C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b192so3466566wmb.2
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFnRPV4NL/Qy/7LGTomKuAfgVNv7KKElg2mHDO8c+kY=;
        b=O2nEFahmjrJeVQ+yeTEaJu1mZYZcmOmi1OaAz6YELBQ3S57hO/Q4WWK6DAh+OY2BVO
         +130lsv260/4Ri2LKkcqwgIJ8cYAQ2ZmWWzvaETP9w4BiULHS8AWFPSIKDs8AF1sW34C
         R6hS0MLyzgjB+R/sTSlpUD7Oh23dSpgVJSHckH2pZJVVn3PZ5j4UK9twMOeTaXWRlNvv
         l+1fr6+zExd4KwlfxP6oqMcfQ8k56TKWvdP16o9Tms+ZwVUYCWIvMrSXCh6UQewo0S/M
         xncIRBg0eeZyaa/99ID/5VmlqKjmn8VO7OVeGKJtNYukTClwzmBfzNMOzCB9ocneWOQy
         eH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFnRPV4NL/Qy/7LGTomKuAfgVNv7KKElg2mHDO8c+kY=;
        b=c2Qx33lZiaShJPseJeg9FKhuGWfkd+P9RJIei55Mi58pWxFJcw4etZ4/1b3UvOSUTT
         UpwB/3qofaz8OgvL/MPBUg37M3hgzQD9irc96KXV6oyj6PU4rR89exXLh0FayrQJ9WDW
         +uXEJUQXgjwR4CdsPwWns7BlTVKG6nfb3zNeVK7v8RlIFvRng7AWdPKjStmET25GBEKC
         a5+OtwLfSzCvhKWQlFXPp+7aJQf07mahwNIvDdZqfYeltfx0UVvxnto2Ef2Htd9RpiCV
         TG8eptWjIt/m4bDc49JkBj4M//MNMXANr3BjEl+X874Jha3wg5thfHVEaO0qqeN25pVv
         YBsw==
X-Gm-Message-State: AOAM5325mMQ0UU/gBb+/YADzBGEI2qd534l4fW5JQhzGlDMMVgapmGbQ
        dD5jn4X5bhWP7cH32AhxDm4tTgIJ0BjwTQ==
X-Google-Smtp-Source: ABdhPJwAaVF06w8k7vZSur8MVwcSzSXwJNHadwWAG62dkP6JLIPnICUweNMvBDt7fPet72wY5vS+uQ==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr4657237wmi.86.1632834881304;
        Tue, 28 Sep 2021 06:14:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm2617981wmh.31.2021.09.28.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:14:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] parse-options.c: move optname() earlier in the file
Date:   Tue, 28 Sep 2021 15:14:27 +0200
Message-Id: <patch-06.10-c065f7d7362-20210928T130905Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1339.g53eae12fb46
In-Reply-To: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
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
index 733cbfa8821..238a283db5d 100644
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
@@ -1037,18 +1052,3 @@ void NORETURN usage_msg_opt(const char *msg,
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
2.33.0.1340.ge9f77250f2b

