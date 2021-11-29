Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01700C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhK2WWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhK2WUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:20:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFEBC08EACD
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:18 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so17762440wmj.5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94vz5/T2qwv/A1tDCdkUEbEMnynLu13SjBepaHKfWZ0=;
        b=aHgmLiggK3nMlvYnVHMVpDPXswdAX0EZrdS65tU068Ve8JyT75s4OtZN7UvFSkCxBo
         wzz48hU4X+ls/29aZhr8KHz+E6dxd1KYrAt2vcAlDVDhDpPdR8Ba91Fz9wud9/yTPOrb
         2fOkwL+Ei0ix7iOCh0qSejdvyI9xSwR6OmzA3nT6tK2m7tSwYUFpMjLRmaNKOP4mnkdY
         u4jsmJIBX3Xj4ykal+wJ6uJ3O4BjprrZQYJWaU4rwm3QOGfdngw2Xi8QoW+DmY8kgrPJ
         ppLxCuCPmb5YQKsFKvSww4u0UHLIl/AepxHaC/+N3ih5fqAyr+bYGV3jc3GoiSpYI/Qt
         5Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94vz5/T2qwv/A1tDCdkUEbEMnynLu13SjBepaHKfWZ0=;
        b=Zsu9ccnG+nWsywCiV17lqCaMOvgQRb0OqgD6uVyVECjq5OfriruRzA4Z9rwTfo2WKH
         +yDr+Ek9jHZquHBmc1PpDlgBJAZRItccVidhAc5GFdX3tpTol796QVU3vCaXuhTV7fhV
         chy7V21DJRWVuQLc4Y1w7bXVWYonUtSlE1SJtYf2hJHgs+l8+TqAAhGxVsOeEwm3v68K
         KfTfB0WRcg3psYNxPDbHtdfCfjeXCnW51ka4VUj4ANyzKo6h6+yuZOKLq1cFLYdiQxxI
         VDUSeLqMIFDFzELy27z7gxie9Vb3OEkN5b3hPVUfC8FprzbuwddV4whE8gSPqwECMiKZ
         /sJg==
X-Gm-Message-State: AOAM533YyHsfbRFv0Wvev9jf3ol/s6GuiPFejKkmllJw71gYVUmB23P0
        fufhh42m7+hsP5MNOFIlWaUhMvnQbpN/oA==
X-Google-Smtp-Source: ABdhPJxtD/oTf5H6+5z+SkmB9EDqLsTxC2dVfvpAAGNMykOUtaoeeZAygPRymKYYlbfKwtH/2etgUg==
X-Received: by 2002:a05:600c:3658:: with SMTP id y24mr130550wmq.161.1638215956716;
        Mon, 29 Nov 2021 11:59:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm298200wmq.32.2021.11.29.11.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:59:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/10] parse-options API: add a usage_msg_optf()
Date:   Mon, 29 Nov 2021 20:57:43 +0100
Message-Id: <patch-v3-03.10-69ef1ae48c3-20211129T195357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
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
2.34.1.841.gf15fb7e6f34

