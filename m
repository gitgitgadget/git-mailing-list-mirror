From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 1/6] environment: static list of repo-local env vars
Date: Wed, 24 Feb 2010 08:23:11 +0100
Message-ID: <1266996196-25978-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:23:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkBb5-0003WY-Qh
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 08:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811Ab0BXHXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 02:23:36 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:43618 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab0BXHXf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 02:23:35 -0500
Received: by mail-ww0-f46.google.com with SMTP id 26so1156644wwf.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 23:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=A2dzpieedutwdpPI1kU6gr1JnnkRPrX5yMsnyPLH3D0=;
        b=JbVN8fNuQgyi7FqMlp914m259OeE6bE6iCo5oaZ3RG+lqnwX28UT+6i3gqXCeLVof4
         rTrftyX872C5PDxTGkXn/VQZwGJdARidP/osZFtiyDhrlMxpqA1l1Mu9tJ0WT9UEfRB2
         WzIJllv0g5w3QGyOsKU+rmKeqRa4bKqgF03PU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Axb0zE8OqnlxLlDZRVzwszkVR3EhCRyErG2bu8BougQvDGJyEijI8uiSSPYfIw2HSv
         Cq+Yv1jqfnAec+HP3PJvSgU0HbyDtBsR0z2L2qaRFJBnOlhYa+vZZ+FDhU8s7+O9E2M3
         M2KoYtDObeDP32PigoAuRFMZjwuG2gYJBmuMc=
Received: by 10.216.88.71 with SMTP id z49mr1303757wee.90.1266996214560;
        Tue, 23 Feb 2010 23:23:34 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id m5sm21357834gve.12.2010.02.23.23.23.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 23:23:33 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g4e217.dirty
In-Reply-To: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140908>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 cache.h       |    3 +++
 environment.c |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index d454b7e..3b44fe2 100644
--- a/cache.h
+++ b/cache.h
@@ -388,6 +388,9 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 
+extern const char *const local_repo_env[];
+extern const unsigned int local_repo_env_size;
+
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
diff --git a/environment.c b/environment.c
index 739ec27..b15352d 100644
--- a/environment.c
+++ b/environment.c
@@ -63,6 +63,21 @@ static char *work_tree;
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
 
+/* Repository-local GIT_* environment variables */
+const char *const local_repo_env[] = {
+	ALTERNATE_DB_ENVIRONMENT,
+	CONFIG_ENVIRONMENT,
+	DB_ENVIRONMENT,
+	GIT_DIR_ENVIRONMENT,
+	GIT_WORK_TREE_ENVIRONMENT,
+	GRAFT_ENVIRONMENT,
+	INDEX_ENVIRONMENT,
+	NO_REPLACE_OBJECTS_ENVIRONMENT,
+	NULL
+};
+
+const unsigned int local_repo_env_size = ARRAY_SIZE(local_repo_env);
+
 static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-- 
1.7.0.212.g4e217.dirty
