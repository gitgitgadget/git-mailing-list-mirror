Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA453C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4DE6108D
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhKFVtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhKFVtu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:49:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF3C061714
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:47:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u1so19599451wru.13
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGpunmhWTIGblwwNJnqv7uORoqqxob92N9CZAXEsfTo=;
        b=MttYNUy0kg3B5hRiWFNus+PaJIvrt28P9/CT6MegftAb0BYOCFrPCZaFZ+yRnjjFqD
         TWiKnVd3X8mXsx6Wlp8TGw5VHUgxKHHjTwheRvRWJJuA0b5RGYLZ5hmJKhZa8+fN3l3f
         btTIPlFy1JG37Olmxd+yWx2oAAP3Dgp0afWa1VXPZv0DSUtbqJ6EAqKNewRUvuSIQF6j
         KOm4tmG7FG03yupD3xUh2HepgIxkRilUHnA7gZ9SFHdbE+YBzFTBGRdUPH23b5Mak9v8
         eY/7Sc5Kys0pPpGBgKBYJYCzjJ/N0/CDHz48ozZYMygOzWzZ/GLgNK+bAg2wP1X7HgB8
         2+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGpunmhWTIGblwwNJnqv7uORoqqxob92N9CZAXEsfTo=;
        b=WBM6P09Jl/IztrtDOHgXvQAESsE5h5sFj7D+9tmR6K4Yc1vnAh7UsC/nTbJ2bDZac6
         agvXQUbGlMVHabfm6x2+/pReNVO1DJZSRVqMzsl0cbaVI6X44jNeJXHwawH8dQug58Ve
         lqf10B5sDlyOunRDkfmh08BdAS6NXVL8MebtaJKMbudacnLnIq+CtMOl/yxWyrAsBfWf
         tlDKOPo65UrswhUOWab770Niydrs9/Pzz7Y+K6ey3SNvR7hYJAhxfhAYr6KFs+YITG7o
         CQ0WXd7aw1r69+MDGQYLs5Gb8zpzUWJJ6P8/nZmWt5A1POs5jdyTxf2IHCFh9C76gdXd
         +7Eg==
X-Gm-Message-State: AOAM533P1B7dIqpYuxHSxx31RWz2LkEgaoMO5iAPcWq4GUWj05aEDk7P
        KZGc9ygzKTQDQVTZ88f+nQfsfxj2sk5COQ==
X-Google-Smtp-Source: ABdhPJySzKPbiOPHeoVy7W8ZCT/m/kAh6WEvHdo9SoY73+h/Q5nWllILGymKYBrb9Fn4hN3iYylk9A==
X-Received: by 2002:adf:df0b:: with SMTP id y11mr60626674wrl.181.1636235226960;
        Sat, 06 Nov 2021 14:47:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12736630wmq.34.2021.11.06.14.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:47:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] parse-options API: add a usage_msg_optf()
Date:   Sat,  6 Nov 2021 22:46:55 +0100
Message-Id: <patch-03.10-5d87897f49c-20211106T214259Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
References: <xmqqlf33i36a.fsf@gitster.g> <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a usage_msg_optf() as a shorthand for the sort of
usage_msg_opt(xstrfmt(...)) used in builtin/stash.c. I'll make more
use of this function in builtin/cat-file.c shortly.

The disconnect between the "..." and "fmt" is a bit unusual, but it
works just fine and this keeps it consistent with usage_msg_opt(),
i.e. a caller of it can be moved to usage_msg_optf() and not have to
have its arguments re-arranged.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/stash.c |  4 ++--
 parse-options.c | 13 +++++++++++++
 parse-options.h | 10 ++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index a0ccc8654df..e27ade3e821 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1749,8 +1749,8 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	else if (!strcmp(argv[0], "save"))
 		return !!save_stash(argc, argv, prefix);
 	else if (*argv[0] != '-')
-		usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
-			      git_stash_usage, options);
+		usage_msg_optf(_("unknown subcommand: %s"),
+			       git_stash_usage, options, argv[0]);
 
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
diff --git a/parse-options.c b/parse-options.c
index 9a0484c8831..3a8e46be255 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1078,3 +1078,16 @@ void NORETURN usage_msg_opt(const char *msg,
 	fprintf(stderr, "fatal: %s\n\n", msg);
 	usage_with_options(usagestr, options);
 }
+
+void NORETURN usage_msg_optf(const char * const fmt,
+			     const char * const *usagestr,
+			     const struct option *options, ...)
+{
+	struct strbuf msg = STRBUF_INIT;
+	va_list ap;
+	va_start(ap, options);
+	strbuf_vaddf(&msg, fmt, ap);
+	va_end(ap);
+
+	usage_msg_opt(msg.buf, usagestr, options);
+}
diff --git a/parse-options.h b/parse-options.h
index bdea052c399..cd1ef584166 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -226,6 +226,16 @@ NORETURN void usage_msg_opt(const char *msg,
 			    const char * const *usagestr,
 			    const struct option *options);
 
+/**
+ * usage_msg_optf() is like usage_msg_opt() except that the first
+ * argument is a format string, and optional format arguments follow
+ * after the 3rd option.
+ */
+__attribute__((format (printf,1,4)))
+void NORETURN usage_msg_optf(const char *fmt,
+			     const char * const *usagestr,
+			     const struct option *options, ...);
+
 /*
  * Use these assertions for callbacks that expect to be called with NONEG and
  * NOARG respectively, and do not otherwise handle the "unset" and "arg"
-- 
2.34.0.rc1.741.gab7bfd97031

