Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E3C1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeBFAKS (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:10:18 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34962 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeBFAKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:10:16 -0500
Received: by mail-pg0-f68.google.com with SMTP id o13so150064pgs.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KHMPtZ8LWf8NKCRSooxd069vD/yt4pWxvV0NG7EKmvE=;
        b=MyrBImYpVPRuL8a0WcFZ5esVqYkzkDZoOsmbLtETXiMJe6HVrFZQg6YT9MfLU7WArr
         jbPvD+Qbc2HO5SQFCjNoiZLkqr9sfi0iz1vc2EcP/BcKX8Jxw+mMuzNupXl8NaleK8kS
         B9CqIsh9Y2RkWnbfrmnBKMgHF78vR7lvxZH99Sc1dL8/6bMW5lbDnvT8c1devHLabhZT
         zQF+J/qQ6rWVG0MXu0XoziejSZJV3DySJAKyDulfRMx4HYWyMHw/YHYpNiCY5GR5dJg2
         rkSheqRRoQAKTBHKyKliHkN7YBemeZksZAd11+H4lVW+Kti6IwhWl+zjI7SlnkpvDaCh
         G0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KHMPtZ8LWf8NKCRSooxd069vD/yt4pWxvV0NG7EKmvE=;
        b=pYIOooy1lQlhnUZsO+u3FUta3wcaMfG2FyXRsuvTt9gigdx/V/I2r85vC9x2qNirkI
         RByFQEwElrzrqc+IN8vPXh86jw6mNTa5iswR0AAbWeqRXVtNHoiRqGNYcAJeRPNzynnk
         e91WKM8iamp7J6JGcQyDH5HZxG/uewik9U+mWgUo/INnuxbVuDU3dq69riujkdyHv3mK
         JLu5r3d1J7IBfsfEBO3sh1506NGMVkIwbzgv6Qg7YOoHLBwgxZuFGlxWWBzmxIV6IrzN
         +OfsiNGjnTJgmVIbnli4N08Hsqdi9K0vGDcSK3jFA1eiJJG/d+QTxrneanbjNfGtvvhz
         zaaw==
X-Gm-Message-State: APf1xPBkfE1x+hIXjQfpKd+o0KQ34/8L1u9nXkpLsq6km5DxMVpc2Ov/
        8TkRknaI0gMyjj84fowUwjyRAmpmtTg=
X-Google-Smtp-Source: AH8x227DO67KWJ5qv+LdgSVhp8Vsafg6yhjTuaau3N7zlRp5eAgJibm6/a8ozXTYmfdseTUi2Kchjg==
X-Received: by 10.101.80.69 with SMTP id k5mr396763pgo.443.1517875815848;
        Mon, 05 Feb 2018 16:10:15 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i128sm18595508pfg.83.2018.02.05.16.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:10:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 075/194] fetch, push: do not use submodule as alternate in has_commits check
Date:   Mon,  5 Feb 2018 15:55:36 -0800
Message-Id: <20180205235735.216710-55-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both fetch and push still use alternates to access submodules in some
other code paths, but this is progress towards eliminating the alternates
hack that conflates access to the_repository and other repositories.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 52 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/submodule.c b/submodule.c
index dc57c176e8..1504812842 100644
--- a/submodule.c
+++ b/submodule.c
@@ -811,14 +811,15 @@ static int append_oid_to_argv(const struct object_id *oid, void *data)
 
 struct has_commit_data {
 	int result;
-	const char *path;
+	struct repository *repo;
 };
 
 static int check_has_commit(const struct object_id *oid, void *data)
 {
 	struct has_commit_data *cb = data;
+	struct repository *r = cb->repo;
 
-	enum object_type type = sha1_object_info(the_repository, oid->hash, NULL);
+	enum object_type type = sha1_object_info(r, oid->hash, NULL);
 
 	switch (type) {
 	case OBJ_COMMIT:
@@ -832,24 +833,43 @@ static int check_has_commit(const struct object_id *oid, void *data)
 		return 0;
 	default:
 		die(_("submodule entry '%s' (%s) is a %s, not a commit"),
-		    cb->path, oid_to_hex(oid), typename(type));
+		    r->submodule_prefix, oid_to_hex(oid), typename(type));
 	}
 }
 
+/*
+ * Initialize 'out' based on the provided submodule path.
+ *
+ * Unlike repo_submodule_init, this tolerates submodules not present
+ * in .gitmodules. NEEDSWORK: The repo_submodule_init behavior is
+ * preferrable. This function exists only to preserve historical behavior.
+ *
+ * Returns 0 on success, -1 when the submodule is not present.
+ */
+static int open_submodule(struct repository *out, const char *path)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (submodule_to_gitdir(&sb, path))
+		return -1;
+
+	if (repo_init(out, sb.buf, NULL)) {
+		strbuf_release(&sb);
+		return -1;
+	}
+
+	out->submodule_prefix = xstrdup(path);
+
+	strbuf_release(&sb);
+	return 0;
+}
+
 static int submodule_has_commits(const char *path, struct oid_array *commits)
 {
-	struct has_commit_data has_commit = { 1, path };
+	struct repository sub;
+	struct has_commit_data has_commit = { 1, &sub };
 
-	/*
-	 * Perform a cheap, but incorrect check for the existence of 'commits'.
-	 * This is done by adding the submodule's object store to the in-core
-	 * object store, and then querying for each commit's existence.  If we
-	 * do not have the commit object anywhere, there is no chance we have
-	 * it in the object store of the correct submodule and have it
-	 * reachable from a ref, so we can fail early without spawning rev-list
-	 * which is expensive.
-	 */
-	if (add_submodule_odb(path))
+	if (open_submodule(&sub, path))
 		return 0;
 
 	oid_array_for_each_unique(commits, check_has_commit, &has_commit);
@@ -878,6 +898,7 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
 		strbuf_release(&out);
 	}
 
+	repo_clear(&sub);
 	return has_commit.result;
 }
 
@@ -897,6 +918,9 @@ static int submodule_needs_pushing(const char *path, struct oid_array *commits)
 		 */
 		return 0;
 
+	/* The submodule odb is needed for access to its refs. */
+	if (add_submodule_odb(path))
+		BUG("submodule '%s' is both present and absent", path);
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct strbuf buf = STRBUF_INIT;
-- 
2.15.1.433.g936d1b9894.dirty

