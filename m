From: Thomas Schwinge <tschwinge@gnu.org>
Subject: [PATCH] Don't rely on unspecified behavior
Date: Sat, 28 Jul 2007 18:39:39 +0200
Message-ID: <11856407791617-git-send-email-tschwinge@gnu.org>
References: <11856407793933-git-send-email-tschwinge@gnu.org>
Cc: Thomas Schwinge <tschwinge@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 18:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEpKY-0000AV-Ti
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 18:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbXG1Qjq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 12:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbXG1Qjq
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 12:39:46 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:48127 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753113AbXG1Qjo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 12:39:44 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id C073727B730
	for <git@vger.kernel.org>; Sat, 28 Jul 2007 18:39:43 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id B14E6212FA9
	for <git@vger.kernel.org>; Sat, 28 Jul 2007 18:39:43 +0200 (CEST)
Received: from server.schwinge.homeip.net (stgt-d9beacf6.pool.mediaWays.net [217.190.172.246])
	(Authenticated sender: tschwinge@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 836A8212F68
	for <git@vger.kernel.org>; Sat, 28 Jul 2007 18:39:43 +0200 (CEST)
Received: (qmail 23771 invoked from network); 28 Jul 2007 16:39:38 -0000
Received: from leibniz.schwinge.homeip.net (192.168.111.120)
  by server.schwinge.homeip.net with SMTP; 28 Jul 2007 16:39:38 -0000
Received: (nullmailer pid 2044 invoked by uid 500);
	Sat, 28 Jul 2007 16:39:40 -0000
X-Mailer: git-send-email 1.5.3.rc3.26.g6c58-dirty
In-Reply-To: <11856407793933-git-send-email-tschwinge@gnu.org>
X-Virus-Scanned: ClamAV 0.91.1/3795/Sat Jul 28 04:08:57 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54040>

Calling access(p, m) with p == NULL is not specified, so don't do that.  On
GNU/Hurd systems doing so will result in an SIGSEGV.

Signed-off-by: Thomas Schwinge <tschwinge@gnu.org>
---
 builtin-add.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 5e6748f..c13c738 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -74,7 +74,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec)
 	path = git_path("info/exclude");
 	if (!access(path, R_OK))
 		add_excludes_from_file(dir, path);
-	if (!access(excludes_file, R_OK))
+	if (excludes_file != NULL && !access(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
 
 	/*
-- 
1.5.3.rc3.26.g6c58-dirty
