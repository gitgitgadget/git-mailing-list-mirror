From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 04/10] config: Trivial rename in preparation for parseopt.
Date: Tue, 17 Feb 2009 15:52:50 +0200
Message-ID: <1234878776-13250-4-git-send-email-felipe.contreras@gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 14:55:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQPm-0001sQ-BY
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbZBQNxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbZBQNxR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:53:17 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:38712 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbZBQNxO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:53:14 -0500
Received: by mail-ew0-f21.google.com with SMTP id 14so2285088ewy.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=F19sRHwXI+0D31xDBJfkmPJFkkeL0dtPD4MkAvSw0ok=;
        b=R9C6sSVD3w2FVmukXsdw4pvwyfmPgdcoOfbs9tGfyITFIMqSFXH2D0OayiBKuqWKEV
         wNzAhXCCiOsFpggdIjvNxt48E7raMZHH9PSUXIhi3s36BT22cih15utGjDjBjjYYC2VJ
         zILMOk6XDmD3hiY00aJwzXn5uQjF0vAdu2qWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l9GBQHJhHDDZNCvb073YH8ijZHVKZ9n49A2Ua9+t7Kqih9kLEhBlTdSCUeY20+SZA9
         hSSm69oEfJxiv1LRUXJLGBSwnJJxawmswyGL43Mht1tpgA5fMlfoarCmkb9fC/Am3650
         yk7S7iaSkEzVoKiPXn/pYyx/O3fNQQN2BROTI=
Received: by 10.210.114.15 with SMTP id m15mr1169027ebc.52.1234878793090;
        Tue, 17 Feb 2009 05:53:13 -0800 (PST)
Received: from localhost (net-63.nrpn.net [192.89.6.63])
        by mx.google.com with ESMTPS id g9sm735582gvc.4.2009.02.17.05.53.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 05:53:12 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110376>

Essensially this replaces 'file' with 'prefix' in the cases where the
variable is used as a prefix, which is consistent with other git
commands.

When using the --list option general errors where not properly reported,
only errors related with the 'file'. Now they are reported, and 'file'
is irrelevant.

That reduces the rest of 'file' usage to nothing, therefore now only
'prefix' remains.

Suggested by Johannes Schindelin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index d52a057..5074c61 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -178,6 +178,7 @@ static char *normalize_value(const char *key, const char *value)
 
 static int get_color_found;
 static const char *get_color_slot;
+static const char *get_colorbool_slot;
 static char parsed_color[COLOR_MAXLEN];
 
 static int git_get_color_config(const char *var, const char *value, void *cb)
@@ -231,7 +232,7 @@ static int get_diff_color_found;
 static int git_get_colorbool_config(const char *var, const char *value,
 		void *cb)
 {
-	if (!strcmp(var, get_color_slot)) {
+	if (!strcmp(var, get_colorbool_slot)) {
 		get_colorbool_found =
 			git_config_colorbool(var, value, stdout_is_tty);
 	}
@@ -263,11 +264,11 @@ static int get_colorbool(int argc, const char **argv)
 		usage(git_config_set_usage);
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
-	get_color_slot = argv[0];
+	get_colorbool_slot = argv[0];
 	git_config(git_get_colorbool_config, NULL);
 
 	if (get_colorbool_found < 0) {
-		if (!strcmp(get_color_slot, "color.diff"))
+		if (!strcmp(get_colorbool_slot, "color.diff"))
 			get_colorbool_found = get_diff_color_found;
 		if (get_colorbool_found < 0)
 			get_colorbool_found = git_use_color_default;
@@ -281,11 +282,11 @@ static int get_colorbool(int argc, const char **argv)
 	}
 }
 
-int cmd_config(int argc, const char **argv, const char *prefix)
+int cmd_config(int argc, const char **argv, const char *unused_prefix)
 {
 	int nongit;
 	char *value;
-	const char *file = setup_git_directory_gently(&nongit);
+	const char *prefix = setup_git_directory_gently(&nongit);
 
 	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
 
@@ -299,10 +300,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
 			if (argc != 2)
 				usage(git_config_set_usage);
-			if (git_config(show_all_config, NULL) < 0 &&
-					file && errno)
-				die("unable to read config file %s: %s", file,
-				    strerror(errno));
+			if (git_config(show_all_config, NULL) < 0) {
+				if (config_exclusive_filename)
+					die("unable to read config file %s: %s",
+					    config_exclusive_filename, strerror(errno));
+				else
+					die("error processing config file(s)");
+			}
 			return 0;
 		}
 		else if (!strcmp(argv[1], "--global")) {
@@ -319,12 +323,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "--file") || !strcmp(argv[1], "-f")) {
 			if (argc < 3)
 				usage(git_config_set_usage);
-			if (!is_absolute_path(argv[2]) && file)
-				file = prefix_filename(file, strlen(file),
-						       argv[2]);
+			if (!is_absolute_path(argv[2]) && prefix)
+				config_exclusive_filename = prefix_filename(prefix,
+									    strlen(prefix),
+									    argv[2]);
 			else
-				file = argv[2];
-			config_exclusive_filename = file;
+				config_exclusive_filename = argv[2];
 			argc--;
 			argv++;
 		}
-- 
1.6.1.3
