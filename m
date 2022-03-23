Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4538DC433FE
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbiCWJPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbiCWJP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF54B76580
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q5so950312plg.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+voSzOjW1RM4B04bcnSPHxziNDQXrcmPqzG5XP3QSNY=;
        b=FxU2qMeDSZQZauHx1v1lf44vr8NmFn6MeAm93lkmbPeybLQYeCzrU2DYDR9fts+Khr
         jjkccq8ZHFyh3wB7SawcnoY3f/IHMR2U1Uht25xqIOQaZyh7lewzkrt+I9mk/BtZ6GDD
         JTVW6v4c4WmNSaBbU9cKzd5LsMmrNQ3NUkb9VsNh2tAfl8AEO0rSzX0xzNh/3p9h3Lex
         sRXcR3pwAN/eE15rNpcyJzLyHP4VK84Qe3Z1jCRr99l3J46Iak4RW1UT0Iu5RzaNnYmh
         sYaWMIXJKjvtKMzDU7ziMb/MdJidx6Pwgt5RmVsk9EmiSXMeS3lOJ0EEsZGqVpvXbTCM
         ndpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+voSzOjW1RM4B04bcnSPHxziNDQXrcmPqzG5XP3QSNY=;
        b=W73o549k/n0XCz+ykInik9jxXY0jZECsb1G+D2VpIGn28SJqC2zAmmdliEdC0fCcaq
         ab0ZrQRQbau9JHqW9PTU5WrkwSOCOsmiVAHfEwF9a0GWzhjj9s58vVXzMq+5e/2po5Mh
         koLz06i2fLPm54GHy0NaZRN4uQ7qwi5fSiDny3q1q6R5OajBZ1Wvg+nS58bx0k3HU1Rk
         WVz7MVxxJ+HjTymkU4clF08hWLitTth18LI1xY28RH0l1LV08t4tt+Uhg6BeXPqJokOf
         O5EB6OY641PgdS3fdKfEK1VEfmFGWVkOztAgToNPoEfO88w5VUgHYdgOqrP98Jf1O3Xf
         L0dw==
X-Gm-Message-State: AOAM53093TWz3dvYxRltOhMZz4Gf7RhfdtV1gST3WnNnKQfuefNpVXHz
        aBmNDGB1GvQxl3eRIm+qBKY=
X-Google-Smtp-Source: ABdhPJzs+NhDphJ9cGySnc92DitUx9qNGuL8mUDFo+eXKyxOYz3R2BOVAxSalcMiZv9vfSylLdpm5w==
X-Received: by 2002:a17:90a:d3d1:b0:1bb:fdc5:182 with SMTP id d17-20020a17090ad3d100b001bbfdc50182mr10426440pjw.206.1648026831406;
        Wed, 23 Mar 2022 02:13:51 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:51 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v14 11/15] cocci: allow padding with `strbuf_addf()`
Date:   Wed, 23 Mar 2022 17:13:11 +0800
Message-Id: <e4769b64c9400089aa7c1e50464aee1c869c900d.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
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
2.34.1.404.g92931a4a2c.dirty

