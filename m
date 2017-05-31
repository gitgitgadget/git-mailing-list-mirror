Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AFF71FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbdEaVpl (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:41 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33588 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdEaVpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:25 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so18626171pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hTJGcGOO7Afr6ovCVjrpTZ97TRhxeHoFWFwcnsBkZ/w=;
        b=JwVyQh/GIeqIoeVlxFGUUa6f5LR1QDPI7JO6k6TaKszMva6CR7NVqFnF0ddXgU0joL
         cXUgld3Aiu4hgzbsPtzqVCF0kJ8aUljaupLFXtGaqQTYMYf16YEpiz6er50o5r5sOzul
         /wzH3uGU6brl8F2iAWouYme9hJ74159zJPDkHNEENxTbSXWCPEGzPpPVkdgtMfEy3cda
         g3zOwzmidFxABFLPI1WuJXGU1IZfUzvGK6bf6EADGcaKzzOoE9B7P8TrMyffvkWK3I/9
         +N1t8q0bBBDUPKpRSejph8mX2z5odGp2T2ODbuA7ahPd/AIuDfECDzgpn25e82N9xn1c
         jSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hTJGcGOO7Afr6ovCVjrpTZ97TRhxeHoFWFwcnsBkZ/w=;
        b=eOxd9HjDoEeneDcHC25j3ceEowbdtuVQNP/TrRwX1+gUBDes0g9T7bh7XVJfYlmGhc
         U2hj8xiXL2iwqmPLs7m7u8gRZo9NDZE65VukJVkNF4b0PUEuSby6OGgFKOJrAZOjQmr2
         32cGKiLtm9AYrglwmIMEPixVcIlYN8M0EDGXTdrrWkwiYm61avl8ZSmh/4+F5cFWbGnA
         Hv+VD0wwA7jS5Sl8GwxfTUSXXlP4gBJ2NxwXPNSxrmI07Q+1SdAsfpW/abQ0K7UNCOJw
         w1BvfH2e/UD12APV0BwWPKHN3em1q+dPat6kOprusGoiOmwPrJZ41fNtFhOHnP7DcbxC
         IgdA==
X-Gm-Message-State: AODbwcDbilDrJK9GGnAQNmkgORXBHIPFlTJz2hPdAHv/CYV9aSBgkkU7
        oEUeOnA6xK040XQv
X-Received: by 10.84.213.143 with SMTP id g15mr92152535pli.53.1496267109818;
        Wed, 31 May 2017 14:45:09 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:08 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 23/31] ls-files: convert show_killed_files to take an index
Date:   Wed, 31 May 2017 14:44:09 -0700
Message-Id: <20170531214417.38857-24-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c37e9de11..f9578cf9f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -121,7 +121,8 @@ static void show_other_files(struct dir_struct *dir)
 	}
 }
 
-static void show_killed_files(struct dir_struct *dir)
+static void show_killed_files(const struct index_state *istate,
+			      const struct dir_struct *dir)
 {
 	int i;
 	for (i = 0; i < dir->nr; i++) {
@@ -135,29 +136,29 @@ static void show_killed_files(struct dir_struct *dir)
 				/* If ent->name is prefix of an entry in the
 				 * cache, it will be killed.
 				 */
-				pos = cache_name_pos(ent->name, ent->len);
+				pos = index_name_pos(istate, ent->name, ent->len);
 				if (0 <= pos)
 					die("BUG: killed-file %.*s not found",
 						ent->len, ent->name);
 				pos = -pos - 1;
-				while (pos < active_nr &&
-				       ce_stage(active_cache[pos]))
+				while (pos < istate->cache_nr &&
+				       ce_stage(istate->cache[pos]))
 					pos++; /* skip unmerged */
-				if (active_nr <= pos)
+				if (istate->cache_nr <= pos)
 					break;
 				/* pos points at a name immediately after
 				 * ent->name in the cache.  Does it expect
 				 * ent->name to be a directory?
 				 */
-				len = ce_namelen(active_cache[pos]);
+				len = ce_namelen(istate->cache[pos]);
 				if ((ent->len < len) &&
-				    !strncmp(active_cache[pos]->name,
+				    !strncmp(istate->cache[pos]->name,
 					     ent->name, ent->len) &&
-				    active_cache[pos]->name[ent->len] == '/')
+				    istate->cache[pos]->name[ent->len] == '/')
 					killed = 1;
 				break;
 			}
-			if (0 <= cache_name_pos(ent->name, sp - ent->name)) {
+			if (0 <= index_name_pos(istate, ent->name, sp - ent->name)) {
 				/* If any of the leading directories in
 				 * ent->name is registered in the cache,
 				 * ent->name will be killed.
@@ -338,7 +339,7 @@ static void show_files(struct dir_struct *dir)
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
-			show_killed_files(dir);
+			show_killed_files(&the_index, dir);
 	}
 	if (show_cached || show_stage) {
 		for (i = 0; i < active_nr; i++) {
-- 
2.13.0.506.g27d5fe0cd-goog

