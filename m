Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56210C43464
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 08:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86AA21582
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 08:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="bZn4+dtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgISIx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 04:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISIx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 04:53:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A59FC0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 01:53:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e17so7400821wme.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 01:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSLAeob2T3P78jPDNHLs3bWVDriy67Oyb+QP6CcoYxM=;
        b=bZn4+dtKiuorivhmlf8ag/puCONMejaINq98Ip1BVLjX2pln5W17UgDz+DvGa0gr9p
         05fLL+nPunUZzFl5XyYIR684MV/KQ0Ef/d/lzDiLcXNVSDaCTwG5jMcI1+hWDUy65uiT
         BG7MRPL+5OOkDAfxHvehHRyEvATghRQkLJZQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSLAeob2T3P78jPDNHLs3bWVDriy67Oyb+QP6CcoYxM=;
        b=grcA3nUSTsnyMbyKFvLZ9iz4oT5bhelWanBo3FairKsa84TLeENac14/yMuNe+Vi/U
         NSL2UwvX6rkVbZ4hOh1ZQPS7aioKis/ZidPuOJt7kWwOfhvNimKQERVgU7nIUEUiIc/V
         H63Ml1B/DN8P/v18LhiKi50sMiTe1dx6uq/DoWQ/u0+v2flFXkSTwXGxVHQgx2GkAR9Z
         1FeAWJjlGrSQMBUHS3QKbQTz8zcgUfAwFU38ujDuNRtdkO/P+ICgU9oIHISl6kmTJ/Qf
         Ex5ZhwooDXL5z4S76MA5VFyRERJwWVJMaYZj1xz4ysc/AJb+jxqBEyV3tW1vk3Racq6c
         fyNg==
X-Gm-Message-State: AOAM533dlXJgjjeCFbO5Q13u2KwQVrwc0hiYGLCar5r3U80dEt+t7Sd6
        u4/ydTwiXAv7l61zZ1hFpkxGW1EoQUam/g==
X-Google-Smtp-Source: ABdhPJx114wCgsIki+j4Ej4/zgMxi+e1Ys8ZASqlci7X3Jnn/cjghaxPBxe0xqsEE4RfdPcuPbf4eQ==
X-Received: by 2002:a1c:7514:: with SMTP id o20mr19044456wmc.76.1600505634904;
        Sat, 19 Sep 2020 01:53:54 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id t15sm8798872wmj.15.2020.09.19.01.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 01:53:54 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/2] git-p4: unshelve uses HEAD^n, not HEAD~n
Date:   Sat, 19 Sep 2020 09:54:39 +0100
Message-Id: <20200919085441.7621-1-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jackson(Xuhui) Liu found that git-p4 unshelve fails, and suggested a
fix.

I have updated the tests to spot the error, and added his suggested fix,
which also works for me.

Luke Diamand (2):
  git-p4 unshelve: adding a commit breaks git-p4 unshelve
  git-p4: use HEAD~$n to find parent commit for unshelve

 git-p4.py           | 2 +-
 t/t9832-unshelve.sh | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.28.0

