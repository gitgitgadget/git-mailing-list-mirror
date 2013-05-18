From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 01/15] test: add test cases for relative_path
Date: Sat, 18 May 2013 11:18:53 +0800
Message-ID: <ea0e3b1148ba1614916a8b1cca8d2d046acd047c.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:19:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXgT-0004GC-7C
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409Ab3ERDTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:19:32 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:35943 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759354Ab3ERDTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:19:25 -0400
Received: by mail-da0-f41.google.com with SMTP id y19so579336dan.14
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=B2RIu7QussTWvuI+ntHUGiABTqtv/aF5d9X45gS4d+I=;
        b=UdqHiRj+mbBprR7R6V0QpHCyCfJexufOu4qHXKHqYqfjgaXwmtqYC8CcwloSE+Gx9Y
         cdedOO5BZimO4GGDf2m0B7rGG9zDThM+C1mM+hMPv7oSm44d+dnkd1DWEMtvJvvtc2Tj
         jOnJK2j3TP6lUJ3BbUAdzbM69NHKaJv7X7oR3Nr0ylc/qUKsSwzcDGAoTVpjHsH4eef0
         V2evocQVvOOKawNQoq0itIB53qIYjNIfZR8XTQ2ch7eGpo/DSy5v5JhAC+yTrH3RS+n8
         DEZPkdjxWmO/tzZH6QSq+RewKoFxY37l63raS3gD9BhWgD+09mu+3HezqSUEZMVZNuM+
         cd0A==
X-Received: by 10.68.245.105 with SMTP id xn9mr50627793pbc.157.1368847164824;
        Fri, 17 May 2013 20:19:24 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.19.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:19:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224759>

Add subcommand "relative_path" in test-path-utils, and add test cases
in t0060.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 t/t0060-path-utils.sh | 26 ++++++++++++++++++++++++++
 test-path-utils.c     | 25 +++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 09a42..2199b 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -12,6 +12,11 @@ norm_path() {
 	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$2'"
 }
 
+relative_path() {
+	test_expect_success $4 "relative path: $1 $2 => $3" \
+	"test \"\$(test-path-utils relative_path '$1' '$2')\" = '$3'"
+}
+
 # On Windows, we are using MSYS's bash, which mangles the paths.
 # Absolute paths are anchored at the MSYS installation directory,
 # which means that the path / accounts for this many characters:
@@ -183,4 +188,25 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
 '
 
+relative_path /a/b/c/	/a/b/		c/
+relative_path /a/b/c/	/a/b		c/
+relative_path /a//b//c/	//a/b//		c/
+relative_path /a/b	/a/b		.
+relative_path /a/b/	/a/b		.
+relative_path /a	/a/b		/a
+relative_path /		/a/b/		/
+relative_path /a/c	/a/b/		/a/c
+relative_path /a/c	/a/b		/a/c
+relative_path /a/b	"<empty>"	/a/b
+relative_path /a/b 	"<null>"	/a/b
+relative_path "<empty>"	/a/b		"(empty)"
+relative_path "<empty>"	"<empty>"	"(empty)"
+relative_path "<empty>"	"<null>"	"(empty)"
+relative_path "<null>"	"<empty>"	"(null)"
+relative_path "<null>"	"<null>"	"(null)"
+
+test_expect_failure 'relative path: <null> /a/b => segfault' '
+	test-path-utils relative_path "<null>" "/a/b"
+'
+
 test_done
diff --git a/test-path-utils.c b/test-path-utils.c
index 0092cb..18267 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -1,6 +1,19 @@
 #include "cache.h"
 #include "string-list.h"
 
+#define PARSE_ARGV_STRING(var, input) do { \
+	if (!strcmp(input, "<null>")) { \
+		var = NULL; \
+	} else if (!strcmp(input, "<empty>")) { \
+		var = ""; \
+	} else if (*input == '<' || *input == '(') { \
+		fprintf(stderr, "Bad value: %s\n", input); \
+		return 1; \
+	} else { \
+		var = input; \
+	} \
+} while (0)
+
 /*
  * A "string_list_each_func_t" function that normalizes an entry from
  * GIT_CEILING_DIRECTORIES.  If the path is unusable for some reason,
@@ -103,6 +116,18 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 4 && !strcmp(argv[1], "relative_path")) {
+		const char *abs, *base, *rel;
+		PARSE_ARGV_STRING(abs, argv[2]);
+		PARSE_ARGV_STRING(base, argv[3]);
+		rel = relative_path(abs, base);
+		if (!rel)
+			puts("(null)");
+		else
+			puts(strlen(rel) > 0 ? rel : "(empty)");
+		return 0;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
1.8.3.rc2.26.g7472058
