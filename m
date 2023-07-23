Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2764AC001DF
	for <git@archiver.kernel.org>; Sun, 23 Jul 2023 16:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGWQ2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jul 2023 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjGWQ2k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2023 12:28:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E1419AB
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 09:28:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb84194bf3so5683125ad.3
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690129670; x=1690734470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3E+uPQlt5WXLywX6gHCcy5eVQoFrKq3LnVAu2txUzA=;
        b=nKpwtTtwSQ4YuBmR2BxUCoUew+KuYZzZZVG9O2c+Lcw99hFK7+JIgf4Dgdvi0c1fQI
         XVkU6M0pqEUWjHLw8x/ypza1I8N0A4c33jhfew23az5UGyJQSimRB7Xn3lJpK6biaatf
         2r+ypzFlzNqpCKjZwd4GH6SF4nfoG/dX2IiUD6/GFTsvsE/qRzBipcNantUdzX7l5X30
         Jzeo5Z/dHjYPTqdj/quOj+k5jDiBvxMBToCZZThatwsI+WP3dNSmeo/uuVwnwmnIxKQQ
         6qNHoDzDBg52vMFscYSxzhvDJUOgwVwt46hm+T9/Q7fUVn7ihcLWs9lcIXUPKUb61caU
         QCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690129670; x=1690734470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3E+uPQlt5WXLywX6gHCcy5eVQoFrKq3LnVAu2txUzA=;
        b=JB2NhNZ+DEwXmwvMxMqBq+h+b6KwmHmiJnL8ZPoT0rp6LGysPX6bec8zVBbBPolFGe
         iUhWUmIGTqxZdEDkIBCD5BjyWW7FBgv/GMYVkG6KS/fvm9uBCGUnplG5YtHqcwUZQfuC
         K3RaaEnHvkg1mxxLy/2HZNA3dTgVTRQJSYcO5txlFl48ANTPKsAHDyecxq/HMBs3/MHD
         SGGH41qykB7Yysffds2ucWMsZ0L9neUvPdcw1wqrtacM9io7bo5KjNMGPEQiXYteYW/k
         Sp1uo8h5fAeFWpmlLdNHkBRzWvNGOQcBkMyWu5QYEO3ZbZGnmKSKcJ/P0m0Bi1bcTuRv
         HTfg==
X-Gm-Message-State: ABy/qLaxd0bYBgQX63K9ERv8EOZdbcHLjXU8eNjxve53MX86jiIageQ3
        uTcAA7VFUWWnABql1q3xa2IYfopMWX8MI3Fp
X-Google-Smtp-Source: APBJJlEALr11BzHw5zMkOWE6MT2JBqs8Gsm0ZOLG+VXEeKZymKV9iiXehSHkQ1LUzdhsApod46h6XQ==
X-Received: by 2002:a17:902:b708:b0:1bb:a125:f831 with SMTP id d8-20020a170902b70800b001bba125f831mr1134897pls.58.1690129669813;
        Sun, 23 Jul 2023 09:27:49 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.157.197])
        by smtp.gmail.com with ESMTPSA id ju4-20020a170903428400b001b392bf9192sm7121847plb.145.2023.07.23.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:27:49 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v4 2/2] ref-filter: add new "describe" atom
Date:   Sun, 23 Jul 2023 21:49:59 +0530
Message-ID: <20230723162717.68123-3-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.396.g9ab76b0018
In-Reply-To: <20230723162717.68123-1-five231003@gmail.com>
References: <20230719162424.70781-1-five231003@gmail.com>
 <20230723162717.68123-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duplicate the logic of %(describe) and friends from pretty to
ref-filter. In the future, this change helps in unifying both the
formats as ref-filter will be able to do everything that pretty is doing
and we can have a single interface.

The new atom "describe" and its friends are equivalent to the existing
pretty formats with the same name.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 Documentation/git-for-each-ref.txt |  23 +++++
 ref-filter.c                       | 125 ++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 138 +++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d9588767a9..11b2bc3121 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -264,6 +264,29 @@ ahead-behind:<committish>::
 	commits ahead and behind, respectively, when comparing the output
 	ref to the `<committish>` specified in the format.
 
+describe[:options]::
+	A human-readable name, like linkgit:git-describe[1];
+	empty string for undescribable commits. The `describe` string may
+	be followed by a colon and one or more comma-separated options.
++
+--
+tags=<bool-value>;;
+	Instead of only considering annotated tags, consider
+	lightweight tags as well; see the corresponding option in
+	linkgit:git-describe[1] for details.
+abbrev=<number>;;
+	Use at least <number> hexadecimal digits; see the corresponding
+	option in linkgit:git-describe[1] for details.
+match=<pattern>;;
+	Only consider tags matching the given `glob(7)` pattern,
+	excluding the "refs/tags/" prefix; see the corresponding option
+	in linkgit:git-describe[1] for details.
+exclude=<pattern>;;
+	Do not consider tags matching the given `glob(7)` pattern,
+	excluding the "refs/tags/" prefix; see the corresponding option
+	in linkgit:git-describe[1] for details.
+--
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 8d5f85e0a7..df00f1628c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -5,6 +5,7 @@
 #include "gpg-interface.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "run-command.h"
 #include "refs.h"
 #include "wildmatch.h"
 #include "object-name.h"
