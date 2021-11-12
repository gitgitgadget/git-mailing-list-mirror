Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C119CC4332F
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D7F60F6B
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhKLWXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhKLWXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:23:46 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7FEC0613F5
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d5so18010087wrc.1
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUtpVkTihhIO+W0Zo2AJHpQQVxaX+TR24sRDwYHdx1A=;
        b=ic/0mu++YTkPYCmLXN+9Bhq+oRbj93At1H7kMjnI0J36f23nmNywJv+f/gdSzFd51r
         Of+CUsP9RJlwOwa7F3ImcjEuDux8aK/2gZN3SgFgOncMeXxmhNQ//PWS+t4PgKhlrcvS
         rVscIYv6DnCOBgSt6cVMB9bOIdZj3CmyzT3MWeHxYxChYOOdfdpEOVFuL7xeJgJsjsX4
         P9wgSxjRcwwT+f7b6JfGZifsadspRWrk/fKl+Bpm85n6f4ELHBmdyJTL8phNLbbSdlvP
         6WO4hAawGjl3VtrHa1qpdix7WGfkQfKOjxzab4tywasDNsKah0JFzZxLtNKAy3A13T+F
         EWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUtpVkTihhIO+W0Zo2AJHpQQVxaX+TR24sRDwYHdx1A=;
        b=igzprZxKLa88iZ4Mcm5qG5dGdfqDWFeD9CVOtPTiuB7vGIRtSI5cffemW/+ptqMoxT
         i6u6HVlyuc/rKuLWAejhmQF41v8eU1myNz2F99ggg+CZavywH+H5XaaduppTigbg+eYR
         k9B/WoO6NEHkqVwRJXlfEOPXZgf2oryrYssDRotL/ZtgFDge5iLzs3NgDHqyt4F+KQmq
         XvXLeL5/rt921ueq9Oa/+ZCFvFJlUK3y2i4DkOaZDGFys0YqFQsztSvtemxW1uCrS5eO
         1fFRctQhea8xfPukqhGefCnWG5LIUV8PhmfWtAjwPCR7vGGYvr7qozCksO/xIbD0DPpl
         t8tA==
X-Gm-Message-State: AOAM531ohPJUe1Bk5QQoUTnVLQt+jMZ8pcR8RqKAzuFhNM4eQIzC3L0p
        pOdfysiIlBh9H7Jff5BrYI0qVzYSCt22Yg==
X-Google-Smtp-Source: ABdhPJxzvwfZWUDvp7qY1ML9iHYKMCAK0CT7tZqga45G8YL2Y8B+m5XrzVPJyTJbZkA6ULtyfyWhVg==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr22597860wrw.166.1636755653766;
        Fri, 12 Nov 2021 14:20:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7sm7896985wri.74.2021.11.12.14.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:20:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] parse-options API: add a usage_msg_optf()
Date:   Fri, 12 Nov 2021 23:20:01 +0100
Message-Id: <patch-v2-03.10-0e2e5ab9d2d-20211112T221506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
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
index fc5b43ff0b2..5a319dda7d5 100644
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
index 275fb440818..4a9fa8a84d7 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -225,6 +225,16 @@ NORETURN void usage_msg_opt(const char *msg,
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
2.34.0.rc2.795.g926201d1cc8

