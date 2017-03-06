Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3872320133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbdCFVIP (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:08:15 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35434 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754628AbdCFVHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:07:53 -0500
Received: by mail-pg0-f50.google.com with SMTP id b129so70421209pgc.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lITrand8zpEeDnZmIEIDLdKwy2lAuYQ5IvJ8E6kjfeY=;
        b=pRnKAeHNYxgA4Ky6iuoq60BGSsU49nhK5+7uCNfDDgrHUgEI7HnV7Mxk+XFhGW/FlP
         TMhSV1UReF8xUXbXqY9Z7UKNBdgT7goao6GsDDbmt8YxaHwXLO+BMnbVFyKe5XWFRZt+
         rzOXAX6gPpGOf7clj/TAIeAoK+7VnozQga8C1NyZODQ5I8Qj6b95eTPNQxpPrwqhBDuV
         8v6DkqPk+78WS9KWWanbgLJhdJbFDks1jslGWGHs6Sy9w56o3Fh1NR2t4WmGT0CfVe0i
         VsclDqQ32PxEOnw/7oS9Gro23kDbWdKB3kyDjJ5OrTRYzooSe93JaT3a4H4xAhib9sRY
         BDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lITrand8zpEeDnZmIEIDLdKwy2lAuYQ5IvJ8E6kjfeY=;
        b=L1ot/xIxzGLVG2KLuCJtsX7q9/HRyhtaV8Zi7ZY8x5Tx5yD62hrPUzaG1jif5gS36v
         qIqX2MJtUp1HHDDo6AUAbOzvIJr9Cm77gdjdAUnzIPS82fGYUQE40O7+JHfA4ZxrLSfm
         DS8JE5H/18jDB8zLJXFSjGTFbDph3A97OpMJVTkjgcs7NSFNCtlbuodEMOBT2DZNoSmb
         xyUbVeeTnHdvB2kJLzLP5ADM6/BPUYvyqGX0oXtlJ+R6rtlkNfKB0+6Kq7i6mra8/h75
         AaFM5MwV3/pkTLm/9H57R+gWn2KyKqb4QR7+oTbzYETCc5YJZvBObWQy41Wb3gK0ieDQ
         iOvg==
X-Gm-Message-State: AMke39nzgefqV8kXFz1jyuQj8Oy1LW2ZxW2S72PAkSWuo/mc07QDQ/QbO9nGzL7ft1Pb9+0r
X-Received: by 10.98.15.200 with SMTP id 69mr24240176pfp.100.1488833983275;
        Mon, 06 Mar 2017 12:59:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id c1sm41234133pfk.112.2017.03.06.12.59.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:42 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 16/18] entry.c: update submodules when interesting
Date:   Mon,  6 Mar 2017 12:59:17 -0800
Message-Id: <20170306205919.9713-17-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/entry.c b/entry.c
index c6eea240b6..d2b512da90 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "submodule.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -146,6 +147,7 @@ static int write_entry(struct cache_entry *ce,
 	unsigned long size;
 	size_t wrote, newsize = 0;
 	struct stat st;
+	const struct submodule *sub;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
 		struct stream_filter *filter = get_stream_filter(ce->name,
@@ -203,6 +205,10 @@ static int write_entry(struct cache_entry *ce,
 			return error("cannot create temporary submodule %s", path);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
+		sub = submodule_from_ce(ce);
+		if (sub)
+			return submodule_move_head(ce->name,
+				NULL, oid_to_hex(&ce->oid), SUBMODULE_MOVE_HEAD_FORCE);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
@@ -259,7 +265,31 @@ int checkout_entry(struct cache_entry *ce,
 	strbuf_add(&path, ce->name, ce_namelen(ce));
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
+		const struct submodule *sub;
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+		/*
+		 * Needs to be checked before !changed returns early,
+		 * as the possibly empty directory was not changed
+		 */
+		sub = submodule_from_ce(ce);
+		if (sub) {
+			int err;
+			if (!is_submodule_populated_gently(ce->name, &err)) {
+				struct stat sb;
+				if (lstat(ce->name, &sb))
+					die(_("could not stat file '%s'"), ce->name);
+				if (!(st.st_mode & S_IFDIR))
+					unlink_or_warn(ce->name);
+
+				return submodule_move_head(ce->name,
+					NULL, oid_to_hex(&ce->oid),
+					SUBMODULE_MOVE_HEAD_FORCE);
+			} else
+				return submodule_move_head(ce->name,
+					"HEAD", oid_to_hex(&ce->oid),
+					SUBMODULE_MOVE_HEAD_FORCE);
+		}
+
 		if (!changed)
 			return 0;
 		if (!state->force) {
-- 
2.12.0.rc1.52.ge239d7e709.dirty

