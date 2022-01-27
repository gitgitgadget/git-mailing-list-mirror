Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A04C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 19:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245436AbiA0TIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245457AbiA0TIg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 14:08:36 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661BC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 11:08:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s9so6535441wrb.6
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 11:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tA2Eye5aVsGlfk44zjOdGDjWrfUA3v08Gwm7WipygZA=;
        b=GNF8lxEH8+fgXRvsKNY0QrX9Ljv+P8n8XvGXkiEPvV0pXP3handYGRP+e76zWm9pmj
         s24lUSBKibzr40vH7SzX/PjaXFBvPbBdf91YnMo3HNkYUMULnTzOWgVTUXd5YIj6c+1+
         Qr+g5HbdF3DYjxHlJKlTYW9ZQ1xD2bbo0EvecIF1kgXBn9I38RECjZc050V7SuLD9xYZ
         Y45bcB+/g2mqIutNMWFNpGET4x2ZWfxDNrz1HNw7ldTd87Rk74dwNdnZwv+xTL43R6rp
         6xFnqU6ayD2yG8FfQ4bgy00s+WaCv0eJxan6GSdft1w++2mLp2JHjWYUB1ywzHns2XpF
         Pk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tA2Eye5aVsGlfk44zjOdGDjWrfUA3v08Gwm7WipygZA=;
        b=iagppBVSyPcCqdRcYi3Aoppi16UuxLr2aYPWV0lXvcpgMe9CCDeml5F9niWmbt7EHw
         a08SUPOIxoEXDsh2mwvn0IEOPiX5eUxY98MAdm66fRStsS159+8zdGvi3bHxjvAiA3GR
         7gVYtA1be7Xq9bkQEQT7Ac7zlmpWJG8JixHKOYfUo2kexuhMi3VOpOOkurrsHd/mnTTp
         vVSsylobmmvE2y471n0fSxRxBMe6G/naiqs+Rgxasw384rGkVgOzvUxbSXCYocoVMiFT
         gyol/p8lvexDOjspxz1PfGGPPIyVlVJ4cCAbHNd7MM1V+ZeKbU9hiMPUXDj917KBjojw
         4lFA==
X-Gm-Message-State: AOAM5316xRtc6BqH52NnwkoWQzqhqOrPyE1pXoMicRabZSj94RfNXO/p
        qmWVPBBmcY3rWYO/meCl8WpRR2U/D6U=
X-Google-Smtp-Source: ABdhPJwzCy7NDbaA/E9lNOB2JyodoYEsQcIhF5bpVDH2ZL1Qt58Wkr8QRcPnnUVLRU5VcXVIFXXRsQ==
X-Received: by 2002:adf:f80a:: with SMTP id s10mr4042607wrp.440.1643310513984;
        Thu, 27 Jan 2022 11:08:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1sm2757705wrq.82.2022.01.27.11.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:08:33 -0800 (PST)
Message-Id: <b041d2b7a3bd4433e86438cddbd52857e5f375a6.1643310510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
        <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 19:08:29 +0000
Subject: [PATCH v2 3/3] diff-filter: be more careful when looking for negative
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
