Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0890C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97138610FE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhHBTBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhHBTBq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 15:01:46 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85809C061760
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 12:01:35 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g6so9375704qvj.8
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DpyIrEtTCiEX3pzs5kNiBf4o6VtRx3ZO6VLKPOI/WgI=;
        b=erBWMTcdsrNcIYbaLJdJ4yiFjl68NsRGSyAZ/OAbwLjUM98qAtq12CgSiZGrjiY5nw
         Tubxthbf0IIAbE6TVXywLflO+8cZPrx0S66PQ9SYsF/OF+zef5vd/kGSbuVuMgrXGYip
         U+0ZP5fs29+DRRlnGUkZxQjqtABaXFf2YGm5zi3isZERoFoPJ5RmKp0GIxXVaDlX/CPA
         99V45miqTglvAGnDCvkVmWFJYnu5cdTRZgWv0DHSTrYbGmcw5BrE+IbYJKwA0Ho3VUgl
         NRfCvIndwQW7Jg4TNEpgZgriUGBEXsuYonM/Gp6ms9P3uZUfhkSFO8yM+kqRyHSokFnA
         bokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DpyIrEtTCiEX3pzs5kNiBf4o6VtRx3ZO6VLKPOI/WgI=;
        b=bVNo47+8r8ksKsEa8Ls+MUWECIg5z5ZODbiMtlHHP1Xi1OiTjxugfjZCAqisDNWmgi
         ZbiSKa1w0Wr1YUCBvkDMsr2x2uw77/LLuTcBjlJzBzAlUyxsmCXHbLXbljFLxULHx+hk
         YgCs6pLKUDq035X0MefI6jGzK/u2sU9i0o2d8fO0KD4VTAhhutWfXqxt4Ui5WLtej00L
         N57KsFEeMHi4uce/smfO7q2o/DjzpxYAjQJNv0NHIk88l0m5zF0ZMA/n4Ma1HQ2BjS5G
         KLEOiV65tY0Qyv66sWy8KW0KlPPq5LGK54tqg1r+eXiAAAAjC8eJg2bpI9b5nmk5Jv3X
         ca+g==
X-Gm-Message-State: AOAM532CyJYPXifMuyxyfp8JufSGzVJPmKT0hbfhjCVTWlKbXrdZ6KZl
        Zr6v1FAnJjXi0H4hCCduHbk3fMVKYQg=
X-Google-Smtp-Source: ABdhPJwpqnyxKdGzlnSDgMTjmz1onTtHKtGHnI7EalbVykcR+ilUchbkx/dcMing4c2Q+BZiN26UVQ==
X-Received: by 2002:ad4:4eaf:: with SMTP id ed15mr6872369qvb.11.1627930894538;
        Mon, 02 Aug 2021 12:01:34 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id b21sm4949885qtb.58.2021.08.02.12.01.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Aug 2021 12:01:34 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/3] openbsd: allow reftable building with zlib 1.2.3
Date:   Mon,  2 Aug 2021 12:00:54 -0700
Message-Id: <20210802190054.58282-4-carenas@gmail.com>
X-Mailer: git-send-email 2.32.0.826.g286871f41a
In-Reply-To: <20210802190054.58282-1-carenas@gmail.com>
References: <20210802190054.58282-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

all released versions of OpenBSD (up to 6.9) include an older than 1.2.9
version of zlib in base.

enable the compat uncompress2 function until is no longer needed (likely
at least until the next 2 future releases are not yet EOL)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 59726d6538..074dc2324e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -260,6 +260,7 @@ ifeq ($(uname_S),FreeBSD)
 	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
+	NO_UNCOMPRESS2 = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
-- 
2.32.0.826.g286871f41a

