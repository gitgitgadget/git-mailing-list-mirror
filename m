From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 07/19] index-helper: add --detach
Date: Wed, 27 Apr 2016 16:04:29 -0400
Message-ID: <1461787481-877-8-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:05:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avViI-0003Ha-1r
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbcD0UF1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2016 16:05:27 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35168 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbcD0UFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:18 -0400
Received: by mail-qk0-f170.google.com with SMTP id q76so21037818qke.2
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68wQnEJVVDMeDcudKaEs/tfWoVwY79Sjxf01hgQJDW0=;
        b=Xqf+PWJysaK+P+MqCjhsrs3ULkzgYGrDCRf5HrAiSYS2tfwSfpH8LXfK1SgVlxjS9W
         xCMf2ypbXk/SuCGURPRCAZ1ox6yU3RaJWiQ+gukl1YoMtA608Kmeyukhx7AJGL6ppZEW
         2jparPtvFhbww+1jWnv5MJNmQGhU9Yz9mlLy7WauHPIyeoYkrz2VeYXPt4H3h7dwfgcn
         rdF3w3qY1dPrUvc6yeaB0U0UBgw8/GI4ojJzW70M/NiRrITn+1yRoGF5u4G8aYoUe5Pb
         e6PDfcCJspgryqJhkxgICMYp6bOr3H/GYXpXb8j5DhYJ9RK5Fs4lVsf4/PB4P9YAjOn+
         iY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68wQnEJVVDMeDcudKaEs/tfWoVwY79Sjxf01hgQJDW0=;
        b=CSOtq7u0d4/m75GGc7/Ak1Q4Ua/z4McDENMX6I9J2drMNMFZ+DEF3oEFPw90nkjIgX
         fkmaYNs8wU6t+ez7E+7g+2ws21zGRxJO93F93+9rqxrZyFEUvxekQdxI4nkhgKxzENqF
         xqUcxUvgOWJh5iSSkaLfdZNbD1jjzZtDsMKE8Q7MIzksCxpy+QbHn68jn5oxyE6h+yF6
         40hrcKqjdTr97PVy8nNRlSlQRypRlY5dAooU1rTHHZkt/U5YWOiqdu2V1I/MHQ9xHpxN
         QMlc8fUUOyyT8gTZENOQ695ujVHtHftt5pwa4uKHFjdh1L3jonQiyWQnVJlaT+eaTZHN
         HDlw==
X-Gm-Message-State: AOPr4FVh4MC6YRvQv6A9JmxJH2PLvGvnYjDI2TErJHfXrwHP60x74eFA2Uxw16eQa1qwew==
X-Received: by 10.55.77.4 with SMTP id a4mr10775372qkb.57.1461787517173;
        Wed, 27 Apr 2016 13:05:17 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:16 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292794>

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
index 4eb3d95..18e1636 100644
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
index 7400d68..4273773 100644
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
@@ -318,7 +320,7 @@ static const char * const usage_text[] =3D {
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds =3D 600;
+	int idle_in_seconds =3D 600, detach =3D 0;
 	int fd;
 	struct strbuf socket_path =3D STRBUF_INIT;
 	struct option options[] =3D {
@@ -326,6 +328,7 @@ int main(int argc, char **argv)
 			    N_("exit if not used after some seconds")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -349,6 +352,14 @@ int main(int argc, char **argv)
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
