Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994511FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbdFHXmJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:42:09 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35092 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdFHXmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:42:01 -0400
Received: by mail-pf0-f179.google.com with SMTP id l89so22168040pfi.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HQWPwf6BWsQZ313oQ5XcERQJl1wZQF10lGJFSpeezPo=;
        b=PKLyvNboqqA9oOXBsdryfvK0juiOomyEOdvIU9HvljcIMl86Q4sZZuEPJueDWzAuS7
         nIVC8nAzqA4z4mdPyGPv7yfDvxZZ5ln4IM4+HIPly2FWiui/ASVZJF7L3wPgLapCz8vO
         R6noV6htj3A46XfLwRIG08vy1lcPwccWolnHCX2+vnttEjhO0J/BIEgnrOIPXF6wvxTo
         Fy8nSnu7Lw4W9sS7OHkQutW8Y++WDGw/tGrnKQpWP38qmSDhbRB7iKUmyAzfhjEMZnEA
         ZBNjYOisxVCIklGQWJUPHO8sL/qgU0lwGvOMGxQpxlFRHV42qPBvJeCOitGIaBmZ876n
         Mx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HQWPwf6BWsQZ313oQ5XcERQJl1wZQF10lGJFSpeezPo=;
        b=s2MU8ez5Ctg646oPTtcxKt+T2nsdwoK3qoCGmWy8tWc/dMF+VDtxGnr4qeMPNRCRY3
         URINlB5uq+GmVCjNyN0//twnk230WQSbPBh9u6d1m6/wVTbAQK05inrkm4rhjwAkOqnV
         rTyV0j4G87mEBu8uQsPFs2czonoowiQ2EYDZhOeiwryYvK670Gl6K659mSiTG80QnIIJ
         75N8mTD8GbniT0p//u+1RMyTn0tOloaTC+pJHnr6HmE/iFrW3YZzdifLfGx8TVoXwD96
         MpGLPIPBvp5cWQkhQdvZ0ULenCXHGatY2GaTM3A3FPJ2GgDWx66mtv4Rarf1iRdZiFhS
         tVHQ==
X-Gm-Message-State: AODbwcCBbCwyb8tZQ0+qmht+YgswgbKqBDMAKiQjeI3MjD0w0g8mOLmx
        4MHXG9lrvejPov4VH/kfzg==
X-Received: by 10.84.150.130 with SMTP id h2mr16478474plh.152.1496965315134;
        Thu, 08 Jun 2017 16:41:55 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:54 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 24/32] ls-files: convert show_killed_files to take an index
Date:   Thu,  8 Jun 2017 16:40:52 -0700
Message-Id: <20170608234100.188529-25-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
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
2.13.1.508.gb3defc5cc-goog

