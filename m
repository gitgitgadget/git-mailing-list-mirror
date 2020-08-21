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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15D3C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837BC20724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+KA1IuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgHUVmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgHUVmB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:42:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78646C061755
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:42:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b17so2419099wru.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QR1w2Zp6gFF71LmnCss6TN/IzKoFjdS10xuG1zbnlSE=;
        b=g+KA1IuMpOqc+zGoJPb52Re91IMAPmmfVRDd2AUGsZtwXvB5ISblEw+BfJFMyEUynT
         EBxihQi1S5u/PfgM0X1epoWv+OLG5BDcQ2I6XLlJKtIPXxVq0M+n4pxwofhuYDoP0oZL
         frimwGu9MijQ5w6ocqYLiMU4ZTDl5WkASuUFonT2LLm9CJBBJLjEMeyhJ4pwxInOHHHW
         HZn3hsCyllXgiSgKPnssb29uKQtB1ntYLUM5S6UigB2kQzqo3mCOIS83Syi4fFxn1gZt
         YXz4pnSX7iXfaG0FlQEhVakzKFGFndRPhYMm0v4XNpDem75PUl7wwzslKkW8owDEVNQP
         dHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QR1w2Zp6gFF71LmnCss6TN/IzKoFjdS10xuG1zbnlSE=;
        b=bBdsGr6VXQKSk4W0ffR8z0v4Pf34ZMWNjv9yy5IPqTyYMHYrYD8kkWTCK0/xLv3SwW
         koQbU+0pwEJ1WJagXutApdvVfJ9cga8MXm7Tv4TytclIRlnifVIPpdH5bbyffB4qRWCC
         52EUJvrXmPd1jZwwR0Pm3nfXR+ML5kZyw7mCHSzpOkMUBCGBqZNKlSklllbcZgJcZXCx
         5DYaDx/Ls5r3MoAdtnEeHY3v0v2YUNikmaAMCr1GoqwQOojmtnuwUQEGVyfn4jJC+pkm
         CYtJ7Q8V/8Wt2fVURbxdqBYZq539DBLFIMEQwZ358gXSJ5Acp026uXUpEogggQm6dwZl
         fxgQ==
X-Gm-Message-State: AOAM5304cx6/swsq2HAFhcyJYbt6vvLR6+77VwfS7vYrXC670YiEjr8g
        i2zlkiSvRo8SDf8qGRlEL75BOK9JHs0=
X-Google-Smtp-Source: ABdhPJxLMOK8oZKw1SlWYROurYTrmkTEqbpG7S+KzEGWufjObwbiXOctSLl6FxMrNpAhKKAPsq1LkA==
X-Received: by 2002:adf:9463:: with SMTP id 90mr4252534wrq.223.1598046118936;
        Fri, 21 Aug 2020 14:41:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b129sm7590880wmb.29.2020.08.21.14.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:41:58 -0700 (PDT)
Message-Id: <7cba8d7a2881055e89976ca420392da2eaa596b8.1598046110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
References: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
        <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:41:50 +0000
Subject: [PATCH v4 8/8] ref-filter: add `sanitize` option for 'subject' atom
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

Currently, subject does not take any arguments. This commit introduce
`sanitize` formatting option to 'subject' atom.

`subject:sanitize` - print sanitized subject line, suitable for a filename.

e.g.
%(subject): "the subject line"
%(subject:sanitize): "the-subject-line"

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       | 23 +++++++++++++++--------
 t/t6300-for-each-ref.sh            |  7 +++++++
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index dd09763e7d..616ce46087 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -247,6 +247,9 @@ contents:subject::
 	The first paragraph of the message, which typically is a
 	single line, is taken as the "subject" of the commit or the
 	tag message.
+	Instead of `contents:subject`, field `subject` can also be used to
+	obtain same results. `:sanitize` can be appended to `subject` for
+	subject line suitable for filename.
 
 contents:body::
 	The remainder of the commit or the tag message that follows
diff --git a/ref-filter.c b/ref-filter.c
index c7d81088e4..12bb78ce06 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -127,8 +127,8 @@ static struct used_atom {
 			unsigned int nobracket : 1, push : 1, push_remote : 1;
 		} remote_ref;
 		struct {
-			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH,
-			       C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH, C_LINES,
+			       C_SIG, C_SUB, C_SUB_SANITIZE, C_TRAILERS } option;
 			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
 		} contents;
