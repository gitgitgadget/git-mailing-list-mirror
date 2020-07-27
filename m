Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60664C433E8
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 348CD2074F
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7MUv72N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgG0UnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgG0UnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 16:43:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8483C0619D2
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so14754772wmi.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OfKJkOAGHL0xEsAIp96Oau+hikHsQClqxiA83+1+DhY=;
        b=A7MUv72NmBFyms+2D2SJNJCfY2C0tqC2U50IUjuKA2j1nhm0sNpXNMvgJz8Anpctt8
         R5ZkNcTdFtw5CirPIhezhiroy/RMgHIP5lTrHrNr7YF33IVhn1m4LBQTpfcQ6HOOAMSM
         sGOqA+lTjJ6F80DEmcpauGjo/Ewumd1jTZpPbP23E0XBoEtKVRI0/1tNKQLlXflQnKpw
         psvjkIbpNAZqUeVxa7H3H3kLPlVE+5RmQ6dNwqmdAOvyVmCtI1XZeaC81+Uq+YhesVrW
         nABM8nxysQtfPFRmvIXyO83rjhPYzQEBwrpyzTCgaWRXbb6zWqHGKPj0uECZ3fmIXmTh
         SD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OfKJkOAGHL0xEsAIp96Oau+hikHsQClqxiA83+1+DhY=;
        b=gEaifzrLFWfHEux6ZJYETGgtucEGi5JRBAjbpgBLY+JbJKDQt07b/npA7YSo/8DlYB
         B9nkCcZ1jAe+wvxDLEReIRD8LUOcWWECLpjCrUz/q1b4CCaqF0CdeZdVJQ/jdukpDxP5
         io3dqTMEuqMkVzviWsGhuWQ64F6qrfcuzfxrHEBM2lbfD0zOriEjKuyGnu+Jc7F2WQzX
         yeYu3ci1u1NQzd80WuNRXpHKwcdiHms+2T5U8qzAXaIfcZ2A0WdQjwZGAePBnViLeuLQ
         f4Qgf2FC4pO9Q/IEdYIyWOncAMIDeZU4o/V5GtN++J2OEWmHki0mhsoQeP7bY5tZ9hib
         Hsww==
X-Gm-Message-State: AOAM532kLkZO7uhCghYif/ZWkP08DYzUlPueUnPjLPxak7spaLKt+hWa
        RQQqSz5Sl27uXbH0xt9udK9N9sap
X-Google-Smtp-Source: ABdhPJxJMQ2HIVK2Gr7fcETnYbjQFf/op/lbHnXKGpT80PYXtWuLyjImpIwypG8c9r9DA27DucHGRg==
X-Received: by 2002:a1c:9e0d:: with SMTP id h13mr923276wme.5.1595882594353;
        Mon, 27 Jul 2020 13:43:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z63sm1154201wmb.2.2020.07.27.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:43:13 -0700 (PDT)
Message-Id: <7b9103cbadfc111755d2db61239fcac4f4d14a33.1595882588.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.git.1595882588.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jul 2020 20:43:08 +0000
Subject: [PATCH 5/5] ref-filter: add `sanitize` option for 'subject' atom
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

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c            | 21 +++++++++++++++++----
 t/t6300-for-each-ref.sh |  7 +++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index d5d5ff6a9d..5f8fc65b68 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -23,6 +23,7 @@
 #include "worktree.h"
 #include "hashmap.h"
 #include "argv-array.h"
+#include "format-support.h"
 
 static struct ref_msg {
 	const char *gone;
@@ -131,7 +132,7 @@ static struct used_atom {
 			unsigned int nobracket : 1, push : 1, push_remote : 1;
 		} remote_ref;
 		struct {
-			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_SUB_SANITIZE, C_TRAILERS } option;
 			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
 		} contents;
