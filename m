Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AB2C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357162AbhLFQ3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352992AbhLFQ3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:29:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445DFC061354
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:26:10 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 133so8663022wme.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPfIek90TfVSRbr+iLkt9sJcCzUkgKILx7faOC4bAS4=;
        b=ZrmTMgPbKYXW43fpE3D/qMZ/azVFo5c6oRn8dPNUVhYSmfmvTkyY1kUL/d8+O7xyxD
         NQ+RMRg4hbI7z7UCy7PxfYdOG1UNZbu2zK0DMlNaFKZ/SeTAV+vfdE/Voe6EsfGiDfX5
         ZePI5vzicbIWV3o0NhVNG/4Kd9ITF7TdeZ443sSsMUS22Nz99NRyD7wjy+LuhrpDR88y
         DOiYtGl2W9mNDqh4a0KeGsf89rmA2xKmsFUiAPleuE2IT3Pzt3p2JqZMG0/JY3F1b+tU
         GtDaxiotzeFRCeetT0CObwWiVlJzw/cqPj/sfi43O8QZ1G/Kj9IWQ+VGacYP/m0qCIlv
         Q5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPfIek90TfVSRbr+iLkt9sJcCzUkgKILx7faOC4bAS4=;
        b=ZCR1fKP86rvVmQPTJloTKLR07rJ0MhM1+hLUXq644FSfzEEP5mCc0vMFG55SNjTslm
         +pEY97lg9m9B9c+cfWOM+U1M/sUi746R72SGgpbOjB6smmqDuOSd8yPDlBZnw/h6wXGP
         3BeG3mGh86RrzmJ2pNNRbdIXdck9MeDyJFpjFzJXxj+gm+Pb9k9bNZ2PKR66QiIe15RK
         F8pKX14rX8jScXU2JRhXTlaerG37vmU1SGu6KhsvCmXwowBXn8zZ6VplaP/PvR57M2em
         wMZBZv6cwd0ClTlwZ5KB7mLkgm0geLWcLdWMYwbj0t57CjC8EdWex0kv6gXB6zOR+DoO
         WekQ==
X-Gm-Message-State: AOAM530DbS9w+JSVHSvHuTXuIoUxom9sliFG1X6T2QH+k6l+/kwOGkQi
        pKPKPLrvzzgVkEm8VcwgI8rARI7gLUrvxg==
X-Google-Smtp-Source: ABdhPJzvb9xcBXSxh3ZZsE81CdvXa2x/Gmo4Zw8yeUSO17nXceXv8dZ0RK9cLjr3lIseni2fEDW1dg==
X-Received: by 2002:a1c:9d48:: with SMTP id g69mr41262638wme.188.1638807967491;
        Mon, 06 Dec 2021 08:26:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q26sm11740173wrc.39.2021.12.06.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:26:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] replace die("BUG: ...") with BUG("...")
Date:   Mon,  6 Dec 2021 17:25:19 +0100
Message-Id: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial clean-up to change a couple of die() uses to BUG() where
appropriate. This is split off from an earlier RFC series I sent
in[1], as the range-diff to the relevant patches there shown there are
no changes since then.

1. https://lore.kernel.org/git/RFC-patch-07.21-3f897bf6b0e-20211115T220831Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  pack-objects: use BUG(...) not die("BUG: ...")
  strbuf.h: use BUG(...) not die("BUG: ...")

 builtin/pack-objects.c | 2 +-
 strbuf.h               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Range-diff:
1:  2507ea71700 = 1:  2a17ed9f135 pack-objects: use BUG(...) not die("BUG: ...")
2:  5dedcee3fb0 = 2:  ab89fec50c3 strbuf.h: use BUG(...) not die("BUG: ...")
-- 
2.34.1.898.g5a552c2e5f0

