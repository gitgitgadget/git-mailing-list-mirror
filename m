From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 08/12] MINGW: config.mak.uname allow using CURL for non-msysGit builds
Date: Mon, 28 Apr 2014 17:51:33 +0400
Message-ID: <1398693097-24651-9-git-send-email-marat@slonopotamus.org>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:52:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Welyg-0003rQ-RQ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbaD1NwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:52:05 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:56306 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbaD1Nvy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:51:54 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyJ-0004qo-H2; Mon, 28 Apr 2014 17:51:52 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247331>

Also, fix `warning: passing argument 2 of 'mingw_main' from
incompatible pointer type` in http-fetch.c and remote-curl.c.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 2 --
 http-fetch.c     | 5 +++--
 remote-curl.c    | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 2f1939e..a376b32 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -523,8 +523,6 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	EXTLIBS += /mingw/lib/libz.a
 	INTERNAL_QSORT = YesPlease
 	NO_GETTEXT = YesPlease
-else
-	NO_CURL = YesPlease
 endif
 	HAVE_LIBCHARSET_H = YesPlease
 	NO_R_TO_GCC_LINKER = YesPlease
diff --git a/http-fetch.c b/http-fetch.c
index ba3ea10..a6a9a2f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -6,7 +6,7 @@
 static const char http_fetch_usage[] = "git http-fetch "
 "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	struct walker *walker;
 	int commits_on_stdin = 0;
@@ -38,7 +38,8 @@ int main(int argc, const char **argv)
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
 		} else if (argv[arg][1] == 'w') {
-			write_ref = &argv[arg + 1];
+			const char *ref = argv[arg + 1];
+			write_ref = &ref;
 			arg++;
 		} else if (argv[arg][1] == 'h') {
 			usage(http_fetch_usage);
diff --git a/remote-curl.c b/remote-curl.c
index 52c2d96..565b6c9 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -938,7 +938,7 @@ static void parse_push(struct strbuf *buf)
 	free(specs);
 }
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int nongit;
-- 
1.9.1
