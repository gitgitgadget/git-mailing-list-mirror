Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69B9C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 05:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJMF5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 01:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJMF5N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 01:57:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F331F129753
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 22:57:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 204so1019946pfx.10
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 22:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai1gdqRHlDcMmz1xEAYUTy8mwPRaCo/XNBIWBIcvb24=;
        b=O9bytvVA3NuoRiOfbvT8rSQ2xtkAaH5gssu3cTgSaBigGAU7hAfXX8LTv/N8lREWlW
         DGygEX8qWgECTg9Dq6uLtZ2itLnybU18pKPCEIWEaLQIIH3RPIeMS4a/9BcDx/bRwDtl
         g4zRg4xsiAkFjlcTxwT3/FAFyDu1f3zk5XA+VR5shUfu+eSs7/w6YjCI6i2hiQYPihVz
         l1Gh7hMTDPXpsW1O2dfUTSx9UB50Fz4bjeLjMHIGqaru7GWjgVkipGHWb1+o5yMe3sUt
         umq4EAzJQ52HPoIbUInH3PfrCtSGE58n8kCOzqACA0kP/k3jZ9m04/0j1qX3MFMArWBh
         u/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ai1gdqRHlDcMmz1xEAYUTy8mwPRaCo/XNBIWBIcvb24=;
        b=sr54OGYWI+eV6W3/CQko1atxUfTa5iPFVLRJ+ZgoYeQnq97t9KkuuyzX15AgqPqaQX
         TO+8dE3RZTAEVw5kiNwdnhRFLB+hLcwwpKD9RJyl0GgeFNZN+isKm4YtJy+toP0TAiui
         TtmnI/mqQGkSecLG1SvmtlB68Tvvp4v+sVdu7rm7Le6hVtfqVqhQ/FuOGAW1Ou2kko1w
         KnDqlaLvijj7W9a05VIbZJ0F/JMoKotOODLsS5+FBtGz4UD2yDq8JiNKsrQcDcss+kP8
         Y9lx0O8ms4RH32rlGuCUjz13Spc5yjhZsdRdNt7D42vVxDZn+1NxuyxMdFVlTaSSRlds
         UuUQ==
X-Gm-Message-State: ACrzQf0ZDDiET1Ry3cY18rbo4poz+per0eoaAT7T8zpPnv6K2X1tz0C7
        vBNtaaxq6K7K0ste37x4zBGh6ig/W8F/9A==
X-Google-Smtp-Source: AMsMyM7GNAdloQ3T//95PdGZqwQG7i8WAHmOI7T7TpT5K8BS1i8Ojim2WP2xqHcVvJJuKOm9yGN+Sw==
X-Received: by 2002:a63:470b:0:b0:442:24d7:578 with SMTP id u11-20020a63470b000000b0044224d70578mr29191514pga.198.1665640629173;
        Wed, 12 Oct 2022 22:57:09 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.62])
        by smtp.gmail.com with ESMTPSA id l76-20020a633e4f000000b00460a5c6304dsm8008822pga.67.2022.10.12.22.57.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2022 22:57:08 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     --cc=avarab@gmail.com, tenglong.tl@alibaba-inc.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 0/2] notes.c: introduce "--no-blankline" option
Date:   Thu, 13 Oct 2022 13:56:52 +0800
Message-Id: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

This RFC patchset includes two patches.

One aims to introduce a new option "--no-blankline" for "git-notes-append". The
another one tries to fix the inaccurate output when target and append note are
both empty.

Thanks.

Teng Long (2):
  notes.c: introduce "--no-blankline" option
  notes.c: fixed tip when target and append note are both empty

 Documentation/git-notes.txt | 10 ++++++++--
 builtin/notes.c             | 18 +++++++++++++++---
 t/t3301-notes.sh            | 15 ++++++++++++++-
 3 files changed, 37 insertions(+), 6 deletions(-)

-- 
2.38.0.rc2