@@ -146,6 +147,7 @@ enum atom_type {
 	ATOM_TAGGERDATE,
 	ATOM_CREATOR,
 	ATOM_CREATORDATE,
+	ATOM_DESCRIBE,
 	ATOM_SUBJECT,
 	ATOM_BODY,
 	ATOM_TRAILERS,
@@ -220,6 +222,7 @@ static struct used_atom {
 			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
 			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
 		} signature;
+		const char **describe_args;
 		struct refname_atom refname;
 		char *head;
 	} u;
@@ -600,6 +603,87 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 	return 0;
 }
 
+static int describe_atom_option_parser(struct strvec *args, const char **arg,
+				       struct strbuf *err)
+{
+	const char *argval;
+	size_t arglen = 0;
+	int optval = 0;
+
+	if (match_atom_bool_arg(*arg, "tags", arg, &optval)) {
+		if (!optval)
+			strvec_push(args, "--no-tags");
+		else
+			strvec_push(args, "--tags");
+		return 1;
+	}
+
+	if (match_atom_arg_value(*arg, "abbrev", arg, &argval, &arglen)) {
+		char *endptr;
+
+		if (!arglen)
+			return strbuf_addf_ret(err, -1,
+					       _("argument expected for %s"),
+					       "describe:abbrev");
+		if (strtol(argval, &endptr, 10) < 0)
+			return strbuf_addf_ret(err, -1,
+					       _("positive value expected %s=%s"),
+					       "describe:abbrev", argval);
+		if (endptr - argval != arglen)
+			return strbuf_addf_ret(err, -1,
+					       _("cannot fully parse %s=%s"),
+					       "describe:abbrev", argval);
+
+		strvec_pushf(args, "--abbrev=%.*s", (int)arglen, argval);
+		return 1;
+	}
+
+	if (match_atom_arg_value(*arg, "match", arg, &argval, &arglen)) {
+		if (!arglen)
+			return strbuf_addf_ret(err, -1,
+					       _("value expected %s="),
+					       "describe:match");
+
+		strvec_pushf(args, "--match=%.*s", (int)arglen, argval);
+		return 1;
+	}
+
+	if (match_atom_arg_value(*arg, "exclude", arg, &argval, &arglen)) {
+		if (!arglen)
+			return strbuf_addf_ret(err, -1,
+					       _("value expected %s="),
+					       "describe:exclude");
+
+		strvec_pushf(args, "--exclude=%.*s", (int)arglen, argval);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int describe_atom_parser(struct ref_format *format UNUSED,
+				struct used_atom *atom,
+				const char *arg, struct strbuf *err)
+{
+	struct strvec args = STRVEC_INIT;
+
+	for (;;) {
+		int found = 0;
+		const char *bad_arg = arg;
+
+		if (!arg || !*arg)
+			break;
+
+		found = describe_atom_option_parser(&args, &arg, err);
+		if (found < 0)
+			return found;
+		if (!found)
+			return err_bad_arg(err, "describe", bad_arg);
+	}
+	atom->u.describe_args = strvec_detach(&args);
+	return 0;
+}
+
 static int raw_atom_parser(struct ref_format *format UNUSED,
 			   struct used_atom *atom,
 			   const char *arg, struct strbuf *err)
@@ -802,6 +886,7 @@ static struct {
 	[ATOM_TAGGERDATE] = { "taggerdate", SOURCE_OBJ, FIELD_TIME },
 	[ATOM_CREATOR] = { "creator", SOURCE_OBJ },
 	[ATOM_CREATORDATE] = { "creatordate", SOURCE_OBJ, FIELD_TIME },
+	[ATOM_DESCRIBE] = { "describe", SOURCE_OBJ, FIELD_STR, describe_atom_parser },
 	[ATOM_SUBJECT] = { "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
 	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
 	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
@@ -1708,6 +1793,44 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 	}
 }
 
+static void grab_describe_values(struct atom_value *val, int deref,
+				 struct object *obj)
+{
+	struct commit *commit = (struct commit *)obj;
+	int i;
+
+	for (i = 0; i < used_atom_cnt; i++) {
+		struct used_atom *atom = &used_atom[i];
+		enum atom_type type = atom->atom_type;
+		const char *name = atom->name;
+		struct atom_value *v = &val[i];
+
+		struct child_process cmd = CHILD_PROCESS_INIT;
+		struct strbuf out = STRBUF_INIT;
+		struct strbuf err = STRBUF_INIT;
+
+		if (type != ATOM_DESCRIBE)
+			continue;
+
+		if (!!deref != (*name == '*'))
+			continue;
+
+		cmd.git_cmd = 1;
+		strvec_push(&cmd.args, "describe");
+		strvec_pushv(&cmd.args, atom->u.describe_args);
+		strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
+		if (pipe_command(&cmd, NULL, 0, &out, 0, &err, 0) < 0) {
+			error(_("failed to run 'describe'"));
+			v->s = xstrdup("");
+			continue;
+		}
+		strbuf_rtrim(&out);
+		v->s = strbuf_detach(&out, NULL);
+
+		strbuf_release(&err);
+	}
+}
+
 /* See grab_values */
 static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
 {
@@ -1817,6 +1940,7 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_tag_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, data);
 		grab_person("tagger", val, deref, buf);
+		grab_describe_values(val, deref, obj);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
@@ -1824,6 +1948,7 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		grab_signature(val, deref, obj);
+		grab_describe_values(val, deref, obj);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 910bf1ea94..7116e008f4 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -597,6 +597,144 @@ test_expect_success 'color.ui=always does not override tty check' '
 	test_cmp expected.bare actual
 '
 
+test_expect_success 'setup for describe atom tests' '
+	git init -b master describe-repo &&
+	(
+		cd describe-repo &&
+
+		test_commit --no-tag one &&
+		git tag tagone &&
+
+		test_commit --no-tag two &&
+		git tag -a -m "tag two" tagtwo
+	)
+'
+
+test_expect_success 'describe atom vs git describe' '
+	(
+		cd describe-repo &&
+
+		git for-each-ref --format="%(objectname)" \
+			refs/tags/ >obj &&
+		while read hash
+		do
+			if desc=$(git describe $hash)
+			then
+				: >expect-contains-good
+			else
+				: >expect-contains-bad
+			fi &&
+			echo "$hash $desc" || return 1
+		done <obj >expect &&
+		test_path_exists expect-contains-good &&
+		test_path_exists expect-contains-bad &&
+
+		git for-each-ref --format="%(objectname) %(describe)" \
+			refs/tags/ >actual 2>err &&
+		test_cmp expect actual &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success 'describe:tags vs describe --tags' '
+	(
+		cd describe-repo &&
+		git describe --tags >expect &&
+		git for-each-ref --format="%(describe:tags)" \
+				refs/heads/master >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'describe:abbrev=... vs describe --abbrev=...' '
+	(
+		cd describe-repo &&
+
+		# Case 1: We have commits between HEAD and the most
+		#	  recent tag reachable from it
+		test_commit --no-tag file &&
+		git describe --abbrev=14 >expect &&
+		git for-each-ref --format="%(describe:abbrev=14)" \
+			refs/heads/master >actual &&
+		test_cmp expect actual &&
+
+		# Make sure the hash used is atleast 14 digits long
+		sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
+		test 15 -le $(wc -c <hexpart) &&
+
+		# Case 2: We have a tag at HEAD, describe directly gives
+		#	  the name of the tag
+		git tag -a -m tagged tagname &&
+		git describe --abbrev=14 >expect &&
+		git for-each-ref --format="%(describe:abbrev=14)" \
+			refs/heads/master >actual &&
+		test_cmp expect actual &&
+		test tagname = $(cat actual)
+	)
+'
+
+test_expect_success 'describe:match=... vs describe --match ...' '
+	(
+		cd describe-repo &&
+		git tag -a -m "tag foo" tag-foo &&
+		git describe --match "*-foo" >expect &&
+		git for-each-ref --format="%(describe:match="*-foo")" \
+			refs/heads/master >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'describe:exclude:... vs describe --exclude ...' '
+	(
+		cd describe-repo &&
+		git tag -a -m "tag bar" tag-bar &&
+		git describe --exclude "*-bar" >expect &&
+		git for-each-ref --format="%(describe:exclude="*-bar")" \
+			refs/heads/master >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'deref with describe atom' '
+	(
+		cd describe-repo &&
+		cat >expect <<-\EOF &&
+
+		tagname
+		tagname
+		tagname
+
+		tagtwo
+		EOF
+		git for-each-ref --format="%(*describe)" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'err on bad describe atom arg' '
+	(
+		cd describe-repo &&
+
+		# The bad arg is the only arg passed to describe atom
+		cat >expect <<-\EOF &&
+		fatal: unrecognized %(describe) argument: baz
+		EOF
+		! git for-each-ref --format="%(describe:baz)" \
+			refs/heads/master 2>actual &&
+		test_cmp expect actual &&
+
+		# The bad arg is in the middle of the option string
+		# passed to the describe atom
+		cat >expect <<-\EOF &&
+		fatal: unrecognized %(describe) argument: qux=1,abbrev=14
+		EOF
+		! git for-each-ref \
+			--format="%(describe:tags,qux=1,abbrev=14)" \
+			ref/heads/master 2>actual &&
+		test_cmp expect actual
+	)
+'
+
 cat >expected <<\EOF
 heads/main
 tags/main
-- 
2.41.0.396.g9ab76b0018

