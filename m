Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09463C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0ED6613F1
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 09:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhFEJPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 05:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhFEJPn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 05:15:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67114C061767
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 02:13:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p13-20020a05600c358db029019f44afc845so6862657wmq.3
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KG7cQO1/o3dNqs+M6tO02GSsP9hxaIQYD/ebElC/0mY=;
        b=tIBuT76zplX0ny6TcbBVcRRLPMumB1w+2jEv+PsipLaX2fnOJu5H3g9nsCexb0dkB1
         NH4HJMB/BMS8nVJLuSeFc7RueCivIomOBINyhM41FuqGw8v8X3VjZBDzvskwW2d8VpC+
         bpJmE7ZnFiTL3B9vNOIh4m6rRslzx9XOOz3ia4yf0WNypbMBuZ3Ei55/p1y7dDTJzIUI
         3aC3NIDEk2vEsPO+hh63iTIOSZcJbisjW50VtGHzAWLkAuPIuVPlWqpHjIybLVD+ADKp
         UMQz+mKnXEpxgLjV4g+EPfHO5MjTbn1+M/3bmS2VjEvInQRfrg43PCe7rIwrhgngfHlJ
         Sufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KG7cQO1/o3dNqs+M6tO02GSsP9hxaIQYD/ebElC/0mY=;
        b=l12UBXBx+t1NAXQ1EC85DrspSXWJ8Dfl2vAuOrUoYePhLeN/+UrekI2BM6YBxUL/Sc
         yxkUQMxtjMscB4DjzVbaFz43X3kXgya96Mza5pe4znAHqRZ2qRRqCZ8zH3cie5pSMamK
         OvPS4XQ+AMDE8a82XZzey/P8VkLbaXqzkzRVGFoC7KfeGxsxImxmg1LNZBlFBuuag4y0
         l/gXo/1iXsM6aTX996PQWJ2ZFPLiDW/nj8dfhV3NPyyDXMNXHpqmbZguusmX9LosGvuT
         D5FN2UA8EboFaeXgUFg3Xs0OU8M39ZISTAOG8a3ZWfW7Hm9XeuTweQhsGWJo29oJjh6q
         /N4g==
X-Gm-Message-State: AOAM5315mvywWspO3qRWrjuJHLk+Ic2kmeOq7Qtn1t4KzhOND2oHxPSU
        p9PnX4QGtNn0DTkWvH3blQk7jVCxO8U=
X-Google-Smtp-Source: ABdhPJxJnqkWzjWlCnEC43CU8M6wwUNjREYf3gfRrRqA+SQbNlkeqZkS54W7v88JMR6klbxaG3l3Og==
X-Received: by 2002:a7b:ce8a:: with SMTP id q10mr7501082wmj.184.1622884419997;
        Sat, 05 Jun 2021 02:13:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e17sm10177783wre.79.2021.06.05.02.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 02:13:39 -0700 (PDT)
Message-Id: <6170eb2fcac18d51a51c7f5f3890d004549812c9.1622884415.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.972.git.1622884415.gitgitgadget@gmail.com>
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Jun 2021 09:13:34 +0000
Subject: [PATCH 6/6] [GSOC] ref-filter: add %(raw:textconv) and %(raw:filters)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In order to let `git cat-file --batch --filter` and
`git cat-file --batch --textconv` use ref-filter
interface, `%(raw:textconv)` and `%(raw:filters)` are
added to ref-filter.

`--rest` contents is used as the `<path>` for them.

`%(raw:textconv)` can show the object' contents as transformed
by a textconv filter.

`%(raw:filters)` can show the content as converted by the filters
configured in the current working tree for the given `<path>`
(i.e. smudge filters, end-of-line conversion, etc).

In addition, they cannot be used with `--python`, `--tcl`,
`--shell`, `--perl`.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-for-each-ref.txt | 18 ++++++--
 builtin/for-each-ref.c             | 11 ++++-
 ref-filter.c                       | 68 ++++++++++++++++++++++++------
 t/t6300-for-each-ref.sh            | 63 +++++++++++++++++++++++++++
 4 files changed, 141 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e85b7b19a530..e49b8861f474 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -76,7 +76,8 @@ OPTIONS
 
 --rest=<rest>::
 	If given, the `%(rest)` placeholders in the `--format` option
-	will be replaced by its contents.
+	will be replaced by its contents. At the same time, its contents
+	is used as the `<path>` for `%(raw:textconv)` and `%(raw:filter)`.
 
 --merged[=<object>]::
 	Only list refs whose tips are reachable from the
@@ -248,9 +249,18 @@ The raw data in a object is `raw`.
 raw:size::
 	The raw data size of the object.
 
