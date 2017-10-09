Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D861FA21
	for <e@80x24.org>; Mon,  9 Oct 2017 01:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbdJIBM7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 21:12:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54704 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753797AbdJIBL7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Oct 2017 21:11:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6F6DC60D99;
        Mon,  9 Oct 2017 01:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1507511516;
        bh=wzlmonV4FkArWVSeRWpDeG/83xTrxeoMXjr3QdsSudM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jjlmoVahT6SaeS/9XE0G2kStIU6UVmeZcYwPlXlk1f955Y0qhpdABnHgKPHAl+lOE
         JgPFfI/VsIoZ05A/FuzMK/RiFSAdEJTjWY9JZaE0Wsy5ZjQhyq6EhEVyen661Xoxro
         nrGgHjwycKV8oeb4Ho7RAps09+LAVX9hCfzQbicF3Z7Sx40pEaFU123atIhu4UyscD
         HMk2gETITJCg76VBX0jJmXvPQM+QlR4+gf+LZqXZF/UCevpN5XyA56DZ7HpEMxXmMa
         pZrd/8g6iVjfzCEWoz+4LwX9QNpd0F4sIy1hLqNJ86nvse/QH1UWbGU68XJgR+1fgn
         lK/aJm+/8qfw1sYBABhPVYAlhv0U4Koe4osc1jT4W4y6xpindkfEZwrTcez4hditrz
         WUzl5WH9vgLnxlBVcJskT9FtxNFCv+RxVX2720TzxeyBtLMQeX1WfRDxcVjDu59JOs
         Rlm82wO80jYdm4CmGJZY+l44W2G/Nfvz6FpQtE6kDJwU487xI0a
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 11/24] refs: convert dwim_log to struct object_id
Date:   Mon,  9 Oct 2017 01:11:19 +0000
Message-Id: <20171009011132.675341-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c
In-Reply-To: <20171009011132.675341-1-sandals@crustytoothpaste.net>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/reflog.c | 4 ++--
 reflog-walk.c    | 2 +-
 refs.c           | 8 ++++----
 refs.h           | 2 +-
 sha1_name.c      | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 302fafbeef..cd4c4847b7 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -602,7 +602,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	for (; i < argc; i++) {
 		char *ref;
 		struct object_id oid;
-		if (!dwim_log(argv[i], strlen(argv[i]), oid.hash, &ref)) {
+		if (!dwim_log(argv[i], strlen(argv[i]), &oid, &ref)) {
 			status |= error("%s points nowhere!", argv[i]);
 			continue;
 		}
@@ -668,7 +668,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!dwim_log(argv[i], spec - argv[i], oid.hash, &ref)) {
+		if (!dwim_log(argv[i], spec - argv[i], &oid, &ref)) {
 			status |= error("no reflog for '%s'", argv[i]);
 			continue;
 		}
diff --git a/reflog-walk.c b/reflog-walk.c
index 1a602a214d..65f8a6b340 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -163,7 +163,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 			struct object_id oid;
 			char *b;
 			int ret = dwim_log(branch, strlen(branch),
-					   oid.hash, &b);
+					   &oid, &b);
 			if (ret > 1)
 				free(b);
 			else if (ret == 1) {
diff --git a/refs.c b/refs.c
index 14a700ade6..40f07296e9 100644
--- a/refs.c
+++ b/refs.c
@@ -496,7 +496,7 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 	return refs_found;
 }
 
-int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
+int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 {
 	char *last_branch = substitute_branch_name(&str, &len);
 	const char **p;
@@ -505,13 +505,13 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 	*log = NULL;
 	for (p = ref_rev_parse_rules; *p; p++) {
-		unsigned char hash[20];
+		struct object_id hash;
 		const char *ref, *it;
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
 		ref = resolve_ref_unsafe(path.buf, RESOLVE_REF_READING,
-					 hash, NULL);
+					 hash.hash, NULL);
 		if (!ref)
 			continue;
 		if (reflog_exists(path.buf))
@@ -522,7 +522,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 			continue;
 		if (!logs_found++) {
 			*log = xstrdup(it);
-			hashcpy(sha1, hash);
+			oidcpy(oid, &hash);
 		}
 		if (!warn_ambiguous_refs)
 			break;
diff --git a/refs.h b/refs.h
index 832a77183c..8159b7b067 100644
--- a/refs.h
+++ b/refs.h
@@ -141,7 +141,7 @@ int refname_match(const char *abbrev_name, const char *full_name);
 
 int expand_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
-int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
+int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
 /*
  * A ref_transaction represents a collection of reference updates that
diff --git a/sha1_name.c b/sha1_name.c
index 28bad3e74b..7de12743f3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -656,7 +656,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 		/* allow "@{...}" to mean the current branch reflog */
 		refs_found = dwim_ref("HEAD", 4, oid, &real_ref);
 	else if (reflog_len)
-		refs_found = dwim_log(str, len, oid->hash, &real_ref);
+		refs_found = dwim_log(str, len, oid, &real_ref);
 	else
 		refs_found = dwim_ref(str, len, oid, &real_ref);
 
-- 
2.14.2.920.gcf0c67979c

