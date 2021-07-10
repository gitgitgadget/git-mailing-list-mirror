Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93077C07E9C
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70729613DC
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhGJIu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 04:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhGJIuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 04:50:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC12C0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g16so5758687wrw.5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zLzh59lo/9mZWxlXTxFEQ0OqCizOyNlXbQoacA/pCU=;
        b=X4jYO6lgakQRTUe32XJQNEibgPfNc2s8wj/tSKtcKrMG26fjrqBOHXNRcVD63GC8PI
         7ABjej6fmLj4h86BdjM/AQ7svVfNbFf9Yk9tntDdjSWfAhRnkgQKzr4q2pCzCiJs/BOx
         VntLdw6j+1q/VrBPyWfN29KNtiD1jhIRLbkDq/eWkYtSZ+nKIT4QhQ13VFR/gyNBMrno
         0Eq+sNs8JpmtWCxMZI+T+dk4n1sfhsRikj4jIzM3ZMaVF0CwSoAGAIxZiuW8G6E+PKGD
         vSJMrgQQyJU/ur+n00CTgz6CSdRf3H4smdL2SJLD5whtI2j6FKLPpvt+BZNzNerqBnbT
         csog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zLzh59lo/9mZWxlXTxFEQ0OqCizOyNlXbQoacA/pCU=;
        b=nOBsNACTFFWHlNjsU4GSf8lLHhteHCUVjLSkjPbaCLbSD3pnd1Ne8Oh8D+eDY+n2yG
         NzTLyRd7FXw/dfAYZ+2rbHV17Tme3MFo62r1TmeF19nfEMxQsIC2e5SwMSbww5xJGYqI
         PLM+7S4p2ax7Sg0yfqk7IqpzYLRGzNuGD2ijQXvCqdGilit7nQjI063TMDPa4a9aOFUF
         XcQ7vW2bgkJPJLW1v8nDIB5us+aUB8S8IsgecMtDRQCW3FC99SceLV9Qzpc1k4qSgDB6
         ozuGyHDhR0ifpPLFu3T+z2J2yo25X3Uaq0sTFWPLfltvtvqGjgULNflccPb8SaghOu2t
         x9dw==
X-Gm-Message-State: AOAM531f9kDzaniCI+Qkum8BYVjVobyVbSMRo6uYOqh7ha5HegR8IqWe
        KxSu0UcMFWIOH3fo152oSW1qUUfViwO+xg==
X-Google-Smtp-Source: ABdhPJwKB5X9UssOYbqfbm4YSOILiwPi+7ABb9EU4qxC9TWwD5i+jr2h4Jf2TpmjuG8ahTo1g8gAIw==
X-Received: by 2002:adf:a183:: with SMTP id u3mr27565103wru.175.1625906858115;
        Sat, 10 Jul 2021 01:47:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm165769wrt.93.2021.07.10.01.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 01:47:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] *.h: add a few missing  __attribute__((format))
Date:   Sat, 10 Jul 2021 10:47:30 +0200
Message-Id: <patch-4.6-3bf8637c16a-20210710T084445Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing format attributes to those function that were missing
them.

In the case of advice_enabled() this revealed a trivial issue
introduced in b3b18d16213 (advice: revamp advise API, 2020-03-02). We
treated the argv[1] as a format string, but did not intend to do
so. Let's use "%s" and pass argv[1] as an argument instead.

For strbuf_addftime() let's add a strftime() format checker. Our
function understands the non-portable %z and %Z, see
c3fbf81a853 (strbuf: let strbuf_addftime handle %z and %Z itself,
2017-06-15).

That might be an issue in theory, but in practice we have existing
codepath that supplies a fixed string to strbuf_addftime(). We're
unlikely to run into the "%z" and "%Z" case at all, since it's used by
date.c and passed via e.g. "git log --date=<format>".

In fact, we had no in-tree user of strbuf_addftime() with an inline
fixed format string at all. A subsequent commit will tweak an existing
one to use the format checking.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.h               | 1 +
 cache.h                | 1 +
 compat/win32/syslog.h  | 1 +
 quote.h                | 1 +
 strbuf.h               | 2 ++
 t/helper/test-advise.c | 2 +-
 6 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/advice.h b/advice.h
index bd26c385d00..9f8ffc73546 100644
--- a/advice.h
+++ b/advice.h
@@ -90,6 +90,7 @@ int advice_enabled(enum advice_type type);
 /**
  * Checks the visibility of the advice before printing.
  */
+__attribute__((format (printf, 2, 3)))
 void advise_if_enabled(enum advice_type type, const char *advice, ...);
 
 int error_resolve_conflict(const char *me);
diff --git a/cache.h b/cache.h
index ba04ff8bd36..f9aed2d45c7 100644
--- a/cache.h
+++ b/cache.h
@@ -1385,6 +1385,7 @@ enum get_oid_result {
 };
 
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
+__attribute__((format (printf, 2, 3)))
 int get_oidf(struct object_id *oid, const char *fmt, ...);
 int repo_get_oid_commit(struct repository *r, const char *str, struct object_id *oid);
 int repo_get_oid_committish(struct repository *r, const char *str, struct object_id *oid);
diff --git a/compat/win32/syslog.h b/compat/win32/syslog.h
index 70daa7c08b8..28e2c96c52d 100644
--- a/compat/win32/syslog.h
+++ b/compat/win32/syslog.h
@@ -15,6 +15,7 @@
 #define LOG_DAEMON  (3<<3)
 
 void openlog(const char *ident, int logopt, int facility);
+__attribute__((format (printf, 2, 3)))
 void syslog(int priority, const char *fmt, ...);
 
 #endif /* SYSLOG_H */
diff --git a/quote.h b/quote.h
index 768cc6338e2..049d8dd0b3d 100644
--- a/quote.h
+++ b/quote.h
@@ -31,6 +31,7 @@ struct strbuf;
 
 void sq_quote_buf(struct strbuf *, const char *src);
 void sq_quote_argv(struct strbuf *, const char **argv);
+__attribute__((format (printf, 2, 3)))
 void sq_quotef(struct strbuf *, const char *fmt, ...);
 
 /*
diff --git a/strbuf.h b/strbuf.h
index 223ee2094af..215fbdd64bc 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -263,6 +263,7 @@ static inline void strbuf_insertstr(struct strbuf *sb, size_t pos,
 void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt,
 		     va_list ap);
 
+__attribute__((format (printf, 3, 4)))
 void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...);
 
 /**
@@ -425,6 +426,7 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
  * `suppress_tz_name`, when set, expands %Z internally to the empty
  * string rather than passing it to `strftime`.
  */
+__attribute__((format (strftime, 2, 0)))
 void strbuf_addftime(struct strbuf *sb, const char *fmt,
 		    const struct tm *tm, int tz_offset,
 		    int suppress_tz_name);
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index a7043df1d38..cb881139f73 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -16,7 +16,7 @@ int cmd__advise_if_enabled(int argc, const char **argv)
 	 * selected here and in t0018 where this command is being
 	 * executed.
 	 */
-	advise_if_enabled(ADVICE_NESTED_TAG, argv[1]);
+	advise_if_enabled(ADVICE_NESTED_TAG, "%s", argv[1]);
 
 	return 0;
 }
-- 
2.32.0.636.g43e71d69cff

