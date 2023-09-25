Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B87FCE7AB1
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 17:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjIYRvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 13:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjIYRvU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 13:51:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B09C101
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 10:51:12 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5789de5c677so4475377a12.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695664272; x=1696269072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20JrfF5Rq2YDa8kuPhsPAwMs/inW5PWw9f09fCJQsMk=;
        b=QTkRe5amnIvhKZINbFLJCHLMSYdLGrkyF6qTDHnP5kH8ZEtevzOesP/a00VwJuIrhX
         4cvIZOirfb7DBO2ZsEvstZ6KILBWcyN+TeTbd5SIGu0oZcvyu5cSS+8z+KfYx8Iu1rH+
         NY9g1QBH8qj/U6O+m3yAAri6FtKTxbKgeLxtgYaFa+28VNA1vJv+eI285YG1MB+fR34J
         05o1+eFtcWmBN72hoWeylAH3zh+Qf0Y3DoUej4VTkpQjWqebDo5h8OlE7V6v/WkTa44N
         o3mVN/THU87QPK3rBuol8jzG7lZ5zwVVslMnmnJ+ZrFQ2E0onAa1/e/6BsZP64A/f5Rf
         Pkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664272; x=1696269072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20JrfF5Rq2YDa8kuPhsPAwMs/inW5PWw9f09fCJQsMk=;
        b=Jkrry9RywAnXVFL2oUUgaAJcP8/pqHT9cpMqwWTd0k0gGPEf+RQbrVR5qwKO4AaVRu
         4mIH8mPimQiqca1Va+SCs4z1WoF9MXUcBOUXt8G1KIB3wwEquLm0IM4u0tZMDaBwMpxj
         nvhZKKnp2Pjv9hn/bZWHbSoobg1/3eG062fiAwvPmKBoovO+5DDSMXKRilOs+9EEN0jO
         2BFUBqDTQZA+tShc3MtkmSNL59YkA7QzuTNWBlCWBls32kZbx8PTk+9JdjOSP13yUrDW
         YDekimON2bkd7Kx74kWrWuSi/2EKyDIz6OB4iLUetU9EY7iU544xCnUuWXj9M7TjElMs
         PsLg==
X-Gm-Message-State: AOJu0Yyiu8dGuuHSMsXK9oZJ6yMf2rpZypPxNlPqVeVkgU0WHlcGWyAK
        Pyeb1RAK/dHuyfJKv24hMKiKuapEUYg=
X-Google-Smtp-Source: AGHT+IFslqPPZ2KCSzyloYxF7l+rygXdSeLmPe+G+i75xRTMtii0W/i+7a7SET9jXjMDv8FgTvdBDQ==
X-Received: by 2002:a17:90a:728e:b0:274:6503:26d with SMTP id e14-20020a17090a728e00b002746503026dmr4888082pjg.33.1695664271522;
        Mon, 25 Sep 2023 10:51:11 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.157.220])
        by smtp.gmail.com with ESMTPSA id gw7-20020a17090b0a4700b00273f65fa424sm8417874pjb.8.2023.09.25.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:51:11 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH v2 3/3] ref-filter: add mailmap support
Date:   Mon, 25 Sep 2023 23:13:10 +0530
Message-ID: <20230925175050.3498-4-five231003@gmail.com>
X-Mailer: git-send-email 2.42.0.273.ge948a9aaf4
In-Reply-To: <20230925175050.3498-1-five231003@gmail.com>
References: <20230920191654.6133-1-five231003@gmail.com>
 <20230925175050.3498-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add mailmap support to ref-filter formats which are similar in
pretty. This support is such that the following pretty placeholders are
equivalent to the new ref-filter atoms:

	%aN = authorname:mailmap
	%cN = committername:mailmap

	%aE = authoremail:mailmap
	%aL = authoremail:mailmap,localpart
	%cE = committeremail:mailmap
	%cL = committeremail:mailmap,localpart

Additionally, mailmap can also be used with ":trim" option for email by
doing something like "authoremail:mailmap,trim".

The above also applies for the "tagger" atom, that is,
"taggername:mailmap", "taggeremail:mailmap", "taggeremail:mailmap,trim"
and "taggername:mailmap,localpart".

