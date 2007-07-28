From: Thomas Schwinge <tschwinge@gnu.org>
Subject: [PATCH] Don't rely on unspecified behavior
Date: Sat, 28 Jul 2007 20:26:35 +0200
Message-ID: <11856471952272-git-send-email-tschwinge@gnu.org>
References: <20070728173948.GD23337@cip.informatik.uni-erlangen.de>
Cc: Thomas Schwinge <tschwinge@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 20:27:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEr0J-0002Cx-0F
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 20:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbXG1S1A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 14:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbXG1S1A
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 14:27:00 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:58301 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752413AbXG1S1A (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 14:27:00 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id B2B762CB083
	for <git@vger.kernel.org>; Sat, 28 Jul 2007 20:26:58 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 9FFAF23D342
	for <git@vger.kernel.org>; Sat, 28 Jul 2007 20:26:58 +0200 (CEST)
Received: from server.schwinge.homeip.net (stgt-d9beacf6.pool.mediaWays.net [217.190.172.246])
	(Authenticated sender: tschwinge@arcor.de)
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 5B52B45598
	for <git@vger.kernel.org>; Sat, 28 Jul 2007 20:26:58 +0200 (CEST)
Received: (qmail 25613 invoked from network); 28 Jul 2007 18:26:33 -0000
Received: from leibniz.schwinge.homeip.net (192.168.111.120)
  by server.schwinge.homeip.net with SMTP; 28 Jul 2007 18:26:33 -0000
Received: (nullmailer pid 4310 invoked by uid 500);
	Sat, 28 Jul 2007 18:26:35 -0000
X-Mailer: git-send-email 1.5.3.rc3.26.g6c58-dirty
In-Reply-To: <20070728173948.GD23337@cip.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54048>

Calling access(p, m) with p == NULL is not specified, so don't do that.  On
GNU/Hurd systems doing so will result in a SIGSEGV.

Signed-off-by: Thomas Schwinge <tschwinge@gnu.org>
---
 builtin-add.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 7345479..de5c108 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -60,7 +60,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
 		path = git_path("info/exclude");
 		if (!access(path, R_OK))
 			add_excludes_from_file(dir, path);
-		if (!access(excludes_file, R_OK))
+		if (excludes_file != NULL && !access(excludes_file, R_OK))
 			add_excludes_from_file(dir, excludes_file);
 	}
 
-- 
1.5.3.rc3.26.g6c58-dirty
