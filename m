From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 5/5] refs.c: add an err argument to pack_refs
Date: Thu, 31 Jul 2014 14:25:10 -0700
Message-ID: <1406841910-3278-6-git-send-email-sahlberg@google.com>
References: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:25:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCxr0-0000bc-MQ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbaGaVZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:25:27 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:44988 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbaGaVZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:25:17 -0400
Received: by mail-oi0-f73.google.com with SMTP id u20so961176oif.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+x5nod9SLfxK3/7FoPu/q0XZUuYUNIRDhpqKNjcT+3E=;
        b=ccjWqyGf4n6rr7tVgKGs6Y/s9cOp6Szj3o6INU/MSmCCNhGKnWLZi2UXsMiJeMY+LK
         K9a9KeQoIteief5XAk4zkXzBgy7YNC2nUMGHbjXRvUZaV/buneEQPXP8XBlf4CFwZfun
         xqm5MbDbjw9gfmEwA8iGB9A8zOKpVu9cPCLdvpYc4sF04B3+xUQXkG8VvThdBtzVpRA1
         H9QvRd52NoCBOuEIv9HIsMsNurq/J1f+7zSCFs5QqdjT8Lag25L9bHjeyEqY278DzVzQ
         eu92nHyRWMg4iKUjuPQft1BPWKS0Y3aLgia37YYZ6EHccdnKD25zXmSJNuL6Bpd7VRAn
         6oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+x5nod9SLfxK3/7FoPu/q0XZUuYUNIRDhpqKNjcT+3E=;
        b=JFRIQ3Oni4lUx++VwBbKqm/djW5O03bABhehpi6hBYXfHI08mUvo47FkiLyWy15mm6
         ouZfgRHtSDqTlmr3QqnDNgB6C5wp7+ig/WamUZnBM2mcQ8SKlgmBodwmFck9G4jKtOe4
         65AUpTeiqJOIn2yrl5DBj5Ir2SMu9gOd+F2V0sI58g7NiJiBBa7UdYrYaAvdtf3I+k8c
         jJ+fiIaX4OwNaJthkHCV2yY3Jmt01BgSfas4fSgZKMqX/z9a1X9vY2i3caDpwPhVzkR5
         xIenCa1hirLAMqbubPUeZhwd3Mwdpf3G4DIU8Zd1luEhRaVzlIGcQJmHLo2pXjMb2FJV
         4S/g==
X-Gm-Message-State: ALoCoQlgpcm/4jhBSH9btj5RZ8WypjN/sBPlsFpMISL7a7YD0aAidigg5nqSQaV4NCPcz5RGlopg
X-Received: by 10.42.85.142 with SMTP id q14mr999707icl.16.1406841916697;
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id 4si55595igj.0.2014.07.31.14.25.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3DE3531C60E;
	Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 93A95E0669; Thu, 31 Jul 2014 14:25:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g70700c9
In-Reply-To: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254607>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/pack-refs.c |  8 +++++++-
 refs.c              | 13 ++++++-------
 refs.h              |  3 ++-
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index b20b1ec..da5d46a 100644
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
+		return 1;
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
2.0.1.523.g70700c9
