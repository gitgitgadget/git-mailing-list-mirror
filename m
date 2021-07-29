Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B1AC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E7360041
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhG2TF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhG2TF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:05:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F22C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:05:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a26so12864420lfr.11
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8i4cxoxiZuCph/97CWcR7SCb54j4KlbcYD6MolsqFgE=;
        b=fY4tHLWDW1pbmLOY6o3K3XhNi0t5SGaSEjooLaQinGQwrgLPM9Hxb+58iflS2+Rhdw
         uFzI6GPBLWcCtUtMkytlIC3Ed/DBBeAW+SQARIxWkZ5mSuS7oQXqzlmcMbsZyIPTUt22
         g/9Hn756nE9lYoUsOqkR4UiSP70bl4hZ/kLDcyUfjwfrUB3EoHbIpsY701jbGf2BKVr1
         0HNw+B+PsBrKGGk5ozaUy+KVeaLQDw0rnl0m7kajUooA4Hr/sQlJ3+Sgh3luBlqf/l6T
         nfNvrcVkuR7Ml7Ou3X/FGTTL2BJnQ3ZGzYPivnv3vo5s5CsrWGh7Jg7E+1MPhMM3Zbrd
         xBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=8i4cxoxiZuCph/97CWcR7SCb54j4KlbcYD6MolsqFgE=;
        b=MUNlrgfKtUpnJBAmcly/GM5oUFcYPlxYTb7NcXGI11s/ZOj5+/yW2UrbL7nwABhHm3
         gjDFMcp+H3BMUA2afcVu910G5TQwNt6UVMed8eDc4/xMci7IpNPzoksZowBbYyA/i4iT
         AsfpfM7JbjLL5dbBnnBKHJ1Ig/vFtphSH6hwSjrGOi+1OOooNvA+eOqLsRp9jhxOTk83
         md/eibZRSMgfDdZ7CFGc+UofwtK6A+e8QZ1dVS5XEKosfNFfeEk9GIPQ+OIvBJGoKItC
         uuINabE/sYRY2DV6Here7HEzm99UbaAjMLuUWVVETVVI4JplzVCjT03dqUkPQEB4H9My
         JG6Q==
X-Gm-Message-State: AOAM5336x6AKu+KMjcV0P1VhXsQAzRbY0d+rGnhdaY4F6ZbiBY4J4J3Q
        4JTIjI8ZyzOs/tFjLpDRvPPxSB6lMUY=
X-Google-Smtp-Source: ABdhPJwy6okqVPYHQATf8TeBm4UihwaKz7RrG3FpsmS+lcIOft7p28cdGBeu9PNULOk2KfPQPZotzQ==
X-Received: by 2002:ac2:53a6:: with SMTP id j6mr2126244lfh.408.1627585549903;
        Thu, 29 Jul 2021 12:05:49 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z5sm376813lfs.126.2021.07.29.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:05:49 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Daniel Knittl-Frank <knittl89@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Using two-dot range notation in `git rebase`?
References: <b3b5f044-8c76-ec71-45d6-1c7fea93c519@iee.email>
        <CACx-yZ1Je+tnZdJ21gDPeuQa-QTuY2t9mDujNr7wqJWFMwwzxA@mail.gmail.com>
        <dc7668ff-37ad-1d9e-fc92-df432549b4e2@iee.email>
        <YQKBNXsMdroX3DfY@coredump.intra.peff.net>
        <xmqqv94t59oq.fsf@gitster.g>
Date:   Thu, 29 Jul 2021 22:05:47 +0300
In-Reply-To: <xmqqv94t59oq.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        29 Jul 2021 10:09:09 -0700")
Message-ID: <87fsvxx7n8.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I do think "git rebase --onto here old..end" is a sensible thing to ask
>> for. If we were designing it today, I'd probably suggest that rebase
>> take arbitrary revision sets (and either require "--onto", or perhaps as
>> long as there is only one negative tip given, that becomes the "--onto"
>> point).
>
> The unfortunate origin of "rebase" makes this a bit awkward.  If it
> were a tool to cherry-pick multiple commits on top of the current
> commit ("on arbitrary point" is trivially implemented by first
> checking that point out and make it cuttent), the range notation
> would have made a lot more sense, and I think it indeed is what the
> multi-pick kind of "git cherry-pick" today does.
>
> But "rebase" is a tool to "rebase a branch", and it is done by
> replaying the history leading to the tip of a given branch (the one
> that is currently checked out being the default) on top of another
> commit.  So its parameters serve dual purpose---which part of the
> commit DAG to take commits to be replayed from *and* which branch
> will be used to point at the tip of the resulting rewritten history.
>
> If you can forget the latter, then multi-pick cherry-pick is already
> there [*1*].

To me it seems like the long-term way to go is to obsolete cherry-pick
as end-user interface in favor of something like "git rebase --pick", to
stop repeating the same functionality in both "rebase" and
"cherry-pick". Besides, the two-dot notation would fit nicely then.

"Take these commits and put them there" (= current rebase) and "take
those commits and put them here" (= current cherry-pick) are similar
enough to be handled by the same command with the same set of features.

Thanks,
-- 
Sergey Organov
