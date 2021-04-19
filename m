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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B05C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878D66101E
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbhDSKxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbhDSKxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0429C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so29781923wrt.5
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5xliBb1w9QcuJ0w9pHRU1bxZSrBpjJ7XjtqqWTLT3aM=;
        b=gGjXRH5P1Kt9pf6GObmvOL/z50LpN0pB8yEOYCe5bnnkSoyE+bUG7WPTWVfhcMmux8
         9YdiXQ2B/ZiGntAA0NLYzKRBE4mqPXusg8eaDUs4Gb5ENeZMGV7MaJ538KlnaFkE9qSb
         ujf+4FEFmW0A5V5Wq5yEM6mvX+lAQSzaUvBT9fFrifKNA2/HjbOw+w3N5fCF5HKdABSo
         RFI/D81lZAHt7KcEHjl24acNDqSGyHnUeuSZXlHbHWASRLT7ECA6etqbkiDjT2o/K7ur
         zSxwESUgo6aynrHAdQDU6SZWTt3uwVC9sHNTrmZzcYdkFPJLgtLaL2G9IP42lD9obY+Y
         WX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5xliBb1w9QcuJ0w9pHRU1bxZSrBpjJ7XjtqqWTLT3aM=;
        b=N6Sst2cl9A3h+fJtQJWTSF1DXayYZOKIAMmzxnPa1+DcO8RwWmPJGgaYtUpml5pko+
         Z1DuTcsp2Us6efAOP3xbfP94K8zHC1+MaT7dkIfmWopM7WKRFgVLahWH1ezpTpXQqBPg
         oFd8zdLODQ2ZElkbBmdngOhClh11BpO9/eKAkaG6MQCqAZWT9La4Z9rl2ThQPUunDUxc
         5aggc48yzqbMhbd/h5N4K8IVtSVPue+5UtFYfXAkfi4aDsHT5MXgpw21cLWK5tHuPLYN
         NzSV/3A4ru5y5i+eA9fY9uGymOB62UAy21ZAWnSAHitBWMOxEPzhZ7VPlW+CAkYuhfoj
         QOZA==
X-Gm-Message-State: AOAM533hAv3Rzi3KwsFZz4QmlKd19RproG3SR+wcDPEWOGofwI/FD+ms
        CzvTHWIZhISp/ozsyfGVRDjh8zsu6VM=
X-Google-Smtp-Source: ABdhPJzx/j6q4cx6PaKXsBZkWgwqPhtcJT2f3w1KyGtwpd23myZXHRML+zsNR8jSSpHhnBCkyJybQw==
X-Received: by 2002:a5d:6e06:: with SMTP id h6mr13684787wrz.201.1618829588687;
        Mon, 19 Apr 2021 03:53:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm43171414wmr.0.2021.04.19.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:08 -0700 (PDT)
Message-Id: <79843c0d572765a3004968235391b5ae17365d56.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:52 +0000
Subject: [PATCH 07/18] t5000: inspect HEAD using git-rev-parse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t5000-tar-tree.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7204799a0b52..472fec4ee64a 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -233,9 +233,10 @@ test_expect_success \
      test_cmp expected.mtime b.mtime'
 
 test_expect_success \
-    'git get-tar-commit-id' \
-    'git get-tar-commit-id <b.tar >b.commitid &&
-     test_cmp .git/$(git symbolic-ref HEAD) b.commitid'
+	'git get-tar-commit-id' \
+	'git get-tar-commit-id <b.tar >actual &&
+	git rev-parse HEAD > expect &&
+	test_cmp expect actual'
 
 test_expect_success 'git archive with --output, override inferred format' '
 	git archive --format=tar --output=d4.zip HEAD &&
-- 
gitgitgadget

