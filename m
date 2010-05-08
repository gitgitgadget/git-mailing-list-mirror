From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control end-of-line conversion
Date: Sat,  8 May 2010 23:46:18 +0200
Message-ID: <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
Cc: mat <matthieu.stigler@gmail.com>, hasen j <hasan.aljudy@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 23:46:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OArr7-0005e1-8K
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 23:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab0EHVqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 17:46:34 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:59208 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab0EHVqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 17:46:32 -0400
Received: by ewy20 with SMTP id 20so578787ewy.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ncBlRVRbHi01H8+ABS852XBQHDbH3oeDuhA3mHIGmjo=;
        b=Em/fvAnZfuwV1HIgzog2PRjaJuDTBfdAJ+ADmnmzHMmCVsF5GkkUvjHXtKmxx4nMVt
         3KhLuOXlIBiXhfPMq+LfFeqz9/WVNCRiE1rpdSOeJAszibrb8/itltW8ZxqEcTq785Bd
         S//E8egfHK6qL8AdBxJMbhtIBCbBzRFG7c6fc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fb4B/AdR4Z3AqBddOF0+FhflJyUkhDgYruLB1RXiyqyvbtME3V93SlWgH8NWZPhCMX
         KGHQ1AHfFWrM40L1nHDABtOs6nyyakBiKy74nsYAyi2VOH2ptFBEHjTGaRgYxI2yO8ye
         EUaoCjLajuj0A0kxzE2VBynOqquS8hL/2vm3o=
Received: by 10.213.107.79 with SMTP id a15mr827185ebp.33.1273355191100;
        Sat, 08 May 2010 14:46:31 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm1782464ewy.6.2010.05.08.14.46.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 14:46:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.3.gb95c9
In-Reply-To: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146675>

Introduce a new configuration variable, "core.eolStyle", that allows the
user to set which line endings to use for end-of-line-normalized files
in the working directory.  It defaults to "native", which means CRLF on
Windows and LF everywhere else.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 Documentation/config.txt |    7 +++++++
 Makefile                 |    3 +++
 cache.h                  |   19 +++++++++++++++++++
 config.c                 |   16 +++++++++++++++-
 environment.c            |    1 +
 5 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 92f851e..3956ff7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -207,6 +207,13 @@ core.autocrlf::
 	the file's `crlf` attribute, or if `crlf` is unspecified,
 	based on the file's contents.  See linkgit:gitattributes[5].
 
+core.eolStyle::
+	Sets the line ending type to use for text files in the working
+	directory when the `auto-eol` property is set.  Alternatives are
+	'lf', 'crlf', 'native' and 'false'.  'native', the default, uses
+	the platform's native line ending.  'false' disables `auto-eol`
+	line ending conversion.  See linkgit:gitattributes[5].
+
 core.safecrlf::
 	If true, makes git check if converting `CRLF` as controlled by
 	`core.autocrlf` is reversible.  Git will verify if a command
diff --git a/Makefile b/Makefile
index 910f471..419532e 100644
--- a/Makefile
+++ b/Makefile
@@ -224,6 +224,8 @@ all::
 #
 # Define CHECK_HEADER_DEPENDENCIES to check for problems in the hard-coded
 # dependency rules.
+#
+# Define NATIVE_CRLF if your platform uses CRLF for line endings.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -989,6 +991,7 @@ ifeq ($(uname_S),Windows)
 	NO_CURL = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	NATIVE_CRLF = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
diff --git a/cache.h b/cache.h
index 5eb0573..690511e 100644
--- a/cache.h
+++ b/cache.h
@@ -561,6 +561,25 @@ enum safe_crlf {
 
 extern enum safe_crlf safe_crlf;
 
+enum auto_crlf {
+	AUTO_CRLF_FALSE = 0,
+	AUTO_CRLF_TRUE = 1,
+	AUTO_CRLF_INPUT = -1,
+};
+
+enum eol_style {
+	EOL_STYLE_FALSE = AUTO_CRLF_FALSE,
+	EOL_STYLE_CRLF = AUTO_CRLF_TRUE,
+	EOL_STYLE_LF = AUTO_CRLF_INPUT,
+#ifdef NATIVE_CRLF
+	EOL_STYLE_NATIVE = EOL_STYLE_CRLF,
+#else
+	EOL_STYLE_NATIVE = EOL_STYLE_LF,
+#endif
+};
+
+extern enum eol_style eol_style;
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
diff --git a/config.c b/config.c
index 6963fbe..8a11052 100644
--- a/config.c
+++ b/config.c
@@ -461,7 +461,7 @@ static int git_default_core_config(const char *var, const char *value)
 
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
-			auto_crlf = -1;
+			auto_crlf = AUTO_CRLF_INPUT;
 			return 0;
 		}
 		auto_crlf = git_config_bool(var, value);
@@ -477,6 +477,20 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.eolstyle")) {
+		if (value && !strcasecmp(value, "lf"))
+			eol_style = EOL_STYLE_LF;
+		else if (value && !strcasecmp(value, "crlf"))
+			eol_style = EOL_STYLE_CRLF;
+		else if (value && !strcasecmp(value, "native"))
+			eol_style = EOL_STYLE_NATIVE;
+		else if (! git_config_bool(var, value))
+			eol_style = EOL_STYLE_FALSE;
+		else
+			return error("Malformed value for %s", var);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.notesref")) {
 		notes_ref_name = xstrdup(value);
 		return 0;
diff --git a/environment.c b/environment.c
index 876c5e5..05cd1d5 100644
--- a/environment.c
+++ b/environment.c
@@ -40,6 +40,7 @@ const char *editor_program;
 const char *excludes_file;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 int read_replace_refs = 1;
+enum eol_style eol_style = EOL_STYLE_NATIVE;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
-- 
1.7.1.3.gb95c9
