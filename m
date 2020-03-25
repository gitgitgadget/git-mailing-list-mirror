Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03945C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74E7207FC
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg4cawTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCYVK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:10:26 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36632 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYVKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:10:25 -0400
Received: by mail-wm1-f52.google.com with SMTP id g62so4705737wme.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1dULQtHOMl1cdrjMHQdY/5i9O9CtCe5+yerOWQfe54=;
        b=Cg4cawTcQw3eVHxwxh8C3ksvHAM0RqzyR66xad5CZzKZ317EDpiIsd0yBOuM56uGfd
         w0ezjrtHbmenKIvVpB0ol0CKhkOS0NokuOUZh/b6z6DuZInpeVn59jhIj6rogL1wJIQL
         1QFkUjL73kHdnJA65Feo57vUZb+Tz4xWQC+8EdGbCZ2r2bZsgVn1jv6kE0aQ8wFrvI8w
         8IwjM+hCnRNk3J3f121A8yzyTaexA3VB/S6kNl95IcYr29qfI+kzmzTv8Y1l7CB2R3uR
         Vduyc0Z4wsVlQoQiUVJQ8mUWqA0LNMerXytcvbKE6eemtokGHnNop+8+6bIYRWxV0mFf
         YfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1dULQtHOMl1cdrjMHQdY/5i9O9CtCe5+yerOWQfe54=;
        b=Em3cmhslYqBE1x72Szu7XyVLF92cMRB9tDKKq1y190IsGXB3Aw9CiuINo6N+30bUC0
         rJ5UAzW623MYG8D0Rh91jbqcQhr40fr7vKAUSVuK2ZVOeA5Smr3rsLmk93ufZ1vKApWF
         oGahTX36RBXMe0Qlj32P2LwxxlvHj65AHZFI4aB2OcJaNsH/JoHBNY2L2HmiFIo0uM9I
         NsAzzUO8EM6n2Tva/KTD7QnJaLq0TznpFIopoctbM7RgxJhTofviBNiHIeYjLCqKufW8
         MQw4tudc6lHnv8YPo2mxyj/DDtvKDae5Usgv2aMZbqn31AX5f5JX/r3rYL7bYyaWJkCl
         bQmg==
X-Gm-Message-State: ANhLgQ07eZSUpnbhqXhN8/EBBgRW3xAnHm14qN3KCfe0QH8Iod+O0wcn
        hMHgdbUcgLPJ+qb75A3CoBL1HKlSWXU=
X-Google-Smtp-Source: ADFU+vsdXAQkgwBIfIzKDVuEd1NJ3bl/2+A+2QRQ6BUj/gYYRVDAvhdC+vRUcZivUTwq4Y/kRlJVAQ==
X-Received: by 2002:a7b:c004:: with SMTP id c4mr5245023wmb.108.1585170624145;
        Wed, 25 Mar 2020 14:10:24 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id u16sm352760wro.23.2020.03.25.14.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:10:23 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v4 0/5] doc: --recurse-submodules
Date:   Wed, 25 Mar 2020 22:09:38 +0100
Message-Id: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No big changes this time, I just incorporated the latest round of remarks.
(A big thanks to Philippe Blain for these!)

Damien Robert (5):
  doc: list all commands affected by submodule.recurse
  doc: document --recurse-submodules for reset and restore
  doc: explain how to deactivate submodule.recurse completely
  doc: be more precise on (fetch|push).recurseSubmodules
  doc: --recurse-submodules mostly applies to active submodules

 Documentation/config/fetch.txt     |  9 +++++----
 Documentation/config/push.txt      |  2 ++
 Documentation/config/submodule.txt | 12 ++++++++++--
 Documentation/fetch-options.txt    |  3 ++-
 Documentation/git-checkout.txt     |  4 ++--
 Documentation/git-grep.txt         |  2 +-
 Documentation/git-ls-files.txt     |  2 +-
 Documentation/git-pull.txt         |  5 +++--
 Documentation/git-read-tree.txt    |  4 ++--
 Documentation/git-reset.txt        |  6 ++++++
 Documentation/git-restore.txt      | 11 +++++++++++
 Documentation/git-switch.txt       |  4 ++--
 Documentation/gitsubmodules.txt    |  3 ++-
 13 files changed, 49 insertions(+), 18 deletions(-)

-- 
Patched on top of v2.26.0 (git version 2.25.2)

