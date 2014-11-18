From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 16/16] refs.c: add an err argument to pack_refs
Date: Mon, 17 Nov 2014 17:44:57 -0800
Message-ID: <1416275097-3616-17-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:45:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXrO-0003tO-Os
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbaKRBpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:31 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:63256 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbaKRBpW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:22 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so6251434igd.13
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZ8/MESwDNQhdLVp/fQkwqbBbYNleCS25tdz5MN3zUA=;
        b=hUHmemNBp0IH/uN4WuYxMmyFdKA/DlYMOJpM97APO9Azsx3Nthdcwt1sEfXIBMXUrF
         tgbl/lwAWcgzRkHkNp+MD8e08Zvxz+VKEF3soJ+cPC1gLYqo9tPrnklSxLrkMeLjPKjT
         aZd+Alw2SiZeZGpbss04VJSVCwgSvl8wp5iT26EeB3B8SIE2/HsTBCMDtQfSD+AJmIYV
         0ukydNRFrJAEWCPC/3oGSltWeKDqoMwjO726X3DRxGcnqa2HiebmRE4BUxP4j7iKh7Dj
         +AuG1MhF+nfGXAhXrE2hIhX2gdeTFkh4cu+lLa4/Q8QUa4PG51/Sp8ygLRQY9xQEe6r8
         70/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZ8/MESwDNQhdLVp/fQkwqbBbYNleCS25tdz5MN3zUA=;
        b=Pex8mxH1DuWEjR31qdBpcRVh0wMnJK/gEeZOI74ukce+OltnyL2p2FhE8+BiMPhlOT
         6Y9/1lnD4+XPdLjuzVGGoctwTEGkj3K+KXd41q8MXytn65gmxvV03Quvj11TlStSPAJ0
         zCiO0weJ+0wHPY2Xf3HOPMajHp9Im0Sdcc82Z16ZoOK7eqUYfFEubKv9N3v/Sw/iREy7
         YiBr2bfybiqhx1e1XSgXZb5DQ3adNMhi3rYm42tIzYwjL4yjGAZuDGhurSs0PJBxUaVN
         uDqw5LGX/cEo0fMN3KGENjtH4ZTl2rjglXXOEwgL3nFfYi8ZjeYoXvWBZ2kT1nOsKEM4
         pwqQ==
X-Gm-Message-State: ALoCoQm/nv7R+oCRUCqZEkeIfWsmXI3m0AubxfxjHHa0OJJfziThgOSolP0tJ7leK+tqNoGt2Y99
X-Received: by 10.50.119.163 with SMTP id kv3mr29556840igb.15.1416275122269;
        Mon, 17 Nov 2014 17:45:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id jd6sm6871401igb.16.2014.11.17.17.45.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:21 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
index 725945e..ddb5fc6 100644
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
2.2.0.rc2.5.gf7b9fb2
