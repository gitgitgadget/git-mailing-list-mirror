From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 05/15] daemonize(): set a flag before exiting the main process
Date: Tue, 19 Apr 2016 19:27:59 -0400
Message-ID: <1461108489-29376-6-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4X-0008N0-JH
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbcDSX2h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 19:28:37 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35639 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbcDSX2V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:21 -0400
Received: by mail-qk0-f174.google.com with SMTP id q76so701527qke.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nl3fugkTQAnDSHcKP9j4UztqtVTu+w4OYfeOvg4LTaA=;
        b=nsHZ29BGyYvFEyUKfYpKoSF3+AX0TdI1DRf3Cmwjsm11ueXYi7Q0ecBivQOFN/J8tV
         lhQRZ9dmPsBIzzSgJfSz1IlvgWOWv2CWWT5KXWXnDq1XuIn/FFphTq4Y03OSLAIWvv/z
         yaJx7xbPNfUdnJUwuxE7Ak0a8jAmPPnYAMh5dQ0/QqHyQYwD+A/4nnJNEUeMV0mAbeBp
         82JrRuY6+/Wd2acTSu5l02j5QGHQ5bsEY33t+wfT2RU2COkwkIRMp/9DOgXSaUATjliK
         95hyTfuZMqbzEIhK2EHvPMSH+oLusa9ZHf69zh1yyPsw0PYMtUXEL2IZLJ7bXygphD0M
         COkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nl3fugkTQAnDSHcKP9j4UztqtVTu+w4OYfeOvg4LTaA=;
        b=SrRpdYkmGO1YEGzqmZtNm8/K6mboVgIiXeReHNU+iVW51GFPNSt/2jeVaJ2AnjCecd
         hhfgLFcpSKwb8sysOLOZzsv6rPIIl+TUCOX6Z7JMFNzYmtLz8qrrgeFoWuukcAbXGaM/
         fTgUgSW0Q9KSl4ti8NqcaY8MwL9IhbjbE3I5MjREw//+ZLJbhIfcaFsio3yp8z53tfUu
         6DlxlvZOJDTlDQB7hSyixHQMeLAA9B5EoUSNvnqf9Kb7jDwzUk2hpOQAtZkyJAbp9sZQ
         oePtWRvc9IMY+Wm9BeCtrPWj3sPuWdflMuOwxuBya0ya36/Zvbi4MkbQK2wW3YRwDAZJ
         XANQ==
X-Gm-Message-State: AOPr4FViMmQkM4GW6cDHBg8J2tZdnZDf8NhGw2h7YflSSzmqMzCQQac1XNToloGqXFH0Zg==
X-Received: by 10.55.77.202 with SMTP id a193mr7377538qkb.48.1461108500643;
        Tue, 19 Apr 2016 16:28:20 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291961>

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
