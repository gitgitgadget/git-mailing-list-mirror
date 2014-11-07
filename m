From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 16/16] refs.c: add an err argument to pack_refs
Date: Fri,  7 Nov 2014 11:39:05 -0800
Message-ID: <1415389145-6391-17-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:39:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpNm-0004FM-RR
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbaKGTjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:39:24 -0500
Received: from mail-qg0-f73.google.com ([209.85.192.73]:37119 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbaKGTjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:39:12 -0500
Received: by mail-qg0-f73.google.com with SMTP id z107so278983qgd.4
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=esjhEVBOOigUK1L9V5CnodYgv6l4mwbuVNi4ugfHAKU=;
        b=SNbgD3w0jWfjVsbkSlhpahlaCi56ViJwhNYwIHuAXj16Hcs850eHG1Oa7x5b1h3Olz
         Gs0aZw/hC8K1FuDpEKC9eI7tkJUrCNWx3P+w3ITeGh8dwmwMs23h11W1ZY7lmmAlWyTn
         9EDhlkKBpfTkFF8q1pYx5vpR6gdbQB1mE8zEw0SFRXnHP4Jns92J70MiE9rkzkjP5MrK
         3lZl1ffq9fkm1x2c16A/k3NVYP7jp5XukwOczrqYCNoesUar3H/leMp+TX4/bgmEd+g6
         Ftqk52fquo+W9bUBcITs5O/LzZ3YQFTWTI5fEGhbpAhQwMuRUevMRIkhPVIkgTwEBeMJ
         FABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=esjhEVBOOigUK1L9V5CnodYgv6l4mwbuVNi4ugfHAKU=;
        b=MjVm4R1Ka41EZxb7umDl1/lVujSafY56fPyU2Cd8/zHdpug4jdem3KgqiiX//VbZGY
         QFqw+0fCHwrNCL909cgG4fZi6LTKRn3BKaGq0+6f4VKG4SHNtPDNrleEnNQvC3iIfXHd
         hqzRtIN715U27FnUz0W4JzodnnDjxhcZq9tJ+mlTux3N2bgyrx0TWH1HzoQDSNvlt15k
         PZi1idZdaN/a5eOkdYoV7pEnBDjZ6ruoNc9CfgiFMG7j8FEjF9cPDVlmrBSgtxAgkAi/
         VUSSjUUC8BGknHyacnBfRn3H7AZZNCIOYAbsH81eyK+qRmHxCUluxH/RLx88DMi4y++Y
         tMrg==
X-Gm-Message-State: ALoCoQmXj++0isDrlbRQgLbxU/4FwxUy7wR/s6s2hSi9IT4gzFqt9ZdzKjWy9g2HjjKco7frxbqo
X-Received: by 10.224.165.137 with SMTP id i9mr10437600qay.0.1415389151572;
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id s23si405358yhf.0.2014.11.07.11.39.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id rUeUKdpJ.2; Fri, 07 Nov 2014 11:39:11 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 19CD0E0FC4; Fri,  7 Nov 2014 11:39:10 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/pack-refs.c | 8 +++++++-
 refs.c              | 7 +++----
 refs.h              | 3 ++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index b20b1ec..299768e 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -10,6 +10,7 @@ static char const * const pack_refs_usage[] = {
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	unsigned int flags = PACK_REFS_PRUNE;
+	struct strbuf err = STRBUF_INIT;
 	struct option opts[] = {
 		OPT_BIT(0, "all",   &flags, N_("pack everything"), PACK_REFS_ALL),
 		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
@@ -17,5 +18,10 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	};
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
-	return pack_refs(flags);
+	if (pack_refs(flags, &err)) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+	return 0;
 }
diff --git a/refs.c b/refs.c
index 1314a9a..cafb4aa 100644
--- a/refs.c
+++ b/refs.c
@@ -2593,16 +2593,15 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+int pack_refs(unsigned int flags, struct strbuf *err)
 {
 	struct pack_refs_cb_data cbdata;
-	struct strbuf err = STRBUF_INIT;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	if (lock_packed_refs(&err))
-		die("%s", err.buf);
+	if (lock_packed_refs(err))
+		return -1;
 
 	cbdata.packed_refs = get_packed_refs(&ref_cache);
 
diff --git a/refs.h b/refs.h
index b5ba685..489aa9d 100644
--- a/refs.h
+++ b/refs.h
@@ -130,8 +130,9 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
 /*
  * Write a packed-refs file for the current repository.
  * flags: Combination of the above PACK_REFS_* flags.
+ * Returns 0 on success and fills in err on failure.
  */
-int pack_refs(unsigned int flags);
+int pack_refs(unsigned int flags, struct strbuf *err);
 
 extern int ref_exists(const char *);
 
-- 
2.1.0.rc2.206.gedb03e5
