Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5A2C208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbdH3Ruc (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:32 -0400
Received: from mout.web.de ([217.72.192.78]:65030 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752016AbdH3RuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:08 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyDph-1dQ2NW1XMb-015ZtE for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:07 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 14/34] help: release strbuf on error return in exec_man_man()
Date:   Wed, 30 Aug 2017 19:49:45 +0200
Message-Id: <20170830175005.20756-15-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:ND57ZE1gw0yq/hPrdV1W6rKgwVcDR5118/vTbKFcH2gCtLV6rwg
 jz0OUOOmcSWEAabdDqd6LrAtr/g/BZ6UmgdvzCndYeRGiLlR/WaIBFjNljZgoU3jJM9bZTu
 MOB/MYiQry1CobpH4UtLYj5K7DsKic8ILEDyCGpTTZ8uOsnyBBdBwuGKc39LlgCS4rAWvGk
 7x66acBKFxK0rbzoZlcQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YM4G8091ZXY=:ZY4EJiNsU5F4eAfEod23JK
 4IcGfn/ItS7akZ0IGwNIkjUhcloKFrDpcGGK+DX08kJUblGBN8yj0nj3dNfB1fmGGVI2/x6EI
 2TRjlWrft+6Gz+/HsOQAL8ueLvv44YHWD/LR8OfCTxOZi/SjCi2gjft1adkDhlBr7BxCiutAy
 wRqn3H1TeBpO6t9wioTeamgbVUJxoomBntNpCihVVQxNV519I2K+OxM6fTxTBZKRd270mX9tM
 xBcdbjFP/var72wulIvPeVqNnzDLPVKe9Bd3EV/87e3xxyU5ho8l9KgJNz/f29pjGcu3l5eHC
 iVxyCSJvgybrLt9wNZt5c1qib2cO2Qi4NJyESew6Txy3UcPZ8iSeepQjJUzb0E/iZGZC8Qrev
 0Ai6ys8hCptO5cclySz9ANC+PlEjOdnzJdzZLd7ClTIipjwMMf4rV5oAB/rfcQ1iDfeHny4/I
 4BKc7JEAufA+hSkAUNjZIUicq+iXS2op6pjaGWxLkyDaBpGYPo2rp1fDQ9GFTKDl/O4j2ZUeB
 zkQTZB2fAv/MTA64OZqhhE5d0P1kPDP/k5EQDerUV7rp8y5EShdTcPK4XwiIlIYusAELlvq38
 wsxVsZm2EzZuJJQpIYQigdN+IOE8IP7l23EwBCbgNDBqI1rKkllQrN4Yz02zdxT2XA1FxJEXg
 C5FkWXIbaL7h/s76K+f6xPkJ5ZUx2lFDQ8UPrG2CHj9dhX9ajhWDX7aOpq70gpRFj6PreNYXk
 NJjQUfCqUWiDIt7c5+SUo2lxPMEsVl2OLj4p8s2As5NZ2VBeU+2AH4BdmnfZ+0oatSJh3hI8a
 635zjMbo2+FrZeYFtvJ8nTiHhe5JA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/help.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/help.c b/builtin/help.c
index 991a8bb16c..12fb48933e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -167,9 +167,10 @@ static void exec_man_man(const char *path, const char *page)
 static void exec_man_cmd(const char *cmd, const char *page)
 {
 	struct strbuf shell_cmd = STRBUF_INIT;
 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
 	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
 	warning(_("failed to exec '%s'"), cmd);
+	strbuf_release(&shell_cmd);
 }
 
 static void add_man_viewer(const char *name)
-- 
2.14.1

