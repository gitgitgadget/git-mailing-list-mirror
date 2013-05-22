From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v13 01/15] test: add test cases for relative_path
Date: Wed, 22 May 2013 09:40:22 +0800
Message-ID: <12d11d43c239adde88b878558da52c37a3d77cfa.1369186574.git.worldhello.net@gmail.com>
References: <cover.1369186574.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 03:41:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uey3p-0001jn-6o
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 03:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab3EVBlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 21:41:01 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:62544 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab3EVBku (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 21:40:50 -0400
Received: by mail-pa0-f41.google.com with SMTP id rl6so1299679pac.28
        for <git@vger.kernel.org>; Tue, 21 May 2013 18:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=bpru2kEq6q9gkhJvwNtpk/EVr3f3MabUjoaYKGOzG6I=;
        b=bSzRKSmWsoFFPhuebEO3aTY7rhXhHBa+DEQgwWul8pPQlTV4l+3nOtTBaS+YlCF2v2
         u7btgOFdEZeHTzNhmEz6PldS4WpGvA2Mjf4y/aMUH3iMuGojuEKlmZW07NuwDH80EUmq
         cb0ejY+KtbH2KVip5wASYlDaVdtZs4uguo/VubBGP4tCj3gUkty3IgcWQ2CgBLeZjXcI
         8oRU+FqKu/Cu50mDl4XRXutqlL9lAWQGXlVYQ79x/y/CmExtuzLGpfgc+/+gf6xrNr0d
         cjroXFXsvteqyWZbz9HR3NEcOnZqcJ9i/3ySpa+V7cNB9v9lrMG2WZe/HRNZ0acp2GUi
         DsXA==
X-Received: by 10.68.19.103 with SMTP id d7mr5330951pbe.156.1369186849379;
        Tue, 21 May 2013 18:40:49 -0700 (PDT)
Received: from localhost.localdomain ([114.248.150.82])
        by mx.google.com with ESMTPSA id at1sm4939345pbc.10.2013.05.21.18.40.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 18:40:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.368.g7c798dd
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
References: <7vhahwm5n6.fsf@alter.siamese.dyndns.org> <cover.1369186574.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225117>

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
index 0092cb..dcc530 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -28,6 +28,19 @@ static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
 	return 1;
 }
 
+static void normalize_argv_string(const char **var, const char *input)
+{
+	if (!strcmp(input, "<null>"))
+		*var = NULL;
+	else if (!strcmp(input, "<empty>"))
+		*var = "";
+	else
+		*var = input;
+
+	if (*var && (**var == '<' || **var == '('))
+		die("Bad value: %s\n", input);
+}
+
 int main(int argc, char **argv)
 {
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
@@ -103,6 +116,18 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 4 && !strcmp(argv[1], "relative_path")) {
+		const char *abs, *base, *rel;
+		normalize_argv_string(&abs, argv[2]);
+		normalize_argv_string(&base, argv[3]);
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
1.8.3.rc3.368.g7c798dd
