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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5919CC07E96
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9F061249
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhGMIIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbhGMIIT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:08:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BDBC0613E9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g12so5170739wme.2
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CxAEuR7M5B4588j/R/sVirSlZDKIe8EG1UKtiXlMS+U=;
        b=Ti2kkYguBPJ7X56iPy6jktgAAe5Uaw0hJ9OdEOb/5gQLjIOYWjkTNpWnn4AHpsaroN
         I1CEN6bTQx1Td7tA55dcQi67DmdvZ72iHbLYsWEEcY3T8/w+BJPXiw1q1zd8WhtNwYAN
         31YAx4MhYaRHAOvBF2NoHHK7hkGYVYIaaOHbSylcq8aiPAXTTtSXh1i3OslfwAWOm48O
         8ycIzaTgcfMq3c9zVSajFHcPjPAcfyJnluIRsOkUlQS2rISoiINq91o+E7W7k6F2XxQP
         gw5q7KBcjHKA7md3i55W4a4GoixHtnsRNjgHwziIoja3nc/GXLGCxtuUvX2Pd5irLfkl
         CvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CxAEuR7M5B4588j/R/sVirSlZDKIe8EG1UKtiXlMS+U=;
        b=M43tiznQjd4CoJdFdXmc3J0bFEs3NO/7qg19NSED8msumiBDyq/yCIu4prZ0t7sRYk
         2Pu/dP8B5VJsA9owigkmeXt1X6JcfTZdGjboxBdQ3afng8W9PJ+roI7OG3auel8geaHV
         m6dEogz8QfTYFcBLSJVM9lQBgXZYNWaRwrzLWTpeqCARYnNMLpDprSK+wHIyJJQ4/t7+
         0AtsltrRbzZdV0YE7H375W4XzvSA71bbexg6WVeSxocqfHvzgdoVPIz//RnobI+ED6MS
         fv6Ke1trVSb25tQh2lk0Z/1Bjd0GanEmp3QmU7AA1ebPo8ejf9bD9gFIIw4YmZ6ntTe1
         HDEg==
X-Gm-Message-State: AOAM532KKouSEbR5EYwJACR2HbJlneA3aSy6SxI1aoSR+qudrYZ20H//
        S7K8NA+GB/MBUp8TaHqy0t2llcjV6qK9CQ==
X-Google-Smtp-Source: ABdhPJycrDqlqvYN2OLnR0RH2iNOThlG2Uj/4z9C30XNWzbhnaKfj4JG9x8wGddbKzYDc1BFNPKTxw==
X-Received: by 2002:a7b:c1c2:: with SMTP id a2mr3472285wmj.15.1626163527110;
        Tue, 13 Jul 2021 01:05:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z11sm17156772wru.65.2021.07.13.01.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:05:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] *.h: add a few missing  __attribute__((format))
Date:   Tue, 13 Jul 2021 10:05:19 +0200
Message-Id: <patch-4.6-fd70d512b4-20210713T080411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com> <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
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

