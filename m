Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50487C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 20:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D2A2613D7
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 20:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFCUZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 16:25:49 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:44881 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFCUZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 16:25:49 -0400
Received: by mail-oo1-f50.google.com with SMTP id o5-20020a4a2c050000b0290245d6c7b555so1696127ooo.11
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=eLTtnEXfJ7sRm3jLmgMCwWU4PcbB9LO1InCgVDGVP2c=;
        b=ef8jfpPQjLw2MDpGlmTIJFWckLbuFHjYgqXSptlqYcgZJ1oDtkDEqeVjVw0Q05QVZB
         Iep8Nd8YOJNpLojVp4FKCwAilx6nIjunNzkDHk5avo8cDhBG4CdWsAOZI0yVkho6TCTD
         /5tIPwvk+j2AzxExWkbj9aWpcrzcabxpnD0/X9pFFWE3f3cstm2oZizKahDmIeocakwv
         z3a2iskp+7VMhEPZE9JB11o3TkFfcoyv7tdhGQ0scIxgnlGQo6y4fFiNhI0JKFxRrRx6
         7F8ydlsTJ6TGRFX5Y8qTABTy9hhLIxYsCncOLRPMYAUjIeh5ar0rTN5bojaYtjw4aRzH
         /pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=eLTtnEXfJ7sRm3jLmgMCwWU4PcbB9LO1InCgVDGVP2c=;
        b=bU2OfSdqf/s0frNKlugfc5f9nzW5c71fW5qwpSJdyND2EHk33vF/GLPBKO4ysQfN6c
         HYoWZmqFOiRy4W+h1IPYuB0PvxRnpb+XAIjf4CkYH2vkolrcD/L905+z7O9aJwKd03jj
         eVlp+3QwEoPKCkmTy8crtDNlxbwEEM91Wx2mgWwXefm68fKanDY0LZ2FuGhseigWv1ZT
         4pZBx3Cy+bHD+K46WeDyRH5dtNddoi8+8l5ZsesG1ROfFvco6buqHCzbYlrlHTow90j/
         Ilt3JkNsajuyGUmJMDLTaHOVSTjohn/Fv9Hboh566whQqhdk/oYuidqqoF2KAbvAsPET
         dkpA==
X-Gm-Message-State: AOAM533wFUU28ELt1xEWuYg2YeY1XhadNxBGOkokXknzkO/dgCBTZHKs
        LJfnxDmDbeupYj54d4meYuI=
X-Google-Smtp-Source: ABdhPJz83Wz+WGAvbixWjONOUALGuo4vBefFJ+Si0T9YGNeS3pWVhAhhKEfpajQuQO8L7XNJHaPc7g==
X-Received: by 2002:a05:6820:386:: with SMTP id r6mr850240ooj.25.1622751783894;
        Thu, 03 Jun 2021 13:23:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id p1sm957572otk.58.2021.06.03.13.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 13:23:03 -0700 (PDT)
Date:   Thu, 03 Jun 2021 15:23:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Message-ID: <60b93a264cb7_39da0420855@natae.notmuch>
In-Reply-To: <YLkwCTcRT/9s8+5R@coredump.intra.peff.net>
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
 <87y2bv0yvl.fsf@evledraar.gmail.com>
 <YLkwCTcRT/9s8+5R@coredump.intra.peff.net>
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a
 symlink
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> Preemptively finding portability problems may save work in the long
> term. And people may even be using Git on AIX and just ignoring test
> failures, or they have GNU coreutils installed anyway, etc. But it would
> also save work if we can ignore platforms that nobody uses.

I agree, but the Git project is overly preoccupied (IMO) with
hypothetical issues some hypothetical users might have in some
hypothetical situations, and that is used as a rationale to block changes
that would improve the experience of the vast majority of users.

This is not a hypothetical issue, and yet you are suggesting to
discount it?

I don't disagree, but this is not consistent.

Either we preoccupy ourselves with obscure issues that will probably not
affect anyone in the real world, or we don't.

In my opinion it's perfectly sensible to let a few potential issues
slide by, and only worry seriously about them when a real user reports a
real problem.

Cheers.

-- 
Felipe Contreras
