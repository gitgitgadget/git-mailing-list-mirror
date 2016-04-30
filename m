From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 07/19] index-helper: add --detach
Date: Fri, 29 Apr 2016 21:02:01 -0400
Message-ID: <1461978133-13966-8-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:03:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJJD-00082g-IS
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbcD3BCm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 21:02:42 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34561 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbcD3BCh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:37 -0400
Received: by mail-qk0-f169.google.com with SMTP id r184so53109716qkc.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0Xdj5qAuhbyhOmEyv1bDr4WwBuQ7g7S55fbd+in02s=;
        b=K1tEkkazXP+t8eY3/or3ictSgYEWbEIbElL7JPQ9Cx+9esYbrQR207YqilB60cV/gB
         WfUnXdsZ4K7SI934s5BRCwHzREpnK+2HixEdmZql4nV1qmy1eSLYyVzruhDRQ/pajwD9
         AZWOxlDH4h9ZJQ9N0+Ra5zI2mDXkgMkfbT+9sC9NhIgTBucMtalAQt/JzcXSYpZqtLCM
         MbRzjAJW42I6YAAyHx4qVM6lbvAS5R5dpohpML3GZjBlD9d0blaZ8FicuLe9HkiPLaRJ
         pkSu3Uff664ghCLGzVzyOsykt7TwJA3x/TUXSg3CnLaPMtbXF3Poa5Hl4oetNCgRbTfC
         yoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0Xdj5qAuhbyhOmEyv1bDr4WwBuQ7g7S55fbd+in02s=;
        b=d1UoFOXuD797LjEv48g1Ps6dwjzBsQaoifYVjBf9X8wMSpbqST0dUGyaV3mOwDTn8x
         0/b2IC+ghOvCsyp9YQu+A1Cu/orzib9wUE7vYFkHrjoBUOe09qJi2XONpkPnipnab31B
         bwJ9x3IfG3foUBIaEpYec8eS3X/Ytseq9YB4jrddW1X8bCmdxZfdTcPbW/8DxoSryz2o
         l1AaXw/XxzzusAdbDX/Qmbq1PwacnlhEibY/0EbosI/zU+1qczcjFGPyj+/bKewYuY0D
         jflVTAqG0UsGnDM3AdiTRXmP6nc1RN1M/VOTTyD3AMTeJHf2ipkTjSxYB7rwpZARZ+gZ
         sNPg==
X-Gm-Message-State: AOPr4FWViCAUDqHHRLjzwSZPngKOGTdFKVUHIWgIpy0+W0lnBY9sVD1ChCUl+4DAWAVmGA==
X-Received: by 10.55.198.149 with SMTP id s21mr23415596qkl.61.1461978151414;
        Fri, 29 Apr 2016 18:02:31 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293109>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

We detach after creating and opening the socket, because otherwise
we might return control to the shell before index-helper is ready to
accept commands.  This might lead to flaky tests.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 15 +++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index 9c2f5eb..e144752 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -34,6 +34,9 @@ OPTIONS
 	for reading an index, but because it will happen in the
 	background, it's not noticable. `--strict` is enabled by default.
=20
+--detach::
+	Detach from the shell.
+
 NOTES
 -----
=20
diff --git a/index-helper.c b/index-helper.c
index 21fb431..7df7a97 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -17,7 +17,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
-static int to_verify =3D 1;
+static int daemonized, to_verify =3D 1;
=20
 static void log_warning(const char *warning, ...)
 {
@@ -59,6 +59,8 @@ static void cleanup_shm(void)
=20
 static void cleanup(void)
 {
+	if (daemonized)
+		return;
 	unlink(git_path("index-helper.sock"));
 	cleanup_shm();
 }
@@ -311,7 +313,7 @@ static const char * const usage_text[] =3D {
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds =3D 600;
+	int idle_in_seconds =3D 600, detach =3D 0;
 	int fd;
 	struct strbuf socket_path =3D STRBUF_INIT;
 	struct option options[] =3D {
@@ -319,6 +321,7 @@ int main(int argc, char **argv)
 			    N_("exit if not used after some seconds")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -342,6 +345,14 @@ int main(int argc, char **argv)
 	if (fd < 0)
 		die_errno(_("could not set up index-helper socket"));
=20
+	if (!freopen("/dev/null", "w", stderr))
+		die_errno("failed to redirect stderr to /dev/null");
+
+	if (!freopen("/dev/null", "w", stdout))
+		die_errno("failed to redirect stdout to /dev/null");
+
+	if (detach && daemonize(&daemonized))
+		die_errno(_("unable to detach"));
 	loop(fd, idle_in_seconds);
=20
 	close(fd);
--=20
2.4.2.767.g62658d5-twtrsrc
