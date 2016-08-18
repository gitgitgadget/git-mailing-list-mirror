Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3EB1F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 12:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbcHRMsQ (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 08:48:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:50036 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945896AbcHRMsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 08:48:08 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lpxdr-1avolB1xe3-00fezC; Thu, 18 Aug 2016 14:46:18
 +0200
Date:	Thu, 18 Aug 2016 14:46:17 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] cat-file: introduce the --filters option
In-Reply-To: <cover.1471524357.git.johannes.schindelin@gmx.de>
Message-ID: <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MVta8Wa0pKInYluQZvWLAX2tPl6Pe3gNW3nA5ZVuE01ShdJ8rC7
 jQCeSjMwlXbIjd5O5AYl9KpVSZxZmTmu8gGOMyRVS4IRpeCRzRgZOERzJN/mqhvmmS1+f3X
 OdxRfkFiWCNz135HqTucEWgK+1sqqwOdsnpWUs396KBWWraV59waFVJcF+wHYHFgp66U+uA
 Cq1tY/FTyMbu+YbrJtVRg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:7VM1mnnF45Q=:u+WEiZuOs4BRYmg5moRwNV
 BW22FfIMA+b1NMZpZwo1mnY/RtEiaC+fqeqE3z25qQqle1psV5hsvBCAHJXPyghwaosgica0x
 reW1E6j68cEnVCoBqd8Dv4e3723tpMHszO3kFNBONTqd47oaYaAMGn9ho9dHMa3h8e0ol6Nnl
 nKPOPRONsQXybNFgreKtdk0e7Dtx6eV2ffHsupg5zMBpZEhtvuZszzB4UPpL/TlFkQis3zCDt
 /ApbCa1j041op2WZ+WBiNR+/ixIKpZbmBLbvp2yvPMuQ8iTcJp1IWrvKMODRQa5Qq/nEUY3WW
 VxhG7jE46pG+LcnrQl5IPwi2KLZKuoxz3aeIaQtOzhPuySMIn1kRS/UDxKxaIGw/9Ll6eYlMO
 FQUSbifoZfofxD5ce7vHFXaiUnusabcUpn7XU5lCfFWEh3fOluNbdcA4pPJI6WXGGDcNYn7iI
 cqbwo/c48Nkcc0O2LEQdPjCEmVC8yKsuBq9F5UvA2P6bnitLMAm0enfrxBtuSkJvJv46qZ+WH
 5wxiLpOSEBaBEFsB1EZcooMHdLZphDZt/a6xrMUJi/DMcDYsh0mQjt0O03XygYm8sH8CqOR8u
 1NsqwTcW6dd9GuE6Nd/l/wpUHzG0pwr9+gZ38muznrZPks+9oTC3rsC0ffi+3GmiLYaP0yeV0
 Ij9A9WcOMw3Z4ZV9iAYp/WtzM/zgdPIc74EDOM1Qg8OumlQnVRmaK11JqctUjZfiZ+1fIbcsy
 JpsBlK/aXrdVddxSSM5cyifuvHPkpPtazkH+bS4M5ZXxr040xth269wkCDE13mCU5gFRt9wSx
 jDNaqCW
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

As suggested by its name, the --filters option applies the filters
that are currently configured for the specified path.

This feature comes in handy when a 3rd-party tool wants to work with
the contents of files from past revisions as if they had been checked
out, but without detouring via temporary files.

Note that we ensure that symbolic links are unaffected (we know from
looking at the mode whether it refers to a symbolic link or a regular
file).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-cat-file.txt | 12 +++++++++---
 builtin/cat-file.c             | 41 ++++++++++++++++++++++++++++++++++++++++-
 t/t8010-cat-file-filters.sh    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 4 deletions(-)
 create mode 100755 t/t8010-cat-file-filters.sh

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 071029b..7d48735 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,15 +9,15 @@ git-cat-file - Provide content or type and size information for repository objec
 SYNOPSIS
 --------
 [verse]
-'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv ) <object>
+'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) <object>
 'git cat-file' (--batch | --batch-check) [--follow-symlinks]
 
 DESCRIPTION
 -----------
 In its first form, the command provides the content or the type of an object in
 the repository. The type is required unless `-t` or `-p` is used to find the
