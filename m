From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 8/9] index-helper: add --detach
Date: Mon, 28 Jul 2014 19:03:14 +0700
Message-ID: <1406548995-28549-9-git-send-email-pclouds@gmail.com>
References: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 14:04:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjfV-00039P-Ea
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 14:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbaG1MEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 08:04:37 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:58286 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaG1MEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 08:04:37 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so10375298pab.14
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 05:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8JsgR1bmQI2wTE5C17M8CC3odtqFVDy6e8DSMGliMQU=;
        b=hgU9Z0qRSqYs89inilgRQSPnsYGgIw7l8j8fRBx9d1qA/R6SpR2ewrNi1UxZqnSeth
         Sr91VwMiXv2eDGwgfAF4c3kDw4T+aOm3L9hWr/b04q4PMrpZmx5emtAZBwstTrF/k40Z
         gFpcqP5jXLdp59cj9vL8RCfH1xQ8tOqy/GcEBDaKLyizRgZOTEY9RhqvOoNOyvtkHsTn
         XLDajTA/g+RMAjfrjC/PL4lol+BJDW68fPfRJbTK9pBWgrZE2tn+jPYIP+MM+Y04HO1E
         0EGzjfRxYg9CuSFa23T0CEGUH6wneP+6T8EnhJUrnaPnVIilTvoIe6hseRW16EO0r6QY
         xK5g==
X-Received: by 10.67.22.65 with SMTP id hq1mr2380740pad.137.1406549076437;
        Mon, 28 Jul 2014 05:04:36 -0700 (PDT)
Received: from lanh ([115.73.211.176])
        by mx.google.com with ESMTPSA id da14sm66177837pac.24.2014.07.28.05.04.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 05:04:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Jul 2014 19:04:38 +0700
X-Mailer: git-send-email 2.1.0.rc0.66.gb9187ad
In-Reply-To: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254322>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index 406856d..d8fbdab 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -31,6 +31,9 @@ OPTIONS
 	for reading an index, but because it will happen in the
 	background, it's not noticable. `--strict` is enabled by default.
=20
+--detach::
+	Detach from the shell.
+
 NOTES
 -----
 On UNIX-like systems, $GIT_DIR/index-helper.pid contains the process
diff --git a/index-helper.c b/index-helper.c
index c82d307..4262678 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -13,7 +13,7 @@ struct index_shm {
=20
 static struct index_shm shm_index;
 static struct index_shm shm_base_index;
-static int to_verify =3D 1;
+static int daemonized, to_verify =3D 1;
=20
 static void free_index_shm(struct index_shm *is)
 {
@@ -32,6 +32,8 @@ static void cleanup_shm(void)
=20
 static void cleanup(void)
 {
+	if (daemonized)
+		return;
 	unlink(git_path("index-helper.pid"));
 	cleanup_shm();
 }
@@ -164,12 +166,13 @@ int main(int argc, char **argv)
 	static struct lock_file lock;
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *prefix;
-	int fd, idle_in_minutes =3D 10;
+	int fd, idle_in_minutes =3D 10, detach =3D 0;
 	struct option options[] =3D {
 		OPT_INTEGER(0, "exit-after", &idle_in_minutes,
 			    N_("exit if not used after some minutes")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -196,6 +199,9 @@ int main(int argc, char **argv)
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
=20
+	if (detach && daemonize(&daemonized))
+		die_errno("unable to detach");
+
 	if (!idle_in_minutes)
 		idle_in_minutes =3D 0xffffffff / 60;
 	loop(sb.buf, idle_in_minutes * 60);
--=20
2.1.0.rc0.66.gb9187ad