The functionality of ":trim" and ":localpart" remains the same. That is,
":trim" gives the email, but without the angle brackets and ":localpart"
gives the part of the email before the '@' character (if such a
character is not found then we directly grab everything between the
angle brackets).

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 Documentation/git-for-each-ref.txt |   6 +-
 ref-filter.c                       | 152 ++++++++++++++++++++++-------
 t/t6300-for-each-ref.sh            |  85 +++++++++++++++-
 3 files changed, 206 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 11b2bc3121..e86d5700dd 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -303,7 +303,11 @@ Fields that have name-email-date tuple as its value (`author`,
 and `date` to extract the named component.  For email fields (`authoremail`,
 `committeremail` and `taggeremail`), `:trim` can be appended to get the email
 without angle brackets, and `:localpart` to get the part before the `@` symbol
-out of the trimmed email.
+out of the trimmed email. In addition to these, the `:mailmap` option and the
+corresponding `:mailmap,trim` and `:mailmap,localpart` can be used (order does
+not matter) to get values of the name and email according to the .mailmap file
+or according to the file set in the mailmap.file or mailmap.blob configuration
+variable (see linkgit:gitmailmap[5]).
 
 The raw data in an object is `raw`.
 
diff --git a/ref-filter.c b/ref-filter.c
index fae9f4b8ed..e4d3510e28 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -13,6 +13,8 @@
 #include "oid-array.h"
 #include "repository.h"
 #include "commit.h"
+#include "mailmap.h"
+#include "ident.h"
 #include "remote.h"
 #include "color.h"
 #include "tag.h"
@@ -215,8 +217,16 @@ static struct used_atom {
 		struct {
 			enum { O_SIZE, O_SIZE_DISK } option;
 		} objectsize;
-		struct email_option {
-			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
+		struct {
+			enum { N_RAW, N_MAILMAP } option;
+		} name_option;
+		struct {
+			enum {
+				EO_RAW = 0,
+				EO_TRIM = 1<<0,
+				EO_LOCALPART = 1<<1,
+				EO_MAILMAP = 1<<2,
+			} option;
 		} email_option;
 		struct {
 			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
@@ -720,21 +730,55 @@ static int oid_atom_parser(struct ref_format *format UNUSED,
 	return 0;
 }
 
-static int person_email_atom_parser(struct ref_format *format UNUSED,
-				    struct used_atom *atom,
-				    const char *arg, struct strbuf *err)
+static int person_name_atom_parser(struct ref_format *format UNUSED,
+				   struct used_atom *atom,
+				   const char *arg, struct strbuf *err)
 {
 	if (!arg)
-		atom->u.email_option.option = EO_RAW;
-	else if (!strcmp(arg, "trim"))
-		atom->u.email_option.option = EO_TRIM;
-	else if (!strcmp(arg, "localpart"))
-		atom->u.email_option.option = EO_LOCALPART;
+		atom->u.name_option.option = N_RAW;
+	else if (!strcmp(arg, "mailmap"))
+		atom->u.name_option.option = N_MAILMAP;
 	else
 		return err_bad_arg(err, atom->name, arg);
 	return 0;
 }
 
+static int email_atom_option_parser(struct used_atom *atom,
+				    const char **arg, struct strbuf *err)
+{
+	if (!*arg)
+		return EO_RAW;
+	if (skip_prefix(*arg, "trim", arg))
+		return EO_TRIM;
+	if (skip_prefix(*arg, "localpart", arg))
+		return EO_LOCALPART;
+	if (skip_prefix(*arg, "mailmap", arg))
+		return EO_MAILMAP;
+	return -1;
+}
+
+static int person_email_atom_parser(struct ref_format *format UNUSED,
+				    struct used_atom *atom,
+				    const char *arg, struct strbuf *err)
+{
+	for (;;) {
+		int opt = email_atom_option_parser(atom, &arg, err);
+		const char *bad_arg = arg;
+
+		if (opt < 0)
+			return err_bad_arg(err, atom->name, bad_arg);
+		atom->u.email_option.option |= opt;
+
+		if (!arg || !*arg)
+			break;
+		if (*arg == ',')
+			arg++;
+		else
+			return err_bad_arg(err, atom->name, bad_arg);
+	}
+	return 0;
+}
+
 static int refname_atom_parser(struct ref_format *format UNUSED,
 			       struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
@@ -877,15 +921,15 @@ static struct {
 	[ATOM_TYPE] = { "type", SOURCE_OBJ },
 	[ATOM_TAG] = { "tag", SOURCE_OBJ },
 	[ATOM_AUTHOR] = { "author", SOURCE_OBJ },
-	[ATOM_AUTHORNAME] = { "authorname", SOURCE_OBJ },
+	[ATOM_AUTHORNAME] = { "authorname", SOURCE_OBJ, FIELD_STR, person_name_atom_parser },
 	[ATOM_AUTHOREMAIL] = { "authoremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
 	[ATOM_AUTHORDATE] = { "authordate", SOURCE_OBJ, FIELD_TIME },
 	[ATOM_COMMITTER] = { "committer", SOURCE_OBJ },
-	[ATOM_COMMITTERNAME] = { "committername", SOURCE_OBJ },
+	[ATOM_COMMITTERNAME] = { "committername", SOURCE_OBJ, FIELD_STR, person_name_atom_parser },
 	[ATOM_COMMITTEREMAIL] = { "committeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
 	[ATOM_COMMITTERDATE] = { "committerdate", SOURCE_OBJ, FIELD_TIME },
 	[ATOM_TAGGER] = { "tagger", SOURCE_OBJ },
-	[ATOM_TAGGERNAME] = { "taggername", SOURCE_OBJ },
+	[ATOM_TAGGERNAME] = { "taggername", SOURCE_OBJ, FIELD_STR, person_name_atom_parser },
 	[ATOM_TAGGEREMAIL] = { "taggeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
 	[ATOM_TAGGERDATE] = { "taggerdate", SOURCE_OBJ, FIELD_TIME },
 	[ATOM_CREATOR] = { "creator", SOURCE_OBJ },
@@ -1486,32 +1530,49 @@ static const char *copy_name(const char *buf)
 	return xstrdup("");
 }
 
+static const char *find_end_of_email(const char *email, int opt)
+{
+	const char *eoemail;
+
+	if (opt & EO_LOCALPART) {
+		eoemail = strchr(email, '@');
+		if (eoemail)
+			return eoemail;
+		return strchr(email, '>');
+	}
+
+	if (opt & EO_TRIM)
+		return strchr(email, '>');
+
+	/*
+	 * The option here is either the raw email option or the raw
+	 * mailmap option (that is EO_RAW or EO_MAILMAP). In such cases,
+	 * we directly grab the whole email including the closing
+	 * angle brackets.
+	 *
+	 * If EO_MAILMAP was set with any other option (that is either
+	 * EO_TRIM or EO_LOCALPART), we already grab the end of email
+	 * above.
+	 */
+	eoemail = strchr(email, '>');
+	if (eoemail)
+		eoemail++;
+	return eoemail;
+}
+
 static const char *copy_email(const char *buf, struct used_atom *atom)
 {
 	const char *email = strchr(buf, '<');
 	const char *eoemail;
+	int opt = atom->u.email_option.option;
+
 	if (!email)
 		return xstrdup("");
-	switch (atom->u.email_option.option) {
-	case EO_RAW:
-		eoemail = strchr(email, '>');
-		if (eoemail)
-			eoemail++;
-		break;
-	case EO_TRIM:
-		email++;
-		eoemail = strchr(email, '>');
-		break;
-	case EO_LOCALPART:
+
+	if (opt & (EO_LOCALPART | EO_TRIM))
 		email++;
-		eoemail = strchr(email, '@');
-		if (!eoemail)
-			eoemail = strchr(email, '>');
-		break;
-	default:
-		BUG("unknown email option");
-	}
 
+	eoemail = find_end_of_email(email, opt);
 	if (!eoemail)
 		return xstrdup("");
 	return xmemdupz(email, eoemail - email);
@@ -1572,16 +1633,23 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	v->value = 0;
 }
 
+static struct string_list mailmap = STRING_LIST_INIT_NODUP;
+
 /* See grab_values */
 static void grab_person(const char *who, struct atom_value *val, int deref, void *buf)
 {
 	int i;
 	int wholen = strlen(who);
 	const char *wholine = NULL;
+	const char *headers[] = { "author ", "committer ",
+				  "tagger ", NULL };
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
+		struct used_atom *atom = &used_atom[i];
+		const char *name = atom->name;
 		struct atom_value *v = &val[i];
+		struct strbuf mailmap_buf = STRBUF_INIT;
+
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
@@ -1589,22 +1657,36 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 		if (strncmp(who, name, wholen))
 			continue;
 		if (name[wholen] != 0 &&
-		    strcmp(name + wholen, "name") &&
+		    !starts_with(name + wholen, "name") &&
 		    !starts_with(name + wholen, "email") &&
 		    !starts_with(name + wholen, "date"))
 			continue;
-		if (!wholine)
+
+		if ((starts_with(name + wholen, "name") &&
+		    (atom->u.name_option.option == N_MAILMAP)) ||
+		    (starts_with(name + wholen, "email") &&
+		    (atom->u.email_option.option & EO_MAILMAP))) {
+			if (!mailmap.items)
+				read_mailmap(&mailmap);
+			strbuf_addstr(&mailmap_buf, buf);
+			apply_mailmap_to_header(&mailmap_buf, headers, &mailmap);
+			wholine = find_wholine(who, wholen, mailmap_buf.buf);
+		} else {
 			wholine = find_wholine(who, wholen, buf);
+		}
+
 		if (!wholine)
 			return; /* no point looking for it */
 		if (name[wholen] == 0)
 			v->s = copy_line(wholine);
-		else if (!strcmp(name + wholen, "name"))
+		else if (starts_with(name + wholen, "name"))
 			v->s = copy_name(wholine);
 		else if (starts_with(name + wholen, "email"))
 			v->s = copy_email(wholine, &used_atom[i]);
 		else if (starts_with(name + wholen, "date"))
 			grab_date(wholine, v, name);
+
+		strbuf_release(&mailmap_buf);
 	}
 
 	/*
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e4ec2926d6..00a060df0b 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -25,6 +25,13 @@ test_expect_success setup '
 	disklen sha1:138
 	disklen sha256:154
 	EOF
+
+	# setup .mailmap
+	cat >.mailmap <<-EOF &&
+	A Thor <athor@example.com> A U Thor <author@example.com>
+	C Mitter <cmitter@example.com> C O Mitter <committer@example.com>
+	EOF
+
 	setdate_and_increment &&
 	echo "Using $datestamp" > one &&
 	git add one &&
@@ -145,15 +152,31 @@ test_atom head '*objectname' ''
 test_atom head '*objecttype' ''
 test_atom head author 'A U Thor <author@example.com> 1151968724 +0200'
 test_atom head authorname 'A U Thor'
+test_atom head authorname:mailmap 'A Thor'
 test_atom head authoremail '<author@example.com>'
 test_atom head authoremail:trim 'author@example.com'
 test_atom head authoremail:localpart 'author'
+test_atom head authoremail:trim,localpart 'author'
+test_atom head authoremail:mailmap '<athor@example.com>'
+test_atom head authoremail:mailmap,trim 'athor@example.com'
+test_atom head authoremail:trim,mailmap 'athor@example.com'
+test_atom head authoremail:mailmap,localpart 'athor'
+test_atom head authoremail:localpart,mailmap 'athor'
+test_atom head authoremail:mailmap,trim,localpart,mailmap,trim 'athor'
 test_atom head authordate 'Tue Jul 4 01:18:44 2006 +0200'
 test_atom head committer 'C O Mitter <committer@example.com> 1151968723 +0200'
 test_atom head committername 'C O Mitter'
+test_atom head committername:mailmap 'C Mitter'
 test_atom head committeremail '<committer@example.com>'
 test_atom head committeremail:trim 'committer@example.com'
 test_atom head committeremail:localpart 'committer'
+test_atom head committeremail:localpart,trim 'committer'
+test_atom head committeremail:mailmap '<cmitter@example.com>'
+test_atom head committeremail:mailmap,trim 'cmitter@example.com'
+test_atom head committeremail:trim,mailmap 'cmitter@example.com'
+test_atom head committeremail:mailmap,localpart 'cmitter'
+test_atom head committeremail:localpart,mailmap 'cmitter'
+test_atom head committeremail:trim,mailmap,trim,trim,localpart 'cmitter'
 test_atom head committerdate 'Tue Jul 4 01:18:43 2006 +0200'
 test_atom head tag ''
 test_atom head tagger ''
@@ -203,22 +226,46 @@ test_atom tag '*objectname' $(git rev-parse refs/tags/testtag^{})
 test_atom tag '*objecttype' 'commit'
 test_atom tag author ''
 test_atom tag authorname ''
+test_atom tag authorname:mailmap ''
 test_atom tag authoremail ''
 test_atom tag authoremail:trim ''
 test_atom tag authoremail:localpart ''
+test_atom tag authoremail:trim,localpart ''
+test_atom tag authoremail:mailmap ''
+test_atom tag authoremail:mailmap,trim ''
+test_atom tag authoremail:trim,mailmap ''
+test_atom tag authoremail:mailmap,localpart ''
+test_atom tag authoremail:localpart,mailmap ''
+test_atom tag authoremail:mailmap,trim,localpart,mailmap,trim ''
 test_atom tag authordate ''
 test_atom tag committer ''
 test_atom tag committername ''
+test_atom tag committername:mailmap ''
 test_atom tag committeremail ''
 test_atom tag committeremail:trim ''
 test_atom tag committeremail:localpart ''
+test_atom tag committeremail:localpart,trim ''
+test_atom tag committeremail:mailmap ''
+test_atom tag committeremail:mailmap,trim ''
+test_atom tag committeremail:trim,mailmap ''
+test_atom tag committeremail:mailmap,localpart ''
+test_atom tag committeremail:localpart,mailmap ''
+test_atom tag committeremail:trim,mailmap,trim,trim,localpart ''
 test_atom tag committerdate ''
 test_atom tag tag 'testtag'
 test_atom tag tagger 'C O Mitter <committer@example.com> 1151968725 +0200'
 test_atom tag taggername 'C O Mitter'
+test_atom tag taggername:mailmap 'C Mitter'
 test_atom tag taggeremail '<committer@example.com>'
 test_atom tag taggeremail:trim 'committer@example.com'
 test_atom tag taggeremail:localpart 'committer'
+test_atom tag taggeremail:trim,localpart 'committer'
+test_atom tag taggeremail:mailmap '<cmitter@example.com>'
+test_atom tag taggeremail:mailmap,trim 'cmitter@example.com'
+test_atom tag taggeremail:trim,mailmap 'cmitter@example.com'
+test_atom tag taggeremail:mailmap,localpart 'cmitter'
+test_atom tag taggeremail:localpart,mailmap 'cmitter'
+test_atom tag taggeremail:trim,mailmap,trim,localpart,localpart 'cmitter'
 test_atom tag taggerdate 'Tue Jul 4 01:18:45 2006 +0200'
 test_atom tag creator 'C O Mitter <committer@example.com> 1151968725 +0200'
 test_atom tag creatordate 'Tue Jul 4 01:18:45 2006 +0200'
@@ -292,8 +339,44 @@ test_bad_atom () {
 test_bad_atom head 'authoremail:foo' \
 	'fatal: unrecognized %(authoremail) argument: foo'
 
+test_bad_atom head 'authoremail:mailmap,trim,bar' \
+	'fatal: unrecognized %(authoremail) argument: bar'
+
+test_bad_atom head 'authoremail:trim,' \
+	'fatal: unrecognized %(authoremail) argument: '
+
+test_bad_atom head 'authoremail:mailmaptrim' \
+	'fatal: unrecognized %(authoremail) argument: trim'
+
+test_bad_atom head 'committeremail: ' \
+	'fatal: unrecognized %(committeremail) argument:  '
+
+test_bad_atom head 'committeremail: trim,foo' \
+	'fatal: unrecognized %(committeremail) argument:  trim,foo'
+
+test_bad_atom head 'committeremail:mailmap,localpart ' \
+	'fatal: unrecognized %(committeremail) argument:  '
+
+test_bad_atom head 'committeremail:trim_localpart' \
+	'fatal: unrecognized %(committeremail) argument: _localpart'
+
+test_bad_atom head 'committeremail:localpart,,,trim' \
+	'fatal: unrecognized %(committeremail) argument: ,,trim'
+
+test_bad_atom tag 'taggeremail:mailmap,trim, foo ' \
+	'fatal: unrecognized %(taggeremail) argument:  foo '
+
+test_bad_atom tag 'taggeremail:trim,localpart,' \
+	'fatal: unrecognized %(taggeremail) argument: '
+
+test_bad_atom tag 'taggeremail:mailmap;localpart trim' \
+	'fatal: unrecognized %(taggeremail) argument: ;localpart trim'
+
 test_bad_atom tag 'taggeremail:localpart trim' \
-	'fatal: unrecognized %(taggeremail) argument: localpart trim'
+	'fatal: unrecognized %(taggeremail) argument:  trim'
+
+test_bad_atom tag 'taggeremail:mailmap,mailmap,trim,qux,localpart,trim' \
+	'fatal: unrecognized %(taggeremail) argument: qux,localpart,trim'
 
 test_date () {
 	f=$1 &&
-- 
2.42.0.273.ge948a9aaf4

