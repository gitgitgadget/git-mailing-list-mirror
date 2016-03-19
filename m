From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 05/17] daemonize(): set a flag before exiting the main process
Date: Fri, 18 Mar 2016 21:04:38 -0400
Message-ID: <1458349490-1704-6-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:06:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5La-0008Mm-AU
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbcCSBGY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 21:06:24 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34324 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbcCSBGM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:06:12 -0400
Received: by mail-qg0-f47.google.com with SMTP id w104so114644146qge.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=coUMEgRhDercBQoWFx2dIr8djc731dr4aGjkmIKoCcA=;
        b=jQrRULtGvX58uHUQZQVdcf/2n8nu/NqCOdP5ZH9VpWe5b2L8bAF7Trf/oUTX9vR5BT
         Cow1Wg98wgY13noUOoliWiH/x1pOR2clogvMwtwFD78Bvjb2iB30RmxkSA8dUOqXBIdf
         gME1L40wn27uQyGaY5m1fnaelq5nxJiE6sAc/j/zZaRdvXckVfrabKabG4GyDRB8M0jW
         ynd6NyUa3yMOFKYoqSHaiJy5j7yLN26/9sF1sqQ7CQB73MbvmryXE+9P4v8RVoc8AoYq
         8s2NoSZOGZjFmwGVQ3fj6M/56tKogShrl7ija+soU7U/ZyyvaBVOGaSUByGucNDQhEsK
         AI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=coUMEgRhDercBQoWFx2dIr8djc731dr4aGjkmIKoCcA=;
        b=VOt7L5gHBGCR94F4T1NVEVqtlLaN4gQNk+cxshZFg8gqe85qp5rNKAfFKtFLetZipf
         G6RzjX7MHnjhBI7V5iQHp2ZClRsb9/CeA0x+PBt+62JvqijIynLH36uwGB2rar9ldl0l
         mBL/bFYN1Vnz7iys7rozAPxGx/Z26F+a6T3nSY+mJ59fQFp3PUYL2AEXeACXN5X1CANn
         HVcYFRzV061pgk3q/i7I76Mc6lE3D2VlxbBe3YLQ0XdmRpNYKh22IgS7VmlDuq78igN7
         4/xq7mjHH0DgHs0xu76PGel+7ZrO4HFXKFWch6royt5d75y/t6oc0TvLfyI569S/ogTa
         h67A==
X-Gm-Message-State: AD7BkJKeb3C4kuDKSmp2iPR088BdIkMlgmKKyLX3KRgJMiw2a0/PmzcWhtamqXb7UwaZcg==
X-Received: by 10.140.104.19 with SMTP id z19mr26153533qge.68.1458349571261;
        Fri, 18 Mar 2016 18:06:11 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.06.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:06:10 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289273>

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
index 5805962..d386722 100644
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
