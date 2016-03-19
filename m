From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 06/17] index-helper: add --detach
Date: Fri, 18 Mar 2016 21:04:39 -0400
Message-ID: <1458349490-1704-7-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:06:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5La-0008Mm-TF
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbcCSBG0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 21:06:26 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35934 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148AbcCSBGO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:06:14 -0400
Received: by mail-qg0-f47.google.com with SMTP id u110so114611795qge.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sWmAu/obYWV0BlpoH09QsAt8z5zkKx9Tq8JdwozKRh4=;
        b=zfTVA/lZWS/dkPfQpPOSGPdccH5LMtozDhs42rUSuQs7OpWfn2/PBNBuQsO5JhvH2L
         NzwJnlhjmmET63z7bFWNtwQy2nkaLx+deRu6Hez/B/2gRqwo6L2q3teqZQoaNt2uMTSb
         H9oBO1lJlCp77LEHmf2BT2ODrlyYd14sEhtsMOBaIOCxnGIoR4pqencsRSxNzkg6DXgq
         2WJU79GO1jXfWBguA5LTd3yZFudQuQP8yYcWN4LeO397903h5MTR4yL7iB2w5l4JITFg
         cJ+uRICLFocGEtajTqCpmvtXa52O8TYB9cBZYHTvk5/nNqQuTeI/54rNbv9pNxvRDLVh
         2n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWmAu/obYWV0BlpoH09QsAt8z5zkKx9Tq8JdwozKRh4=;
        b=TcNdf8weohqz+XC1RcO8iZD6aqK9sj03fL0cOuIrDOLOq46YEo8lS/IkWidepUUMYq
         0svjCp9VKQ51nH6M5zR9rvLVsofTxQBMl/P0rlVVtL0bYLDSca/WOOb7/UfBvtRxLsw9
         rlyvo2Akzgru66oyREtBD8ZBQN5/jtAOuZ7XxLnxKZDj4i95TRIeDa0/ljwX7YLqpQZL
         96hzpd8caiHmd2ybCl0zANcY5dqDyf4VSuW4eX8ts68d1KVRxpr+kaUrp0JY+B73JNlF
         SOYXYvDXfjFGpjIwLxp8i+iJIYPeyosY5HS6x9Rn5nbJKd6EVDzSXBH+z6Dr6bpiP1Sj
         lWrA==
X-Gm-Message-State: AD7BkJJzBStK/sD/H0qxrKUq65mR2pM9SpOwyiiEp8RpYubQgzeXdJrIlK3TLuOZVNGAVA==
X-Received: by 10.140.32.203 with SMTP id h69mr26154169qgh.55.1458349572600;
        Fri, 18 Mar 2016 18:06:12 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.06.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:06:11 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289272>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

We detach after creating and opening the named pipe, because otherwise
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
index 7afc5c9..b858a8d 100644
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
 $GIT_DIR/index-helper.pipe is a named pipe that the daemon reads
diff --git a/index-helper.c b/index-helper.c
index 8d221e0..a854ed8 100644
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
 	unlink(git_path("index-helper.pipe"));
 	cleanup_shm();
 }
@@ -229,7 +231,7 @@ static const char * const usage_text[] =3D {
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds =3D 600;
+	int idle_in_seconds =3D 600, detach =3D 0;
 	int fd;
 	struct strbuf pipe_path =3D STRBUF_INIT;
 	struct option options[] =3D {
@@ -237,6 +239,7 @@ int main(int argc, char **argv)
 			    N_("exit if not used after some seconds")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -258,6 +261,10 @@ int main(int argc, char **argv)
 	fd =3D setup_pipe(pipe_path.buf);
 	if (fd < 0)
 		die_errno("Could not set up index-helper.pipe");
+
+	if (detach && daemonize(&daemonized))
+		die_errno("unable to detach");
+
 	loop(fd, idle_in_seconds);
 	return 0;
 }
--=20
2.4.2.767.g62658d5-twtrsrc
