Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6184AC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 11:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiCXLpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbiCXLpk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 07:45:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96D6E352
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:44:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so4873019pjf.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFPCrG8lChR/Fg/e3hSIBsJuKNi/z/cOM9QV+hntCA0=;
        b=fm3fh7r2JOVC0fTANMaoLbBvvV308zfFt93c7uTEmIYEfTZESlmUnlg+heVz4x9ALb
         DnPdF/3nBltPLXuu9VlOnYp9/IMtVADjXu3tzMd486OdhLdYpnlJ1YG1G//tl2t49GoJ
         LW82mAbqJeC8BGpMGOHejhlHucQPIpa4HHoXHeh4Z5S5vBtqz2Nn8g6XRk+BUz6AcGDZ
         3K6o1+0pN/6aoxp30xRhlvLojDvI113ArHlKTgSAGW9/fVw9LzJoAE+6Fy+GoQPbwNAY
         CQyDyd423LEpqKAp91GIFOkdDBr3teSX1+QGN9tDqONY9+uA6LD/SsAzQngLIG16TSbS
         /6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFPCrG8lChR/Fg/e3hSIBsJuKNi/z/cOM9QV+hntCA0=;
        b=FEzoFYv0nTQbFb/JxszVcXRNGyqet4v23ubpf2Zi6fd31QLtJnJYHp8gzdjPCUhSLH
         5rkOvKwF+LN3utukrZZ9Elx8ZNA450Q2BJjXi3yEWFc2OZi0opDI7j1GkU0uE6x5xTAi
         AbWyUx3ypl7J/lreqmnH90GO7B7G3wNNz6pW93GnMFWNq7KWZC0EBgPzhRwDag5ntBZb
         hZRx/depU5DpsG3+1BbwbpaDPHsVSGTnXvUOj8VFF88HzUAJwk61AKc4NSAg9J/2zvaV
         diZt1D8wihnw3uC2oTKMK6Lo9N70bTGIfUC5esfix/WugoZsZKRgftLjcIvffoRsFRUD
         vMOg==
X-Gm-Message-State: AOAM533g6zho1f7/26omlkZ5TesPN0KWhel09WXSLbdsu44VC1lkok1+
        FRUnZ+ognGM0upfDwqofiIWhGStmFYjuX/Wt
X-Google-Smtp-Source: ABdhPJyd5qjX+BojxAJCPkHfFBiVLCkqvwFT2SbTFBscagzDBp18QS4/Id1omJo0c4PdXJEEds093A==
X-Received: by 2002:a17:90a:ce8b:b0:1c7:7567:9f7e with SMTP id g11-20020a17090ace8b00b001c775679f7emr13513818pju.10.1648122247571;
        Thu, 24 Mar 2022 04:44:07 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.36])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm9717498pjb.16.2022.03.24.04.44.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:44:06 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, me@ttaylorr.com, derrickstolee@github.com,
        tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v1 0/3] trace2 output for bitmap decision path
Date:   Thu, 24 Mar 2022 19:43:58 +0800
Message-Id: <cover.1648119652.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.579.g70500b6343.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Git repo can be chosen to use the normal bitmap (before MIDX) and MIDX bitmap.

I recently tried to understand this part of the MIDX implementation because I found
a bug which has been discovered and repaired in community [1].

I am grateful to Taylor Blau for his help and for introducing me to the testing
method according to the `git rev-list --test-bitmap <rev>`.

In the process of understanding and troubleshooting by using this command, I found
when the execution is failed it will output a single line of
"fatal: failed to load bitmap indexes", sometimes will be more informations like
if the bitmap file is broken, the outputs maybe contain
"error: Corrupted bitmap index file (wrong header)".), but most of time are single
line output I mentioned above. So, this brings a little obstacle for debugging and
troubleshooting I think, because "failed to load bitmap indexes" can represent
to much informations (many causes like: midx config turn off, bitmap inexistence, etc.)

Therefore, as a git repo can be chosen to use the normal bitmap (before MIDX) or
MIDX bitmap, or they can both exist and let git make the decision. I think why not add
some extra informations based on TRACE2 to help for showing the bitmap decision path
clearer and more plentiful, so when the failure occurs the user can use it to debug
around bitmap in a quicker way.

Thanks.

Links:
	1. https://public-inbox.org/git/cover.1638991570.git.me@ttaylorr.com/)

Teng Long (3):
  pack-bitmap.c: use "ret" in "open_midx_bitmap()"
  pack-bitmap.c: add "break" statement in "open_pack_bitmap()"
  bitmap: add trace outputs during open "bitmap" file

 midx.c        |  2 ++
 pack-bitmap.c | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

Range-diff against v0:
-:  ---------- > 1:  3048b4dd29 pack-bitmap.c: use "ret" in "open_midx_bitmap()"
-:  ---------- > 2:  70500b6343 pack-bitmap.c: add "break" statement in "open_pack_bitmap()"
-:  ---------- > 3:  9912450fc1 bitmap: add trace outputs during open "bitmap" file
-- 
2.35.1.579.g70500b6343.dirty

