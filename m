Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88918C83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjH1WxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjH1Ww5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 18:52:57 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1247799
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:52:55 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5920efd91c7so43284787b3.2
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693263174; x=1693867974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVXM7+o/bzcf7lN5nkl8rF6Ga4lXvRLMjRS9lXclObU=;
        b=TLkiwsGan1tV+2PienSWlNJyAkZ7BbXpbWNZZePWJFf8e6q/+tqdG9cl5QbGbR0Lxg
         Xrp+ovg69p2/m2GeNkCDiwEOV3QCse7uJhLxd/S/fIClGJ1uLeiSNJZMknyK+3xATq5l
         JVUVkuaUr0+jEGyK3fSuULLKDJ6sn3LsknWHPfG3ntiKKxLdgLiq+XxwUbLrLs1EW/ta
         jyu2TJAOV6jtaomlIcRVqnk3cPPTIISNE30CwZiXpmjOimOs0L6D9chiE+kpV1KwQcnt
         ePAOf9oLOQOtSWDXEYW8/+5cpf1B9TDIfcoCBaExbzi46l/FXlxQrApCEDc7tGjfSP/Z
         Z/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263174; x=1693867974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVXM7+o/bzcf7lN5nkl8rF6Ga4lXvRLMjRS9lXclObU=;
        b=JYHAbqUPwrNhmjVNjkI83sN+XbRw9uhucJq2HYJBMSEqd/vWGB5EpUf7xODv+4kiK5
         hpCM17djYBDlhqLWsm8/WC3/DY6vdJNTSM5dZ43yW50iWZS1LBIQ4neiVe+YZ11e/qXh
         ow2uGe/n5vOpLrag8VDN/+06rT4fhyn2RL0RW7bzVIwKiKBFTzPz55G5qGY19+FZ7Gk9
         c41ukr6splcfqkVlQQ22SGU3YVjdWyWDGe6aci3TGdpK3BooUMC1VQtZpcRbvhtsIf+z
         Kbin9bf2KxEfNXC/4sF/vYfkB3PIDLSTVBgi+x7b25rbQpQ/cCh1yqFdm9TcVcHYv7qP
         VRfQ==
X-Gm-Message-State: AOJu0YzNGEUnFM44zjX72XOqcvw6KI27BLIE71Voy2kHGSsbyxIdb9/U
        5m9c2EuODAKdmg/QCwNRbZ1FyCqo4eVzhn15Fsu04Q==
X-Google-Smtp-Source: AGHT+IEn/72LuSQN1V2a25qImPDvvUc/sBFRRO7gtaWuoAOW5McRMvdNI6G/RT6abDHnEtCmBbJCog==
X-Received: by 2002:a0d:cec7:0:b0:573:d3cd:3d2a with SMTP id q190-20020a0dcec7000000b00573d3cd3d2amr28325993ywd.28.1693263174129;
        Mon, 28 Aug 2023 15:52:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id db21-20020a05690c0dd500b005950be5bf24sm1291711ywb.116.2023.08.28.15.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:52:53 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:52:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 0/4] leak tests: mark remaining tests leak-free as such
Message-ID: <cover.1693263171.git.me@ttaylorr.com>
References: <cover.1692902414.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692902414.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of my (I guess now mine and Peff's!) series to update
our test scripts to accurately mark which ones are leak-free.

This is mostly unchanged from the previous round, modulo cleaning up the
first (now second) patch's message, and inserting a new patch from Peff
at the beginning to ignore noisy LSan output.

Thanks in advance for your review!

Jeff King (1):
  test-lib: ignore uninteresting LSan output

Taylor Blau (3):
  leak tests: mark a handful of tests as leak-free
  leak tests: mark t3321-notes-stripspace.sh as leak-free
  leak tests: mark t5583-push-branches.sh as leak-free

 t/t3321-notes-stripspace.sh | 1 +
 t/t5571-pre-push-hook.sh    | 1 +
 t/t5583-push-branches.sh    | 1 +
 t/t7516-commit-races.sh     | 2 ++
 t/test-lib.sh               | 1 +
 5 files changed, 6 insertions(+)

Range-diff against v1:
-:  ---------- > 1:  7dd42212c0 test-lib: ignore uninteresting LSan output
1:  b1711c4c81 ! 2:  164f37cade leak tests: mark a handful of tests as leak-free
    @@ Commit message
         'ab/mark-leak-free-tests', 2021-10-25), a handful of tests in the suite
         were marked as leak-free.
     
    -    As far as I can tell, each patch from that series ran tests from a
    -    handful of subject areas, such as "some ls-files tests", or "all trace2
    -    tests". This left some gaps in which tests had and hadn't been audited
    -    to be leak-free.
    +    Since then, a handful of tests have become leak-free due to changes like
     
    -    This patch closes those gaps by exporting TEST_PASSES_SANITIZE_LEAK=true
    -    before sourcing t/test-lib.sh on most remaining leak-free tests. This
    -    list was compiled by doing:
    +      - 861c56f6f9 (branch: fix a leak in setup_tracking, 2023-06-11), and
    +      - 866b43e644 (do_read_index(): always mark index as initialized unless
    +        erroring out, 2023-06-29)
    +
    +    , but weren't updated at the time to mark themselves as such. This leads
    +    to test "failures" when running:
     
             $ make SANITIZE=leak
    -        $ make \
    +        $ make -C t \
                 GIT_TEST_PASSING_SANITIZE_LEAK=check \
                 GIT_TEST_SANITIZE_LEAK_LOG=true \
                 GIT_TEST_OPTS=-vi test
     
    -    and looking through the list of failing tests in the output.
    +    This patch closes those gaps by exporting TEST_PASSES_SANITIZE_LEAK=true
    +    before sourcing t/test-lib.sh on most remaining leak-free tests.
     
         There are a couple of other tests which are similarly leak-free, but not
         included in the list of tests touched by this patch. The remaining tests
         will be addressed in the subsequent two patches.
     
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## t/t5571-pre-push-hook.sh ##
2:  cfeca88942 = 3:  116555fc02 leak tests: mark t3321-notes-stripspace.sh as leak-free
3:  4011eb6a8b = 4:  a16a0b2cac leak tests: mark t5583-push-branches.sh as leak-free
-- 
2.42.0.49.g03c54e21ee
