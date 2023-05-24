Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE01C7EE23
	for <git@archiver.kernel.org>; Wed, 24 May 2023 00:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjEXAGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 20:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbjEXAGc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 20:06:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83569126
        for <git@vger.kernel.org>; Tue, 23 May 2023 17:06:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25332b3915bso245417a91.2
        for <git@vger.kernel.org>; Tue, 23 May 2023 17:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684886788; x=1687478788;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrQnlwWwXvs8CB+PrzBFj0l+GM8ygQ5Oo0v4jJhe9T4=;
        b=TcnkqwIXYquvXxLl0vjpcqa592XDl0mMK6exJbZzdtPw/cHHZZsCOAxUoF6XwgxplY
         ZCAh/HPI7IhJl0NgFnxtEnM9/1bqeFnevHkRSsgUbTTHf/MlADeKnyEQ3xnYWB8CdLL/
         PJVgGQ0PICxBP0exX+cr+ne2+L1NOVcTEBFB9SI6ZQaDWsNRu3M/cgIHSt/9aFbUuDOb
         lMRobB8Cl7xh1jZHSBigQ/oTEDcw00bim4w9JXuJG7BG+9Dbp65xy4dddSvweikMuxHi
         5u28zZ1mk2MzPJf4f+WzfdWJgKYECMDcgS4o6O9hOpfqgT9yz8nt3hQlBrF4COFokiod
         hepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684886788; x=1687478788;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lrQnlwWwXvs8CB+PrzBFj0l+GM8ygQ5Oo0v4jJhe9T4=;
        b=UtBDWZygImBsnj/Lp5bOkc8J3SlWuUQg2IJg6vPcmjtb17GdbaYE2lwYHTLCIg1R4b
         rLlWujs+3jfhOFvMS/CZboRjq89RM25wKun/i4eohMh1shx9GlOUF7y/af2+G8VJQsP6
         yikn9wDr/0e1m0AJLwKmJ0egT4YUB20d3MM7H4TRtavvMNoQ6q2UFaRjWlZKpMubjEDE
         6tgqrKoC2hvn0Hil5gLDsYmntfnCvaL2Fpx1aXzaOdB8KUP4C2mymFeQlaY5+JudZZ/U
         RfKpKa9uEKI3sEm7IWLLlXlAQv+d8JsJlj6KF1pJ6mAQgVMUqXTWRImQcESaqYcHEkeN
         xtGg==
X-Gm-Message-State: AC+VfDyG3VDKXxmYuBoTkNe44UDj1OBpQ5spycTrUhjEz5rDj+Okon13
        /z5gY5UqXpo8psa3XYEh8xoeST/S7ne9QQ==
X-Google-Smtp-Source: ACHHUZ59W9QvJ5FijQIABd8O6QerthF+9WiMsEosoE52SU51FkxflTzAPUoPvdsRav41XO5KKi7AZA==
X-Received: by 2002:a17:90a:f48d:b0:255:a904:7a7b with SMTP id bx13-20020a17090af48d00b00255a9047a7bmr3780867pjb.26.1684886787888;
        Tue, 23 May 2023 17:06:27 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090ab48500b002537d88e22csm106093pjr.48.2023.05.23.17.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:06:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: refuse cherry-pick sequence if index is dirty
References: <pull.1535.git.1684830767336.gitgitgadget@gmail.com>
        <CAPMMpojV1Ts=OKM0FbBHU6=EB5RKNxHucX-8VQmYoQBNefKpqQ@mail.gmail.com>
Date:   Wed, 24 May 2023 09:06:26 +0900
In-Reply-To: <CAPMMpojV1Ts=OKM0FbBHU6=EB5RKNxHucX-8VQmYoQBNefKpqQ@mail.gmail.com>
        (Tao Klerks's message of "Tue, 23 May 2023 18:01:25 +0200")
Message-ID: <xmqqjzwyh9tp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> The current implementation of this patch is far too restrictive. It
> doesn't break any tests (and maybe I should add one now that I know),
> but it's doing the wrong thing.

I am ambivalent.  What do we want to see in a multi-pick sequence
that is different from rebase?  A single-step cherry-pick can fail
safely before it touches the index or the working tree files, but if
two-step cherry-pick, whose first step succeeds, finds that it
cannot safely carry out its second step without clobbering the local
changes made to the working tree files, what should happen?  Are we
OK if we stopped in the state just after the first step has already
been done?

My (tentative) answer to that question is "yes", but the recovery
options of "cherry-pick" may want to work differently from what we
have seen them traditionally do.  Namely, the user accepts that the
first step is already done, and stopping "cherry-pick", be it called
"--abort" or something else, should just remove the sequencer state
and behave as if the single-pick cherry-pick on the first step only
has just finished and leave such a state in the index and the
working tree.  If that is what we are going to do, then it would
make sense to adopt the same safety semantics we use for "git merge"
and "git checkout" to ensure only that the index is clean, relying
on the unpack-trees machinery that stops before clobbering a locally
modified working tree files.  But if we are to aim for "all-or-none"
semantics people expect from aborting "git rebase", I suspect that
it would be way too complicated to allow random changes in the
working tree files that we may only discover to be problems after
starting the sequence of replaying commits one-by-one, and "too
restrictive" check may be justified.  To put it differently, if it
is too restrictive for multi-pick, then we would want to loosen it
for "git rebase" as well, as the issues are likely to be the same.

Thanks.





