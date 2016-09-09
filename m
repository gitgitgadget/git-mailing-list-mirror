Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067F81F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbcIIKLE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:11:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:56965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752035AbcIIKK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:10:59 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M9bYB-1bu9f51mQh-00D26F; Fri, 09 Sep 2016 12:10:48
 +0200
Date:   Fri, 9 Sep 2016 12:10:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 2/4] cat-file: introduce the --filters option
In-Reply-To: <cover.1473415827.git.johannes.schindelin@gmx.de>
Message-ID: <084088ba86c0af3636d960276c0bfdf7f5d2cfde.1473415827.git.johannes.schindelin@gmx.de>
References: <cover.1472041389.git.johannes.schindelin@gmx.de> <cover.1473415827.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:S9KyXPlEbgrlmEoh+Yj9WX7oWmfWs8Wz8Km9sR70aEK2QS6rljM
 E0FiH0H2eXCorV9hFzWfaSF8ga3BrP1AHZtEl5efoD5lEVVyfgGoKuB4XxAYKBZd4XJOSHZ
 l4po1AID3iENQNwv5/weluddRk/nXlMJ6Vw1jJBVZTiRNvBfSPn0OB/eFweRsnMAAmTSKSV
 SC8QNvZ1VQr1+jnSHi/sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AurG1BXPfP0=:YXlpZrYCXEnI9xHz1nvgsq
 quXkYEq+RyTY15Ze8jqX/Q1hmwVWKjtA2HoYH2vQVLzk64aTa47B+eWzK1P0xWpbtBZTSqEVG
 eHscwFaoGCb2SjPODntsX99VcQJFZdHsMd+LivmGLTKXsBng9fYcyM2GzLjpG91J0nTsAFSVp
 s6dgaJ4WXqClmfGMQjtK0rguNHdMtolDGJ+BbuJUtNDGDAwk7eJuPxOYM64Aj/8H/x3DUTrlx
 Ox3L9TSaLqAwOVgoP6GPaQL/Q/fqUcAO5RF3iYBW4ZfL+HM7BXEvdY/PSinyZyt1eVnsLqrvs
 EW9hq553rf3nav7LhdLwFE/cOSWS7ixl235rZsTLIPQmhuzmH1IxbE1Qx+e9gwP5BvfcO0MbW
 Bd6ZJkH3N0CjF0ZRdJPqeXvrpQVWpzktH5PJbLl4iekdt2PAwXuTo5yIiXEZ5tT9zApVjRYR2
 42v3X3Sl9D0ljzhhlhFD7ffGlcR7nl25QxhEmuEBTwoTTnK7JytYsJHb+FtZx37m8mSOh6smS
 piZxwM70VhsMJewsToNbhR1zyfEbctu9u9hTPAdUxp/pse68IDiV+ReZ/MpFIpkSF5YH+6ljD
 v7wQG1ebZHmlqvSy/8cteHlQiBvgOJQPSrehNntXYxWYVUKwwPtUwHB1WBJbvHUmq7hGVG2uX
 rZPk/nDct8dtggi1arpfI1neLYWZNrcc+BFXB0I2ixyEx5NfRdydp5W9WXIgCnDajH9H0HU47
 D6L3ClwOaaStfPZmxBtSgVcNxe96wAopFy09uaEph89OY9p7NI8WZubkwkEUDJNexBJPEaHPd
 T/m69NL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --filters option applies the convert_to_working_tree() filter for
the path when showing the contents of a regular file blob object.

This feature comes in handy when a 3rd-party tool wants to work with
the contents of files from past revisions as if they had been checked
out, but without detouring via temporary files.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-cat-file.txt | 12 +++++++++---
 builtin/cat-file.c             | 41 ++++++++++++++++++++++++++++++++++++++++-
 t/t8010-cat-file-filters.sh    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 4 deletions(-)
 create mode 100755 t/t8010-cat-file-filters.sh

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 071029b..537d02c 100644
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
+	Show the content as converted by the filters configured in
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
2.10.0.windows.1.10.g803177d


