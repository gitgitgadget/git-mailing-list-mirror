Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECB6C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbiCUHfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344962AbiCUHfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:37 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7D5AC918
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c11so9718982pgu.11
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xjtpr71rmRe863Ta57w9ChYNkXlSn55eFsnOfSKRC7E=;
        b=TNbvLBZlpSp3leGCL/hsLmBM3vevLDa/gNA4dHFdD7nE02SRUuVLqQSy4jck6VHgaV
         7txnpwRwc1taWmsNiyGcRIiswP3mKSpg87V3vb/pKsQSZmoQAGmgInCjiQhVjQCpvZvm
         m3hgy+5E/egQ/axEhwNMmdr7grZl9rwvJqv5b1NblcCZPrBUo2mhL3z5KiiZZmJugRzS
         iKkOz+NO4N/t015KBMlhY0hijnCxtGcbaBt8RBm+rdLBLUUGcJ4rv2iOx19fGyxv2RyH
         ajKQTph2YapecjI/BVKPQnMzm3opl03fSOIvTGzxFSNUa6uwHKkhAuQcw/oj/oznVN1H
         e5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xjtpr71rmRe863Ta57w9ChYNkXlSn55eFsnOfSKRC7E=;
        b=KDy17nQkqZBd4JKxT1wmwe2yohAE5QBeLZ6S6gBtCrQ0aO0yn3EMWUdDjQRuQHSY0R
         X+SWzO+BuVruFTuasu6opq9D4ZwZUtFRvXdSxHkN1wLnNCKJhY6Sak3C7pZOoGck6uEL
         Yt2EESi9KKaeS+9I30vWUgqhkc0m9+OvTIJFECB2Ieg0x6ljQBPwJD1CJ2AEAYnKqsqQ
         M7XIDSotPkvZsKDbjGvY9xxDQTLA2ULAfmVWJTFtP9cwR1BONjVfKi7N4grQMaR0sAD6
         7qzHYEbksTQGdhvHMQRdh4FQFC3ZpBnQtSY2JBxHf+mLqlZN3TgeRZgl1B4S9zsC2aLr
         2V8g==
X-Gm-Message-State: AOAM530VS0tSxgISp11B/BRUCEoluYwDguI/RwXmfn/27knVkGpbij1F
        dwD+h07dV6a5Yduw2K315Zk=
X-Google-Smtp-Source: ABdhPJxCjW1pqGnFwzChkliitBKJDqJ1wN+9d6cY1TWUb5o7zdLAhMAJV8A8UtCKR40+XyctWrz0mg==
X-Received: by 2002:a65:61ad:0:b0:378:8f01:7674 with SMTP id i13-20020a6561ad000000b003788f017674mr16782049pgv.314.1647848047769;
        Mon, 21 Mar 2022 00:34:07 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.34.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:34:07 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v13 10/16] cocci: allow padding with `strbuf_addf()`
Date:   Mon, 21 Mar 2022 15:33:24 +0800
Message-Id: <eddcf903ada6c598cce1080fefb87d2115b80455.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A convenient way to pad strings is to use something like
`strbuf_addf(&buf, "%20s", "Hello, world!")`.

However, the Coccinelle rule that forbids a format `"%s"` with a
constant string argument cast too wide a net, and also forbade such
padding.

The original rule was introduced by commit:

    28c23cd4c39 (strbuf.cocci: suggest strbuf_addbuf() to add one strbuf to an other, 2019-01-25)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 contrib/coccinelle/strbuf.cocci | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index d9ada69b43..0970d98ad7 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -15,7 +15,7 @@ constant fmt !~ "%";
 @@
 expression E;
 struct strbuf SB;
-format F =~ "s";
+format F =~ "^s$";
 @@
 - strbuf_addf(E, "%@F@", SB.buf);
 + strbuf_addbuf(E, &SB);
@@ -23,7 +23,7 @@ format F =~ "s";
 @@
 expression E;
 struct strbuf *SBP;
-format F =~ "s";
+format F =~ "^s$";
 @@
 - strbuf_addf(E, "%@F@", SBP->buf);
 + strbuf_addbuf(E, SBP);
@@ -44,7 +44,7 @@ struct strbuf *SBP;
 
 @@
 expression E1, E2;
-format F =~ "s";
+format F =~ "^s$";
 @@
 - strbuf_addf(E1, "%@F@", E2);
 + strbuf_addstr(E1, E2);
-- 
2.34.1.406.g2e0e55130e

