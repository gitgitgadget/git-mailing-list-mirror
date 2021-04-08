Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D927C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2373B61154
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhDHNex (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhDHNex (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 09:34:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77970C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 06:34:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w18so2503828edc.0
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPNwPC7VKwWUn4CFdTc5xJ/98x/ZiEohUUUdRaIwj+Y=;
        b=Qq4sib+wWmd1NH2/jKcgdn1L8skGx4EIyXaJ7pzs6Y+nGmv3CKe8WC/0S123djo9n2
         Nik379Fk7c2xMTLL/yDcZRe/OUm3ioVutvDWNzHyWcVGU6tr92tdXutOBwu/iNXen5KV
         HVSTaDjt1TnsgJkvrxlT5qHF4ynyXcwfx0RXq9OQIwhnxRZ3V98IpZu9ncrtMcikU79j
         UbVtsflKsCQaVS7YfBmw3Gh26PF4ZMKYKk/t97ytY0j28D0qhuGHDoDDYXVunhIVjuX5
         jfJquDLBiP/FJWx/TqSMmY+HWAGCiuFJQDw7Ej1OeNjPKzFecLScd9aXRBBQwlNWdQli
         BBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPNwPC7VKwWUn4CFdTc5xJ/98x/ZiEohUUUdRaIwj+Y=;
        b=Hi9/fuM5lTvpnEDcrbTDqM169xf0GmeIUIj9+YjWrc0WZ/Jb/uPuhYzN93Xrcq3PzR
         WD9Eqg6YSCHW+mD+HB53ZE+akkpvVsip+Ww9xIe1kl/1QLHM0z5igiRMEWHSRU2o3n6z
         vrbMfXEM8d3WJ7mXSvD5T4AHIS36AzWfwQweHb79K9GMW2tdRFSayB70VSgDsBrciDO8
         /GKY65D7y+XGMLkJORSHEs9r6rhZlVL8pwiKcuqUfzSxM7Dr/KJQfVhe+Tzr9mhcMTnw
         aEsNosTwJ6hU00KsZW3CYbk1CMw3tTwLNqyFTmj7/xIg+HHYv2WqNM9Pss/UhMxvgbm/
         KNHQ==
X-Gm-Message-State: AOAM531xB7deUhIPdI740z1DX4FoyN7hLznAZVaq3UsjLGOutGwRo8z1
        vZdSRrhFjPthx4rELvCTPgWs/bFiaDYjWg==
X-Google-Smtp-Source: ABdhPJyNykm4f/6+67U6cTp8+L1XVLzzx1K9Gp5On32mB4aMButdn8xsvNzyGlbxTRQm6gfUPVCMcg==
X-Received: by 2002:a05:6402:6c1:: with SMTP id n1mr11340250edy.158.1617888878988;
        Thu, 08 Apr 2021 06:34:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x24sm12441621edr.36.2021.04.08.06.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:34:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lin Sun <lin.sun@zoom.us>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] config: support --type=bool-or-auto for "tristate" parsing
Date:   Thu,  8 Apr 2021 15:34:24 +0200
Message-Id: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor some of our internal C code to use a new
git_config_tristate() functino instead of checking for "auto" or
"bool" in several places.

This isn't just Yet Another Ævar Series, I'm using this to re-roll my
outstanding userdiff series, the start of that topic was a partial
refactor of userdiff.c which is better done here.

While writing this I discovered that the recently added --bool-or-type
option added in
https://lore.kernel.org/git/pull.781.v18.git.git.1599895268433.gitgitgadget@gmail.com/
didn't have any tests (and we didn't notice in 18! iterations of it:)

2/5 adds that, 1/5 adds a comment on some bool parsing code that's
puzzled me for the Nth time.

Ævar Arnfjörð Bjarmason (5):
  config.c: add a comment about why value=NULL is true
  config tests: test for --bool-or-str
  git-config: document --bool-or-str and --type=bool-or-str
  config.c: add a "tristate" helper
  config: add --type=bool-or-auto switch

 Documentation/git-config.txt |   7 ++
 builtin/config.c             |  19 ++++++
 builtin/log.c                |  13 ++--
 compat/mingw.c               |   6 +-
 config.c                     |  20 ++++++
 config.h                     |  12 ++++
 http.c                       |   5 +-
 mergetools/meld              |   2 +-
 t/t1300-config.sh            | 121 +++++++++++++++++++++++++++++++++++
 userdiff.c                   |   6 +-
 10 files changed, 195 insertions(+), 16 deletions(-)

-- 
2.31.1.527.g9b8f7de2547

