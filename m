From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/4] help.c: wrap wait-only poll() invocation in sleep_millisec()
Date: Fri,  5 Jun 2015 21:45:05 +0200
Message-ID: <1bf3ed414ca35f378ac4934dee49a6fa595966ed.1433532968.git.j6t@kdbg.org>
References: <55700F10.8030806@kdbg.org>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:46:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xZ1-0007wn-B1
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbbFETpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:45:54 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:8249 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751939AbbFETpy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 15:45:54 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3m3Dww4rqXz5tlJ;
	Fri,  5 Jun 2015 21:45:52 +0200 (CEST)
Received: from dx.lan (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id 6D72B1D0;
	Fri,  5 Jun 2015 21:45:52 +0200 (CEST)
X-Mailer: git-send-email 2.3.2.245.gb5bf9d3
In-Reply-To: <55700F10.8030806@kdbg.org>
In-Reply-To: <cover.1433532967.git.j6t@kdbg.org>
References: <cover.1433532967.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270880>

We want to use the new function elsewhere in a moment.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 cache.h   | 1 +
 help.c    | 2 +-
 wrapper.c | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 54f108a..328cdb7 100644
--- a/cache.h
+++ b/cache.h
@@ -1680,5 +1680,6 @@ int stat_validity_check(struct stat_validity *sv, const char *path);
 void stat_validity_update(struct stat_validity *sv, int fd);
 
 int versioncmp(const char *s1, const char *s2);
+void sleep_millisec(int millisec);
 
 #endif /* CACHE_H */
diff --git a/help.c b/help.c
index 2072a87..de1279b 100644
--- a/help.c
+++ b/help.c
@@ -372,7 +372,7 @@ const char *help_unknown_cmd(const char *cmd)
 		if (autocorrect > 0) {
 			fprintf_ln(stderr, _("in %0.1f seconds automatically..."),
 				(float)autocorrect/10.0);
-			poll(NULL, 0, autocorrect * 100);
+			sleep_millisec(autocorrect * 100);
 		}
 		return assumed;
 	}
diff --git a/wrapper.c b/wrapper.c
index c1a663f..ff49807 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -595,3 +595,8 @@ int write_file(const char *path, int fatal, const char *fmt, ...)
 	}
 	return 0;
 }
+
+void sleep_millisec(int millisec)
+{
+	poll(NULL, 0, millisec);
+}
-- 
2.3.2.245.gb5bf9d3
