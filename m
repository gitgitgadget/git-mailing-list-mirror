From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/8] Introduce new function real_path_if_valid()
Date: Wed, 26 Sep 2012 21:34:44 +0200
Message-ID: <1348688090-13648-3-git-send-email-mhagger@alum.mit.edu>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:35:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxOf-0004jo-HI
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758310Ab2IZTfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:35:31 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:56058 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758198Ab2IZTf2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 15:35:28 -0400
X-AuditID: 12074414-b7f846d0000008b8-f6-506358ff721e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id ED.F2.02232.FF853605; Wed, 26 Sep 2012 15:35:27 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8QJZFfg010704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Sep 2012 15:35:26 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqPs/IjnA4OhfU4uuK91MFg29V5gt
	jp6ysLi9Yj6zxfp3V5kdWD3+vv/A5LFz1l12j4uXlD0+b5ILYInitklKLCkLzkzP07dL4M54
	v7204CxHxb7/mg2MrexdjJwcEgImEm+m/GODsMUkLtxbD2RzcQgJXGaUWLxkFTOEc4ZJ4sGd
	s0wgVWwCuhKLeprBbBEBNYmJbYdYQIqYBSYxSvRseAA2VljAQeL71+tgY1kEVCWWXjzODGLz
	CrhIPDlwD2qdosSP72vA4pwCrhJfNlwAiwsB1Rx+dYt5AiPvAkaGVYxyiTmlubq5iZk5xanJ
	usXJiXl5qUW6Fnq5mSV6qSmlmxghYSSyg/HISblDjAIcjEo8vB9tkwOEWBPLiitzDzFKcjAp
	ifJahwGF+JLyUyozEosz4otKc1KLDzFKcDArifA+y0oKEOJNSaysSi3Kh0lJc7AoifN+W6zu
	JySQnliSmp2aWpBaBJOV4eBQkuBdHg40VLAoNT21Ii0zpwQhzcTBCSK4QDbwAG2IBynkLS5I
	zC3OTIcoOsWoKCXO2wmSEABJZJTmwQ2ARfwrRnGgf4R554BU8QCTBVz3K6DBTECDl24COb24
	JBEhJdXAmB4dfX/G7/v5DPKJB35NWc2f/1nAJT0yr/AHWwTT7EMTWnUPTZrWaWiz9tR30bU6
	u000v7/fsCtW0fDu1X0Rf5ii3d/VxVfc0My3/vmvZf2tmqZX77dafFpY6M79cv1zIeX5xsaP
	bDq+Hkhr+7Ekb262/9QPVSl6t6z4ll3kqU3Isplfzf0/X4mlOCPRUIu5qDgRAEVT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206434>

The function is like real_path(), except that it returns NULL on error
instead of dying.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c | 5 +++++
 cache.h   | 1 +
 2 files changed, 6 insertions(+)

diff --git a/abspath.c b/abspath.c
index a7ab8e9..5748b91 100644
--- a/abspath.c
+++ b/abspath.c
@@ -146,6 +146,11 @@ const char *real_path(const char *path)
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
