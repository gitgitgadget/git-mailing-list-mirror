Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B10BC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB1820724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoGALuv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgHUVl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHUVly (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:41:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D0AC061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y3so3198988wrl.4
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZyGaiMZDKkBCk7ZUMG6MB7U2gFaGky2dAue7wegcrQI=;
        b=VoGALuv2e8+T4S5fmMcrXo14Cn4b+GGSqbuZKZcLvFNIzZWuGQ3M7SOQmazPlQh4Mt
         rpHBU0Aqy16ClEOjTfQ3K4I2ang+3FFGzjUfHbWmKHV6ll7gciWa1YaJG0Uqao283UAN
         3OimZEclSDiptHab4fJgqKYL+wqZAdC0g918eQK1JvmLoQb8zorbtXLL7AylQFYHAEf2
         Om/bJKZ18b3Z5+BfzV+sMiiMyPBuezbnVa06Zc/svKOMJMl1gMncwyWdUWdaZ0mlFO0G
         SsEbOjFN1uxK5sZMm4Ld68s6rEQQCRuH+jjjsST6SSfiLFvgCBYdt+Y1DpmZT06f0uF1
         njnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZyGaiMZDKkBCk7ZUMG6MB7U2gFaGky2dAue7wegcrQI=;
        b=KwlMRHWj9Qh7teNTC3gVJnkLFxL12VcMhChgHhUQhuHArKQfZ3c9SL678XGhXKo0wP
         UaKuBBUhIXk6y0+5ucXOT6PKLA2FE7i2PnJa2oHXYuhQKbA6H5E83EHp2FUXqDrqBA46
         X0MRt9aQUVIkUoDi3Uqid1tTSF3YCTrZovqDxMjBPRsAmJU93rVtsw0MjIde3KzRTl9X
         +VRPHyyUK9Bb0MfJCfF0eYPvxVg5J7XVoaBHNYFHzbFkAMum49r2mJx8Cn1l1Bmf8L6Z
         pYMM8i5S3umc/6FK1gUeQTb9il4OE0/0N6CfisWR7DabA2CTEakpdMTvq08Zi6DSmJhZ
         yK8g==
X-Gm-Message-State: AOAM5337A3SWje/p2OQZ/BC76IlEqaaWZmErurM+OXN0CIrQx4hebGQe
        Xx4Z/mUTfj/t7S7+2j7G3WhFnjm1pt8=
X-Google-Smtp-Source: ABdhPJxHivsEyBCUmAj2vfolHgXEITmOAhv++aMoD4q0l4cnNVdBtzlHbjqsUHIZuCvHbmZSKOdrHw==
X-Received: by 2002:adf:e94c:: with SMTP id m12mr4364300wrn.109.1598046112373;
        Fri, 21 Aug 2020 14:41:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d21sm8473602wmd.41.2020.08.21.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:41:51 -0700 (PDT)
Message-Id: <55618fe4c1ea96fb0c2734121f8a54a921fb0aff.1598046110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
References: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
        <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:41:43 +0000
Subject: [PATCH v4 1/8] ref-filter: support different email formats
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

