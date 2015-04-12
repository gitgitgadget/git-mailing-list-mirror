From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 3/7] dir.c: replace home_config_paths() with xdg_config_home()
Date: Sun, 12 Apr 2015 15:46:08 +0800
Message-ID: <1428824772-8736-3-git-send-email-pyokagan@gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 09:47:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhCbv-0004qZ-8P
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 09:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbbDLHrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 03:47:11 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35442 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbDLHrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 03:47:08 -0400
Received: by pabtp1 with SMTP id tp1so68439660pab.2
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KgdMKY+h8VHR8oB/I6Bn9FEv5hJlkHCoHzzTA0k+Naw=;
        b=g/HofUNO4PIB2VoEUHG3NhKHnC5NLr7+r5MMyNwAjyPcn58QPtaamvW22RMlk/rDLD
         Br+SP3Ud11tPcUa3k4s2feNp/C1UoCVfIhvOOMXNeyefQGrZwT8FSq53QI+I0/iyL7XZ
         nFxf+p0c6YAqQX0SIsTBSm8pS6/j9J4CiE7biySLxQ6zLBNAbmtNoZunA47uFu4g8Tk9
         Z5mn0tXCyQgIQ/ancDsM6Vw0pZsan867gURR0QiPAvyyZ/pA/9nFDyXyKBKENm0+OAo2
         3XK0WTYxOic9zDupbVuMfK6QvQcj2UwwSjKhUXB5dinw5ulLdcakkI4bDZDK9rKkDxLq
         XNXQ==
X-Received: by 10.66.119.238 with SMTP id kx14mr16499962pab.2.1428824827937;
        Sun, 12 Apr 2015 00:47:07 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id ei17sm3783153pac.20.2015.04.12.00.47.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Apr 2015 00:47:06 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267043>

Since only the xdg excludes file path is required, simplify the code by
replacing use of home_config_paths() with xdg_config_home().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 dir.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 0943a81..335dc7e 100644
--- a/dir.c
+++ b/dir.c
@@ -1665,14 +1665,11 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
-	char *xdg_path;
 
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
-	if (!excludes_file) {
-		home_config_paths(NULL, &xdg_path, "ignore");
-		excludes_file = xdg_path;
-	}
+	if (!excludes_file)
+		excludes_file = xdg_config_home("ignore");
 	if (!access_or_warn(path, R_OK, 0))
 		add_excludes_from_file(dir, path);
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
-- 
2.1.4
