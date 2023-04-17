Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E43CC77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 16:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDQQVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjDQQVs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 12:21:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE06A4F
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kx14so6168696pjb.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681748507; x=1684340507;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVoy8j8NyevikFpznNrUpT2G6LOkTy9aRDZ0MdllNSs=;
        b=BYMc3TY1tDRzjcw6onl1ppZR2hsUQ6zbZMw9Oiyk/308BjTVlQAMBTCtKKObZj8o6w
         3+TMPbA6W40tYOtL/OUAr0+O8Tq1WjX8wdze0upp0ep73EciE1FcSP2WEOVzPRiZH+FL
         FygRQZ+Yn6xVk+WDivPJlBtna9mU1g2onQDoDqP2mIudFgLMzmVvVYWOWb6U+SEVE1uX
         AO7M420qsRxxGGjFmTbV1ntqzApYRG+Vo/v1uILVoJ1LFlYwgw7hbRfo4UD3w1A4NLqB
         dtFWj6yuKj7Mtm3K2hx9vHkDAdNVbMFAbqsH9f+9fu4zF4F2ci3rbySIh38so0i8FWun
         ub/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681748507; x=1684340507;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QVoy8j8NyevikFpznNrUpT2G6LOkTy9aRDZ0MdllNSs=;
        b=bITKkacdmvwypeNX2oDlXmcqt4Dzppc+tsUiTuOmtp204vCuiw0Ey37Ci2PqjKANU7
         EDvJE5bGaj6EKY5yBMI0W24780ss9LkB8xGhsaF17l+3UzMo80o8yN8YFmX40/uR1FX6
         tEsmIuSWCgff2BLsZ7HzIUJMHML9Y9ecPHUnwF96l96GGhuJS61cTdqrVL3gQVfVNG6f
         hdsdQ396IMQ6gCzv7KbZcM4kUu0SgTcPynbRrj+A6tTmS6jdveZNBj89hU7uApE+h6BE
         2ND7QE1+hFlbWGsiIcrk/D5Ti+m1lx/wif3z+v7GK3/UdGe7afnFymyMate0RmbjYPx+
         v1LA==
X-Gm-Message-State: AAQBX9eFb1pHS6fotzKDKSQlmvd5PKDeVKDDuKXTKE+Y3uNuvayTVUIv
        bzCMQJNboktNKEUMBl2ZESU=
X-Google-Smtp-Source: AKy350ZVu90usKW5drIGTuXxg0pgU1iqYZr/m340NNggim2QjRU7q1zbxGAInEzLuViEpH9LDC4oEA==
X-Received: by 2002:a05:6a20:2007:b0:d6:7264:f44e with SMTP id w7-20020a056a20200700b000d67264f44emr14294693pzw.3.1681748506834;
        Mon, 17 Apr 2023 09:21:46 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id a22-20020a62bd16000000b0063b59ad4e0dsm6884533pff.118.2023.04.17.09.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:21:46 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 0/2] cocci: codify authoring and reviewing practices
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
        <CABPp-BEWaojwSpMaYT1VqNBYuhETm-QB9UyFsC-ePsu9B_e_aQ@mail.gmail.com>
Date:   Mon, 17 Apr 2023 09:21:46 -0700
In-Reply-To: <CABPp-BEWaojwSpMaYT1VqNBYuhETm-QB9UyFsC-ePsu9B_e_aQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 14 Apr 2023 18:27:09 -0700")
Message-ID: <xmqqilduo4x1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ....  Maybe
> the wording should instead be "It's okay to give a Reviewed-by: on a
> series that also contains cocci changes when you are unfamiliar with
> coccinelle; just state that your Reviewed-by is limited to the other
> bits".  Or maybe the instructions should just be to give an Acked-by.
> You should probably have someone familiar enough with coccinelle that
> they know what is worth worrying about weigh in on that aspect.
>
> But you can have my Acked-by on the other bits.  :-)

The value of Reviewed-by takes two sides to determine.  Even if we
reserve a Reviewed-by to "I have reviewed the entirety of this
patch, and the patch is something I can stand behind" (as opposed to
"my understanding of this patch is iffy in this and that area, but
all the other parts of the patch is something I can stand behind"),
the value of such a Reviewed-by is conditional to "how well does the
reviewer actually know the area?"  A drive-by "Reviewed-by:" thrown
into a review discussion thread by a total stranger would not carry
much weight, until we know how much they are familiar with and how
good a taste they have.

And honest qualifying comments like "my understanding of this and
that area is iffy so I cannot endorse these parts" helps build trust
by others in the reviewer who gives such a partial review and we
should encourage such behaviour.  I agree "Acked-by:" with comments
is a good idea.

Thanks.
