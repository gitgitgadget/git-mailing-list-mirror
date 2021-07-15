Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547AEC07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D29961374
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbhGOPng (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbhGOPn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2258C061767
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso3965660wmj.0
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=/eivstvOXJvKVWdkJhnzJmSkxFiMa1WMQVdYhPN5R2Y=;
        b=s455+Cvg6pXQ2yTGO4z8F1zLfxn1sO2l1KoKbv3fn2hl1WVFM0pNZvbo4KCmWLIVbV
         BjytePBBeF9YH+L2fdbnAFvCG4xFD5wW2+Q1NgYZzpsyjKRjUQfvf7uBWS5KJsgyVSm6
         bT/p9XgPxTrO1QdQG7a+MdZiRULdh+R3NDD3j91gBAAVvQK6Du33hvSv+195+U0QnAFW
         osqoURK3RUgf0dqEWgUAkEvBH0WpBSC89msrD7c5NqBtGhHhH9gJjjtGkGKcDNU/gm3u
         6GmcLZlr7qEQ/kbE1lN23azH7V/mjOVl0LTnamWWrm0TI8hwRVwmXieFhth7N9fitJvS
         L1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=/eivstvOXJvKVWdkJhnzJmSkxFiMa1WMQVdYhPN5R2Y=;
        b=E9cYexBpOoyS0m/I6rL8lNL6uByvjcj1DBVj2PY7I9TOOUGaQpCKBWhDPzEFfQ2ZrW
         LfzJZkDIgqXFrU4uMyWscz/73cu/ugxaL/FVnJlHRpUxWEwtVlpRBBPVCmwc/PdxumyP
         Cv/cjgMbwMk2GsGQ7FuspWIYWHki5PWavlaTYmZy7a22d+/L+YviXkgXF0bAxLAiaMk9
         O0vSH5OjbLluo10TSrdXZXrA64WBBCH1Gazld5YeaaXU7TjkU5OoGlQIEQfL+KS01nAU
         Yz/hSqfxY8LfzASjDjwXTt1nuKnlFGgNW3RBU3QIDmzOo3njrgrQbPNGPuSxNyOP/0XJ
         /jSA==
X-Gm-Message-State: AOAM533an6mqc0vlVaV7sMgkx8xStSA98Voe981KLO3KLRo6thFGxUWq
        R+eh08ttua94mMfeopJvAydXhPGJOu8=
X-Google-Smtp-Source: ABdhPJzOVfOZXu1KTNbyFjFjqZzoQ69hJ5szfMRyBQjHP0x3eK3POJWd31mUOLiABQ8Gc/19Wr/r7g==
X-Received: by 2002:a1c:48a:: with SMTP id 132mr11296857wme.157.1626363633192;
        Thu, 15 Jul 2021 08:40:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm6709770wrs.22.2021.07.15.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:32 -0700 (PDT)
Message-Id: <bf052cc5d3fce91f84c343e8968aaddd741df630.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:16 +0000
Subject: [PATCH v2 08/17] [GSOC] ref-filter: add cat_file_mode to ref_format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add `cat_file_mode` member to struct `ref_format`. When
`cat-file --batch` use ref-filter logic later, it can help us
reject atoms in verify_ref_format() which cat-file cannot use,
e.g. `%(refname)`, `%(push)`, `%(upstream)"...

Add batch_test_atom() to t/t1006-cat-file.sh and add check
for cat-file --batch, this can help us clearly show which
atoms cat-file accepts and which atoms it rejects.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c        |  23 ++++-
 ref-filter.h        |   1 +
 t/t1006-cat-file.sh | 226 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index d70b295672f..27199ba40f5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1000,9 +1000,24 @@ static const char *find_next(const char *cp)
 	return NULL;
 }
 
-static int reject_atom(enum atom_type atom_type)
-{
-	return atom_type == ATOM_REST;
+static int reject_atom(int cat_file_mode, enum atom_type atom_type)
+{
+	if (!cat_file_mode)
+		return atom_type == ATOM_REST;
+
+	/* cat_file_mode */
+	switch (atom_type) {
+	case ATOM_FLAG:
+	case ATOM_HEAD:
+	case ATOM_PUSH:
+	case ATOM_REFNAME:
+	case ATOM_SYMREF:
+	case ATOM_UPSTREAM:
+	case ATOM_WORKTREEPATH:
+		return 1;
+	default:
+		return 0;
+	}
 }
 
 /*
@@ -1025,7 +1040,7 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
-		if (reject_atom(used_atom[at].atom_type))
+		if (reject_atom(format->cat_file_mode, used_atom[at].atom_type))
 			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
 
 		if ((format->quote_style == QUOTE_PYTHON ||
diff --git a/ref-filter.h b/ref-filter.h
index 44e6dc05ac2..053980a6a42 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -78,6 +78,7 @@ struct ref_format {
 	 */
 	const char *format;
 	const char *rest;
+	int cat_file_mode;
 	int quote_style;
 	int use_rest;
 	int use_color;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 18b3779ccb6..95d760652eb 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -608,4 +608,230 @@ test_expect_success 'cat-file --batch="batman" with --batch-all-objects will wor
 	cmp expect actual
 '
 
+. "$TEST_DIRECTORY"/lib-gpg.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+
+test_expect_success 'cat-file --batch|--batch-check setup' '
+	echo 1>blob1 &&
+	printf "a\0b\0\c" >blob2 &&
+	git add blob1 blob2 &&
+	git commit -m "Commit Message" &&
+	git branch -M main &&
+	git tag -a -m "v0.0.0" testtag &&
+	git update-ref refs/myblobs/blob1 HEAD:blob1 &&
+	git update-ref refs/myblobs/blob2 HEAD:blob2 &&
+	git update-ref refs/mytrees/tree1 HEAD^{tree}
+'
+
+batch_test_atom() {
+	if test "$3" = "fail"
+	then
+		test_expect_${4:-success} $PREREQ "basic atom: $1 $2 must fail" "
+			test_must_fail git cat-file --batch-check='$2' >bad <<-EOF
+			$1
+			EOF
+		"
+	else
+		test_expect_${4:-success} $PREREQ "basic atom: $1 $2" "
+			git for-each-ref --format='$2' $1 >expected &&
+			git cat-file --batch-check='$2' >actual <<-EOF &&
+			$1
+			EOF
+			sanitize_pgp <actual >actual.clean &&
+			cmp expected actual.clean
+		"
+	fi
+}
+
+batch_test_atom refs/heads/main '%(refname)' fail
+batch_test_atom refs/heads/main '%(refname:)' fail
+batch_test_atom refs/heads/main '%(refname:short)' fail
+batch_test_atom refs/heads/main '%(refname:lstrip=1)' fail
+batch_test_atom refs/heads/main '%(refname:lstrip=2)' fail
+batch_test_atom refs/heads/main '%(refname:lstrip=-1)' fail
+batch_test_atom refs/heads/main '%(refname:lstrip=-2)' fail
+batch_test_atom refs/heads/main '%(refname:rstrip=1)' fail
+batch_test_atom refs/heads/main '%(refname:rstrip=2)' fail
+batch_test_atom refs/heads/main '%(refname:rstrip=-1)' fail
+batch_test_atom refs/heads/main '%(refname:rstrip=-2)' fail
+batch_test_atom refs/heads/main '%(refname:strip=1)' fail
+batch_test_atom refs/heads/main '%(refname:strip=2)' fail
+batch_test_atom refs/heads/main '%(refname:strip=-1)' fail
+batch_test_atom refs/heads/main '%(refname:strip=-2)' fail
+batch_test_atom refs/heads/main '%(upstream)' fail
+batch_test_atom refs/heads/main '%(upstream:short)' fail
+batch_test_atom refs/heads/main '%(upstream:lstrip=2)' fail
+batch_test_atom refs/heads/main '%(upstream:lstrip=-2)' fail
+batch_test_atom refs/heads/main '%(upstream:rstrip=2)' fail
+batch_test_atom refs/heads/main '%(upstream:rstrip=-2)' fail
+batch_test_atom refs/heads/main '%(upstream:strip=2)' fail
+batch_test_atom refs/heads/main '%(upstream:strip=-2)' fail
+batch_test_atom refs/heads/main '%(push)' fail
+batch_test_atom refs/heads/main '%(push:short)' fail
+batch_test_atom refs/heads/main '%(push:lstrip=1)' fail
+batch_test_atom refs/heads/main '%(push:lstrip=-1)' fail
+batch_test_atom refs/heads/main '%(push:rstrip=1)' fail
+batch_test_atom refs/heads/main '%(push:rstrip=-1)' fail
+batch_test_atom refs/heads/main '%(push:strip=1)' fail
+batch_test_atom refs/heads/main '%(push:strip=-1)' fail
+batch_test_atom refs/heads/main '%(objecttype)'
+batch_test_atom refs/heads/main '%(objectsize)'
+batch_test_atom refs/heads/main '%(objectsize:disk)'
+batch_test_atom refs/heads/main '%(deltabase)'
+batch_test_atom refs/heads/main '%(objectname)'
+batch_test_atom refs/heads/main '%(objectname:short)' fail
+batch_test_atom refs/heads/main '%(objectname:short=1)' fail
+batch_test_atom refs/heads/main '%(objectname:short=10)' fail
+batch_test_atom refs/heads/main '%(tree)' fail
+batch_test_atom refs/heads/main '%(tree:short)' fail
+batch_test_atom refs/heads/main '%(tree:short=1)' fail
+batch_test_atom refs/heads/main '%(tree:short=10)' fail
+batch_test_atom refs/heads/main '%(parent)' fail
+batch_test_atom refs/heads/main '%(parent:short)' fail
+batch_test_atom refs/heads/main '%(parent:short=1)' fail
+batch_test_atom refs/heads/main '%(parent:short=10)' fail
+batch_test_atom refs/heads/main '%(numparent)' fail
+batch_test_atom refs/heads/main '%(object)' fail
+batch_test_atom refs/heads/main '%(type)' fail
+batch_test_atom refs/heads/main '%(raw)' fail
+batch_test_atom refs/heads/main '%(*objectname)' fail
+batch_test_atom refs/heads/main '%(*objecttype)' fail
+batch_test_atom refs/heads/main '%(author)' fail
+batch_test_atom refs/heads/main '%(authorname)' fail
+batch_test_atom refs/heads/main '%(authoremail)' fail
+batch_test_atom refs/heads/main '%(authoremail:trim)' fail
+batch_test_atom refs/heads/main '%(authoremail:localpart)' fail
+batch_test_atom refs/heads/main '%(authordate)' fail
+batch_test_atom refs/heads/main '%(committer)' fail
+batch_test_atom refs/heads/main '%(committername)' fail
+batch_test_atom refs/heads/main '%(committeremail)' fail
+batch_test_atom refs/heads/main '%(committeremail:trim)' fail
+batch_test_atom refs/heads/main '%(committeremail:localpart)' fail
+batch_test_atom refs/heads/main '%(committerdate)' fail
+batch_test_atom refs/heads/main '%(tag)' fail
+batch_test_atom refs/heads/main '%(tagger)' fail
+batch_test_atom refs/heads/main '%(taggername)' fail
+batch_test_atom refs/heads/main '%(taggeremail)' fail
+batch_test_atom refs/heads/main '%(taggeremail:trim)' fail
+batch_test_atom refs/heads/main '%(taggeremail:localpart)' fail
+batch_test_atom refs/heads/main '%(taggerdate)' fail
+batch_test_atom refs/heads/main '%(creator)' fail
+batch_test_atom refs/heads/main '%(creatordate)' fail
+batch_test_atom refs/heads/main '%(subject)' fail
+batch_test_atom refs/heads/main '%(subject:sanitize)' fail
+batch_test_atom refs/heads/main '%(contents:subject)' fail
+batch_test_atom refs/heads/main '%(body)' fail
+batch_test_atom refs/heads/main '%(contents:body)' fail
+batch_test_atom refs/heads/main '%(contents:signature)' fail
+batch_test_atom refs/heads/main '%(contents)' fail
+batch_test_atom refs/heads/main '%(HEAD)' fail
+batch_test_atom refs/heads/main '%(upstream:track)' fail
+batch_test_atom refs/heads/main '%(upstream:trackshort)' fail
+batch_test_atom refs/heads/main '%(upstream:track,nobracket)' fail
+batch_test_atom refs/heads/main '%(upstream:nobracket,track)' fail
+batch_test_atom refs/heads/main '%(push:track)' fail
+batch_test_atom refs/heads/main '%(push:trackshort)' fail
+batch_test_atom refs/heads/main '%(worktreepath)' fail
+batch_test_atom refs/heads/main '%(symref)' fail
+batch_test_atom refs/heads/main '%(flag)' fail
+
+batch_test_atom refs/tags/testtag '%(refname)' fail
+batch_test_atom refs/tags/testtag '%(refname:short)' fail
+batch_test_atom refs/tags/testtag '%(upstream)' fail
+batch_test_atom refs/tags/testtag '%(push)' fail
+batch_test_atom refs/tags/testtag '%(objecttype)'
+batch_test_atom refs/tags/testtag '%(objectsize)'
+batch_test_atom refs/tags/testtag '%(objectsize:disk)'
+batch_test_atom refs/tags/testtag '%(*objectsize:disk)' fail
+batch_test_atom refs/tags/testtag '%(deltabase)'
+batch_test_atom refs/tags/testtag '%(*deltabase)' fail
+batch_test_atom refs/tags/testtag '%(objectname)'
+batch_test_atom refs/tags/testtag '%(objectname:short)' fail
+batch_test_atom refs/tags/testtag '%(tree)' fail
+batch_test_atom refs/tags/testtag '%(tree:short)' fail
+batch_test_atom refs/tags/testtag '%(tree:short=1)' fail
+batch_test_atom refs/tags/testtag '%(tree:short=10)' fail
+batch_test_atom refs/tags/testtag '%(parent)' fail
+batch_test_atom refs/tags/testtag '%(parent:short)' fail
+batch_test_atom refs/tags/testtag '%(parent:short=1)' fail
+batch_test_atom refs/tags/testtag '%(parent:short=10)' fail
+batch_test_atom refs/tags/testtag '%(numparent)' fail
+batch_test_atom refs/tags/testtag '%(object)' fail
+batch_test_atom refs/tags/testtag '%(type)' fail
+batch_test_atom refs/tags/testtag '%(*objectname)' fail
+batch_test_atom refs/tags/testtag '%(*objecttype)' fail
+batch_test_atom refs/tags/testtag '%(author)' fail
+batch_test_atom refs/tags/testtag '%(authorname)' fail
+batch_test_atom refs/tags/testtag '%(authoremail)' fail
+batch_test_atom refs/tags/testtag '%(authoremail:trim)' fail
+batch_test_atom refs/tags/testtag '%(authoremail:localpart)' fail
+batch_test_atom refs/tags/testtag '%(authordate)' fail
+batch_test_atom refs/tags/testtag '%(committer)' fail
+batch_test_atom refs/tags/testtag '%(committername)' fail
+batch_test_atom refs/tags/testtag '%(committeremail)' fail
+batch_test_atom refs/tags/testtag '%(committeremail:trim)' fail
+batch_test_atom refs/tags/testtag '%(committeremail:localpart)' fail
+batch_test_atom refs/tags/testtag '%(committerdate)' fail
+batch_test_atom refs/tags/testtag '%(tag)' fail
+batch_test_atom refs/tags/testtag '%(tagger)' fail
+batch_test_atom refs/tags/testtag '%(taggername)' fail
+batch_test_atom refs/tags/testtag '%(taggeremail)' fail
+batch_test_atom refs/tags/testtag '%(taggeremail:trim)' fail
+batch_test_atom refs/tags/testtag '%(taggeremail:localpart)' fail
+batch_test_atom refs/tags/testtag '%(taggerdate)' fail
+batch_test_atom refs/tags/testtag '%(creator)' fail
+batch_test_atom refs/tags/testtag '%(creatordate)' fail
+batch_test_atom refs/tags/testtag '%(subject)' fail
+batch_test_atom refs/tags/testtag '%(subject:sanitize)' fail
+batch_test_atom refs/tags/testtag '%(contents:subject)' fail
+batch_test_atom refs/tags/testtag '%(body)' fail
+batch_test_atom refs/tags/testtag '%(contents:body)' fail
+batch_test_atom refs/tags/testtag '%(contents:signature)' fail
+batch_test_atom refs/tags/testtag '%(contents)' fail
+batch_test_atom refs/tags/testtag '%(HEAD)' fail
+
+batch_test_atom refs/myblobs/blob1 '%(refname)' fail
+batch_test_atom refs/myblobs/blob1 '%(upstream)' fail
+batch_test_atom refs/myblobs/blob1 '%(push)' fail
+batch_test_atom refs/myblobs/blob1 '%(HEAD)' fail
+
+batch_test_atom refs/myblobs/blob1 '%(objectname)'
+batch_test_atom refs/myblobs/blob1 '%(objecttype)'
+batch_test_atom refs/myblobs/blob1 '%(objectsize)'
+batch_test_atom refs/myblobs/blob1 '%(objectsize:disk)'
+batch_test_atom refs/myblobs/blob1 '%(deltabase)'
+
+batch_test_atom refs/myblobs/blob1 '%(contents)' fail
+batch_test_atom refs/myblobs/blob2 '%(contents)' fail
+
+batch_test_atom refs/myblobs/blob1 '%(raw)' fail
+batch_test_atom refs/myblobs/blob2 '%(raw)' fail
+batch_test_atom refs/mytrees/tree1 '%(raw)' fail
+
+batch_test_atom refs/myblobs/blob1 '%(raw:size)' fail
+batch_test_atom refs/myblobs/blob2 '%(raw:size)' fail
+batch_test_atom refs/mytrees/tree1 '%(raw:size)' fail
+
+batch_test_atom refs/myblobs/blob1 '%(if:equals=blob)%(objecttype)%(then)commit%(else)not commit%(end)' fail
+batch_test_atom refs/myblobs/blob2 '%(if:equals=blob)%(objecttype)%(then)commit%(else)not commit%(end)' fail
+batch_test_atom refs/mytrees/tree1 '%(if:equals=tree)%(objecttype)%(then)tree%(else)not tree%(end)' fail
+
+batch_test_atom refs/heads/main '%(align:60) objectname is %(objectname)%(end)|%(objectname)' fail
+batch_test_atom refs/heads/main '%(align:left,60) objectname is %(objectname)%(end)|%(objectname)' fail
+batch_test_atom refs/heads/main '%(align:middle,60) objectname is %(objectname)%(end)|%(objectname)' fail
+batch_test_atom refs/heads/main '%(align:60,right) objectname is %(objectname)%(end)|%(objectname)' fail
+
+batch_test_atom refs/heads/main 'VALID'
+batch_test_atom refs/heads/main '%(INVALID)' fail
+batch_test_atom refs/heads/main '%(authordate:INVALID)' fail
+
+batch_test_atom refs/heads/main '%(objectname) %(objecttype) %(objectsize)
+%(raw)' fail
+batch_test_atom refs/tags/testtag '%(objectname) %(objecttype) %(objectsize)
+%(raw)' fail
+batch_test_atom refs/myblobs/blob1 '%(objectname) %(objecttype) %(objectsize)
+%(raw)' fail
+batch_test_atom refs/myblobs/blob2 '%(objectname) %(objecttype) %(objectsize)
+%(raw)' fail
+
 test_done
-- 
gitgitgadget

