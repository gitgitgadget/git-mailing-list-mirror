Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0372DC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiCDKoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237758AbiCDKo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:44:26 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DFF1AE644
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:43:38 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o26so7177614pgb.8
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zat6ZRTSvvw2CIXm+7n76MZX8/mahV4fB4VisSulkj4=;
        b=Cn6QWXeICV7BQsLQbYy0A5MOvp0qlYhPi30/1ieArCS1RfqSwL/y4Nek1uzBQXEqpI
         EvdjYe22zyiegCaWDbzS7OYZrv18XaZAmBYCMPXS8EsFAh7M8zNRBfStX357DLl0Wewn
         PUmHirlYlFA+z17p702pb70DA+5fAOdDaxUqWK0jLVrWRSOH1F6TVG1J1L/LPKSld+lS
         k8xqhPLZ9/0ynQB/DGm8i54TNjQjFDNzGy/JVTrTFa1yJpz5umWbr5MHoh3xvkTTxGRs
         ieCnHIJSNLERr+Q65SV8EIVgw2lp2J3haeM9jqaEMrYISsFDnkVtRoUmGi3wKnOZrL1W
         VhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zat6ZRTSvvw2CIXm+7n76MZX8/mahV4fB4VisSulkj4=;
        b=u7GxbkwUl8bT0WPCPfrOYx8YL7KK0O8kYca9+OyIlYOKxKlY5nEBpa0M4zTWWPXRtE
         euTH9MGgIPidFGRnwWxOCc8UkkN5C1eDJZ50nz2uhPujRaN8q4LmpqfaC1U3qk5+2DqC
         ubaXcBwVe10HPaiHTOG+AE828NI02s5DkL5c3cTBuePPMlO485B/KjeBw7ibh9+QtBt9
         TxYlar86pO2VgzNlfdbTGaqKqYKW8Jj4Y4rBhwvC2QDuAARHD1IfYQ2++l8UW4XDJlq0
         xwSDlyFsyX89HY3fvvx5qS9kafIh6Th1BcnExpyAum5b/p7Cqd0eyB5f0wby+YM9bj1E
         NaOQ==
X-Gm-Message-State: AOAM5300Nx9f+alVHC6TSuQvuB+nVXcniJqNc5koZqLLn1lng7TYPtMt
        jHNyONNPaB1pXs8pfni00Nc=
X-Google-Smtp-Source: ABdhPJzhOnOFqchZe9aLgaiaqUp08/JCaUNrRNc2qxqB/7NUJMAtkmnUrwsIApeK4jTSMHVsZR1F5g==
X-Received: by 2002:a63:8548:0:b0:37c:945e:2603 with SMTP id u69-20020a638548000000b0037c945e2603mr2489298pgd.124.1646390618092;
        Fri, 04 Mar 2022 02:43:38 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.43.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:43:37 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v12 10/12] cocci: allow padding with `strbuf_addf()`
Date:   Fri,  4 Mar 2022 18:42:36 +0800
Message-Id: <459080f549e040d5e2396533abff76276b60c274.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
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
2.34.1.402.gef0f5bd184

