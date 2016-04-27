From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 06/19] daemonize(): set a flag before exiting the main process
Date: Wed, 27 Apr 2016 16:04:28 -0400
Message-ID: <1461787481-877-7-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:06:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVjN-0003h7-TI
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbcD0UGi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2016 16:06:38 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32913 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbcD0UFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:17 -0400
Received: by mail-qk0-f182.google.com with SMTP id n63so23535856qkf.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nl3fugkTQAnDSHcKP9j4UztqtVTu+w4OYfeOvg4LTaA=;
        b=q/yYy10UOIi/3bPrgvhnt79orrtpNzI+fc8fJEy7xcickm8vIaSzEU7PndghYxgutE
         yDEF7De2o8W6eUTaVpWOCtYMJvtSUk1UbruKxoxCofZ0QI2Cycg7gA9Pt4DZTOgBI5kJ
         sULWgJDJn4fgpJ5Ykpr/W0/HAytSIusMWL4rpeIsv3ct8XkXyIQKU72pSFELOifOtDgh
         ga5wGurwjZqGVr+NWM+vERRqCz2APYuVc1WUm+4hUB7pCqoiSuA7v6arzCHO7AfvkImi
         5d1YiM4uTQxIIh6E41FfidH4D4vPjmAKHbee0LYc8NCIIH7sl8yKZqLdWhIHvs4TOYcD
         EfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nl3fugkTQAnDSHcKP9j4UztqtVTu+w4OYfeOvg4LTaA=;
        b=VJXfSQF1KU8rXZ5XLDFUOpDeE8/y5a+olDfsQTvPP94yRU786du9uh3vnFaQMbM0DD
         1MFXf1TKzZloD/bxNcESn/vgfUfykunU1eny26Pu1EjzQUtZ3IEaTCKon0rVt5ZZzO4l
         7GlsE9qYkRH4XEjUul5UfNVcw2TPoEHtst8qCp8/hpJCIx9CehrWUNuUiTng0MxasLZ2
         fzxUNSjVOcrFI6Iw5yHt87hwU4O5hvsvYwxo29rq6uVt65jEp773URz93YUBlp9Z6IdO
         B0vewn0QVmJmRGGRMTyNhJEqmgKkDgt2h3EOEmRWxO9zeKl0aXyteDW1lnC4ZSCh62ie
         dLqw==
X-Gm-Message-State: AOPr4FUZ6k9MEYcEvNFwA5yNy5xnMxl/0fFcsPBzWd7997po0o3CeMtpSaYekg8QWVaIww==
X-Received: by 10.55.33.92 with SMTP id h89mr11162848qkh.143.1461787516105;
        Wed, 27 Apr 2016 13:05:16 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:15 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292804>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

This allows signal handlers and atexit functions to realize this
situation and not clean up.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/gc.c | 2 +-
 cache.h      | 2 +-
 daemon.c     | 2 +-
 setup.c      | 4 +++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c583aad..37180de 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -385,7 +385,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
 			 */
-			daemonized =3D !daemonize();
+			daemonized =3D !daemonize(NULL);
 		}
 	} else
 		add_repack_all_option();
diff --git a/cache.h b/cache.h
index 4b678e9..0aeb994 100644
--- a/cache.h
+++ b/cache.h
@@ -530,7 +530,7 @@ extern int set_git_dir_init(const char *git_dir, co=
nst char *real_git_dir, int);
 extern int init_db(const char *template_dir, unsigned int flags);
=20
 extern void sanitize_stdfds(void);
-extern int daemonize(void);
+extern int daemonize(int *);
=20
 #define alloc_nr(x) (((x)+16)*3/2)
=20
diff --git a/daemon.c b/daemon.c
index 8d45c33..a5cf954 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1365,7 +1365,7 @@ int main(int argc, char **argv)
 		return execute();
=20
 	if (detach) {
-		if (daemonize())
+		if (daemonize(NULL))
 			die("--detach not supported on this platform");
 	} else
 		sanitize_stdfds();
diff --git a/setup.c b/setup.c
index de1a2a7..9adf13f 100644
--- a/setup.c
+++ b/setup.c
@@ -1017,7 +1017,7 @@ void sanitize_stdfds(void)
 		close(fd);
 }
=20
-int daemonize(void)
+int daemonize(int *daemonized)
 {
 #ifdef NO_POSIX_GOODIES
 	errno =3D ENOSYS;
@@ -1029,6 +1029,8 @@ int daemonize(void)
 		case -1:
 			die_errno("fork failed");
 		default:
+			if (daemonized)
+				*daemonized =3D 1;
 			exit(0);
 	}
 	if (setsid() =3D=3D -1)
--=20
2.4.2.767.g62658d5-twtrsrc
