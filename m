From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 05/16] daemonize(): set a flag before exiting the main process
Date: Tue, 12 Apr 2016 20:32:58 -0400
Message-ID: <1460507589-25525-6-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:33:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8kW-0002jC-OE
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758923AbcDMAdd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 20:33:33 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35797 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758907AbcDMAd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:27 -0400
Received: by mail-qg0-f45.google.com with SMTP id f105so31004761qge.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nl3fugkTQAnDSHcKP9j4UztqtVTu+w4OYfeOvg4LTaA=;
        b=HIzV51T/qTLhYxHU4Kxi91VJOgxXrMqg/FIznRwTrB4zqxVV77SnGIQ2qFe4KSZItn
         tjrPIWHai9w41uG4JJUkAwHNXWiJxDbgRfxl5GjbJm3FVQLC2wNRR6vMOc/SnzpN5VeO
         m3JospdbYc/aiOLwQljJgrziTbMuZNctFLpt7sBrqjVjodnkK4lMbW0nGMYNKVIDSSYB
         rOcpRH1k9uXulKVWormNeA2klsRjuG40oSChy6QmH7X25vfctpzMlPYB6rmQEqXF3ndp
         YdXT5QGP79PhZLBOTvxyVLrBEKBCxu3M3YENGmUqAlCZi2gfJYe6xcvlW7ivbanfjYuX
         lrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nl3fugkTQAnDSHcKP9j4UztqtVTu+w4OYfeOvg4LTaA=;
        b=QWPo0SGsDPsoxbG9MXWCJbcyw0C/vR1RVM49aGxO2c7iZhC2xBm9hkXVkY4xxlQG0Z
         +O8BkEauZeaSyKrdrpTNhg1O7GkMeW5B9jKWbqdqI/+s1GmqOFKe6hteTftazbnlr2Ex
         lnfK9SCBvYLaynXFP/OALykjg5LnSF/YW1sFNlL9QikvOa7LsmVFq/Ql+5v7/TZfcuLr
         fwaGuw15/1pt5WyrAwimemuIOPuo7mXC/9F0LeabIMHaqXbd63r62tWY+Ed3KApUpl5Y
         i3mZCuQHJuxU1SNQR+vu99tOBGNk9Ij1LaKkaDQyD6zqzrjvA/Er+ZbqjGgMOFFv7QLs
         nbew==
X-Gm-Message-State: AOPr4FW27JH4OAEK7bl7XPoXdjf30KoKDWflck661AjTjep6aQela1HDhLkEzSdCKCggmg==
X-Received: by 10.140.19.147 with SMTP id 19mr7468456qgh.70.1460507606339;
        Tue, 12 Apr 2016 17:33:26 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291340>

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
