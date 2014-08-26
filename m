From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v6 2/6] Add git_env_ulong() to parse environment variable
Date: Tue, 26 Aug 2014 17:23:21 +0200
Message-ID: <1409066605-4851-3-git-send-email-prohaska@zib.de>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 17:24:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMIbP-0001Gq-J3
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 17:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbaHZPXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 11:23:51 -0400
Received: from mailer.zib.de ([130.73.108.11]:35447 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbaHZPXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 11:23:50 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNes6011303;
	Tue, 26 Aug 2014 17:23:40 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNcNb011272;
	Tue, 26 Aug 2014 17:23:40 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
In-Reply-To: <1409066605-4851-1-git-send-email-prohaska@zib.de>
X-Miltered: at mailer.zib.de with ID 53FCA67C.002 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FCA67C.002 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FCA67C.002 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255909>

The new function will be used to parse GIT_MMAP_LIMIT and
GIT_ALLOC_LIMIT.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 cache.h  |  1 +
 config.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/cache.h b/cache.h
index fcb511d..b820b6a 100644
--- a/cache.h
+++ b/cache.h
@@ -1318,6 +1318,7 @@ extern int git_config_rename_section_in_file(const char *, const char *, const c
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
 extern int git_env_bool(const char *, int);
+extern unsigned long git_env_ulong(const char *, unsigned long);
 extern int git_config_system(void);
 extern int config_error_nonbool(const char *);
 #if defined(__GNUC__)
diff --git a/config.c b/config.c
index 058505c..178721f 100644
--- a/config.c
+++ b/config.c
@@ -1122,6 +1122,17 @@ int git_env_bool(const char *k, int def)
 	return v ? git_config_bool(k, v) : def;
 }
 
+/*
+ * Use default if environment variable is unset or empty string.
+ */
+unsigned long git_env_ulong(const char *k, unsigned long val)
+{
+	const char *v = getenv(k);
+	if (v && *v && !git_parse_ulong(v, &val))
+		die("failed to parse %s", k);
+	return val;
+}
+
 int git_config_system(void)
 {
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
-- 
2.1.0.8.gf3a29c8
