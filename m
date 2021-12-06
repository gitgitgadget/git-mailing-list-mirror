Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27ECC433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbhLFRxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbhLFRxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 12:53:42 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DC4C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 09:50:13 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f125so11262293pgc.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l/6qEl4+u7fQjYQP/k+oPSIgl5d+6mra3aFAG+tH0ck=;
        b=NK/LO2qdLj9WacM8ZGzYuVZ/wnm0L5aHhknNDQyql85czjOrzB1c3yE0eQc4KcjfcI
         I0+geZF4lkH+D15jzlysTfhAFMXaunb96NGTT/ZrgK9B64+sG0R4nXUxMVJXP0rHE/Vu
         qMid4c8CEHLneFmVG8UBnMPYIFC3XOXSbZkyAh1vRrIdRSE/MgmtI/3mBRa5uZ5u/1Si
         9SYblBVCtawrSeMPxQ/h+2v4vfNqvAnWHHRENtGQ71x/7wJ6NJIWUGGbzeBsAgBdmdUU
         Rh7LZAZSXjOsdOfUaR38ZDiE18f954e8YhLKCZmpIJu2MBZkvopgZ7XmSjDpgt0Knp6W
         m9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l/6qEl4+u7fQjYQP/k+oPSIgl5d+6mra3aFAG+tH0ck=;
        b=5cwik9Y1JsGIT/+6HpsCnyzLpdn3cwgGs5jJUZuQlFD5JE7tKZp/G7Xgmz8JM6O9FK
         1b22TuAngFyXzy61y8x4XGYJLvPW/PCrFV5wPhJVGg3tdbFRQqVMdOJ194zzEN9kdNCB
         bNt8A8Hf0PYQ2Ae4Ql6Bmg5e8udjr6QZQLjdGmuIUb4hGfM2Wq9ft+fQPnmghUTnOd58
         Rigun9Qlucn/taurYSPnn23IFKZv2fo6eOXPeqaJ/xY4HpuXPM71hIP4qHDW24bLbX1B
         0gzqngcL2KtpKVyZpko13hNOLPw2GLQTsVwZKzYSnW1xBb1q5cJN0hnF7GWK4Rb8wDuj
         c5Xg==
X-Gm-Message-State: AOAM530NV4vUsdZfyuVOQeQ+r88XbMLVjSNp8HCQssX5LR/0zGBO08Ek
        i6t/9Vo31lE1N2LuSd9sU8o=
X-Google-Smtp-Source: ABdhPJy3ph26B2r7OfdT4IqdBx2hPDt9tvIOvCoFvHAsPsLhbvvu2mhniAg7YKDjYHm4ImRmDueiFg==
X-Received: by 2002:a63:be4f:: with SMTP id g15mr19555020pgo.417.1638813013214;
        Mon, 06 Dec 2021 09:50:13 -0800 (PST)
Received: from localhost ([2620:15c:289:200:9206:9546:da97:4e9c])
        by smtp.gmail.com with ESMTPSA id ml24sm29313pjb.16.2021.12.06.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:50:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>,
        Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
References: <xmqqzgpm2xrd.fsf@gitster.g>
        <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
        <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
        <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
        <211203.861r2tsfej.gmgdl@evledraar.gmail.com>
        <CABPp-BGE5Ff=adH3nREMDm38DGLEmtRTcPwuJowHw-ckwpbmqQ@mail.gmail.com>
        <211203.86wnklqx05.gmgdl@evledraar.gmail.com>
        <30b4169a.18.17d8d589b6d.Coremail.pwxu@coremail.cn>
        <xmqqilw2i6w1.fsf@gitster.g>
        <CABPp-BGk9fYqtuYTACmzdXakpV7TP635eqHtHxkoHRT3aa4qFQ@mail.gmail.com>
Date:   Mon, 06 Dec 2021 09:50:11 -0800
In-Reply-To: <CABPp-BGk9fYqtuYTACmzdXakpV7TP635eqHtHxkoHRT3aa4qFQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 6 Dec 2021 09:37:35 -0800")
Message-ID: <xmqqlf0xhbcc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> When I first read the documentation, it sounded to me like it was
> implying an abort.  I find 'die' very unnatural as a way to explain
> this behavior; it's too strong of a word.

The way we currently document "git am", we have no word "die" used
anywhere in the page.  The existing mention of the behaviour are
found in these places:

    --continue::
    -r::
    --resolved::
            After a patch failure (e.g. attempting to apply
            conflicting patch), the user has applied it by hand and
            the index file stores the result of the application.
            Make a commit using the authorship and commit log
            extracted from the e-mail message and the current index
            file, and continue.

This uses "failure", and "the user has applied" implies that the
user somehow got control back.  We give "error:" messages to state
that the patch does not apply from apply.c::apply_all_patches() and
the caller silently exits, without calling die.

    --show-current-patch[=(diff|raw)]::
            Show the message at which `git am` has stopped due to
            conflicts.  If `raw` is specified, show the raw contents of
            the e-mail message; if `diff`, show the diff portion only.
            Defaults to `raw`.

This uses "has stopped" to describe the same situation.

>> (on the other hand, I find 'ask' highly
>> unnatural since we do not ask anything---we just throw the control
>> back the user).
>
> Okay, but what about my previous suggestions of 'stop' or 'interrupt'?

I agree that "stop" would be a good word that is already used to
describe "the command cannot make further progress without
assistance by the user, so it stops and gives control back".

After that, the user can say "am --skip", "am --abort", or edit plus
"am --continue".

Thanks.
