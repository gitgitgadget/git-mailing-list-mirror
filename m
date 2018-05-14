Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EEE1F406
	for <e@80x24.org>; Mon, 14 May 2018 21:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeENV4y (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:56:54 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:48663 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeENV4w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:56:52 -0400
Received: by mail-yw0-f202.google.com with SMTP id i22-v6so5803129ywe.15
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=+A/ZUoMD4mcuqeqQk3akjirRmp1jVsMHzxopLFJYfy4=;
        b=rnoRQkb6tH+jJ271xdLPwVRPgN/aCM90gZ3bSi3TlnSh9Zya8sJlXL7TBm58d/w63i
         Yh2z1B52WpkqOtMeoSz8ZkpRjdT5Kl+KG6Aauq/g8muBAU5VAx5uFayvGttAZ2vFG/mK
         0KoKvJMRNR40CIKki3S3lUkt98P48AZCNoIdEyp4Z/UvwYKfu2zkJ42BIs4MWF9ldiwX
         8oyMuY3zgLZ3WExa9RiYN3nuOIjwCKvfcTITn/EzUZZp1psX71Lc/U8lSIIxoxKJt4ue
         E1Xou3HWMLHUcOS3NZTPfXd2R4SCJ1998fo/X9Yg8xTi3spONo9JVoZPVwuMDHlgWe4k
         J5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=+A/ZUoMD4mcuqeqQk3akjirRmp1jVsMHzxopLFJYfy4=;
        b=AjLpp430+OAmIU3wRfRaGkdG196urOu4GNmOxR2KYEyFI1jLo/g7qfwtu+NRkeRTv0
         w55KruA/3EJQQ/k5VXazAdS6gaNJ7BxmwZ0+y2V+ifXt2l80Xwj8w0eAfaqROslwh0PI
         d1YlHoflmhdexx6vzyFzf5s5TCQVwIZ9We3I7h0O2lYpwHAVbHsE/R1aAzgPTei/fXSF
         q3v6qK7HS8NOI/rEASfenud2bJpYsWvqHPJoX1n9vntvkziDNfhis3q4XIOZAa61jrgl
         NgZzda+Pw1p39AMl8Aufgt+8jdKOtvUXmhYu2Lw90K2mfoFQLhxIglA4wMEOCFUaJYgv
         rbEQ==
X-Gm-Message-State: ALKqPwfXAtd6Ca86xE4MoWJsIhsZXYw/QiHNUeO2HVKwCaM6YSOBWWht
        SDGFnPHfBKY119xeg5DdTkkQ3cyk5EkyBgfI5BmvcrOd3cHp0VSztiIUypah01mQj/jhoLSyZK/
        Ou7Pw+ApjXNnQl0AetF1Dgd3N4gx3q/z3AGEdvFc9V0OXYCvyi74UMMAUog==
X-Google-Smtp-Source: AB8JxZoYRJ/gWdBTnKQ57H0ts84rBS1Ld9zK7yfZpD/i5lmstNdytvNU+bNdlA5V7luLoQoArSWTNuDxTqg=
MIME-Version: 1.0
X-Received: by 2002:a0d:dbc9:: with SMTP id d192-v6mr3355814ywe.64.1526335011986;
 Mon, 14 May 2018 14:56:51 -0700 (PDT)
Date:   Mon, 14 May 2018 14:55:57 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-7-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 06/35] submodule--helper: convert push_check to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'push_check()' to use 'struct refspec'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c0c4db007..88a149a2c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1744,13 +1744,14 @@ static int push_check(int argc, const char **argv, const char *prefix)
 
 	/* Check the refspec */
 	if (argc > 2) {
-		int i, refspec_nr = argc - 2;
+		int i;
 		struct ref *local_refs = get_local_heads();
-		struct refspec_item *refspec = parse_push_refspec(refspec_nr,
-							     argv + 2);
+		struct refspec refspec = REFSPEC_INIT_PUSH;
 
-		for (i = 0; i < refspec_nr; i++) {
-			struct refspec_item *rs = refspec + i;
+		refspec_appendn(&refspec, argv + 2, argc - 2);
+
+		for (i = 0; i < refspec.nr; i++) {
+			const struct refspec_item *rs = &refspec.items[i];
 
 			if (rs->pattern || rs->matching)
 				continue;
@@ -1777,7 +1778,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 				    rs->src);
 			}
 		}
-		free_refspec(refspec_nr, refspec);
+		refspec_clear(&refspec);
 	}
 	free(head);
 
-- 
2.17.0.441.gb46fe60e1d-goog

