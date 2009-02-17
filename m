From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/8] config: Trivial rename in preparation for parseopt.
Date: Tue, 17 Feb 2009 02:54:47 +0200
Message-ID: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 01:56:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEGB-00084m-IH
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbZBQAy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbZBQAy7
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:54:59 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:51434 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZBQAy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:54:59 -0500
Received: by bwz5 with SMTP id 5so3545414bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 16:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YSVjKDSJNiF7xm/+KeN500HnOLbmFqZ/5T4a8+eykmk=;
        b=a0zyBmAOfChBT9wV6iLl1lWBXqUJ+r78qbjF6d/cYsJqF3owIKJIGuVP5DJCndh+H7
         Bpwkc3CNH8qeZKTMqA49ylQbOXJUdlXTHjUpIYU92DZN3QEQyrHBOTah+OH+V82jyvtU
         PxYeUJEXLKpNJH5EQpF+eVhzAHioy/PsURUNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eUJmGLPGyIF7+xcP67KQKzGNbV00pSO47UbPoIXEzQ9E+SgmeXtZ6Qj0f38dAMpPMg
         RqO4TjMnPM3O7SdUePWSl9DtsRW8B5WzR3Of+EFQJpHS5s4uTQsOyxElf2wQigtjLfeT
         +JEUc4dZK9XLxXK8fJBQpXWzUS5Eoywamwrrk=
Received: by 10.103.198.15 with SMTP id a15mr3281963muq.60.1234832096819;
        Mon, 16 Feb 2009 16:54:56 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id j9sm63137mue.40.2009.02.16.16.54.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 16:54:56 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110275>

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
 builtin-config.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 6937eaf..da754e0 100644
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
 	char* value;
-	const char *file = setup_git_directory_gently(&nongit);
+	const char *prefix = setup_git_directory_gently(&nongit);
 
 	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
 
@@ -299,10 +300,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
 			if (argc != 2)
 				usage(git_config_set_usage);
-			if (git_config(show_all_config, NULL) < 0 &&
-					file && errno)
-				die("unable to read config file %s: %s", file,
-				    strerror(errno));
+			if (git_config(show_all_config, NULL) < 0)
+				die("error processing config file(s)");
 			return 0;
 		}
 		else if (!strcmp(argv[1], "--global")) {
@@ -319,12 +318,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
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
