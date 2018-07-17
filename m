Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F6B1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbeGQMjO (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 08:39:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40797 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731669AbeGQMjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so1259548wma.5
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 05:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=J864P+oFQSqBkpYVVPNfswcUeS2MCP8sIjEAz5d8bzQ=;
        b=sSn3qsAsVDW74MPwm61ieRSkDmzxuxN3CPVC5sKMPElarKxisdMoqUgwRhM84geyM2
         WmsbyBr1LDzSvwPlM0QM4nk1cxcTbzCtQN7rCaUYpHeGy+b8UwbJIQDQaplaAXm4k0+2
         E8Qdvs2EUDKzd5pNzD/0WwMfNJh+wSDb7I6YnWRHpRDcLNarHYFrvApluZHKb267tfgt
         2Vg+0neBy76TGwa8F65OyEkOcQzUxrfDH/Jh/MW2Mrr+HIqk/MMwcBcCVR74oN1AcWCk
         0qQWRQjwS2Hgf3m91azPOheBwasx519eyzUtOkJIldyTca943/DguQsXl4LOVQ51LC2H
         qkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=J864P+oFQSqBkpYVVPNfswcUeS2MCP8sIjEAz5d8bzQ=;
        b=ZTv6lWrnPhNchDcfr7aYDTQGlQIGRmCmpH5Rs3y3+VXWQ8xdbvbeUfXL7hzHfk4SwA
         jUEiVq9mdHUU8PIQe9Vm4v3/Ke2vFNOfDugzT6aLju8jK4zy1E+qiG08lxTj1+CZGwaI
         NjL5Rm27hmTFTt4o6TZ4uf3DEAtzt+56Z0USgkN6pbrUBb13YmUXamJq/8VcgOTpr8OA
         cKOJ2RgL8+clDoxvnoQ6iFpUtOwEVqx3pm7OhxxVBxmoFTq3E98sFePc3NmfbnMYQun/
         IqyWRmrVOB9dGRrvHySZLeSKVMjQ8nlsapXZoLEBNs6q+h42C7bxrJM2vxRa0JbSC8k9
         PInQ==
X-Gm-Message-State: AOUpUlEXn9QIvkwsmpfVmY6YWYqBKdhl6K5NGtaFKgxyIlJg8JlurAjO
        AYygMhCMxgmyS1GlhZrYvdloag==
X-Google-Smtp-Source: AAOMgpduf+EfbGj5uWzy04Gfe1J0aUeL6iNG5OQonQONfldcprFQGPuPXUl2OcJyh5MMuA4ftBhjTg==
X-Received: by 2002:a1c:b80c:: with SMTP id i12-v6mr1154120wmf.30.1531829210251;
        Tue, 17 Jul 2018 05:06:50 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-157-218.residential.rdsnet.ro. [5.13.157.218])
        by smtp.gmail.com with ESMTPSA id d4-v6sm542099wrp.51.2018.07.17.05.06.49
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 05:06:49 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 5/6] sha1-name: Teach `get_oid_with_context[_1]()` to be gentle
Date:   Tue, 17 Jul 2018 15:06:35 +0300
Message-Id: <dc1abfca46cd536f060b9097b9f2d1a64988f932.1531778417.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.184.ga79db55c2.dirty
In-Reply-To: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit makes `get_oid_with_context()` and `get_oid_with_context_1()`
to recognize the `GET_OID_GENTLY` flag.

The `gentle` flag does not imply `quiet` and we might need to reconsider
whether we should display any message if `GET_OID_GENTLY` is given.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 sha1-name.c | 103 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 83 insertions(+), 20 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 74ecbd550..a5d4e0dc7 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1521,11 +1521,12 @@ int get_oid_blob(const char *name, struct object_id *oid)
 }
 
 /* Must be called only when object_name:filename doesn't exist. */
