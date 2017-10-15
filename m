Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1741C20372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdJOWHx (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:07:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55084 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751585AbdJOWHt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5216E6045A;
        Sun, 15 Oct 2017 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105267;
        bh=zb2BbNtb+SGlKboPwYLHLRcpdGOWvA6hydoLlnB2w5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=IMKRFk2oM0Hix0ZuQmUID9Ra0OA5Q5PoAQ1tgprojwXQElYjiY+2XxxXuaOdNWMrZ
         uJ6/HKF58B54Cd7ezHcwB3exvZtnBQYydejsAMS+m+JrFZwsCg6y739p3qCX67RbXM
         eljCnGGGGv8/WMSYtmLX92iG1AZPcjeMVdVzOfN7XRSROlbHvJgqw6hxUZZiDMJ69N
         Vls8dUxzZHfmy0QKwQZwMZ/grwKaTKovZHEy58yKqGNc+qxJA5r/4+o3O2n3HPlKu3
         D80tqjyeatsVVzShB3RVVOpBgrhfhW13wZ8w6zFyMei2hEnk0XWg1lAsL55CshIzt4
         mMGw8MJYDUtxBwXcWo+pC+nW/tIe0sFIEsI+4M4YNAUz0KmgxiX8jb3W9BhiFj18lV
         9f7dQOz35mxM7LyP7h/gAlBZfeMocugToNUK464U5h2F1yd2GkAUSZs4I91vSnUWq6
         w2Ji5DdwFgb4q3OjaUqAt0za70PF3cWl54D8GHDA/YWFR7EzgAi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 11/25] builtin/reflog: convert remaining unsigned char uses to object_id
Date:   Sun, 15 Oct 2017 22:06:58 +0000
Message-Id: <20171015220712.97308-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining uses of unsigned char [20] to struct object_id.
This conversion is needed for dwim_log.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/reflog.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2067cca5b1..302fafbeef 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -42,7 +42,7 @@ struct expire_reflog_policy_cb {
 };
 
 struct collected_reflog {
-	unsigned char sha1[20];
+	struct object_id oid;
 	char reflog[FLEX_ARRAY];
 };
 
@@ -385,7 +385,7 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
 	struct collect_reflog_cb *cb = cb_data;
 
 	FLEX_ALLOC_STR(e, reflog, ref);
-	hashcpy(e->sha1, oid->hash);
+	oidcpy(&e->oid, oid);
 	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
 	cb->e[cb->nr++] = e;
 	return 0;
@@ -589,7 +589,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
-			status |= reflog_expire(e->reflog, e->sha1, flags,
+			status |= reflog_expire(e->reflog, e->oid.hash, flags,
 						reflog_expiry_prepare,
 						should_expire_reflog_ent,
 						reflog_expiry_cleanup,
@@ -601,13 +601,13 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	for (; i < argc; i++) {
 		char *ref;
-		unsigned char sha1[20];
-		if (!dwim_log(argv[i], strlen(argv[i]), sha1, &ref)) {
+		struct object_id oid;
+		if (!dwim_log(argv[i], strlen(argv[i]), oid.hash, &ref)) {
 			status |= error("%s points nowhere!", argv[i]);
 			continue;
 		}
 		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
-		status |= reflog_expire(ref, sha1, flags,
+		status |= reflog_expire(ref, oid.hash, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
@@ -659,7 +659,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 
 	for ( ; i < argc; i++) {
 		const char *spec = strstr(argv[i], "@{");
-		unsigned char sha1[20];
+		struct object_id oid;
 		char *ep, *ref;
 		int recno;
 
@@ -668,7 +668,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!dwim_log(argv[i], spec - argv[i], sha1, &ref)) {
+		if (!dwim_log(argv[i], spec - argv[i], oid.hash, &ref)) {
 			status |= error("no reflog for '%s'", argv[i]);
 			continue;
 		}
@@ -683,7 +683,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.cmd.expire_total = 0;
 		}
 
-		status |= reflog_expire(ref, sha1, flags,
+		status |= reflog_expire(ref, oid.hash, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
-- 
2.15.0.rc0.271.g36b669edcc