-Note that `--format=%(raw)` can not be used with `--python`, `--shell`, `--tcl`,
-`--perl` because the host language may not support arbitrary binary data in the
-variables of its string type.
+raw:textconv::
+	Show the content as transformed by a textconv filter. It must be used
+	with `--rest`.
+
+raw:filters::
+	Show the content as converted by the filters configured in
+	the current working tree for the given `<path>` (i.e. smudge filters,
+	end-of-line conversion, etc). It must be used with `--rest`.
+
+Note that `--format=%(raw)`, `--format=%(raw:textconv)`, `--format=%(raw:filter)`
+can not be used with `--python`, `--shell`, `--tcl`, `--perl` because the host
+language may not support arbitrary binary data in the variables of its string type.
 
 The message in a commit or a tag object is `contents`, from which
 `contents:<part>` can be used to extract various parts out of:
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index fac7777fd2c0..4be5ddacbac1 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "parse-options.h"
 #include "ref-filter.h"
+#include "userdiff.h"
 
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
@@ -14,6 +15,14 @@ static char const * const for_each_ref_usage[] = {
 	NULL
 };
 
+static int git_for_each_ref_config(const char *var, const char *value, void *cb)
+{
+	if (userdiff_config(var, value) < 0)
+		return -1;
+
+	return git_default_config(var, value, cb);
+}
+
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -57,7 +66,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
 
-	git_config(git_default_config, NULL);
+	git_config(git_for_each_ref_config, NULL);
 
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
 	if (maxcount < 0) {
diff --git a/ref-filter.c b/ref-filter.c
index a859a94aa8e0..ae684924b363 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "cache.h"
 #include "parse-options.h"
@@ -192,7 +193,7 @@ static struct used_atom {
 			unsigned int nlines;
 		} contents;
 		struct {
-			enum { RAW_BARE, RAW_LENGTH } option;
+			enum { RAW_BARE, RAW_FILTERS, RAW_LENGTH, RAW_TEXT_CONV } option;
 		} raw_data;
 		struct {
 			cmp_status cmp_status;
@@ -434,12 +435,19 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 static int raw_atom_parser(struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
-	if (!arg)
+	if (!arg) {
 		atom->u.raw_data.option = RAW_BARE;
-	else if (!strcmp(arg, "size"))
+	} else if (!strcmp(arg, "size")) {
 		atom->u.raw_data.option = RAW_LENGTH;
-	else
+	} else if (!strcmp(arg, "filters")) {
+		atom->u.raw_data.option = RAW_FILTERS;
+		format->use_rest = 1;
+	} else if (!strcmp(arg, "textconv")) {
+		atom->u.raw_data.option = RAW_TEXT_CONV;
+		format->use_rest = 1;
+	} else {
 		return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) argument: %s"), arg);
+	}
 	return 0;
 }
 
@@ -1018,7 +1026,9 @@ int verify_ref_format(struct ref_format *format)
 		if (at < 0)
 			die("%s", err.buf);
 		if (format->quote_style && used_atom[at].atom_type == ATOM_RAW &&
-		    used_atom[at].u.raw_data.option == RAW_BARE)
+		    (used_atom[at].u.raw_data.option == RAW_BARE ||
+		     used_atom[at].u.raw_data.option == RAW_FILTERS ||
+		     used_atom[at].u.raw_data.option == RAW_TEXT_CONV))
 			die(_("--format=%.*s cannot be used with"
 			      "--python, --shell, --tcl, --perl"), (int)(ep - sp - 2), sp + 2);
 		cp = ep + 1;
