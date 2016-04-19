From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 06/15] index-helper: add --detach
Date: Tue, 19 Apr 2016 19:28:00 -0400
Message-ID: <1461108489-29376-7-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4P-0008Hl-6t
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbcDSX22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 19:28:28 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34208 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbcDSX2X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:23 -0400
Received: by mail-qg0-f43.google.com with SMTP id c6so19266575qga.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7G9E9+5FiyRUcKJGqc29QwWM17mAcY1IbE/WcnKtq1U=;
        b=y1z3kjFyc+p5OJ2rOwrSGY8ELy57ZsMLl4iBnlH0PgWfschpxILFwkwI8Hna2UToRS
         wI8vqUaf4jKXHrHa1udfy8rJhohypEyPHvd8TFx23VAs6cAbQstnrufIc/ApWzNpdHVl
         UfMATUIfPqW6KFIHvk3wWY5KqWDaAjN2DnQyfPufF+X101QbDjS6/DbNdfVpGrjhijYN
         txmX4r2mnTuxZwSQlNfY9+9rS/I3RX+neF9bsnDnmQjbE6jUGVyCF15bJX6gdbssNytZ
         JLtIY2LY9fTk7d9egnsTc+DqTEjni7/YuGs1zyTixKBpku5oPHWREl30Zr8BT8LisuT9
         SP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7G9E9+5FiyRUcKJGqc29QwWM17mAcY1IbE/WcnKtq1U=;
        b=QuFoWPjl9Wc2znmZEI4dOyiFJnZcNPN/cBEKlWZeiZKQ6FvhOuAZhZVZDz28A7OnAD
         WElOvnMr6mj8XJy5tE5JZYVYAyEfNiM363dphihebMMvCZ2BKOaoVWz0+ra63rqEk8wk
         lqx49yV7YuiXXt8g+QYBGYoHnPLc7vC7RzdxzsJr+wdZJ0JeiPjQyYwN3m86a0uCnNc6
         WkiOl1Ihb8iTxkuGT5qsnHXANYcp4oy51r/Mi86ArPSLs5Fr/tMrc6OTWF7t1DRdvvbE
         /CRICyr4UbAMxdwiUzQwwuIQPwQLzdKKtVG8lKs+CkE4XOnemVGqJLYHqnQGYVBZiqYV
         Me9w==
X-Gm-Message-State: AOPr4FUzg5Ckbsh5f1vgWQeXYAudxMFSv6eTPzNJTEYi5aV3KsErLpeccQX8BbEQ48YKnA==
X-Received: by 10.140.198.135 with SMTP id t129mr7596788qha.36.1461108501932;
        Tue, 19 Apr 2016 16:28:21 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291956>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

We detach after creating and opening the socket, because otherwise
we might return control to the shell before index-helper is ready to
accept commands.  This might lead to flaky tests.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt | 3 +++
 index-helper.c                     | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index a5c058f..f6aa525 100644
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
=20
diff --git a/index-helper.c b/index-helper.c
index e8d6b64..80b1dbe 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -16,7 +16,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
-static int to_verify =3D 1;
+static int daemonized, to_verify =3D 1;
=20
 static void release_index_shm(struct shm *is)
 {
@@ -35,6 +35,8 @@ static void cleanup_shm(void)
=20
 static void cleanup(void)
 {
+	if (daemonized)
+		return;
 	unlink(git_path("index-helper.sock"));
 	cleanup_shm();
 }
@@ -286,7 +288,7 @@ static const char * const usage_text[] =3D {
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds =3D 600;
+	int idle_in_seconds =3D 600, detach =3D 0;
 	int fd;
 	struct strbuf socket_path =3D STRBUF_INIT;
 	struct option options[] =3D {
@@ -294,6 +296,7 @@ int main(int argc, char **argv)
 			    N_("exit if not used after some seconds")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -317,6 +320,8 @@ int main(int argc, char **argv)
 	if (fd < 0)
 		die_errno(_("could not set up index-helper socket"));
=20
+	if (detach && daemonize(&daemonized))
+		die_errno(_("unable to detach"));
 	loop(fd, idle_in_seconds);
=20
 	close(fd);
--=20
2.4.2.767.g62658d5-twtrsrc
