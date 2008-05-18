From: drafnel@gmail.com
Subject: [PATCH] builtin-clone.c: Need to closedir() in copy_or_link_directory()
Date: Sat, 17 May 2008 23:00:01 -0500
Message-ID: <3926741.1211083121329.JavaMail.teamon@b306.teamon.com>
References: <1211083201-2696-1-git-send-email-foo@example.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun May 18 05:59:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxa3X-000162-Gy
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 05:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbYERD6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 23:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYERD6n
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 23:58:43 -0400
Received: from mailproxy06.teamon.com ([64.14.130.37]:23791 "EHLO
	b306.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751712AbYERD6n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 23:58:43 -0400
Received: from b306.teamon.com (localhost [127.0.0.1])
	by b306.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m4I3wfd30260;
	Sun, 18 May 2008 03:58:41 GMT
X-Mailer: git-send-email 1.5.5.1.447.geb0a7
In-Reply-To: <1211083201-2696-1-git-send-email-foo@example.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82374>

From: Brandon Casey <drafnel@gmail.com>

So not to leak file descriptors, close the directory after opening it.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin-clone.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 8713128..8936a51 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -215,6 +215,7 @@ static void copy_or_link_directory(char *src, char *dest)
 				die("failed to create link %s\n", dest);
 		}
 	}
+	closedir(dir);
 }
 
 static const struct ref *clone_local(const char *src_repo,
-- 
1.5.5.1.447.geb0a7
