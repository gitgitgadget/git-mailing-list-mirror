Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B6BC49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C929613C2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhFXScb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhFXScZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 14:32:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E27C061756
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:30:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n23so4648357wms.2
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TJmKJKAJOqDW8RW+/aGJobLyFXCoqVHaR+iGuEjWbuI=;
        b=GMzn+vTfb++K8S1okywRd9E2rLrcY37JNEj0QaAatXHGL3cSJ3zqh15/tdcRCyfbNx
         2IpJhC/brK5IcS+sySlkG3srszs94aPWmsAG0TTsZ0+6m11PGXIrzkWULrH1N5JP/xP6
         M6Fm2TPAS2CWbnz74+Df8LHXLE87pQ2O8wKqBJstwRijd6baEzUwrgUOScW+d09LxCYM
         bHyqmUHWz6wYWEGQXNPghTdyvacb5gLnDA6Nzf6fZaEwcu+kLrPUvJRNqVd4yZaNdKYS
         lD4DxSRLjZcyKCaToq9eUcNw92SHShLUjkgQQiLS5WL4nhcjga5pFhqM8rDfk2mWJ4X2
         LqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TJmKJKAJOqDW8RW+/aGJobLyFXCoqVHaR+iGuEjWbuI=;
        b=YNGyW2LXp1aHuv/0J1z/UEtoPQ2mcDbRmGxwOqLsVb9LHEodmzyNRLofRBiWRDkTdR
         4Mw0rJeWtAsRFFyAT/gD2vMSQIbHg/PkOV0tKHyQBdo/HnmmMHlPFOpD1U6oD/L+oE0a
         fmA0JtcSHlZd2kHm89t2+AHwOwzK7+YLm8t1HgPHQtCsyA6kmR30DN7tvyaYZ63Gc6bu
         3QjPBdFtg/M2+WI63cye2WV45sUNoRGC8YhHEnTUDjBINW8D60Azp3cuRr/FzcD3EU9z
         4GzaCmSE0+/YOobw8Lwt5tl9fyNkbOa2H0/SdB+taygZfBiaT9IgggYianRqOZn0xfSh
         Ze5A==
X-Gm-Message-State: AOAM5314E9rJ0ebYvCLWcFqpIEKUmT8XLzWpa5dLzrCQCUel3PZQ8BLg
        Mnx75GM2C18Pk6aat8MLwIseCxCWym8=
X-Google-Smtp-Source: ABdhPJw+PX1tCMLnGoUyBAmeTue4CsPAaaYpbL/jJAxxaiwWPTt0iTLPcc+d/+ClyqQs7ra95DDFNQ==
X-Received: by 2002:a1c:e91a:: with SMTP id q26mr5932972wmc.170.1624559404027;
        Thu, 24 Jun 2021 11:30:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 22sm3535999wmi.4.2021.06.24.11.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:30:03 -0700 (PDT)
Message-Id: <c4d2a3cab4bd5243a776002e4f04fead7b1f34c5.1624559402.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.986.git.1624559401.gitgitgadget@gmail.com>
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Jun 2021 18:29:59 +0000
Subject: [PATCH 1/3] Add a second's delay to t7519 for untracked cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In t7519 there is a test that writes files to disk, and immediately
writes the untracked index. Because of mtime-comparison logic
that uses a 1-second resolution, this means the cached entries
are not trusted/used under some circumstances (see
read-cache.c#is_racy_stat()).

Untracked cache tests in t7063 use a 1-second delay to avoid
this issue. We should do the same here.

This change doesn't actually affect the outcome of the test,
but does enhance its validity, and becomes relevant after
later changes

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7519-status-fsmonitor.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 637391c6ce4..1209fa93499 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -13,6 +13,10 @@ clean_repo () {
 	git clean -fd
 }
 
+avoid_racy() {
+	sleep 1
+}
+
 dirty_repo () {
 	: >untracked &&
 	: >dir1/untracked &&
@@ -332,6 +336,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 		: >dir2/modified &&
 		write_integration_script &&
 		git config core.fsmonitor .git/hooks/fsmonitor-test &&
+		avoid_racy &&
 		git update-index --untracked-cache &&
 		git update-index --fsmonitor &&
 		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace-before" \
-- 
gitgitgadget

