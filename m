From: david@statichacks.org
Subject: [PATCH 1/4] Changed timestamps to time_t instead of unsigned
Date: Thu,  6 Nov 2008 09:48:45 -0800
Message-ID: <1225993728-4779-2-git-send-email-david@statichacks.org>
References: <1225993728-4779-1-git-send-email-david@statichacks.org>
Cc: David Bryson <david@statichacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 18:50:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky906-0005WU-CB
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 18:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbYKFRtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 12:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYKFRtA
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 12:49:00 -0500
Received: from cryptobackpack.org ([64.105.32.74]:38696 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbYKFRsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 12:48:53 -0500
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 50E0C10D02AC; Thu,  6 Nov 2008 09:48:52 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_SECURITYSAGE autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id F370710D0265;
	Thu,  6 Nov 2008 09:48:49 -0800 (PST)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 8730514463; Thu,  6 Nov 2008 09:48:48 -0800 (PST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <1225993728-4779-1-git-send-email-david@statichacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100257>

From: David Bryson <david@statichacks.org>

---
 builtin-prune.c       |    2 +-
 builtin-reflog.c      |    8 ++++----
 builtin-show-branch.c |    4 ++--
 parse-options.c       |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 7b4ec80..e1d46f0 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -12,7 +12,7 @@ static const char * const prune_usage[] = {
 };
 static int show_only;
 static int verbose;
-static unsigned long expire;
+static time_t expire;
 
 static int prune_tmp_object(const char *path, const char *filename)
 {
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 6b3667e..fdf78a9 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -27,8 +27,8 @@ struct cmd_reflog_expire_cb {
 	int rewrite;
 	int updateref;
 	int verbose;
-	unsigned long expire_total;
-	unsigned long expire_unreachable;
+	time_t expire_total;
+	time_t expire_unreachable;
 	int recno;
 };
 
@@ -361,7 +361,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 	return ent;
 }
 
-static int parse_expire_cfg_value(const char *var, const char *value, unsigned long *expire)
+static int parse_expire_cfg_value(const char *var, const char *value, time_t *expire)
 {
 	if (!value)
 		return config_error_nonbool(var);
@@ -380,7 +380,7 @@ static int parse_expire_cfg_value(const char *var, const char *value, unsigned l
 static int reflog_expire_config(const char *var, const char *value, void *cb)
 {
 	const char *lastdot = strrchr(var, '.');
-	unsigned long expire;
+	time_t expire;
 	int slot;
 	struct reflog_expire_cfg *ent;
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 306b850..73b3dc0 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -716,7 +716,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			base = strtoul(reflog_base, &ep, 10);
 			if (*ep) {
 				/* Ah, that is a date spec... */
-				unsigned long at;
+				time_t at;
 				at = approxidate(reflog_base);
 				read_ref_at(ref, at, -1, sha1, NULL,
 					    NULL, NULL, &base);
@@ -726,7 +726,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		for (i = 0; i < reflog; i++) {
 			char *logmsg, *m;
 			const char *msg;
-			unsigned long timestamp;
+			time_t timestamp;
 			int tz;
 
 			if (read_ref_at(ref, 0, base+i, sha1, &logmsg,
diff --git a/parse-options.c b/parse-options.c
index fd08bb4..4581b50 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -480,7 +480,7 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 			     int unset)
 {
-	*(unsigned long *)(opt->value) = approxidate(arg);
+	*(time_t *)(opt->value) = approxidate(arg);
 	return 0;
 }
 
-- 
1.6.0.1
