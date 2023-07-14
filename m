Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAC4EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 19:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbjGNTn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 15:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbjGNTnU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 15:43:20 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823023A9B
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 12:43:15 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a36b309524so1913085b6e.3
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689363794; x=1691955794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZkf/NEKqUKsiMxRSMp0Ms6SotAxy2FH1lU5fJeVuDQ=;
        b=Ds/uTgKHNL3jCrWpJyJpIjt8qKGP73JXjiJe/JowmcmYnIPQCTk/84qeUBSm7HbYtw
         Mqk3XxYRhZiR/BkwkeOZLy/mjmmV9Ri+OYoBezgO9E+Vr7469QkOruqzODM9i9KluGEg
         +rK/KsjAA74ierb7zvy1P8NR17blO+gQFfyGA4GMtkx2AGwdMLIPa7WVXMX/nd1/GcLa
         FSYVmeLyA+5JriJLmZy0axb9kynAbc9DmVNyaYqqltzIsn8dgrbTDzuoVQIzkyAqBMPv
         yL5fYCh8uqVwrOINtvrtdpfr6GyF3OhhuNhMADUNapU+PWC7zszUKS96Zba3l75mz47T
         c+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689363794; x=1691955794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZkf/NEKqUKsiMxRSMp0Ms6SotAxy2FH1lU5fJeVuDQ=;
        b=RSebeE8+25Pky+/x+DfaZxn0oFqfNaW+TGU4DRFNPjI11u2LolJX9/ftrdBJ927M4J
         UEGyuVChIC1flVAdRCfbwSKqom0IG+cmR6Uud6PDY52iInrszItXAD6kZK1f30yulugY
         1f6jn3tVdOsd7m7/cTZ609hrApUg5XT8etVtONX1du0gIlzVM4RtThdyRF1oB1OC3uqM
         acI2K36MNyd9xVhyPl3f2f+Psg1GhYB8YRIVd6jVTZUpFRx55ELY0k9ZIvwyflOmXMPj
         oWyELixr9EsPtpiOQDTGgc1RJxAA3sbE7xOz6SeZ4zn93pn5kGhhyRrxyxu8MAkYBo4W
         lpbA==
X-Gm-Message-State: ABy/qLYXBokQjkxy0kH9F0glMC/Bw2XhbXkxhQs/2vNg3tg5lVxDr/NI
        wzxHsj6oT5d1xAi8QYX4HThgYReMiUY=
X-Google-Smtp-Source: APBJJlEEvyGFP2mTuUmJBhG4rK80qiCLL+OFDjXmR65Nu6+14Sut7n9w4HQgpSgiMqiIiFsc1qlS4g==
X-Received: by 2002:aca:b946:0:b0:3a1:dc7e:bb39 with SMTP id j67-20020acab946000000b003a1dc7ebb39mr5986765oif.18.1689363794401;
        Fri, 14 Jul 2023 12:43:14 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.159.128])
        by smtp.gmail.com with ESMTPSA id u63-20020a17090a51c500b00260a5ecd273sm1514820pjh.1.2023.07.14.12.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 12:43:14 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH v2 2/3] ref-filter: add new "describe" atom
Date:   Sat, 15 Jul 2023 00:50:27 +0530
Message-ID: <20230714194249.66862-3-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.29.g8148156d44.dirty
In-Reply-To: <20230714194249.66862-1-five231003@gmail.com>
References: <20230705175942.21090-1-five231003@gmail.com>
 <20230714194249.66862-1-five231003@gmail.com>
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

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 Documentation/git-for-each-ref.txt |  23 +++++
 ref-filter.c                       | 147 +++++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            |  85 +++++++++++++++++
 3 files changed, 255 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 1e215d4e73..2a44119f38 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -231,6 +231,29 @@ ahead-behind:<committish>::
 	commits ahead and behind, respectively, when comparing the output
 	ref to the `<committish>` specified in the format.
 
