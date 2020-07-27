Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29404C433E0
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE22920759
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzgBJUuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgG0UnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgG0UnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 16:43:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98565C0619D4
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f1so15625649wro.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L3UUShb3kGIPQKkEB4fx5bFT1hHTBnr8RIViyS+q8Qc=;
        b=HzgBJUuIVYIw+qHx4CocK3j7Y8OlQ+/Ie/a3YJrspLnDh9OGCeZsKfkV/Ynr3FUSYr
         TKFfKzURNIGR1HYf82T37U3MJZNcHo1cfIbUH0UqzFxH8BUNTYIJ1eoQGBcDXqAGS9ih
         hUAcSroeY19OTcUi22hIQBzmE7NGQdKxeBRL+lFZI7N0jFDS/BZLQBzD3NeS70L3xExX
         DsQYY7bkT4+YP2iZPLPid3E+6hLpT2ObsqpoxXT7n1L+2ZUvBX+VnWN4GyVqINvkbU77
         2kIUGPdrHilv8N6zxQOA6EwTXGJLf5PqQqARGF97EgdhmW3sHeCHAu5hiVh0DGNBzZO1
         5mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L3UUShb3kGIPQKkEB4fx5bFT1hHTBnr8RIViyS+q8Qc=;
        b=sbrMjbSo51fJdAw3RmH1wmVlPxINOHWbgCLmDzn8HztoijHsaEKkEwm8aQUbpifaVC
         VgXLZkxJW1Kmk5cfjU8e+04BWMfoJW4lsgCb453LNF0hx+vSe4aW5jaW3UEyRbG12nqq
         DfQfKnazwuj7FtpIdcCuOADb1U4R3VWO3gs5KOnic/kU37e4fkCU9VJ987LC3JPhq5An
         apFxU7+ao1MFQzhTyYpg0dh6XTuacIWLPilFsTwHN9k7W93nWqmSjxpdMopMESLWDfje
         jimHWdFU3hfcSKEhe0N2QcEYKup+7UTqIMQaiLOalYE38j5v6O8ie3XkrrFaC2K0KTpX
         pNkQ==
X-Gm-Message-State: AOAM531RrjVKhLrQTTXZCe5jrlEtQY2f3VnBcTNgNZ86qMuEg0k9zAUs
        QMCBsmzlYaeV3L2BkvVAaziAYcRz
X-Google-Smtp-Source: ABdhPJzdBTxpIdVbj2rV0pFlPAvGkcf7Y2PWZZGd8nExAcLSrK7KLc0ULLMphLHO1090I6tbeYKvFA==
X-Received: by 2002:a5d:54ca:: with SMTP id x10mr14485020wrv.36.1595882591028;
        Mon, 27 Jul 2020 13:43:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm4925671wrt.41.2020.07.27.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:43:10 -0700 (PDT)
Message-Id: <aeb116c5aaaa23dfefbc7a6f4ac743a6f5a3ade8.1595882588.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.git.1595882588.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jul 2020 20:43:04 +0000
Subject: [PATCH 1/5] ref-filter: support different email formats
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

Currently, ref-filter only supports printing email with arrow brackets.

Let's add support for two more email options.
- trim : print email without arrow brackets.
- localpart : prints the part before the @ sign

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c            | 36 ++++++++++++++++++++++++++++++++----
 t/t6300-for-each-ref.sh | 16 ++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8447cb09be..8563088eb1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -102,6 +102,10 @@ static struct ref_to_worktree_map {
 	struct worktree **worktrees;
 } ref_to_worktree_map;
 
+static struct email_option{
+	enum { EO_INVALID, EO_RAW, EO_TRIM, EO_LOCALPART } option;
+} email_option;
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -1040,10 +1044,26 @@ static const char *copy_email(const char *buf)
 	const char *eoemail;
 	if (!email)
 		return xstrdup("");
-	eoemail = strchr(email, '>');
+	switch (email_option.option) {
+	case EO_RAW:
+		eoemail = strchr(email, '>') + 1;
+		break;
+	case EO_TRIM:
+		email++;
+		eoemail = strchr(email, '>');
+		break;
+	case EO_LOCALPART:
+		email++;
+		eoemail = strchr(email, '@');
+		break;
+	case EO_INVALID:
+	default:
+		return xstrdup("");
+	}
+
 	if (!eoemail)
 		return xstrdup("");
-	return xmemdupz(email, eoemail + 1 - email);
+	return xmemdupz(email, eoemail - email);
 }
 
 static char *copy_subject(const char *buf, unsigned long len)
@@ -1113,7 +1133,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 			continue;
 		if (name[wholen] != 0 &&
 		    strcmp(name + wholen, "name") &&
-		    strcmp(name + wholen, "email") &&
+		    !starts_with(name + wholen, "email") &&
 		    !starts_with(name + wholen, "date"))
 			continue;
 		if (!wholine)
@@ -1124,8 +1144,16 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 			v->s = copy_line(wholine);
 		else if (!strcmp(name + wholen, "name"))
 			v->s = copy_name(wholine);
-		else if (!strcmp(name + wholen, "email"))
+		else if (starts_with(name + wholen, "email")) {
+			email_option.option = EO_INVALID;
+			if (!strcmp(name + wholen, "email"))
+				email_option.option = EO_RAW;
+			if (!strcmp(name + wholen, "email:trim"))
+				email_option.option = EO_TRIM;
+			if (!strcmp(name + wholen, "email:localpart"))
+				email_option.option = EO_LOCALPART;
 			v->s = copy_email(wholine);
+		}
 		else if (starts_with(name + wholen, "date"))
 			grab_date(wholine, v, name);
 	}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index da59fadc5d..b8a2cb8439 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -106,15 +106,21 @@ test_atom head '*objecttype' ''
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
@@ -151,15 +157,21 @@ test_atom tag '*objecttype' 'commit'
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
@@ -545,10 +557,14 @@ test_atom refs/tags/taggerless tag 'taggerless'
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

