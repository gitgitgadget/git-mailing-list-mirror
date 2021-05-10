Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68678C43462
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414A361107
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhEJPZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbhEJPYp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:24:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A804C07E5C1
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:01:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j3-20020a05600c4843b02901484662c4ebso11355281wmo.0
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sHGVRRbCeLF8b+y24TGalW+AkX9fnFVQoZWAt6L5hUc=;
        b=plA4WZNics3OKeQNJNHLl7t5FzKbuDlUpOcmN/UmUm1JOSU4cY1CYEi6150ggoUUNu
         hOMmveoSQ1UpZZHQFm5ltkZf4euiwDmXULb24l6tOsetHSkFCcmGQajhQO1ZcRDjg3fX
         H4ahkqejGRL5iRpf1/CzXmZHFzfEYFmt/SVqRHfoGigdCBN0myUy8GR71oYqdi8IVnjW
         6cxJdgzAuni0D3y05GLDs7Y0isXgzU9hyY7KIWO7aZF7DDgiyexSAfayMc943u+HAcSh
         wvv/t42LOhgswPTzAR8goiGWH/3mAO+Eem0zRMzcxgZorpeiF6SQty5cA9nuZqaI7D1t
         MjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sHGVRRbCeLF8b+y24TGalW+AkX9fnFVQoZWAt6L5hUc=;
        b=WVa54z8E7myo8d7GEJMUmQbfBNmju7XF4iIQfnoswT1Ohaqwx1TZwsoQMK29f2K2+h
         ZlrDliDpbiEtDkY6vK2DRBOrE7iSjMl2/6XUo81wkIZC3BnMgAa6c2ef10jY8q5IMWGm
         OhkuFsbkefwogqnalSXnQetnolhEdqU15o4sHBX8CjG6eJhqdV8GmgRK2QAWaQznjGdd
         IGygYuYqkyvxcXgBXtnNEsWBN+MSwwBkC5fE+tgfND9BE6EI5wzvsBrCQZP3gHRzJRVo
         eqv54AbYaKeEza9jdgvbNQ232qvwYc+duPbyghtwVw6hl6SMUzT4XIX1hZrU9qim6D4S
         MmeA==
X-Gm-Message-State: AOAM533BdHs9nKqNgg+jksxXnyLdQyizdS2PqAggUJfc2XaiKJN0KD/l
        RBnQ0G1hCm/b7AKWIdf0x+Y+xpZrSmc=
X-Google-Smtp-Source: ABdhPJzYKPXFb21KJq6XCLEorgWKON5Y67BDNJryRMoxS7jR+F+zdggjyOWXKxfyhCf++2Ps11oYvA==
X-Received: by 2002:a05:600c:2cd2:: with SMTP id l18mr3643297wmc.142.1620658905753;
        Mon, 10 May 2021 08:01:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10sm24179848wrw.20.2021.05.10.08.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:01:45 -0700 (PDT)
Message-Id: <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com>
In-Reply-To: <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com>
References: <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 May 2021 15:01:43 +0000
Subject: [PATCH v4] [GSOC] ref-filter: fix read invalid union member bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

used_atom.u is an union, and it has different members depending on
what atom the auxiliary data the union part of the "struct
used_atom" wants to record. At most only one of the members can be
valid at any one time. Since the code checks u.remote_ref without
even making sure if the atom is "push" or "push:" (which are only
two cases that u.remote_ref.push becomes valid), but u.remote_ref
shares the same storage for other members of the union, the check
was reading from an invalid member, which was the bug.

Modify the condition here to check whether the atom name
equals to "push" or starts with "push:", to avoid reading the
value of invalid member of the union.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] ref-filter: fix read invalid union member bug
    
    Change from last version:
    Prove that the bug may appear when using %(color) atom. And add
    corresponding test for it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-949%2Fadlternative%2Fref-filter-enum-bug-fix-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-949/adlternative/ref-filter-enum-bug-fix-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/949

Range-diff vs v3:

 1:  21cf7a44e168 ! 1:  8c6c0368a590 [GSOC] ref-filter: fix read invalid union member bug
     @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbu
       			const char *branch_name;
       			v->s = xstrdup("");
       			if (!skip_prefix(ref->refname, "refs/heads/",
     +
     + ## t/t6302-for-each-ref-filter.sh ##
     +@@ t/t6302-for-each-ref-filter.sh: test_expect_success '%(color) must fail' '
     + 	test_must_fail git for-each-ref --format="%(color)%(refname)"
     + '
     + 
     ++test_expect_success '%(color:#aa22ac) must success' '
     ++	cat >expect <<-\EOF &&
     ++	refs/heads/main
     ++	refs/heads/side
     ++	refs/odd/spot
     ++	refs/tags/annotated-tag
     ++	refs/tags/doubly-annotated-tag
     ++	refs/tags/doubly-signed-tag
     ++	refs/tags/four
     ++	refs/tags/one
     ++	refs/tags/signed-tag
     ++	refs/tags/three
     ++	refs/tags/two
     ++	EOF
     ++	git for-each-ref --format="%(color:#aa22ac)%(refname)" >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     + test_expect_success 'left alignment is default' '
     + 	cat >expect <<-\EOF &&
     + 	refname is refs/heads/main    |refs/heads/main


 ref-filter.c                   |  2 +-
 t/t6302-for-each-ref-filter.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index a0adb4551d87..213d3773ada3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1730,7 +1730,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = xstrdup("");
 			continue;
-		} else if (atom->u.remote_ref.push) {
+		} else if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:")) {
 			const char *branch_name;
 			v->s = xstrdup("");
 			if (!skip_prefix(ref->refname, "refs/heads/",
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 9866b1b57368..38a7d83830aa 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -117,6 +117,24 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
 
+test_expect_success '%(color:#aa22ac) must success' '
+	cat >expect <<-\EOF &&
+	refs/heads/main
+	refs/heads/side
+	refs/odd/spot
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(color:#aa22ac)%(refname)" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'left alignment is default' '
 	cat >expect <<-\EOF &&
 	refname is refs/heads/main    |refs/heads/main

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
gitgitgadget
