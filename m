Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135DBC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiL3CTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiL3CTB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:19:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74F917888
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:56 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u28so24034750edd.10
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdxqY8IQiB9zQE6L43tYA+GaKvhgdq23KkAZRaO1jWU=;
        b=g5ypJxV1MDiJ5qX0gI/ObRaWWmkGiEamdawSUVRYH+7TJ2kwLgCStyMzZMQIc+ovSs
         wrgPxhPtYKdJBcuVFRVE2lcw+UW2WIGvaM2dath6fNuKmENaStlJG79+1S2/nUMIQ8TA
         iXo686ZRcsX29mKmIrpGpYO+ekJMa3niqSpjO/CQEs/TRT3Nsko0BrOnGA25at2JUmDe
         71TsDRIfuRng02nDPZQtzu0WbMFCo5S3Jj9J/5LKiEeIPscZ06VQKctN6fm/0PgENKTE
         Unnm4J0iVOhulKahDpl72fH803CZfxvhp/twltI3Zyz37q0dEoxIOhPszI4BvRJFGbpS
         zlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdxqY8IQiB9zQE6L43tYA+GaKvhgdq23KkAZRaO1jWU=;
        b=d+u6KJrpNU5uetsa1YiKASpCpbVYCzEUawbIyPJSXTh9xN5SA9lBUL30WkmgRvTeIt
         CdvS7brWnnsSMBE+ndxVmN9edZvEK3G5FSAONTugoVSPeiuf26ORa65XxWj0+VUfOSTI
         tP/Wg6XB5YTU9nYh547DtfxxMeOcJGkS4KRufC97JHDB8DJf78XFFxqwXonpUhRXzWKk
         oEw2nZySKy34OcHCZVIDjX89E7rSa6ZZiDCH0CItHftX6ycP+zBpxUVdtlceH+dtojj0
         oALnrasBlQ9YTaFkLSLVwdLQPsUd8ma8oCZ0xnTJzHf10MSro5GEnblceyzgy0IEdXVU
         gk2Q==
X-Gm-Message-State: AFqh2kqgqG2och0292v12EuyPeJq/iU8szH/8ntbfOSL5kMxQmjX71Fq
        91aMvs88uFB9Je6D+RD1OODJqFivzVv03g==
X-Google-Smtp-Source: AMrXdXteYj23GurDZB3YIibc7F9o1DmYWYKAgfzgICCG3RYGjiheRpvN8VcH456tfHRA959kc/6h6Q==
X-Received: by 2002:a05:6402:1f0b:b0:467:7b2e:88a2 with SMTP id b11-20020a0564021f0b00b004677b2e88a2mr26188666edb.19.1672366734840;
        Thu, 29 Dec 2022 18:18:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 17/20] grep.c: refactor free_grep_patterns()
Date:   Fri, 30 Dec 2022 03:18:32 +0100
Message-Id: <patch-v2-17.20-fa2e8a7d297-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the free_grep_patterns() function to split out the freeing of
the "struct grep_pat" it contains, right now we're only freeing the
"pattern_list", but we should be freeing another member of the same
type, which we'll do in the subsequent commit.

Let's also replace the "return" if we don't have an
"opt->pattern_expression" with a conditional call of
free_pattern_expr().

Before db84376f981 (grep.c: remove "extended" in favor of
"pattern_expression", fix segfault, 2022-10-11) the pattern here was:

	if (!x)
		return;
	free(y);

But after the cleanup in db84376f981 (which was a narrow segfault fix,
and thus avoided refactoring this) we ended up with:

	if (!x)
		return;
	free(x);

Let's instead do:

	if (x)
		free(x);

This doesn't matter for the subsequent change, but as we're
refactoring this function let's make it easier to reason about, and to
extend in the future, i.e. if we start to free free() members that
come after "pattern_expression" in the "struct grep_opt".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 06eed694936..a4450df4559 100644
--- a/grep.c
+++ b/grep.c
@@ -769,11 +769,11 @@ static void free_pattern_expr(struct grep_expr *x)
 	free(x);
 }
 
-void free_grep_patterns(struct grep_opt *opt)
+static void free_grep_pat(struct grep_pat *pattern)
 {
 	struct grep_pat *p, *n;
 
-	for (p = opt->pattern_list; p; p = n) {
+	for (p = pattern; p; p = n) {
 		n = p->next;
 		switch (p->token) {
 		case GREP_PATTERN: /* atom */
@@ -790,10 +790,14 @@ void free_grep_patterns(struct grep_opt *opt)
 		}
 		free(p);
 	}
+}
 
-	if (!opt->pattern_expression)
-		return;
-	free_pattern_expr(opt->pattern_expression);
+void free_grep_patterns(struct grep_opt *opt)
+{
+	free_grep_pat(opt->pattern_list);
+
+	if (opt->pattern_expression)
+		free_pattern_expr(opt->pattern_expression);
 }
 
 static const char *end_of_line(const char *cp, unsigned long *left)
-- 
2.39.0.1153.g589e4efe9dc

