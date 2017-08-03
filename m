Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C681F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbdHCSVe (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:21:34 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:38363 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdHCSUK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:10 -0400
Received: by mail-pg0-f50.google.com with SMTP id l64so9223111pge.5
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wmpO/xIQ5qyM7TD63yqxvQeo/Cm/CrbRgYWhtHrBIBk=;
        b=nWS4K0yTFpao61rsAaczt3UEJY+gBwtw3JEOc5HZQIAB+TX2PrDyb02He3eXpEJxew
         Fq3lauGnr1P0tDzYarWQR9CJeCwV4Qn97WaBqcxLdrUYtePlXM9P0Rj4huj/VKWE11+v
         ci86Cz7kQ5VVHBB//4EuzEk1qxWiStrlgAgQ60E4rD2zep9YtNnaHv6b0OVWa93FrkuG
         G8QnxDBW0Qyyl/jsHX+QFrpCtbYRghCA++I7y06qdaeLX8F1Yypb35ilSzxV+Zm/j5jD
         0g2SkSTIyl4npjAxT+UySi2Ggkj8lITA/99J/Wof/6zX6/cc7BEr7vq3WE8Dan/XBw5W
         GFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wmpO/xIQ5qyM7TD63yqxvQeo/Cm/CrbRgYWhtHrBIBk=;
        b=bzBUXWzKOqtain2xQf5maZsT1qYseZuVyHQiM/sv4CTpvA2csHkxFWPN07r7li6DKG
         JXNEF/VH36IQtYEcb24J5aTpvGK0+YEklUEf8wYCYPxB+0OgpZNO+oQC3O238Bt6IKXd
         /+ZL8AP59oNRs2o1kqkloSN/EzcBuoLrsc4P0GIBDDWmyJS8lptYrFYfj/EwqfF04M/K
         zuXX2zOE+g7i/+jt+YdSywdcACkGj1R3taKP/ja6Cl0YKwYyqsVNmnjKm2Th//JZ33ZS
         Bm4/euerwBcc7jLipENTDD3pDS5gNHAxGPQ4KQt/mRm2UvVmAUAh4GlhTGB733UIxYFx
         09kQ==
X-Gm-Message-State: AIVw112D8pMvT4sV56ZEYZEjGmku6JXVfXw50biRYw1p+3Wls3QPqQQw
        6atnTBE63qE+WXUbM4IH0g==
X-Received: by 10.84.176.195 with SMTP id v61mr2816366plb.271.1501784409032;
        Thu, 03 Aug 2017 11:20:09 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:07 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 02/15] submodule: don't use submodule_from_name
Date:   Thu,  3 Aug 2017 11:19:47 -0700
Message-Id: <20170803182000.179328-3-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function 'submodule_from_name()' is being used incorrectly here as a
submodule path is being used instead of a submodule name.  Since the
correct function to use with a path to a submodule is already being used
('submodule_from_path()') let's remove the call to
'submodule_from_name()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5139b9256..19bd13bb2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1177,8 +1177,6 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 
 		submodule = submodule_from_path(&null_oid, ce->name);
-		if (!submodule)
-			submodule = submodule_from_name(&null_oid, ce->name);
 
 		default_argv = "yes";
 		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

