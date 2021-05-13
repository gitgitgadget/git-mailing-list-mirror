Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA83C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E07D610A7
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhEMPOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhEMPOs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 11:14:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59170C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:13:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x5so27232116wrv.13
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iApMh796RzvmxaOZiGqAzkVfwVfcRYXB6hPZhefkNx8=;
        b=G4awlQvwgrVTlzwj5Jz+5ivnh2TMKnoq/D+/QqTCTrOP6cdTISJHDfiyhshcXdIFd7
         kZ5XcxaiHgx1iVtGzxfmaV8Nx57SYaVXEYP/WPmnbWiAmJ1bWL/jwY95stUW3ijo90fL
         CZNGyONNmMXpdWT64sN3MnHDM+up7fjbTwJzuxYmq0zkABrPvJDz9w4P730XOBfj3arL
         KnYBzBEUB/gUsvKiCjU9LQ2XJTg76/jCuqM72Sded3/1yCyK7/V6TEteFtbr1lzO0O8R
         rY7Nyo6enluY0dv9fWkNHTbJ8VAZZTWQiTR+PKXvVq/ZyZ+DgR1/lRf4H8XbwzrukxAn
         8BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iApMh796RzvmxaOZiGqAzkVfwVfcRYXB6hPZhefkNx8=;
        b=Tz9FXl8+JWlUwqEl8bJqVQ3RqOgWqZduiiMo2dxVeV+xqC+HsjBiwNlPEF1XanUghv
         soBEyOvs8thKWvlXV5arQCOpnomp2WX0xn+kg4WEEnrj0T9vGDs4iuT/jJ4GnauZr+IF
         I0BQvHO4il59QF9esMIYiuVVpy0FUMU6EBPCOpylzXatamJfDssh9j3kEfp3SDn9SFmF
         fRXcR4FLl0WbM9rTC5vTppA+pBBFe2UF3U75TisV6NS9w9vYJzeAehTSuIj6EED4VMon
         f2M8+BA/mpgfsIDh0y6c6hi2unwJBYAhseA1nUQoKqQFmKyauGko1lqkYI4iCWd5hFnL
         +ARw==
X-Gm-Message-State: AOAM530W8lL6U7QtkXyP/8kMHktwJ9Tcl9ZwvUKQUWJFWPwC4cLLDPDs
        xzTNlRM/4BXSARkyRmT7iUm8IUJC4LM=
X-Google-Smtp-Source: ABdhPJw6VUOH1UE+LdLAiPoUfjaW+Af6MoUImqPXHeBKwzLAkGNltoF38BktKjY7Yc8WhUPhO0KWrw==
X-Received: by 2002:adf:ef90:: with SMTP id d16mr52408107wro.359.1620918816051;
        Thu, 13 May 2021 08:13:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm3067752wru.64.2021.05.13.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:13:35 -0700 (PDT)
Message-Id: <pull.949.v7.git.1620918814489.gitgitgadget@gmail.com>
In-Reply-To: <pull.949.v6.git.1620821572126.gitgitgadget@gmail.com>
References: <pull.949.v6.git.1620821572126.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 May 2021 15:13:33 +0000
Subject: [PATCH v7] [GSOC] ref-filter: fix read invalid union member bug
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
    
    Change from last version: Modify the test content, reduce additional
    'mkdir' operation and remove temp-dir "test" when finished.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-949%2Fadlternative%2Fref-filter-enum-bug-fix-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-949/adlternative/ref-filter-enum-bug-fix-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/949

Range-diff vs v6:

 1:  518cc41a78a4 ! 1:  50bef8439a85 [GSOC] ref-filter: fix read invalid union member bug
     @@ t/t6302-for-each-ref-filter.sh: test_expect_success '%(color) must fail' '
       '
       
      +test_expect_success '%(color:#aa22ac) must succeed' '
     -+	mkdir test &&
     ++	test_when_finished rm -fr test &&
      +	git init test &&
      +	(
      +		cd test &&


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
index 9866b1b57368..5070d0cf1e80 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -117,6 +117,25 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
 
+test_expect_success '%(color:#aa22ac) must succeed' '
+	test_when_finished rm -fr test &&
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
