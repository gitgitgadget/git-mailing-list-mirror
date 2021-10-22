Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D04C433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CF1610D0
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhJVTiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhJVTim (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:38:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8159AC061224
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 62-20020a1c0241000000b0032ca21cffeeso2146146wmc.1
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+Y4dejdbb84XjG3Uf1O1m0X8QhkadkF59FDp5uTi30=;
        b=NwNQBgsNsJ2uI8zlBy7mHUmOtiE033bRUir+ba8hRIUvGfrqm4nGWgBAay1tPSVREf
         iSo/cupieHFXyUrodoz30h0nZ00rdTWGYaHOs8aC/z9c5vnSTs4ZKpWKjB/Kox5WNR6o
         /4BtUycRSKfWnMNRmECbPgwF+S1KRuSZxNx8Vf+r618k5AtFnBAI3Zwts6OD9zXyhz+9
         YwLUvCPDsG+7qunoE3YPp4XyzvHeDUz+ATE53blrClT5/upIYrk9hvVE+VD6p/gR2WRU
         VMWutAPUJKwujBULVm2Zs6mzOMl2NvPsrSYPuXEYBUFBxRn6/Jt1Kg6G4QNDvA1aOzrc
         Rxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+Y4dejdbb84XjG3Uf1O1m0X8QhkadkF59FDp5uTi30=;
        b=Wu4V425r5iz7enh22+Ja/n5SoncV/lrSEcntUklUMdTpe5mcBPtYTg9v3Iu9mXXQwV
         QTeJYMwszJCtz+Lbj9VcBnhrzcHiTLyFD9ESiKzY0B7G28zDxya6/squYziP9lyDTR31
         8MOGez7ImVnhAdJ5cz1WzrVbp5g0yHo4djY3X838tNck3TYtniohBHusovtaoU3PlPI5
         ju2ylGbiPfkIrGDfwxTdwH3AVQPpshTvqsKDk1WeblrW8PH3LehXvyIJhpj0s+xtbgp0
         an4O6O8PV1DJETNe/g8JD9DPHrHR+gONWEh961ue6FpdfBavoRhBZJRa8ZPB60EthmSH
         eCJQ==
X-Gm-Message-State: AOAM532qzja1BY8njueraDu6BpW6nosMdflbLldxQocbqPD0M4UXWvwm
        OqHBupeSITb8kLjR+8uEpXtGLVVW5qLNqg==
X-Google-Smtp-Source: ABdhPJwIJEDnTmF9DTXthjay3TSZ6r7cCkD0XrRvbMetmraeOlqqurhoEuPdGIxeiNPhR2pQ45BCsA==
X-Received: by 2002:a7b:ce8d:: with SMTP id q13mr30550720wmj.103.1634931380821;
        Fri, 22 Oct 2021 12:36:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm8871814wrs.73.2021.10.22.12.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:36:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] generate-cmdlist.sh: run "grep | sort", not "sort | grep"
Date:   Fri, 22 Oct 2021 21:36:09 +0200
Message-Id: <patch-v2-05.10-f01c1fd8088-20211022T193027Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This doesn't matter for performance, but let's not include the empty
lines in our sorting. This makes the intent of the code clearer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 16043e38476..e517c33710a 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -18,8 +18,8 @@ category_list () {
 	command_list "$1" |
 	cut -c 40- |
 	tr ' ' '\012' |
-	LC_ALL=C sort -u |
-	grep -v '^$'
+	grep -v '^$' |
+	LC_ALL=C sort -u
 }
 
 get_synopsis () {
-- 
2.33.1.1505.g075a284c562

