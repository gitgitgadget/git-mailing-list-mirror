From: David Turner <dturner@twopensource.com>
Subject: [PATCH 07/19] daemonize(): set a flag before exiting the main process
Date: Wed,  9 Mar 2016 13:36:10 -0500
Message-ID: <1457548582-28302-8-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiye-0007Hh-Pa
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933852AbcCISgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:36:53 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36089 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933692AbcCISgk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:40 -0500
Received: by mail-qk0-f178.google.com with SMTP id s68so24057106qkh.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W1HneKu4s5+/aY6r3Inbem1fUFBi5NpxE9BYmGFNl78=;
        b=U8jqGwEeD3A22acgxyR+dTsQ70xB/MOmpvUXNwRIjgCqWdkV2oeOG7dQqhmzXhOxzV
         /AaAsYOJnvJJA2ZMpBlknZ+kLSow2ZxACH/q8kbZx+MhFcJ0P4CuLEc+ssWXcql9n2eD
         5N/SVJfG3lrCmyRNLf7/aoAzdI3GAkstg/4vEKgs/38N/+TKXxfgVACOMFajdeJlXqrL
         52SLh077NY1g+nLqDCUR7NbjSeXwtOMs84k6j17WvRUF0U65RWDwnL2rEvOedLCW4xV5
         jDlM9w9E+jNq9m7ru1cgsvyUhu04PMWNbiNjRYom+ZIZVVScL/2+wA4HC2N+eBouyFqX
         98bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1HneKu4s5+/aY6r3Inbem1fUFBi5NpxE9BYmGFNl78=;
        b=CJWDHBD1lx1aHBa4a7EfhphGinBxz2r6Uml2dBHG3dbsg5VBKSjQSrCVaAdBEkiZCV
         YUlX7zjGftNJ2u3LNmOSuaF1q5M1xOYKuout8zH+D9nSoWn8Nw8scsmLHEIJL9M2mH2i
         RdqoHrHm3JIaCmYzGtwrVvHmNz7UJhEaRIEqV3shDfCgQXzBTHcID4cIOE9RrdrJXRTp
         qByM3vQowtqL7GWsBGdd1hz4V2XH8dlnHJ3rrPc8bRiseMptfnOIghNzlzhi4dzYajgC
         /158cdEsebLKHDGv/H1cgt1NZqTi6V7uIttPVNDe47343Jd4zcpI/jHODj/LrygrTJf6
         VcRw==
X-Gm-Message-State: AD7BkJIZHN0A5Rt1orc+6+UPGJ3M1m4igz+fENFyiTgpcB2iYEhSuOL380XSbatkCaCsCw==
X-Received: by 10.55.71.195 with SMTP id u186mr45147385qka.38.1457548599628;
        Wed, 09 Mar 2016 10:36:39 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:38 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288554>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

This allows signal handlers and atexit functions to realize this
situation and not clean up.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
index 1d7e561..cc1f6f5 100644
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
