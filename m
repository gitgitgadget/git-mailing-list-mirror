From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 75/94] builtin/apply: make try_create_file() return -1 on error
Date: Wed, 11 May 2016 15:17:26 +0200
Message-ID: <20160511131745.2914-76-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4e-0004Lj-NU
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbcEKNVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36854 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253AbcEKNVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id w143so9355410wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZMZPtVh6RENg7ObGDgJms1zMjoEV3gjjUmwP7Skiiak=;
        b=vmwk7kOAo5V4BkRC8znmUtJ8MgkcRthRWKkDCX5v8KLd6yYf/D29b2An9TjqsRQRBc
         lZEa8fhHFEOhMsq8Uk+PelpdKWKbVcSQALzDSzYt+Dm8t/TQbgKFJmI6HKr2SiDEoukz
         KRcjlp3aBcjJ+IpRmBcvNOHw5eDdmBiBSL2z+7AV/ReDrLHDqvIEK2HlRqusB75zmMlL
         rZ+AhhW6dcfrJ6xra/KK//knVEKFMTbMe+zIZN1HEYSreLfd8865llnaOI/lVv1viU/W
         ieCpeOjTK2EJy6nyHM9oS5c7P/Q2PZzRnHHIch7RJNYdrlVdLmgYjiBbLNHy81PpXrQd
         jNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZMZPtVh6RENg7ObGDgJms1zMjoEV3gjjUmwP7Skiiak=;
        b=WO6tFufPNrUAhLjZpZrubMTJaM8tLf52bX133mqosgTWcozjIXTOKe9RwCJiyTKFuA
         ZCZi29LldQjHQtlekHKHs3MevvnMxTkkIVS5CXWCIF00yhbJN2fg5zeZp9TRNBok0/pB
         k4/bYOClPNYUErmQadGMsCPUdzZRFoB3BLiLqKS2imwGNBklTUcCSVkii0AVJ79wKltV
         BEt3FV4lLBQIXjNEWwe0raYEa+APPwK8S2517q9D5EmSCGsGTyzru44QC7WRxI1v3sv2
         jEzpdied9UgtCvSKGOHju+4hioEipJzh9tHG5TG4SXGseojm6IJBL5LpkPbTB8IMaVr/
         YU0Q==
X-Gm-Message-State: AOPr4FWhIqaUipRi9xHlZFdZWdoGSFeAP1OHMl8NaKEQZt8GmdVqA1vzdrsmEOy43vaV+g==
X-Received: by 10.28.29.147 with SMTP id d141mr19849wmd.91.1462972861166;
        Wed, 11 May 2016 06:21:01 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:00 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294290>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", try_create_file() should return -1 in case of
error.

Unfortunately try_create_file() currently returns -1 to signal a
recoverable error. To fix that, let's make it return 1 in case of
a recoverable error and -1 in case of an unrecoverable error.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 97bc704..eaf7b8f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4140,38 +4140,45 @@ static int add_index_file(struct apply_state *state,
 	return 0;
 }
 
+/*
+ * Returns:
+ *  -1 if an unrecoverable error happened
+ *   0 if everything went well
+ *   1 if a recoverable error happened
+ */
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
 {
-	int fd;
+	int fd, res;
 	struct strbuf nbuf = STRBUF_INIT;
 
 	if (S_ISGITLINK(mode)) {
 		struct stat st;
 		if (!lstat(path, &st) && S_ISDIR(st.st_mode))
 			return 0;
-		return mkdir(path, 0777);
+		return !!mkdir(path, 0777);
 	}
 
 	if (has_symlinks && S_ISLNK(mode))
 		/* Although buf:size is counted string, it also is NUL
 		 * terminated.
 		 */
-		return symlink(buf, path);
+		return !!symlink(buf, path);
 
 	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
 	if (fd < 0)
-		return -1;
+		return 1;
 
 	if (convert_to_working_tree(path, buf, size, &nbuf)) {
 		size = nbuf.len;
 		buf  = nbuf.buf;
 	}
-	write_or_die(fd, buf, size);
+	res = !write_or_whine_pipe(fd, buf, size, path);
 	strbuf_release(&nbuf);
 
-	if (close(fd) < 0)
-		die_errno(_("closing file '%s'"), path);
-	return 0;
+	if (close(fd) < 0 && !res)
+		return error(_("closing file '%s': %s"), path, strerror(errno));
+
+	return res ? -1 : 0;
 }
 
 /*
@@ -4185,15 +4192,24 @@ static void create_one_file(struct apply_state *state,
 			    const char *buf,
 			    unsigned long size)
 {
+	int res;
+
 	if (state->cached)
 		return;
-	if (!try_create_file(path, mode, buf, size))
+
+	res = try_create_file(path, mode, buf, size);
+	if (res < 0)
+		exit(1);
+	if (!res)
 		return;
 
 	if (errno == ENOENT) {
 		if (safe_create_leading_directories(path))
 			return;
-		if (!try_create_file(path, mode, buf, size))
+		res = try_create_file(path, mode, buf, size);
+		if (res < 0)
+			exit(1);
+		if (!res)
 			return;
 	}
 
@@ -4212,7 +4228,10 @@ static void create_one_file(struct apply_state *state,
 		for (;;) {
 			char newpath[PATH_MAX];
 			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
-			if (!try_create_file(newpath, mode, buf, size)) {
+			res = try_create_file(newpath, mode, buf, size);
+			if (res < 0)
+				exit(1);
+			if (!res) {
 				if (!rename(newpath, path))
 					return;
 				unlink_or_warn(newpath);
-- 
2.8.2.490.g3dabe57
