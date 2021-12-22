Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C063C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbhLVENO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhLVENL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:13:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F82EC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s1so2142905wrg.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4ISCfFEc1GwFrOlR+4+db2zBJd7iFNhw/iaW4++Gw4=;
        b=je/Z/hZ7zSxgoOAB44iqQnQszUDCgMp+7PkA3WC6LGtKpSMbCfkTHFXkROc+hEpJbj
         oxvpOZwE14o+SQ7v46G3B2uz+7k/7YExPxqV523RBY/kPXNNgL+vGA9YgMTb8vLXchZ3
         HGH6OOQv0AbT0q2lxattwGhK5WeUCiQGAqDemnMG2f3g7CNdDjedSapoEsZx4+Qj6JWK
         nfOy2njasuMJaS2Ii0el1/2th41chq0lLX35jv7Y8tVL1V3nIpqD+EWPoxU3Blnndcqb
         8PzeJKkWXziMKHNJVYPJNV8IHmbpAijZWK8aD9mf7SywOT38+Pk+6PRhwamHRtwg36ra
         x2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4ISCfFEc1GwFrOlR+4+db2zBJd7iFNhw/iaW4++Gw4=;
        b=uTeacuO1tMIlMeIbMTNzfNcCLq7Kf5CY9RAwNu7ss5AvGw86hSxB3WAPSYHy9KqrXJ
         VKNWzPrC+fnUhh82OhjaD5zvhmMeK2e9YnvU3xJGPzZNm3imOSpBhzlYnZt/pOAp24Iu
         wQDiORdXWlq/pVxJJqHWz9lNbOnwHLHM2ZHjuh616b9hS6gE00lI1psBrPjE8A9i/pw2
         4/xotlgLVednpRPlSSZbW2gEkMCYHfjpfbd3XGIQ7V0uSMTR2ZqyeBFXL+8fybQ+/p9x
         6Cp14RgQZ22c4MmhR2pC/vprFA8fd9mskhgXWGQf/Ud9d7EVFKzhNfXVXbW5ugLduQDM
         oTQA==
X-Gm-Message-State: AOAM532CFlJjqyZ/EHmQbE7zhDZHMzv82NsKkOBQCbeUS7HxGlicM1jB
        RQOojIj4DM45rkBS8GqYysVaGCd4v98aSw==
X-Google-Smtp-Source: ABdhPJzUQpi/7X/olLWB9XSrS5fnVuz2A7VObzOvFf4PGQuKV0RKeH4mTy1uoNU5HHsQUpLCoAIpUg==
X-Received: by 2002:adf:c186:: with SMTP id x6mr769233wre.580.1640146389316;
        Tue, 21 Dec 2021 20:13:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm749650wrd.92.2021.12.21.20.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:13:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/10] parse-options API: add a usage_msg_optf()
Date:   Wed, 22 Dec 2021 05:12:56 +0100
Message-Id: <patch-v5-03.10-0689dbb248c-20211222T041050Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
References: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
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
2.34.1.1146.gb52885e7c44

