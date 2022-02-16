Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C96C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 08:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiBPIV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:21:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBPIVY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 03:21:24 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B092722E6
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:21:10 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so3119279wme.3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0CECdebT2Ri2O4hK0Kg7zBLv0DHkmZq5AoprEoEHvk=;
        b=XQ2ADO1VGSyQ1btxvzD92XKyQ+DPdNj8SwD9KoATIdlL5WwlMRPkeS9LfHmeB+zuGY
         4eLN2JyA93ZpBVGERIkS35gC9LywaWNECdf8IG8anZLzRGC64EDuUnCSFuw5n9XJCjHi
         Tyk5Khmpkms/uugh/pO43KDyj714050cu9K5hdBermSaxaUQ5TTMqWetMdu7gmNlpnKa
         2T1xI2qD8JtcaV3Rl/UKxGjCU3sRzo47SysbOizPp0EOQ7Ps+ovs14Ab4OU8zfvmNcb/
         XHhcSY1aPR7RvXoxP3mFT1kFFeuEYdC+aKcY7cV493eTNBTA5UUf5sZQwIIwXyPp7Ha0
         AFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0CECdebT2Ri2O4hK0Kg7zBLv0DHkmZq5AoprEoEHvk=;
        b=yZhkR/nmLxvsHokrc1Cza4Y9/+lDafQxaR/w0C0KD7JEJ/pBWHfxiCHRIZmKSErT3s
         wthRhgQfOQsuCyZycMlqovbOtkWg3d1DwOsiO+G48+D4pORk41TyN8ZQBDNKPzp4ZSxk
         2tpOw4B71NReyz7ciL6PO3JwCDNA2emt3FHbAD3i0CCnk0pttFDujxoipSYePoeAbfaP
         So/sLgfw1jUUxobpkWJcn9wKp7wrUSCxArJ3zJoB5HTYCw2KSeitbqV003bOkEmXJl7k
         uLof6KKPHxdyRxjv+LXOfLGQ6fAW8r2GkO3NqbmVNbvzVF8oM2nNHiH/D1sMCSdwOMY6
         wBUg==
X-Gm-Message-State: AOAM532xAnCpLQK8eUYJGQbqn1GUBQy1dLaQQ1VWel4GoDrS9ItLVhFH
        FJRfIqRi1Ev/7QCghgJ7li6FNcQu94dUuA==
X-Google-Smtp-Source: ABdhPJw3Al/T1GWDBQ+nSIP4qF37DlJCUAlXzlW03YPZvNzl+pIShOZ6iG21eyaWGVrLKYvo6OZglQ==
X-Received: by 2002:a05:600c:3b87:b0:37c:af2b:4f36 with SMTP id n7-20020a05600c3b8700b0037caf2b4f36mr460561wms.132.1644999669205;
        Wed, 16 Feb 2022 00:21:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2sm17460687wmc.33.2022.02.16.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 00:21:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] commit: trivial leak fix, add 2 tests to linux-leaks CI
Date:   Wed, 16 Feb 2022 09:21:04 +0100
Message-Id: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This trivial series fixes a leak in "git commit", removes two UNLEAK()
in favor of simply calling strbuf_release(), and marks two tests that
previously hit that UNLEAK() being run in the linux-leaks CI job.

Ævar Arnfjörð Bjarmason (2):
  commit: fix "author_ident" leak
  commit: use strbuf_release() instead of UNLEAK()

 builtin/commit.c                 | 13 ++++++++-----
 t/t2203-add-intent.sh            |  1 +
 t/t7011-skip-worktree-reading.sh |  1 +
 3 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.35.1.1028.g2d2d4be19de

