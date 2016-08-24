Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A78D21F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 12:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754973AbcHXMYH (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 08:24:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:56628 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754886AbcHXMYD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 08:24:03 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M7kwW-1bGRvQ25Nw-00vOuY; Wed, 24 Aug 2016 14:23:48
 +0200
Date:   Wed, 24 Aug 2016 14:23:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 4/4] cat-file: support --textconv/--filters in batch
 mode
In-Reply-To: <cover.1472041389.git.johannes.schindelin@gmx.de>
Message-ID: <89fdd570345a1b092024e5b8e608852f0ccc94fc.1472041389.git.johannes.schindelin@gmx.de>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <cover.1472041389.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:08O+szvpQxyjufAk4xUzqbgdFW+wetaWD7AIYSFquJtfqB8Ahcw
 ElIg+Yo5DiZcXt5chLBNRuD4/RMGTZ3XVEQlmMCnQ3muSsdkBGn45FCdkgEeTKiRtTz3far
 GolGZTsqVaGMW6Z3VgD6znH6zqItIovTuEg6jIuE52gkEtaHBNWr3pSlqmh6sFlhR/fdxnV
 W1Vblx5/qKVQ8dJZ+wYtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OrsZBn27S8o=:CYtRTdlvZTek1+Bjx+e+QS
 Q3Peo2VSihHH2B/zfOB3VF4W7aHoTHLJHIyMQTcXvX5AeYdHmYJBQyosXGLn3+seofHx/7Kov
 +INlSow+lATTPP1aaWKJnf/OuS17fIiqNZkecs23/d+Abnnd2BL1ecxJRYOasCB+e/d3CnqIW
 YU8MY1tKfYOhxzz/v18ZPSQjPgG9ywoM0vvSPI0C6JihnUi84406kfjFxR3WGM9I3HoUexEnl
 lafCHc9RvmW16wq+VwCuYxPK9g/a8Vj5SRbxh03Tz/5r8YZDFJZHj6ru3IlHNxJESW2GUMYYM
 0lC+T9v4gX3q1S4LHmvSVl/4fCFG9Apy9uwgQZqBAC4lgPEUvLQsUX4Sc1c/bx1xp2uWL+LRC
 vDLi1vphfN2iQdxdp22aM/lIBkHyLGncHBONXZWihFf+3i/oS0+l4KEGNOi/yIhe1Wmq4uxeA
 1nv5/qUqLr7q01yFlIsiA/a2zO8FDAKsFWmVjD3W8Gt+N/dj7hnCMubEcdgsf2faQP+UuXX/s
 Lid9FK9dGbdbdNK4SyhTkDDJ8YRQ2ru12Ozlr2Ef6DdQfHPK30ThGXN43jBpV+ptH7tb7NHcV
 ubfTKBrdw55Pbe6woLoJ66xoJa+oQhUQEXSJ3/o8LwSGTDEHzxYBd5KdyrPJuuLUMmhQCpIYi
 oocDGjlYFYXyQsMQiWrtwC3uLXAu/zfIBd5PnPi/Lsam261olMuoZ9IamAchmXmyjItoUEMfF
 wCd5ht8efo1lfYZ8unE8WMs4h9+ZtUFlVVc9DO5OCwXoZU+cCnOAnAPeoNvJCf+o7FKRgP2OY
 GDq1pcU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this patch, --batch can be combined with --textconv or --filters.
For this to work, the input needs to have the form

	<object name><single white space><path>

so that the filters can be chosen appropriately.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-cat-file.txt | 18 +++++++++++-----
 builtin/cat-file.c             | 49 +++++++++++++++++++++++++++++++++++++-----
 t/t8010-cat-file-filters.sh    | 10 +++++++++
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 4fa9041..204541c 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) [--path=<path>] <object>
-'git cat-file' (--batch | --batch-check) [--follow-symlinks]
+'git cat-file' (--batch | --batch-check) [ --textconv | --filters ] [--follow-symlinks]
 
 DESCRIPTION
 -----------
@@ -20,7 +20,11 @@ object type, or `-s` is used to find the object size, or `--textconv` or
 `--filters` is used (which imply type "blob").
 
 In the second form, a list of objects (separated by linefeeds) is provided on
-stdin, and the SHA-1, type, and size of each object is printed on stdout.
+stdin, and the SHA-1, type, and size of each object is printed on stdout. The
+output format can be overridden using the optional `<format>` argument. If
+either `--textconv` or `--filters` was specified, the input is expected to
+list the object names followed by the path name, separated by a single white
+space, so that the appropriate drivers can be determined.
 
 OPTIONS
 -------
@@ -72,13 +76,17 @@ OPTIONS
 --batch::
 --batch=<format>::
 	Print object information and contents for each object provided
