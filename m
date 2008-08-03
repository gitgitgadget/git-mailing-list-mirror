From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 5/5] add --no-filters option to git hash-object
Date: Sun,  3 Aug 2008 18:36:22 +0400
Message-ID: <1217774182-28566-5-git-send-email-dpotapov@gmail.com>
References: <20080803055602.GN7008@dpotapov.dyndns.org>
 <1217774182-28566-1-git-send-email-dpotapov@gmail.com>
 <1217774182-28566-2-git-send-email-dpotapov@gmail.com>
 <1217774182-28566-3-git-send-email-dpotapov@gmail.com>
 <1217774182-28566-4-git-send-email-dpotapov@gmail.com>
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 16:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPeib-0007zq-DM
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 16:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009AbYHCOgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 10:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbYHCOgp
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 10:36:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:5157 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915AbYHCOgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 10:36:44 -0400
Received: by nf-out-0910.google.com with SMTP id d3so606841nfc.21
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OxJhCpaQVayTjcIVZ8tIro95sRCurTvVrZeZSuSBcqM=;
        b=FQjoO/SoFD4Cne/OuH8RUAz/Dyp3hIDOmzMcHQkZ7dO3JNy48X4UyTFqI/cbEMIY9r
         wBIURT/b8M7powu9c960HL3T/3vf3TQF2a3dSWlhdo558pDJaVkXQWykEcQn1hbBpx4/
         W9uG9oTl27G21xkMjVKX7YkAXaVmBTmOVXeDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AXbXB4giavRb0ZKoiEZCbdzNI0TYfJx9gjDl8HD7q5K9tVCmpepe7wQ6FcAXXIMLX/
         eaRwld39C/tuh81wWN94s+Zj2nL7O4aMapJDWaNqsGMnVx3LmJ3soj3JwIE9xsQ78wgv
         xCx+kIcLSWTkmRWWoUgr8nFvSPe7+z8bbFpzg=
Received: by 10.210.54.19 with SMTP id c19mr13714900eba.107.1217774203932;
        Sun, 03 Aug 2008 07:36:43 -0700 (PDT)
Received: from localhost ( [85.141.191.110])
        by mx.google.com with ESMTPS id h1sm4605407nfh.19.2008.08.03.07.36.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 07:36:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.58.gacdf
In-Reply-To: <1217774182-28566-4-git-send-email-dpotapov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91247>

If this option is given then the file is hashed as is ignoring all filters
specified in the configuration. This option is incompatible with --path
and --stdin-paths options.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 Documentation/git-hash-object.txt |    8 +++++++-
 hash-object.c                     |   17 +++++++++++++----
 t/t1007-hash-object.sh            |   24 ++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index fececbf..340e49c 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -9,7 +9,7 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 SYNOPSIS
 --------
 [verse]
-'git hash-object' [-t <type>] [-w] [--path=<file>] [--stdin] [--] <file>...
+'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin] [--] <file>...
 'git hash-object' [-t <type>] [-w] --stdin-paths < <list-of-paths>
 
 DESCRIPTION
@@ -47,6 +47,12 @@ OPTIONS
 	temporary files located outside of the working directory or files
 	read from stdin.
 
+--no-filters::
+	If this option is given then the file is hashed as is ignoring
+	all filters specified in the configuration, including crlf
+	conversion. If the file is read from standard input then no
+	filters is always implied unless the --path option is given.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
diff --git a/hash-object.c b/hash-object.c
index b11f459..3070a3e 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -51,7 +51,7 @@ static void hash_stdin_paths(const char *type, int write_objects)
 }
 
 static const char * const hash_object_usage[] = {
-	"git hash-object [-t <type>] [-w] [--path=<file>] [--stdin] [--] <file>...",
+	"git hash-object [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin] [--] <file>...",
 	"git hash-object  --stdin-paths < <list-of-paths>",
 	NULL
 };
@@ -60,6 +60,7 @@ static const char *type;
 static int write_object;
 static int hashstdin;
 static int stdin_paths;
+static int no_filters;
 static const char *vpath;
 
 static const struct option hash_object_options[] = {
@@ -67,6 +68,7 @@ static const struct option hash_object_options[] = {
 	OPT_BOOLEAN('w', NULL, &write_object, "write the object into the object database"),
 	OPT_BOOLEAN( 0 , "stdin", &hashstdin, "read the object from stdin"),
 	OPT_BOOLEAN( 0 , "stdin-paths", &stdin_paths, "read file names from stdin"),
+	OPT_BOOLEAN( 0 , "no-filters", &no_filters, "store file as is without filters"),
 	OPT_STRING( 0 , "path", &vpath, "file", "process file as it were from this path"),
 	OPT_END()
 };
@@ -98,9 +100,15 @@ int main(int argc, const char **argv)
 			errstr = "Can't specify files with --stdin-paths";
 		else if (vpath)
 			errstr = "Can't use --stdin-paths with --path";
+		else if (no_filters)
+			errstr = "Can't use --stdin-paths with --no-filters";
+	}
+	else {
+		if (hashstdin > 1)
+			errstr = "Multiple --stdin arguments are not supported";
+		if (vpath && no_filters)
+			errstr = "Can't use --path with --no-filters";
 	}
-	else if (hashstdin > 1)
-		errstr = "Multiple --stdin arguments are not supported";
 
 	if (errstr) {
 		error (errstr);
@@ -115,7 +123,8 @@ int main(int argc, const char **argv)
 
 		if (0 <= prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
-		hash_object(arg, type, write_object, vpath ? vpath : arg);
+		hash_object(arg, type, write_object,
+			    no_filters ? NULL : vpath ? vpath : arg);
 	}
 
 	if (stdin_paths)
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index dbe1f04..12195a5 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -65,6 +65,14 @@ test_expect_success "Can't use --path with --stdin-paths" '
 	echo example | test_must_fail git hash-object --stdin-paths --path=foo
 '
 
+test_expect_success "Can't use --stdin-paths with --no-filters" '
+	echo example | test_must_fail git hash-object --stdin-paths --no-filters
+'
+
+test_expect_success "Can't use --path with --no-filters" '
+	test_must_fail git hash-object --no-filters --path=foo
+'
+
 # Behavior
 
 push_repo
@@ -117,6 +125,22 @@ test_expect_success 'check that approperiate filter is invoke when --path is use
 	git config --unset core.autocrlf
 '
 
+test_expect_success 'check that --no-filters option works' '
+	echo fooQ | tr Q "\\015" > file0 &&
+	cp file0 file1 &&
+	echo "file0 -crlf" > .gitattributes &&
+	echo "file1 crlf" >> .gitattributes &&
+	git config core.autocrlf true &&
+	file0_sha=$(git hash-object file0) &&
+	file1_sha=$(git hash-object file1) &&
+	test "$file0_sha" != "$file1_sha" &&
+	nofilters_file1=$(git hash-object --no-filters file1) &&
+	test "$file0_sha" = "$nofilters_file1" &&
+	nofilters_file1=$(cat file1 | git hash-object --stdin) &&
+	test "$file0_sha" = "$nofilters_file1" &&
+	git config --unset core.autocrlf
+'
+
 pop_repo
 
 for args in "-w --stdin" "--stdin -w"; do
-- 
1.6.0.rc1.58.gacdf
