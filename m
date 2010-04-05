From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/43] init/clone: turn on startup->have_repository properly
Date: Mon,  5 Apr 2010 20:41:14 +0200
Message-ID: <1270492888-26589-30-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH9-0000ps-5h
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab0DESnX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:23 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab0DESnS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:43:18 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=F9xvRLOZJDc3+B/ZEGC+tYD5fME5W8C2hCYa8H7KPgU=;
        b=sz/Wix2a3/8KHGPILWehRKEk7yAP+ZMOgG2T+9Ahs0qX9BDAI8FdnYCx7CVgPOYdet
         WE23LvWaZmfic7KkUjwrC0md91gZJLwJzhqllGObRCs/jpJdS5lFhBlrBsXsogtMXKnU
         TF/BTHe+TEa1C/Lpyz6wZblMndB3YkEHw6Hms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KfaDHyQ+IlBnDBH7c98sGgrYTQ49VzFnRsZGhtkNgS3BVOCRHX2HwXRHCpvWpOuQKA
         aWfYWJk4VY6WO195CnhHzPgjtp9cgN8ALGrLvpYqjSviShp3lsnTiU9vAt+EHijuXJkv
         gdwC3b60AGAITrenud7QVYqdeIXEGnLdydgP0=
Received: by 10.223.22.74 with SMTP id m10mr2591838fab.93.1270492997833;
        Mon, 05 Apr 2010 11:43:17 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 22sm352306fkr.59.2010.04.05.11.43.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:17 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:14 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144022>

With startup_info !=3D NULL, many code path may be disabled, depending
on repo setup. Also move set_git_dir() closer to have_repository
assignment to make it clear about repo setup.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c   |    3 +--
 builtin/init-db.c |    9 +++++----
 cache.h           |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 05f8fb4..3badb44 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -459,9 +459,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die("could not create leading directories of '%s'", git_dir);
-	set_git_dir(make_absolute_path(git_dir));
=20
-	init_db(option_template, (option_verbosity < 0) ? INIT_DB_QUIET : 0);
+	init_db(git_dir, option_template, (option_verbosity < 0) ? INIT_DB_QU=
IET : 0);
=20
 	/*
 	 * At this point, the config exists, so we do not need the
diff --git a/builtin/init-db.c b/builtin/init-db.c
index edc40ff..064b919 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -294,12 +294,15 @@ static int create_default_files(const char *templ=
ate_path)
 	return reinit;
 }
=20
-int init_db(const char *template_dir, unsigned int flags)
+int init_db(const char *git_dir, const char *template_dir, unsigned in=
t flags)
 {
 	const char *sha1_dir;
 	char *path;
 	int len, reinit;
=20
+	set_git_dir(make_absolute_path(git_dir));
+	startup_info->have_repository =3D 1;
+
 	safe_create_dir(get_git_dir(), 0);
=20
 	init_is_bare_repository =3D is_bare_repository();
@@ -509,7 +512,5 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 				   get_git_work_tree());
 	}
=20
-	set_git_dir(make_absolute_path(git_dir));
-
-	return init_db(template_dir, flags);
+	return init_db(git_dir, template_dir, flags);
 }
diff --git a/cache.h b/cache.h
index f53fb32..2980741 100644
--- a/cache.h
+++ b/cache.h
@@ -430,7 +430,7 @@ extern void verify_non_filename(const char *prefix,=
 const char *name);
=20
 #define INIT_DB_QUIET 0x0001
=20
-extern int init_db(const char *template_dir, unsigned int flags);
+extern int init_db(const char *git_dir, const char *template_dir, unsi=
gned int flags);
=20
 #define alloc_nr(x) (((x)+16)*3/2)
=20
--=20
1.7.0.rc1.541.g2da82.dirty
