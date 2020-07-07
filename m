Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC893C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56F420675
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlAH8ABh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGGRlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgGGRlO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 13:41:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2037CC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 10:41:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so38057818wrs.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFLvt3WUQ34Pwh87a7G9wDA/qQQvPUws3hMQRTDa0mk=;
        b=dlAH8ABh5fKIktjVQNsUaWGrMyKuOd/3iKFVI19yGZzKWerkEa0d2o0V5NYrWTtTMh
         85R/0sNAzoz/JAam+EOJCp2nYFeTQ7eVJWDjx+V8Se7Dfjbq1je8uF+Y9oYf3F6uH5vV
         /q+UEQ+yTfXG5foAu9HRT+zan/5kPfuKqU6S6s/kpHCH/lOh0kZFK7XYIB0Az3jP3qIg
         csu9w0PeJFO5apaLU9Ch6dwXq0K+8DYM18M3NpeqjaxaOIv9LsVpXb1uag/rkJEZyhJ0
         y5V6nRiZoogHHnfo+jyiLsTAc2Tx0VKdvaYehUSqWH6BgW6oSoC1K5mZ8QkNRHXbXSp0
         e2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFLvt3WUQ34Pwh87a7G9wDA/qQQvPUws3hMQRTDa0mk=;
        b=W5yclSr7s7QcKYdcm3aBo2TwSazJWwVfk6GYiHCR02Zi+bW/7H65MsH8DVTbEubzRV
         URuhUu/eue99+lO4Wt749/7u/nmb4iZU66hP/KW5RgMYHldpdeYtqTdVAhmmW0w2XdzD
         JDBqDmBNUJoTXy8awTsYcOspe02UVQW/z4NEFhsoeOXwnr/6vf8G4hpxnhyHjGqri9B5
         4jneKR2mONSvdvpTX+oeaVPjYeA6XpGZsWgOAO4tNjN6Vfkh24N83oN7UQIyONSGwHd0
         cctXihNKLaXBWfMlNZZu5rjTbl2gqSBPkWTsTFwghWPxe3ZT4AeVHtQ2tGH0BVcDZgoz
         dvjA==
X-Gm-Message-State: AOAM531SkjfIiSupr3x5hX48+39wD/H+my752SYvSMKDluopeYWdiFPB
        ldTLcBeQX+QWAU8DnCMuAr16Ujpo8lA=
X-Google-Smtp-Source: ABdhPJxZ7shE2eks4GJQ6udp3ECvA1asoYjPTx1i+C/a10VZ1lvLgj8FYZnpVnk+82YqSJGO8Of46g==
X-Received: by 2002:adf:e482:: with SMTP id i2mr54144653wrm.75.1594143672447;
        Tue, 07 Jul 2020 10:41:12 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.97])
        by smtp.gmail.com with ESMTPSA id c194sm1977405wme.8.2020.07.07.10.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:41:12 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/4] ref-filter: add support for %(contents:size)
Date:   Tue,  7 Jul 2020 19:40:49 +0200
Message-Id: <20200707174049.21714-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.460.g66f3a24dd5
In-Reply-To: <20200707174049.21714-1-chriscool@tuxfamily.org>
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's useful and efficient to be able to get the size of the
contents directly without having to pipe through `wc -c`.

Also the result of the following:

`git for-each-ref --format='%(contents)' refs/heads/my-branch | wc -c`

is off by one as `git for-each-ref` appends a newline character
after the contents, which can be seen by comparing its output
with the output from `git cat-file`.

As with %(contents), %(contents:size) is silently ignored, if a
ref points to something other than a commit or a tag:

```
$ git update-ref refs/mytrees/first HEAD^{tree}
$ git for-each-ref --format='%(contents)' refs/mytrees/first

$ git for-each-ref --format='%(contents:size)' refs/mytrees/first

```

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       |  7 ++++++-
 t/t6300-for-each-ref.sh            | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 788258c3ad..049bc93e6a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -236,6 +236,9 @@ The complete message (subject, body, trailers and signature) of a
 commit or tag object is `contents`. This field can also be used in the
 following ways:
 
+contents:size::
+	The size in bytes of the complete message.
+
 contents:subject::
 	The "subject" of the commit or tag message.  It's actually the
 	concatenation of all lines of the commit message up to the
diff --git a/ref-filter.c b/ref-filter.c
index 8447cb09be..8ec28f0535 100644
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
index 371e45e5ad..b580e27a32 100755
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
 
 test_expect_success 'set up refs pointing to tree and blob' '
 	git update-ref refs/mytrees/first refs/heads/master^{tree} &&
@@ -664,6 +681,7 @@ test_atom refs/mytrees/first body ""
 test_atom refs/mytrees/first contents:body ""
 test_atom refs/mytrees/first contents:signature ""
 test_atom refs/mytrees/first contents ""
+test_atom refs/mytrees/first contents:size ""
 
 test_atom refs/myblobs/first subject ""
 test_atom refs/myblobs/first contents:subject ""
@@ -671,6 +689,7 @@ test_atom refs/myblobs/first body ""
 test_atom refs/myblobs/first contents:body ""
 test_atom refs/myblobs/first contents:signature ""
 test_atom refs/myblobs/first contents ""
+test_atom refs/myblobs/first contents:size ""
 
 test_expect_success 'set up multiple-sort tags' '
 	for when in 100000 200000
-- 
2.27.0.460.g66f3a24dd5

