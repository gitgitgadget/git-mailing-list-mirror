From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 15/15] refs.c: add an err argument to pack_refs
Date: Tue, 21 Oct 2014 13:37:00 -0700
Message-ID: <1413923820-14457-16-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:46:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggKK-0004vb-Cv
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933459AbaJUUqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:46:40 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:60215 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933266AbaJUUqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:46:39 -0400
Received: by mail-pd0-f202.google.com with SMTP id fp1so370988pdb.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SV8+RR61MgXjgkuFPr/Wd+4ejipMeB2KsHvaDytgbjE=;
        b=a026NkBMiJYXCL/nPk7BT2HKj7WBDexmguE03r1nUSLSQlViUWRhP1Apd7udHVoW89
         sN4JQ4IclMokFg0I3dSD5wlY+ip84oSR8Yi8Wp9jfknslrclmGWVqqEnKWsqjuXObWhL
         hwHsJRSkG43UKWOEaLYuJPG16+WdRn7iAfNM8MIVm3lYw7wtlSd9pxAT3ipSfLrYTaNW
         kxNcBh+sCiVAzIBjsSYQ7wkC+JtrcCwinFq6Ee22+CMeJ+mhbBG+DLbi+aNGj2nQKUW1
         pnbRz9NInp/0cCIcSyKbLFqYXEGQc508m6SYYZAgxbs20WTh6np2kz37myuMlbKZAR02
         wNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SV8+RR61MgXjgkuFPr/Wd+4ejipMeB2KsHvaDytgbjE=;
        b=YW2VQ5xwNOs+0cHoQ6G63SzKj1cQPa/6R9J6a6GBRU8Az6QcRwTxbC18tdyxGoTgQf
         Y5kp2XJmMvWMzHIpW1YEx9Gn1rmgI7bsks+bqXKVpPY1eif2jX52tV8VFHYdSQqptcws
         VSzC0/yR8465PCRiUSBcnXyM0Qx7bZC/DQWDFO597REMbojqzTTJOX53i9tda0CSdo5l
         4TOLavCBw2fPYrAY1SbnJ0B2H9PLV2ao9SOzaJqeqF+qIxy3h8i4mFNfRxti8n3R9oSz
         Qrmq2Ba0MmrBdl4foiLIXzAvaEL5bE7B2W3Ub69Z25pgDtfryJdAZRn1LKzTTliRK4R8
         tqYQ==
X-Gm-Message-State: ALoCoQlGwll0HtJnlFHMu2pNphfi77M6ayNgdwwI1eCbfwRIHkC5a9YxLWjfzXR/UxfpDMpezJFz
X-Received: by 10.70.63.41 with SMTP id d9mr23825188pds.5.1413924398912;
        Tue, 21 Oct 2014 13:46:38 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n22si597277yhd.1.2014.10.21.13.46.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:46:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 6s96RTlh.1; Tue, 21 Oct 2014 13:46:38 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 39156E1253; Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change-Id: I1e65ac429c14f01073d95c6440f820dda1c6091b
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
index 7fb0d6c..a5e1eff 100644
--- a/refs.c
+++ b/refs.c
@@ -2588,16 +2588,15 @@ static void prune_refs(struct ref_to_prune *r)
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
index f3e08f5..be16c08 100644
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
