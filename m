Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD60C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 09:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D01064F10
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 09:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhCRJr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 05:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhCRJrG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 05:47:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C84CC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 02:47:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so2442726pjb.4
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jv4NT1GMSWNRSVSILiXI6o7+Nq0aGTx3fZssmufEfAM=;
        b=YZCq3dNBSTua/euA3uwSa83scU/bzBAzNWdUGJPpQtQWXRshZFGHm79gTc2X1FSkAl
         Xu25hGWBq4886dZoKIRd7CQZqvsCbliaE54QjjzAKI+cSm7hc4v9aBd312ReJUtpHBy+
         ss2yiYd2tnuFYsoGT52tZXlQEy+cCYNaGUrD90J0WcMci+JiUKNlEGzRNx6oXSjWuJCy
         +/fAm2pVavxG77clmBMxzHmCN6UPfJVDi5HB6P4iiV/x1YY/AHc9Pev/hSGJMMqLoVIb
         YZOW1y6135Kyo0XbVVGU2ETEZ3HFQoUyxZQ6kXsjjJ4jikQuQuVs0xXxEqZPmS4i3fyN
         WLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jv4NT1GMSWNRSVSILiXI6o7+Nq0aGTx3fZssmufEfAM=;
        b=Y2SQEHs/yiD9X/9Sa3K8BcZIVTeGB1k1rBIBmMK4T+4NOOzooeedT2ha8GK0Xev1EQ
         JhvwOEhEb9fEbHvnzVSa3uisXznwocF6xbP7lQQw9KWKeEwnNhbISnlM60DyQ13XCGx/
         8HpwL3okBmLko2/mEggeX9Ii7D5DuUIsq3YfFbw0gpFWAu5XcS1vrs4leFujz6ohGY0i
         d02RGxBe9+BTsj828WZwP19Z2c0eQnNZ0o4+2p9rogzRCqM2ZLUiUYgQkulI1iTfB8Go
         jutrresfilCEvPej4pcYfDXvM1jB3mA3s64p1UsZxVknN/SivKMWOb7U/Dm1MQiuCtOb
         I97Q==
X-Gm-Message-State: AOAM530ufz39oUtCuytN+tM6queEFX7pSm4tmGdYONStvphpqVAuoAsD
        pGvEWIoWwsyYynIG2SxyRVvbunWV0Kw=
X-Google-Smtp-Source: ABdhPJx6g0qZSlppz8dlm7t7v3TYD2BHSx42Dl5f9ZgUPCb5+VAD14Oy9W8b/wnmlmyzVOu1x1Bdcw==
X-Received: by 2002:a17:90b:798:: with SMTP id l24mr3270727pjz.63.1616060825549;
        Thu, 18 Mar 2021 02:47:05 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id b186sm1902326pfb.170.2021.03.18.02.47.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 02:47:04 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [RESEND PATCH 0/3] git-completion.bash: improvements to _git_stash()
Date:   Thu, 18 Mar 2021 02:46:53 -0700
Message-Id: <cover.1616060793.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615855962.git.liu.denton@gmail.com>
References: <cover.1615855962.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series modernises the _git_stash() completion handler by letting it
take advantage of __gitcomp_builtin(). Also, it fixes a bug with how it
offers completions when arguments are provided to the main git command.

Denton Liu (3):
  git-completion.bash: extract from else in _git_stash()
  git-completion.bash: fix `git <args>... stash branch` bug
  git-completion.bash: use __gitcomp_builtin() in _git_stash()

 contrib/completion/git-completion.bash | 103 +++++++++++++------------
 1 file changed, 52 insertions(+), 51 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620

