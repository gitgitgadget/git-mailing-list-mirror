From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 05/16] daemonize(): set a flag before exiting the main process
Date: Wed,  6 Apr 2016 18:11:51 -0400
Message-ID: <1459980722-4836-6-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:13:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvhY-000541-CY
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbcDFWMn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 18:12:43 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33483 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbcDFWMm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:42 -0400
Received: by mail-qg0-f54.google.com with SMTP id j35so48393188qge.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nanZVkoNXGPzsuejIIyWOvWmREk7ZHUuqZoktuBs8Kc=;
        b=hZq1WKwTtjWGmSwkNRD082bigi3QknBBM+y7Yg5ZJG3sJojjjI4B6i8NKOmlffEt8W
         pmZ8AYmnYne6MmFRt7hSsZ3lt6Q8VOow+zOCemmwdRe2tQRaNifhm4aTWuw/ht4hiHCR
         ZGziJkuypL+vTp2Fu13V4yRbpVlsSsbV1wyLId6NRxZrlbzXOozKNHawusfONWR0MZYx
         lPQIn1BTQPki44U3zPSxnC8sVpVgoIISo+YvjPpFyuF5J4uqJzf2bLdvNYH8Ubijz8NH
         L4yFqWV3vtW4WAK7BFHkElI0YI0CrrWkduDgtPChQIZlQVepCUyurSiOlUZVYrUkF8gz
         QZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nanZVkoNXGPzsuejIIyWOvWmREk7ZHUuqZoktuBs8Kc=;
        b=SESRaUT71ek4VMrMsSV6zwBkzxngRZRSC821m2bXAvAjALG/8g6fT1/uyYnRhsb3KX
         8K9wB6U+IQIvCQed6NmSWGDH0vbqNHZdK2DtldNMX18TRV9qyhQw0aX6niNpaA0hKVCs
         2iJZmcdMkpPKIaYGbF3Km1fe6pPmwzp2GEvqgawcUKogxhDTizKp0n/q3KF000+BfWFW
         8gMa/9eejrJqZksFPTZ+q7UbbumX1jKsM8ykr1btAO5MRo3fWQXzTB7Ch9ca+S8tBbjt
         fAV38IaJiKLciAsA173GVAfcHM52Grf4EgMVnuNK7FGnr4FoOZdbDCIAjmhtNtzIUN8+
         iTtA==
X-Gm-Message-State: AD7BkJLNa1Rx4B02desBuOd7YY7g1ofk9l53cNQEGPEnC6O20nTggLWCmsBzM1MsNRZmdg==
X-Received: by 10.140.228.68 with SMTP id y65mr40836911qhb.78.1459980761029;
        Wed, 06 Apr 2016 15:12:41 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290887>

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
