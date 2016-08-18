Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF131F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 12:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbcHRMsO (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 08:48:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:59311 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945904AbcHRMsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 08:48:08 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Mg4FJ-1bmGxs175B-00NOFn; Thu, 18 Aug 2016 14:46:29
 +0200
Date:	Thu, 18 Aug 2016 14:46:28 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] cat-file: support --textconv/--filters in batch mode
In-Reply-To: <cover.1471524357.git.johannes.schindelin@gmx.de>
Message-ID: <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NQDNmxe0rG7Rnp+Af1yCuUqze0sjZO8C4c4aQxJsjRCv9F9Vqhg
 A358A0N4kMwEpZSWY7iAgFoGT9pbnIoXJEcisj5a2g6iclwU4gA31f0HqDX/LR1Z33FzTz0
 yMTifleP1z9Ke+CHB5PA2wWGlYyfqZphyhiwRHp/+QZy4gO8RX+ZPK5a3XNvNalQmpq5rWT
 mh1v5x9QNAXiUAQ5My0gg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:F2wJNQdyT08=:vXl4TIH4A1GxvYMUf5qlyN
 Kt4oXThoenvhvF3+6cKqZq1IcVSr+gNDNlpeSUxtV+XzrRk0ZpOF7Qzqxj0I03sErV08RzsIa
 2WxVbkfSjmqesZHuzlZPyYdUM/hK0t3hgySBLqp3UrCVYwxnoHZy6fS+Fxea8XTmJSF11Agng
 LOL1LRGKbE/SOU/f3unqo1FI1haRJebsP19YSoUQ7AbolzY/GArcxCWY/bS4LCxZK17RxtkjP
 iN1aeoKUSlePUjJyWUfjLmy85uz3Zpjw72jkYSHwaVgq/JzMnCva0l/GmdzqQ8pz9TXA4iBy5
 S9abYEEAAQ1drtByAs5/7JyF+GPrCeQF4ICncxFTLYq2fLBiZqXDjCoErBu4Lg9KZ3Qfs10ph
 G0CpBEHZoO3rVhPjZV3wYRT0UCE0UHHjDQiovR9k/JGOmkWLSLV5NVsQ5W/0uUBa8uFAyq061
 m9CPZ9nr+km5/uvdXgMRqhd/FVnGpc4Iw6jiV5sKz2FmDGJ7L0CgaOO0v+GU9ig1iPP0TyA82
 VNSDLz7wvaTG9DhxC0PyF7hm/utJiogfw0zZG4CrcpZ3hc9qQ+ODFdxM4CHzYG/DcHNLHnynT
 pV+CFrjQ6tKnmSxPI7IMTtesOgyRBLQXLBQTpq7TKAt+ZevpELpoDUNxX+qfadx1XwusMx3+c
 db21fYB2Sbf/evmn6b2C5ZP+RHeZnQVJu/qrvrcVOAP4eLulGlDS/toCCPLL5Xx56jwT7q4tz
 VFq/eEl+7wmWM9IgVuz41+kIJWtrqn3gd3VsD0DKsSBwCHABANw5xnF7i5Ab49sa5qWMzF7mf
 1Jokokh
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index 59a3c37..1f4d954 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) [--use-path=<path>] <object>
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
index 5ff58b3..5f91cf4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -17,6 +17,7 @@ struct batch_options {
 	int print_contents;
 	int buffer_output;
 	int all_objects;
+	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
 	const char *format;
 };
 
@@ -281,7 +282,32 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
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
@@ -418,6 +444,8 @@ static int batch_objects(struct batch_options *opt)
 	data.mark_query = 1;
 	strbuf_expand(&buf, opt->format, expand_format, &data);
 	data.mark_query = 0;
+	if (opt->cmdmode)
+		data.split_on_whitespace = 1;
 
 	if (opt->all_objects) {
 		struct object_info empty;
@@ -483,7 +511,7 @@ static int batch_objects(struct batch_options *opt)
 
 static const char * const cat_file_usage[] = {
 	N_("git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|-p|<type>|--textconv|--filters) [--use-path=<path>] <object>"),
-	N_("git cat-file (--batch | --batch-check) [--follow-symlinks]"),
+	N_("git cat-file (--batch | --batch-check) [--follow-symlinks] [--textconv|--filters]"),
 	NULL
 };
 
@@ -554,7 +582,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
 
 	if (opt) {
-		if (argc == 1)
+		if (batch.enabled && (opt == 'c' || opt == 'w'))
+			batch.cmdmode = opt;
+		else if (argc == 1)
 			obj_name = argv[0];
 		else
 			usage_with_options(cat_file_usage, options);
@@ -566,8 +596,12 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
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
@@ -579,6 +613,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		usage_with_options(cat_file_usage, options);
 	}
 
+	if (force_path && batch.enabled) {
+		error("--use-path=<path> incompatible with --batch");
+		usage_with_options(cat_file_usage, options);
+	}
+
 	if (batch.buffer_output < 0)
 		batch.buffer_output = batch.all_objects;
 
diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
index fd17159..89ae868 100755
--- a/t/t8010-cat-file-filters.sh
+++ b/t/t8010-cat-file-filters.sh
@@ -44,4 +44,14 @@ test_expect_success 'cat-file --textconv --use-path=<path> works' '
 	test uryyb = "$(cat rot13 | remove_cr)"
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
2.9.2.691.g78954f3
