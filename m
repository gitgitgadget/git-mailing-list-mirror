Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C94C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiAMDms (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiAMDmo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:42:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EC1C061245
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so16651419pjj.2
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WP/rVHesd0tLJ7fuvItSuZM2Y6Efr8+wRCkMN++hhKQ=;
        b=PQcPJbHWa9ZtDmNj+SNb/J3OydxtbAtAq6yH/rojcHa7Qfmi1cRZBvWZNzEC29z6zg
         QhjEf+X63m3sEuRWN59wBTB/U+kJlODQBwEo4o3Ut81bovxylxfbS/2nCVD2qleHyGaa
         sRizNW2ZGmTo5KrbPKBxy9cLewLjX2YtiLvXbp18FtY1f66PcWQOyjtyhbXWIuAnXHbL
         yjEnw4Exe5ZU+E0qOVrsZWJItVy99yyjPMlF7vGimZptLCxXXaZ812R/UPmhP0e3pfK1
         tKZSB8b65LsHcKbSgdOt0hhv1wi0c3hRa3N6LLFm1GfOHWH/E+Qi3BKI9p8xcEnz5oCl
         awAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WP/rVHesd0tLJ7fuvItSuZM2Y6Efr8+wRCkMN++hhKQ=;
        b=6iFHfVOaRP56rPgM0J+s2SVH1ZNn5keDNrYEv9tZ/QAVQPUAcGTZzzUDZa4RC6y0nb
         MO4crdETM1rwCXOCpM1Aj3FXAWHNzw2bNqkkmeo1mhz42MR92rzEBbg5LOCt6/d5lRPN
         ZGcv+GLLiV7AZPLMyfsYLVaZPdRjUQYeSojEpyjJFt3UDEMguatvzRAsvUyElvWn38+7
         rxjQlulLqEENvjLhnBplzvgydrrYw78KA053bHXyub1+ucJrbuhy/OOBAqbAwbO/Sn3X
         JV+oLv7OgpEutrQuPw7z7JoPyKSL+CYUmh+nEJJrpY5oTel49KjRWGN9zqeisEnAu8gr
         Ph0A==
X-Gm-Message-State: AOAM530qZRMavz6ABFIfHJNB8sUknXm/fn2x9nQXWXCqpmaL6BHwNq+E
        OTf8AO7axfOG3218ttK/BKhk+q7OG7PiybjTSYOzZg==
X-Google-Smtp-Source: ABdhPJxoBkPDj3qbMpMWV+1h5X4SMzmMM920rFY8iX9deNwlTo2QkuQ97H6LZ8Y00USbLJvZeOZ5Hw==
X-Received: by 2002:a17:902:9a0a:b0:149:7da0:af27 with SMTP id v10-20020a1709029a0a00b001497da0af27mr2792928plp.49.1642045359664;
        Wed, 12 Jan 2022 19:42:39 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.48])
        by smtp.gmail.com with ESMTPSA id c20sm879436pgk.75.2022.01.12.19.42.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 19:42:39 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v10 8/9] cocci: allow padding with `strbuf_addf()`
Date:   Thu, 13 Jan 2022 11:42:11 +0800
Message-Id: <4b58a707c2913da3e2c39c1ffc09b08dfd98737e.1641978175.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.390.g2ae0a9cb82.dirty
In-Reply-To: <cover.1641978175.git.dyroneteng@gmail.com>
References: <cover.1641978175.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.34.1.390.g2ae0a9cb82.dirty

