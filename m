Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10C711F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbdB0SCR (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:17 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33918 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wm0-f68.google.com with SMTP id m70so14622443wma.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KCC8UdpixqF1pH0fRj6HXP0GC3WxJI8WxB0c28fxFXU=;
        b=EPsT/dgvCOV+nhCNaE5yBdqLIk0nUEa41YXmdSGvnbEbZjppHeeUuQ7R8oNqKuN5Kc
         SXhnt6Vo+7aqfQWTfE6wwD2zEYWTl3HwU7vmdZ6Sk5NTKXoq5VJsEsSotqtFVz6FQMJo
         YskH8O8xCiia6vSGHVAh7GtkKT2vj7AfDlmmxojGtg/Ba/sB9HHsa7AfoOq1MKNNV48l
         QrY7Pz4g9hJpW90rGSjxNFpBDAEcaSgYteRK/qx7LPliY9dDt1T0khRAXef738q6doRR
         eAXngKwQXy2/7Ol2SqCJzsmrWxhOfM3NNHqFzpqOrvG52GX2KTXkD+91WKlbrfZ8pKqX
         ioKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KCC8UdpixqF1pH0fRj6HXP0GC3WxJI8WxB0c28fxFXU=;
        b=BkzMllANrMBtalSCshGJzBdjavoaAq/j5A92ra3TzU4hwp7kq5jPKtV8Hk++K4yoXu
         TTG5pSgfV1SDYs70xbxlTqUTqlc2iCb1IP8/efTSqmV7sqh+rumEMUjCOTyEAfCMMawj
         jj8pXZBxGo6lnItphh7zEh7C+/C/stVX13UH+69WYn1ZkLK6LPrfey6bM5wRCreQcUqQ
         Cu+2mtZQl0QDzmcwu5Y+rxoJ0LqnE70occ3UOnbasp8xSmvzf9raZviPl+V37FhASLw1
         syUieZjNAWXrgRNmrGiyS5bbPz+jq5O3iJdwQCuRkx7lpwb93n43sVTn+MasBeAghkZK
         ek3w==
X-Gm-Message-State: AMke39lQGxAwAcaIIw2nIHKETX3E12Dr3LBGguyZfzdUO8qh/nl0c1qf3QzQbLX+d8DXRQ==
X-Received: by 10.28.55.68 with SMTP id e65mr15446337wma.62.1488218445497;
        Mon, 27 Feb 2017 10:00:45 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:44 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 06/22] update-index: warn in case of split-index incoherency
Date:   Mon, 27 Feb 2017 19:00:03 +0100
Message-Id: <20170227180019.18666-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When users are using `git update-index --(no-)split-index`, they
may expect the split-index feature to be used or not according to
the option they just used, but this might not be the case if the
new "core.splitIndex" config variable has been set. In this case
let's warn about what will happen and why.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 24fdadfa4b..d74d72cc7f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1099,12 +1099,21 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (split_index > 0) {
+		if (git_config_get_split_index() == 0)
+			warning(_("core.splitIndex is set to false; "
+				  "remove or change it, if you really want to "
+				  "enable split index"));
 		if (the_index.split_index)
 			the_index.cache_changed |= SPLIT_INDEX_ORDERED;
 		else
 			add_split_index(&the_index);
-	} else if (!split_index)
+	} else if (!split_index) {
+		if (git_config_get_split_index() == 1)
+			warning(_("core.splitIndex is set to true; "
+				  "remove or change it, if you really want to "
+				  "disable split index"));
 		remove_split_index(&the_index);
+	}
 
 	switch (untracked_cache) {
 	case UC_UNSPECIFIED:
-- 
2.12.0.22.g0672473d40