@@ -301,9 +301,12 @@ static int body_atom_parser(const struct ref_format *format, struct used_atom *a
 static int subject_atom_parser(const struct ref_format *format, struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
-	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(subject) does not take arguments"));
-	atom->u.contents.option = C_SUB;
+	if (!arg)
+		atom->u.contents.option = C_SUB;
+	else if (!strcmp(arg, "sanitize"))
+		atom->u.contents.option = C_SUB_SANITIZE;
+	else
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(subject) argument: %s"), arg);
 	return 0;
 }
 
@@ -1282,8 +1285,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			continue;
 		if (deref)
 			name++;
-		if (strcmp(name, "subject") &&
-		    strcmp(name, "body") &&
+		if (strcmp(name, "body") &&
+		    !starts_with(name, "subject") &&
 		    !starts_with(name, "trailers") &&
 		    !starts_with(name, "contents"))
 			continue;
@@ -1295,7 +1298,11 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 
 		if (atom->u.contents.option == C_SUB)
 			v->s = copy_subject(subpos, sublen);
-		else if (atom->u.contents.option == C_BODY_DEP)
+		else if (atom->u.contents.option == C_SUB_SANITIZE) {
+			struct strbuf sb = STRBUF_INIT;
+			format_sanitized_subject(&sb, subpos, sublen);
+			v->s = strbuf_detach(&sb, NULL);
+		} else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
 		else if (atom->u.contents.option == C_LENGTH)
 			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 79d5b29387..220ff5c3c2 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -150,6 +150,7 @@ test_atom head taggerdate ''
 test_atom head creator 'C O Mitter <committer@example.com> 1151968723 +0200'
 test_atom head creatordate 'Tue Jul 4 01:18:43 2006 +0200'
 test_atom head subject 'Initial'
+test_atom head subject:sanitize 'Initial'
 test_atom head contents:subject 'Initial'
 test_atom head body ''
 test_atom head contents:body ''
@@ -207,6 +208,7 @@ test_atom tag taggerdate 'Tue Jul 4 01:18:45 2006 +0200'
 test_atom tag creator 'C O Mitter <committer@example.com> 1151968725 +0200'
 test_atom tag creatordate 'Tue Jul 4 01:18:45 2006 +0200'
 test_atom tag subject 'Tagging at 1151968727'
+test_atom tag subject:sanitize 'Tagging-at-1151968727'
 test_atom tag contents:subject 'Tagging at 1151968727'
 test_atom tag body ''
 test_atom tag contents:body ''
@@ -619,6 +621,7 @@ test_expect_success 'create tag with subject and body content' '
 	git tag -F msg subject-body
 '
 test_atom refs/tags/subject-body subject 'the subject line'
+test_atom refs/tags/subject-body subject:sanitize 'the-subject-line'
 test_atom refs/tags/subject-body body 'first body line
 second body line
 '
@@ -639,6 +642,7 @@ test_expect_success 'create tag with multiline subject' '
 	git tag -F msg multiline
 '
 test_atom refs/tags/multiline subject 'first subject line second subject line'
+test_atom refs/tags/multiline subject:sanitize 'first-subject-line-second-subject-line'
 test_atom refs/tags/multiline contents:subject 'first subject line second subject line'
 test_atom refs/tags/multiline body 'first body line
 second body line
@@ -671,6 +675,7 @@ sig='-----BEGIN PGP SIGNATURE-----
 
 PREREQ=GPG
 test_atom refs/tags/signed-empty subject ''
+test_atom refs/tags/signed-empty subject:sanitize ''
 test_atom refs/tags/signed-empty contents:subject ''
 test_atom refs/tags/signed-empty body "$sig"
 test_atom refs/tags/signed-empty contents:body ''
@@ -678,6 +683,7 @@ test_atom refs/tags/signed-empty contents:signature "$sig"
 test_atom refs/tags/signed-empty contents "$sig"
 
 test_atom refs/tags/signed-short subject 'subject line'
+test_atom refs/tags/signed-short subject:sanitize 'subject-line'
 test_atom refs/tags/signed-short contents:subject 'subject line'
 test_atom refs/tags/signed-short body "$sig"
 test_atom refs/tags/signed-short contents:body ''
@@ -686,6 +692,7 @@ test_atom refs/tags/signed-short contents "subject line
 $sig"
 
 test_atom refs/tags/signed-long subject 'subject line'
+test_atom refs/tags/signed-long subject:sanitize 'subject-line'
 test_atom refs/tags/signed-long contents:subject 'subject line'
 test_atom refs/tags/signed-long body "body contents
 $sig"
-- 
gitgitgadget
