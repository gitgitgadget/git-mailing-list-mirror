Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D05C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 18:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292AD61474
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 18:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFYSfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYSfG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 14:35:06 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CE7C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 11:32:45 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so10245781oth.9
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 11:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SebWsXMp0PXt7QL2c+6mjNdvKwzATa7lQkeBehliAdc=;
        b=vKFa33tZFfrL0xMhfqEomq/qQ5+dOF83flKzUKEZ+6nKh5ct6a0bq8t43dRiTemj8x
         O+4vZ/5eia6Jk6q151UOwxVDFpcY87wobwQldPtlL3UNW3cf03gNPSoflligXbXyp8cK
         7RlYjI0u/51qzbZI9LHRRLjTxbxOcTXhvb552R6udnWe1uMidCXuO2hFz1FYG62x8uF4
         kZFoUIg103jxyW1zzPqdycFZ70RlAkxk/IndSnAwnBNHp7sLZNz9nZDL+Jc80uXssLiL
         8IuQkIxr9e/jtx8+jIV+7d8WJbw94lKYIdqKpy4GnQI60F+mJJwrGSGP230yEbmdOTue
         YjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SebWsXMp0PXt7QL2c+6mjNdvKwzATa7lQkeBehliAdc=;
        b=fAiBlcCalrtlVl9XeUvoPiR70e/ui04IElHJZiNZAvh2Hd350HqMUSLqOi3T9wU5Qv
         tgRgXtl1e+fMvwF/3hDwJwRdfFpQanURGNdl5eDAvjRgxyVPc/jbbHiWE+xmcksKl8ex
         yJFS6pF1wOOVhAFd4QbEP2zJXnGQsOQvEtmYgMJwXAJx2qXwhP72EDvZ8Hi+dW7iJPf3
         3WvinDMxseqbczPPj2Z/J4HPNxy+R9awbsDXHy1P9774ifJ/G5qnV7NSJW4Qxa7z/khb
         kN3V7pyakBR3NJHek+oMhp6sNa95Y+7QPCFLERFwmJCOSx4yvcQztYbYBza1MMoXFy5n
         /RHw==
X-Gm-Message-State: AOAM532AWrG4KyGWWtJxCVU/vQbgoD8bb4fylPfDDBVKY5FUwMBM4c3V
        T6v5pdu4hm4tW1mbEMNILUg=
X-Google-Smtp-Source: ABdhPJwQ72G898joPdzg4swBZTyifanIqYNtmPlKUwJGddd2awGxv3z/Y8j+kY+uTfuijfADx0fKVg==
X-Received: by 2002:a9d:145:: with SMTP id 63mr2525907otu.349.1624645964427;
        Fri, 25 Jun 2021 11:32:44 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id d3sm327802otf.61.2021.06.25.11.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 11:32:43 -0700 (PDT)
Date:   Fri, 25 Jun 2021 13:32:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60d62147d2661_cc8d2089d@natae.notmuch>
In-Reply-To: <patch-13.30-0300607a9b4-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <patch-13.30-0300607a9b4-20210614T101920Z-avarab@gmail.com>
Subject: RE: [PATCH v2 13/30] read-cache: convert post-index-change hook to
 use config
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
> =

> By using hook.h instead of run-command.h to run, post-index-change hook=
s
> can now be specified in the config in addition to the hookdir.
> post-index-change is not run anywhere besides in read-cache.c.
> =

> This removes the last direct user of run_hook_ve(), so we can make the
> function static now. It'll be removed entirely soon.

This is mixing two logically independent changes. For the same reason I
suggested to split the run_hook_le() removal I think this should be
split too.

Not a big deal though, especially since the splitted patch would be very
small.

-- =

Felipe Contreras=
