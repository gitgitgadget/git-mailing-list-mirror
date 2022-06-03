Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73EDC433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347615AbiFCSji (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347121AbiFCSjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBD165C0
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so4753124wms.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I78BFi8lWbxsFfO4i7U+p+E1Z5D4ikxyRJc6zcGg/gE=;
        b=Ob8p8kGo8x3N47zphHQwUHXyxzXOErZX8GI2v2Y41lVqY/WUke9+Sv9U9ckb+phvSA
         uk60LEjCTOenNBPWBxJ3a7+Y/PSJ6ZH9s96KywdD7XqM/Y88KqcNoRsR9Yp5oRLQSIu9
         HEyRUWa5c3i7GzIS4ahCgy7TVHVkqd9l7d6y/EQzD8CwzlTOaalseknda8xLWZWYsGWy
         RolCC+KS5E4Cbs1u7OaO3RFxtZdI2EBRj64euO5StITAIF389nmwbpzw7NSLNyZMr6yO
         tvHWSQbL20oC8bLXF19EXCllUFeJAFGjm9gpAoV1lNjJ8IhlN63CexTokEypGeTGO+CC
         q1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I78BFi8lWbxsFfO4i7U+p+E1Z5D4ikxyRJc6zcGg/gE=;
        b=t6E0DF7FT1t+RZhTyoqdsXm+sVQ6a6DY/HM6733GJ3EHT6lvhkjiLPLi04MZCOYnGF
         FDLT553b43Gq41+Am/E9lLJ1OtujiQGnj8NWikS+087KhqzJiffsdDAaxInW2Og2bL16
         5FL+SlUBTeNP3RLH6n02kK8NpkcogSYWrx1Db4NMjN+8Bv+PJQSZtucI65HZqSiuTYXy
         lbtJD9P/frfshs2WZqgK2y6XqmGid2YHqkUAIa3bS6d7vmL3vyuT76A0MTuvEIiyLI9T
         j2oVR/UiSnBE0Z4ml+qfNOmvsId0wJMoAxj8RxtUp8Z6RjDdUBmPTjyv0mGQksJpVJ94
         E3cg==
X-Gm-Message-State: AOAM531fkaIj1zIWA278tLi7Dvqvcjx5fEJ3br27gh75a5PRKsPucWRM
        LE4J8UyN+PdoabVbkFFQalDOE+qKMxkS9w==
X-Google-Smtp-Source: ABdhPJwK4oxVliGgj6XIdXq6Ziqq5i9JnTNvtgtY2oeySUjIcEtCRtHp7Rntik3YAfXa84ii+6KIjw==
X-Received: by 2002:a05:600c:583:b0:39c:3637:b9f with SMTP id o3-20020a05600c058300b0039c36370b9fmr7126192wmd.79.1654281488216;
        Fri, 03 Jun 2022 11:38:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 08/15] strbuf.c: use st_add3(), not unsigned_add_overflows()
Date:   Fri,  3 Jun 2022 20:37:45 +0200
Message-Id: <RFC-patch-08.15-2c4b7832144-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the strbuf_grow() function to use st_add3() instead of doing
its own unsigned_add_overflows() checks.  The overflow checking here
was originally added in b449f4cfc97 (Rework strbuf API and semantics.,
2007-09-06) and adjusted in 1368f65002b (compat: helper for detecting
unsigned overflow, 2010-10-10). Instead we compute a "sz" with
st_add3().

That was done at a time when the underlying xrealloc() in
git-compat-util.h didn't use st_mult() yet, that has been the case
since the later e7792a74bcf (harden REALLOC_ARRAY and xcalloc against
size_t overflow, 2016-02-22).

The only behavior change here should be the very obscure edge case
that we'd previously die() in cases where we strictly didn't need to,
as we'd check both "extra + 1" and "sb->len + extra + 1" for
overflow. If we overflowed only on the latter but were doing the
former we'd needlessly die() die. I don't think that difference
mattered, but it's noted here for completeness.

While we're at it add an inline comment about why we're adding 1 to
the values, that's also explained in the API documentation in
strbuf.h, but since we're using that magic constant here...

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 strbuf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 61c4630aeeb..f0a74d2bfb1 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -91,12 +91,12 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
 	int new_buf = !sb->alloc;
-	if (unsigned_add_overflows(extra, 1) ||
-	    unsigned_add_overflows(sb->len, extra + 1))
-		die("you want to use way too much memory");
+	const size_t sz_buf = new_buf ? 0 : sb->len;
+	const size_t sz = st_add3(sz_buf, extra, 1 /* for \0 */);
+
 	if (new_buf)
 		sb->buf = NULL;
-	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+	ALLOC_GROW(sb->buf, sz, sb->alloc);
 	if (new_buf && !sb->buf)
 		BUG("for a new buffer ALLOC_GROW() should always do work!");
 	if (new_buf)
-- 
2.36.1.1124.g577fa9c2ebd

