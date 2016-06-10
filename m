From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 25/44] builtin/apply: make try_create_file() return -1 on error
Date: Fri, 10 Jun 2016 22:10:59 +0200
Message-ID: <20160610201118.13813-26-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSn0-0003PH-AZ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbcFJUMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34354 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446AbcFJUMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id n184so1056271wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1bMUats5TBV2X2B2VRwIoqjjhkmgg97az7d4xvMB//Y=;
        b=ZI5dlGmuFM9qLHzfsbdmDG6f2y6F7c6Va2xNAImwG2OAruyfsol3OEOrk3pcKay2Fq
         8xLPVkH2zjoPCm34bfZx39iS1lv4P15gG58PO+kGUL8epoqaTlQEOaVwQAhmPV3zM0se
         eTxMZgesjm/+vvld8/+eKF6fMA9WKN8O9taTI1alPtR+6ryLDacNby689qhBv2SzPAVY
         V9lWav87kWFxSPtPP59+zWwihwBm+pFGGdJ+/XuhgYg7pvmKDfnbOF4R4c5NXaJ5nPK5
         nW2tpD0TyxdONfyj21HJ791FxD3fNVeXbLj7Lf7zO2E0wCq7E4nUiIWPX0IIcXE74MEd
         ULdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1bMUats5TBV2X2B2VRwIoqjjhkmgg97az7d4xvMB//Y=;
        b=b0U8ic/V2kVdO/LzTzq4Iu98SxnmcsFU+CNT/cyAb0e6/hNIiAFIHFljDSHnyUwB+D
         qFwE5GvzHs9/dRPdgJ4tyPXnnmdUeYrnBreucfWC2+9HZINp7HSAQRfFnD0VgomU2T4S
         zeO4gQbh5i1lGopHavIi63CIkiR21mIfUwfWd/WB7Xok+Ml16QDYxeoel0NeZ5afZCOm
         pRIZGMHIw2Ue8X/w9/FsdFzQ1Gi4HfYR6gNyAVr9Lb//QAJlteC0RCVkDFdi/LT9y+JC
         3AA1Ya/ijO48Z8gAQ22+fgWREYX2hA+rnWTkDRIjmrXiHyQ3CIGlVbxRdz6KPUycWWZj
         Vagg==
X-Gm-Message-State: ALyK8tIHHv+Zgeho5kxh0Sz5RBdR5EFfxHBX2ciwuCzqQ0r7xh7pm3EaOipoRN4wEREtJQ==
X-Received: by 10.194.76.33 with SMTP id h1mr3705502wjw.43.1465589534752;
        Fri, 10 Jun 2016 13:12:14 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:13 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297034>

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
index f35c901..37f0c2e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4139,38 +4139,45 @@ static int add_index_file(struct apply_state *state,
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
@@ -4184,15 +4191,24 @@ static void create_one_file(struct apply_state *state,
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
 
@@ -4211,7 +4227,10 @@ static void create_one_file(struct apply_state *state,
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
2.9.0.rc2.362.g3cd93d0
