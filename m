Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89114C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602EA2072E
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUQlrIB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbgHQSKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbgHQSK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:10:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537E9C061345
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id x5so14015605wmi.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZyGaiMZDKkBCk7ZUMG6MB7U2gFaGky2dAue7wegcrQI=;
        b=QUQlrIB632OIigQZv71/FJpZYKT+pyRbgXdP0ZQn50IuDwEZ+oqYRP+CjA0CEOkpi/
         oxgbVh28T/bZeuagM9mH74eDwOzfi55Xghj9lMfauWWkaKMuB52yDjFldyMNUbjsUonM
         VL5XkYPCRR8oKwTPdheyiK+UnhU3l+akYhLctSoJm5Xg6FIdveLW1Ol3VJOf+TzYGcVN
         I1rPk881sT+dPe1S7byaImNZFhnfVUn/m925qIqiI/eoqyFbFcxCY1MANO5D3rlSpfwF
         0HdxdNSXOnshFS40cismI4c1s8ORVscww4wG3DNRr8/fQhehLPkviYdXDGwPRcqRSnfX
         LnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZyGaiMZDKkBCk7ZUMG6MB7U2gFaGky2dAue7wegcrQI=;
        b=aU/qpSXhzfIZ5xh/rJ/yN6shy0vR2HE+IJ1XHiK8dQ4/DWD6Gtea+bYh3kGdazYaiI
         IcWinheD7yW9FaLji2Qu64DTKMJ2/vHj4d3llMca0N7LVtUInKPvEFm6J72oBMjDY9Ei
         q1pVTIHM/XloxpMFpxn783rQd8CI5aTLQxXvLFUQa1emxWpVWmqxnMsCdgRKmV8cqj/w
         ogzyfOASm49TFaEMneVMr8gE2Z/3bRO8NCEPdGY0H4GpYUrC5Q3ao0rIU44uqufRxruP
         K8nfttCqcexQpYyTq3yHzknaBKTRFGJ++V0GO2cVI30IZO02h9na+VkQKW7YkjdCBl06
         bFtA==
X-Gm-Message-State: AOAM530Z3oW6kkvRmn7PNBtOed+WefKnjOStBC3wPzoLTR8LCZM7HTW6
        4muMMLhezPG5V5a2RT6u9DdvLhGQga0=
X-Google-Smtp-Source: ABdhPJzKh0sqbh96pXIrJvU0D2OgOBh2ohxcwclusIa0RHNT4nxImWWqMsn33XJGnuIvTuLa0nmWpA==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr14626798wmh.80.1597687824143;
        Mon, 17 Aug 2020 11:10:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8sm33272029wrl.7.2020.08.17.11.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:10:23 -0700 (PDT)
Message-Id: <3e6fc66a4668a8abe1eefbbce352ccd30abc096b.1597687822.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 18:10:14 +0000
Subject: [PATCH v3 1/9] ref-filter: support different email formats
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Currently, ref-filter only supports printing email with angle brackets.

Let's add support for two more email options.
- trim : for email without angle brackets.
- localpart : for the part before the @ sign out of trimmed email

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 ++-
 ref-filter.c                       | 54 +++++++++++++++++++++++++-----
 t/t6300-for-each-ref.sh            | 16 +++++++++
 3 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2ea71c5f6c..e6ce8af612 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -230,7 +230,10 @@ These are intended for working on a mix of annotated and lightweight tags.
 
 Fields that have name-email-date tuple as its value (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
-and `date` to extract the named component.
+and `date` to extract the named component.  For email fields (`authoremail`,
+`committeremail` and `taggeremail`), `:trim` can be appended to get the email
+without angle brackets, and `:localpart` to get the part before the `@` symbol
+out of the trimmed email.
 
 The message in a commit or a tag object is `contents`, from which
 `contents:<part>` can be used to extract various parts out of:
diff --git a/ref-filter.c b/ref-filter.c
index ba85869755..e60765f156 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -140,6 +140,9 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
+		struct email_option {
+			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
+		} email_option;
 		struct refname_atom refname;
 		char *head;
 	} u;
@@ -377,6 +380,20 @@ static int objectname_atom_parser(const struct ref_format *format, struct used_a
 	return 0;
 }
 
