Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B1C1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 12:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755021AbcHXMYf (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 08:24:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:63679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754246AbcHXMX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 08:23:59 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MF4eJ-1bNRCh3vpL-00GMKh; Wed, 24 Aug 2016 14:23:41
 +0200
Date:   Wed, 24 Aug 2016 14:23:39 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 2/4] cat-file: introduce the --filters option
In-Reply-To: <cover.1472041389.git.johannes.schindelin@gmx.de>
Message-ID: <320f5e862e8df12bbd1d918f0b347aeacbd25d17.1472041389.git.johannes.schindelin@gmx.de>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <cover.1472041389.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4/9MMHvn+XGPDRyIWqHgw2XuCiuGEQq6Pn+6gt0C1vswUKVis33
 U0q6r7qOCM2NrI/ubZl/+5W3kdAaAvu67ZvDi/tnQ8Ws3h08i0GxDgWkZWrj5yT9ScfQTd2
 ovY/G8b1JwzkDaglTV0c25PsfUarhR15y2fhcuw1CPqC906v4qbvmNG23d6bYv6l+QrT9xN
 cF4oONBzS+lLbIEUQOkiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vr69btTYRNA=:Og/WqbAO8BHs7nsakQ/kfz
 El7eOuNq0QjlBouMtTucoQFMFAFF1ChATXg36d5iRNbDTOg6NLHYnmadCUW070ZmsHZ4xE8M9
 rc57Gnv6qH+WkPu59SHOXUruIjQ56vDJPekE5EMyqqRs06Zqvguq/2TPMi530ZRN1UVK7wnZ6
 1VnOGRPdoXTQliWhPI2+yQMyiYC1AP+jNjRNXSA8VmtTsBUcvLReoUrlYnornuul8mIaxi0be
 ZnKuabogv0RVWHZgJGAbCnZjCcs7xKvVFxVPBq+gajOgOaX9dKMU5+KuLipIEHtG7yWpOCNKt
 W5Jbvwkjuk+b3xVefxgWb7fpFgG/k6KG7in2rr8j0Qj1VQnLzUmzbXNXnCN4qcHeMr1GJTI+Z
 lmPHB8HhcsbjgvIUYopr3PE1rkMSgXdOhBvDhbp70c/N6QZSxX+BysZyc/YthsYEhUI5v+zx+
 /HvRFYLJZRRu7FiRcyXYrvtgBF1Ckx6HEHGiKjDttJDqY86Z872io70RSM+morpj1IeMBMI1n
 OCHhyK90WbXanqHxM9+zkqLjwMcpAd3ygTv75G5kLFY2bSdQEsDyG0LEzDWwNwO54/hCH7K4f
 ADnyrnieCiQGhuuphm7KfN+w7wkLPX4GISiFfq9v+OUmz16IkgLaVsaxnXNfibIWTrNr+UOqo
 /H8E+Aykgy+SMRfTndGJlC77pImpNpsQ3prNHfvzn36cJLoIgw21dgQ5mlKtfOXHKvxy2jnQD
 u+4+0zWZo+c4IiXHbn7Tz5MqKx/kU5xrzqfZGbx3QtRdTZJHxZwqernQra86GMgwwz7WlZUCc
 gV1EnXA
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
2.10.0.rc1.99.gcd66998


