Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F97C64EC7
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 16:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBNQcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 11:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjBNQcL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 11:32:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443702B0B1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 08:32:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id mg23so9062293pjb.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpyakATXux4AQwZEG+rEm6lLc9svqbuEf2KSyb4QTt8=;
        b=RzJE4yeTkG6Moc1uqVzl+gAvjtDEn4oWKtVvQLVgp5SzhU+irU+Os/qFmvqmlXmsHM
         tcRblGXn6EBDedoybXxOSybxL1jpp1mUahpPquLejr7GRQMRkq8Ks+Y2ssgTV2zyJHKL
         0dwqzU4R1sleyTs+QrUZywvR2aPnX4bxgjRX0jpr4OecvFsmc4zYo0hx2tU7u6UW6l3D
         /L21DlWwB4ffQNEQaQmsdUIKuUbF7pcQaQlTWs6ZM0oaAJwVLIGn7oGmSO/5knGkjfy8
         6bVdxE54huJz6qg3l3/4nZAeiN+H27I3F5+t5C+4slDIWjyvyv/32IYmh/I3bfSEVDMH
         JViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UpyakATXux4AQwZEG+rEm6lLc9svqbuEf2KSyb4QTt8=;
        b=2e3j+d1RBvxq4zdDJys+rwHXdohHIcUAgT5+QHO+If1sFIUyUxYtJptX9QdqhKE4pL
         qWZHErrZd0eNYpNXZRj2lXd2wQM5RmCpst8dUhELKJtMYrtdXoSAlbgncuo1onMVm0nr
         GzTO2gh8fISKbudtpV73AKYeBycO6rTkavfpfABcDIPvM6Z7hvy/AeYUbyzuCgLt2tVa
         FrptAuVx71oMympQ2j/3r5gHf+vKq6qX06fCp+qqtPujvXDD6p4VpCmDNK0nFhOQVlDC
         lCd0yGxX7A0fIymafmFfe/X2jDihAa2sKwEA2mUWHWbfq6P4MAn/giZPJuN6fqL1x785
         PEKA==
X-Gm-Message-State: AO0yUKXwjpST2M+DkgRAd7FlOQrp6WNhywPIXtjres4Cqyqbw3IPqDbm
        jfIz3SBwgk6gycCQyJ/w24A=
X-Google-Smtp-Source: AK7set/Hdzk7/69fUrUHycdbKVKYLogxRWtXJ40sSUrS7veLciZSSox9zczzbbnqY6RJYtEiYqVgkw==
X-Received: by 2002:a17:902:f950:b0:19a:98c9:8cea with SMTP id kx16-20020a170902f95000b0019a98c98ceamr2965183plb.39.1676392327564;
        Tue, 14 Feb 2023 08:32:07 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id r3-20020a170902be0300b001962858f990sm10415358pls.164.2023.02.14.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:32:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 6/6] add: reject nested repositories
References: <20230213182134.2173280-1-calvinwan@google.com>
        <20230213182134.2173280-7-calvinwan@google.com>
        <Y+qgwHx52DSAfsEb@coredump.intra.peff.net>
        <xmqqilg57zxq.fsf@gitster.g>
        <Y+ux3DEd/p5emFWs@coredump.intra.peff.net>
Date:   Tue, 14 Feb 2023 08:32:06 -0800
In-Reply-To: <Y+ux3DEd/p5emFWs@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Feb 2023 11:07:56 -0500")
Message-ID: <xmqqr0us6we1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> If we are keeping the escape hatch, it would make sense to actually
>> use that escape hatch to protect existing "git add" with that,
>> instead of turning them into "git submodule add" and then adjust the
>> tests for the consequences (i.e. "submodule add" does more than what
>> "git add [--no-warn-embedded-repo]" would), at least for these tests
>> in [3,4,5/6].
>
> Good point. I did not really look at the test modifications, but
> anywhere that is triggering the current warning is arguably a good spot
> to be using --no-warn-embedded-repo already. It is simply that the test
> did not bother to look at their noisy stderr. And such a modification is
> obviously correct, as there are no further implications for the test.

I did not mean that no "git add" that create a gitlink in existing
tests should be made into "git submodule add".  The ones that
clearly wanted to set up tests to see what happens in a top-level
with a subproject may become more realistic tests by switching to
"git submodule add" and updating the expected "git diff HEAD" output
to include a newly created .gitmodules file.  But some of the tests
are merely to see what happens with an index with a gitlink in it,
and "add --no-warn" would be more appropriate for them.

>> Also I do not think it is too late for a more natural UI, e.g.
>> "--allow-embedded-repo=[yes/no/warn]", to deprecate the
>> "--[no-]warn-*" option.
>
> True. We have to keep the existing form for backwards compatibility, but
> we can certainly add a new one.
>
> I kind of doubt that --allow-embedded-repo=warn is useful, though. If a
> caller knows what it is doing is OK, then it would say "yes". And
> otherwise, you'd want "no". There is no situation where a caller is
> unsure.

Yeah, if the default becomes "no", then there isn't much point,
other than just for completeness, to have "warn" as a choice.

Thanks.
