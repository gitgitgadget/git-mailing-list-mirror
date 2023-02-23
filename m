Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CDFC64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 20:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBWUzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 15:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBWUzG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 15:55:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF53030192
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 12:55:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso42672wmi.4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 12:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hQF1VWuzInHRFjjQHHJ9QmzTSXN2bNK5UEQBaXeSCTw=;
        b=axNKv3ah3lNFBGzWq/yg6WtTuXiVfZOBANFR9zdmqNEQQbmu+Mb90IdEQwCuY2Wlk3
         QW6ZGIme9Mm6fXlUK/rUXo9mYjyEYyfD82v3z+d+r8unU1fdCx+Zdv4oDqAQZoJjcoRy
         obVSOkXBoc7GhwclJnJ4AzPAyu+n7GNweXewDEZ8Jvm7dUgWtrPFZgUWa8V56jIZ2i3e
         n5D15hjTMwl29b8hRF6tS98O3GLSmLwAZMkX8zx30NAi7/FtiX7Cx6Xz4QiZLTW4YTD0
         srBYWlcBoBi+yo8q84LREmuUQ8MN9LxfH6ylRbeMuHwdxD7A2cwh8DAX9U6WE5SvtwGF
         6J7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQF1VWuzInHRFjjQHHJ9QmzTSXN2bNK5UEQBaXeSCTw=;
        b=RLC84ZNNBojx1p6+j83Nim8pTcqZV72FPYjZ6TtGnEmUpqhp2a3jVq23Vtf270znT5
         wrRBOyfgDbOx5Z95d2Ozs9HTDm3wZflKRP3v0eLDal5oqo2tczddWS2sCZ/phGEoKzLg
         0ayooOgaP38vWLcy+4Xt35EtkwvALi6NyPDZ+TNZaJGRaV5K42LstOe2cl/FXdl+iZtb
         lfBhT1HLkDPrsO3wBjxeWyfU4GWI98gpc6f3oExS+KefcyBGhaShdhluGyl/GQJVdjje
         jpXwjYwjM8Sp9YZycLcnFdm6VG4HB6XFqwkh2ONl4eDcOXUgBKvsOyGDEymw6s6K6IeN
         gTzQ==
X-Gm-Message-State: AO0yUKXDCd4JdFLWH74boQ6wwMfhsj0v+hjdQAxdtf3WVxIV//4WvCUN
        d/Wb3XZuQsEZbr16G1kXjHcjnvOF8fA=
X-Google-Smtp-Source: AK7set+/hQoVK3admomTEDtdDDAPiUTIre6ggEOT5IaHHAcDLI/PfPH7ViGsgUA6TREyPlDhOg+I+g==
X-Received: by 2002:a05:600c:5126:b0:3e9:f4c2:b604 with SMTP id o38-20020a05600c512600b003e9f4c2b604mr3803484wms.24.1677185702922;
        Thu, 23 Feb 2023 12:55:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c63-20020a1c3542000000b003dc1a525f22sm436847wma.25.2023.02.23.12.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 12:55:02 -0800 (PST)
Message-Id: <pull.1486.git.1677185701.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 20:54:59 +0000
Subject: [PATCH 0/2] sequencer parsing fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a couple of small bugs in the parsing of todo lists

Phillip Wood (2):
  rebase -i: match whole word in is_command()
  rebase -i: fix parsing of "fixup -C<commit>"

 sequencer.c                     | 18 ++++++++----------
 t/lib-rebase.sh                 | 10 +++++++---
 t/t3404-rebase-interactive.sh   | 12 +++++++-----
 t/t3437-rebase-fixup-options.sh | 26 ++++++++++++++++++++++++++
 t/test-lib-functions.sh         |  8 ++++++++
 5 files changed, 56 insertions(+), 18 deletions(-)


base-commit: 06dd2baa8da4a73421b959ec026a43711b9d77f9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1486%2Fphillipwood%2Fsequencer-parsing-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1486/phillipwood/sequencer-parsing-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1486
-- 
gitgitgadget