@@ -301,8 +302,14 @@ static int body_atom_parser(const struct ref_format *format, struct used_atom *a
 static int subject_atom_parser(const struct ref_format *format, struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
-	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(subject) does not take arguments"));
+	if (arg) {
+		if (!strcmp(arg, "sanitize")) {
+			atom->u.contents.option = C_SUB_SANITIZE;
+			return 0;
+		} else {
+			return strbuf_addf_ret(err, -1, _("unrecognized %%(subject) argument: %s"), arg);
+		}
+	}
 	atom->u.contents.option = C_SUB;
 	return 0;
 }
@@ -1266,11 +1273,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 		struct used_atom *atom = &used_atom[i];
 		const char *name = atom->name;
 		struct atom_value *v = &val[i];
+
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
 			name++;
 		if (strcmp(name, "subject") &&
+		    strcmp(name, "subject:sanitize") &&
 		    strcmp(name, "body") &&
 		    !starts_with(name, "trailers") &&
 		    !starts_with(name, "contents"))
@@ -1283,7 +1292,11 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 
 		if (atom->u.contents.option == C_SUB)
 			v->s = copy_subject(subpos, sublen);
-		else if (atom->u.contents.option == C_BODY_DEP)
+		else if (atom->u.contents.option == C_SUB_SANITIZE) {
+			struct strbuf sb = STRBUF_INIT;
+			format_sanitized_subject(&sb, subpos, sublen);
+			v->s = strbuf_detach(&sb, NULL);
+		} else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
 		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 533827d297..e2dd410356 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -127,6 +127,7 @@ test_atom head taggerdate ''
 test_atom head creator 'C O Mitter <committer@example.com> 1151968723 +0200'
 test_atom head creatordate 'Tue Jul 4 01:18:43 2006 +0200'
 test_atom head subject 'Initial'
+test_atom head subject:sanitize 'Initial'
 test_atom head contents:subject 'Initial'
 test_atom head body ''
 test_atom head contents:body ''
@@ -180,6 +181,7 @@ test_atom tag taggerdate 'Tue Jul 4 01:18:45 2006 +0200'
 test_atom tag creator 'C O Mitter <committer@example.com> 1151968725 +0200'
 test_atom tag creatordate 'Tue Jul 4 01:18:45 2006 +0200'
 test_atom tag subject 'Tagging at 1151968727'
+test_atom tag subject:sanitize 'Tagging-at-1151968727'
 test_atom tag contents:subject 'Tagging at 1151968727'
 test_atom tag body ''
 test_atom tag contents:body ''
@@ -592,6 +594,7 @@ test_expect_success 'create tag with subject and body content' '
 	git tag -F msg subject-body
 '
 test_atom refs/tags/subject-body subject 'the subject line'
+test_atom refs/tags/subject-body subject:sanitize 'the-subject-line'
 test_atom refs/tags/subject-body body 'first body line
 second body line
 '
@@ -612,6 +615,7 @@ test_expect_success 'create tag with multiline subject' '
 	git tag -F msg multiline
 '
 test_atom refs/tags/multiline subject 'first subject line second subject line'
+test_atom refs/tags/multiline subject:sanitize 'first-subject-line-second-subject-line'
 test_atom refs/tags/multiline contents:subject 'first subject line second subject line'
 test_atom refs/tags/multiline body 'first body line
 second body line
@@ -644,6 +648,7 @@ sig='-----BEGIN PGP SIGNATURE-----
 
 PREREQ=GPG
 test_atom refs/tags/signed-empty subject ''
+test_atom refs/tags/signed-empty subject:sanitize ''
 test_atom refs/tags/signed-empty contents:subject ''
 test_atom refs/tags/signed-empty body "$sig"
 test_atom refs/tags/signed-empty contents:body ''
@@ -651,6 +656,7 @@ test_atom refs/tags/signed-empty contents:signature "$sig"
 test_atom refs/tags/signed-empty contents "$sig"
 
 test_atom refs/tags/signed-short subject 'subject line'
+test_atom refs/tags/signed-short subject:sanitize 'subject-line'
 test_atom refs/tags/signed-short contents:subject 'subject line'
 test_atom refs/tags/signed-short body "$sig"
 test_atom refs/tags/signed-short contents:body ''
@@ -659,6 +665,7 @@ test_atom refs/tags/signed-short contents "subject line
 $sig"
 
 test_atom refs/tags/signed-long subject 'subject line'
+test_atom refs/tags/signed-long subject:sanitize 'subject-line'
 test_atom refs/tags/signed-long contents:subject 'subject line'
 test_atom refs/tags/signed-long body "body contents
 $sig"
-- 
gitgitgadget