-object type, or `-s` is used to find the object size, or `--textconv` is used
-(which implies type "blob").
+object type, or `-s` is used to find the object size, or `--textconv` or
+`--filters` is used (which imply type "blob").
 
 In the second form, a list of objects (separated by linefeeds) is provided on
 stdin, and the SHA-1, type, and size of each object is printed on stdout.
@@ -58,6 +58,12 @@ OPTIONS
 	order to apply the filter to the content recorded in the index at
 	<path>.
 
+--filters::
+	Show the content as transformed by the filters configured in
+	the current working tree for the given <path> (i.e. smudge filters,
+	end-of-line conversion, etc). In this case, <object> has to be of
+	the form <tree-ish>:<path>, or :<path>.
+
 --batch::
 --batch=<format>::
 	Print object information and contents for each object provided
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2dfe626..0b74afa 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -20,6 +20,33 @@ struct batch_options {
 	const char *format;
 };
 
+static int filter_object(const char *path, unsigned mode,
+			 const unsigned char *sha1,
+			 char **buf, unsigned long *size)
+{
+	enum object_type type;
+
+	*buf = read_sha1_file(sha1, &type, size);
+	if (!*buf)
+		return error(_("cannot read object %s '%s'"),
+			sha1_to_hex(sha1), path);
+	if (type != OBJ_BLOB) {
+		free(*buf);
+		return error(_("blob expected for %s '%s'"),
+			sha1_to_hex(sha1), path);
+	}
+	if (S_ISREG(mode)) {
+		struct strbuf strbuf = STRBUF_INIT;
+		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
+			free(*buf);
+			*size = strbuf.len;
+			*buf = strbuf_detach(&strbuf, NULL);
+		}
+	}
+
+	return 0;
+}
+
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			int unknown_type)
 {
@@ -61,6 +88,16 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	case 'e':
 		return !has_sha1_file(sha1);
 
+	case 'w':
+		if (!obj_context.path[0])
+			die("git cat-file --filters %s: <object> must be "
+			    "<sha1:path>", obj_name);
+
+		if (filter_object(obj_context.path, obj_context.mode,
+				  sha1, &buf, &size))
+			return -1;
+		break;
+
 	case 'c':
 		if (!obj_context.path[0])
 			die("git cat-file --textconv %s: <object> must be <sha1:path>",
@@ -440,7 +477,7 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|-p|<type>|--textconv) <object>"),
+	N_("git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|-p|<type>|--textconv|--filters) <object>"),
 	N_("git cat-file (--batch | --batch-check) [--follow-symlinks]"),
 	NULL
 };
@@ -486,6 +523,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_CMDMODE(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
+		OPT_CMDMODE(0, "filters", &opt,
+			    N_("for blob objects, run filters on object's content"), 'w'),
 		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
 			  N_("allow -s and -t to work with broken/corrupt objects")),
 		OPT_BOOL(0, "buffer", &batch.buffer_output, N_("buffer --batch output")),
diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
new file mode 100755
index 0000000..e466634
--- /dev/null
+++ b/t/t8010-cat-file-filters.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='git cat-file filters support'
+. ./test-lib.sh
+
+test_expect_success 'setup ' '
+	echo "*.txt eol=crlf diff=txt" >.gitattributes &&
+	echo "hello" | append_cr >world.txt &&
+	git add .gitattributes world.txt &&
+	test_tick &&
+	git commit -m "Initial commit"
+'
+
+has_cr () {
+	tr '\015' Q <"$1" | grep Q >/dev/null
+}
+
+test_expect_success 'no filters with `git show`' '
+	git show HEAD:world.txt >actual &&
+	! has_cr actual
+
+'
+
+test_expect_success 'no filters with cat-file' '
+	git cat-file blob HEAD:world.txt >actual &&
+	! has_cr actual
+'
+
+test_expect_success 'cat-file --filters converts to worktree version' '
+	git cat-file --filters HEAD:world.txt >actual &&
+	has_cr actual
+'
+
+test_done
-- 
2.9.2.691.g78954f3


