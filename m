From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 3/8] Introduce new function real_path_if_valid()
Date: Sun, 28 Oct 2012 17:16:22 +0100
Message-ID: <1351440987-26636-4-git-send-email-mhagger@alum.mit.edu>
References: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:17:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSVXu-0003CZ-Sf
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 17:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab2J1QQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 12:16:56 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:64186 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753086Ab2J1QQz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 12:16:55 -0400
X-AuditID: 12074414-b7f846d0000008b8-00-508d5a76b268
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 9C.9F.02232.67A5D805; Sun, 28 Oct 2012 12:16:54 -0400 (EDT)
Received: from michael.fritz.box (p57A2465E.dip.t-dialin.net [87.162.70.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9SGGXJd002689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Oct 2012 12:16:53 -0400
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqFsW1RtgcH6JqUXXlW4mi4beK8wW
	T+beZbY4esrC4vaK+cwWP1p6mC3Wv7vK7MDu8ff9ByaPnbPusns8fNXF7vGsdw+jx8VLyh6f
	N8kFsEVx2yQllpQFZ6bn6dslcGd03fzFXnCKo+LxhJNsDYxN7F2MnBwSAiYSX07OZoOwxSQu
	3FsPZHNxCAlcZpTovbGXHcI5wyTx795GFpAqNgFdiUU9zUwgtoiArMT3wxsZQYqYBe4ySkw6
	OhVslLCAs8TX3f/BilgEVCW2PF4OFucVcJHYcWQ7K8Q6OYkPex4BbeDg4BRwlTja7wwSFgIq
	+bPqHeMERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUICTmQH45GT
	cocYBTgYlXh4LxX0BAixJpYVV+YeYpTkYFIS5WUO6g0Q4kvKT6nMSCzOiC8qzUktPsQowcGs
	JMK7lBsox5uSWFmVWpQPk5LmYFES5/22WN1PSCA9sSQ1OzW1ILUIJivDwaEkwXshEqhRsCg1
	PbUiLTOnBCHNxMEJIrhANvAAbVgHUshbXJCYW5yZDlF0ilFRSpz3WARQQgAkkVGaBzcAlhpe
	MYoD/SPMuxGknQeYVuC6XwENZgIarMMHNrgkESEl1cDYn1BstWz32Q2X5rz3T710cvbL9sU8
	Ocemam8KmrFtr+6uKS+O3XLimfEode6NRzoHZrJu6uzzOZVstHjpZg6XJjuHj2fPv14dJb/e
	4oDK7KMv2p/beKbKfxbj84oLYj4kLtg7V6bdY5Ykc+tbz5upq9Yr2665mpszZcLx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208553>

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
1.8.0
