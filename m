Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7959C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 14:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF6520899
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 14:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmVf+Y8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgGBOJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgGBOJF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 10:09:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E32C08C5DC
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 07:09:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g75so26930525wme.5
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7Gbrvm7nkFASYvPgsxsuk798cTHQnZUNF7M0YuOaiM=;
        b=pmVf+Y8jKrjYXsorhrWPqQp/Fm4A3tr2iEZ5l+0XAVTGe3zGYThdXr+ixk7BDDojDZ
         tXDe0nsL2UVJbo9T17KviOoWj3dm+iX2Voo2riN3rW+lhqExAwF81VnS8TxTLBgrD2Vp
         wBJMOWCp6sknQGKmKxMRuoihyscutNQMxfBNgvUpJpG2dqNqkfrsLjdFgdKGqFWkzq3d
         MHSjIBT7hE8SEZSoXO8xKVFIGZH6qGDUcYNJG3HfznXPaAyecuPyUCLWI71WWGsamTZi
         k8rUD6IN8CKxUM1l+10vx4WEz9xSM4z/rZ7+GTPJd0DWLlpWbt/74IkIP23CfPHOOU2M
         0GOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7Gbrvm7nkFASYvPgsxsuk798cTHQnZUNF7M0YuOaiM=;
        b=LDXlpbHjUwhQdfhBXhYBPzuxDT8BnSuLiZkt1S5o+eEZKLrzMDXJR3ZhnjI0Pu0Q67
         OavzIJidYB51GImzK1UJ7Gvn5yxxBbAJ2JNBocwjpcri3Aoo77gOS/JCd7cBQDJ+/OQk
         XeNDuma769tQAHDkUWU3ImucINUMuZALBq8Sxjp00utKxeNKdDb01GS5d0QvTf1aHUY3
         SuFDU0+HyKEYG10S1n56JymML7dZ4q0fZfUxcDbNB05P3eot7wYv3OtalEI1nru4SiyO
         BZJBy7P2B+auI0PmPC10EjdwfUhFin8Cw6bMUK2bfJgiG3PpU7pFPyn/Tp6rYkE8Bqn+
         c0qw==
X-Gm-Message-State: AOAM5339UstGhYWsXieCA5/RADuzAt+CRz8kF1uqIfMpiQZBftcgAysf
        UXM21Sq/BhVcgnZETtY9+99uT1ORVYk=
X-Google-Smtp-Source: ABdhPJwbMCSpNxDdkIMX0LQEUhD8ZYYa1y0J2QkkDDSdWDfvfS/ECWlwfZ4ctz2U+06vP+HaTNleNw==
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr31522122wmb.87.1593698942399;
        Thu, 02 Jul 2020 07:09:02 -0700 (PDT)
Received: from localhost.localdomain ([193.57.125.121])
        by smtp.gmail.com with ESMTPSA id p17sm10265038wma.47.2020.07.02.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:09:01 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/2] ref-filter: add support for %(contents:size)
Date:   Thu,  2 Jul 2020 16:08:45 +0200
Message-Id: <20200702140845.24945-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.221.ga08a83db2b.dirty
In-Reply-To: <20200702140845.24945-1-chriscool@tuxfamily.org>
References: <20200702140845.24945-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's useful and efficient to be able to get the size of the
contents directly without having to pipe through `wc -c`.

Also the result of the following:

`git for-each-ref --format='%(contents)' | wc -c`

is off by one as `git for-each-ref` appends a newline character
after the contents, which can be seen by comparing its ouput
with the output from `git cat-file`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       |  7 ++++++-
 t/t6300-for-each-ref.sh            | 17 +++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2db9779d54..833641eacd 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -235,6 +235,9 @@ and `date` to extract the named component.
 The complete message of a commit or tag object is `contents`. This
 field can also be used in the following ways:
 
+contents:size::
+	The size in bytes of the complete message.
+
 contents:subject::
 	The "subject" of the commit or tag message.  It's actually the
 	concatenation of all lines of the commit message up to the
