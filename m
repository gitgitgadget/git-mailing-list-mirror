Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC5DC11F68
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B9A61380
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbhGNASp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbhGNASn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:18:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C574C0613EE
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:15:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f17so902836wrt.6
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CxAEuR7M5B4588j/R/sVirSlZDKIe8EG1UKtiXlMS+U=;
        b=MIxanvnXyaPBXl0U5gm1o6J6zXzUZr+zFCFgrvQe8flBmyoL8puHwBmD0Da9MFpXWB
         ogaflnLGU4pgMSfeTVtgxYMMNbNG38KSLCn2Qtq3SDS6OQirPKwzV9hrgi8Gz1CzFN8v
         xq94HB8MYcLmauVOr9EhOAMF1wyW62tMz5fkXiL2xe3c2IFWch72e0aDHrumKPcNVi6z
         HRJ4ckHUemFuTIAoJpsMxUBi9s8ckr29V9xwUH8e1joUXi6x1dPt60HuKu2SkS3W+zt/
         U1L8aav5Zb9ZebZumrDkCGCKoGF23blbkCEu8DC4EPFRVZy2nZdxUd49Edx0MLxoTC0h
         r8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CxAEuR7M5B4588j/R/sVirSlZDKIe8EG1UKtiXlMS+U=;
        b=j7C6kkzM9VaykG05xBrfDC5d2I2DrHbxQyMJXiGWusVmQoq5ggd+NPVnrl/K19F3FF
         9paoVea679M+EnaHA5zy0Hkaj4a0/autL1+KQln2zxrFC8lwnsv1QGwYTgi+6xZuWBBB
         K+yvbq28PsRD6kXte42LCjnyEeL6+ZpTdsEUGiLzMR6MZZlC98ncUrYmwqyXw1ng1hmv
         fYVhaGvZfXIn0EfoPqKYNHX5GnifFBIzID2Q9LVNzMYZc9TSJuJJNE2BZ0/jC83p2Pdk
         wtSMvC8K1NS/L0eDJ4fNlaS4IzYVhAvpFyufkdKlaFlT/Y+Q4K7pYaGtvm03V1eUq0zJ
         VC4Q==
X-Gm-Message-State: AOAM530aSWEGt7frXXKBKszXbgEhTtOK9ex4gcPaMhr4NyMed5qp+l8K
        LNLpHSwMxUpyAVMbMQsuKzsn4RLqGnxJfPiU
X-Google-Smtp-Source: ABdhPJwDEPq6H0BA4270QoDvv0jpDFAcuiara2YK3AboRHYejwPokb5XaEc46/ba/q5bAo3JHKt0Pg==
X-Received: by 2002:adf:c409:: with SMTP id v9mr9182482wrf.102.1626221750521;
        Tue, 13 Jul 2021 17:15:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm2876518wmc.7.2021.07.13.17.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:15:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/5] *.h: add a few missing  __attribute__((format))
Date:   Wed, 14 Jul 2021 02:15:43 +0200
Message-Id: <patch-4.5-fd70d512b4-20210714T001433Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.5-0000000000-20210714T001433Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com> <cover-0.5-0000000000-20210714T001433Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing format attributes to API functions that take printf
arguments.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h  | 1 +
 quote.h  | 1 +
 strbuf.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/cache.h b/cache.h
index ba04ff8bd3..f9aed2d45c 100644
--- a/cache.h
+++ b/cache.h
@@ -1385,6 +1385,7 @@ enum get_oid_result {
 };
 
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
+__attribute__((format (printf, 2, 3)))
 int get_oidf(struct object_id *oid, const char *fmt, ...);
 int repo_get_oid_commit(struct repository *r, const char *str, struct object_id *oid);
 int repo_get_oid_committish(struct repository *r, const char *str, struct object_id *oid);
diff --git a/quote.h b/quote.h
index 768cc6338e..049d8dd0b3 100644
--- a/quote.h
+++ b/quote.h
@@ -31,6 +31,7 @@ struct strbuf;
 
 void sq_quote_buf(struct strbuf *, const char *src);
 void sq_quote_argv(struct strbuf *, const char **argv);
+__attribute__((format (printf, 2, 3)))
 void sq_quotef(struct strbuf *, const char *fmt, ...);
 
 /*
diff --git a/strbuf.h b/strbuf.h
index 223ee2094a..f1e9821a54 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -263,6 +263,7 @@ static inline void strbuf_insertstr(struct strbuf *sb, size_t pos,
 void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt,
 		     va_list ap);
 
+__attribute__((format (printf, 3, 4)))
 void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...);
 
 /**
-- 
2.32.0-dev

