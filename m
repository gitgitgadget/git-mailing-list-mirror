From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Fix memory leak in prepend_to_path (git.c).
Date: Tue, 5 Sep 2006 08:22:16 +0200
Message-ID: <20060905082216.c9b11769.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 08:17:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKUF5-0007J4-Jb
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 08:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWIEGQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 02:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWIEGQ7
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 02:16:59 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:17824 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S965179AbWIEGQ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Sep 2006 02:16:58 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id CFAD5547B0;
	Tue,  5 Sep 2006 08:16:56 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26460>

Some memory was allocated for a new path but not freed
after the path was used.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 1d00111..335f405 100644
--- a/git.c
+++ b/git.c
@@ -36,6 +36,8 @@ static void prepend_to_path(const char *
 	memcpy(path + len + 1, old_path, path_len - len);
 
 	setenv("PATH", path, 1);
+
+	free(path);
 }
 
 static int handle_options(const char*** argv, int* argc)
-- 
1.4.2.g269a-dirty
