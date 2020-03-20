Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64F5C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDBE20658
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXI5b/P4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCTViH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:38:07 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41908 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTViH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 17:38:07 -0400
Received: by mail-wr1-f47.google.com with SMTP id h9so9234997wrc.8
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEtjLLVdPhzwarlBn5yZ095vaLgJ9+wbP+2pBOpXWdw=;
        b=kXI5b/P4nJ7Vztx+fQkGvkpPh+HLeXD/FsMltTOV1L61060ZppWzmAncmGmOZ7AHXv
         1LjSdt4OG1MPvyTP6y4BS/hfX2gdjtjTlMU8n73pg3jFGAqZHJBga1HYPbJdv4IIBuSZ
         foPoNqFy25qah3O+ti9KPTft63U+ndAQ2odpNgGkDkpxFbd/uWGTtzPf7laBqr5F1DeC
         Up1QAdoaTmpiY2X6dGLOeQLEGVbqI3Un7KqRMSNZWTZz7OH0oJd11OfLHsYiFDXlfvoh
         O+xafd6ZFdFaW/fJ8RHDbKiwRlOafTf7F2HtX8P429SM6lwF+4FR7ZrhoZrzqB9PKjoW
         hbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEtjLLVdPhzwarlBn5yZ095vaLgJ9+wbP+2pBOpXWdw=;
        b=cr7G4oWHnBYQYJSgUGE0kwdrK0WIdpbVCzrvDifseKl30a0+GIH0Ct+QlB41AgMmXa
         L7FuLZg2ypWfZMla48S/J9z1reQ/IGZFXfXrKbEfD581PARk33BLZksSFmPbyjD4Re50
         w5nZwraQxw445f94OVFPlDh5mOOXSbtR4WmFZbNlCWV067Y0GENY+nurSK/DeGymuHfB
         yKrEsbKJJxOkXFzzVu0VFbIxNAy/793EhKUOFGtb6GLLhbv1ZBaV8emtirZ+DQbbJ5EY
         Qr5jXmiW/FIj3PFBLTL+wZI8KHviLD32Notoyx26e6RjKyuWg8mQ4SnCKcM2TKYRvD1+
         Bb6g==
X-Gm-Message-State: ANhLgQ23OBZKUZ7/+Mq4Uw2UE1qzaMMfD0oDbM/XOHzUtTAhC449sdhQ
        6IwVWtNa/9Wx8BMNJJ1B5iZo9nTF5F4=
X-Google-Smtp-Source: ADFU+vs3gwgmnK011cHdo8iYtYsu7unvzQGCzc6LcEIyyFpcM26crsdJmqZAt5vT6dpw7CBIA2dDww==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr2628512wro.227.1584740285012;
        Fri, 20 Mar 2020 14:38:05 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id i1sm9742407wrq.89.2020.03.20.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:38:04 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v3 0/5] doc: --recurse-submodules
Date:   Fri, 20 Mar 2020 22:37:24 +0100
Message-Id: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v3, incorporating all remarks received:
- The typos mistakes mentioned by Robert and Junio.
- The main change is patch 5/5 where I incorporated the nice explanations of
  Philippe Blain.

Damien Robert (5):
  doc: list all commands affected by submodule.recurse
  doc: document --recurse-submodules for reset and restore
  doc: explain how to deactivate submodule.recurse completely
  doc: be more precise on (fetch|push).recurseSubmodules
  doc: --recurse-submodules mostly only apply to active submodules

 Documentation/config/fetch.txt     | 10 ++++++----
 Documentation/config/push.txt      |  2 ++
 Documentation/config/submodule.txt | 12 ++++++++++--
 Documentation/fetch-options.txt    |  3 ++-
 Documentation/git-checkout.txt     |  2 +-
 Documentation/git-grep.txt         |  2 +-
 Documentation/git-ls-files.txt     |  2 +-
 Documentation/git-pull.txt         |  5 ++---
 Documentation/git-read-tree.txt    |  2 +-
 Documentation/git-reset.txt        |  6 ++++++
 Documentation/git-restore.txt      | 10 ++++++++++
 Documentation/git-switch.txt       |  2 +-
 Documentation/gitsubmodules.txt    |  3 ++-
 13 files changed, 45 insertions(+), 16 deletions(-)

-- 
Patched on top of v2.26.0-rc2-27-gbe8661a328 (git version 2.25.2)

