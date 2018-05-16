Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA531F406
	for <e@80x24.org>; Wed, 16 May 2018 22:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeEPW6z (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:58:55 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:37405 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeEPW6x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:58:53 -0400
Received: by mail-qk0-f201.google.com with SMTP id a125-v6so2345199qkd.4
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=+A/ZUoMD4mcuqeqQk3akjirRmp1jVsMHzxopLFJYfy4=;
        b=BCOMCoWKktkk0Icb3MIxZRHB28kFfvw7xFziJ/A5RqWCDvLXmJFF68uvNuPYL5JcoB
         1pNhCFhYIWBhmB4wukjgCJDWMLfKtZrI+QIFWNu/o4nC46x0e6xRHdxkXRBYVg0nvVVz
         JY9/j6nSsXHed298AMsvOc2kIFyZx6WbjiosvDoJ0FN5VDB1kyW+Rk0ABAQN16fkpfu+
         IS6069gtcW5jwW47exGC79DvQn9/HpvwTc1ifz0OFuYP4XbGxQZIiTuRsC3WZf85f7OE
         QB/MrBeDjFB+8MHZiGDgSUO58u2LYeD299mlgvMBwbls0EeRO3ksL1mL+Cbj4ti/03IW
         ci5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=+A/ZUoMD4mcuqeqQk3akjirRmp1jVsMHzxopLFJYfy4=;
        b=QLmBm7sdwM5jEZ3sFXP95rmYnKmnZ0oSskMvuL5ifXGjt50HHzANr9U/xVUWC39IpQ
         AHYbcxdmmJku+yyP2QEAB9Y40ZVXrUTtDMuhC305Q+bYH4nty+D4/OTWhIfXH35JMX9i
         ++os3ps328Mo9/G7fVdyeIyv50RsjDwAsRU2OXw+xd6MCCIcL9YmYJNlGWTAKB/y75Ii
         tKO8s6KtsdGu5F4yZc5KFsFumIpx6FZg25ty1vgY5j1gLQGlCxVCoeUmeOKm6HtPvNl2
         PsWWedLxf9zUlpcVX1bZ6MQu0HC8/VcQy+U1nYCbRr8FK0HNWmGd2Z+pWWL4BmiE9Ipt
         re0w==
X-Gm-Message-State: ALKqPwcNOSzkXMzamg7UyYuRTpiKSRvJZRZOffdwrsmRw0/bSW4+XZQq
        17+pdR06TEKylqoF2GNf/btKGtHFF6Kr5u0sBEUW8TIxb/Mv8ud/iJZ2BA5VOw99rizt6kDpLtZ
        52zJTz5yOu9IgB9CoMuhcASx1x1QsgeRmjJTashrelGDwMPxT1aV0G1ETPg==
X-Google-Smtp-Source: AB8JxZqP6Czwba7IrRWBARdECBfIIbcMgiO0HkkyDHn4DHFg+iuAB48DDbxGsSIdW1494A+DEAXpkV8T03I=
MIME-Version: 1.0
X-Received: by 2002:ac8:68a:: with SMTP id f10-v6mr2959861qth.9.1526511532575;
 Wed, 16 May 2018 15:58:52 -0700 (PDT)
Date:   Wed, 16 May 2018 15:57:53 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-7-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 06/36] submodule--helper: convert push_check to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
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

