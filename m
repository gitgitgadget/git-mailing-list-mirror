From: Andrei Dinu <mandrei.dinu@gmail.com>
Subject: [PATCH v4 2/2] diff-no-index.c: read_directory_path() use is_dot_or_dotdot().
Date: Wed, 19 Mar 2014 17:46:30 +0200
Message-ID: <1395243990-6030-1-git-send-email-mandrei.dinu@gmail.com>
Cc: Andrei Dinu <mandrei.dinu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 16:47:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQIho-00022M-9O
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 16:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965608AbaCSPqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 11:46:47 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:37892 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965160AbaCSPqq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 11:46:46 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so6787760eek.13
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 08:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YU4aGmpQ8GurqMT3KogEFdrcG/5TjcJGIXxPDtfKIcQ=;
        b=wtiM34qBUtPoaIf2Ecmej6Nd6xR/bIYbJmCsJA3yoM1rNW6CrF2Mt4eISh29TSzbiZ
         RLepuk9nR+4AckjDpw2FRas7EqjMx3gbUT/SzvQagJFdmRTEU68hB2kZ5UdeGHLYRZiY
         2HCrn+XW7x1sxFAW5UU5as6IMcCwvDQ8kjB+wotohDeiNrsp+E0eRMlDcX8d8gLrEOEv
         ppouDn0VwM8LNwSHM+g2nMy7KwZFDPEDLMNVASxLF5TM0Ri8T1BwezBa9cUEEwFoK1k/
         Lu/oEqZZh5WA91Zb1lL4Pll/6Inmj2lrg//qYYIJz0OhOeJQ9UySW1AhBeHhkbUfI7v6
         +hxA==
X-Received: by 10.14.47.12 with SMTP id s12mr1084eeb.116.1395244005123;
        Wed, 19 Mar 2014 08:46:45 -0700 (PDT)
Received: from localhost.localdomain (p5.eregie.pub.ro. [141.85.0.105])
        by mx.google.com with ESMTPSA id 43sm55432068eeh.13.2014.03.19.08.46.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 08:46:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244455>

Implement code so read_directory_path() use is_dot_or_dotdot() from "dir.h"
instead of strcmp().

Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>

---
 I plan on applying to GSoc 2014.

 diff-no-index.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 5e4a76c..2d1165f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -15,6 +15,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "string-list.h"
+#include "dir.h"
 
 static int read_directory_path(const char *path, struct string_list *list)
 {
@@ -25,7 +26,7 @@ static int read_directory_path(const char *path, struct string_list *list)
 		return error("Could not open directory %s", path);
 
 	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+		if (!is_dot_or_dotdot(e->d_name))
 			string_list_insert(list, e->d_name);
 
 	closedir(dir);
-- 
1.7.9.5
