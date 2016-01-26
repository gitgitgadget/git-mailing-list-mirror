From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/6] worktree: new repo extension to manage worktree behaviors
Date: Tue, 26 Jan 2016 18:44:40 +0700
Message-ID: <1453808685-21235-2-git-send-email-pclouds@gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, max@max630.net,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 12:45:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO23n-0005J6-Sj
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 12:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934241AbcAZLpV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 06:45:21 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34705 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756003AbcAZLpT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 06:45:19 -0500
Received: by mail-pf0-f195.google.com with SMTP id 65so8134203pfd.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=s0ks1KB2eB8P/gEcwVg5wyO3PSBKg0jf4M8piZWC2KU=;
        b=cEKnpM+oyIoSJjZPDGJtQBj8P/mCgsBKexpAADDzrE5Nv3phqEsDPuwdwjROb4HCxI
         O++xK9JMex5l4DkvOpL3BnTZTLojsVO3spjEXicYgxu+BCFvnxmVGFo2FBNznQ1XspzB
         bTss6DeULnzhq3CHEhNavG2PNlWM1eMC+vhJXKS2Jec3jBSg4h56yJEZPA9ocUoZKkNv
         tTSc1s1chi+gOU8m9Rz8vHLr8wGykrh0UWBbAHFcDQtO7TLoUzMECCfIEoYm62UgiZtE
         YR/p47Siy93We0kcUlTewPon50pOK6oqKndjt08VuUvXa9OdM2f7FIlv6f5sBxKdzPRi
         +hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=s0ks1KB2eB8P/gEcwVg5wyO3PSBKg0jf4M8piZWC2KU=;
        b=QTfbsp+jo6nGx8d4ZdlLpgbxzHl5TCi5sHtGUdVxdWbjkNFTt8Oe6m3SUF574edtmT
         WorOgGG9hsQykYj97Ep+HHPAY1HfBfKfkI2Vy2ngaqVGV3WldRLJ+JFO2kNRmkQjyGix
         THWa3Oc2WUbN88zSoh3o+qa4dWYbMpAGAf3By+9pBxPLmIKlWImSQ/ZqLzK1So5F5TnL
         xY7+kbqtEyMWMzZZsm7FFpD9f8XYd2O5JJJI6FAup/8xw0lvflcrckM/aEgBykr8Hw2/
         dshvTCcSBqS7yBlH9SwZDURLC6HYZLeW03nJjS+E2CtGC9pYGuJgB99oZQS+mJq9dnsQ
         lYqw==
X-Gm-Message-State: AG10YOQajpUGLKRcWvW9CwH+k/OoOjQJhXPweLpK8C2sAbGKxCC78u5sQmC3ZTVdaiXb8g==
X-Received: by 10.98.72.135 with SMTP id q7mr32742234pfi.151.1453808718683;
        Tue, 26 Jan 2016 03:45:18 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id 75sm1502133pfj.20.2016.01.26.03.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 03:45:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 26 Jan 2016 18:45:20 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453808685-21235-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284804>

Multiple worktree setup is still evolving and its behavior may be
changed in future. But we do not want to break existing worktree
setups. A new set of extensions, worktree=3DX, is recognized to tell Gi=
t
what multiple worktree "version" is being used so that Git can
behavior accordingly.

This extension has no use yet. The first one will be config split.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt                 | 12 ++++++++++++
 Documentation/technical/repository-version.txt |  6 ++++++
 cache.h                                        |  1 +
 environment.c                                  |  1 +
 setup.c                                        |  3 +++
 5 files changed, 23 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 5b9ad04..048d7d6 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -106,6 +106,18 @@ OPTIONS
 --expire <time>::
 	With `prune`, only expire unused working trees older than <time>.
=20
+WORKTREE VERSIONS AND MIGRATION
+-------------------------------
+Multiple worktree is still an experimental feature and evolving. Every
+time the behavior is changed, the "worktree version" is stepped
+up. Worktree version is stored as a configuration variable
+extensions.worktree.
+
+Version 0
+~~~~~~~~~
+This is the first release. Version 0 is implied if extensions.worktree
+does not exist.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository=
's
diff --git a/Documentation/technical/repository-version.txt b/Documenta=
tion/technical/repository-version.txt
index 00ad379..e4583c5 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -86,3 +86,9 @@ for testing format-1 compatibility.
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
+
+`worktree`
+~~~~~~~~~~
+
+Define behavior in multiple worktree setup. The value specifies the
+version. Default version is zero.
diff --git a/cache.h b/cache.h
index dfc459c..e742c46 100644
--- a/cache.h
+++ b/cache.h
@@ -727,6 +727,7 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_version;
 extern int repository_format_precious_objects;
+extern int repository_format_worktree_version;
 extern int check_repository_format(void);
=20
 #define MTIME_CHANGED	0x0001
diff --git a/environment.c b/environment.c
index 1cc4aab..1bd4a56 100644
--- a/environment.c
+++ b/environment.c
@@ -27,6 +27,7 @@ int warn_on_object_refname_ambiguity =3D 1;
 int ref_paranoia =3D -1;
 int repository_format_version;
 int repository_format_precious_objects;
+int repository_format_worktree_version;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 int shared_repository =3D PERM_UMASK;
diff --git a/setup.c b/setup.c
index d343725..2f41648 100644
--- a/setup.c
+++ b/setup.c
@@ -373,6 +373,9 @@ static int check_repo_format(const char *var, const=
 char *value, void *cb)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			repository_format_precious_objects =3D git_config_bool(var, value);
+		else if (!strcmp(ext, "worktree"))
+			repository_format_worktree_version =3D
+				git_config_ulong(var, value);
 		else
 			string_list_append(&unknown_extensions, ext);
 	}
--=20
2.7.0.288.g1d8ad15
