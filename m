Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9241F1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 07:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeJTPnV (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 11:43:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41687 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeJTPnU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 11:43:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23-v6so16727536pgc.8
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cyEugzNp/3R3AFWgQe4ukg8pxhwu4lAm+Vze2Gsu8Xc=;
        b=ubvTd9rO306yZDnt3qbnCJeqhK9ahmCp/sPIHEWJGZEayxDYPvj6fTawzT7D0dn1EQ
         RNAPFoDBeabp3KhreHbjep7wEsdTlh/+YzPDrdMAz6kIadeNkw+0NpV0Lzl4QI/CAFP6
         +s85m+GXc27mdETSvJINEpWUsW44olix2Uk171dB0cq3ZF0az9K17JT0RdL5IYUgYxJi
         ROtRnPHwQFkf+Eu6pisElYMuNKTGbcuItgX3l1T0hzXqkR0ojFDSIXaS7mlrR0YUQ85j
         YIaLmlh0SuWiiQzuTAUMdA8jzuUZOmInFc3swVhh/Uv5Et2vlCUHQwUrSCH0O83t4qUD
         0pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cyEugzNp/3R3AFWgQe4ukg8pxhwu4lAm+Vze2Gsu8Xc=;
        b=JNiGZR0xWG2qY1AhbsHBx/B6/f0An5qCjtw4AfNFMsASehhO19CZZQDceVW6GkwFuf
         +aCVpKxYJ5KtXneS1FwrkF8XTXMH61ZAJu7nG/pw/47CkyP+8QhjwOEiE9rji72FaqJ0
         UtpImw8Df6cpQBFu2ZyQ9g+0gnrwiS8Valk4lqnBzbh/iaggHwQI7CBNJfZj6qyd5J8J
         MQZuZr3+sOtoUmqWSsVF6h6uSOXAMNHpkP8fjgaRfvPspPdg3AY809XRhOfbtzV2/OyB
         RJKBKfUHVqoS3PRzbTLbxIYxGaWfKWVSIepUFPbzgnFaK03WOeeSw4imCipJS/vLOiaS
         s4wA==
X-Gm-Message-State: ABuFfogiFlrIcUwclCMh5dgD6V1nrEUXU5VWL3qh1+cTpA9nAxWLSDmu
        6K7OSdGlAlAajVQf+0ASGyJXa21a
X-Google-Smtp-Source: ACcGV61Y6zIhMWYApAnfW6mXL+I1v8bF7zF6qg4X78hy/FD+R20D05sPWnvx/QxSWlhi9UdtGeqlwA==
X-Received: by 2002:a63:1d62:: with SMTP id d34-v6mr35956654pgm.180.1540020831496;
        Sat, 20 Oct 2018 00:33:51 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h32-v6sm20930098pgb.94.2018.10.20.00.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 00:33:51 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] read-cache: use of memory after it is freed
Date:   Sat, 20 Oct 2018 00:33:34 -0700
Message-Id: <20181020073334.48348-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

introduced with c46c406ae1e (trace.h: support nested performance tracing)
on Aug 18, 2018 but not affecting maint

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 1df5c16dbc..78f47d2f50 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2297,8 +2297,8 @@ int read_index_from(struct index_state *istate, const char *path,
 	freshen_shared_index(base_path, 0);
 	merge_base_index(istate);
 	post_read_index_from(istate);
-	free(base_path);
 	trace_performance_leave("read cache %s", base_path);
+	free(base_path);
 	return ret;
 }
 
-- 
2.19.1

