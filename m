Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9F01FDEA
	for <e@80x24.org>; Tue,  9 May 2017 19:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbdEITSm (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 15:18:42 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36560 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdEITSe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 15:18:34 -0400
Received: by mail-pf0-f177.google.com with SMTP id m17so4535657pfg.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8psKbVyOrGoK3TMPA749cyJlAs6VW+utgoaaZQcEMs=;
        b=YgKT9KCt0IyJb4NjZXRT5eNgGhWk2K51khix0VLE99HlYMDIQ2cWdBYPYH1mveZxO+
         l318LZLESkcKJmXQ/h1p9DuHkOToU3zyEizgG0wZQL5rn2fXHqk/+XfHC7Nrv2plibhz
         s5lSskZEuVscJb945AV4/7TIMT2gR1gF+AC2ZbLNAREmHUIVdq9qp5mUuo/5ST4UpRKp
         lSivybGKDCLMuo60JHbpAdKvlAoBvdC8Bx5BnZ60ZKRKxsXJM1Vca7+HezCu9joMc8oH
         zrT2LbI51ms7ui9m+CFQOv6cWB+518HkeBVeYcyYe+k1rqG+FZ0Lh9enpLHAFHrgKrge
         EOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s8psKbVyOrGoK3TMPA749cyJlAs6VW+utgoaaZQcEMs=;
        b=Eeen0tPBCzsWxsyd8twqpnegpc/V/43b6KIPwT5VipuPPWgSHftw/cxcXxiPTeFuwg
         iacK8ayqFaW5Bxy0Om3I6v6mjttzyKTV/qH4hSnopsQtBeo0MwTxxkwffD+yS2EMlWa0
         cJ991mIGCzG4yAvdFc/3bRaLZpAbxnxSCpNAJ7FenpxyvT6+unuHU8E1UotZASY8DlSf
         /MS6014ZRlfrHRuWdty34ciK4p2YOx/DMdh46ir9NV7khCC1DmpIBKyqqkDiQbroQTMB
         B+tZtaT2YgPgmDHpRdWCANZisjgwtKbsAQXbwEUen/l6xiBY8YtLCbhOOjGV7//ZESXd
         vzbA==
X-Gm-Message-State: AODbwcBMo56jOv6FbSgxqSV1FB15iRkIi2wOL41o+6fjeMmrpnRfn7+P
        3Klqm2NdQ+OJgA/m
X-Received: by 10.84.233.131 with SMTP id l3mr2436116plk.18.1494357513984;
        Tue, 09 May 2017 12:18:33 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id w23sm1124427pfl.133.2017.05.09.12.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 12:18:33 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 7/8] pathspec: convert init_pathspec_item to take an index
Date:   Tue,  9 May 2017 12:18:04 -0700
Message-Id: <20170509191805.176266-8-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170509191805.176266-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index bbd71b48b..c7ed8b3fb 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -430,7 +430,9 @@ static void die_path_inside_submodule(const struct pathspec_item *item,
 /*
  * Perform the initialization of a pathspec_item based on a pathspec element.
  */
-static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
+static void init_pathspec_item(struct pathspec_item *item,
+			       const struct index_state *istate,
+			       unsigned flags,
 			       const char *prefix, int prefixlen,
 			       const char *elt)
 {
@@ -500,7 +502,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	}
 
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH)
-		strip_submodule_slash(item, &the_index);
+		strip_submodule_slash(item, istate);
 
 	if (magic & PATHSPEC_LITERAL) {
 		item->nowildcard_len = item->len;
@@ -627,7 +629,8 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		entry = argv[i];
 
-		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
+		init_pathspec_item(item + i, &the_index, flags,
+				   prefix, prefixlen, entry);
 
 		if (item[i].magic & PATHSPEC_EXCLUDE)
 			nr_exclude++;
@@ -653,7 +656,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	 */
 	if (nr_exclude == n) {
 		int plen = (!(flags & PATHSPEC_PREFER_CWD)) ? 0 : prefixlen;
-		init_pathspec_item(item + n, 0, prefix, plen, "");
+		init_pathspec_item(item + n, &the_index, 0, prefix, plen, "");
 		pathspec->nr++;
 	}
 
-- 
2.13.0.rc2.291.g57267f2277-goog

