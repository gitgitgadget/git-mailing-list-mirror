From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 26/40] builtin/apply: make create_one_file() return -1 on error
Date: Mon, 13 Jun 2016 18:09:28 +0200
Message-ID: <20160613160942.1806-27-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURv-0003vv-88
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424950AbcFMQKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36059 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424929AbcFMQKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id m124so16000046wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6XIJzGDRlSHJdDIjI2TQgoaNfNlc2Ove0Kb8p0vENkQ=;
        b=ftipJy2XiYQ3K29NdQxcP47grv7qkY5M3tInyjMVgJvqqAhWyvoXgUV8kNeOxGXGkx
         qjLbBut8FSEjTRR45Zh3QUqQV9/oC0tF1R7H1eOWP9lDHlp8MoZtmNeuZrtrCqz+DNjX
         qyMRBPB/UEECKGTPQNcdsr89eiPVc6Ldxo3TZ1EqZ6fAqOIQiB+nKW+rFv6CcLsowHQp
         30rfDhe5m9CJ42CyEDmxK6TCcOYfW2eKCUZOGHti/0p1ZIQQsNXZrJkS3F8JCy+Dpsim
         DdLGmjkWsGOF+yeY6NDZt0ir3DsWn2wf3reE7It/smPyMmXk5J5fkZ7w/yGzh6xG+cmk
         /ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6XIJzGDRlSHJdDIjI2TQgoaNfNlc2Ove0Kb8p0vENkQ=;
        b=iahSUr6JoDSPfEARsZRkAEdmyk4mDL9f4GrgNBxSo4Z3Bpyaujvzv8oYEB/qN31j5w
         1sPrrJ8U9HTooOwicUO8HO0HIY5DBKKM+Mfi50kiLUFTek2thIn2d5R0Lemgm0bHEvrY
         EdbTTH9DP0pa+0xGRaxZ7SEPFCvvJYCZDWgZOhWZTLDmJicPFkVXE+OnWnSA+4DslK1g
         d67I//u0dYI297sJscyFRgDlo3rmyG4wOP4vEO/IOsTaS4RdSW/MRmV0SsCojw9ICWMy
         Zjoh29w1jraVmqVnWb6KvYxxtOZUkgxonyDcdF5La3mzS3rmtFqrjLERiyhUBU7TAcXo
         AdZA==
X-Gm-Message-State: ALyK8tKK3MwXpzYvizdubLM0L3NQYAHHE0KBgBEde+LUjuxYG/XsJK/f1WULweL7M1JMBA==
X-Received: by 10.28.21.204 with SMTP id 195mr353287wmv.64.1465834232271;
        Mon, 13 Jun 2016 09:10:32 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:31 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297203>

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", create_one_file() should return -1 instead of
calling exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 37f0c2e..f51dc60 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4184,32 +4184,36 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
  * We optimistically assume that the directories exist,
  * which is true 99% of the time anyway. If they don't,
  * we create them and try again.
+ *
+ * Returns:
+ *   -1 on error
+ *   0 otherwise
  */
-static void create_one_file(struct apply_state *state,
-			    char *path,
-			    unsigned mode,
-			    const char *buf,
-			    unsigned long size)
+static int create_one_file(struct apply_state *state,
+			   char *path,
+			   unsigned mode,
+			   const char *buf,
+			   unsigned long size)
 {
 	int res;
 
 	if (state->cached)
-		return;
+		return 0;
 
 	res = try_create_file(path, mode, buf, size);
 	if (res < 0)
-		exit(1);
+		return -1;
 	if (!res)
-		return;
+		return 0;
 
 	if (errno == ENOENT) {
 		if (safe_create_leading_directories(path))
-			return;
+			return 0;
 		res = try_create_file(path, mode, buf, size);
 		if (res < 0)
-			exit(1);
+			return -1;
 		if (!res)
-			return;
+			return 0;
 	}
 
 	if (errno == EEXIST || errno == EACCES) {
@@ -4229,10 +4233,10 @@ static void create_one_file(struct apply_state *state,
 			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
 			res = try_create_file(newpath, mode, buf, size);
 			if (res < 0)
-				exit(1);
+				return -1;
 			if (!res) {
 				if (!rename(newpath, path))
-					return;
+					return 0;
 				unlink_or_warn(newpath);
 				break;
 			}
@@ -4241,7 +4245,8 @@ static void create_one_file(struct apply_state *state,
 			++nr;
 		}
 	}
-	die_errno(_("unable to write file '%s' mode %o"), path, mode);
+	return error(_("unable to write file '%s' mode %o: %s"),
+		     path, mode, strerror(errno));
 }
 
 static int add_conflicted_stages_file(struct apply_state *state,
@@ -4286,7 +4291,8 @@ static int create_file(struct apply_state *state, struct patch *patch)
 
 	if (!mode)
 		mode = S_IFREG | 0644;
-	create_one_file(state, path, mode, buf, size);
+	if (create_one_file(state, path, mode, buf, size))
+		return -1;
 
 	if (patch->conflicted_threeway)
 		return add_conflicted_stages_file(state, patch);
-- 
2.9.0.rc2.411.g3e2ca28