-static void diagnose_invalid_oid_path(const char *prefix,
+static int diagnose_invalid_oid_path(const char *prefix,
 				      const char *filename,
 				      const struct object_id *tree_oid,
 				      const char *object_name,
-				      int object_name_len)
+				      int object_name_len,
+				      int gentle)
 {
 	struct object_id oid;
 	unsigned mode;
@@ -1533,12 +1534,19 @@ static void diagnose_invalid_oid_path(const char *prefix,
 	if (!prefix)
 		prefix = "";
 
-	if (file_exists(filename))
+	if (file_exists(filename)) {
+		if (gentle)
+			return -1;
 		die("Path '%s' exists on disk, but not in '%.*s'.",
 		    filename, object_name_len, object_name);
+	}
 	if (is_missing_file_error(errno)) {
 		char *fullname = xstrfmt("%s%s", prefix, filename);
-
+		if (gentle) {
+			warning(_("%s or %s does not exist."), fullname,
+				filename);
+			return -1;
+		}
 		if (!get_tree_entry(tree_oid, fullname, &oid, &mode)) {
 			die("Path '%s' exists, but not '%s'.\n"
 			    "Did you mean '%.*s:%s' aka '%.*s:./%s'?",
@@ -1552,12 +1560,14 @@ static void diagnose_invalid_oid_path(const char *prefix,
 		die("Path '%s' does not exist in '%.*s'",
 		    filename, object_name_len, object_name);
 	}
+	return 0;
 }
 
 /* Must be called only when :stage:filename doesn't exist. */
-static void diagnose_invalid_index_path(int stage,
+static int diagnose_invalid_index_path(int stage,
 					const char *prefix,
-					const char *filename)
+					const char *filename,
+					int gentle)
 {
 	const struct cache_entry *ce;
 	int pos;
@@ -1574,11 +1584,20 @@ static void diagnose_invalid_index_path(int stage,
 	if (pos < active_nr) {
 		ce = active_cache[pos];
 		if (ce_namelen(ce) == namelen &&
-		    !memcmp(ce->name, filename, namelen))
+		    !memcmp(ce->name, filename, namelen)) {
+			if (gentle) {
+				warning("Path '%s' is in the index "
+					"but not at stage %d.\n"
+					"Did you mean ':%d:%s'?",
+					filename, stage,
+					ce_stage(ce), filename);
+				return -1;
+			}
 			die("Path '%s' is in the index, but not at stage %d.\n"
 			    "Did you mean ':%d:%s'?",
 			    filename, stage,
 			    ce_stage(ce), filename);
+		}
 	}
 
 	/* Confusion between relative and absolute filenames? */
@@ -1590,31 +1609,58 @@ static void diagnose_invalid_index_path(int stage,
 	if (pos < active_nr) {
 		ce = active_cache[pos];
 		if (ce_namelen(ce) == fullname.len &&
-		    !memcmp(ce->name, fullname.buf, fullname.len))
+		    !memcmp(ce->name, fullname.buf, fullname.len)) {
+			if (gentle)
+				return -1;
 			die("Path '%s' is in the index, but not '%s'.\n"
 			    "Did you mean ':%d:%s' aka ':%d:./%s'?",
 			    fullname.buf, filename,
 			    ce_stage(ce), fullname.buf,
 			    ce_stage(ce), filename);
+		}
 	}
 
-	if (file_exists(filename))
+	if (file_exists(filename)) {
+		if (gentle)
+			return -1;
 		die("Path '%s' exists on disk, but not in the index.", filename);
-	if (is_missing_file_error(errno))
+	}
+	if (is_missing_file_error(errno)) {
+		if (gentle)
+			return -1;
 		die("Path '%s' does not exist (neither on disk nor in the index).",
 		    filename);
+	}
 
 	strbuf_release(&fullname);
+	return 0;
 }
 
+static const char *resolve_error = "dummy";
 
-static char *resolve_relative_path(const char *rel)
+static char *resolve_relative_path_gently(const char *rel, int gentle)
 {
 	if (!starts_with(rel, "./") && !starts_with(rel, "../"))
 		return NULL;
 
-	if (!is_inside_work_tree())
+	if (!is_inside_work_tree()) {
+		/*
+		 * `resolve_error` is a dummy variable and it is used to verify
+		 * if there was any problem inside this function. This is
+		 * returned only in the case we want to perform gently,
+		 * otherwise, `exit()` or `die()` can be called.
+		 */
+		if (gentle)
+			return (char*) resolve_error;
 		die("relative path syntax can't be used outside working tree.");
+	}
+
+	if (gentle) {
+		return prefix_path_gently(startup_info->prefix,
+					  startup_info->prefix ?
+					  strlen(startup_info->prefix) : 0,
+					  NULL, rel);
+	}
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
 	return prefix_path(startup_info->prefix,
@@ -1669,7 +1715,16 @@ static int get_oid_with_context_1(const char *name,
 			stage = name[1] - '0';
 			cp = name + 3;
 		}
-		new_path = resolve_relative_path(cp);
+		/*
+		 * Note that `resolve_relative_path_gently()` may die if
+		 * the second parameter is zero. If it is a non-zero value,
+		 * the function will return `resolve_error` on failure. This
+		 * dummy variable is defined as a `static const char *`.
+		 */
+		new_path = resolve_relative_path_gently(cp, flags & GET_OID_GENTLY);
+		if (new_path == resolve_error)
+			return -1;
+
 		if (!new_path) {
 			namelen = namelen - (cp - name);
 		} else {
@@ -1698,8 +1753,11 @@ static int get_oid_with_context_1(const char *name,
 			}
 			pos++;
 		}
-		if (only_to_die && name[1] && name[1] != '/')
-			diagnose_invalid_index_path(stage, prefix, cp);
+		if (only_to_die && name[1] && name[1] != '/' &&
+			diagnose_invalid_index_path(stage, prefix, cp,
+						    flags & GET_OID_GENTLY))
+			return -1;
+
 		free(new_path);
 		return -1;
 	}
@@ -1723,7 +1781,10 @@ static int get_oid_with_context_1(const char *name,
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
-			new_filename = resolve_relative_path(filename);
+			new_filename = resolve_relative_path_gently(filename,
+								    flags & GET_OID_GENTLY);
+			if (new_filename == resolve_error)
+				return -1;
 			if (new_filename)
 				filename = new_filename;
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
@@ -1731,13 +1792,14 @@ static int get_oid_with_context_1(const char *name,
 					filename, oid, &oc->symlink_path,
 					&oc->mode, flags);
 			} else {
-				ret = get_tree_entry(&tree_oid, filename, oid,
-						     &oc->mode);
+				ret = get_tree_entry_gently(&tree_oid, filename,
+							    oid, &oc->mode,
+							    flags & GET_OID_GENTLY);
 				if (ret && only_to_die) {
 					diagnose_invalid_oid_path(prefix,
 								   filename,
 								   &tree_oid,
-								   name, len);
+								   name, len, 0);
 				}
 			}
 			if (flags & GET_OID_RECORD_PATH)
@@ -1769,7 +1831,8 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 
 int get_oid_with_context(const char *str, unsigned flags, struct object_id *oid, struct object_context *oc)
 {
-	if (flags & GET_OID_FOLLOW_SYMLINKS && flags & GET_OID_ONLY_TO_DIE)
+	if (flags & (GET_OID_FOLLOW_SYMLINKS | GET_OID_GENTLY) &&
+	    flags & GET_OID_ONLY_TO_DIE)
 		BUG("incompatible flags for get_sha1_with_context");
 	return get_oid_with_context_1(str, flags, NULL, oid, oc);
 }
-- 
2.18.0.rc2.184.ga79db55c2.dirty