+describe[:options]:: Human-readable name, like
+		     link-git:git-describe[1]; empty string for
+		     undescribable commits. The `describe` string may be
+		     followed by a colon and zero or more comma-separated
+		     options. Descriptions can be inconsistent when tags
+		     are added or removed at the same time.
++
+--
+tags=<bool-value>;; Instead of only considering annotated tags, consider
+		    lightweight tags as well; see the corresponding option
+		    in linkgit:git-describe[1] for details.
+abbrev=<number>;; Use at least <number> hexadecimal digits; see
+		  the corresponding option in linkgit:git-describe[1]
+		  for details.
+match=<pattern>;; Only consider tags matching the given `glob(7)` pattern,
+		  excluding the "refs/tags/" prefix; see the corresponding
+		  option in linkgit:git-describe[1] for details.
+exclude=<pattern>;; Do not consider tags matching the given `glob(7)`
+		    pattern, excluding the "refs/tags/" prefix; see the
+		    corresponding option in linkgit:git-describe[1] for
+		    details.
+--
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index b170994d9d..fe4830dbea 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2,9 +2,11 @@
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
+#include "config.h"
 #include "gpg-interface.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "run-command.h"
 #include "refs.h"
 #include "wildmatch.h"
 #include "object-name.h"
@@ -146,6 +148,7 @@ enum atom_type {
 	ATOM_TAGGERDATE,
 	ATOM_CREATOR,
 	ATOM_CREATORDATE,
+	ATOM_DESCRIBE,
 	ATOM_SUBJECT,
 	ATOM_BODY,
 	ATOM_TRAILERS,
@@ -215,6 +218,11 @@ static struct used_atom {
 		struct email_option {
 			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
 		} email_option;
+		struct {
+			enum { D_BARE, D_TAGS, D_ABBREV,
+			       D_EXCLUDE, D_MATCH } option;
+			const char **args;
+		} describe;
 		struct refname_atom refname;
 		char *head;
 	} u;
@@ -521,6 +529,94 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 	return 0;
 }
 
+static int describe_atom_parser(struct ref_format *format UNUSED,
+				struct used_atom *atom,
+				const char *arg, struct strbuf *err)
+{
+	const char *describe_opts[] = {
+		"",
+		"tags",
+		"abbrev",
+		"match",
+		"exclude",
+		NULL
+	};
+
+	struct strvec args = STRVEC_INIT;
+	for (;;) {
+		int found = 0;
+		const char *argval;
+		size_t arglen = 0;
+		int optval = 0;
+		int opt;
+
+		if (!arg)
+			break;
+
+		for (opt = D_BARE; !found && describe_opts[opt]; opt++) {
+			switch(opt) {
+			case D_BARE:
+				/*
+				 * Do nothing. This is the bare describe
+				 * atom and we already handle this above.
+				 */
+				break;
+			case D_TAGS:
+				if (match_atom_bool_arg(arg, describe_opts[opt],
+							&arg, &optval)) {
+					if (!optval)
+						strvec_pushf(&args, "--no-%s",
+							     describe_opts[opt]);
+					else
+						strvec_pushf(&args, "--%s",
+							     describe_opts[opt]);
+					found = 1;
+				}
+				break;
+			case D_ABBREV:
+				if (match_atom_arg_value(arg, describe_opts[opt],
+							 &arg, &argval, &arglen)) {
+					char *endptr;
+					int ret = 0;
+
+					if (!arglen)
+						ret = -1;
+					if (strtol(argval, &endptr, 10) < 0)
+						ret = -1;
+					if (endptr - argval != arglen)
+						ret = -1;
+
+					if (ret)
+						return strbuf_addf_ret(err, ret,
+								_("positive value expected describe:abbrev=%s"), argval);
+					strvec_pushf(&args, "--%s=%.*s",
+						     describe_opts[opt],
+						     (int)arglen, argval);
+					found = 1;
+				}
+				break;
+			case D_MATCH:
+			case D_EXCLUDE:
+				if (match_atom_arg_value(arg, describe_opts[opt],
+							 &arg, &argval, &arglen)) {
+					if (!arglen)
+						return strbuf_addf_ret(err, -1,
+								_("value expected describe:%s="), describe_opts[opt]);
+					strvec_pushf(&args, "--%s=%.*s",
+						     describe_opts[opt],
+						     (int)arglen, argval);
+					found = 1;
+				}
+				break;
+			}
+		}
+		if (!found)
+			break;
+	}
+	atom->u.describe.args = strvec_detach(&args);
+	return 0;
+}
+
 static int raw_atom_parser(struct ref_format *format UNUSED,
 			   struct used_atom *atom,
 			   const char *arg, struct strbuf *err)
