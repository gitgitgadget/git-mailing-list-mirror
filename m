From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v11 02/15] test: test relative_path through test-path-utils
Date: Fri, 17 May 2013 17:20:06 +0800
Message-ID: <c856c65a9f8b28cdead5cc89c182ed2a2a97c9a5.1368782129.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 17 11:20:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdGqF-0006AW-U6
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 11:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab3EQJUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 05:20:40 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:43151 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab3EQJUh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 05:20:37 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so3135572pdj.40
        for <git@vger.kernel.org>; Fri, 17 May 2013 02:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=Ufpm2NORxS+0+pQWFuz9Cl5X4EYeXScGcFuu19O912o=;
        b=gxK+MfpjUtygeEOHbk/hd3+ic26G4T7LMi3oPCes3IFh1G0so8ugcQ2OGaS9M++ruO
         kE+qlnu4UFJBZl6S0vwVUuLQNvhOJv5pOt13njAqSfWPkINTAQaOr1Lx68+rmT5+XQuj
         45dvtVuVDwsCORcRUGkCc3Tpa3EgtDya+KzIZgO1Z2DeGmQECOYvMILTc1D+RxhACQ5+
         Rkr/yncNgjGK9tTr4jis00vdrnjHhAsWyEHvwpo4k1EYH/uE/oLlcsQZUsW0f9KTfgMs
         Pc8vWCsvRFf1gSzNCvPoolfPeT/56Vdmc3mn7F5XXemVX9DzhT4B6N7gXCtXiVlOc+xl
         qFhA==
X-Received: by 10.68.189.231 with SMTP id gl7mr31389450pbc.123.1368782437317;
        Fri, 17 May 2013 02:20:37 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id 10sm10531002pbm.0.2013.05.17.02.20.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 02:20:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.380.g956c2b2
In-Reply-To: <cover.1368782129.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368782129.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224665>

Add subcommand "relative_path" in test-path-utils, and add test cases
in t0060.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 t/t0060-path-utils.sh | 23 +++++++++++++++++++++++
 test-path-utils.c     | 24 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 09a42..a51d7 100755
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
@@ -183,4 +188,22 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
 '
 
+relative_path /a/b/c/	/a/b/		c/
+relative_path /a/b/c/	/a/b		c/
+relative_path /a//b//c/	//a/b//		c/
+relative_path /a/b	/a/b		./
+relative_path /a/b/	/a/b		./
+relative_path /a	/a/b		../
+relative_path /		/a/b/		../../
+relative_path /a/c	/a/b/		../c
+relative_path /a/c	/a/b		../c
+relative_path /a/b	"(empty)"	/a/b
+relative_path /a/b 	"(null)"	/a/b
+relative_path "(empty)"	/a/b		./
+relative_path "(empty)"	"(empty)"	./
+relative_path "(empty)"	"(null)"	./
+relative_path "(null)"	/a/b		./
+relative_path "(null)"	"(empty)"	./
+relative_path "(null)"	"(null)"	./
+
 test_done
diff --git a/test-path-utils.c b/test-path-utils.c
index 0092cb..d759c 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -1,6 +1,19 @@
 #include "cache.h"
 #include "string-list.h"
 
+#define PARSE_ARGV_STRING(var, input) do { \
+	if (!strcmp(input, "(null)")) { \
+		var = NULL; \
+	} else if (!strcmp(input, "(empty)")) { \
+		var = ""; \
+	} else if (*input == '(') { \
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
@@ -103,6 +116,17 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 4 && !strcmp(argv[1], "relative_path")) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *abs, *base, *rel;
+		PARSE_ARGV_STRING(abs, argv[2]);
+		PARSE_ARGV_STRING(base, argv[3]);
+		rel = relative_path(abs, base, &sb);
+		puts(rel ? rel : "(null)");
+		strbuf_release(&sb);
+		return 0;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
1.8.3.rc2.380.g956c2b2
