Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151A4C7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 06:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjC0Ggp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 02:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjC0Ggo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 02:36:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A2844AD
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 23:36:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so4415347wmq.3
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 23:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679898998;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbz4quyzzTyNV0lk+jHcs3Gbz5KeKe5CtOdRCXlOYRI=;
        b=jY8XlDSsIEfm3T0ZyaspGlO42eEcn8D2im3Y+cQX1Ygtq9AwVVziWGa+On1j0VqADa
         Y4Rh1byITMkJE3lkemeiUhyK/PH82BP4vN0KANiUCEvDpUGyQ1X2OO56JW78/Keb2DC+
         3ZNgeP6+ywfZQhuwgoE5tINNLqOofrobdGbPrR0g0j3GtyijY5lbthK+UjG7BTlMNSXh
         T5afAwQsIcKpL3jR17XRQ7W8i/Svb4JcwNMdiB4eAfTVzOoOAo1tS+H1grrkG/I/2gc7
         3ioSto+DYeGs0eXSiD0icI4QSaUX7mm0uG1+aE0nhtjP/uHEKxtv6J0aHWRq7cSieuBp
         Igzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679898998;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nbz4quyzzTyNV0lk+jHcs3Gbz5KeKe5CtOdRCXlOYRI=;
        b=zU1DaDstUoa1GjLXG7jqyBAqWvhsUF/QYllSXkIIXi0HTPDd6z/SD5tp+X01NYMxzA
         049EJ48xxZKzWzZ3WMU//0r6nJRe5zWYz7YzPCFRni1hlSI+2nW2uQUFDEsbF9V9X3Ht
         wggYOVVj/xde/UjcGh1TxpTHdtc1s+h+hKrAPWTpSXEE3yonIfBSmi2IW9/BGotps4B9
         /u9ZCKiIVJ3ONmGkJuZR/BNdnikB7MSNyM2/lsCY/fI+3F3kCtfqe6ONzjO1feeUV2yH
         tZS1v1sHT5llYvnClwsQGaDiEnZJ3P0FmBIVYc41N9TQs008yoevMKJI7UF7gFVOs0tC
         fGmg==
X-Gm-Message-State: AO0yUKVOVl5omHRNeAAegM6Hh/3exd+D1e1VFYBitn2g34cJm80Z6zdv
        5U9p9Lg65+bBD4Mb+dnAqGinBUb+MuQ=
X-Google-Smtp-Source: AK7set9TEm6Yf1SKH2dS+pZY6L++LHxV6dMVwZQrnlTLIr2j0owC4VanlXRn3a7XHPyp4H1jEDqybg==
X-Received: by 2002:a1c:4b04:0:b0:3dc:5b88:e6dd with SMTP id y4-20020a1c4b04000000b003dc5b88e6ddmr8623605wma.10.1679898997466;
        Sun, 26 Mar 2023 23:36:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b003ef6ceedf14sm3265845wmb.38.2023.03.26.23.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 23:36:37 -0700 (PDT)
Message-Id: <pull.1504.git.1679898996492.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Mar 2023 06:36:36 +0000
Subject: [PATCH] t3701: we don't need no Perl for `add -i` anymore
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

This should have been removed in `ab/retire-scripted-add-p` but wasn't.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t3701: remove PERL prereq
    
    I just noticed that this is still left-over.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1504%2Fdscho%2Ft3701-needs-no-perl-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1504/dscho/t3701-needs-no-perl-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1504

 t/t3701-add-interactive.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 3a99837d9b1..ac43333619d 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -7,12 +7,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-if test_have_prereq !PERL
-then
-	skip_all='skipping add -i (scripted) tests, perl not available'
-	test_done
-fi
-
 diff_cmp () {
 	for x
 	do

base-commit: 73876f4861cd3d187a4682290ab75c9dccadbc56
-- 
gitgitgadget
