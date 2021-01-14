Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BFBC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD1623A6C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbhANXDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbhANXDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:03:39 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAC1C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:02:59 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w2so4254585pfc.13
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yR4qB8jTCfMYn8rWN+37Q6Q7dB4IEOIPm2ZMsGIC8YU=;
        b=rNN0ANTONy3RVtQWnmtF4kIXsLpuP02tWNRgeq4zGBOFMqAweTjzwgig8ROj5bzPQN
         NnizKrz0/aFli5KMdEalot7Ynxrokwn+0q1VUe9oWBmdkgfVHhq7rAuiDZ6UtggjPj+m
         zm4xxGMg6CvWzPynsuNdZKxh5inft5ooZWPxLNdRtmkkzDQozuDXXeExZ9ThihYCbt/+
         bpAg7ZGEjS7fQGytBujLM7M+PA6Fj9GTsA/MLKPOfhxvxPyWaP5PPko3VF7PGbSZQxgR
         T1gR9sthGEucJa1t2H045RvFmLdfyIllUgApS+7qZHzWLnhcG4tSg51MhlTqmULqdyvK
         MOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yR4qB8jTCfMYn8rWN+37Q6Q7dB4IEOIPm2ZMsGIC8YU=;
        b=pnaKKmPM64bIAzhEwyu8mnG7hEYMtBcXuyQcqdqbsR2zbSao/1ULHPoJc9puseb/Xy
         8puBQz384ewxYJw1qFCIyPBb5uREv/GKuV3KSl54jAdeO1Usd6UQoQyBLXEwO1XsN0Tr
         38ajOICQROkPr9bebEBQRKs1sjGl0THWzgTCDOM8moPrU/acQAd1lVqPvkHDoSwcJ/YE
         QG5raJsqCaDUlyFFUJ6tF1PD5VktWrjPy2Ia3LyV4koBe0bDUmBM3qv7XLStjVYpPCsl
         vFAflzy3fTIEIlsevre0ZLFxFfdTVUVDXECtYpgEwhlQSAdTgIXVp8QPLy1w389fU0eU
         XemA==
X-Gm-Message-State: AOAM5306LZ+xmtgJRhgKP6+jRNjLz/mONjNhDeiMxqkAUpd90KbW8tHX
        UVYNnb2GAIE535IqCcIbN70sJqnmVg4=
X-Google-Smtp-Source: ABdhPJxujqAYSn7JlEw80yG4Ddn8p6RGzZQZlmwPgU65/B+/AA4qxWPwiHxe+iMmL6qXa6hQsYnmfg==
X-Received: by 2002:a63:3086:: with SMTP id w128mr9514514pgw.227.1610665378877;
        Thu, 14 Jan 2021 15:02:58 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id n1sm6030261pfu.28.2021.01.14.15.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:02:58 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] mailmap: test cleanup
Date:   Thu, 14 Jan 2021 15:02:39 -0800
Message-Id: <cover.1610665323.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5ea
In-Reply-To: <20210112201806.13284-1-avarab@gmail.com>
References: <20210112201806.13284-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of small test cleanups that can be applied on top of
'ab/mailmap'.

Denton Liu (2):
  test-lib-functions.sh: fix usage for test_commit()
  t4203: stop losing return codes of git commands

 t/t4203-mailmap.sh      | 21 ++++++++++++++-------
 t/test-lib-functions.sh |  4 ++--
 2 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.30.0.284.gd98b1dd5ea

