From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 5/7] git-commit: replace use of home_config_paths()
Date: Sun, 12 Apr 2015 15:46:10 +0800
Message-ID: <1428824772-8736-5-git-send-email-pyokagan@gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 09:47:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhCc4-0004wG-MI
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 09:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbbDLHrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 03:47:17 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36258 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbDLHrN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 03:47:13 -0400
Received: by pabsx10 with SMTP id sx10so68411442pab.3
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 00:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R3Qbh++uy/QjhzT4OsFMwWrdV7mN6yr6iQxf2eTzLAc=;
        b=ufbEof+kt2SsoJfmYQ/OCslQLb4735ZGIak2FXe73wmC3/Q0YWsYZlkvcoKqj+b76y
         5UyJz5h/sT2rtXzJeCqD4r31cl58NgJstw4KJLbEzNS/Cf0ac+KfVq3zxZE9r3hVJARG
         XLyoTjmngqySFpK19ypGU04UKkoAbn82c+bnHI40lZM2bgdnBS1C3mnsFGJx3oMXgD9N
         fODVr3GTNFOQEqcdzRsTgcZ4yLhIhLY69zDaNUZklxBfxmX//I++M4c+wt3lbumlI/CY
         sOJKUQ0OwBXUlx6k7hQeT1qBklfDHx+zHYKltqEGS8z07JW6sc53iGYiMdGXeahljnHX
         gBdQ==
X-Received: by 10.70.46.65 with SMTP id t1mr16297615pdm.128.1428824832804;
        Sun, 12 Apr 2015 00:47:12 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id ei17sm3783153pac.20.2015.04.12.00.47.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Apr 2015 00:47:11 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267046>

Since home_config_paths() combines two distinct functionality already
implemented by expand_user_path() and xdg_config_home(), and hides the
home config file path ~/.gitconfig. Make the code more explicit by
replacing the use of home_config_paths() with expand_user_path() and
xdg_config_home().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/commit.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index da79ac4..c2ebea4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1398,12 +1398,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 static const char *implicit_ident_advice(void)
 {
-	char *user_config = NULL;
-	char *xdg_config = NULL;
-	int config_exists;
+	char *user_config = expand_user_path("~/.gitconfig");
+	char *xdg_config = xdg_config_home("config");
+	int config_exists = file_exists(user_config) || file_exists(xdg_config);
 
-	home_config_paths(&user_config, &xdg_config, "config");
-	config_exists = file_exists(user_config) || file_exists(xdg_config);
 	free(user_config);
 	free(xdg_config);
 
-- 
2.1.4
