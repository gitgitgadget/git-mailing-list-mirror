From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 25/40] builtin/apply: make try_create_file() return -1 on error
Date: Mon, 13 Jun 2016 18:09:27 +0200
Message-ID: <20160613160942.1806-26-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSZ-0004Qg-6G
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424959AbcFMQKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36044 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424915AbcFMQKc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id m124so15999896wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NIUbrVWL84QcwR+nythQ2ziSzVZ8mLDsXtF0y/Uk5Tc=;
        b=oyJVwiut/LROHexq8fCToId+6oie6McI6zRDQgE9yqcvFFhgkZa4kmPZkJWaq12sv5
         nKkn7Bt2HBP9w1XNG+1jq1zeTYOtN+A+sDzbhEcPfEJZgc6MXFMyWV9QtxhrbEsZHK7y
         URmOuutRzPJobfxNxIUGjfnX47RZeoslWftZI9tHXh+C4xKoLlGWoq7DjRP7VqchbTxT
         fSust9jwjK7hyAb11S570jhy+VXk15qzUKo7Y8P97/iebzxHfnU3eyEeA28FVVDDZxcg
         Jsy8N9eaKEQKCYrtAa8wYdJxs3MQwNL0Xcz0amgIStn8EeUaxwaNJ3yf6bPoRPBFWXFU
         Eg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NIUbrVWL84QcwR+nythQ2ziSzVZ8mLDsXtF0y/Uk5Tc=;
        b=Ltl4wlBzX3dboZMxRpFqT4WvxleDfJne8keCDq8kHnVRp+YabZ84A8acveGiNrwUiM
         UPAYC02mgEbXlyikO9S4c1dUWlUauelWjDjFDZ67yahWnHi1uRV2mGrpIilkF7OuoXvJ
         cOsIfAwmfs+5wU0qhPC/EhF/4ORRhmyjUznV/0dAWLqn5S4IXNisFlHj0lo+xlljnBzp
         tt83TBUMvxm+uGRnapvs03tPIPELeSKpbZ28GPBGOo3eQK5eV5ZgZqClkbLPh3ZIe4h/
         reorXJxRMeS/xVsNrpHaaKETa8B7kgTu7yj+kbwEDQRRNQln3S7VmHMdoXjPD1Ea6WR5
         qQfg==
X-Gm-Message-State: ALyK8tKiaIi2veSeVdWUXjm69bNeUcdMOyxnkOT3MYjjEwBshRaD85oZiK8yg/Nc/2IEfw==
X-Received: by 10.194.89.5 with SMTP id bk5mr2072378wjb.55.1465834230844;
        Mon, 13 Jun 2016 09:10:30 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:30 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297216>

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
2.9.0.rc2.411.g3e2ca28
