Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A5EC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4507E6058D
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhI0NA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 09:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhI0NA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 09:00:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0963C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:58:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q127-20020a1ca785000000b0030cb71ea4d1so391544wme.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqyY6fFFmj139C8NxCu7otHsu0Zp9aOpUbRxrIPrYHw=;
        b=N687CagU1oq6jP8qWsJKvJZkjn16+GKvx9SGnF4ywA+wmjoE6T9RSfhW5AhsTAbLN2
         MXo3u8cshYzEXc2Pe55epEyeoZwV5qsMjqv8XEzYLipUpubm8G52/86tepZaFE5ziYCI
         RFJ9yabBEGDHfQr9S2M2rEiw1zMwc1NTd8izLorWhxAfH09umUOvoHbHolQN1GBpSLvR
         NA5lxYaBKTHL4XSuyqREhxtihmCWpJG8ikN5Bc5t1n7uWQ8TMSaM7EJbYrGOqB4jAii7
         bB8GJltrDiEQntOg7qCHJWtpIE9EngXaOa+hvIRlpv7ZqWs4ivcwb5JXFmnLM54+P+Jv
         G+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqyY6fFFmj139C8NxCu7otHsu0Zp9aOpUbRxrIPrYHw=;
        b=n6a2KTGOPUyyEEw6K7UADzvSs3Lsvdfy+msal+WhwdJG59M4wC8RY5mNQNzd6UaqaC
         ylnLcoQlu9mUXSEYQzmRMouK+bk+2w094uuEFJnrSGTdIDyLsASCTVf3aSzeu6K1m30+
         nWgvZcX6i/1OzbB5nh6gLpk+2qZortyrq4TSTGosfUZMWYYUMeSoiy1rVPBBWjCRCVfi
         3ttBbdOOPLND4vNmxJd8Lpn2Br2/42eiGi3ylUeCld8bwdj167QIE6243a97pMWMilVC
         h8IVwTXnch7pDeVdFNp2FwzP0je22DYpom0c4qYJD/Z/VCTFCe9nBisKOiGx2NZ9Q3a4
         +rsA==
X-Gm-Message-State: AOAM531dUiAviMRe52pWC9MPmKISAVKhD2XIhxutA37K4KanX0vec518
        6bL6+FHG+L98hQaW6Bh9hKSoROr2fyQ+IA==
X-Google-Smtp-Source: ABdhPJzkR5WdkZ32LmI8+HZt2dhReLkyr8tsVUso9c9OjvkjsVnfhkfZsxJqFJuUbhLt5kqRcuZ6nQ==
X-Received: by 2002:a05:600c:1c9a:: with SMTP id k26mr15370336wms.169.1632747527927;
        Mon, 27 Sep 2021 05:58:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j21sm17562179wmj.40.2021.09.27.05.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:58:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] Non-trivial designated initializer conversion
Date:   Mon, 27 Sep 2021 14:58:40 +0200
Message-Id: <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See
http://lore.kernel.org/git/cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com
for the v1 & goals. As noted in
http://lore.kernel.org/git/87lf3i1e7k.fsf@evledraar.gmail.com I
ejected the previous 3/6. It wasn't incorrect, but partially
converting to an *_INIT macro doesn't make any sense in the "struct
shortlog" case.

Ævar Arnfjörð Bjarmason (5):
  daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
  builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
  urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
  builtin/remote.c: add and use a REF_STATES_INIT
  builtin/remote.c: add and use SHOW_INFO_INIT

 builtin/blame.c  |  30 ++++++-------
 builtin/config.c |   3 +-
 builtin/remote.c | 111 +++++++++++++++++++++++------------------------
 credential.c     |   4 +-
 daemon.c         |  19 +++-----
 http.c           |   4 +-
 urlmatch.h       |   4 ++
 7 files changed, 82 insertions(+), 93 deletions(-)

Range-diff against v1:
1:  3130693b416 = 1:  3130693b416 daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
2:  65c5295c1ac = 2:  65c5295c1ac builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
3:  c9db107fcb1 < -:  ----------- shortlog: use designated initializer for "struct shortlog"
4:  cb4c81dcc83 = 3:  3783788b553 urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
5:  1c34c00feb5 = 4:  13ef9566903 builtin/remote.c: add and use a REF_STATES_INIT
6:  76fa070e89c = 5:  b78a9ec0846 builtin/remote.c: add and use SHOW_INFO_INIT
-- 
2.33.0.1316.gb2e9b3ba3ae

