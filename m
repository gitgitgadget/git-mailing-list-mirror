Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B158C4321A
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6F164EA0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhBOQDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhBOPvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:51:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFC6C061221
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:50:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m1so9761568wml.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cg9FsAloIS69d/rsHLq9MYBD3yHbiTLLdTsp/UyjzbE=;
        b=Hk2Y1p0UrW5Lsb8q2Y5qsZG7NPKhDwuNnGqnpPaeJ/NdabscjWEZI8BZygJ5xG1sSz
         6qoADQpAOgA9YICYyFpwUIGgHqDC1ucQkKG+nlnl+z2XCJOktG+rHUNaRBfvxiILhdmS
         GPCdczE1a5ekhHoog5gVc5Rc2BS3KuP8tBmA3oxsN1sd5CIPw10170Rn5pR5Khu2FvA4
         x5Nieoe8OkKQdkX+oEqRJDR97ayD33EhS7nNbysie3sqa/L4CuAjFJKg7Ly+qekEouvA
         e4URYJUnUY+qFGhEef7W2fMQkjFpmLKNg9oveTZEKl+cZB5RiJWL5qelrwPOt6SoG04P
         HRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cg9FsAloIS69d/rsHLq9MYBD3yHbiTLLdTsp/UyjzbE=;
        b=hZbpkArtYHxapbe33bXdyqNh89yt0IeGTSVb7lUuovwNb9b6BTMdCjpCft0fWP/BBk
         lwrCh82ksaIazeqvQBlTgyK+UJ8UuHcCBfuk/QKJniaR1WhLFh/t7m2WnYbr9cE7azLB
         SFXSAi0fzUmoM3W9ph2L0UVTJjF2XKxR0yrUt61IHajwV2fGXyxpsW1WMs061LJvD1SH
         YgZmoSlxZ4zzmqeOga0xW9jQAjvtBETSK88uwSmK3BWqHbE4EIayQAoQ9fOcRC6Ym4F2
         jsquYdXC/2FzWvLbgsMfvrg4K/wwCTwNIndww+RJeyCwba/6QG1nmgi/4vIAfSvEaUhk
         F2NA==
X-Gm-Message-State: AOAM532DCTBbStNvfTNUs25LmoFcX9QbxgAAu/HACI584v4r/cOWODwB
        snTo71PrgA66aDIgLFk1nGMRP7RCNumshw==
X-Google-Smtp-Source: ABdhPJwSP1RbsIcC0OlgBjH+drgcuD3kDZGNUaKXAMtzUus3VtVNcyGDSnngSiY+E3NXQt5vfF1a9g==
X-Received: by 2002:a1c:3b8a:: with SMTP id i132mr14924386wma.26.1613404234035;
        Mon, 15 Feb 2021 07:50:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 75sm9672617wma.23.2021.02.15.07.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:50:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] diff: do not display hunk context under -W
Date:   Mon, 15 Feb 2021 16:50:18 +0100
Message-Id: <20210215155020.2804-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top of my
https://lore.kernel.org/git/20210215154427.32693-1-avarab@gmail.com/
because it use its newly setup test infrastructure.

Ævar Arnfjörð Bjarmason (2):
  diff: do not display hunk context under -W
  diff: test and document -W interaction with -U<n>

 Documentation/diff-options.txt | 12 ++++++++++++
 t/t4015-diff-whitespace.sh     |  2 +-
 t/t4018-diff-funcname.sh       | 12 ++++++++++++
 xdiff/xemit.c                  |  4 +++-
 4 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7

