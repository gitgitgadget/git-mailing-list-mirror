Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA53FEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 21:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjFOVwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFOVwO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 17:52:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3795BDF
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 14:52:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666683eb028so174606b3a.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 14:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686865932; x=1689457932;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZOjPtGvXc4+8TJvIDZ/He0TZuLfMnyoZARpyRnUPUI=;
        b=jGKxmQD/0LKmTfRtP5RTc0BBBmgzhAP1npI3FKedYbeuqpBpgxaoSjr+RzG3ihzoJh
         tCA6YhXj5o46kChZjeR1QruFTfrYM5+t+zFZUjfdS+4tBZdKw04SO2GSbQmkoHiu9lDb
         oKnO2fGjqKBQvAOIqD/P0qAYehz4QcAE6XqXgExXFXwWRr1zMkJ6QfN7Fkkx8PFwx4lk
         rYvIy8LEWC76+LGZO53FRY6u0+4bjpGqE3caafK94haMUvFqnr5p50WtpraTyZZC5xS+
         UkajyoCKA2vmSeldXVRtxYUcM1Do9FN52NvP6Ic86NXo+gF5LfUJCyX899HRQDN3mRUp
         CC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686865932; x=1689457932;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZOjPtGvXc4+8TJvIDZ/He0TZuLfMnyoZARpyRnUPUI=;
        b=YC35LphL9JjfJiUKY7uYjZBs0N75mL4lx2WwD61Lk68LU3JWXoLxKa0o08ezyt82C/
         W+ct/AnWp7b/SjaOUpaUZGrEphoZPoZq9ThMgAMzybMOLfq+FSdnLZMlRqpwk99srx1K
         nmLlyM4i3vGo1nnjpeljDbnl+qA8K2XA6RODx9VAwa2JJ1FhR8RRW3x9/QB/zRtphJdY
         0VOdTDd77cHLrPU60LYKLiT/m2FQjvcQQXlv3vLc8YpZGbQBdjKNsWDzCJ5mRKj8tgnd
         BK5duGEdPj91hPk2hA2QvBl7LFjrLp/Vhk6IsjkPGkYgxDhnugy6gS2fstq8aNlF6XEB
         YP6w==
X-Gm-Message-State: AC+VfDw6R0lRFaspYVZJ+en7D9GDQvdodEObi9u2n34uY1YVISh3j6by
        2vQPcFHs6LiV7zXsV7iPPM0=
X-Google-Smtp-Source: ACHHUZ5aHuNbvVH0GuSEaNacF2gNE9m9ttyL/orte9TXk5meyk2vFJWQFuZorrTDj9qiyaVrTW5DMg==
X-Received: by 2002:a05:6a00:b8f:b0:666:5fc4:36b1 with SMTP id g15-20020a056a000b8f00b006665fc436b1mr302840pfj.26.1686865932544;
        Thu, 15 Jun 2023 14:52:12 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79211000000b00662610cf7a8sm12711248pfo.172.2023.06.15.14.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:52:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v4 0/2] credential: improvements to erase in helpers
References: <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
        <pull.1525.v4.git.git.1686856773.gitgitgadget@gmail.com>
        <xmqqh6r8v3es.fsf@gitster.g>
        <20230615212116.GA39325@coredump.intra.peff.net>
Date:   Thu, 15 Jun 2023 14:52:11 -0700
In-Reply-To: <20230615212116.GA39325@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Jun 2023 17:21:16 -0400")
Message-ID: <xmqqcz1wv1f8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jun 15, 2023 at 02:09:15PM -0700, Junio C Hamano wrote:
>
>> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>> > M Hickford (2):
>> >   credential: avoid erasing distinct password
>> >   credential: erase all matching credentials
>> >
>> >  Documentation/git-credential.txt   |   2 +-
>> >  Documentation/gitcredentials.txt   |   2 +-
>> >  builtin/credential-cache--daemon.c |  17 +++--
>> >  builtin/credential-store.c         |  15 +++--
>> >  credential.c                       |   7 +-
>> >  credential.h                       |   2 +-
>> >  t/lib-credential.sh                | 103 +++++++++++++++++++++++++++++
>> >  7 files changed, 128 insertions(+), 20 deletions(-)
>> 
>> It is helpful to reviewers to describe/summarize, in your own words,
>> what changed since the previous version, in the cover letter.
>> 
>> The range-diff generated for the versions can serve as a good
>> supporting material, and it would help you while writing that
>> summary, but not a substitute for the summary.
>
> Yeah, I agree that would have made reviewing much easier. :)
>
> That said, I just re-reviewed the patches themselves, and everything now
> looks good to me.

I missed that you suggested fixing the indentation breakage
introduced in the previous round, and the part of the range-diff,
which was unexpected to me because I lacked the context, was
distracting enough that I missed other changes X-<.  

But the end result does look good to me, too.

Thanks.
