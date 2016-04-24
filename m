From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 74/83] builtin/apply: make try_create_file() return -1 on error
Date: Sun, 24 Apr 2016 15:34:14 +0200
Message-ID: <1461504863-15946-75-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDi-0000Mv-FN
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbcDXNg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:57 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38706 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbcDXNga (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:30 -0400
Received: by mail-wm0-f42.google.com with SMTP id u206so89955634wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NPLsCN0PtbeZH6yLGPJKS9FYGGqqxe2B5rx9txodDS8=;
        b=hrNffHHaaP0b8KeK4xhTvlKfgFhRrIabs7IP+NACmfhdGU4e7x6uuAsjOYgqXphdb1
         ke/EJ0RL9eskaCmm2/1teV+ZMumsJ/FSwREmxS52l2TXbbiqCxSpCeg0NG+Cs41Mx3Dh
         BVHvyVQ2cuTiDYLtLiMeIgEKtXwXGQpTNYymgBlOpbIvij9bOGvANnQzGqKvzoRNJktu
         lKBCO9aLMm3XvQAnrM9c1amLklKm5daDcs8EZD3PcyFSQ3PLqBGaGTx7bQjEYnJT/OmF
         9MVRFrJTKRsQ/lTt0bBahzp92wqOVBeMeeeFY7KKviMzSjcpW8vF+/bvTS5YMBGRP91s
         uNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NPLsCN0PtbeZH6yLGPJKS9FYGGqqxe2B5rx9txodDS8=;
        b=YYGfHWVklQ4u5vGa0tyCGck/e3KzRwDKEfX9GKFKmpANvoOpYsCaL4FjAmphb+X1S2
         ZmBf3Ea5oqGh/msQ9hVpjtl7lCwQjRQSTohWJcQh//vwEpMhJJ89cPyNn3Qmd9fqDuQn
         xyFk8O5+3W8k53UsiCc6iP19Ci7ZKL4A8rctm1rt2xX9hJ8bIom/hvow2XWlHn1NG+sF
         rNEnvPcJ9fHCD1UYPp43ANQHeQ8dy7g+OWYNLiHBqWiXEUyk/gytxIRqy2wga0OWoX7E
         Qp90UUaJxxuDJjKFb/5A/m5LKGykVZeU8u8UC1sPIxjs2/C/UsaiFKpGwSeSO63wFC6e
         9yYQ==
X-Gm-Message-State: AOPr4FWDFbbMDeAcC5n4Z4OUI4Qwtgdz7Aq7ADBfWLR24zTBqVlYfhpDNdBX9uXrepdKRg==
X-Received: by 10.28.94.5 with SMTP id s5mr7197566wmb.26.1461504989186;
        Sun, 24 Apr 2016 06:36:29 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:28 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292367>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 49ef4c9..32c38f0 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4136,6 +4136,12 @@ static int add_index_file(struct apply_state *state,
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
 	int fd;
@@ -4145,28 +4151,32 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
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
+
+	if (!write_or_whine_pipe(fd, buf, size, path)) {
+		strbuf_release(&nbuf);
+		return -1;
+	}
 	strbuf_release(&nbuf);
 
 	if (close(fd) < 0)
-		die_errno(_("closing file '%s'"), path);
+		return error(_("closing file '%s': %s"), path, strerror(errno));
 	return 0;
 }
 
@@ -4181,16 +4191,25 @@ static void create_one_file(struct apply_state *state,
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
+	if (!res)
 		return;
+	if (res < 0)
+		exit(1);
 
 	if (errno == ENOENT) {
 		if (safe_create_leading_directories(path))
 			return;
-		if (!try_create_file(path, mode, buf, size))
+		res = try_create_file(path, mode, buf, size);
+		if (!res)
 			return;
+		if (res < 0)
+			exit(1);
 	}
 
 	if (errno == EEXIST || errno == EACCES) {
@@ -4208,12 +4227,15 @@ static void create_one_file(struct apply_state *state,
 		for (;;) {
 			char newpath[PATH_MAX];
 			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
-			if (!try_create_file(newpath, mode, buf, size)) {
+			res = try_create_file(newpath, mode, buf, size);
+			if (!res) {
 				if (!rename(newpath, path))
 					return;
 				unlink_or_warn(newpath);
 				break;
 			}
+			if (res < 0)
+				exit(1);
 			if (errno != EEXIST)
 				break;
 			++nr;
-- 
2.8.1.300.g5fed0c0
