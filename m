Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F1DC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 16:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68A1613CD
	for <git@archiver.kernel.org>; Tue, 11 May 2021 16:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhEKQan (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 12:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEKQal (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 12:30:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9D8C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 09:29:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c3so29531508lfs.7
        for <git@vger.kernel.org>; Tue, 11 May 2021 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PazLprK4cgQdJm1Ibuj8/O19znG68xYMZTtthE84ACQ=;
        b=U6tiWLZMM+SdMmiKgY/3BUVUN0wUxxMknwhrs984O6FwbI3JqgEfZIjIO8DvtVqOvv
         utwuz4Odho8a+whhjXvERQj9QybXs1ZfZgj33zZ9AwG98DYPvGZ3Vym3jZhJzexh2b9A
         71zbCkoOnjbOZaG0Ph3jxIc9o9nXZmCp3cGA52QWuaC/Ya0Pqvd0fswu+IyJqKSEKnuw
         F1WPxtPiokOtDN45ZHvr6pZbKem3b5wJu6vbCv2YS0UM+jHWSSfmSQekRz40wMpyM/iY
         QlgcZ6RE2J7pStY+bKSDGFGjdnJiv4dJzjoQYLl05qyxadSR4F2qKInLI+7Hpd6g0/CZ
         t7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=PazLprK4cgQdJm1Ibuj8/O19znG68xYMZTtthE84ACQ=;
        b=polAiieztxwH1FL2N5gh6Rqdmuu4NauArUL3+1MGCwvxEQ5c89YhtR0DcVc2zyDas4
         Pt6wc56uyVj2NsfeIj3wjy0PDkbyvv8llJR8cmqPWHYwuBTxu5PCQjUZ7XOZeEWngavz
         8LGq8CUp60nqReSP8ozGqDyF7egtMLHh0CQ+whtLZlhELvPh3P4/pNJcUe162au2WtLJ
         W/N/+ij9XRS1nm+MM34AcPJhRXOBKjphs4S2JpOT9XYUrLBUNKYoMsxO2xhh3gZjsRzn
         hGDt4VjB9vpCBFwVICDnxydibpqDWF9mexjD1VxYIRCPjVSH3QWp+y3lPRgX9SiB9fVC
         TkCg==
X-Gm-Message-State: AOAM533hqkftH6l7VrPcI76IUMpGNuZ4Dyp1gPIvrZd+s0g80L7WPk46
        X2/T+P45LlmhJkcGAQPVnGbWCG1TL20=
X-Google-Smtp-Source: ABdhPJzVDcu/PRwgCIv3PcmcpHqUXllpgI8AVZu703UJAUFeVOWmQ6Fu9ELtDWJVQjj2NZexUKIDow==
X-Received: by 2002:a05:6512:3591:: with SMTP id m17mr21150356lfr.302.1620750572712;
        Tue, 11 May 2021 09:29:32 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a26sm2660848lfl.127.2021.05.11.09.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 09:29:31 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g>
Date:   Tue, 11 May 2021 19:29:30 +0300
In-Reply-To: <xmqqo8dhool7.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        11 May 2021 13:56:36 +0900")
Message-ID: <87pmxxqln9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Fix long standing inconsistency between -c/--cc that do imply -p, on
>>> one side, and -m that did not imply -p, on the other side.
>>>
>>> After this patch
>>>
>>>   git log -m
>>>
>>> will start to produce diffs without need to provide -p as well, that
>>> improves both consistency and usability. It gets even more useful if
>>> one sets "log.diffMerges" configuration variable to "first-parent" to
>>> force -m produce usual diff with respect to first parent only.
>>
>> Please make sure that you clearly state that you do not blindly
>> force --patch output in the proposed log message.  Explicitly
>> mentioning that "git log --stat -m" would not give a patch but just
>> diffstat would be assuring.
>
> Also, avoid "-p" in the title.  "let -m imply diff generation" might
> be a good compromise.
>
> What --cc/-c implies is to show some kind of diff for merges
> (dense_combined_merges, combine_merges and !ignore_merges are the
> members of the revs field that controls how merge commits) and they
> ask for specific kind of diff is shown.  So "-c/--cc imply -p" is
> quite wrong (you never get straight --patch output for merges when
> you give -c/--cc---you get combined diff).  In a sense, you could
> say -c/--cc implies -m (i.e. do show some kind of diff for merges).
>
> Taken together, perhaps:
>
>     Subject: diff: let -m imply diff generation
>
>     The "-c/--cc" options to "git log" asks for merges to be shown
>     with patch-like output, implicitly enabling the "-m" option
>     (which is used to tell "do not ignore merge commits when showing
>     patches).  However, the opposite is not true; giving "-m" alone
>     does not tell "git log" that the user wants some form of patches.
>     
>     Make "-m" imply "we want some form of diff output", so that "git
>     log -m" would behave identically to "git log -m -p".  When the
>     user explicitly asks for what kind of diff output is desired,
>     e.g. "git log -m --stat", there is no need to imply anything,
>     specifically, do NOT blindly turn on the "-p: option to turn it
>     into "git log -m --stat -p:.
>
> or something like that.


Fine with me, will do, thanks!

-- Sergey Organov
