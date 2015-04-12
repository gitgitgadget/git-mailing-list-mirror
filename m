From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 2/7] attr.c: replace home_config_paths() with xdg_config_home()
Date: Sun, 12 Apr 2015 15:46:07 +0800
Message-ID: <1428824772-8736-2-git-send-email-pyokagan@gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 09:47:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhCbq-0004oR-3p
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 09:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbbDLHrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 03:47:08 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35402 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbbDLHrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 03:47:05 -0400
Received: by pabtp1 with SMTP id tp1so68438970pab.2
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EqGeiikvkWZdIyWuD0ydVIjAL5hT5m2BiAbdETp/CtI=;
        b=I6D9GbP31fO+3KcsaFNHXHnEYDqzLShd4foZfQMq1WiAhkrUapzeud3rjKfVCwVo/h
         LHBU3+QfXKXqCxUbgYf7BE4C1WE9Yu4Mj8MY+/n88p9Y6bR01nYF0sbBWTj800c1SAGF
         gLZIY+9YDijFVQdR0xu8j0jjvFiskTCl9aNru+49CnEUcA7YxYFEDvg7BZFLBv/S1OyO
         arJeow0Oh0gIuuK/xPblFj8PRD2Zc3TaaFSVY08vfyBTHgpqAfmvVbQgQbm0JQl6mU6I
         T7dVtaJKeWt5etSQyw5qfv9zashYHzQVvx/UVt+2QN7pbpuA7kueK+58RCplkrHa7Rby
         6xRw==
X-Received: by 10.66.142.137 with SMTP id rw9mr16414111pab.56.1428824825282;
        Sun, 12 Apr 2015 00:47:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id ei17sm3783153pac.20.2015.04.12.00.47.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Apr 2015 00:47:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267041>

Since only the xdg attributes file path is required, simplify the code
by using xdg_config_home() instead of home_config_paths().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 attr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index 1f9eebd..868dce3 100644
--- a/attr.c
+++ b/attr.c
@@ -488,7 +488,6 @@ static int git_attr_system(void)
 static void bootstrap_attr_stack(void)
 {
 	struct attr_stack *elem;
-	char *xdg_attributes_file;
 
 	if (attr_stack)
 		return;
@@ -507,10 +506,8 @@ static void bootstrap_attr_stack(void)
 		}
 	}
 
-	if (!git_attributes_file) {
-		home_config_paths(NULL, &xdg_attributes_file, "attributes");
-		git_attributes_file = xdg_attributes_file;
-	}
+	if (!git_attributes_file)
+		git_attributes_file = xdg_config_home("attributes");
 	if (git_attributes_file) {
 		elem = read_attr_from_file(git_attributes_file, 1);
 		if (elem) {
-- 
2.1.4
