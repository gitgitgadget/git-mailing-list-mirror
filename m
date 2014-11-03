From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 17/17] refs.c: add an err argument to pack_refs
Date: Mon,  3 Nov 2014 11:02:19 -0800
Message-ID: <1415041339-18450-18-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:02:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMts-0001Xv-Vq
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbaKCTCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:43 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:33894 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbaKCTC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:26 -0500
Received: by mail-oi0-f74.google.com with SMTP id u20so1377940oif.5
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4aHTHqh7RjJrTlqVrR9PZGwlaemq9SQ8XkOsdwSoVlw=;
        b=m1578DSq+MQmY9EziPsf2xh+PU/+iPll9cbzRGEXYEYbZBAnThRGHhR1N/HsbPQ3os
         NnKGyUYlEM98ZJ3Av5P2lGpuKqZSy3f55WiGyt+vtWI6U6Af5YOfmjE3iSArXdnriwkr
         LZ0/z05IEpyiMBy1b+iYEX4f6CRee3SdTVpX7Jc7bV77MRW0tkTnfkaN2E/ecfHljj4Z
         U5lMbSLHS1TsCb1ynCFb3M3QetWx2rcsKcNsdHQW6D78Ek6lpJUu0B5gCw4qmBls8qY0
         8EGGidUO97jBwiMKPS70aixdGgthDB3tpzCbs9SsSp9uK14NbusZ2J6zoMIT36Wr4f3q
         7QlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4aHTHqh7RjJrTlqVrR9PZGwlaemq9SQ8XkOsdwSoVlw=;
        b=ATc7Yp0Yc4Jz0XmxkmzI9Iy8z7vU5+0uEHC0R0gqI3Rq2kMD/G/+PEGUlkRTZ5uWBS
         7tx1wy/lj648YK3Gz7xWTPvcDF6uSYEVDnPZH0jA7zm5tmLp0Kh0/8dFm3V0MdcafeYk
         UxP6SUp2Jyft3Iwcx1ZKOdu32m0KGfXR8dWGKVAvS9BFIS0FiKbn7VzkhyfIts+YV+k4
         Doeb82NjayGt+LulWKvUh/eXfE7bnkG6vsvgd0Sv1Hw3/Y6K7xoAvbvZN+raaqQIutWI
         0vo9FXN6m8wA6TrICOVhoFYIW6JSN53ajOVzqQBI+K339FEPldZ+YT1lvEsaTUhk4Vqu
         FqXw==
X-Gm-Message-State: ALoCoQm0S1PfsodHkl+0RvY7PJ8cF1dYU04C2R6V/c+zq6pu1Y0r7FOb6w5xe/TdLfxiFsSfuRvP
X-Received: by 10.42.10.132 with SMTP id q4mr33968173icq.25.1415041344748;
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id t28si974952yhb.4.2014.11.03.11.02.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id J95ZVEsi.2; Mon, 03 Nov 2014 11:02:24 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 33F86E1170; Mon,  3 Nov 2014 11:02:23 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
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
index 92e7714..c98d594 100644
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
index af20bd7..7c2f6c0 100644
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
