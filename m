Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D2C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 18:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217606140F
	for <git@archiver.kernel.org>; Mon, 24 May 2021 18:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhEXSmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 14:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhEXSmC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 14:42:02 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A0BC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 11:40:34 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so15597155oty.7
        for <git@vger.kernel.org>; Mon, 24 May 2021 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4sDakoQyR0NfKDRWsFZxK+Yxs4BYvZ+qF7x5NBsHi6s=;
        b=dke6hrN2CcOjwiIaf8XwVU8u5MeMf9aXJL1+dMNVTpxDT59SgcBr+Ky5YhnPGMHV6e
         lWStQMdoiTF/TErYxFvsVeuhGoYtsmfYdxB60JnmN+Tkz0xsk4XLjCxcSr91DHjF+KSJ
         qYmrkBJkAVGXXLXE3P6YcxXzxwGsXumo7GfXvVReoZPioq6jdAmnRnTK9ES9I747fTMF
         NDn2g/YwWo4PdDyuwJbpwxwQCJ7datmwBKCmgizfvchLmnyY5Ypyv1Bq/efRmUPP6sH6
         2glBKw1VP7mgMIGH+jgZVWXDOlE4olkanUU+Dg07avCaV7SP8KFyFGiG3rqr1l9Kb9z6
         OGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4sDakoQyR0NfKDRWsFZxK+Yxs4BYvZ+qF7x5NBsHi6s=;
        b=h04TdQIBkjQoxKxLLcUoJELxpbMGxFXgVxHK3OzQDiP0pl1BPRY19ShsKUjgnH4qKB
         ce5vNeGmVS3YTEhL6ya3JjZjy2tJBI8k071maE/ULda2b7R8vbXB6VRTDSSfJgO7xj3t
         MQKRPqTdBFJF3640UaO7/oJOn7eGIYYRf0Pex9BIzod7TmonLA2hY3z3hO60D8X7Etog
         llVtxcbIV3xA6ZtkMX/cO/F1CSQtlJK+5xLkxAULLkF8alfi+edlVMM9pwwpNNLeWDso
         S6BezR9etyJjoKXPG9BqoQmQmMMm/pvYB7Yoz3nqtiX8xGRuIgN9xhZF9nfuViE44RCz
         yJ/w==
X-Gm-Message-State: AOAM533Rb90EQJA9g3kN1x8N5MqWf9Dvq4XTZmTkfVmrpyoTqqdDHe0I
        MB7MV179dwcUtpX4EoXHjygnD0+B/ZBm8g==
X-Google-Smtp-Source: ABdhPJzG5sW6ctxv4mUz2MDjbUHuIyxbY4S2el7GM6UbEim3IKlx2meAZGEF1TJ25LcNYaWtzMbojg==
X-Received: by 2002:a05:6830:1db6:: with SMTP id z22mr20638309oti.312.1621881633989;
        Mon, 24 May 2021 11:40:33 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id h9sm3221340otn.56.2021.05.24.11.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:40:33 -0700 (PDT)
Date:   Mon, 24 May 2021 13:40:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60abf32038579_1b209208d2@natae.notmuch>
In-Reply-To: <xmqqcztgj9za.fsf@gitster.g>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
 <20210521222941.525901-4-felipe.contreras@gmail.com>
 <xmqqcztgj9za.fsf@gitster.g>
Subject: Re: [PATCH v3 3/5] doc: remove unnecessary rm instances
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Commits 50cff52f1a (When generating manpages, delete outdated targets
> > first., 2007-08-02) and f9286765b2 (Documentation/Makefile: remove
> > cmd-list.made before redirecting to it., 2007-08-06) created these rm
> > instances for a very rare corner-case: building as root by mistake.
> >
> > It's odd to have workarounds here, but nowhere else in the Makefile--
> > which already fails in this stuation, starting from
> > Documentation/technical/.
> >
> > We gain nothing but complexity, so let's remove them.
> >
> > Comments-by: Jeff King <peff@peff.net>
> 
> This is curious.  I understand what other kinds of trailers like
> Helped-by and Suggested-by people sometimes use mean, but this one
> does not tell anything other than that this person had some comments
> on an earlier rounds, does not tell us what kind of comments they
> were and if something was done to address those comments or the
> comments were totally ignored or what.

If they were ignored they would not be part of the commit. It is
understood the comments were incorporated.

When you see 'Tested-by' do you wonder what was the result of the test?
I presume most people would understand that the test succeeded, and
that's why the trailer line was added.

I happen to have at hand a script that ranks the most common trailer
lines:

 * acked-by: 25% (1945)

Doesn't apply.

 * reviewed-by: 22% (1729)

This does apply, but I'm not confident Jeff would like me to add that.

 * helped-by: 17% (1336)
 * reported-by: 12% (960)
 * mentored-by: 5% (379)
 * suggested-by: 4% (281)
 * cc: 3% (222)
 * noticed-by: 2% (165)
 * tested-by: 2% (153)
 * improved-by: 1% (88)
 * thanks-to: 1% (65)
 * signed-off-by: 1% (50)
 * based-on-patch-by: 1% (50)
 * contributions-by: 1% (43)
 * co-authored-by: 1% (41)

I don't think any of these apply.

Cheers.

-- 
Felipe Contreras
