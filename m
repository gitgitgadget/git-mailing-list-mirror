Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E0C2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 10:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EBF20659
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 10:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjVUT1Rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBFK5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:57:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42426 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgBFK5y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 05:57:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id e8so2195586plt.9
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 02:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlqYfZzbE3WrHxN7YApf+beZ7d9+/lx+A5WMtkjmVIw=;
        b=DjVUT1RhHeU1VidUup+Vk1WwyMkfsubzAYvzu74Dem2vLlydCjD9QQ0fPtonC7FBq3
         BUr75yMspuP5XGOQeeQ4R9qnGiTC8Wgpk8s9GeokbYwjARRkaHyuxXfxojiZbHEtREEJ
         G3grDRR7apZdoeZ2hgo9DSAU/kbA6os5fwiyP39pLE9X5x8Cw7zGJo8/jAguGlW10ckq
         Nw5OmVUk0N9OG/X7dtnS6fvf11Uf/YSKri2Yx0BrHAf8TvV0JlJsA7xolfrAbXg5+JnW
         +aET1OHtNmyIkmtRmqt4TP90sMPwxfKkyLJeteVfE9AMzSAbZWaeL7izfmI0jVgyvgm8
         v1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlqYfZzbE3WrHxN7YApf+beZ7d9+/lx+A5WMtkjmVIw=;
        b=tmJ2d6q8++fONa25EdYpnW8iAaqUPiZuHZFr5TEMxrQmhYjrZpePkCBqLY9ii04KeL
         m6qe3nbQF1FzTEda9Doh/DCW0RAak897ZrN6c7/yK/Dple5M7EJ76L8w1mCbonV9Jl4i
         1BPzRSTqu0AQhSshMfw34XDQuH9IxCqhgZv2gWyzo87xpmCU5qkMDk6hx97a/XtEsTIE
         MaQWHw1fdMWnt0VYO+U+rBCJQZprWVhcMWepiQylZOgyvIjyUgPyfgG4NeCZxnoQkjoW
         o9z/X7yJnztn5ugkdyoBrQekLREQRWA/UlQsSyrxOOrhsppzN7rQp8Avi3WitpXJxcNP
         lVfQ==
X-Gm-Message-State: APjAAAVq09oBOg3wDrd+533b6zCRabrZWo77X50QXD33VYhkap+ebM3T
        pj0NBm8RUOkShIjoCicH9DAb948C
X-Google-Smtp-Source: APXvYqx35SQxalIQ7nQ98wTtChpVOgATBnBllQWfBrd6RuWZhlFvxMlopRuiKCNutvIjCCG4YW7h5Q==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr3253877plv.194.1580986674066;
        Thu, 06 Feb 2020 02:57:54 -0800 (PST)
Received: from localhost.localdomain (115-189-93-166.mobile.spark.co.nz. [115.189.93.166])
        by smtp.gmail.com with ESMTPSA id u13sm2944293pjn.29.2020.02.06.02.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Feb 2020 02:57:53 -0800 (PST)
From:   Heba Waly <heba.waly@gmail.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com, gitster@pobox.com,
        jonathantanmy@google.com, Heba Waly <heba.waly@gmail.com>
Subject: [Outreachy][PATCH 0/1] add: change advice config variables used by the add API
Date:   Thu,  6 Feb 2020 23:57:29 +1300
Message-Id: <20200206105730.16231-1-heba.waly@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

advice.addNothing config variable is used to control the visibility of
two advice messages in the add library. This config variable is
replaced by two new variables, whose names are more clear and relevant
to the two cases.

Also add the two new variables to the documentation.

Heba Waly (1):
  add: change advice config variables used by the add API

 Documentation/config/advice.txt |  6 ++++++
 advice.c                        |  6 ++++--
 advice.h                        |  3 ++-
 builtin/add.c                   | 12 ++++++++----
 t/t3700-add.sh                  |  2 ++
 5 files changed, 22 insertions(+), 7 deletions(-)

--
This change is built on top of hw/advice-add-nothing

2.21.0 (Apple Git-122.2)

