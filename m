From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 26/44] builtin/apply: make create_one_file() return -1 on error
Date: Fri, 10 Jun 2016 22:11:00 +0200
Message-ID: <20160610201118.13813-27-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnG-0003cB-2q
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbcFJUMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36002 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932296AbcFJUMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id m124so1035578wme.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ASx4rOkHrN/+hkWI4ZrVHBOMo+8RoAiX6lHfMYl2sCw=;
        b=iTRUE629ZeyUVg4o6bmUukJ7E3eOlUTTtSD5qJyEuCfmiBfsUkT8BC0T9gymuNjDqY
         WZ+Pgl4TrkIMvUWCu4fKP5FPFmdOerYbiT9bxRPQTIUUy15yCILokU+KUDIVurverR5I
         nX8yav+WyN8L5CIjP8IjE6GNAVphHSGGfkvxnAIGfZIx6c+UevV8EDr1Hsxis57LPPnF
         lI7R6pyKnsMhKjY6mT+2ixtDzpY824awqS5fmSl4T8xS3O0WEbwgnb+SxaJbxFV+OADV
         Tt4o3aT5HOb8HZH08N9zvrnhsgbnBH9sFW30Z3C1RUCQzhIQI0VawXOsYp59WTg0lRLs
         PThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ASx4rOkHrN/+hkWI4ZrVHBOMo+8RoAiX6lHfMYl2sCw=;
        b=M1BA52s+AuLMhD0WYzUjxAokQqA1g4+4XwloCJyumMqsCd0lzJh/2ARRlvvbMNBLG6
         7r2q0VhiHQFaWkRmcmPdOItlbAmQ9b41lHaQ7jBO5ipvAx8O1qgLy1eTQ1TgTAGC7Hnj
         XqEeb0pHPBwYVjqxzGkYX16a2UT+p0ynPYxH96TWXryR3zQfo6dnA3j/mpVK+1NWRzya
         ZtuqGw8DOTlOp+3qFAeLdhJr8pYzXvTzKNSjM40JRLBCxy7uWaqYUNXbZNF1TIujbtLA
         S9m35N5o4zwZiaZBht21isKo0rWzQ5y3sThfYFDIDnv96hTILuzJ9o1cBTOqeMwimyFw
         aA7g==
X-Gm-Message-State: ALyK8tIPMxZmXBjNdrxNrQHzKgHtI7VsfT4JoJd6+xA8nDjcPh+OLmG0sFXxhTP8Kw7PJg==
X-Received: by 10.194.133.161 with SMTP id pd1mr3804814wjb.16.1465589536556;
        Fri, 10 Jun 2016 13:12:16 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:15 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297040>

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
2.9.0.rc2.362.g3cd93d0
