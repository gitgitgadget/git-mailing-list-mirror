From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 3/8] Introduce new function real_path_if_valid()
Date: Sun, 21 Oct 2012 07:57:32 +0200
Message-ID: <1350799057-13846-4-git-send-email-mhagger@alum.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 07:59:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPoYo-0006i8-6c
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 07:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697Ab2JUF61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 01:58:27 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:42213 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751387Ab2JUF60 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 01:58:26 -0400
X-AuditID: 1207440c-b7f616d00000270b-29-50838f0141ac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id F3.7F.09995.10F83805; Sun, 21 Oct 2012 01:58:25 -0400 (EDT)
Received: from michael.fritz.box (p57A24D34.dip.t-dialin.net [87.162.77.52])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9L5w2Wq013120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Oct 2012 01:58:23 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsUixO6iqMvY3xxgsPKSiMWRN0+YLbqudDNZ
	NPReYbZ4Mvcus8XRUxYWt1fMZ7ZY/+4qswO7x9/3H5g83rT3MnrsnHWX3ePhqy52j4uXlD0+
	b5ILYIvitklKLCkLzkzP07dL4M64tXE7a8FZjor2eWcZGxhb2bsYOTkkBEwkJp0/BWWLSVy4
	t56ti5GLQ0jgMqPErK9nWCGcM0wS1/48YgapYhPQlVjU08wEYosIqElMbDvEAlLELHCHUWLh
	lTdgRcICzhI/H61hA7FZBFQltmzaBLaCV8BF4svzW6wQ6xQlfnxfA1bPKeAqcWXZHLB6IaCa
	nRvfM05g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdQLzezRC81pXQTIyTkeHYwflsn
	c4hRgINRiYeX0bo5QIg1say4MvcQoyQHk5Io74teoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
	3t2CQDnelMTKqtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvah9Qo2BRanpq
	RVpmTglCmomDE0RwgWzgAdrgClLIW1yQmFucmQ5RdIpRUUqc1wgkIQCSyCjNgxsASw6vGMWB
	/hHm9QKp4gEmFrjuV0CDmYAGm3M3ggwuSURISTUwhm3+rlOhNWtijfeGlb8u3cxdk36SXyn5
	U/FHKd21XXxfWUQDAuPmZvsu714SnPum/846z79rsjdnrerpeNLw683Cmi8Xbmg8vnyUSbDN
	RFDHm6WhaefGnnQV5fPft68N0Om6+TnjT97fJtNiX+79dcEr7/wqvOcasrP+1YxF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208108>

The function is like real_path(), except that it returns NULL on error
instead of dying.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c | 5 +++++
 cache.h   | 1 +
 2 files changed, 6 insertions(+)

diff --git a/abspath.c b/abspath.c
index f8a526f..40cdc46 100644
--- a/abspath.c
+++ b/abspath.c
@@ -153,6 +153,11 @@ const char *real_path(const char *path)
 	return real_path_internal(path, 1);
 }
 
+const char *real_path_if_valid(const char *path)
+{
+	return real_path_internal(path, 0);
+}
+
 static const char *get_pwd_cwd(void)
 {
 	static char cwd[PATH_MAX + 1];
diff --git a/cache.h b/cache.h
index a58df84..b0d75bc 100644
--- a/cache.h
+++ b/cache.h
@@ -714,6 +714,7 @@ static inline int is_absolute_path(const char *path)
 }
 int is_directory(const char *);
 const char *real_path(const char *path);
+const char *real_path_if_valid(const char *path);
 const char *absolute_path(const char *path);
 const char *relative_path(const char *abs, const char *base);
 int normalize_path_copy(char *dst, const char *src);
-- 
1.7.11.3
