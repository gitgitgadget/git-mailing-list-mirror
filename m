Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D32CC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0619A60E78
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhG0AB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 20:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhG0ABV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 20:01:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E3EC06179B
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:41:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z4so1229366wrv.11
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfIufSmkJFCD8a6+6iKMzQHuMTJ+1UdE1Ojbift7qxI=;
        b=MLb8JGV1qHO8F0vEfsfD1+RXIM2WDowDsoxbq5NmrNelp00K+JeiTHzaRpel9Ihd3j
         iitfQaAo+Ru/l5mp6kr4ZQ1M1jLyOnWx2wF5tg/2dNFz2iZ7vUHj4AgM80lXequikVvE
         DhrA91FtNqgmmKvaQ6CVxwyUqPFgz19R0wqWl48RbOsL8e2U1ej9xJ7fL42xWvPirvJ2
         LpFOagHCbceNBskDLqcs+uVefdAGxItHo+4cOHLsZOLIWrwzQAd9nVj8mJRRDjdw3kCC
         Vhh66k8l3boBgTnqAhmyHly2H/lf1SJii8647MbnRcFDcW9yhMEJlD1dZrJJbs6dstpY
         cSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfIufSmkJFCD8a6+6iKMzQHuMTJ+1UdE1Ojbift7qxI=;
        b=S2yDaDuyuTYhxyc8Lyab5qoqHlGpGvVdLOz0xVxEu5VThPAuGxvue//uBf0eI0AoXg
         a3RD2GJ1n4gwioaxbmySG/3csdTQGZpLieM+rVA2yhpgR9hVsTRMjrshlaAngGsQjT10
         ilc1+imNLhQr12A3+TYR4BUKCJKx16JLQdPtZw6EaMJ05ExJ1iNu5hKMEmGl4eODpg6X
         s6CVXvBzGXrrtFirkljbAJYemL7LKTtVbTLZeM2EGb2FbXprSBtZoIAvrTNgoBLsDL5A
         a8Jajh3MVzbS3+v7FaJ2DW03EEARpbx/FARHK4sWclfzJW7HImKR164bt4OnkhBuYVvY
         MQVQ==
X-Gm-Message-State: AOAM533kMNzA3ffcWzWh3C4EjfBY3QmvXUEE6/jUU9eW6QsIccVIvG+R
        /hz0thVlb/CNJ5zQv+A7WieYIBVERVvqBQ==
X-Google-Smtp-Source: ABdhPJz3BVbgGnKYx3/FwaQoeaMneKXI2ToAhIzTbImuvQ8Q7elVI0kxsmdFQ/MHlpxCMtGxHbmDhg==
X-Received: by 2002:a05:6000:144a:: with SMTP id v10mr21378900wrx.339.1627346507783;
        Mon, 26 Jul 2021 17:41:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c16sm1254377wru.82.2021.07.26.17.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:41:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] bundle: show progress on "unbundle"
Date:   Tue, 27 Jul 2021 02:41:38 +0200
Message-Id: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g189fd9ae38
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This straightforward series addr progress output on "git bundle
unbundle", we already had progress output if bundles were fetched from
via the transport.c (i.e. "git clone/fetch" etc.), but not from "git
bundle unbundle" directly.

Ævar Arnfjörð Bjarmason (4):
  bundle API: start writing API documentation
  bundle API: change "flags" to be "extra_index_pack_args"
  index-pack: add --progress-title option
  bundle: show progress on "unbundle"

 Documentation/git-index-pack.txt |  6 ++++++
 builtin/bundle.c                 | 16 ++++++++++++++--
 builtin/index-pack.c             |  6 ++++++
 bundle.c                         | 17 +++++++++++------
 bundle.h                         | 15 +++++++++++++--
 transport.c                      |  5 ++++-
 6 files changed, 54 insertions(+), 11 deletions(-)

-- 
2.32.0.988.g189fd9ae38

