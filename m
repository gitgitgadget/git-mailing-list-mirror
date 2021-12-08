Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6315AC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhLHMiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhLHMiD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:38:03 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75F3C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 04:34:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so3768574wru.13
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 04:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=onxQfEFprRIOizBehiT3izRpZuqKe7yexADBfyvk/Go=;
        b=Y6q6E1elZ67RCnmQiBsWF4GlefW5RQZJ9dUBu/WUL9762KY6nOD65jmrfEdFew7OUr
         uNfVg+sXeZI7rehl0h+zEPuSX/aAWzAj+6VqC39y8jfq3ANA4M52KApCqOGcfm/zrX0H
         AHSMv6IwG/lfYlxT1KUwQFvecBPN79NnuVO5pRPT/H17tgo18vxRdjYxeymhWaeMLZGW
         ayCxZC9tbMxaAeFL3qWH8oK0uxqvB/2Nm8ft3Au+aMPvM2DAJOGDvaJePDWyhjE6yGC9
         tvB8iuUYT91VTpFqoOLoqjLEWbqKbQZczgHZ+LcEgTK2ObY+epb54t+AG3M/9LxDLXhR
         X2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=onxQfEFprRIOizBehiT3izRpZuqKe7yexADBfyvk/Go=;
        b=C/yBKk5VrcF36GbI3t3lKrwyjBrP+UQeeVTC49MH/1jN3ARdOhw9Nr0uVaU24G+Tei
         UoBjLtfrdksIGe2R5xAgDtEpXz7ONCt047wODMt+wq3OsVMHfkLpDrqLXRcMy1w5HepQ
         BVjUS0gY5+HecN3adnQWWbKgXwTPoV587lNiqXPmIQSZ1EWPPVMEz5Q4xeSI3sFgYrx4
         4Wk9LTAfIJDCJ3hazH+NcTjOn/7uZGqDGsA97dyg4n4ojr9gg3nMUUYJlJScyPSnjRot
         n6409865wArWKq/CjNn2s3UF55h67vVgADcSwUEpT8uuQGOUmLzubB/qK7ovxL+LB7EP
         eXtw==
X-Gm-Message-State: AOAM530IlvSMHhgJGo9dnpcrqhHC/q3N6UEs9h+ChZQMJx39wn0FYgnY
        Mr1Bt0pZ9QCfdjuvuoFSrtHEDaiJ7eQVeg==
X-Google-Smtp-Source: ABdhPJyfF5jxtvc0uMnqWLIDDD1DOVxcyKIRiuIM8Wrf4COelCb9VZT+rwhSUiv4YbYhdub4LFiFaw==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr58329966wrs.270.1638966869008;
        Wed, 08 Dec 2021 04:34:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2540692wrm.76.2021.12.08.04.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:34:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/10] parse-options API: add a usage_msg_optf()
Date:   Wed,  8 Dec 2021 13:34:16 +0100
Message-Id: <patch-v4-03.10-01de6e4305f-20211208T123151Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.926.g895e15e0c0c
In-Reply-To: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
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
2.34.1.926.g895e15e0c0c

