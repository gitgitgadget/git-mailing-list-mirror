Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2094CC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 08:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918102076C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 08:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFt2KKJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgJGIHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJGIHj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 04:07:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58C4C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 01:07:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x5so608193plo.6
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 01:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m7OG6hbUIEpUoLzRTRbZMHnv032PTRqRAhouFHOOp5g=;
        b=qFt2KKJaGNKHhQ3hY+ozdmCVXmu8wNWVsnVMsdqQdSstzG/o388b04VfTh1im26eyN
         wQHii+l916vgcdboInqxP6r4wAw1RIhf51fSsLLbjpjOS3Lu1YnWnWdaDlRvsEe8DPxX
         lRflOl7scLixUllpCYt7p/EdNOlNOzrEgY1pIR3n/ILlGZXezbV/IzYLctuuQT7pD6Mt
         TnUf5Hrt5vFJENKdadUiQJVkVFgaQhHx96T/GmE9pkQC4T2xWSh8fVaMJ1whj/6Jt2GM
         sj17q1ZKSrAVsSu1R0pqEKrAt+p4Hxi8NDIg9vEU0EwFmoIFYzAo0RdsF7gOL1snKNGI
         UNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m7OG6hbUIEpUoLzRTRbZMHnv032PTRqRAhouFHOOp5g=;
        b=qvop/j8rwaBU3mMaHMGN6KweTtQlvWkLD6FQZhSNZ50EptF6hOyGwdP6tX9w/SPio0
         yu38pyAyu7n121un8NgFyMQH0m6Z4lJLKKf4bFmNi46+4REXoW+mmpAsREJnMrbclJzj
         Pv1clVbppBPxwHS2OTS7e9f8axayx8+BT5sQzKzC2vL+9ty0iYV1kgnThx3tAtb9nhBi
         /3M9o705GVUrzchG3lZCuOhs2suXYoHcBKvsKKmR/JcN0tgaEdN7Dz7IjsCe4tIQQCvp
         ZicJYyp2wf7/2WoCqyBRiVW189PvyMKZCeVcXD9fM1haCmOEjm3RVT1mmyeBWlgiARik
         2mNg==
X-Gm-Message-State: AOAM5319GUsEpR1r6fbh1iaN7j4S1B/pH96wvSPe24uhMsc2o6SdEtqQ
        adcvOulcad9Kugbfv8z8WSU=
X-Google-Smtp-Source: ABdhPJyz7Y1kwE9zGq9P41SD9HB+M3cWCZBTx/xa4CQbn7JG0iujWj/ifMre1kf5tlWlvirzVfuqMA==
X-Received: by 2002:a17:90b:4a8b:: with SMTP id lp11mr1857614pjb.53.1602058058436;
        Wed, 07 Oct 2020 01:07:38 -0700 (PDT)
Received: from generichostname (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id z5sm1820395pfn.20.2020.10.07.01.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 01:07:37 -0700 (PDT)
Date:   Wed, 7 Oct 2020 01:07:35 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2020, #01; Mon, 5)
Message-ID: <20201007080735.GA2463829@generichostname>
References: <xmqq8scj5d3n.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8scj5d3n.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Oct 06, 2020 at 01:11:24PM -0700, Junio C Hamano wrote:
> * dl/diff-merge-base (2020-09-21) 10 commits
>  - contrib/completion: complete `git diff --merge-base`
>  - builtin/diff-tree: learn --merge-base
>  - builtin/diff-index: learn --merge-base
>  - t4068: add --merge-base tests
>  - diff-lib: define diff_get_merge_base()
>  - diff-lib: accept option flags in run_diff_index()
>  - contrib/completion: extract common diff/difftool options
>  - git-diff.txt: backtick quote command text
>  - git-diff-index.txt: make --cached description a proper sentence
>  - t4068: remove unnecessary >tmp
> 
>  "git diff A...B" learned "git diff --merge-base A B", which is a
>  longer short-hand to say the same thing.
> 
>  Expecting a reroll.
>  cf. <xmqqblhyepup.fsf@gitster.c.googlers.com>

I'd prefer to not reroll this and leave it over-restrictive than
under-restrictive if possible[0].

Looking back, I don't think I've explained this clearly enough. I
believe that you are looking at this from the perspective of a Git
developer where you know that diff is just a frontend for diff-index and
diff-tree. However, I believe the perspective of a user who doesn't
know/care about the implementation details, all they know about is the
documentation.

In the documentation for diff, the `git diff <A> <B>` and the `git diff
<A>..<B>` forms are documented in separate sections. Looking at it from
that perspective, it would make sense that `--merge-base` only applies
to the endpoint form and I don't think that users would detect any
inconsistencies there.

Thanks,
Denton

[0]: https://lore.kernel.org/git/20200926015256.GA136085@generichostname/
