From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/6] Define new repo extension to manage multiple worktree behaviors
Date: Sun, 27 Dec 2015 10:14:34 +0700
Message-ID: <1451186079-6119-2-git-send-email-pclouds@gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
 <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, max@max630.net, Jens.Lehmann@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 04:15:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD1nS-0002yn-Rd
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 04:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbbL0DO7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 22:14:59 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36489 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbbL0DO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 22:14:58 -0500
Received: by mail-pa0-f52.google.com with SMTP id yy13so1450223pab.3
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 19:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=s6cY9KSXd6i3LsylATfvjOcBYKkOIwdc4GmBCNs10BE=;
        b=KFcY2qGG5193OTNKk/JvLOjjRqBDxyPOEaDQet/m1o61Xegt7Ioa4DS/hdU5pX3cEu
         7TYUWnz+s6lUO8d5zkg1dPnGN9h2Cn8juYtJXKd3QPpyYpkpNAFQcrp8XubyfFBA7co6
         zp9cyO23Wv1yFmZyZCo6vPUEszSSEDQ1SBXD6tHJjl9hGz4xBnNe5xQw+FQoOMnc8o8R
         kDYcaoGzsfz8L0dL9OrGOie3Z2MKgT2h0o1d4jglByBE8zzPAzympRtIVj45uNTYmRa5
         o676DKLkncbNiUsMzb5WkOavZdk5e4+mtujvHAmUXT5iGhKhEEYmmr+0bd0XJebvfWVD
         alWQ==
X-Received: by 10.66.253.97 with SMTP id zz1mr26635495pac.106.1451186097549;
        Sat, 26 Dec 2015 19:14:57 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id u26sm17191622pfa.86.2015.12.26.19.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 19:14:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 10:15:03 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 Documentation/technical/repository-version.txt | 6 ++++++
 cache.h                                        | 1 +
 environment.c                                  | 1 +
 setup.c                                        | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/Documentation/technical/repository-version.txt b/Documenta=
tion/technical/repository-version.txt
index 00ad379..c680528 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -86,3 +86,9 @@ for testing format-1 compatibility.
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
+
+`worktree`
+~~~~~~~~~~~~~~
+
+Define behavior in multiple worktree setup. The value specifies the
+version. Default version is zero.
diff --git a/cache.h b/cache.h
index c63fcc1..fa0a64b 100644
--- a/cache.h
+++ b/cache.h
@@ -725,6 +725,7 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_version;
 extern int repository_format_precious_objects;
+extern int repository_format_worktree_version;
 extern int check_repository_format(void);
=20
 #define MTIME_CHANGED	0x0001
diff --git a/environment.c b/environment.c
index 2da7fe2..a3f17ed 100644
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
2.3.0.rc1.137.g477eb31
