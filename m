Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0CD20133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754638AbdCFVHz (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:07:55 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33635 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754609AbdCFVHo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:07:44 -0500
Received: by mail-pg0-f49.google.com with SMTP id 25so70462284pgy.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=17o2biyEwuX5S72bVx8uByIiXmuJSuWYZrscy51qXNQ=;
        b=U/irOrQSJwd7sA0A/2ClzlijMP/KWtYB2pzq0tdO1af3ZGqc4bAO613UUXHr+0kiQR
         iXh9ty+hhezS4MqeAZdRnl1ct0BiTsn+d5jQKEfSSeAHYvtO9XWzpBICvEiWtkx2qCwq
         c6j5odopHBIS6KDYRLR1XTVOpEpkHNQRmEPjq+gnFa070W45thBh+ViJhW+neRcHe7jl
         B5QQDsOj0UYxiVAWK7uM1L7vRoYhVK4EIp6zM7QxR7E5fnMEYlCVquC+ngm3Ke3PbDvJ
         gUIIVWOIzlfKBAhFEsZMy3gM4iCFDKvYxcMcV5g2UVP9jyMvZCl44DJ9AGe4CXzFkvun
         2hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=17o2biyEwuX5S72bVx8uByIiXmuJSuWYZrscy51qXNQ=;
        b=clSMYRd9fO8vqhcnlb7ZDcgGA5RS9i+o0WX/kHGyPj+ZDRjIyv90ZCQpwIiIdODlu/
         kQdOamhnHFEV//JSij+fYasyuykSn26+bLw2qWyQ8Xi1oCTPXypcgaii14r13qCyUXYS
         STwUMue5l76zn3mb+gT0z8luRVIJWlovicCJ/FtlbViwelEgEBoITZo3xLPCg7vW2PUd
         tQgFcwEXNnBKNviyMjIQpfNOuvSrVUL+NEpxcOH89SedS4e5p1ZAMYA+fhvOoVZ2mPuA
         /2kZbirXn4PjT9aC1FO5EcBAbLz1xwHMqX4eoDlxw+oUJ/qlrxHxu7DvBA2WLFXhpVfz
         W4Zw==
X-Gm-Message-State: AMke39koBXyouRONSK3DLrz/XlReDI+eQ4G1yefMENBKLWNmd1j7tio4+83fJOrbI2D4e4mj
X-Received: by 10.98.163.17 with SMTP id s17mr23410486pfe.61.1488833979734;
        Mon, 06 Mar 2017 12:59:39 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id d189sm41562665pga.17.2017.03.06.12.59.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 13/18] unpack-trees: pass old oid to verify_clean_submodule
Date:   Mon,  6 Mar 2017 12:59:14 -0800
Message-Id: <20170306205919.9713-14-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
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
2.12.0.rc1.52.ge239d7e709.dirty

