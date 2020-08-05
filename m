Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC8C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061F622CAF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp8lQbmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHEVwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgHEVv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:51:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D62EC0617A0
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:51:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p14so7093782wmg.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eayZ8iqKjfrVZq20Nn41q2KGBtxB2MvtcvFO0SPVCGM=;
        b=Xp8lQbmAtIPdT31KdCWMqlK0bQk+6tNO8xSzvfSllUI33lx8PvSDY2VUV2b/IcAhvm
         vdBkQqyglHss+bEpmtBmsi4Wr3AS3UPD0fXQcxsvvWQivjZVbL1XhfR7A8Rpx9xvVciP
         Y8zJgIGtzqg8/ObgMXnsPdDYFC1GBygAGhr58wwuKXgqiOGVYef0iFNNLMtmbBuFCzet
         icZyx1YHNouvmLKTQrednw9m7OHEHGSaXjBFyt7VT/ejlkgUytgVCfG3TPta5g+jo5+d
         xO+DKVKLrhvF0Ze3mtyzCEz/P/enhPAc2XE+ghPLivDYZKv22Z4kjdszp3kTjo+CyDwP
         1MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eayZ8iqKjfrVZq20Nn41q2KGBtxB2MvtcvFO0SPVCGM=;
        b=cf3h8Mq+4EeSHUOiEG5Nej5RdMK1qfAGmGNSsZQeqaSoxU+z56mzPzghqwD8Hi0211
         4BCj98nTN2rjNSmFEBJQTf2G80Eht4DZ/bbTvzvB/JIk7xpiNZr4IJJohaW5InOuGXPE
         IxWBRgWgrWpcBSgdvqyW7v3/wCopNt7m/ePOIFJvFvSvYD+zEgmr70+7vpsZ9U2SLAA2
         jDudOvleUa9ztaNRxW4cvidsfN8aUraX/sFQ/Ou+H/SboE9P0hQNlo3oTWUpu42knfvd
         1WKf/5Xm6xJh2A8LXW25lynNVTiJS4TGUNcTpYKpnzp7UXTYA55NwP7VCUltBXSAgo55
         xH/A==
X-Gm-Message-State: AOAM5326EjSUbpuzhLMIyi2+lJIZV+7/JDwhKbOmPfcyE3qvi2dYGQWq
        Lm2q91WfUZb67K+wJZhHUjS/eDj1
X-Google-Smtp-Source: ABdhPJwu4ZVeuQVZw9mGDcY/mXkWY/KS4QzSBcubiQPlUXpcrS9l2l0rCt9bOGCmMpUjn6+PAxdm4g==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr5355200wmj.128.1596664316144;
        Wed, 05 Aug 2020 14:51:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm4201978wrx.30.2020.08.05.14.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:51:55 -0700 (PDT)
Message-Id: <feace82752199aea87e728c340e9a7c9f0b2a2fa.1596664306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 21:51:45 +0000
Subject: [PATCH v2 9/9] ref-filter: add `sanitize` option for 'subject' atom
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
 ref-filter.c                       | 24 ++++++++++++++++--------
 t/t6300-for-each-ref.sh            |  7 +++++++
 3 files changed, 26 insertions(+), 8 deletions(-)

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
index 6d5bbb14a2..016a03ef20 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -23,6 +23,7 @@
 #include "worktree.h"
 #include "hashmap.h"
 #include "argv-array.h"
+#include "format-support.h"
 
 static struct ref_msg {
 	const char *gone;
@@ -127,8 +128,8 @@ static struct used_atom {
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
@@ -301,9 +302,12 @@ static int body_atom_parser(const struct ref_format *format, struct used_atom *a
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
 
@@ -1282,8 +1286,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
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
@@ -1295,7 +1299,11 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 
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
