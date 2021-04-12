Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F753C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2D861206
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbhDLRRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbhDLRQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6529CC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 12so7260023wmf.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vfzGY4e3JZmVv/z7f6GluOSI2a8fb+vM/qakIeaBgE=;
        b=uc3VQTwIqHHH2elx3gUsfZKVr/B21KaUqpzbKTCYJoCLVWXeT+04zDxt2haH/09b0s
         3Hjfoi3cTriLrZwVArqqiayTRzPKrrOslOtmw+WwTeXF3YXo1a3ZA4Yz+MJdzW+Lq61I
         9pu+6JsxKOrWg0OhkQcf5/0qodSSBOQMVef7QVkncHbl/6rbALGWuzGCMzJVGjdrF5Dx
         anImSoXOgJZ3NjWYgvpVo3kvee6qJDuPt7xZPDxH+dz+ytg2nkQVd0uMGGTUW34lgix1
         BzoYnTAMQ1QntnVHSmOuDtF7n+qwGvuJ+n0gElOJgJaIaJ0VJvG6mJzkGzEO65kmGqeb
         VbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vfzGY4e3JZmVv/z7f6GluOSI2a8fb+vM/qakIeaBgE=;
        b=Kaz9Q5rv+BfNE+7c6l2l1J8tmwf9k9RJT7C8YkTId8qGNYikhBOKm/Ym0N4E0pFMOt
         b4RG8hxkMF/QzbWqIeya3UNDbKACq/5hTcKRo9Jg49MTGnalmQ1Mmmp4aGQ7XwWRAGC9
         pyG4GemJYfoSjvM5RTKjyzZl4YoHpDQAlSBfvof2XTCbgWl5cFVra4Z9siy1uvc7suwf
         NsnoOdaVubXb0nH4goJ8X6aQwzkh6LRXvMJueIeDyG6qVAR8CopaVA9ajFx5d8vMuROs
         cC3wojEsRjyaE66m1NKymqNJDz5u/0ehxbdg4nnI0ojNxR7Ww3O5ZjcctIdhHJtngh6M
         x2wA==
X-Gm-Message-State: AOAM533LP0LgNUzkPYWGKQEyvWQe1csLGqGJRMdgmnGBj/lOS/CUut+Z
        nCyhtSchmxytmGnP993MDuxcB40+gsn1Kg==
X-Google-Smtp-Source: ABdhPJyI3tbK+/BNt0S4iVF3m7CJbptFFX9F3d5AoDpMRtRqGMk4vEIpVnvnKwG9vW3Am1nR7R0v7w==
X-Received: by 2002:a05:600c:4f44:: with SMTP id m4mr121405wmq.175.1618247753782;
        Mon, 12 Apr 2021 10:15:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 20/22] pickaxe -G: don't special-case create/delete
Date:   Mon, 12 Apr 2021 19:15:27 +0200
Message-Id: <patch-20.22-76de6ebc8b8-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
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
index 2147afef722..96183f4cfab 100644
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
@@ -172,9 +164,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	mf1.size = fill_textconv(o->repo, textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(o->repo, textconv_two, p->two, &mf2.ptr);
 
-	ret = fn(DIFF_FILE_VALID(p->one) ? &mf1 : NULL,
-		 DIFF_FILE_VALID(p->two) ? &mf2 : NULL,
-		 o, regexp, kws);
+	ret = fn(&mf1, &mf2, o, regexp, kws);
 
 	if (textconv_one)
 		free(mf1.ptr);
-- 
2.31.1.639.g3d04783866f

