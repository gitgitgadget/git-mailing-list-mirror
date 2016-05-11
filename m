From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 76/94] builtin/apply: make create_one_file() return -1 on error
Date: Wed, 11 May 2016 15:17:27 +0200
Message-ID: <20160511131745.2914-77-chriscool@tuxfamily.org>
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
	id 1b0U4e-0004Lj-5N
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbcEKNVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32991 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932353AbcEKNVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id r12so9417594wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+RZqK9K9N+310h6Oe0ywtevAo0blIkzh3pRQsj0IVt0=;
        b=XgAnUgRJiOR+ZLQW0V6lsAcV53WvOfd0P75ZcPt3kYmOmI4lvrIoRCkqmAqAJY10sZ
         UXoy4eASTyMbBefp0t5FRLeS5PDzaz3hBH4Cc3zKm58CrXyCW6IixgGBBKoU18pDGnrz
         moZj1XEW6PU/py3ZlVzoVu4CthxZDKq8xoJk+3kL0c5/SPUKeWVTGmwjSV1FxD3SpTYn
         RzlZl/s+dv4ali52LSvJu/8IEp9Ae2mdAbEIXAzkLriC1dmYAj7mISFI968k+muJ3w45
         w5QVQJ5WHtpihIxHFJnkFnuZm6SLvPd/6/MMz2SdCJAWEu5Yb5T3ErIwFqvQusRIBvME
         ROow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+RZqK9K9N+310h6Oe0ywtevAo0blIkzh3pRQsj0IVt0=;
        b=KzjN9/nodnGE9sg9L3NHChdYmFCiATEA0izph6nJoXX7CwqxZ8ULmcybB/kuRPpWM+
         aTVY7wGNeUTNzJMaYwqKEKYE5WU7oQJyxAoq0breowapAg5f7ZtxRFZ5Si/nmzZhhn4f
         rcEVSj4MsFD3pcdX7JKdfCLzvv1IY1kTghx18Dkso9ywwl8PZGwQQzMBALFhjiun6Of2
         NyABQ1rcwZR1ljDNflmAxOf8k5sH5Duib6hd+P2AWZomV93JX9g15i8ZvCcFdBL4iMtq
         JF0VIpQNRp3DvJ7dQVLzji7pI+X8lXjY3BgVTVGy2oyZ7LflK7ehbpg47AOtA2uLsS3H
         SDJw==
X-Gm-Message-State: AOPr4FUddT3UVC0z4VayJHNVYl2ISVJZmqN6OE6uDjL+GuXDATqugvjiSHLI8+qNb63JSw==
X-Received: by 10.194.192.8 with SMTP id hc8mr3843971wjc.87.1462972863001;
        Wed, 11 May 2016 06:21:03 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:02 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294294>

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
index eaf7b8f..8c31617 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4185,32 +4185,36 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
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
@@ -4230,10 +4234,10 @@ static void create_one_file(struct apply_state *state,
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
@@ -4242,7 +4246,8 @@ static void create_one_file(struct apply_state *state,
 			++nr;
 		}
 	}
-	die_errno(_("unable to write file '%s' mode %o"), path, mode);
+	return error(_("unable to write file '%s' mode %o: %s"),
+		     path, mode, strerror(errno));
 }
 
 static int add_conflicted_stages_file(struct apply_state *state,
@@ -4287,7 +4292,8 @@ static int create_file(struct apply_state *state, struct patch *patch)
 
 	if (!mode)
 		mode = S_IFREG | 0644;
-	create_one_file(state, path, mode, buf, size);
+	if (create_one_file(state, path, mode, buf, size))
+		return -1;
 
 	if (patch->conflicted_threeway)
 		return add_conflicted_stages_file(state, patch);
-- 
2.8.2.490.g3dabe57
