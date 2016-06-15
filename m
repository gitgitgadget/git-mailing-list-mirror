From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2 3/6] wrapper: move is_empty_file() from builtin/am.c
Date: Wed, 15 Jun 2016 19:30:23 +0530
Message-ID: <20160615140026.10519-4-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 16:02:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDBOW-00076p-5P
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 16:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbcFOOCC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2016 10:02:02 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36286 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161083AbcFOOB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 10:01:59 -0400
Received: by mail-pa0-f66.google.com with SMTP id fg1so1639187pad.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMXnkseQRDhIbJZNpnSZCwiNcfYvGXdpesABCE+asio=;
        b=OhdfeeS+mW/C5rWWIv8qujmQCWFetDNzfCX+/l2AKi2a0Xl0Nyxo33heDF48hnkXVR
         sWTUuLBYXX2ov9C2NtxkRxDT8OJL4R5YKR2fXqbDtVIQV+ts6zA41j/27cWsBzNzpStK
         mqmoht2wLcRs9/Oy8u1lTjU46Yj992jmAxOS2321wbLTR8DdztvsPr9bfXBOysR3KyE/
         HmFFJ0icBVOSWdlbz2gnG5CCTUSv6OCbj9GrlCKeaQMCJwFFMkF3FotPa66gTEhy/VQv
         /Rq8c7AGlSBgAFe2kQuOsapfB3EK17EJRg1chUpjjko4I4Co3uow9EBAOqwRCgTy9+Ug
         iY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMXnkseQRDhIbJZNpnSZCwiNcfYvGXdpesABCE+asio=;
        b=aOQgPefEygHeWTqJ2qvdIwoOQiaTqB3RGpSbONXvFWP49qNmj5k3ntICwDw7q6vtvz
         md2folaCiZ0QQ8HZ7fhUNvX0pvLwcUR5tUN4MZNcEl0q+2CZNM7Hz2cswVw1mS2MpDXJ
         QuPlrbgMKCXJrm1pRr0x5ze1C1MZBSUi/5eJzIac8dfZiEPtQ6711b6kFurCqB8KDm0l
         DwPYH59VBlqFa3M58NgM6NuflBu2wf0eTcTrmEKK8qq2FoSFw8nCVPYLBazKXYTypEth
         /IraApZxcm6zd0oUmvZiDtzmi3HfXvMBmrXmoK2/gs9qki0NFvGm0HQRO5QcQgvQLqwt
         Oovw==
X-Gm-Message-State: ALyK8tJLaTQZJhvDwB4n4S0sFg4scWXOb9spAaICHKJP2X0C9gs2K4lVo4cVdMLi2oO4Ug==
X-Received: by 10.66.166.202 with SMTP id zi10mr4076075pab.42.1465999317415;
        Wed, 15 Jun 2016 07:01:57 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.188])
        by smtp.gmail.com with ESMTPSA id i5sm37514156pfk.14.2016.06.15.07.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jun 2016 07:01:56 -0700 (PDT)
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160615140026.10519-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297375>

is_empty_file() can help to refactor a lot of code. Also it is quite
helpful while converting shell scripts which use `test -s`. Since
is_empty_file() is now a "library" function, its inappropriate to die()=
 so
instead error_errno() is used to convey the message to stderr while the
appropriate boolean value is returned.

Suggested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/am.c | 16 ----------------
 cache.h      |  3 +++
 wrapper.c    | 13 +++++++++++++
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3dfe70b..84f21d0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -30,22 +30,6 @@
 #include "mailinfo.h"
=20
 /**
- * Returns 1 if the file is empty or does not exist, 0 otherwise.
- */
-static int is_empty_file(const char *filename)
-{
-	struct stat st;
-
-	if (stat(filename, &st) < 0) {
-		if (errno =3D=3D ENOENT)
-			return 1;
-		die_errno(_("could not stat %s"), filename);
-	}
-
-	return !st.st_size;
-}
-
-/**
  * Returns the length of the first line of msg.
  */
 static int linelen(const char *msg)
diff --git a/cache.h b/cache.h
index 6049f86..8eaad70 100644
--- a/cache.h
+++ b/cache.h
@@ -1870,4 +1870,7 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
=20
+/* Return 1 if the file is empty or does not exists, 0 otherwise. */
+extern int is_empty_file(const char *filename);
+
 #endif /* CACHE_H */
diff --git a/wrapper.c b/wrapper.c
index 5dc4e15..36a3eeb 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -696,3 +696,16 @@ void sleep_millisec(int millisec)
 {
 	poll(NULL, 0, millisec);
 }
+
+int is_empty_file(const char *filename)
+{
+	struct stat st;
+
+	if (stat(filename, &st) < 0) {
+		if (errno =3D=3D ENOENT)
+			return 1;
+		error_errno(_("could not stat %s"), filename);
+	}
+
+	return !st.st_size;
+}
--=20
2.9.0
