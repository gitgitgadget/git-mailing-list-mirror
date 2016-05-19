From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 06/20] daemonize(): set a flag before exiting the main process
Date: Thu, 19 May 2016 17:45:43 -0400
Message-ID: <1463694357-6503-7-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:47:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Vn2-00072K-AW
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbcESVqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 17:46:48 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33759 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbcESVqp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:45 -0400
Received: by mail-qk0-f171.google.com with SMTP id n63so56493745qkf.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWgUhX/x6Lc604mI1EfACARwLR71lPeDNbTsIjhalcI=;
        b=x6pW2RAx3njNR1iXbtiQYmvdPRps0+IAfsj9EwN1q28TOnng7z58kstiN2o5m8TpFP
         Iu/rDy0KbnU8DqVjQYr1JSbSqSkTepUFf/NeTn8bSZmN3dnSps9DJKvETHBkqmtWHd1M
         Lqt1HLegdLBsmZZzbufnn5zwzGEv8k3HiCtR9Nf6kSvyzox4LY4cNJMY3WO20EsIsk7e
         wQOJA5Y8gQoppHJrPdaGPnhY2i6O0T+4t0NimrSWdvD2YcdTujghXkH0Ucu0jXG8v1SF
         r99lIYTpFWmUaO8bn7H3XxkInKhAJh+4Gc8dRkIgcF3wNoWZcIy8HYRylUiQLhgzCBJu
         QLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWgUhX/x6Lc604mI1EfACARwLR71lPeDNbTsIjhalcI=;
        b=Y5E/ZhyhxlMzPoudukm9ef4n11nPSbvZo0U8T7qBNUwo7CuYkPIay5c6L+hcfFMXsr
         kD5iCbBaJqSgx2dWMjEzt5RBCnNyGgwOgtnlfYeTOo1vXP2qJYRs4td4mfdpykja6lrZ
         yeP5i21q7kOvYOOI6OESopuMJt4wfbiTlc9JRuf6iO9VXnlLMuObC3zoPAn9rUYVKBsM
         94C6rdrU5XCo1oAf//DlCFN4dTblCESytYpB+DF5vjkDWmfCo2Yjn+toUIX4bRco1GAQ
         mvFbdHxZJAtjEHPx9lXe6Iufl8rZdEK5+IN4GUkK0O50okoLxlwBFZaa/WGYEmkKvGl5
         XPZQ==
X-Gm-Message-State: AOPr4FWUvUTf9jHIrY7NA83IJDLLxN+4GJ/SS4LsnR4i9SZhJSxy6etodnKqPvi2x80A7A==
X-Received: by 10.55.80.131 with SMTP id e125mr273860qkb.155.1463694404535;
        Thu, 19 May 2016 14:46:44 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295120>

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
