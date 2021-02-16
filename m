Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F21BC43381
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1764264DDA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBPMFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhBPMCT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:02:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70BDC061222
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l17so8932430wmq.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uh1usR7siGRw6cGOZsOPuaQw+7hf8fEOHWPH+QU3ADE=;
        b=Tt9Dy5WlM+OIwHLNufMxRViGtqt0buhP40A9209IVvBo/q2RKX2lKorE+nJgMQILeS
         AOoiprwjJKs+TCc0zisLMeeuKWCle3NMfqynpXpEkE1wu6Cv/mtW4BB46svXuBtPIBvX
         pcroq8U7bNEEUM/ctLI/1BZAotVY9tWwHSwAjltprr/shQPnepSjsUP1hD5md/X4R8P4
         g8X8mxEmlsIuMPz6pBvxoWceHMORX70+EkSwN8b40HiX9Vuidyeb0epyJxbZH6xwMoFa
         XbJzfnwVNgsVIAcyG6Jp0byaxVHL5JdO4PzCjB+qJmfFKfRMDN0CR69eIxHx1J3bv8zg
         qpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uh1usR7siGRw6cGOZsOPuaQw+7hf8fEOHWPH+QU3ADE=;
        b=FQldof6dJbJirzgHhOCDCAXT6ZXk40ghxS06SMDFlw3nfsfyvP6QJ3PMi/xujCJPrG
         oKvUWtHhbJlTBzEqyExPkeD9vm4CFBjGqbgyGjES2UcfKstNJGqHKf4f7PB+mpdRZI3A
         6qQCoXSc1GDroUZOWmnSUwBLVjVuLHPVdSJYCvABQ/2487DrzFXRMkcXujlLeAtZkwaF
         F7b/ksNWL5gzf1rF0nrw/FfoptBrFu9T5LCKYhAKKq10+OsbfmNqSDBWnsP9OMVKS0WX
         6rf1pmWFq4XUTQ3EgUqvkYP8DBYxs9BP9altg6p5fdMRAgcFAW7zQSCT0yZpA+2Z/U92
         squA==
X-Gm-Message-State: AOAM530XJrz0Lq/l/TDhZi2ybtssohsHtyacAfLz95vE+YrQgOu7JMF3
        pZS8pejW+/wqjB1CbG8PxlrSWYMSBG6t8g==
X-Google-Smtp-Source: ABdhPJyf3nqsbNNDXGfm0ELCI+/duDvtCHtsKwlsZ03t2fqJaAY8i4cfLYGkgRhb/gJxbYww2LW3DA==
X-Received: by 2002:a1c:7217:: with SMTP id n23mr2989892wmc.183.1613476712103;
        Tue, 16 Feb 2021 03:58:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 22/22] pickaxe -G: don't special-case create/delete
Date:   Tue, 16 Feb 2021 12:58:01 +0100
Message-Id: <20210216115801.4773-23-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of special-casing creations and deletions let's just generate
a diff for them.

This logic of not running a diff under -G if we don't have both sides
dates back to the original implementation of -S in
52e9578985f ([PATCH] Introducing software archaeologist's tool
"pickaxe"., 2005-05-21).

In the case of -S we were not working with the xdiff interface and
needed to do this, but when -G was implemented in f506b8e8b5f (git
log/diff: add -G<regexp> that greps in the patch text, 2010-08-23)
this logic was diligently copied over.

But as the performance test added earlier in this series shows, this
does not make much of a difference. With:

    time GIT_TEST_LONG= GIT_PERF_REPEAT_COUNT=10 GIT_PERF_MAKE_OPTS='-j8 CFLAGS=-O3' ./run origin/next HEAD~ HEAD -- p4209-pickaxe.sh

