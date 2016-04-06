From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 06/16] index-helper: add --detach
Date: Wed,  6 Apr 2016 18:11:52 -0400
Message-ID: <1459980722-4836-7-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:13:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvhY-000541-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbcDFWNV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 18:13:21 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35690 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbcDFWMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:43 -0400
Received: by mail-qk0-f172.google.com with SMTP id o6so23604249qkc.2
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OI8cdfMDPKFUhuCw9jzIMnkb664HR+QK6neflgrkwYI=;
        b=cDyig2Hl2aaGT/EyvYIjR5RknoNM5hB6mz0JRoL1sixFFRBMbyRwqxLVDiKdLLoIKl
         yw4woxP6+yraN8NwnDzeozMUIypkEAnzvBAx5i29W5Nkv1/MCrmp37ZwkKFVEV2FlXhC
         AhN4fAA0uCmtFFQ2/OJl/ovQtOAlierse3C860vtt+KZ0lR2DV3MBgEoGfKtfLrhPOwx
         Afo9hpxZQ2nLHKN3EW2SbwkxSE16EyGr4EWfpi+RquLP/s0La60hVQ56PvGT1BlJRvuw
         bw8lqUJZJvBIpxMMRO+L9+/njZKlPwr2hROaf+64pUvsGNZCK68jPKlRI9WghhKEC+sv
         pvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OI8cdfMDPKFUhuCw9jzIMnkb664HR+QK6neflgrkwYI=;
        b=gNxP/D6J5kusbPrBSyJao76ctagLPysmxg+2zpyfS1PlZF0dTOS3h1sHwKHEG4MYhC
         vAJMqHCJSCqBIs5afJtby51FbvrT0Zv0OcUIThVoWgNoPEch7yC3+4Lcvy44wIrOa45Z
         sw9q6pOmMLGkwBPpQSbYrWDU/ptC/H5JfKL4Sshe8CsmZfFWXhoXn+3yUDhP4YTPzwA1
         jq9H5xRrSs8gJPlKluVGCq3uHv8EP1H1stR695fEq/aWA/4ExG6KfAMX2oiHJ7rH78G0
         U3dXLdJnOB/cGEaQ621aWCQG5x3L6Z5SLy7WviaNsa3A3zpJSQY+1Br+OQ8RkSHeDtuZ
         KkaA==
X-Gm-Message-State: AD7BkJKNLO5Z0S1M8Qm9ppVbyvoMw5jOnOt56CGPiuynKBXFdcocYUy9/jJ2OwRFS4bXVQ==
X-Received: by 10.55.73.85 with SMTP id w82mr50879256qka.52.1459980762009;
        Wed, 06 Apr 2016 15:12:42 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290886>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

We detach after creating and opening the socket, because otherwise
we might return control to the shell before index-helper is ready to
accept commands.  This might lead to flaky tests.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index b177fb8..bb344cf 100644
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
 $GIT_DIR/index-helper.path is a symlink to a Unix domain socket in
diff --git a/index-helper.c b/index-helper.c
index 8288e30..10f29f5 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -15,7 +15,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
-static int to_verify =3D 1;
+static int daemonized, to_verify =3D 1;
=20
 static void release_index_shm(struct shm *is)
 {
@@ -34,6 +34,8 @@ static void cleanup_shm(void)
=20
 static void cleanup(void)
 {
+	if (daemonized)
+		return;
 	unlink(git_path("index-helper.path"));
 	cleanup_shm();
 }
@@ -289,7 +291,7 @@ static void make_socket_path(struct strbuf *path)
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds =3D 600;
+	int idle_in_seconds =3D 600, detach =3D 0;
 	int fd;
 	struct strbuf socket_path =3D STRBUF_INIT;
 	struct option options[] =3D {
@@ -297,6 +299,7 @@ int main(int argc, char **argv)
 			    N_("exit if not used after some seconds")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -326,6 +329,10 @@ int main(int argc, char **argv)
 		die(_("failed to delete old index-helper.path"));
 	if (symlink(socket_path.buf, git_path("index-helper.path")))
 		die(_("failed to symlink socket path into index-helper.path"));
+
+	if (detach && daemonize(&daemonized))
+		die_errno(_("unable to detach"));
+
 	loop(fd, idle_in_seconds);
=20
 	return 0;
--=20
2.4.2.767.g62658d5-twtrsrc
