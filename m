From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 08/12] MINGW: fix main() signature in http-fetch.c and remote-curl.c
Date: Tue, 29 Apr 2014 13:12:02 +0400
Message-ID: <1398762726-22825-9-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:12:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf45Z-0005GE-5t
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbaD2JM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:12:27 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:45098 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756778AbaD2JMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:12:22 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45L-0006BN-3M; Tue, 29 Apr 2014 13:12:19 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247535>

On MinGW, compat/mingw.h defines a 'mingw_main' wrapper function.
Fix `warning: passing argument 2 of 'mingw_main' from incompatible
pointer type` in http-fetch.c and remote-curl.c by dropping 'const'.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 http-fetch.c  | 5 +++--
 remote-curl.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

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
