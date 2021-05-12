Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A30C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2441613EB
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhELMOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 08:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhELMOC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 08:14:02 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DCAC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 05:12:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o127so12809199wmo.4
        for <git@vger.kernel.org>; Wed, 12 May 2021 05:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QkrVTdC7QMjTnJm+TEaGuH27onH93mve8lC7XX8Jn+g=;
        b=EgwnA43PLuNdFYvEsQpVTGplgCTxxG0zDQRw8B78d8RrCErm/0zSXu97Iasb1jn9K4
         ivEj88dD7UomxosD3iJMknRdjdBqkzGA87PiAjPQctCerxPq//VfRBn78HOeY92QQRGi
         WW+daUbvFuucEYhk8eyGEOECfaJmgEiLhsSaTQN7qzHaTaLMPvsG6LYVHYzh9x6+NoY2
         oiGfnvgfQd/+ltv8edYK4+jcTAZijkcOXAfC4jRL1BWpA005Oq+Xn8AVkkErtZ7CXV6r
         bogrozp9nc+Cqz3INFP96zninrbJ9w8rREHxS/lfgNvVrExH76qUl5quEFZVSHj51M7j
         ZNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QkrVTdC7QMjTnJm+TEaGuH27onH93mve8lC7XX8Jn+g=;
        b=Q9fxZkJiS914na+Re3tgiCffX78PnAv3Ip2SOawOYnCAMQQOHEgD+GmunooDuSr1tz
         nLczVIhZjym8n7Qd+8HvAhPDELAiOG0o86+e73+Dqq8w1DrZB1YMXtF/hMGhbBUXbHtF
         YrFgJDK+CyuavKzbsPK4XZLzGsNd3Ck1lGS7r/+jCY3yp4E57jCHfN+7/Dtd5kEFgSgk
         t5LT4WFri/hHO7iJHmr1FBgYBQRgWMrHWWazISECwp8ZHopKsMFcthbIcR3Fp+oTZks1
         kQTIaw2JGy8HGXSzAKtO67FTE86poonR6URffTHhzQFgiO12kg391UwhJCeTToIl9ndN
         X30w==
X-Gm-Message-State: AOAM531vVvzfRECjk3WnXTCS7ygsSAq/UaK033UzHTOQfAHX4cqZqLSV
        fA7/LZ9YrFR6UrPxZcsv6jgUYJ0Qw1U=
X-Google-Smtp-Source: ABdhPJxmm1YoZMZmb50lin56nozrOyIcd6UHZVabAk6L42YCn5Qjqb4rp/hnazEvuliMYIFLaW5RdQ==
X-Received: by 2002:a05:600c:4a19:: with SMTP id c25mr38195233wmp.94.1620821572991;
        Wed, 12 May 2021 05:12:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm34944629wrq.45.2021.05.12.05.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 05:12:52 -0700 (PDT)
Message-Id: <pull.949.v6.git.1620821572126.gitgitgadget@gmail.com>
In-Reply-To: <pull.949.v5.git.1620747320947.gitgitgadget@gmail.com>
References: <pull.949.v5.git.1620747320947.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 12:12:51 +0000
Subject: [PATCH v6] [GSOC] ref-filter: fix read invalid union member bug
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
    
    Change from last version: Modify the test content to make the test more
    correct and complete.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-949%2Fadlternative%2Fref-filter-enum-bug-fix-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-949/adlternative/ref-filter-enum-bug-fix-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/949

Range-diff vs v5:

 1:  b546477e8c87 ! 1:  518cc41a78a4 [GSOC] ref-filter: fix read invalid union member bug
     @@ t/t6302-for-each-ref-filter.sh: test_expect_success '%(color) must fail' '
       	test_must_fail git for-each-ref --format="%(color)%(refname)"
       '
       
     -+test_expect_success '%(color:#aa22ac) must successed' '
     -+	test_when_finished "cd .. && rm -rf ./test" &&
     ++test_expect_success '%(color:#aa22ac) must succeed' '
      +	mkdir test &&
     -+	cd test &&
     -+	git init &&
     -+	cat >expect <<-\EOF &&
     -+	refs/heads/main
     -+	EOF
     -+	git add . &&
     -+	git branch -M main &&
     -+	git commit -m "test" &&
     -+	git remote add origin nowhere &&
     -+	git config branch.main.remote origin &&
     -+	git config branch.main.merge refs/heads/main &&
     -+	git for-each-ref --format="%(color:#aa22ac)%(refname)" >actual &&
     -+	test_cmp expect actual
     ++	git init test &&
     ++	(
     ++		cd test &&
     ++		test_commit initial &&
     ++		git branch -M main &&
     ++		cat >expect <<-\EOF &&
     ++		refs/heads/main
     ++		refs/tags/initial
     ++		EOF
     ++		git remote add origin nowhere &&
     ++		git config branch.main.remote origin &&
     ++		git config branch.main.merge refs/heads/main &&
     ++		git for-each-ref --format="%(color:#aa22ac)%(refname)" >actual &&
     ++		test_cmp expect actual
     ++	)
      +'
      +
       test_expect_success 'left alignment is default' '


 ref-filter.c                   |  2 +-
 t/t6302-for-each-ref-filter.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

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
index 9866b1b57368..b64abe4184b8 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -117,6 +117,25 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
 
+test_expect_success '%(color:#aa22ac) must succeed' '
+	mkdir test &&
+	git init test &&
+	(
+		cd test &&
+		test_commit initial &&
+		git branch -M main &&
+		cat >expect <<-\EOF &&
+		refs/heads/main
+		refs/tags/initial
+		EOF
+		git remote add origin nowhere &&
+		git config branch.main.remote origin &&
+		git config branch.main.merge refs/heads/main &&
+		git for-each-ref --format="%(color:#aa22ac)%(refname)" >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'left alignment is default' '
 	cat >expect <<-\EOF &&
 	refname is refs/heads/main    |refs/heads/main

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
gitgitgadget
