Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED2C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 23:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2AD60D07
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 23:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhGLXIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 19:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLXIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 19:08:09 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CDDC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 16:05:20 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so20587645oti.2
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ohjkVx7Inf7m4Os0ssrru91Ipg+GvgZDJz7mMVmJ/lc=;
        b=LThtOjYX7wqoLaPVZNHWjFPfn02OKhBg1bQVil7CQtMe3GcJAee1FGTf+6wHa2KKGq
         cPC3jHXSQRoD2+mJ1rRJGRgTq3wMNeMX9d2q1GHCFAYX4dYEsrLoe/Z72NcsWO4Np/4M
         5RzztEUuY5TXpZRKa5lQm5auOaEyTg4RuynJObFeigqY2RPqmjD6WMzgLAixrZ/+5uq5
         zUFJmutuWoiLqclx8qdx2kIr+s7XYjemiza19bbDgkDC7Fy9X2ARHxG2yyvtV1plfisJ
         SQxs/6oHfs45E5I0+5w3RBixm0uRSfyvWsU9gwnUsqr1pLAqOcWKb5xDnXEHX21/TTPp
         kFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ohjkVx7Inf7m4Os0ssrru91Ipg+GvgZDJz7mMVmJ/lc=;
        b=rfNNcZeSQ/tSwrPrrm4PuVa0Njg7Gag1tqDO3G9hqNukRXzYSOSQr+kNj+qiY1HJd9
         u3RwGCZ1DSA3X37f0ibzvkbiZScSRpNReuc9yUAX/3MxffOKWdrKKLsCp2r70GLnWxwB
         XfRvL0It0aunLvxKJFxQO4gYW8f3mrDoLmeL+QNQwZXftWVjtpN0v9aH1xPX2A1cBCdb
         dLQr8Al76nfEd6maDn9m4H7QCFJWOss7gAI80sbLJFI+f0tKF7otJYHTbNO58Yj37ATk
         JxsJVGwU6F6c23+JZ/qKNO5n+tLeNYMjMLHcULju8LMldPJ8E6tKukSsM16gdeeyyIhp
         rF1w==
X-Gm-Message-State: AOAM5337dj3cjT6KxC5bqxyfcetQA5eILQZpC7j4VuouJw5Bh5Qd2cPq
        tUI3y2DA8ovoeF4JehYR8dOiWWOtEx0=
X-Google-Smtp-Source: ABdhPJxCQ3HvgmLLV94POikDVnyeBrg3NUxjtig4jDCn0GEBMNOAQ7BVehD8LBjDEyZ4Zg9M8UWiWg==
X-Received: by 2002:a05:6830:34a2:: with SMTP id c34mr1055901otu.59.1626131119963;
        Mon, 12 Jul 2021 16:05:19 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id u132sm3011043oib.29.2021.07.12.16.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:05:19 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:05:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60eccaa4c70d_a71772087f@natae.notmuch>
In-Reply-To: <xmqqbl772l4m.fsf@gitster.g>
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
 <xmqqpmvn5ukj.fsf@gitster.g>
 <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com>
 <CAMMLpeRX3iMwT9NJ+ULHgAhS3A=nAybgDYFHomkY3sif-H+F4g@mail.gmail.com>
 <CAMMLpeSBgURtX+MKbABKdmFuuoTA-Dw3h8uONwNeiP5aqcnfpA@mail.gmail.com>
 <xmqq8s2b489p.fsf@gitster.g>
 <CABPp-BH+LPbfdgixvSEGpLxwCHHSK99PFmE3q04jPZjLaqr5Xg@mail.gmail.com>
 <xmqqbl772l4m.fsf@gitster.g>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> >> When we cannot fast-forward (i.e. we have our own development that
> >> is not in the tip of their history),
> >>
> >>  --ff-only would cause the operation fail
> >>  --ff would become no-op (as it merely allows fast-forwarding)
> >>  --no-ff would become no-op (as it merely forbids fast-forwarding)
> >>
> >> and the latter two case, we'd either merge or rebase (with possibly
> >> specified mode like --preserve-merges).  I thought the current
> >> documentation is already fairly clear on this point?
> >
> > git pull's --no-ff is documented to "create a merge commit in all
> > cases", and thus as worded, seems incompatible with rebasing to me.
> 
> It smells like a "too literally to be useful" interpretation of a
> pice of documentation that has no relevance to "pull --rebase" to
> me, though.  It comes from merge-options.txt and would not be
> relevant to "git pull --rebase" to begin with.

But Elijah's statement is correct.

`git pull --no-ff --rebase` is undocumented. Period.

-- 
Felipe Contreras
