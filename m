Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB0C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 15:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbiGNPoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbiGNPoA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 11:44:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8FE1C935
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 08:43:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n185so1285146wmn.4
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IQyccFinT+ZoD8RZBHFM1ksXeaX6pkGsPEmF2UJuFGc=;
        b=pM6hh5Cm2U9uhYu9peOa34TeWvJZ/oruE5B1s8PjF+2L09rFULifLFBQzEcL5dNDgw
         YTMgMnlSPMX/LCDLiROSKmaK45QinuJNYrI1Oa/o2aS6i1EYDR2YIQ7Z0TGBErCOUodY
         qHypAHcgQr4plh4LWqDK8NPMvIuv2yTKpi8O1vwjXpQZHXtnTazmvIq2Vi1us5VJuBUt
         eGKbdDCEcRNfcmjPizU20wpfDiQXSYqNXFunW/JYABml1W+WkUKETPv8DhmIVIaaXyOk
         Px1ePC9rKPaJbZ5KUKYRwIfjaNbm+F9PtClcdELSeWRJfhU9lyK7RzKQgOs/7cEEAUIb
         qzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IQyccFinT+ZoD8RZBHFM1ksXeaX6pkGsPEmF2UJuFGc=;
        b=2BLYw/LpimWP5fQ0VhCUVNKiebtEwL1/H2siiVnPy25w1L78iCDbMZtXSEApnWnuli
         5lHqb4nKlPVa5SBR2RzvGBkVs9VvrPFZ1nD6uc3M4Qk1QEwYNJRO84uRhf+3GqZEm2/y
         DkW1nqIbgfiJ6LMjYzPWRMSO4UJ34LzkxHj8ZQt+rMZ/YkjNRKqNGdBGhXxLtu+FBG7i
         9j8lTE7gdnQ/RBEMaq+HIOdLi4GaKhIy/VIJdQ8s/yASPTlXX1sAh833mx3TzEWVn+p7
         JGjR0Xj4MI9eDy58DUnlETi0a/3RDw7rk5oyTSr02vEESxebHj6M/cNfJ9YpYoj51FNm
         d3Qw==
X-Gm-Message-State: AJIora+M0NKX/DUzEb2znxF187SURx2pZFZNOf7fXL1krP6rVRrtnUbX
        h2FRhR48iLhe8KBT/tKIp9bCHD3uQx4=
X-Google-Smtp-Source: AGRyM1sP3m20xUw23wORdM6pHUWsJKgwM9qzqi7NRWTLTgiDyrsV51DktodFgrAzZJTv/LJOyENdCA==
X-Received: by 2002:a05:600c:3591:b0:3a0:563a:49d3 with SMTP id p17-20020a05600c359100b003a0563a49d3mr9377411wmq.60.1657813430813;
        Thu, 14 Jul 2022 08:43:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p129-20020a1c2987000000b003a2d47d3051sm2566945wmp.41.2022.07.14.08.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:43:50 -0700 (PDT)
Message-Id: <pull.1290.git.1657813429221.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 15:43:49 +0000
Subject: [PATCH] shortlog: use a stable sort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When sorting the output of `git shortlog` by count, a list of authors in
alphabetical order is then sorted by contribution count. Obviously, the
idea is to maintain the alphabetical order for items with identical
contribution count.

At the moment, this job is performed by `qsort()`. As that function is
not guaranteed to implement a stable sort algorithm, this can lead to
inconsistent and/or surprising behavior: items with identical
contribution count could lose their alphabetical sub-order.

The `qsort()` in MS Visual C's runtime does _not_ implement a stable
sort algorithm, and under certain circumstances this even causes a test
failure in t4201.21 "shortlog can match multiple groups", where two
authors both are listed with 2 contributions, and are listed in inverse
alphabetical order.

Let's instead use the stable sort provided by `git_stable_qsort()` to
avoid this inconsistency.

This is a companion to 2049b8dc65 (diffcore_rename(): use a stable sort,
2019-09-30).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    shortlog: use a stable sort
    
    This is another fall-out from validating Git for Windows v2.37.1 via the
    reinstated Azure Pipeline.
    
    The most valid question a reviewer might have about this patch is: "But
    why does our current CI not fail in the vs-test job?". The answer is
    surprisingly trivial: Because our CMake-based definition universally
    defines INTERNAL_QSORT
    [https://github.com/git/git/blob/v2.37.1/contrib/buildsystems/CMakeLists.txt#L227],
    which should actually not even be necessary, while the Azure Pipeline I
    used still calls make vcxproj to generate the Visual Studio build
    definition and does not define that flag.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1290%2Fdscho%2Fshortlog-requires-stable-sort-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1290/dscho/shortlog-requires-stable-sort-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1290

 builtin/shortlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 35825f075e3..086dfee45aa 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -443,7 +443,7 @@ void shortlog_output(struct shortlog *log)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (log->sort_by_number)
-		QSORT(log->list.items, log->list.nr,
+		STABLE_QSORT(log->list.items, log->list.nr,
 		      log->summary ? compare_by_counter : compare_by_list);
 	for (i = 0; i < log->list.nr; i++) {
 		const struct string_list_item *item = &log->list.items[i];

base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca
-- 
gitgitgadget
