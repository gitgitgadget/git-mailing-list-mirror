From: Brian Bourn <ba.bourn@gmail.com>
Subject: [PATCH v2 2/2] [GSoC] diff:use is_dot_or_dotdot() in code
Date: Wed, 19 Mar 2014 02:29:38 -0400
Message-ID: <1395210578-1532-2-git-send-email-ba.bourn@gmail.com>
References: <1395210578-1532-1-git-send-email-ba.bourn@gmail.com>
Cc: Brian Bourn <ba.bourn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 07:30:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQA0u-00041Z-EJ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 07:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbaCSGaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 02:30:01 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:59118 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbaCSGaA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 02:30:00 -0400
Received: by mail-ie0-f180.google.com with SMTP id as1so8098235iec.25
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 23:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6/I36XqLwrZGVBVODKIjxBfUSNcCvwrEhn1Uazk66u4=;
        b=OvqFT1SokyPIRJWvyesk1XJS82L4bwn0MXIt1lWmrwRgkRlCfU6FLQRy3+tUL8UIJC
         3v1zL0Or18YHWQpZFkFG35Pnh6/kqcf5poYn5AeGjMdA9w3QxuMYsJzoZZ/FeGCQNJKw
         PmjS2nUlncpgxezYFVmV361O2Fi7jpNrphgHhKEMVwHMnDJx6brRqbuSyiYcT/HKvhzm
         7o/UntxsjHPAaK9BZmUeDVKA12G0m8U0kQF55Ukwi4AYGPU2eoNWPiDveUiRa5Pqe+U3
         SNeqm6aQYup4YvqbSH7cHAOItqx4IzfTCex4daO/dEn2/fgwmN7wnYjknYHxAD0ycZW1
         AEfA==
X-Received: by 10.43.57.19 with SMTP id we19mr30298icb.89.1395210600286;
        Tue, 18 Mar 2014 23:30:00 -0700 (PDT)
Received: from arch.hil-sldcohx.den.wayport.net ([50.95.219.56])
        by mx.google.com with ESMTPSA id y9sm31313024igl.7.2014.03.18.23.29.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Mar 2014 23:29:59 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395210578-1532-1-git-send-email-ba.bourn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244413>

From: Brian Bourn <ba.bourn@gmail.com>

Subject: replace manual "."/".." check with is_dot_or_dotdot()

Signed-off-by: Brian Bourn <ba.bourn@gmail.com>
---
Part 2 of my GSoC submission where the actual change is made
 diff-no-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index ec51106..c554691 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -15,6 +15,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "string-list.h"
+#include "dir.h"
 
 static int read_directory_contents(const char *path, struct string_list *list)
 {
@@ -25,7 +26,7 @@ static int read_directory_contents(const char *path, struct string_list *list)
 		return error("Could not open directory %s", path);
 
 	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+		if (!is_dot_or_dotdot(e->d_name))
 			string_list_insert(list, e->d_name);
 
 	closedir(dir);
-- 
1.9.0
