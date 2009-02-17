From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 05/10] config: Reorganize get_color*.
Date: Tue, 17 Feb 2009 15:52:51 +0200
Message-ID: <1234878776-13250-5-git-send-email-felipe.contreras@gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-4-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 14:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQPn-0001sQ-2S
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbZBQNxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZBQNxU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:53:20 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:38712 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbZBQNxR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:53:17 -0500
Received: by mail-ew0-f21.google.com with SMTP id 14so2285088ewy.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BRRNhdajgqmygzNn8NNPIGcrPD3ZWRsh8FUKIPermk0=;
        b=qlSEiktuUYNkvxwjN2oPWZLG6VFsWsPVM1YJo+ZsoSe7GbQMfru+SouBDHcI1L6M1l
         Ml0An1W+iXhjeYWKAVhHb9amA8FHMbopcoK2AXdbmtPOffhhdZmspMMrJRI+qacFfE/Y
         mjOchcVIW6kWfbLiAuVM0Ueo2FHAME5VPXqFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ek5Wdr9Mvv3PqLBnEHk4rLrseC3RhEsoIpUtEZYaPEezJnv9LNB5FAIyU8C+mmU+65
         6rIrcW0Sc2JzT5tQyaO/rg+7OXMlLF8qv6a0Wufx4s9+5o9sQjrofkVOo2FVS55bg2w8
         KrFu2N+xZGPTZgkoCIm1UxN7b1xzBgwr4ZWjM=
Received: by 10.210.86.10 with SMTP id j10mr5324057ebb.153.1234878796663;
        Tue, 17 Feb 2009 05:53:16 -0800 (PST)
Received: from localhost (net-63.nrpn.net [192.89.6.63])
        by mx.google.com with ESMTPS id m5sm4325984gve.10.2009.02.17.05.53.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 05:53:15 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234878776-13250-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110375>

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