+static int person_email_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				    const char *arg, struct strbuf *err)
+{
+	if (!arg)
+		atom->u.email_option.option = EO_RAW;
+	else if (!strcmp(arg, "trim"))
+		atom->u.email_option.option = EO_TRIM;
+	else if (!strcmp(arg, "localpart"))
+		atom->u.email_option.option = EO_LOCALPART;
+	else
+		return strbuf_addf_ret(err, -1, _("unrecognized email option: %s"), arg);
+	return 0;
+}
+
 static int refname_atom_parser(const struct ref_format *format, struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
@@ -488,15 +505,15 @@ static struct {
 	{ "tag", SOURCE_OBJ },
 	{ "author", SOURCE_OBJ },
 	{ "authorname", SOURCE_OBJ },
-	{ "authoremail", SOURCE_OBJ },
+	{ "authoremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
 	{ "authordate", SOURCE_OBJ, FIELD_TIME },
 	{ "committer", SOURCE_OBJ },
 	{ "committername", SOURCE_OBJ },
-	{ "committeremail", SOURCE_OBJ },
+	{ "committeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
 	{ "committerdate", SOURCE_OBJ, FIELD_TIME },
 	{ "tagger", SOURCE_OBJ },
 	{ "taggername", SOURCE_OBJ },
-	{ "taggeremail", SOURCE_OBJ },
+	{ "taggeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
 	{ "taggerdate", SOURCE_OBJ, FIELD_TIME },
 	{ "creator", SOURCE_OBJ },
 	{ "creatordate", SOURCE_OBJ, FIELD_TIME },
@@ -1037,16 +1054,35 @@ static const char *copy_name(const char *buf)
 	return xstrdup("");
 }
 
-static const char *copy_email(const char *buf)
+static const char *copy_email(const char *buf, struct used_atom *atom)
 {
 	const char *email = strchr(buf, '<');
 	const char *eoemail;
 	if (!email)
 		return xstrdup("");
-	eoemail = strchr(email, '>');
+	switch (atom->u.email_option.option) {
+	case EO_RAW:
+		eoemail = strchr(email, '>');
+		if (eoemail)
+			eoemail++;
+		break;
+	case EO_TRIM:
+		email++;
+		eoemail = strchr(email, '>');
+		break;
+	case EO_LOCALPART:
+		email++;
+		eoemail = strchr(email, '@');
+		if (!eoemail)
+			eoemail = strchr(email, '>');
+		break;
+	default:
+		BUG("unknown email option");
+	}
+
 	if (!eoemail)
 		return xstrdup("");
-	return xmemdupz(email, eoemail + 1 - email);
+	return xmemdupz(email, eoemail - email);
 }
 
 static char *copy_subject(const char *buf, unsigned long len)
@@ -1116,7 +1152,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 			continue;
 		if (name[wholen] != 0 &&
 		    strcmp(name + wholen, "name") &&
-		    strcmp(name + wholen, "email") &&
+		    !starts_with(name + wholen, "email") &&
 		    !starts_with(name + wholen, "date"))
 			continue;
 		if (!wholine)
@@ -1127,8 +1163,8 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 			v->s = copy_line(wholine);
 		else if (!strcmp(name + wholen, "name"))
 			v->s = copy_name(wholine);
-		else if (!strcmp(name + wholen, "email"))
-			v->s = copy_email(wholine);
+		else if (starts_with(name + wholen, "email"))
+			v->s = copy_email(wholine, &used_atom[i]);
 		else if (starts_with(name + wholen, "date"))
 			grab_date(wholine, v, name);
 	}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index a83579fbdf..64fbc91146 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -125,15 +125,21 @@ test_atom head '*objecttype' ''
 test_atom head author 'A U Thor <author@example.com> 1151968724 +0200'
 test_atom head authorname 'A U Thor'
 test_atom head authoremail '<author@example.com>'
+test_atom head authoremail:trim 'author@example.com'
+test_atom head authoremail:localpart 'author'
 test_atom head authordate 'Tue Jul 4 01:18:44 2006 +0200'
 test_atom head committer 'C O Mitter <committer@example.com> 1151968723 +0200'
 test_atom head committername 'C O Mitter'
 test_atom head committeremail '<committer@example.com>'
+test_atom head committeremail:trim 'committer@example.com'
+test_atom head committeremail:localpart 'committer'
 test_atom head committerdate 'Tue Jul 4 01:18:43 2006 +0200'
 test_atom head tag ''
 test_atom head tagger ''
 test_atom head taggername ''
 test_atom head taggeremail ''
+test_atom head taggeremail:trim ''
+test_atom head taggeremail:localpart ''
 test_atom head taggerdate ''
 test_atom head creator 'C O Mitter <committer@example.com> 1151968723 +0200'
 test_atom head creatordate 'Tue Jul 4 01:18:43 2006 +0200'
@@ -170,15 +176,21 @@ test_atom tag '*objecttype' 'commit'
 test_atom tag author ''
 test_atom tag authorname ''
 test_atom tag authoremail ''
+test_atom tag authoremail:trim ''
+test_atom tag authoremail:localpart ''
 test_atom tag authordate ''
 test_atom tag committer ''
 test_atom tag committername ''
 test_atom tag committeremail ''
+test_atom tag committeremail:trim ''
+test_atom tag committeremail:localpart ''
 test_atom tag committerdate ''
 test_atom tag tag 'testtag'
 test_atom tag tagger 'C O Mitter <committer@example.com> 1151968725 +0200'
 test_atom tag taggername 'C O Mitter'
 test_atom tag taggeremail '<committer@example.com>'
+test_atom tag taggeremail:trim 'committer@example.com'
+test_atom tag taggeremail:localpart 'committer'
 test_atom tag taggerdate 'Tue Jul 4 01:18:45 2006 +0200'
 test_atom tag creator 'C O Mitter <committer@example.com> 1151968725 +0200'
 test_atom tag creatordate 'Tue Jul 4 01:18:45 2006 +0200'
@@ -564,10 +576,14 @@ test_atom refs/tags/taggerless tag 'taggerless'
 test_atom refs/tags/taggerless tagger ''
 test_atom refs/tags/taggerless taggername ''
 test_atom refs/tags/taggerless taggeremail ''
+test_atom refs/tags/taggerless taggeremail:trim ''
+test_atom refs/tags/taggerless taggeremail:localpart ''
 test_atom refs/tags/taggerless taggerdate ''
 test_atom refs/tags/taggerless committer ''
 test_atom refs/tags/taggerless committername ''
 test_atom refs/tags/taggerless committeremail ''
+test_atom refs/tags/taggerless committeremail:trim ''
+test_atom refs/tags/taggerless committeremail:localpart ''
 test_atom refs/tags/taggerless committerdate ''
 test_atom refs/tags/taggerless subject 'Broken tag'
 
-- 
gitgitgadget

