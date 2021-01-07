Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38D5C433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1B3217A0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbhAGJxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbhAGJxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:53:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31453C0612FC
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 01:52:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r3so5013178wrt.2
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 01:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ccZKqxiWIAZOqv/z5zaiFjTEnjAbnawhQjILWbeJLQU=;
        b=GR2KMTVlvM+TtfC5d82D1Mef0y0DXQhgMXFmGMa3sbLG7rs0T/uX9cV9/hYcgK1GyR
         KcDirY0YWOs9npE8q2pTtw7fHrV39xiSIuy+2uZZn/DTTkP73r/zJffZLccRd+/vx7v1
         LZIrLyDygF5YG1CHqR7qRqE5PmZK2WXM/MeDzItsf1gmthNSh9kWtz+EdO4XiXdeyrnW
         oaqwqm7EuhYEJOd88Dz2u80XQow0K+U6ahnmO8i5sB0NV634DKdqIuZrVkSwmyJIKfMj
         q7p7ycSwUUSkeeF34/CYDXh0U+9ZcBb2b1Dl6wSRFA0S8mkEMR6OR2rIDjwsHH/QxHms
         p0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ccZKqxiWIAZOqv/z5zaiFjTEnjAbnawhQjILWbeJLQU=;
        b=JH9JlUKi+on8fOvnwrc8PWskRAeh6/JMeNHz9K7Xy+WtZUzv1zEEhxk0onIGkxMA2v
         0EEA3AwHWbyF0rQJX1seFGvjNLlbX945bfafbsrpTVJcyiXlRpT52X4Gj4Wk8T5VfsGN
         EmaPfgDaCJIJsAbCZEYagRiasRxNCf1WgICRB6hrQvzYWJN0jwLAyX+kPh1cM6DK7qHc
         Ub/bCuK2oq7ydYLBz6mMIpQTz2DCzyMipBM8BGUhMB67wJ+OWxturApRY39vIYHG/pYK
         amYQjvYcGexQiQt1nQbpl69WjwK+6wOBc2xC8hjw+ovC7Lf/Hu/y9/bxRuJcX8uh3T32
         q5Cw==
X-Gm-Message-State: AOAM5322Nf+7qIWkZWzYsNYO3UJ3guI9VnNmAV2EqY7PAQgH8dfYX6VB
        uTah5Pxr9afx3rPBXAJNUxEcvy1tf9FUcA==
X-Google-Smtp-Source: ABdhPJzOAFIjUH6OCVD6qadq2UTtrC+LWS52LVhgxmY01A1O8CnDZKSGgSNVY0vpIjBd5k68Wr64IQ==
X-Received: by 2002:adf:8145:: with SMTP id 63mr7899052wrm.8.1610013140650;
        Thu, 07 Jan 2021 01:52:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm6806535wrq.38.2021.01.07.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:52:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/7] branch: show "HEAD detached" first under reverse sort
Date:   Thu,  7 Jan 2021 10:51:53 +0100
Message-Id: <20210107095153.4753-8-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210106100139.14651-1-avarab@gmail.com>
References: <20210106100139.14651-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the output of the likes of "git branch -l --sort=-objectsize"
to show the "(HEAD detached at <hash>)" message at the start of the
output. Before the compare_detached_head() function added in a
preceding commit we'd emit this output as an emergent effect.

It doesn't make any sense to consider the objectsize, type or other
non-attribute of the "(HEAD detached at <hash>)" message for the
purposes of sorting. Let's always emit it at the top instead. The only
reason it was sorted in the first place is because we're injecting it
into the ref-filter machinery so builtin/branch.c doesn't need to do
its own "am I detached?" detection.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ref-filter.c             | 5 ++++-
 t/t3203-branch-output.sh | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8d0739b9972..ee337df232a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2357,6 +2357,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 {
 	struct atom_value *va, *vb;
 	int cmp;
+	int cmp_detached_head = 0;
 	cmp_type cmp_type = used_atom[s->atom].type;
 	struct strbuf err = STRBUF_INIT;
 
@@ -2368,6 +2369,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	if (s->sort_flags & REF_SORTING_DETACHED_HEAD_FIRST &&
 	    ((a->kind | b->kind) & FILTER_REFS_DETACHED_HEAD)) {
 		cmp = compare_detached_head(a, b);
+		cmp_detached_head = 1;
 	} else if (s->sort_flags & REF_SORTING_VERSION) {
 		cmp = versioncmp(va->s, vb->s);
 	} else if (cmp_type == FIELD_STR) {
@@ -2384,7 +2386,8 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 			cmp = 1;
 	}
 
-	return (s->sort_flags & REF_SORTING_REVERSE) ? -cmp : cmp;
+	return (s->sort_flags & REF_SORTING_REVERSE && !cmp_detached_head)
+		? -cmp : cmp;
 }
 
 static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 8f53b081365..5e0577d5c7f 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -221,10 +221,10 @@ test_expect_success 'git branch `--sort=[-]objectsize` option' '
 	test_i18ncmp expect actual &&
 
 	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
 	  branch-one
 	  main
 	  branch-two
-	* (HEAD detached from fromtag)
 	EOF
 	git branch --sort=-objectsize >actual &&
 	test_i18ncmp expect actual
@@ -241,10 +241,10 @@ test_expect_success 'git branch `--sort=[-]type` option' '
 	test_i18ncmp expect actual &&
 
 	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
 	  branch-one
 	  branch-two
 	  main
-	* (HEAD detached from fromtag)
 	EOF
 	git branch --sort=-type >actual &&
 	test_i18ncmp expect actual
@@ -261,10 +261,10 @@ test_expect_success 'git branch `--sort=[-]version:refname` option' '
 	test_i18ncmp expect actual &&
 
 	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
 	  main
 	  branch-two
 	  branch-one
-	* (HEAD detached from fromtag)
 	EOF
 	git branch --sort=-version:refname >actual &&
 	test_i18ncmp expect actual
-- 
2.29.2.222.g5d2a92d10f8

