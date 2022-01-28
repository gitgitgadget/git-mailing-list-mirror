Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052D1C433FE
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348171AbiA1MC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244353AbiA1MC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:02:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DFFC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:02:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id f17so10508350wrx.1
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yn11dC0UUJVOeGUVCENUnG8LQlPDdRO6ilUxv446bR0=;
        b=nouzknN/J54bTPALP1Ast3HTWiN+ETc6p5lk+wQT2Mgse21rAoDFVOjPvsQczZX2MB
         5sfk0ghVw3MGCkPx/Fnerit3et70gswa4hqXCQJ8nZ98gaIen5pvpd+CTGC+NEdHFX64
         t4mtfZ1h8lL/r9ZlqrpDqndlJjrq02hxHoBxhf9YNgGWjn/EdrRINxSLcVGx8Ib/ii5H
         ZIlthN/M6ya7FFyIaeT60zqJoM9ZkWVGjx3Cnqmc61iuRvwkKlHXfPso3PLskzqcPVIU
         BcMEs4SmrBIT+j8KQ2v6KdJdPzCtUfaIUoiaEygMnfMG1WpJgGV/NE7Vsh2sRRL1hMvU
         J3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yn11dC0UUJVOeGUVCENUnG8LQlPDdRO6ilUxv446bR0=;
        b=8IM4Sxi3SOMyIj2EIBnAWxIvtZih7Ek/eNxBLnPyvwA4E35b42fS1Qdfn8YdT3OUqy
         odr717mdPaPjc68ts39QmdyDCqO4gFq+Bj81jo/t0AIAqQtNxHZ3vJC0ilMb4nH/R4Kb
         a8ji7YQ+5vgL0D7fCHHPEHChtkTzjwUqjiFusOjbrFfSzy/djk/yI8/Pr0VOH2xisH/U
         pzsVR1KYWLLdURim5po6qIBCgmOeJ3ikfbcYP77/WkcGtbj52t4kqRHrj1X72gaoFEej
         2flwRsGvImGo+ZlY4gimPNfyMuw4oddUxA6KrANFp8ttcOUkrwZk4yCXtGakU4l0FGXi
         efZg==
X-Gm-Message-State: AOAM531xwTZL2lCqcu/LMFefyY6FZ6rS7hRLYWwp0O4V9ICG6UsUoDDp
        zUX8minoREtvLjyZbaG5t+ysLinQFNU=
X-Google-Smtp-Source: ABdhPJww6fv9i6hiRqIJVFerp0R3V5Fufkhk7AXGvaeBY7/5BP26IKaf6Xoqw69GptPWl7bRTr2YSQ==
X-Received: by 2002:a5d:5049:: with SMTP id h9mr6952424wrt.502.1643371374864;
        Fri, 28 Jan 2022 04:02:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm1945474wmq.21.2022.01.28.04.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:02:54 -0800 (PST)
Message-Id: <f1f027ad61beb1bd0dee73acbffdee5c0f967e9a.1643371370.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1127.v3.git.1643371370.gitgitgadget@gmail.com>
References: <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
        <pull.1127.v3.git.1643371370.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 12:02:50 +0000
Subject: [PATCH v3 3/3] diff-filter: be more careful when looking for negative
 bits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `--diff-filter=<bits>` option allows to filter the diff by certain
criteria, for example `R` to only show renamed files. It also supports
negating a filter via a down-cased letter, i.e. `r` to show _everything
but_ renamed files.

However, the code is a bit overzealous when trying to figure out whether
`git diff` should start with all diff-filters turned on because the user
provided a lower-case letter: if the `--diff-filter` argument starts
with an upper-case letter, we must not start with all bits turned on.

Even worse, it is possible to specify the diff filters in multiple,
separate options, e.g. `--diff-filter=AM [...] --diff-filter=m`.

Let's accumulate the include/exclude filters independently, and only
special-case the "only exclude filters were specified" case after
parsing the options altogether.

Note: The code replaced by this commit took pains to avoid setting any
unused bits of `options->filter`. That was unnecessary, though, as all
accesses happen via the `filter_bit_tst()` function using specific bits,
and setting the unused bits has no effect. Therefore, we can simplify
the code by using `~0` (or in this instance, `~<unwanted-bit>`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c         | 23 +++++++----------------
 diff.h         |  2 +-
 t/t4202-log.sh | 13 +++++++++++++
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 5081052c431..4ab4299b817 100644
--- a/diff.c
+++ b/diff.c
@@ -4720,6 +4720,12 @@ void diff_setup_done(struct diff_options *options)
 	if (!options->use_color || external_diff())
 		options->color_moved = 0;
 
+	if (options->filter_not) {
+		if (!options->filter)
+			options->filter = ~filter_bit[DIFF_STATUS_FILTER_AON];
+		options->filter &= ~options->filter_not;
+	}
+
 	FREE_AND_NULL(options->parseopts);
 }
 
@@ -4820,21 +4826,6 @@ static int diff_opt_diff_filter(const struct option *option,
 	BUG_ON_OPT_NEG(unset);
 	prepare_filter_bits();
 
-	/*
-	 * If there is a negation e.g. 'd' in the input, and we haven't
-	 * initialized the filter field with another --diff-filter, start
-	 * from full set of bits, except for AON.
-	 */
-	if (!opt->filter) {
-		for (i = 0; (optch = optarg[i]) != '\0'; i++) {
-			if (optch < 'a' || 'z' < optch)
-				continue;
-			opt->filter = (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;
-			opt->filter &= ~filter_bit[DIFF_STATUS_FILTER_AON];
-			break;
-		}
-	}
-
 	for (i = 0; (optch = optarg[i]) != '\0'; i++) {
 		unsigned int bit;
 		int negate;
@@ -4851,7 +4842,7 @@ static int diff_opt_diff_filter(const struct option *option,
 			return error(_("unknown change class '%c' in --diff-filter=%s"),
 				     optarg[i], optarg);
 		if (negate)
-			opt->filter &= ~bit;
+			opt->filter_not |= bit;
 		else
 			opt->filter |= bit;
 	}
diff --git a/diff.h b/diff.h
index 8ba85c5e605..a70e7c478c1 100644
--- a/diff.h
+++ b/diff.h
@@ -283,7 +283,7 @@ struct diff_options {
 	struct diff_flags flags;
 
 	/* diff-filter bits */
-	unsigned int filter;
+	unsigned int filter, filter_not;
 
 	int use_color;
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 50495598619..b25182379ff 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -142,6 +142,19 @@ test_expect_success 'diff-filter=R' '
 
 '
 
+test_expect_success 'multiple --diff-filter bits' '
+
+	git log -M --pretty="format:%s" --diff-filter=R HEAD >expect &&
+	git log -M --pretty="format:%s" --diff-filter=Ra HEAD >actual &&
+	test_cmp expect actual &&
+	git log -M --pretty="format:%s" --diff-filter=aR HEAD >actual &&
+	test_cmp expect actual &&
+	git log -M --pretty="format:%s" \
+		--diff-filter=a --diff-filter=R HEAD >actual &&
+	test_cmp expect actual
+
+'
+
 test_expect_success 'diff-filter=C' '
 
 	git log -C -C --pretty="format:%s" --diff-filter=C HEAD >actual &&
-- 
gitgitgadget
