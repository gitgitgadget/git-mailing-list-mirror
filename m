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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B39C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 15:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAAF6147F
	for <git@archiver.kernel.org>; Tue, 11 May 2021 15:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhEKPgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhEKPgc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 11:36:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A0DC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 08:35:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l2so20587626wrm.9
        for <git@vger.kernel.org>; Tue, 11 May 2021 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XlDPQJC9Iw936176XTDjPbb5dl8gBgK6Zu2WYrm+sTs=;
        b=YGRDVWY9d9hzO3hUx2IQI0uJubpqXBAPqDPeCouiFMHV7QgBlPq+TaEPF4UUXyHOpL
         L/PO/S/JROM7tz4qe7G0itfdSP4MwdH7rlNaweWe1BW1TZ1gy3Q4hljMEFF9E/elA2mZ
         lL77/OIb406wPcbgodbNn+iD21FqStyCs8kyijxCi0S8Kx+b6Qeb2k6WIi7GyjU0PcTp
         Rna4jRbTbaIQN318Sk8QJqMLb+8AtDv7qwK9NXCFHzSgqWnfV7t2QFl5uJXhb7yvh6SV
         SthR9FbUBmO9r9n6EvuskgxCwXf4To0nTmpiEaaBvddk295viMQYz8GgFiTwtAcWYvTL
         vu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XlDPQJC9Iw936176XTDjPbb5dl8gBgK6Zu2WYrm+sTs=;
        b=no+jAnGkhgG6/QR4j86ih35gNASicj92fzGDpAxWLOAAtT2PxZq0pPqVprs4oANl7l
         nU6bDF3ieiPfYPrOk8cW85neBFO18UddFrOToJNKFPLbvX+mOyL1ARfZQJLnuhV9hxLW
         p9pgM2MEVHQBURLg+BWZqSZUf6E/c5eozVqHMn4l8JGU4M9AbqcCbQ5nY83b/c599bog
         KACN9OBZzyy+9i197JPswSS87lGIP3ydzdns2o3s1CLQVxH4uV2GltHW4baXwrS9EJDZ
         DcIOjEO7txxhEWXeKLVy2Xi7sP77O3MfXbO8hhdygjFFfwDXQsRio6E+I7O1BwKMrS1Z
         KIiw==
X-Gm-Message-State: AOAM533bZxKCNCr5ZV9ywW3aVp9q8irW53J5lcSOEyz6w/kqeCgn28PU
        6W5soE2PtMKISYLPreWA2+x4IxfRDeo=
X-Google-Smtp-Source: ABdhPJw7+3oPeYnZv4irbmOGsoYD8vMn78Glbllruv4SeBOqEhTL9p1Imq++eiwXRFMGECaqNWkt1g==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr38393373wrv.239.1620747322551;
        Tue, 11 May 2021 08:35:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm23642423wmf.9.2021.05.11.08.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 08:35:21 -0700 (PDT)
Message-Id: <pull.949.v5.git.1620747320947.gitgitgadget@gmail.com>
In-Reply-To: <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com>
References: <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 May 2021 15:35:20 +0000
Subject: [PATCH v5] [GSOC] ref-filter: fix read invalid union member bug
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
    
    I and Junio discussed the situation that this bug might actually occur.
    
    The damage that can be found currently is using %(colors:#aa22ac) or
    some other %(colors) atoms. But Junio found that testing
    %(colors:#aa22ac) alone did not show the expected bug in the commit
    before the repair.
    
    So I conducted an experiment:
    
    When we use git push, Git will add some config, these configurations
    will affect the result of the execution process related to atom %(push)
    in populate_value().
    
    Change from last version: added a new test, which added two
    configurations:
    
    git config branch.main.remote origin git config branch.main.merge
    refs/heads/main
    
    used to simulate the configuration changes brought by git push.
    
    Finally, a test on the broken atom %(colors:#aa22ac). In the commit
    before the repair, breakage occurs. In the commit after the repair,
    breakage disappeared.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-949%2Fadlternative%2Fref-filter-enum-bug-fix-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-949/adlternative/ref-filter-enum-bug-fix-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/949

Range-diff vs v4:

 1:  8c6c0368a590 ! 1:  b546477e8c87 [GSOC] ref-filter: fix read invalid union member bug
     @@ t/t6302-for-each-ref-filter.sh: test_expect_success '%(color) must fail' '
       	test_must_fail git for-each-ref --format="%(color)%(refname)"
       '
       
     -+test_expect_success '%(color:#aa22ac) must success' '
     ++test_expect_success '%(color:#aa22ac) must successed' '
     ++	test_when_finished "cd .. && rm -rf ./test" &&
     ++	mkdir test &&
     ++	cd test &&
     ++	git init &&
      +	cat >expect <<-\EOF &&
      +	refs/heads/main
     -+	refs/heads/side
     -+	refs/odd/spot
     -+	refs/tags/annotated-tag
     -+	refs/tags/doubly-annotated-tag
     -+	refs/tags/doubly-signed-tag
     -+	refs/tags/four
     -+	refs/tags/one
     -+	refs/tags/signed-tag
     -+	refs/tags/three
     -+	refs/tags/two
      +	EOF
     ++	git add . &&
     ++	git branch -M main &&
     ++	git commit -m "test" &&
     ++	git remote add origin nowhere &&
     ++	git config branch.main.remote origin &&
     ++	git config branch.main.merge refs/heads/main &&
      +	git for-each-ref --format="%(color:#aa22ac)%(refname)" >actual &&
      +	test_cmp expect actual
      +'


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
index 9866b1b57368..309cf699506f 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -117,6 +117,24 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
 
+test_expect_success '%(color:#aa22ac) must successed' '
+	test_when_finished "cd .. && rm -rf ./test" &&
+	mkdir test &&
+	cd test &&
+	git init &&
+	cat >expect <<-\EOF &&
+	refs/heads/main
+	EOF
+	git add . &&
+	git branch -M main &&
+	git commit -m "test" &&
+	git remote add origin nowhere &&
+	git config branch.main.remote origin &&
+	git config branch.main.merge refs/heads/main &&
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
