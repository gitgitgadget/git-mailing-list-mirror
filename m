From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/20] untracked cache: print untracked statistics with $GIT_TRACE_UNTRACKED
Date: Wed,  7 May 2014 21:51:54 +0700
Message-ID: <1399474320-6840-15-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:53:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3Dy-0006HP-3n
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932855AbaEGOxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:53:21 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33739 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbaEGOxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:53:18 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so1331759pab.3
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ENlAMnz4gV2SCUo+t7AZdlaz2ZA0zMnGM4ELe2xchjU=;
        b=LeR3a50WbAjF8BmDlUyl7SWxnq1X7czHGp/ZxjowqM3pqH3UN53cD0mxH0ib+QSSyi
         tEsYCSzj2F6zna71pc+3cpe4PFA1oMTyJYuCXiOHLBRBj1FNadcMvhS7ijExgqG34npC
         2T8j2W8ULlDEgf0w+jf5NfEcMWcyqx7TmRwg1ohVzvgOZNNo2aI6hwEXxLYZEF5uOr1Y
         naQ5NoUw7BYtiaeuFn/o51GEuX6nNrnzsASyeTZhwOjFh5xJNfLkJbqICRFESfdQ8vcT
         CtWkB9wgm1xOr6fzH+VsAIzTmVhd3XlTs72/oNodZ6Gu9d2PitDg8BowYG4RT7y8AzIc
         NtUg==
X-Received: by 10.66.171.76 with SMTP id as12mr19384832pac.52.1399474398022;
        Wed, 07 May 2014 07:53:18 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id ph1sm114178208pac.14.2014.05.07.07.53.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:53:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:53:18 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248319>

This could be used to verify correct behavior in tests
---
 dir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/dir.c b/dir.c
index 18fe44c..58303ca 100644
--- a/dir.c
+++ b/dir.c
@@ -14,6 +14,8 @@
 #include "pathspec.h"
 #include "varint.h"
 
+#define TRACE_KEY "GIT_TRACE_UNTRACKED"
+
 struct path_simplify {
 	int len;
 	const char *path;
@@ -1929,6 +1931,16 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
+	if (dir->untracked) {
+		trace_printf_key(TRACE_KEY, "node creation: %u\n",
+				 dir->untracked->dir_created);
+		trace_printf_key(TRACE_KEY, "gitignore invalidation: %u\n",
+				 dir->untracked->gitignore_invalidated);
+		trace_printf_key(TRACE_KEY, "directory invalidation: %u\n",
+				 dir->untracked->dir_invalidated);
+		trace_printf_key(TRACE_KEY, "opendir: %u\n",
+				 dir->untracked->dir_opened);
+	}
 	return dir->nr;
 }
 
-- 
1.9.1.346.ga2b5940