@@ -723,6 +819,7 @@ static struct {
 	[ATOM_TAGGERDATE] = { "taggerdate", SOURCE_OBJ, FIELD_TIME },
 	[ATOM_CREATOR] = { "creator", SOURCE_OBJ },
 	[ATOM_CREATORDATE] = { "creatordate", SOURCE_OBJ, FIELD_TIME },
+	[ATOM_DESCRIBE] = { "describe", SOURCE_OBJ, FIELD_STR, describe_atom_parser },
 	[ATOM_SUBJECT] = { "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
 	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
 	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
@@ -1542,6 +1639,54 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
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
+		if (deref)
+			name++;
+
+		if (!skip_prefix(name, "describe", &name) ||
+		    (*name && *name != ':'))
+			    continue;
+		if (!*name)
+			name = NULL;
+		else
+			name++;
+
+		cmd.git_cmd = 1;
+		strvec_push(&cmd.args, "describe");
+		strvec_pushv(&cmd.args, atom->u.describe.args);
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
@@ -1651,12 +1796,14 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_tag_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, data);
 		grab_person("tagger", val, deref, buf);
+		grab_describe_values(val, deref, obj);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, data);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
+		grab_describe_values(val, deref, obj);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5c00607608..98ea37d336 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -561,6 +561,91 @@ test_expect_success 'color.ui=always does not override tty check' '
 	test_cmp expected.bare actual
 '
 
+test_expect_success 'describe atom vs git describe' '
+	test_when_finished "rm -rf describe-repo" &&
+
+	git init describe-repo &&
+	(
+		cd describe-repo &&
+
+		test_commit --no-tag one &&
+		git tag tagone &&
+
+		test_commit --no-tag two &&
+		git tag -a -m "tag two" tagtwo &&
+
+		git for-each-ref refs/tags/ --format="%(objectname)" >obj &&
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
+	test_when_finished "git tag -d tagname" &&
+	git tag tagname &&
+	git describe --tags >expect &&
+	git for-each-ref --format="%(describe:tags)" refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'describe:abbrev=... vs describe --abbrev=...' '
+	test_when_finished "git tag -d tagname" &&
+
+	# Case 1: We have commits between HEAD and the most
+	#         recent tag reachable from it
+	test_commit --no-tag file &&
+	git describe --abbrev=14 >expect &&
+	git for-each-ref --format="%(describe:abbrev=14)" \
+		refs/heads/ >actual &&
+	test_cmp expect actual &&
+
+	# Make sure the hash used is atleast 14 digits long
+	sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
+	test 15 -le $(wc -c <hexpart) &&
+
+	# Case 2: We have a tag at HEAD, describe directly gives
+	#         the name of the tag
+	git tag -a -m tagged tagname &&
+	git describe --abbrev=14 >expect &&
+	git for-each-ref --format="%(describe:abbrev=14)" \
+		refs/heads/ >actual &&
+	test_cmp expect actual &&
+	test tagname = $(cat actual)
+'
+
+test_expect_success 'describe:match=... vs describe --match ...' '
+	test_when_finished "git tag -d tag-match" &&
+	git tag -a -m "tag match" tag-match &&
+	git describe --match "*-match" >expect &&
+	git for-each-ref --format="%(describe:match="*-match")" \
+		refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'describe:exclude:... vs describe --exclude ...' '
+	test_when_finished "git tag -d tag-exclude" &&
+	git tag -a -m "tag exclude" tag-exclude &&
+	git describe --exclude "*-exclude" >expect &&
+	git for-each-ref --format="%(describe:exclude="*-exclude")" \
+		refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
 cat >expected <<\EOF
 heads/main
 tags/main
-- 
2.41.0.321.g26b82700c0.dirty

