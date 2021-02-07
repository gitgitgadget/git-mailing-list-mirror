Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF3EC433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7E864E31
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBGSTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGSTS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:19:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80767C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 10:18:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z9so7485077pjl.5
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 10:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHvWecUzwF0kWQU0IXzKRtLazGmJ8138iVhpxqjV3+8=;
        b=VIw7krha47Fduajd289NgEpyBUvm46LVM0SOWiYJbTOkXKwSQzIK8754Tc02+kYHr4
         W2S2AEBWzX1BontrSY9WbF9SwucgkkwwJ1BXeJpG896Aj6JS80UcF8rqc7EcMjyO+0Jd
         lbyEsJ17Wa+jVaqDJ//Lw7jO31bVULbA+T/YbRK8AODKTzbanbaI7GleifzJjw+LtNZE
         m2zECqnEvncwF/dBFKT9xuFnf5M7e2agskUgvDw3PamQcEKhlnyOK7nhxiVFk04FU5I+
         eFZp6jBENaquosZhTAzOsArNCNsBeEN/AQNd1GxwhFQAdQb+GoTbH9EFuYl1vu/NFuEx
         MQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHvWecUzwF0kWQU0IXzKRtLazGmJ8138iVhpxqjV3+8=;
        b=PIP6H8QidlOVka3TgJQh1Ms3A+9qITwfT5dtJf3PZjtIkg16jqm/O28i/7VVE7Jk8/
         7xL/fqCLpnSku0lA3H2vZqjSrFxGl0AcYEeZWT5mzF/mS4lGqvaoExqW01xBRHh8jO3q
         XAbAXVoP8u26OdCLTRgkKxhOqN/SzuRfXZBQSDoO/YyV0drWDJ8TJe15msIPqStmRMvv
         2SZordVG4HPbHd8TwKRWFOks5VsdMssQZB9rbJPdjPJGcnkMmkVEnkt8vQG/sLXDh7zr
         JLsWyMf+zYREi82lW3NfzJloJIgAx6EAUeNbL0MdUTkjbJZ84qUgnIl6R/42r6PnxF3X
         d1hg==
X-Gm-Message-State: AOAM5338kyJWpoN+IHPiwUcA0DsyMUy/Cw+yWX39ZjuQEi+/ZDwoSf5P
        kgcmSpzNQB86F+RTa5rMkTfA8xdzHa2t5Q==
X-Google-Smtp-Source: ABdhPJxW2TQ1j6ptZP67/6Az2WN3n4XTAjWvmFfYDvruyTSW1u3L0sNnJrxwLuJeoyBYzgIIWfZV0g==
X-Received: by 2002:a17:90b:182:: with SMTP id t2mr13631058pjs.215.1612721917853;
        Sun, 07 Feb 2021 10:18:37 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:4438:7fbe:1d1f:8bc])
        by smtp.googlemail.com with ESMTPSA id n7sm16375194pfn.141.2021.02.07.10.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 10:18:37 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH 0/7][Outreachy] Improve the 'fixup [-C | -c]' in interactive rebase
Date:   Sun,  7 Feb 2021 23:44:33 +0530
Message-Id: <20210207181439.1178-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is build on the top of "cm/rebase-i" in the 'next' branch and
improves it. It fixup the source code of 'fixup [-C | -c]' command in the
sequencer, do some fixes in rebase -i, improves the 'fixup_-C' like commands
in lib-rebase.sh, update the test-script 't3437' and fixes a typo in the
documentation.

(Thanks to Junio C Hamano, Eric Sunshine, Christian Couder and Phillip Wood
for the suggestions and guidance for this patch series)

Charvi Mendiratta (7):
  sequencer: fixup the datatype of the 'flag' argument
  sequencer: rename a few functions
  rebase -i: clarify and fix 'fixup -c' rebase-todo help
  t/lib-rebase: change the implementation of commands with options
  t3437: fix indendation of the here-doc
  t/t3437: update the tests
  doc/rebase -i: fix typo in the documentation of 'fixup' command

 Documentation/git-rebase.txt    |   2 +-
 rebase-interactive.c            |   6 +-
 sequencer.c                     |  23 +++---
 t/lib-rebase.sh                 |   8 +-
 t/t3437-rebase-fixup-options.sh | 140 +++++++++++++++++---------------
 5 files changed, 93 insertions(+), 86 deletions(-)

--
2.29.0.rc1

