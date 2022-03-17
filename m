Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAEEC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 18:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbiCQSKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiCQSKN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6869A114351
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:08:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p26so2443067wma.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zVCvnvTdYy+/JuEabKx3NzL6RP7Hf2TYyAPmITb5xs=;
        b=F24jtsIktY10drx3M2An9WhGPeVTLSdA5OveB1BhCNy8oB+aF/oeokMK5Whf71JSt0
         Fej5fs8WYv1ImfUDcc7qfpujHqzbhxdUoXDMUPLshOJVfhHWMqkrUVh3uh1B8XWHfknb
         1eG8DE4jassAOOV3pmxlwP92kkR9phA4Hwnq6ZTBnUn4dKK5BTFpm4jDLQ32pgjRJeTK
         Jt2pMSGCjq3hVcjc5YD3IS+VaG7saU7NjZ542SZZNfDL8HFR/HqO5XJG7u7+oytJq9Un
         3S9YsVjbRGaN9/o7YjE7CWwG41AmMCpEaiPEYxy7JUuoIg3bgFBRxKtCn2VKZFxstAM9
         eI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zVCvnvTdYy+/JuEabKx3NzL6RP7Hf2TYyAPmITb5xs=;
        b=MYUi7yCo6HwziABslFD1I/w56uweENFq7GyjfV4eJhVlIMN61VzYZNzgouzjYVlkeP
         ALFmXDhBdoPOcsoB73aq5wcqhvfw8WDQ1x7vZZK1lTRhmCMwDaxQkNa9Y9EMPNa6EBbI
         l2qOnq0eDMD4WA6BRwB3JgdyUWLr6x0Z85f+YF0aE2V4LhDcL84KSuxjs6EGdSjm453N
         PDj2CySpezIZfgr9+7hMKWiCBLlu54fkiWrBLP/BDT/0BkaqS69A5xbeWo94zGudYDf6
         esvyD0wI+2UvkoNs8Jli0vffHHNZ+hUDUmp8Cz07GQodnM4YiyJkTTc/ZyTDHc1OPSVh
         NNiw==
X-Gm-Message-State: AOAM532DwF52xc6AxerAy8PemurooPG9y2JUWQ/bNrLjr3IS6hU1ltE9
        dWhdu+cuu6xFQmE8kzdIJJ7yTmBwF0z/3Q==
X-Google-Smtp-Source: ABdhPJy27nQAWnRC6sZE1ySSJ6eMvCyWuO/F2/0mU1MJdJKHgn8b9TMHn3irXrgF5fCBjO2yUXGysQ==
X-Received: by 2002:a05:600c:2056:b0:389:736a:5631 with SMTP id p22-20020a05600c205600b00389736a5631mr12979059wmg.120.1647540534700;
        Thu, 17 Mar 2022 11:08:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm4756253wri.105.2022.03.17.11.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:08:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] reflog: migrate fully to parse_options()
Date:   Thu, 17 Mar 2022 19:08:32 +0100
Message-Id: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the recently landed 1b4d9b4512e (Merge branch
'jc/reflog-parse-options', 2022-02-05). It converted a couple of
subcommands in builtin/reflog.c to use parse_options(), this converts
the rest.

The 1/8 is a technically unrelated indentation fix for the recently
landed 7d3d226e700 (reflog: libify delete reflog function and helpers,
2022-03-02), but since it's also in the reflog code I figured it was
OK and that it didn't deserve its own topic.

Ævar Arnfjörð Bjarmason (8):
  reflog.c: indent argument lists
  reflog: refactor cmd_reflog() to "if" branches
  reflog tests: add missing "git reflog exists" tests
  reflog: move "usage" variables and use macros
  git reflog [expire|delete]: make -h output consistent with SYNOPSIS
  reflog exists: use parse_options() API
  reflog: convert to parse_options() API
  reflog [show]: display sensible -h output

 builtin/reflog.c         | 146 +++++++++++++++++++++++++--------------
 reflog.c                 |  20 +++---
 t/t1410-reflog.sh        |  22 ++++++
 t/t1411-reflog-show.sh   |   5 --
 t/t1418-reflog-exists.sh |  37 ++++++++++
 t/test-lib-functions.sh  |   2 +-
 6 files changed, 165 insertions(+), 67 deletions(-)
 create mode 100755 t/t1418-reflog-exists.sh

-- 
2.35.1.1384.g7d2906948a1

