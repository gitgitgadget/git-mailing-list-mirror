From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/9] Introduce new function real_path_if_valid()
Date: Sat, 29 Sep 2012 08:15:56 +0200
Message-ID: <1348899362-4057-4-git-send-email-mhagger@alum.mit.edu>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:16:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqLx-0002Qb-QM
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757927Ab2I2GQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:16:28 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:53288 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757908Ab2I2GQZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 02:16:25 -0400
X-AuditID: 1207440d-b7f236d000000943-3a-506692399155
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 12.2B.02371.93296605; Sat, 29 Sep 2012 02:16:25 -0400 (EDT)
Received: from michael.fritz.box (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T6G740026219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 02:16:23 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqGs5KS3AoOU6m0XXlW4mi4beK8wW
	R09ZWNxeMZ/ZYv27q8wOrB5/339g8tg56y67x8VLyh6fN8kFsERx2yQllpQFZ6bn6dslcGfc
	2ridteAsR0X7vLOMDYyt7F2MnBwSAiYS+4+vg7LFJC7cW8/WxcjFISRwmVHi/Yw+FgjnLJPE
	lgVtbCBVbAK6Eot6mplAbBEBNYmJbYfAipgFJjFK9Gx4ADSKg0NYwFniapsJSA2LgKrE8hln
	wTbwgoTf32SE2KYo8eP7GmYQm1PAReJ3z3RWEFsIqObR3jusExh5FzAyrGKUS8wpzdXNTczM
	KU5N1i1OTszLSy3SNdLLzSzRS00p3cQICSTeHYz/18kcYhTgYFTi4dU8nhogxJpYVlyZe4hR
	koNJSZT384S0ACG+pPyUyozE4oz4otKc1OJDjBIczEoivBnFQOW8KYmVValF+TApaQ4WJXFe
	tSXqfkIC6YklqdmpqQWpRTBZGQ4OJQlew4lAQwWLUtNTK9Iyc0oQ0kwcnCCCC2QDD9AGFpBC
	3uKCxNzizHSIolOMilLivCIgCQGQREZpHtwAWMy/YhQH+keYVwikigeYLuC6XwENZgIavHRT
	EsjgkkSElFQDI/cT9/25j39Fe3gsZnlieOKCjrj4ZU/RxFVGQgHftL5/bL2Z7edTH/h+8ePV
	jhrKjNcOPS7h/n6b73e5m+0WY6+QQyf7M8yvRr6bcVOmy92t0ZtjywuOsD6jsE0q/98se7Zc
	w0ixeeGPn/8m9gdezLCQNdg4O/DTHpE5pyprAv7+UKvc+CJST4mlOCPRUIu5qDgR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206636>

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
