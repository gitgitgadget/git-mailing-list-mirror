Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F79FC43217
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhL1N27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhL1N25 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:28:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D2BC06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s1so38473768wrg.1
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LGaMDqcMu/jgfRshxKhIMOBax4KNk51FgqRzXtMmQUY=;
        b=NgiIIWxZBVEUztNhJ9LoZlJ5IKbmz5g69MzG7PJ0Yhk6ljH0AGQF9Qi61spZzzWed0
         ubwKz7GMuL0XHT307tR2HeMjSuj8FCZiAHpKRs91MKo7wIwjlJ1E3krrVHRIWHQE9W1K
         ZjMlTnz3GkE5foFw6RNowne7DQwIUJG/wMhg/Seu0r7QTEe/2/r3qThCaaDRhN6sGQmo
         2Im+U4EVWA39xNzFd/ITzO4W0U7f/oDpaTvyh7tQ7muh+Qc/ftd/fydQzfHkd2hH8NKh
         0NtdU5kqR08ur9wiv86fKFza/9xHd1jcMChSwYLhmuS24/5JN64OBFSDDf7e+Ei4rFrs
         xk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGaMDqcMu/jgfRshxKhIMOBax4KNk51FgqRzXtMmQUY=;
        b=SQzQtYEPoOGnijL38EoA4TNsG91p4oyxqkwrtPv+Ur6K3H/SXSRMo+JpSmsSsHnplz
         9gaZPOXyRzmi6Mn2jgYM9OQ9meCyHbbvX2fYta2xu7oWqwffYH75DaoH/EUGY5evzEcA
         abbqKOPrwtnX56TjHGry1g/hAi/ZFhUZ1B0GpXFVJTsbDygcfKpd+pXDaq/IIVyzVL9L
         u4opn11n2A9FDESsHUMnZgTOy9wC8VOxky/TjO8/J1b6lu5JsLhJ8F/fdRq/iqhxy47i
         B+gKgw6rQ41mgklh0GVZFJUS7w0esfrDxEp8C6HJhPE0QcOuRwJ+eOpiGqKhjeYcW29/
         mFYw==
X-Gm-Message-State: AOAM530CQBSN9iSyN0RWIVp1Iw/W5WdCTAxdXt2IDWmhvbmzCzcxQOfx
        JyLgouAZsPgUlACenJII9pebnnKS7iQoy4Sz
X-Google-Smtp-Source: ABdhPJxpuruCwThxRR14ZfOrem6OhgPyRb8gp/b9bv2mzL7jzv0hNEMsuomnOwqubI3nDZqOA92MzQ==
X-Received: by 2002:adf:ea84:: with SMTP id s4mr2606616wrm.546.1640698135288;
        Tue, 28 Dec 2021 05:28:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11sm19695868wri.101.2021.12.28.05.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:28:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 03/10] parse-options API: add a usage_msg_optf()
Date:   Tue, 28 Dec 2021 14:28:43 +0100
Message-Id: <patch-v6-03.10-ff717088a28-20211228T132637Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com> <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
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
index 18c812bbe03..c9a09047a6e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1811,8 +1811,8 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
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
index 629e7963497..c01f0040368 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1079,3 +1079,16 @@ void NORETURN usage_msg_opt(const char *msg,
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
2.34.1.1257.g2af47340c7b

