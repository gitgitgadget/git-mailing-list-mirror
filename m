From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 4/4 (was 3/3, still WIP)] t/lib-git-svn: adjust config to apache 2.4 WIP
Date: Mon, 11 May 2015 13:54:20 +0200
Message-ID: <5973b74b00301c25ca956764981ec032a863ca07.1431344881.git.git@drmicha.warpmail.net>
References: <0727016B-E495-4577-A174-E0EA85910BD3@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 13:54:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrmIC-0004D7-4F
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 13:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbbEKLyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 07:54:33 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42599 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753462AbbEKLy1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 07:54:27 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 6FEB220A4A
	for <git@vger.kernel.org>; Mon, 11 May 2015 07:54:27 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 11 May 2015 07:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:in-reply-to:message-id:references
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=yhtLg
	qJF3jJlIzOiSw/5b+Uq3pY=; b=WyrhNe81EbKrYO9d1JFfWSf5mmLo25HsnWfdl
	kH68WxG0RYdsZTBEjRJlgFxNNiyDwRMhRmIZBOUtoOl+RlcTYAotOXv/+CEIVAkt
	9u6XZCB3uzUbF5ej9TZbKbEPcQE4bhu6NTKREKNp8nnfnoZYBfWgCydgp7z2j71u
	VEsrXw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:in-reply-to
	:message-id:references:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=yhtLgqJF3jJlIzOiSw/5b+Uq3pY=; b=pP/p9
	AshPNvyzEfnEuN1XrL9RTODGlq8ImSBPYD2Vd9jhr7Ry3XU0FCsMeROUyDi+nB7F
	fALGFYAK4kuUYvrnDZtF+W2mXWawqlW96uvUx/i/gRPLLdRnQOx9yLP/PrflBDYj
	4fV4zFu5xVl0YuSOw/xGGaPk0/KVvRaSIKWLkM=
X-Sasl-enc: 5JDIkCUotPwXSu59bEbXFwRROQ1wNwOMj5Ry/rjnr4fq 1431345267
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0A320C00018;
	Mon, 11 May 2015 07:54:26 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc3.332.g886447c
In-Reply-To: <0727016B-E495-4577-A174-E0EA85910BD3@gmail.com>
In-Reply-To: <cover.1431344881.git.git@drmicha.warpmail.net>
References: <cover.1431344881.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268773>

The current config is tailored to apache 2.2. Apache 2.4 fails to start
with it.

Adjust the config to apache 2.4. [still incomplete]

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    This is WIP and RFH. Apache does not start without mpm, and the lock
    mechanism has changed. It will run with these changes, but svn fails to
    connect.
    
    Again, I'm wondering who is running these tests at all, but also:
    Why do we leverage lib-httpd so little from lib-git-svn?

 t/lib-git-svn.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 2a0ef07..24ad8b4 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -117,10 +117,21 @@ ServerName "git svn test"
 ServerRoot "$GIT_DIR"
 DocumentRoot "$GIT_DIR"
 PidFile "$GIT_DIR/httpd.pid"
-LockFile logs/accept.lock
 Listen 127.0.0.1:$SVN_HTTPD_PORT
 LoadModule dav_module $SVN_HTTPD_MODULE_PATH/mod_dav.so
 LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
+<IfModule !mod_version.c>
+        LoadModule version_module $SVN_HTTPD_MODULE_PATH/mod_version.so
+</IfModule>
+<IfVersion < 2.4>
+LockFile logs/accept.lock
+</IfVersion>
+<IfVersion >= 2.4>
+Mutex default
+<IfModule !mod_prefork_module.c>
+	LoadModule mpm_prefork_module $SVN_HTTPD_MODULE_PATH/mod_mpm_prefork.so
+</IfModule>
+</IfVersion>
 <Location /$repo_base_path>
 	DAV svn
 	SVNPath "$rawsvnrepo"
-- 
2.4.0.rc3.332.g886447c
