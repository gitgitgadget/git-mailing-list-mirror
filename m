Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B04C3525C
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377014AbiBHNOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350296AbiBHMPM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:15:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43264C03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:15:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so1883686pja.3
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k61gPCyYa++t62hfIn5SzAt1sRF/aZFfvQC8DVdwMaY=;
        b=JDR2JUGoYm2gk4M2hoarMeAVJEYp9XiulIUOZTBG4++sM+RAoq5XlKTnpwQfiR+q8y
         zQjDclP4FyWO+mjQh6oA8ZX9iSHJRoedbtN5s3JqiK3Ka7mgzYJhTb74fM261tMJkL9D
         GxdpaNQrlaBNkaBQBCr5rCgFclCgOvBS9H4DxJBzys2xLnaOyAJ3nNzL8tuzXhRc86r9
         ZJnRF387tTyyGx0Q1x+Wk5vB4k7X5Cmc6gUBV1w/Qdv5D9+Io0C5eD2xi30QlYMaGqyj
         WdKnWuxKTKXl/P+vWOtoo92e+WjtD2CHnq4Xr5MQCoz7vNhPhLskgZRIxs5/30ofFkgw
         ApIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k61gPCyYa++t62hfIn5SzAt1sRF/aZFfvQC8DVdwMaY=;
        b=IrIJj+MdPDC1s/23XJR0ZTsqDllQ7Zai1JKMtv4hOkSfs01qJMrh9j7D+jDYyLXCeq
         8aQkI22Qmy7dupCyCxM5RnnvKjXCIi7ZEhwgPJA8I1EPS6/lYn7s5qAYDVIQu7EHajnb
         B/scgnYZwn0hRmDsfiPUQPt22DL6UmJuWwRx4Fq34Fs9zY+99HGLHDxRMI9wP0oG0MUL
         F6AQ407yGYBR9C5mXiGJ5XYxmBRgzsgurpv3hMfD8MHdg0vTGMbEd2hNn1R3Jo24Y9sk
         ISSHo8og7Tg7vlh0K/BN8uHUJLj8Qlu1FqRtnGVE2TF+znfDHGMg6AOFnA0NGcAeNB4/
         pN/A==
X-Gm-Message-State: AOAM533BYEGsyXmeX3CXlmtL/S8rDm03Ccbtndui0gcgIJT+hzgR1MWL
        5vIhMbZ7V3xztHJVkRsZ0hk=
X-Google-Smtp-Source: ABdhPJzzg0KsF9pshmB8UKhgovK37RLMMPSiMGwHe2VyrqIngFu/F5gPvic9AjYjdtMMkFfRCHpgsA==
X-Received: by 2002:a17:902:cacb:: with SMTP id y11mr4333032pld.96.1644322511665;
        Tue, 08 Feb 2022 04:15:11 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.15.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:15:11 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v11 10/13] cocci: allow padding with `strbuf_addf()`
Date:   Tue,  8 Feb 2022 20:14:35 +0800
Message-Id: <c04320b8018000f1f789b069a49236de798e9a92.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
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
2.34.1.403.gb35f2687cf.dirty

