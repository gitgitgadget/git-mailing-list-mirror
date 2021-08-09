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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CA9C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 01:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE21E60F4B
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 01:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhHIBjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 21:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhHIBjL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 21:39:11 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C9CC061757
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 18:38:51 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l3so2919125qtk.10
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 18:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwdTZ1jw0/rg9fMiml6nG/QJoZIfkW6CrOa342mXHMc=;
        b=NI+b81Kjx1h3qqOxZa6EV/EqwXDwd1nIGJiwMz6/RlP/XoUdFbM6i3qnbqHOzcqQ2v
         c7GFB3d9mxVUq67yRnwa6xflGN19d3bxrT7MJRqhsJc/N26KKodyWFkATnOCpPNPLlQi
         YeKX+QPa2Tz9trAMEBn6gyGGZcsmVZ+KbKYIwucRguw1iqiaAyahuyw9cKRjSIYojmhv
         sZUIlMWkk25lYUi44BEYPx2uiQ+DnJvTrqyNB/4BDY+uFl3vqt0gWsmLR1H54m1dc5qV
         q1hdhsI2fE8F6xXIBf7NHiMG9tyPVcqLp128Tb60Xd5fNFOAax56ouTUUCpcxGRtJ0j7
         c73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwdTZ1jw0/rg9fMiml6nG/QJoZIfkW6CrOa342mXHMc=;
        b=GQXss4hO1OqEBXfWZKZ8caZGHubT7wC3hI6qNfevuiVGlGDJrEfB41odCQ4AV0b1PM
         OycAHt98JnrYe+k8ymQPF1YwK8j86IkMerNPwO7+1HaImQb7kvE8Q9heirO31T/OcN8y
         6dnznrF7UQ5eKGO0ciQSkM3V/5xqEenXVQ2G0Y3xOQS+t1hN3J+TKu1y57PnucMxc+ts
         NnJyr6B3OyBngUgU145K3bRHaxgQ/bWo4clkT2U068Oelpl7VO1TYCB4MbProeUr2kKS
         0K9u9PnrQuP+DsZrOBlSxPgEQEOEelYMhwOzrsnBC0Q6DP1GMHiOYURnF39Je5tTx43+
         byUA==
X-Gm-Message-State: AOAM532D+UxOo87xxH8Xob/fdChDSDVIZ4K3TBDcW50Sn0FjheTUNEnH
        Q2cpz0H6pWwsm6U6JlTRGtxO3KfGEI8=
X-Google-Smtp-Source: ABdhPJyKTRFnuMzJNBGD/l6Pjg3Q4siu9IQiquZJHBvK3qO0TCgkS3I79lIF3cT1/xIOv1AMb6RsLQ==
X-Received: by 2002:ac8:6611:: with SMTP id c17mr17877508qtp.392.1628473130538;
        Sun, 08 Aug 2021 18:38:50 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o16sm1279492qtq.95.2021.08.08.18.38.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:38:50 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     e@80x24.org,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH/RFC 2/3] object-store: avoid extra ';' from KHASH_INIT
Date:   Sun,  8 Aug 2021 18:38:32 -0700
Message-Id: <20210809013833.58110-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.373.gc715f1a457
In-Reply-To: <20210809013833.58110-1-carenas@gmail.com>
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
introduces a KHASH_INIT invocation with a trailing ';', which while
commonly expected will trigger warnings with pedantic on both
clang[-Wextra-semi] and gcc[-Wpedantic], because that macro has already
a semicolon and is meant to be invoked without one.

while fixing the macro would be a worthy solution (specially considering
this is a common recurring problem), remove the extra ';' for now to
minimize churn.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 object-store.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-store.h b/object-store.h
index e679acc4c3..d24915ced1 100644
--- a/object-store.h
+++ b/object-store.h
@@ -34,7 +34,7 @@ struct object_directory {
 };
 
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
-	struct object_directory *, 1, fspathhash, fspatheq);
+	struct object_directory *, 1, fspathhash, fspatheq)
 
 void prepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
-- 
2.33.0.rc1.373.gc715f1a457

