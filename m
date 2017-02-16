Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147C51FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 15:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbdBPPOi (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 10:14:38 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33075 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932213AbdBPPOh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 10:14:37 -0500
Received: by mail-pg0-f68.google.com with SMTP id 5so2231235pgj.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 07:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qydMrluMTq6MKFE5lLXU7N1NSY2ksosB24NZf5QOAm0=;
        b=BoLTO0Lhu6AoOzIelqG1ozYsvQuvvITCR0B7OFG1kwT9hQ2pPfhFPfW/aqkBZjhdgn
         V85uqlIIHuntCdJmH8NHkfk1ubsBDwOeaWWTfyEAoL/U/cOTnM9r2ZXLbkOOubBwN/QO
         q+A2q9miJoAQR6mvrEvdKEpTRQ/1k9C4HyQLZko0EgbfuCsNl2TAzEakArhU6YgUx//E
         BVYL3iy5QiSUmnaUw28Qe8VXD5EcaT9A3KHeo/VHPW7sxv4ngrTBKM+yXVyJvN3woYIn
         5Xk4JHSLMZ8ay2ofPWWdOobBIdkoV7PEa+5NG+Q4y033XjLDGRonwbtT0ewZhRpm5K2E
         Ar1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qydMrluMTq6MKFE5lLXU7N1NSY2ksosB24NZf5QOAm0=;
        b=pmaTGWKJlcffHUr9Yp21E8F33YYuycv6B2WVneeYy+gberR7Z+auqxkj8yaCYQj79d
         6y5Gyg5szyShIAcQJyvgsJl1K0NryWkcBbAP6LH9bxBsbZ0AAPZhPUcsYwnehndC6hbn
         h1EVnKYv8SMz1tUO42j1mp9eV98vMlV88eLrbk5G0ZK5B353jf2KnCneDHbGdMYzOBAp
         JD+qaY/+0Z9nmCBDO7B7ePQ8NuCocTbyYlFszV2b+I20ldsNa20gLmFaNSXbAEKCAReN
         Sya+wCf8c0Gm8RwD41UQOjytgNaPcNnffSbzPuCQlKW412xuGZ/qQS1rnm3d1gxOvIQf
         U3EA==
X-Gm-Message-State: AMke39mffyBxDTCGJx2fUBmpLNTRqgFSTjXcQ5V1H1HxzEt1ei45L/2Q1Vyl66Pkk3hb5w==
X-Received: by 10.99.202.73 with SMTP id o9mr3505612pgi.173.1487258076615;
        Thu, 16 Feb 2017 07:14:36 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id t6sm14504891pgt.8.2017.02.16.07.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 07:14:36 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 1/4 v4] revision.c: do not update argv with unknown option
Date:   Thu, 16 Feb 2017 15:14:11 +0000
Message-Id: <1487258054-32292-2-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

handle_revision_opt() tries to recognize and handle the given argument. If an
option was unknown to it, it used to add the option to unkv[(*unkc)++].  This
increment of unkc causes the variable in the caller to change.

Teach handle_revision_opt to not update unknown arguments inside unkc anymore.
This is now the responsibility of the caller.

There are two callers of this function:

1. setup_revision: Changes have been made so that setup_revision will now
update the unknown option in argv

2. parse_revision_opt: No changes are required here. This function throws an
error whenever the option provided as argument was unknown to
handle_revision_opt().

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
 revision.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index b37dbec..5674a9a 100644
--- a/revision.c
+++ b/revision.c
@@ -2016,8 +2016,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->ignore_missing = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
-		if (!opts)
-			unkv[(*unkc)++] = arg;
 		return opts;
 	}
 	if (revs->graph && revs->track_linear)
@@ -2234,6 +2232,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 			if (opts < 0)
 				exit(128);
+			/* arg is an unknown option */
+			argv[left++] = arg;
 			continue;
 		}
 
-- 
2.1.4

