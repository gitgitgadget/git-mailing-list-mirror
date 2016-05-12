From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 06/20] daemonize(): set a flag before exiting the main process
Date: Thu, 12 May 2016 16:20:01 -0400
Message-ID: <1463084415-19826-7-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:21:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6s-0005ZL-Af
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbcELUVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 16:21:22 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35855 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbcELUUc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:32 -0400
Received: by mail-ig0-f177.google.com with SMTP id lr7so62827108igb.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWgUhX/x6Lc604mI1EfACARwLR71lPeDNbTsIjhalcI=;
        b=geNBuF2bZb3U1rIH9Oa9gc4mLcov+SSk+0uCmMiYe7xctyY3PO2cSstp5gHvWwVngw
         VPFqx/Bn1D+Ny/isQqDtGOO104p/PNqJzJzRp3BCWHa/Nk1I/V57e92yc7ZHiOpUpzKo
         o3QcQbK/z8sPT+jeQkTJyvbvR54DJqSXHQSRrA5TxhRaDfFQq8+Kx8vCkgadXZYqGNAC
         TJPP7ZPbNWb3Vg9RVtRuCOm/L7XvhzfP0VaoWVIdzUWekI06FjZwM5zI6BinrNKVUeQt
         mpEUxDN8/dzRpnLNdMxSBd6bC0fElJ43uzXhw7y9EIl/L/PwdWDFep2AFyUbckRi/Yny
         1wWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWgUhX/x6Lc604mI1EfACARwLR71lPeDNbTsIjhalcI=;
        b=ixzX/cJn2TNfwRAvuZVwJhMwv+1xrLWGtko6h0jKjpzeWjR8AB8JFtq0qIQAq7YWGJ
         6ojaCyZg+jS97xdhDUOCClkZackHJsNSr+tZZxMpiLlPfSu+oY7Qcr+9+4B9ASc6Vv4F
         4y6GfDLwmvZgvWMF6NK8T+P65xqiaZBYy1tQuerCSQqqxR1q2pOJ6hFtfGBRyYUabKr2
         GB0OcWfmu2PdGnCTlYFR0LUSekjQ2kNOxQuBiHW5ATEDMfAqwaoTLqYgCW8HIbd2S/hL
         rDTXjz/r+XUZGWdL4d3tlFtiEuVpMjhkzHBXIf3MUjVSJgTaAhlx/i3WyyxyzOw/C4cS
         CetQ==
X-Gm-Message-State: AOPr4FUmLPXiNkjgTYUkNtz4nSUst/7uK8U7KDYqouwMi73rHcE/64MF5AaiPqpQpO9n5g==
X-Received: by 10.50.147.7 with SMTP id tg7mr27034964igb.63.1463084431878;
        Thu, 12 May 2016 13:20:31 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294468>

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
