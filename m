Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A9C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 04:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjEJE0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 00:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJE0d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 00:26:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5881987
        for <git@vger.kernel.org>; Tue,  9 May 2023 21:26:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51b661097bfso4750539a12.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 21:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683692792; x=1686284792;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z/vkP1owWF50y8HzDbVj/HxorTrcYSdfpZMkQtfcPcw=;
        b=cF5n/2uQAVIbpb9I1Zwys+Ox31vTI/1O75zrQht4TLgqAq3BSH5mDUctYb+s/FpzPG
         TYDslkd1c6knxx6RSyvPz81K8glVcojD4myIEXFssc/2u6JOuahQms6Ny7p7Wsmw8a/q
         hg6Z4ISCAW8RSS8jMrBC813/ZRz3prSJnMarpD6xJc1xo9LobiRnAJyJ1a8VCFDKLZdv
         APSvh30PFeEANcG+jwf0WGWr1MsEvgGm7o3iai1Qh/YgoJZOrRv1DNE3jZZG91W9BC50
         EQkI/f3KNcb1gS91chO4YOX1OlWay3gdLx79WHoHmVOJ8s8t3K6qFES/3rT+NnrrExOG
         KTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683692792; x=1686284792;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/vkP1owWF50y8HzDbVj/HxorTrcYSdfpZMkQtfcPcw=;
        b=SEGAmy8Y57HIGbtotCn46eatqyfPs4p03OxdAFSYbVWd7L6ecAgebwjCeEcrcHekfu
         slNO6LQIXo0FpYr3s8kCp0clEWRNSIa43hMMYw6cdHHeosNAWWzovsDH8JQWL0leTWa2
         1yHDcHcB1gLRUwvYfuQ5ebS58xJd3nWSljrWrVjYzpvwVoe+L8PRMcVIbiWteza4AZzJ
         YmsmMxNDknD90IogJ0H1f1V2Hvb77UNw8AbexOWlol396yRcDgFSLirGugXUNkNmeJKV
         yxGasEh0iRHBGmCS3hAoErsJCCV5TgVGCG0/lJYWA/hixz+FC+PSNUfcid7lNaWNV8vb
         bn7g==
X-Gm-Message-State: AC+VfDyM/7FLJdWvO6JIjRobfGLBo5IkzEylJ4U/2VB28UekMMgt6Dfh
        0qAmT4biyUX5ZJEUCNBDsWK2EvEA2r4=
X-Google-Smtp-Source: ACHHUZ64j2L/qIIvOzCO4m6eHAnX/QukuMSrqW0cYR2uJark+R4N1nidTkXxsvtRG+8u1QX18KeRhw==
X-Received: by 2002:a05:6a20:72a7:b0:ff:d067:34f with SMTP id o39-20020a056a2072a700b000ffd067034fmr15873889pzk.33.1683692792075;
        Tue, 09 May 2023 21:26:32 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j24-20020aa78018000000b0063a1e7d7439sm2604593pfi.69.2023.05.09.21.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:26:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
References: <xmqqfs8bith1.fsf_-_@gitster.g>
        <20230505165952.335256-1-gitster@pobox.com>
        <645995f53dd75_7c6829483@chronos.notmuch> <xmqqsfc62t8y.fsf@gitster.g>
        <6459c31038e81_7c68294ee@chronos.notmuch>
Date:   Tue, 09 May 2023 21:26:31 -0700
Message-ID: <xmqqjzxgzua0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> > Is it though?
>> 
>> Yes.
>> 
>> If the proposed log message says "as intended", the author thinks it
>> is.
>
> The question is not if the author of the patch thinks this is the way
> `-s` is intended to work, the question is if this is the way `-s` is
> intended to work.

The "author" refers to the author of the "proposed log message" of
the patch in question, i.e. me in this case.  The author of the
patch under discussion thinks it is, so asking "Is it?", implying
you do not agree, is nothing but a rhetorical question, and doing
so, without explaining why, wastes time on both sides.

I am not interested in getting involved in unproductive arguments
with you (or with anybody else for that matter).  I've been giving
you benefit of doubt, but I'll go back to refrain from responding to
your message, unless it is a patch that I can say "I agree 100% with
what the proposed log message says and what the patch text does,
looking great, thanks. Will queue." to, which has been my default
stance.

Past experience tells me that to any review other than "100% good",
I would see responses in an unpleasant and hostile manner.  Anything
that asks clarification for something unclear in your patch, or
suggests alternatives or improvements.  And it led to unproductive
and irritating waste of time number of times, and eventually you
were asked to leave the development community for at least a few
times.

