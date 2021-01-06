Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3B0C43381
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A782310B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbhAFKCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbhAFKCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 05:02:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E268C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 02:01:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q75so2113594wme.2
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 02:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjZWHDkDMDpau58DDtgnqwPfc5PR9zrIMKigyv+4LlY=;
        b=kc6jTsHHDoqligy9Qhx0ylm/NI+8EdFqvHcIcoe8frmEFDn5kDykHAoUrZYcjncNOR
         RYRgpzpj42WPvCKNnT/BC4z33F2BC9NGZDlYQlHV5kM/+4GVDTc5o6kckdd310KQUXrc
         /M1dzSSJFt3ZhdcSwLmwtAGsp4Xzi8s/rEod112DVU5xeW/6Hyw9bcdCrlPIF049ESxE
         abezUCRUv7RxevRTKOrVAC9kUZZtNmn/9S5UCduBbOrgmJGSiZ+/zKE1JSVqIno4y310
         GrtZsxKqHk5b2iYA+NAOrQ2/jNTBd4QwFK2/HbDOsWhoBjtxbzQS/znQ7yS7v3aEfj0+
         x/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjZWHDkDMDpau58DDtgnqwPfc5PR9zrIMKigyv+4LlY=;
        b=W+Fil1r99zXolyt4huHWR8Y1uGRMYuCXxLlh5OSC2pwiJIebJCFzNY98y1mbBEscv3
         fJEmeOhc7jpvtQ4DSsLaJUzkJpCr5syuSXkF70Zh3ASMHn0tfrOUfA6t3nYPfPL9ZD69
         e5zdvQPK2RPGoOhHFImwwcY1FXTbDVjJFgDsbywLIlFD4GJqvQxtsXlogHxZ97Bwh23X
         r5fj15/uVT9xF0g29IWXJ3IzY1R8iBIjzFt/JEOJE7ee5cnkebgpap+4O6l7nDnBytTP
         /Frr+H9/vLMr4nsx9qnCZhkGzqIrhpN9mQyxHIoHW1l3dNK7tNZ+QwYXcZfbRbKiO3ls
         r7nQ==
X-Gm-Message-State: AOAM532rPTnZ2g3U/W1I2mJUgk500YWX3PqTFgfSTdSrnncJnDM41UqC
        aADZin/1S2Sa2iijINr4BcRvVtg/AVFUpw==
X-Google-Smtp-Source: ABdhPJyzo6e0SNxv/J9z3Bl4knV9tULLSnCVK7QK8W0RSBArO9FsLtBCd47/njRU7Sw+X7lM03GtPA==
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr2867651wmj.182.1609927314710;
        Wed, 06 Jan 2021 02:01:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r13sm2538637wrs.6.2021.01.06.02.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:01:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] branch: --sort improvements
Date:   Wed,  6 Jan 2021 11:01:34 +0100
Message-Id: <20210106100139.14651-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
References: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started out as a reading of ref-filter.c where I wondered why we
needed this i18n lego. I'm not sure whether in Chinese what Matthew
DeVore said in [1] is true, but in any case it seems better to leave
that to the translators, re-using the string is a relatively small
gain.

So I think that change was really just "ASCII sort is easier than
checking a flag in a sort callback", fair enough. But I thought I'd
try to see how hard that patch would be. Turned out it's rather easy &
I think results in better code, 4/5 gets us to that point.

But 5/5 I think makes this more generally interesting. In all locales
(including LC_ALL=C) we list the "HEAD detached" entry last in "git
branch -l" output if you're doing a reverse sort. I don't think this
makes any sense, it's a notice, not a refname to be sorted. Using the
new sorting function for treating detached HEAD specially makes this
trivial to fix.

1. https://lore.kernel.org/git/9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com/

Ævar Arnfjörð Bjarmason (5):
  branch: change "--local" to "--list" in comment
  branch tests: add to --sort tests
  ref-filter: add a "detached_head_first" sorting option
  branch: use the "detached_head_first" sorting option
  branch: show "HEAD detached" first under reverse sort

 builtin/branch.c         |  3 ++-
 ref-filter.c             | 54 +++++++++++++++++++++++++---------------
 ref-filter.h             |  3 +++
 t/t3203-branch-output.sh | 51 ++++++++++++++++++++++++++++++++++++-
 wt-status.c              |  4 +--
 wt-status.h              |  2 --
 6 files changed, 91 insertions(+), 26 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8

