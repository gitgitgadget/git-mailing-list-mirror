Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F96BC3F2D1
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8368246A8
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U959sK66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgB1KhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:37:22 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:36009 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1KhV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 05:37:21 -0500
Received: by mail-wm1-f45.google.com with SMTP id g83so437792wme.1
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 02:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaeKGIvA4yCqTpNSxWfM+V5iyPxlrvD2dXk5iiCPLsU=;
        b=U959sK660Q1KlIZjpNhm1VC4Nu4rh6uKfHZb46JEY8hRFI7U6u7mKusMj4uQ9cNJ+v
         VhEOxJEG8w5aXXC/K6h8S4Lakkx0+hk1GGOnnrp8xtpe9UDPXxNJsEdaPHSqriV2bWBL
         FE0dGuU9G6zHEdcx2e2+F+e6cOqbQTTUi7oFeTl71U1lUomfEnoSBw0MyzBxpmwP5PFr
         xrptOhRrvmAeHkWrbX0ozVCDuEOMbe6zni8t4chlF8lEfvhubqnps1ubOqr38/erTRcj
         eB7RjBZF6TJazeCWha1xTZpj26ChyuicgwUZaU9rOA6lHmT1tMm1DQ3qGyRbLJg87PRo
         V5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaeKGIvA4yCqTpNSxWfM+V5iyPxlrvD2dXk5iiCPLsU=;
        b=t7ThfMinhkZ6ha0xo+/S2wGUhJlDKuWEyKNXIONnDVqTr0VoInbuKBGnfb3vpKRTN5
         waIS+kkMR5GO5NuqhfkkWME7PBbU/vaQ3AvVfuTCTnUVJ11gw3E2lLVmQekBykwMRgFi
         aC5oYldMy47luJiRW9vZNCHvs7FoF4b7lQo11GXLnVFDQkYATzv5NZekFwWYkkgX7OPR
         MrYdr3YbL5LSZyed04R9IypzLzu+WEmt3CfugVtay4/fwv6hZntxqOv7hJkCWJauDp/Y
         ZBt0oa2S+SJu9JiahZ8B4ea9+D7qneSGkCDF1gKPjOnfCryJlKSMmXNiflnxHer+GYYL
         heNg==
X-Gm-Message-State: APjAAAWRPDVsxPkIiKnaBUezzm8BIDJxxD0qfon1t4PxQgoPIULOuKli
        JiLwy7wrYFvFy9Ca81gnQPwUhVkt3wU=
X-Google-Smtp-Source: APXvYqz/zeaIGdgyhGGHBH82IA7e5eqrQK4QsnJqw/XjxO8nXc9H8gifRtT0HVE9zQY3XLLqr+PHOA==
X-Received: by 2002:a05:600c:290:: with SMTP id 16mr1832508wmk.64.1582886239066;
        Fri, 28 Feb 2020 02:37:19 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id c9sm12089032wrq.44.2020.02.28.02.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 02:37:18 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH 0/4] doc: --recurse-submodules
Date:   Fri, 28 Feb 2020 11:35:54 +0100
Message-Id: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series add some extra documentation on --recurse-submodules.

Damien Robert (4):
  doc: list all commands affected by recurse.submodule
  doc: document --recurse-submodules for reset and restore
  doc: explain how to deactivate recurse.submodule completely
  doc: be more precise on (fetch|pull).recurseSubmodules

 Documentation/config/fetch.txt     |  6 ++++--
 Documentation/config/push.txt      |  3 +++
 Documentation/config/submodule.txt | 11 +++++++++--
 Documentation/git-reset.txt        |  6 ++++++
 Documentation/git-restore.txt      |  9 +++++++++
 5 files changed, 31 insertions(+), 4 deletions(-)

-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

