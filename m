From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 06/19] daemonize(): set a flag before exiting the main process
Date: Thu,  5 May 2016 17:46:58 -0400
Message-ID: <1462484831-13643-7-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:47:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR7m-00082K-By
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931AbcEEVro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 17:47:44 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33509 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757917AbcEEVrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:33 -0400
Received: by mail-qk0-f176.google.com with SMTP id n63so50926225qkf.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWgUhX/x6Lc604mI1EfACARwLR71lPeDNbTsIjhalcI=;
        b=h6fVMZT+xB+Jf0H2xtvitLl7fvhe/Q1j3rbDnCbLF6kF72m9BXUl8lT+gYugWVhwOf
         +MK3Y3x/i+SxeQiVj7QvAzVOb3uolsMHX2XZfjmfaLupLPE+3EhbYqa7DJtUWEUhRXnX
         og9eDLJto734eBthim7mIWsrFF4rs6eIdao/L/poilh8FJ0NfWFrtgZ/A3BXwuDxXbnh
         YTY9sYKkR9Z4ReBZLiivOswFdaFT7CC4SJWiLd9ftMqz2tYwqR/F4zocoZDkr2rEkVG/
         3IaGSkJKvNNePu4HwCXsO4FAqHrCW3AloXccQ0YpJgEeqP94Eg7gQO52OClgQWrnIHji
         tV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWgUhX/x6Lc604mI1EfACARwLR71lPeDNbTsIjhalcI=;
        b=fIZTegi5PCr3jgGA60MT9gU5eoh7saLciG9QYOLO+CFO1MhYnsLh8nBATDX9bz/o/s
         hx64IxyYfU/ITqacYzqPPqnItCZW2wYIQb6NN+tsmcyBFnrXAPGvlay54DPGhUlsmLAU
         k+mqSAq0eoUbTcDaXLV29uquVa+dTbRmz1h0H49OD9tb1kKMT8NeBnW7FtZ79TU/lyTM
         FduEftaG7PaCmzNAB8qbzaQEyNN1DrNAx4qqGMDxinhxnYFR96N0bO4xDdCOdUCvMvZv
         2c2XnTlMvntKtLH9g2b27bHTIhqawCB6kJyJWUaxhwtZucccj6ImDnXmSvjdoxV9SAoL
         YpdQ==
X-Gm-Message-State: AOPr4FVatgtUnkaONPDrGrdA7SPsDBEzt0+AadDop6Tz9s6nZZ4/ZUVdHbQIpFbIlSHpxQ==
X-Received: by 10.55.16.89 with SMTP id a86mr17996066qkh.118.1462484852575;
        Thu, 05 May 2016 14:47:32 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293690>

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
index 6cb0d02..4c1529a 100644
--- a/cache.h
+++ b/cache.h
@@ -539,7 +539,7 @@ extern int set_git_dir_init(const char *git_dir, co=
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
