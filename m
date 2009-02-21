From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A v4 5/5] git config: reorganize get_color*
Date: Sat, 21 Feb 2009 02:48:57 +0200
Message-ID: <1235177337-2532-6-git-send-email-felipe.contreras@gmail.com>
References: <1235177337-2532-1-git-send-email-felipe.contreras@gmail.com>
 <1235177337-2532-2-git-send-email-felipe.contreras@gmail.com>
 <1235177337-2532-3-git-send-email-felipe.contreras@gmail.com>
 <1235177337-2532-4-git-send-email-felipe.contreras@gmail.com>
 <1235177337-2532-5-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 01:51:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lag5V-0007JC-Uq
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbZBUAtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbZBUAtR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:49:17 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:42984 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbZBUAtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:49:12 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so3160824bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BRRNhdajgqmygzNn8NNPIGcrPD3ZWRsh8FUKIPermk0=;
        b=QYsnseuV6UzcyRJH9nXFUU/+fG+NkKo9GUnBG3s7D9BASFx9VxPAptYoH8I797I5aE
         WDbG59Io/XhirWeUlZPn77ztTOkw/g+w4uJQMKQYdBaESJW+Czz9UX6VOBsK8czkS6IF
         L2p0G5UQL3/p5kgjfX/zda4Ud8O6k6G+0cVdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PLciVQR+lW0BoN1AxeG9dDHQK+eJmuDJD3FuYGXrlgbbAwg1Qa7eMRmh3mKWKKW8+3
         wuw4t/6vB1kSk4FO69mciJqtq85Iju6O6h4/cB0kbeQAl6J8HSfuEWK1z0muEsyh8yAX
         /k57RB77HQmbBChIUTkkZ/4D4SPLEIli6bF7Q=
Received: by 10.181.159.11 with SMTP id l11mr468495bko.186.1235177350964;
        Fri, 20 Feb 2009 16:49:10 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id y15sm3035690fkd.32.2009.02.20.16.49.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 16:49:10 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235177337-2532-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110912>

In preparation for parseopt.

Also remove some unecessary comments since the usage is described in the
documentation.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |   63 +++++++++++++++--------------------------------------
 1 files changed, 18 insertions(+), 45 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 5074c61..0836880 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -180,7 +180,6 @@ static int get_color_found;
 static const char *get_color_slot;
 static const char *get_colorbool_slot;
 static char parsed_color[COLOR_MAXLEN];
-
 static int git_get_color_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, get_color_slot)) {
@@ -192,29 +191,8 @@ static int git_get_color_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int get_color(int argc, const char **argv)
+static void get_color(const char *def_color)
 {
-	/*
-	 * grab the color setting for the given slot from the configuration,
-	 * or parse the default value if missing, and return ANSI color
-	 * escape sequence.
-	 *
-	 * e.g.
-	 * git config --get-color color.diff.whitespace "blue reverse"
-	 */
-	const char *def_color = NULL;
-
-	switch (argc) {
-	default:
-		usage(git_config_set_usage);
-	case 2:
-		def_color = argv[1];
-		/* fallthru */
-	case 1:
-		get_color_slot = argv[0];
-		break;
-	}
-
 	get_color_found = 0;
 	parsed_color[0] = '\0';
 	git_config(git_get_color_config, NULL);
@@ -223,7 +201,6 @@ static int get_color(int argc, const char **argv)
 		color_parse(def_color, "command line", parsed_color);
 
 	fputs(parsed_color, stdout);
-	return 0;
 }
 
 static int stdout_is_tty;
@@ -247,24 +224,10 @@ static int git_get_colorbool_config(const char *var, const char *value,
 	return 0;
 }
 
-static int get_colorbool(int argc, const char **argv)
+static int get_colorbool(int print)
 {
-	/*
-	 * git config --get-colorbool <slot> [<stdout-is-tty>]
-	 *
-	 * returns "true" or "false" depending on how <slot>
-	 * is configured.
-	 */
-
-	if (argc == 2)
-		stdout_is_tty = git_config_bool("command line", argv[1]);
-	else if (argc == 1)
-		stdout_is_tty = isatty(1);
-	else
-		usage(git_config_set_usage);
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
-	get_colorbool_slot = argv[0];
 	git_config(git_get_colorbool_config, NULL);
 
 	if (get_colorbool_found < 0) {
@@ -274,12 +237,11 @@ static int get_colorbool(int argc, const char **argv)
 			get_colorbool_found = git_use_color_default;
 	}
 
-	if (argc == 1) {
-		return get_colorbool_found ? 0 : 1;
-	} else {
+	if (print) {
 		printf("%s\n", get_colorbool_found ? "true" : "false");
 		return 0;
-	}
+	} else
+		return get_colorbool_found ? 0 : 1;
 }
 
 int cmd_config(int argc, const char **argv, const char *unused_prefix)
@@ -363,9 +325,20 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 			}
 			return 0;
 		} else if (!strcmp(argv[1], "--get-color")) {
-			return get_color(argc-2, argv+2);
+			if (argc > 4 || argc < 3)
+				usage(git_config_set_usage);
+			get_color_slot = argv[2];
+			get_color(argv[3]);
+			return 0;
 		} else if (!strcmp(argv[1], "--get-colorbool")) {
-			return get_colorbool(argc-2, argv+2);
+			if (argc == 4)
+				stdout_is_tty = git_config_bool("command line", argv[3]);
+			else if (argc == 3)
+				stdout_is_tty = isatty(1);
+			else
+				usage(git_config_set_usage);
+			get_colorbool_slot = argv[2];
+			return get_colorbool(argc != 3);
 		} else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
 			if (argc != 2)
 				usage(git_config_set_usage);
-- 
1.6.1.3