@@ -1403,7 +1413,7 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static int grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data,
+static int grab_sub_body_contents(struct ref_array_item *ref, int deref, struct expand_data *data,
 				  struct strbuf *err)
 {
 	int i;
@@ -1411,6 +1421,7 @@ static int grab_sub_body_contents(struct atom_value *val, int deref, struct expa
 	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 	void *buf = data->content;
 	unsigned long buf_size = data->size;
+	struct atom_value *val = ref->value;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
@@ -1425,12 +1436,39 @@ static int grab_sub_body_contents(struct atom_value *val, int deref, struct expa
 
 		if (atom_type == ATOM_RAW) {
 			if (atom->u.raw_data.option == RAW_BARE) {
-				v->s = xmemdupz(buf, buf_size);
-				v->s_size = buf_size;
+				goto bare;
 			} else if (atom->u.raw_data.option == RAW_LENGTH) {
 				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);
+			} else if (atom->u.raw_data.option == RAW_FILTERS ||
+				   atom->u.raw_data.option == RAW_TEXT_CONV) {
+				if (!ref->rest)
+					return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
+							       oid_to_hex(&data->oid));
+				if (data->type != OBJ_BLOB)
+					goto bare;
+				if (atom->u.raw_data.option == RAW_FILTERS) {
+					struct strbuf strbuf = STRBUF_INIT;
+					struct checkout_metadata meta;
+
+					init_checkout_metadata(&meta, NULL, NULL, &data->oid);
+					if (convert_to_working_tree(&the_index, ref->rest, buf, data->size, &strbuf, &meta)) {
+						v->s_size = strbuf.len;
+						v->s = strbuf_detach(&strbuf, NULL);
+					} else {
+						goto bare;
+					}
+				} else if (atom->u.raw_data.option == RAW_TEXT_CONV) {
+					if (!textconv_object(the_repository,
+							ref->rest, 0100644, &data->oid,
+							1, (char **)(&v->s), &v->s_size))
+						goto bare;
+				}
 			}
 			continue;
+bare:
+			v->s = xmemdupz(buf, buf_size);
+			v->s_size = buf_size;
+			continue;
 		}
 
 		if ((data->type != OBJ_TAG &&
@@ -1503,33 +1541,35 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static int grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data, struct strbuf *err)
+static int grab_values(struct ref_array_item *ref, int deref, struct object *obj,
+		       struct expand_data *data, struct strbuf *err)
 {
 	void *buf = data->content;
+	struct atom_value *val = ref->value;
 	int ret = 0;
 
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
-		if ((ret = grab_sub_body_contents(val, deref, data, err)))
+		if ((ret = grab_sub_body_contents(ref, deref, data, err)))
 			return ret;
 		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		if ((ret = grab_sub_body_contents(val, deref, data, err)))
+		if ((ret = grab_sub_body_contents(ref, deref, data, err)))
 			return ret;
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
-		if ((ret = grab_sub_body_contents(val, deref, data, err)))
+		if ((ret = grab_sub_body_contents(ref, deref, data, err)))
 			return ret;
 		break;
 	case OBJ_BLOB:
 		/* grab_blob_values(val, deref, obj, buf, sz); */
-		if ((ret = grab_sub_body_contents(val, deref, data, err)))
+		if ((ret = grab_sub_body_contents(ref, deref, data, err)))
 			return ret;
 		break;
 	default:
@@ -1755,7 +1795,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		ret = grab_values(ref->value, deref, *obj, oi, err);
+		ret = grab_values(ref, deref, *obj, oi, err);
 	}
 
 	grab_common_values(ref->value, deref, oi);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e908b2ca0522..4ba2aa2dcd73 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1365,6 +1365,69 @@ test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ref-filter raw:textconv and raw:filter setup ' '
+	echo "*.txt eol=crlf diff=txt" >.gitattributes &&
+	echo "hello" | append_cr >world.txt &&
+	git add .gitattributes world.txt &&
+	test_tick &&
+	git commit -m "Initial commit" &&
+	git update-ref refs/myblobs/world_blob HEAD:world.txt
+'
+
+test_expect_success 'basic atom raw:filters with --rest' '
+	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
+	git for-each-ref --format="%(objectname) %(raw:filters)" --rest="HEAD:world.txt" \
+	    refs/myblobs/world_blob >actual &&
+	printf "%s hello\r\n\n" $sha1 >expect &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(objectname) %(raw:filters)" --rest="HEAD:world.txt2" \
+	    refs/myblobs/world_blob >actual &&
+	printf "%s hello\n\n" $sha1 >expect &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'basic atom raw:textconv with --rest' '
+	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
+	git -c diff.txt.textconv="tr A-Za-z N-ZA-Mn-za-m <" \
+	    for-each-ref --format="%(objectname) %(raw:textconv)" --rest="HEAD:world.txt" \
+	    refs/myblobs/world_blob >actual &&
+	printf "%s uryyb\r\n\n" $sha1 >expect &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(objectname) %(raw:textconv)" --rest="HEAD:world.txt2" \
+	    refs/myblobs/world_blob >actual &&
+	printf "%s hello\n\n" $sha1 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(raw:textconv) without --rest must failed' '
+	test_must_fail git for-each-ref --format="%(raw:textconv)"
+'
+
+test_expect_success '%(raw:filters) without --rest must failed' '
+	test_must_fail git for-each-ref --format="%(raw:filters)"
+'
+
+test_expect_success '%(raw:textconv) with --shell must failed' '
+	test_must_fail git for-each-ref --format="%(raw:textconv)" \
+			   --shell --rest="HEAD:world.txt"
+'
+
+test_expect_success '%(raw:filters) with --shell must failed' '
+	test_must_fail git for-each-ref --format="%(raw:filters)" \
+			   --shell --rest="HEAD:world.txt"
+'
+
+test_expect_success '%(raw:textconv) with --shell and --sort=raw:textconv must failed' '
+	test_must_fail git for-each-ref --format="%(raw:textconv)" \
+			   --sort=raw:textconv --shell --rest="HEAD:world.txt"
+'
+
+test_expect_success '%(raw:filters) with --shell and --sort=raw:filters must failed' '
+	test_must_fail git for-each-ref --format="%(raw:filters)" \
+			   --sort=raw:filters --shell --rest="HEAD:world.txt"
+'
+
 test_expect_success 'for-each-ref reports broken tags' '
 	git tag -m "good tag" broken-tag-good HEAD &&
 	git cat-file tag broken-tag-good >good &&
-- 
gitgitgadget
