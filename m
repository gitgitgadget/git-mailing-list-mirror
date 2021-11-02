Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A470C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2308760EB4
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhKBQuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbhKBQut (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 12:50:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD2C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 09:48:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z200so15269577wmc.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JygNbU6ET2WNRg0d7MqONkaOqXuIc3AwxOHRrqrsI4Y=;
        b=kbDA6Bh0exwGnA+so7AAaRkRhbm2XNVWj/iJiWPUGAyzb2aLMr7BJrgg3/9X5teM0J
         j9M5l6YGVJCgNAtvbBYKQo4viGGw88P2LavFvxZ8vtD9C5kRKrNNiIgvivHlwwJJGfYd
         80bbqHzfTlKGpl1Bc4h+CYBOGG2a7zARlGaBEkxoR8R8nj5LQGNCAe6zsNfuOiAueS0V
         Xz/ZiiOtUHTS9xCg4KzqmWw/yOTA9Dwwgo9mFSY9WxKROI9V693RsvcAnnlCOIOqnmEV
         j3uJ6gToHX0TsoIO4xx7LLsYXuZT5puhWhvdjwL8w/2CLek8y1KDlA5NRB+zLdFgYF/b
         gSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JygNbU6ET2WNRg0d7MqONkaOqXuIc3AwxOHRrqrsI4Y=;
        b=p7zwAUTNxsRtD2+F11TEKgSqrubmbHQMpshPPFIJ5oXT0iDlZzlc3oafh14pHxOHkS
         S9oWRysdnPOA0uxIiHz3QqMycsd/hvx3DsWtfRHNzBrITd4JJm+nEceW3N9SYAwl2Nmn
         fvLx17V0J41JHQQ0zNZPFYBmICV82vj2iyLgIlh5FO+oYPawv50otpTmnERDtEScoOt6
         BJX9XS0ckK9VrlGbReV07eXpVU+OERuxhFhbbPTS55giNKfiswWzAvdGifCxkUjWcObp
         g/A26OuBwqati8Yu5ddRqVhEhUWKLJYLuGRYPeEwiBw1pjtgYR8vWVHBk5YH7BYbHAmQ
         /Qrg==
X-Gm-Message-State: AOAM531HTWjkF55DiATYHUaQciIfsqR0WwKDKD69hXHTJ6FrBrW6x1Sy
        IxcsE+PDMSzDkL1r7JuvcteFPYdXNt5FqQ==
X-Google-Smtp-Source: ABdhPJyw99qoz8u+NpPdOIuh/vZ6o7lQF9t9Ch35dCu5LSJYzPQONmqcaAIrBHo2dCOQV3zoQEzmyA==
X-Received: by 2002:a05:600c:4e91:: with SMTP id f17mr1210665wmq.195.1635871692909;
        Tue, 02 Nov 2021 09:48:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17203188wrs.19.2021.11.02.09.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:48:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alejandro Sanchez <asanchez1987@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] prompt.c: split up git_prompt(), read from /dev/tty, not STDIN
Date:   Tue,  2 Nov 2021 17:48:08 +0100
Message-Id: <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <20190524062724.GC25694@sigill.intra.peff.net>
References: <20190524062724.GC25694@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had a stupid bug in another series of mine[1] breaking code around
git_prompt() in bisect--helper.c, and in trying to follow-up to add
testing to that discovered that doing so was rather hard, due to how
git_prompt() behaves.

In another case in 2019 (which is the In-Reply-To here) we added a
seeming for-the-tests workaround for the same issue in "git am
--interacive".

This starts out by splitting the more complex "get a password
interactively" case out of prompt.c into a new prompt-password.c, most
of prompt.c's complexity was to cater to one API user in credential.c.

That being done move these callers to using git_prompt(), and have it
understanda a new GIT_TEST_TERMINAL_PROMPT=true variable so we can
have our cake and it it too in the test suite. If that's set the
prompt function will allow input on stdin.

This then allowed my to add the missing test for "git bisect" for the
code I'd accidentally broken in [1].

As noted in the discussion in 2/2 I'm not 100% sure this is the right
direction in terms of swiching us back to using /dev/tty and not
stdin, but see that commit & commit message for details. In any case,
whatever behavior we go for as far as the UX goes shouldn't be
catering only to the test suite at the cost of trade-offs elsewhere.

1. https://lore.kernel.org/git/cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  prompt.c: split up the password and non-password handling
  prompt.c: add and use a GIT_TEST_TERMINAL_PROMPT=true

 Makefile                    |  1 +
 builtin/am.c                |  8 ++--
 builtin/bisect--helper.c    |  8 +---
 credential.c                | 17 ++++----
 help.c                      |  2 +-
 prompt-password.c           | 63 +++++++++++++++++++++++++++++
 prompt-password.h           |  7 ++++
 prompt.c                    | 79 ++++++++-----------------------------
 prompt.h                    |  7 +---
 t/t6030-bisect-porcelain.sh | 41 +++++++++++++++++++
 t/test-lib.sh               |  4 ++
 11 files changed, 151 insertions(+), 86 deletions(-)
 create mode 100644 prompt-password.c
 create mode 100644 prompt-password.h

-- 
2.33.1.1570.g069344fdd45

