Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E89C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FF220659
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQQIOjLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgDEUQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:16:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53834 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgDEUQw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 16:16:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id d77so12649768wmd.3
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qgtjpXecbKuFFyz3u3Y/bnIj7wnhC2ol2RbwnLL5TRo=;
        b=rQQIOjLV4/lQvJNtx3/s0GQzbdTFN7tJOlxYIhZLExUU3ikcEaSLhY9d1TjW66Vbjo
         A0U6u9Fb9O989PMH/xAfsESPNE5x5oDGOn/o+2P87ymIsStpknEC0H6eE2jTv+rSgYP+
         uGMWjH/CnE1T7y3lEJS50eFsCD8wRWtS2WBHt89O+/LY4MaKOgJ9D1mtJqRbpBaXXzo+
         +1j9FiWPfExRUiIEs8fpVf8vHCfgFG+V5QneP3mZyr2aTinnhZ0o2sB7HW1gtzBn4pdq
         8R+GRvbFw+SQNjQ+fmg9Mm028qndCmwXqq18Ap6Z2jczzCd6O2Oon4UzVY19V6YsNwLJ
         UZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qgtjpXecbKuFFyz3u3Y/bnIj7wnhC2ol2RbwnLL5TRo=;
        b=UroSLmX2eERn/+8V9glOFIwoHe21sa5TDxrRrMegAYLcVzKmOwEqydPg7Ak18n05Ia
         QsA80ZAJFe9WYXW/wMMMsB/0KNJKZfYHXjNYaqek9DlNWCad+9N7osSJoiow5iYNhb7F
         jfthlFqdYuQNw2i0kIc74CADnvK1yIic5c9qMbwq+KCxtvTDvwVqLz80KEZj2Tb8NenF
         hPyt7b1b8rLC2EGXYTaId7+cznaddDJ+I5oThQobWI5vrIZwbg3S/K92GzqxH+2x8b8E
         Qky4T0Jl5pPJAWWlqkk/CXWmuArk1z6tvzjUM8Kz1MqXKE1Tltbm4H6IklrmSWMKjjTH
         wQnQ==
X-Gm-Message-State: AGi0Pubqq9s2TWXk/6F7mKy+gdHPMqfrGYOcrGTiP3e6SuPkpcXO4eRq
        m7CBvQNASmn+RdvdBGaRak3iPEkOlUqWDQ==
X-Google-Smtp-Source: APiQypJ//R+9TD6wGtPPZPaU6hgJnZQuFb+sCEyvpjl9ul/oOT5piw/e8huAoIA6vTHUE4UTI1XOLw==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr19482123wmo.85.1586117809730;
        Sun, 05 Apr 2020 13:16:49 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id d7sm22468921wrr.77.2020.04.05.13.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 13:16:49 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v5 0/5] doc: --recurse-submodules
Date:   Sun,  5 Apr 2020 22:16:28 +0200
Message-Id: <20200405201633.704987-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry it took me a while, I have been busy.
I incorporated the two remarks by Philippe Blain on v4.

We are converging!

Damien Robert (5):
  doc: list all commands affected by submodule.recurse
  doc: document --recurse-submodules for reset and restore
  doc: explain how to deactivate submodule.recurse completely
  doc: be more precise on (fetch|push).recurseSubmodules
  doc: --recurse-submodules mostly applies to active submodules

 Documentation/config/fetch.txt     | 13 ++++++++-----
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
 13 files changed, 52 insertions(+), 19 deletions(-)

-- 
Patched on top of v2.26.0-106-g9fadedd637 (git version 2.26.0)

