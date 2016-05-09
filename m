From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 06/19] daemonize(): set a flag before exiting the main process
Date: Mon,  9 May 2016 16:48:36 -0400
Message-ID: <1462826929-7567-7-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:50:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7M-0003yU-3z
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbcEIUtO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 16:49:14 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34981 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbcEIUtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:12 -0400
Received: by mail-qk0-f181.google.com with SMTP id n62so27771251qkc.2
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWgUhX/x6Lc604mI1EfACARwLR71lPeDNbTsIjhalcI=;
        b=npdb7/FsIy+X9Lty1j+FL5OiSqf78a3C3ltzERv2GLffZ3O+fvZcwz8bF/N3XXT6gY
         fUSSPFsX8prov6YYKRaTlr1OZFEfNqN9hVf8oGtjjh0iuOFegVuuONYsG8F1bU4Eco2G
         DCNBlDjM5+aLH6gqX2+vuhCt4n9sCMtBhubkdqRnd1Wb/YRBTV/JJrXofZZPJzM9R4lZ
         FO3gbnsI4zg9PPMyDm25jvp/eRF8TAwol3yKY7BQKHmHJ0BrENMEgd9RFAElYvzb7KJj
         tbpgq6dXj9bl0lFzS0y8LmutjS4xPD9L98IAiFDiYengMYcZHiD1z21LojXxkw2Ak7kP
         QZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWgUhX/x6Lc604mI1EfACARwLR71lPeDNbTsIjhalcI=;
        b=MEhJJFIMK+aOYz0TBTysGjSlQns/4gJXcUiIKOit7FHc7s6BkiNBlpU0fXjZNOCPyC
         T2l/g1Mpw6nZMZR8FWkODm5+7KTuMFKX6/0edj/9qXjFcDyd2UTckFXsVzueIh2iWZCK
         SIrk3pvv7P+xukEXu86eSHQXP8GBXYrMJm2F1MGKsVa3Pcc/fCWP6y1KCZRLZ8VRambT
         tgWmfwgo5wDAHByQgwtJrc/lWHdQaagRhMN7c8KsIah5N8xDmJw9qwZGnwxZ7bbb2cce
         r0lr/+Jzlod965F5ZQk60+xzyqrN+ibgsOWiCwoSZmbmy13CRrbezNyUsKdGIY6bXi5+
         BCXA==
X-Gm-Message-State: AOPr4FWn244WT1Ofe31jICd0va+endCJHl7DQfVpCUGV96Q17O/EjOZirZTjcfXfB40NBA==
X-Received: by 10.55.77.216 with SMTP id a207mr39908834qkb.80.1462826951448;
        Mon, 09 May 2016 13:49:11 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:10 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294054>

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
