From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [fixup PATCH 1/2] Call configset_clear
Date: Fri, 11 Jul 2014 16:27:12 +0200
Message-ID: <1405088833-5817-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqwqbk0y8n.fsf@anie.imag.fr>
Cc: tanayabh@gmail.com, artagnon@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 11 16:37:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5bwn-0007FC-27
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 16:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbaGKOhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 10:37:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47278 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbaGKOhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 10:37:05 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6BEYeJ9019100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jul 2014 16:34:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6BEYfv9024271;
	Fri, 11 Jul 2014 16:34:41 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1X5buL-0002Gg-IL; Fri, 11 Jul 2014 16:34:41 +0200
X-Mailer: git-send-email 2.0.0.262.gdafc651
In-Reply-To: <vpqwqbk0y8n.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 11 Jul 2014 16:34:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6BEYeJ9019100
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1405694082.35924@Z1FQi9qSFAtbBJYF2lHMbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253280>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Consider squashing this into PATCH 2/2.

 test-config.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/test-config.c b/test-config.c
index dc313c2..07b61ef 100644
--- a/test-config.c
+++ b/test-config.c
@@ -41,17 +41,17 @@ int main(int argc, char **argv)
 
 	if (argc < 2) {
 		fprintf(stderr, "Please, provide a command name on the command-line\n");
-		return 1;
+		goto exit1;
 	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
 		if (!git_config_get_value(argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
 		strptr = git_config_get_value_multi(argv[2]);
@@ -63,46 +63,46 @@ int main(int argc, char **argv)
 				else
 					printf("%s\n", v);
 			}
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
 		if (!git_config_get_int(argv[2], &val)) {
 			printf("%d\n", val);
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
 		if (!git_config_get_bool(argv[2], &val)) {
 			printf("%d\n", val);
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	} else if (!strcmp(argv[1], "configset_get_value")) {
 		for (i = 3; i < argc; i++) {
 			if (git_configset_add_file(&cs, argv[i]))
-				return 2;
+				goto exit2;
 		}
 		if (!git_configset_get_value(&cs, argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
 		for (i = 3; i < argc; i++) {
 			if (git_configset_add_file(&cs, argv[i]))
-				return 2;
+				goto exit2;
 		}
 		strptr = git_configset_get_value_multi(&cs, argv[2]);
 		if (strptr) {
@@ -113,13 +113,25 @@ int main(int argc, char **argv)
 				else
 					printf("%s\n", v);
 			}
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	}
 
 	fprintf(stderr, "%s: Please check the syntax and the function name\n", argv[0]);
+	goto exit1;
+
+exit0:
+	git_configset_clear(&cs);
+	return 0;
+
+exit1:
+	git_configset_clear(&cs);
 	return 1;
+
+exit2:
+	git_configset_clear(&cs);
+	return 2;
 }
-- 
2.0.0.262.gdafc651