With the HEAD~ commit being the preceding "pickaxe -G: terminate early
on matching lines" we get these results. Note that it's only the -G
codepaths that are relevant to this change:

    Test                                                                      origin/next       HEAD~                   HEAD
    -----------------------------------------------------------------------------------------------------------------------------------------
    4209.1: git log -S'int main' <limit-rev>..                                0.35(0.32+0.03)   0.35(0.33+0.02) +0.0%   0.35(0.30+0.05) +0.0%
    4209.2: git log -S'æ' <limit-rev>..                                       0.46(0.42+0.04)   0.46(0.41+0.05) +0.0%   0.46(0.42+0.04) +0.0%
    4209.3: git log --pickaxe-regex -S'(int|void|null)' <limit-rev>..         0.65(0.62+0.02)   0.64(0.61+0.02) -1.5%   0.64(0.60+0.04) -1.5%
    4209.4: git log --pickaxe-regex -S'if *\([^ ]+ & ' <limit-rev>..          0.52(0.45+0.06)   0.52(0.50+0.01) +0.0%   0.54(0.47+0.04) +3.8%
    4209.5: git log --pickaxe-regex -S'[àáâãäåæñøùúûüýþ]' <limit-rev>..       0.39(0.34+0.05)   0.39(0.34+0.04) +0.0%   0.39(0.36+0.03) +0.0%
    4209.6: git log -G'(int|void|null)' <limit-rev>..                         0.60(0.55+0.04)   0.58(0.54+0.03) -3.3%   0.58(0.49+0.08) -3.3%
    4209.7: git log -G'if *\([^ ]+ & ' <limit-rev>..                          0.61(0.52+0.06)   0.59(0.53+0.05) -3.3%   0.59(0.54+0.05) -3.3%
    4209.8: git log -G'[àáâãäåæñøùúûüýþ]' <limit-rev>..                       0.61(0.51+0.07)   0.58(0.54+0.04) -4.9%   0.57(0.51+0.06) -6.6%
    4209.9: git log -i -S'int main' <limit-rev>..                             0.36(0.31+0.04)   0.36(0.34+0.02) +0.0%   0.35(0.32+0.03) -2.8%
    4209.10: git log -i -S'æ' <limit-rev>..                                   0.36(0.33+0.03)   0.39(0.34+0.01) +8.3%   0.36(0.32+0.03) +0.0%
    4209.11: git log -i --pickaxe-regex -S'(int|void|null)' <limit-rev>..     0.83(0.77+0.05)   0.82(0.77+0.05) -1.2%   0.80(0.75+0.04) -3.6%
    4209.12: git log -i --pickaxe-regex -S'if *\([^ ]+ & ' <limit-rev>..      0.67(0.61+0.03)   0.64(0.61+0.03) -4.5%   0.63(0.61+0.02) -6.0%
    4209.13: git log -i --pickaxe-regex -S'[àáâãäåæñøùúûüýþ]' <limit-rev>..   0.40(0.37+0.02)   0.40(0.37+0.03) +0.0%   0.40(0.36+0.04) +0.0%
    4209.14: git log -i -G'(int|void|null)' <limit-rev>..                     0.58(0.51+0.07)   0.59(0.52+0.06) +1.7%   0.58(0.52+0.05) +0.0%
    4209.15: git log -i -G'if *\([^ ]+ & ' <limit-rev>..                      0.60(0.54+0.05)   0.60(0.54+0.06) +0.0%   0.60(0.56+0.03) +0.0%
    4209.16: git log -i -G'[àáâãäåæñøùúûüýþ]' <limit-rev>..                   0.58(0.51+0.06)   0.57(0.52+0.05) -1.7%   0.60(0.48+0.09) +3.4%

This small simplification really doesn't buy us much now, but I've got
plans to both convert the pickaxe code to using a PCREv2 backend[1]
and to implement additional pickaxe modes to do custom searches
through the diff[2]. Always having the diff available under -G is
going to help to simplify both of those changes.

1. https://lore.kernel.org/git/20210203032811.14979-22-avarab@gmail.com/
2. https://lore.kernel.org/git/20190424152215.16251-3-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index f11b38b7121..94d3890e669 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -40,19 +40,11 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 		     struct diff_options *o,
 		     regex_t *regexp, kwset_t kws)
 {
-	regmatch_t regmatch;
 	struct diffgrep_cb ecbdata;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	int ret;
 
-	if (!one)
-		return !regexec_buf(regexp, two->ptr, two->size,
-				    1, &regmatch, 0);
-	if (!two)
-		return !regexec_buf(regexp, one->ptr, one->size,
-				    1, &regmatch, 0);
-
 	/*
 	 * We have both sides; need to run textual diff and see if
 	 * the pattern appears on added/deleted lines.
@@ -173,9 +165,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	mf1.size = fill_textconv(o->repo, textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(o->repo, textconv_two, p->two, &mf2.ptr);
 
-	ret = fn(DIFF_FILE_VALID(p->one) ? &mf1 : NULL,
-		 DIFF_FILE_VALID(p->two) ? &mf2 : NULL,
-		 o, regexp, kws);
+	ret = fn(&mf1, &mf2, o, regexp, kws);
 
 	if (textconv_one)
 		free(mf1.ptr);
-- 
2.30.0.284.gd98b1dd5eaa7