-	on stdin.  May not be combined with any other options or arguments.
-	See the section `BATCH OUTPUT` below for details.
+	on stdin.  May not be combined with any other options or arguments
+	except `--textconv` or `--filters`, in which case the input lines
+	also need to specify the path, separated by white space.  See the
+	section `BATCH OUTPUT` below for details.
 
 --batch-check::
 --batch-check=<format>::
 	Print object information for each object provided on stdin.  May
-	not be combined with any other options or arguments.  See the
+	not be combined with any other options or arguments except
+	`--textconv` or `--filters`, in which case the input lines also
+	need to specify the path, separated by white space.  See the
 	section `BATCH OUTPUT` below for details.
 
 --batch-all-objects::
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2c799ac..f8a3a08 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -17,6 +17,7 @@ struct batch_options {
 	int print_contents;
 	int buffer_output;
 	int all_objects;
+	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
 	const char *format;
 };
 
@@ -285,7 +286,32 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	if (data->type == OBJ_BLOB) {
 		if (opt->buffer_output)
 			fflush(stdout);
-		if (stream_blob_to_fd(1, sha1, NULL, 0) < 0)
+		if (opt->cmdmode) {
+			char *contents;
+			unsigned long size;
+
+			if (!data->rest)
+				die("missing path for '%s'", sha1_to_hex(sha1));
+
+			if (opt->cmdmode == 'w') {
+				if (filter_object(data->rest, 0100644, sha1,
+						  &contents, &size))
+					die("could not convert '%s' %s",
+					    sha1_to_hex(sha1), data->rest);
+			} else if (opt->cmdmode == 'c') {
+				enum object_type type;
+				if (!textconv_object(data->rest, 0100644, sha1,
+						     1, &contents, &size))
+					contents = read_sha1_file(sha1, &type,
+								  &size);
+				if (!contents)
+					die("could not convert '%s' %s",
+					    sha1_to_hex(sha1), data->rest);
+			} else
+				die("BUG: invalid cmdmode: %c", opt->cmdmode);
+			batch_write(opt, contents, size);
+			free(contents);
+		} else if (stream_blob_to_fd(1, sha1, NULL, 0) < 0)
 			die("unable to stream %s to stdout", sha1_to_hex(sha1));
 	}
 	else {
@@ -422,6 +448,8 @@ static int batch_objects(struct batch_options *opt)
 	data.mark_query = 1;
 	strbuf_expand(&buf, opt->format, expand_format, &data);
 	data.mark_query = 0;
+	if (opt->cmdmode)
+		data.split_on_whitespace = 1;
 
 	if (opt->all_objects) {
 		struct object_info empty;
@@ -487,7 +515,7 @@ static int batch_objects(struct batch_options *opt)
 
 static const char * const cat_file_usage[] = {
 	N_("git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|-p|<type>|--textconv|--filters) [--path=<path>] <object>"),
-	N_("git cat-file (--batch | --batch-check) [--follow-symlinks]"),
+	N_("git cat-file (--batch | --batch-check) [--follow-symlinks] [--textconv|--filters]"),
 	NULL
 };
 
@@ -558,7 +586,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
 
 	if (opt) {
-		if (argc == 1)
+		if (batch.enabled && (opt == 'c' || opt == 'w'))
+			batch.cmdmode = opt;
+		else if (argc == 1)
 			obj_name = argv[0];
 		else
 			usage_with_options(cat_file_usage, options);
@@ -570,8 +600,12 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		} else
 			usage_with_options(cat_file_usage, options);
 	}
-	if (batch.enabled && (opt || argc)) {
-		usage_with_options(cat_file_usage, options);
+	if (batch.enabled) {
+		if (batch.cmdmode != opt || argc)
+			usage_with_options(cat_file_usage, options);
+		if (batch.cmdmode && batch.all_objects)
+			die("--batch-all-objects cannot be combined with "
+			    "--textconv nor with --filters");
 	}
 
 	if ((batch.follow_symlinks || batch.all_objects) && !batch.enabled) {
@@ -583,6 +617,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		usage_with_options(cat_file_usage, options);
 	}
 
+	if (force_path && batch.enabled) {
+		error("--path=<path> incompatible with --batch");
+		usage_with_options(cat_file_usage, options);
+	}
+
 	if (batch.buffer_output < 0)
 		batch.buffer_output = batch.all_objects;
 
diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
index 0d5c33e..acdfa09 100755
--- a/t/t8010-cat-file-filters.sh
+++ b/t/t8010-cat-file-filters.sh
@@ -51,4 +51,14 @@ test_expect_success '----path=<path> complains without --textconv/--filters' '
 	grep "path.*needs.*filters" err
 '
 
+test_expect_success 'cat-file --textconv --batch works' '
+	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
+	test_config diff.txt.textconv "tr A-Za-z N-ZA-Mn-za-m <" &&
+	printf "%s hello.txt\n%s hello\n" $sha1 $sha1 |
+	git cat-file --textconv --batch >actual &&
+	printf "%s blob 6\nuryyb\r\n\n%s blob 6\nhello\n\n" \
+		$sha1 $sha1 >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.10.0.rc1.99.gcd66998