diff --git a/ref-filter.c b/ref-filter.c
index bf7b70299b..036a95d0d2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -127,7 +127,8 @@ static struct used_atom {
 			unsigned int nobracket : 1, push : 1, push_remote : 1;
 		} remote_ref;
 		struct {
-			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH,
+			       C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
 			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
 		} contents;
@@ -338,6 +339,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 		atom->u.contents.option = C_BARE;
 	else if (!strcmp(arg, "body"))
 		atom->u.contents.option = C_BODY;
+	else if (!strcmp(arg, "size"))
+		atom->u.contents.option = C_LENGTH;
 	else if (!strcmp(arg, "signature"))
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
@@ -1253,6 +1256,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			v->s = copy_subject(subpos, sublen);
 		else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
+		else if (atom->u.contents.option == C_LENGTH)
+			v->s = xstrfmt("%ld", strlen(subpos));
 		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
 		else if (atom->u.contents.option == C_SIG)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index da59fadc5d..ceee8d9372 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -125,6 +125,7 @@ test_atom head contents:body ''
 test_atom head contents:signature ''
 test_atom head contents 'Initial
 '
+test_atom head contents:size '8'
 test_atom head HEAD '*'
 
 test_atom tag refname refs/tags/testtag
@@ -170,6 +171,7 @@ test_atom tag contents:body ''
 test_atom tag contents:signature ''
 test_atom tag contents 'Tagging at 1151968727
 '
+test_atom tag contents:size '22'
 test_atom tag HEAD ' '
 
 test_expect_success 'Check invalid atoms names are errors' '
@@ -580,6 +582,7 @@ test_atom refs/tags/subject-body contents 'the subject line
 first body line
 second body line
 '
+test_atom refs/tags/subject-body contents:size '51'
 
 test_expect_success 'create tag with multiline subject' '
 	cat >msg <<-\EOF &&
@@ -606,6 +609,7 @@ second subject line
 first body line
 second body line
 '
+test_atom refs/tags/multiline contents:size '73'
 
 test_expect_success GPG 'create signed tags' '
 	git tag -s -m "" signed-empty &&
@@ -622,6 +626,16 @@ sig='-----BEGIN PGP SIGNATURE-----
 -----END PGP SIGNATURE-----
 '
 
+# We cannot use test_atom to check contents:size of signed tags due to sanitize_pgp
+test_tag_contents_size_pgp () {
+	ref="$1"
+	test_expect_success $PREREQ "basic atom: $ref contents:size" "
+		git cat-file tag $ref | tail -n +6 | wc -c >expected &&
+		git for-each-ref --format='%(contents:size)' $ref >actual &&
+		test_cmp expected actual
+	"
+}
+
 PREREQ=GPG
 test_atom refs/tags/signed-empty subject ''
 test_atom refs/tags/signed-empty contents:subject ''
@@ -629,6 +643,7 @@ test_atom refs/tags/signed-empty body "$sig"
 test_atom refs/tags/signed-empty contents:body ''
 test_atom refs/tags/signed-empty contents:signature "$sig"
 test_atom refs/tags/signed-empty contents "$sig"
+test_tag_contents_size_pgp refs/tags/signed-empty
 
 test_atom refs/tags/signed-short subject 'subject line'
 test_atom refs/tags/signed-short contents:subject 'subject line'
@@ -637,6 +652,7 @@ test_atom refs/tags/signed-short contents:body ''
 test_atom refs/tags/signed-short contents:signature "$sig"
 test_atom refs/tags/signed-short contents "subject line
 $sig"
+test_tag_contents_size_pgp refs/tags/signed-short
 
 test_atom refs/tags/signed-long subject 'subject line'
 test_atom refs/tags/signed-long contents:subject 'subject line'
@@ -649,6 +665,7 @@ test_atom refs/tags/signed-long contents "subject line
 
 body contents
 $sig"
+test_tag_contents_size_pgp refs/tags/signed-long
 
 test_expect_success 'set up multiple-sort tags' '
 	for when in 100000 200000
-- 
2.27.0.221.ga08a83db2b.dirty

