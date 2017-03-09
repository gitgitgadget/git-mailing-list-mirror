Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F8B202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753729AbdCIWQP (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:15 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32951 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbdCIWQN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:13 -0500
Received: by mail-pg0-f47.google.com with SMTP id 25so31172134pgy.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6uLq2dfHpSqdRGB32jFwNk0Z0f2erH6PLCqV5+Wc4A8=;
        b=W6SdjlsaqjZIKd/n51B39bmKY4mbmQpcoftcCC36X7275oNtsPgV9u6i2G3QqonhNl
         GZXQMDlh1kzCLd/M5KTpEiRqupMsMKAsoZhh922T19QqGewOxYJ14vXbbQxlgz8IH5gg
         hp60YZ5S70G5HDl4YtnW+hw5DpnjgGjBpcWYZ1/hSBnKxzE5firb3Jcy9k6RbmrfBqe2
         jsYqus44/qoIMK61idahzP8RJNRqWHwevkvFifcQU1a6S+CLGYrrCiYY4A/QB0arom/I
         iaRzK8umWB/KxNkmyupeh0t4AiX8WZgNgb8d5ljz/LRTwnIwDDzgq00Xa+NW25gRbxGt
         hP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6uLq2dfHpSqdRGB32jFwNk0Z0f2erH6PLCqV5+Wc4A8=;
        b=rLNIaQNKnDiKiA5Uw0HOcrp1v0kF27yAkzBwlg0NcRAzx3ksqszWdTYtmF6YFC66vR
         dtG0JWflObav/mWizf0mrxgbzaMeNDFFjpAOEkEnakmAQyv9c2WW4fbW/tuRJ6UHL42/
         LBLFPcAYCMuqd/oGFvKbtSpjsVKe5D5J6OVpIPvgl+3pz7uRvg6DaOsR+666if1LolCg
         nkZmsM8MPPV5jp0elbx94MB+jJSsUeGF0dbw/3A4CoPSZpVKbdRQV7Jt0JyeRExhSgZ5
         Ga8uGw9aoSdNHazamV4pHJ+e0Cx2gPHAwkQn/zhmk/J+c4ZGSm2ArIfhtkSK06fe392y
         NnCg==
X-Gm-Message-State: AMke39l9d3FvA37MIuM+E+YFbo6AIQZxtQPThnb+uBhZsw+1VcE4wRzk92/RV4REStPYHT9V
X-Received: by 10.84.209.194 with SMTP id y60mr20420144plh.115.1489097772016;
        Thu, 09 Mar 2017 14:16:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id e129sm14377123pfe.8.2017.03.09.14.16.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:16:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 13/17] unpack-trees: pass old oid to verify_clean_submodule
Date:   Thu,  9 Mar 2017 14:15:39 -0800
Message-Id: <20170309221543.15897-14-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check (which uses the old oid) is yet to be implemented, but this part
is just a refactor, so it can go separately first.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a8ee19fe8..616a0ae4b2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1407,7 +1407,8 @@ static void invalidate_ce_path(const struct cache_entry *ce,
  * Currently, git does not checkout subprojects during a superproject
  * checkout, so it is not going to overwrite anything.
  */
-static int verify_clean_submodule(const struct cache_entry *ce,
+static int verify_clean_submodule(const char *old_sha1,
+				  const struct cache_entry *ce,
 				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
@@ -1427,16 +1428,18 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
-	unsigned char sha1[20];
 
-	if (S_ISGITLINK(ce->ce_mode) &&
-	    resolve_gitlink_ref(ce->name, "HEAD", sha1) == 0) {
-		/* If we are not going to update the submodule, then
+	if (S_ISGITLINK(ce->ce_mode)) {
+		unsigned char sha1[20];
+		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", sha1);
+		/*
+		 * If we are not going to update the submodule, then
 		 * we don't care.
 		 */
-		if (!hashcmp(sha1, ce->oid.hash))
+		if (!sub_head && !hashcmp(sha1, ce->oid.hash))
 			return 0;
-		return verify_clean_submodule(ce, error_type, o);
+		return verify_clean_submodule(sub_head ? NULL : sha1_to_hex(sha1),
+					      ce, error_type, o);
 	}
 
 	/*
-- 
2.12.0.rc1.45.g207f5fbb2b

