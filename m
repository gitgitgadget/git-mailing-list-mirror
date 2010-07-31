From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/16] Add core.subtree
Date: Sat, 31 Jul 2010 23:18:10 +0700
Message-ID: <1280593105-22015-2-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:37:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOR2-0002kR-RQ
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452Ab0HAChr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:37:47 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63694 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab0HAChq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:37:46 -0400
Received: by pxi14 with SMTP id 14so977542pxi.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MrE9fJKc1mtnRFFYR3HGKMly+JhAMBXHacCtiv166fg=;
        b=gpuZkF7c+X4mMSyQ1nzdUM46uc/3B9T6NwfmoAS4ObKtsM99Fku2ENulP0iiVVRBje
         iwXfWH6N8/a4EW3dReCnZOEhYIcU6ilCCNKtHgpF8cunkUw62zj2FJSPnlGgvDqnYUCm
         ji3GYnYpBJv0iKRmatxlL5Hc2dYso+zmID7e4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=G5Y6q5qjtqjVUGizKvGGVktbJYKOZwmMUYdGucC2gnZ8vJyvL9Uv9OQimS3kOAGnMI
         ujsRGEK4z9M99SAz2IHJbkrWBkxSmynVW+Job0HRJXUJOLC4nrHE1cdtSV2b98nxNsgM
         2llg7iYPWFq1r0hwbAV1g3GiH33wQekYWTSbA=
Received: by 10.142.223.14 with SMTP id v14mr3602789wfg.238.1280630265792;
        Sat, 31 Jul 2010 19:37:45 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id w27sm5242429wfd.17.2010.07.31.19.37.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:37:44 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:18:39 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152348>

This variable contains the subtree. With core_subtree being non-empty
behavior of git may be totally different.

Perhaps this should not stay in .git/config, rather .git/subtree

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       |    1 +
 config.c      |    3 +++
 environment.c |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index c9fa3df..04ebe6e 100644
--- a/cache.h
+++ b/cache.h
@@ -551,6 +551,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern const char *core_subtree;
=20
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
diff --git a/config.c b/config.c
index cdcf583..86ded29 100644
--- a/config.c
+++ b/config.c
@@ -595,6 +595,9 @@ static int git_default_core_config(const char *var,=
 const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.subtree"))
+		return git_config_string(&core_subtree, var, value);
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 83d38d3..1365dd0 100644
--- a/environment.c
+++ b/environment.c
@@ -57,6 +57,8 @@ int core_apply_sparse_checkout;
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
=20
+const char *core_subtree;
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() *=
/
 char *git_work_tree_cfg;
 static char *work_tree;
--=20
1.7.1.rc1.69.g24c2f7
