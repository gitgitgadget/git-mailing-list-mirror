From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/8] config: Reorganize get_color*.
Date: Tue, 17 Feb 2009 02:54:48 +0200
Message-ID: <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 01:57:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEGe-0008Gx-HF
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbZBQAzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbZBQAzD
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:55:03 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:56109 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbZBQAzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:55:01 -0500
Received: by bwz5 with SMTP id 5so3545431bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 16:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TV4chtnnjq4iyhGxSZCTXNzsbxTRM1vo8IdHgYNl+cM=;
        b=qVTN/A7v9Hdzft4h8n7uMYeiTjvAPVrOGneMR9ATfZA4vdZ+brGt7k6gwKUAt3X7sJ
         LMMfbQiHg3LCMBkmwt55TrY4qijW8WCZrhHHs5CkvWk+/b4ZOPzBKmiN/EmYzbwrF4K9
         Pds9Cpj3kAugcyU+dPa86c3KDNVdtLTTAhFQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QFu3ruhVzXhdGIw+7ueucNPfAK33QW9maVlp1W2QGxmCOi/FgMRc8VeCIyf5Kfuijc
         Zga7hgOuSLdjD4cEAvNyvFLQ76s1rPyYIc24HMYrqVlqLVrwIqHJjc/+lvC5Un0+kA3F
         tEhG3dzDxxu/Xmtvb6oe5RL5yz5s4+djVscRI=
Received: by 10.103.220.18 with SMTP id x18mr3262453muq.135.1234832098923;
        Mon, 16 Feb 2009 16:54:58 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id u9sm8706624muf.55.2009.02.16.16.54.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 16:54:58 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110277>

In preparation for parseopt.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |   63 +++++++++++++++--------------------------------------
 1 files changed, 18 insertions(+), 45 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index da754e0..8fd6171 100644
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
@@ -358,9 +320,20 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
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
+			return get_colorbool(argc == 3);
 		} else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
 			const char *config_filename;
 			if (argc != 2)
-- 
1.6.1.3
