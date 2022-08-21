Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9CBC25B08
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 00:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiHUAjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 20:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiHUAjt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 20:39:49 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95692AE2E
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 17:39:48 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 62so5861145iov.5
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 17:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+zTf0rEs7Tnn0S25pncu9YiN2rQ1d/xdWGV9zRMirPs=;
        b=W1AZPNNzSsj0AfyHwjXrfwlkKg891YVL0y8PC19yR8k+vV99gAirms2dlmoRmQZlLF
         Oi8C08bDZKx8jDHsbZB/3fGFqdctdkKeEqU3YXUdAUZ+4zlI+8LyvEldYkEznpFb40ba
         CcJQES1gCQmF8cRO9s0CblcGe9xvU4NGpdbru34f2DVrSyz2PXXMiT2WawaLqy+phm8u
         0IqI29d2AUTLTCJh4cJ0oX0kDQB8vACeq+H7UH2OeSHfjzLYYXe3N8YrRvbl10oz/5O0
         0h+emasPQPfYWb2GrQMNOCnHrZ0wA0fuza02zK2mtZpz4MxxQcRC1wAFaMYCv0mabKRp
         g+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+zTf0rEs7Tnn0S25pncu9YiN2rQ1d/xdWGV9zRMirPs=;
        b=P9nKDDATrlHfSGEjosyppNxC12hBLFgrqjwvxoQRVixpVfgFAG6KTno5L0+tMfwyvI
         lNhy6uT+A8ymofu88Lie41khNk+UCITnTXAhk6CbviEWs4v+0XSLV/z3vzYnAORST1va
         LdOT3vofJAKYuFBFaYMDKLejUyMFBik9fgvzsXpCN1lAdaLP3R1GfLgWgVOVbGYvLLI3
         tBb3NcqNSlnUoJLugrz0ahweXE6V0qMCQtQqonex5KrPggREZap6oB1BJEbABSaUJUi9
         tTZt1DM1XT39IlKZxlxtaFr1YFKWicIhUGrPi/gwPNp0n4/m4Dff7MoIvV7L7FKhuSh3
         7upw==
X-Gm-Message-State: ACgBeo2H/LAzlJRb8NnKPVmR2KBtlmM6V0tTxCjOsD9NK3DAil9Ltpof
        4990hEhWepPHo5ZBKqggotfDM15Z1zTSRydtL/ZjhoCrIA==
X-Google-Smtp-Source: AA6agR581gR+rl9gzr4RYxR9+o2wKixbJhmWftiV0AJUXEsOti9yWqKalBTHbfqaRIx1QGqH0FQ/2rOND3o0NpwMLwA=
X-Received: by 2002:a05:6602:1593:b0:689:a797:78e5 with SMTP id
 e19-20020a056602159300b00689a79778e5mr1802584iow.28.1661042388016; Sat, 20
 Aug 2022 17:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAO_RewbD+BJd1hPKCmCNM8wYBSUmZ2TuOoy6t1up1CT-rbn4DA@mail.gmail.com>
 <xmqq8rniikrg.fsf@gitster.g> <CAO_RewZPXP1EUP90kU6uEQ3_CqqC7yWedjfNd7RaVASFSfrg0Q@mail.gmail.com>
 <xmqq4jy6igb2.fsf@gitster.g>
In-Reply-To: <xmqq4jy6igb2.fsf@gitster.g>
From:   Tim Hockin <thockin@google.com>
Date:   Sat, 20 Aug 2022 17:39:36 -0700
Message-ID: <CAO_RewaZHL34WBaoXVyXh6ZNVuG+fi5uGUbpRMsc9N=orHzx1Q@mail.gmail.com>
Subject: Re: rev-parse: -- is sometimes a flag and sometimes an arg?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I assumed it was clear, but that was dumb of me.

I have a string - might be a tag name, might be a branch name, might
be a SHA (complete or partial).  I want to resolve that into a
canonical SHA.  My finger-memory is `git rev-parse`, but I can't say
if that's just a bad habit I picked up somewhere...

Tim

On Sat, Aug 20, 2022 at 5:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tim Hockin <thockin@google.com> writes:
>
> > Thanks.  Is there a more friendly way to do what I'm trying to
> > express?  Should I just use `rev-list -n1` instead?
>
> That's hard to answer, as you didn't exactly say what you are trying
> to express.  All you asked was: why is "--" treated as an arg.
