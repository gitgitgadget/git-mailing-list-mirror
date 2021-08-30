Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2EDC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60053610FA
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 10:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhH3KsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 06:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbhH3KsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 06:48:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C08C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 03:47:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u16so21772827wrn.5
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47CukMty1Cy9ADfZh+CZY0xZNChGTZ6Zzu01M9M2ghw=;
        b=A5H1foqBO+k/x7sUJSUVHUdMquYCEgj/qHI7NQwyT/vOsZgrtkyyiNj+/BuE/HefaW
         3+zcZIix2QbzZJEXAyWxXtc7oIauAj6y1xyFRj4hBcMQF1N+PmumIlKFAQ1M/LmgXOTF
         mdaxFwAvaRYX1aWxXsHVvl9UxRaWIbX9Yd6oVHkIwFYRc++EU8wztkbWCnQlaPUJ/5dl
         FifU5zp3wiZ2DpwSZiAAzIEhcZh8PXh9pHzIIbBqAKm/CkzmEurQJIGAqv22VK/e60IS
         NtGyVCBkf4yDSQz0vXSEt252QkQmjbK7Po1kq3tJk914CyJ4am3Q4+8nJa8E1csZx6pd
         sQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47CukMty1Cy9ADfZh+CZY0xZNChGTZ6Zzu01M9M2ghw=;
        b=HWOBUkq1DGsrxWBtLYSiB4qM3/TCzrfXn4zbx2MsduulhiXVep+slpzPOa0WR8orrk
         Mim6WQjHJszlNfV4Aks5ptA0tRfHSXtNabodouE2theDCPb4fYTQlgRUQeE0+zMQEtLq
         1lPiQTr0d0Rqs7JmKQQsN/EYruadoSF0JpeJvHMcyarF7PR2blblMmnMuoWwM8S2F7it
         jtqoc03hIWhzB/aKUN5bdizJRnGHTIHLjhuxogTz0waM7buQ93cs3/FmuAwSYScJZXry
         CAIgfawFg6FN1zb42HkYRI3piOF9bzJKaiPTCc/AKTR1/lamtvSdrLgP+KjurcohJrSL
         KAcA==
X-Gm-Message-State: AOAM530T6gSXDBO+uf+S7syN9jMNECFLehFEJpibrU9cJ6L2h8rnkQi4
        oUFC1Z0UKRcUa3ZqAVYliDXuzXQLtacO9BUx
X-Google-Smtp-Source: ABdhPJxxFVad8dk7DjOsSC9BPZbD9k77n0bLS8ZGn+su6J5XlniuCdbpSl+p/GGWyl69ycJ21urtiA==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr6901140wre.380.1630320441672;
        Mon, 30 Aug 2021 03:47:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13sm15509057wrf.55.2021.08.30.03.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:47:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 0/2] suppress trailing whitespace on empty "notes" lines
Date:   Mon, 30 Aug 2021 12:47:12 +0200
Message-Id: <RFC-cover-v2-0.2-00000000000-20210830T103913Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.737.g0eefde7d76
In-Reply-To: <20210830072118.91921-1-sunshine@sunshineco.com>
References: <20210830072118.91921-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a review of Eric Sunshin's
<20210830072118.91921-1-sunshine@sunshineco.com> series.

Side note:

    I'm generally trying to see if just sending a "proposed vX" is
    more productive for everyone than patch feedback effectively
    describing it in prose. I don't mean for this thing to be picked
    up as-is by Junio without the consent of the submitter, and don't
    have any desire to "pick up" the series myself.

    My review workflow is just applying the patches locally, fiddling
    with them, so it seems like the most straightforward and helpful
    thing to send the result of that local end-state, rather than
    describing the changes I made in prose, and expect the original
    submitter to reverse engineer that state if they're interested in
    trying it out locally themselves.

I really like the end goal of
<20210830072118.91921-1-sunshine@sunshineco.com> series, but this
seems like a more straightforward way to get to that goal.

I.e. the original 1/3 and 2/3 starts out by making the tests
whitespace-independent. If we just skip that 1/3, and then in 3/3
tweak the relevant failing tests for the code change we won't even
need a new test, all the existing tests previously made
whitespace-independent in 1/3 will assert this new behavior.

Eric Sunshine (2):
  t3303/t9301: make `notes` tests less brittle
  notes: don't indent empty lines

 notes.c                      |  2 +-
 t/t3301-notes.sh             | 28 ++++++++++++++--------------
 t/t3303-notes-subtrees.sh    | 13 ++++++++-----
 t/t9301-fast-import-notes.sh | 36 +++++++++++++++++++-----------------
 4 files changed, 42 insertions(+), 37 deletions(-)

Range-diff against v1:
1:  d2915b20aee < -:  ----------- t3301: tolerate minor notes-related presentation changes
2:  478d8b8d104 ! 1:  5a1ddd30859 t3303/t9301: make `notes` tests less brittle
    @@ Commit message
         desired information in a stable machine-consumable format.
     
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t3303-notes-subtrees.sh ##
     @@ t/t3303-notes-subtrees.sh: INPUT_END
3:  56d05862a67 < -:  ----------- notes: don't indent empty lines
-:  ----------- > 2:  4b546b83fd7 notes: don't indent empty lines
-- 
2.33.0.737.g0eefde7d76

