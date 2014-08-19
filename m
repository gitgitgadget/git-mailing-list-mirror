From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 5/5] refs.c: add an err argument to pack_refs
Date: Tue, 19 Aug 2014 09:17:04 -0700
Message-ID: <1408465024-23162-6-git-send-email-sahlberg@google.com>
References: <1408465024-23162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:17:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJm5z-0002yN-8S
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbaHSQRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:17:11 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:34448 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbaHSQRI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:17:08 -0400
Received: by mail-ig0-f201.google.com with SMTP id h3so1086157igd.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G5tv8pZZRpDm8NEGKzyPtYmV/CboZEpL1N9XLlkoz00=;
        b=USuVZAis2FKImSLt42dwDMXNcS0eYR74Ug06JxhNfZ9lyHB1DEsl9ZDKck7t5RIHi8
         chRXlnyVarYjVX3lNAMFrb+csAcN0dIrZdKvhrHrCI/0LGCpHgifSyv5VJeC4h10WnLX
         TPVsV+ka0IY8IsHeywj+aYEPHeOLnFmM50+17IUmSRFiWqZORcWI8sRDtag5sM5aL7Ot
         zdE1sYitgz1VjIhL1m9+AJrWTLBgcmAlxScWfFKX3R1E8rJKmoLO9BaFCffT3pATkC3G
         tzbChoR2ejzktl5ttBNFsBnIjomv4IrwawBPIGylbBbOJnfpUeVWMEPnZo0vEGu6OE/3
         7YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G5tv8pZZRpDm8NEGKzyPtYmV/CboZEpL1N9XLlkoz00=;
        b=DhRVbYY5X7uXBZGDxGumxSeC8RbA6iXx8vK8VAITJg6RN97g9mlwMtx0g7ZJHmoROS
         gP0ywicTs45ZyteHGIGk3bQGlBPlGkcVgRS8NN4OZ7ZiT1bpS6GAXK9zt+oVbyvDR9Ae
         3GIZfP5ZkHJ6qRtXJ19+oP06qa/BKdOPswl/b9jyyXVU1d+zmoiWZsdWQnGm9e3CFTn5
         mSIKb/NYiV5djXbuyUL59GZHQQIWgBFA9cGCdNw6CF1/ldOdydGheVuwIrbNajAk+czG
         TZlAPcOOEOT/n3VX6txgmfq3pfuEeORP02NKD4fjTX3gGYHXV3o/teT9otb5KSXiw4Nx
         DfrA==
X-Gm-Message-State: ALoCoQniM4TQclc1f3l6REFatka2fy4maMC8NYjIBYyLboeGQq3h1MQGVOT8ahtHWXMrkHw8p7Os
X-Received: by 10.182.125.68 with SMTP id mo4mr443559obb.49.1408465027311;
        Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a66si326101yhg.7.2014.08.19.09.17.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 2BD515A4412;
	Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B7F44E0E84; Tue, 19 Aug 2014 09:17:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.ge8f7cba.dirty
In-Reply-To: <1408465024-23162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255464>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/pack-refs.c |  8 +++++++-
 refs.c              | 13 ++++++-------
 refs.h              |  3 ++-
 3 files changed, 15 insertions(+), 9 deletions(-)

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
index 19e73f3..5875c29 100644
--- a/refs.c
+++ b/refs.c
@@ -2328,7 +2328,7 @@ static int commit_packed_refs(struct strbuf *err)
 		strbuf_addf(err, "error writing packed-refs. %s",
 			    strerror(errno));
 		return -1;
-       }
+	}
 
 	data.fd = packed_ref_cache->lock->fd;
 	data.err = err;
@@ -2482,24 +2482,23 @@ static void prune_refs(struct ref_to_prune *r)
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
 
 	do_for_each_entry_in_dir(get_loose_refs(&ref_cache), 0,
 				 pack_if_possible_fn, &cbdata);
 
-	if (commit_packed_refs(&err))
-		die("%s", err.buf);
+	if (commit_packed_refs(err))
+		return -1;
 
 	prune_refs(cbdata.ref_to_prune);
 	return 0;
diff --git a/refs.h b/refs.h
index dee9a98..1a98e27 100644
--- a/refs.h
+++ b/refs.h
@@ -122,8 +122,9 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
 /*
  * Write a packed-refs file for the current repository.
  * flags: Combination of the above PACK_REFS_* flags.
+ * Returns 0 on success and fills in err on failure.
  */
-int pack_refs(unsigned int flags);
+int pack_refs(unsigned int flags, struct strbuf *err);
 
 extern int ref_exists(const char *);
 
-- 
2.0.1.556.ge8f7cba.dirty
