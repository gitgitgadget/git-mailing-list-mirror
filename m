From: Jeremy White <jwhite@codeweavers.com>
Subject: [PATCH] Enable setting attach in .gitconfig for git-format-patch.
Date: Sat, 07 Feb 2009 15:56:31 -0600
Message-ID: <498E038F.3090704@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050503000408020606030109"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 23:20:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVvXV-0008EL-Ij
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 23:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbZBGWTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 17:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbZBGWTO
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 17:19:14 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:52756 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbZBGWTN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 17:19:13 -0500
X-Greylist: delayed 1296 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Feb 2009 17:19:13 EST
Received: from localhost
	([127.0.0.1] helo=[10.0.0.16] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LVvBA-0001Cs-Kh
	for git@vger.kernel.org; Sat, 07 Feb 2009 15:57:36 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108897>

This is a multi-part message in MIME format.
--------------050503000408020606030109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

In an attempt to keep us Thunderbird users from embarrassing ourselves.

Signed-off-by: Jeremy White <jwhite@codeweavers.com>
---
  Documentation/git-format-patch.txt |    4 +++-
  builtin-log.c                      |   15 +++++++++++++++
  2 files changed, 18 insertions(+), 1 deletions(-)



--------------050503000408020606030109
Content-Type: text/x-patch;
 name="a7c94b28e4cfa6b9945499da8e6c7cb7289c19d4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a7c94b28e4cfa6b9945499da8e6c7cb7289c19d4.diff"

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 11a7d77..2e8e94e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -174,7 +174,8 @@ CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message
 in the repository configuration, new defaults for the subject prefix
-and file suffix, and number patches when outputting more than one.
+and file suffix, control attachements, and number patches when outputting
+more than one.
 
 ------------
 [format]
@@ -183,6 +184,7 @@ and file suffix, and number patches when outputting more than one.
 	suffix = .txt
 	numbered = auto
 	cc = <email>
+	attach [ = mime-boundary-string ]
 ------------
 
 
diff --git a/builtin-log.c b/builtin-log.c
index 2ae39af..1a8adde 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -428,6 +428,8 @@ static const char *fmt_patch_suffix = ".patch";
 static int numbered = 0;
 static int auto_number = 1;
 
+static char *extra_attach = NULL;
+
 static char **extra_hdr;
 static int extra_hdr_nr;
 static int extra_hdr_alloc;
@@ -488,6 +490,14 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		auto_number = auto_number && numbered;
 		return 0;
 	}
+	if (!strcmp(var, "format.attach")) {
+		if (value && strlen(value) > 0)
+			extra_attach = xstrdup(value);
+		else
+			extra_attach = xstrdup(git_version_string);
+		return 0;
+	}
+
 
 	return git_log_config(var, value, cb);
 }
@@ -787,6 +797,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
 
+	if (extra_attach) {
+		rev.mime_boundary = extra_attach;
+		rev.no_inline = 1;
+	}
+
 	/*
 	 * Parse the arguments before setup_revisions(), or something
 	 * like "git format-patch -o a123 HEAD^.." may fail; a123 is


--------------050503000408020606030109--
