Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A74C07E9A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829A2611CB
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhGLUWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhGLUWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:22:42 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD11C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:19:54 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id n24-20020a4ad4180000b029025bcb88a40eso3816923oos.2
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=htngulWWY0ZU2kEslLpfczsn5JXUbtox4SWb3xljlIQ=;
        b=Mf8V+hFGUCUlwUypk35O2U2yni7rRHtdnvUcxwnpdkrgVnOEcCnudlis7LQfY447/4
         CvxX0IQtDu7Bf0D9pwvaJuI1jufEgWyTcWMlCIunSAy8z4RJ1AqYuvr6Puij0ythmmc+
         R+JaCfbUBx48RdCHxtXx1azlZOF4C/Qwh/5JO0J/yxtxq4iaHW6RCqpW8FbiYuS0barJ
         5hKdcMTwAz8JvnzhBwDGaiYOWdc+z2GJshuBGCyISSrh7DiQ0qEd137ptpelX7hyGzaS
         ExFkHG0cIX3iJfnmTIR2bCwhESUo2JCwWyj6qIGdQRT317K15+uJ0cvXQMpXwZIM3Evn
         0Wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=htngulWWY0ZU2kEslLpfczsn5JXUbtox4SWb3xljlIQ=;
        b=FlgXRg3wBe6Ff9APlAzmHXCnH00NHiqKpQVzzW5dATOuXCwaLW2BlWtdYjKK6H+pnY
         w1bcyfE0BiOMf9+HaN6Xp5HOfS5R2DNRqI0hnA7bkrw+EVZP0DMoLWb7/+wtuR6AyRzF
         6IwZZQFATz5teo4mE+NCRHSyfMZvfmquTcQSyxk18bGIMT1nHEmKzFVudgBmtAnXB+bf
         GOgTm91jN+j7vgqd0bVVfNHuTOlpwdJ8rvdPReP0DUfE7DTN2hnVRBlxkZ5B4w99jTYQ
         219O3X1avs+FnW52N+fGeMdK8e9Slku7D5nqrPH1NLUjMUo35ccgoJfbl/r1avsyiPX2
         /0PQ==
X-Gm-Message-State: AOAM532JIxMY/9hEOQzHpbHXgYryRNy3y6CZDGmJl7sZm6Y0AIzxqXTm
        ks1lTmrdFNdzCSZ1BbZqaBw=
X-Google-Smtp-Source: ABdhPJyPH4sM5DL5Be2p9EXlCJUipFnZyv9phkRmq7SGdajUL/F8K9ZmhrLqRqE50k4/FFTb8ncJJw==
X-Received: by 2002:a4a:8f13:: with SMTP id e19mr718924ool.39.1626121193166;
        Mon, 12 Jul 2021 13:19:53 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id g1sm3353170otq.22.2021.07.12.13.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 13:19:52 -0700 (PDT)
Date:   Mon, 12 Jul 2021 15:19:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60eca3e6a0337_a659b20858@natae.notmuch>
In-Reply-To: <xmqq8s2b489p.fsf@gitster.g>
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
 <xmqqpmvn5ukj.fsf@gitster.g>
 <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com>
 <CAMMLpeRX3iMwT9NJ+ULHgAhS3A=nAybgDYFHomkY3sif-H+F4g@mail.gmail.com>
 <CAMMLpeSBgURtX+MKbABKdmFuuoTA-Dw3h8uONwNeiP5aqcnfpA@mail.gmail.com>
 <xmqq8s2b489p.fsf@gitster.g>
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
> Alex Henrie <alexhenrie24@gmail.com> writes:
> 
> > Sorry, I misspoke. I was thinking of the case where fast-forwarding is
> > impossible.
> 
> When we cannot fast-forward (i.e. we have our own development that
> is not in the tip of their history),
> 
>  --ff-only would cause the operation fail
>  --ff would become no-op (as it merely allows fast-forwarding)
>  --no-ff would become no-op (as it merely forbids fast-forwarding)
> 
> and the latter two case, we'd either merge or rebase (with possibly
> specified mode like --preserve-merges).  I thought the current
> documentation is already fairly clear on this point?

Correct. But the documentation says absolutly nothing about
`--ff-only --rebase`.

> > If fast-forwarding is possible, --ff-only already effectively
> > implies --no-rebase, and we might want to make that explicit in
> > the documentation.
> 
> When we fast-forward (i.e. their history is descendant from ours,
> and the user did not give --no-ff), it does not matter if it is done
> using the merge backend, the rebase backend, or by the "git pull"
> wrapper. The end user does not care.  The end result is that the tip
> of the branch now points at the tip of the history we pulled from
> the other side and that is all what matters.
> 
> So, from that point of view, I do not think we want to say rebase or
> merge or anything else for such a case in the documentation.

Correct again. But currently the only way a fast-forward is possible is
by doing `git merge --ff-only`, which is a merge done in a fast-forward
way.

If we add my proposed `git fast-forward` [1], then the documentation
could be updated to say that --ff-only does a `git fast-forward`, and
thus there's no need for `git merge` (or `git rebase`).

[1] https://lore.kernel.org/git/20210705123209.1808663-4-felipe.contreras@gmail.com/

-- 
Felipe Contreras
