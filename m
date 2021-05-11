Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85233C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6A261585
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhEKVjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKVjn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 17:39:43 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B53C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 14:38:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v5so26977581ljg.12
        for <git@vger.kernel.org>; Tue, 11 May 2021 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vodwrWCCbypo8bVzxI+iZbSId+y8uqoVWy94QaCs8Ek=;
        b=DL5RR7QAT9PEh4gi8pmjOKJvvt7972qdcQMauNIN6/ZGzWp2m85b5x318q7wLptK/N
         TAU1vm+z2dZwgb6PyiaB7JngQmMwAW/WeKkU8dLNrJqoP+4TLHLAGNBKlS8YamSK1Pqc
         C/pXRoJHa2ZMjwgiVDiRv73vflXgaLmSyWgdaEX+yrC2mKETr5HRB+XiCXrperGlSrCJ
         eEZ2HSbtj7Mf5tzNHYAQQ2VfOeGYHO/Mcjf4Kw5vdw5AyC27vlEyG+c5QAPrHOBQYOxV
         Me2Q0o2/nhp7bsm15fVjEd6NbC1ZVImObyX0xEvUdC74Ob7tQHXKwA0Ix0MRyf/Yy68Y
         AfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=vodwrWCCbypo8bVzxI+iZbSId+y8uqoVWy94QaCs8Ek=;
        b=rxJKGLR7CLD3lgSJqHt6+miSYuxzw4SPm0iZjMCJpfwsjYQqOOmLtCEAS3GDLD5f8r
         o+hjbZR3NKDcMmSTm3W64NdwziLMjr28Z2jnwO9CJEBZdjstPo1fHACQfcUZ8kir0BKc
         kEX8fGS6qTfmq1tVVWfb6pzCpdgheJaDPYFGIY9JO69Qmf+h6o+zcXZsO5F+FH1TQMRP
         p/b641462xUaALxtD/t5eGNfWcm6ckMtTtfzd1yeB+rByO1c9oQHLqX1JKLCGbp18KIp
         K2gGmRzfhp6EyiLhst1lBus+wqfV7a8PjgcbcJw1Gkkqz+BrjYMQ5wedLNB3NF3AbTRZ
         YvOw==
X-Gm-Message-State: AOAM5305AkbQeh6aM/nwEYFjpMjS24ex0nwq929YXY6mHF+yeqO9Uuaj
        cz11O2nWbMDtyiSTICJEKfwj7xXGLm4=
X-Google-Smtp-Source: ABdhPJyjMj56nW99EfRlMBdaARqgJYrIK8SMf4iCEiwv/65aFeaweGLetOWj3fU2y/tM/zPw8VQw3Q==
X-Received: by 2002:a2e:9215:: with SMTP id k21mr26407377ljg.224.1620769106023;
        Tue, 11 May 2021 14:38:26 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v8sm3304486ljj.137.2021.05.11.14.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 14:38:25 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g>
        <87v97pv04p.fsf@osv.gnss.ru>
        <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
        <xmqqtun9knmy.fsf@gitster.g>
Date:   Wed, 12 May 2021 00:38:24 +0300
In-Reply-To: <xmqqtun9knmy.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        12 May 2021 05:43:01 +0900")
Message-ID: <87h7j9ne7j.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> On Tue, May 11, 2021 at 7:03 AM Sergey Organov <sorganov@gmail.com> wrote:
>>> ...
>> I think --cc is a lot better than -m for helping you find what users
>> changed when they did the merge, but I agree the format is somewhat
>> difficult for many users to understand.  (--diff-merges=remerge, or
>> --remerge-diff, fixes these problems, IMO.)  I think
>> --diff-merges=first-parent, while fine when explicitly requested on
>> the command line, would be wildly misleading as a default because it
>> would attribute changes to a merge commit that were made elsewhere.
>>
>>> Overall, let's rather make -m give diff to the first parent by default.
>>> Simple. Useful. Not confusing.
>>
>> I think it's confusing.
>
> I do not think it is particularly confusing---after all, it shows
> "here is a comparison between two trees" the users are familiar with
> in a single strand of pearls.

Moreover, it's comparison between two most natural trees, the same trees
as for non-merge commits.

>
> But I do think that it is an utterly misleading option to show
> merges in general.  When "log" is used with the "--first-parent"
> traversal, "compare with the first parent to show everything the
> side branch did" is an acceptable alternative, but even there, it is
> far less suitable than the "remerge" or "cc", I would think, as the
> default format.

What I still fail to see is why somebody wants to mix traversal rules
with representation of merge commits, sorry.

If I want to see merges in --cc, I want them in --cc, no matter which
way I get to particular commit through the DAG. If I want to see them in
--diff-merges=1, I want them this way, no matter how I happened to get
to particular commit.

Is it more likely that I want to see merges in --diff-merges=1 when I
use --first-parent? Yes, of course! That's why --first-parent implies
--diff-merges=1. Vice versa? No, why?

Thanks,

-- Sergey Organov
