Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC45C433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 05:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31A222DCC
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 05:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbhAQFMl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 17 Jan 2021 00:12:41 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:37896 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAQFMe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 00:12:34 -0500
Received: by mail-ej1-f42.google.com with SMTP id 6so19102629ejz.5
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 21:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o83YVAxluvSoi9bsenKHYx5fxOy1pIyAoUhjjG1/ar4=;
        b=Pjy5aH6lQwmXprljrqRjyYuqG5EfUemaQx2AafTn322xG+26Vpq1Tql+dweOTYxFGb
         WzrahINJMmwFN9AMjRXMVCm9p+6Pz5lcnS7aA//lwR+a5viL6uQSzmntmFya998UlBdA
         nhSWD4kQ1u/E8tfa7EYSlgHoNIbxHIvfXtl0U1xaz9Wa1fNW0/1q30Sob+Y6NKs6yhaC
         zcKuN6gPGKmdbaNI7EvDOxd7NMaGGvmzLGRWVK6Bxa0g1LrhMNiQ3OSQl06Z6eAiCieA
         N1yjbVyP+0aBvPhC31xuj450Wf5aR/ziQycK01z+8CYOYsCkMQF9F+WU3o63RQswVY+1
         LPpg==
X-Gm-Message-State: AOAM531ecGUymIAVSVQYKFeeWYrU5gck4Z16Hg5cZsPIv8GTls9b/JgB
        nG1AYCmCTtzZ7sFGor2V0t5MYDB3+ouuX0vuJBM=
X-Google-Smtp-Source: ABdhPJyKAp4OLTJamnVdRygeyNVy62jxeWVwxpADhpuadfDLz46kLxZIF7C2i/RsMw6meTsl6REaUsdmAOKEtN72Tl0=
X-Received: by 2002:a17:906:4348:: with SMTP id z8mr13884224ejm.371.1610860312265;
 Sat, 16 Jan 2021 21:11:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
 <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com> <CAPig+cQBi7jdq64==U630Ht1YDcH+9komLNv-hZMnEhQ1Q-V9A@mail.gmail.com>
 <CAOLTT8QNhz4PrMhAt9y58n+-bEjeOE+xst8rzcg-x045Amw7iw@mail.gmail.com>
In-Reply-To: <CAOLTT8QNhz4PrMhAt9y58n+-bEjeOE+xst8rzcg-x045Amw7iw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 Jan 2021 00:11:41 -0500
Message-ID: <CAPig+cQr2kMNbhZgYn3e1V79Y5QnCbDKYzQnriEdae4FomK8Aw@mail.gmail.com>
Subject: Re: [PATCH v3] ls-files.c: add --dedup option
To:     =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 16, 2021 at 10:48 PM 胡哲宁 <adlternative@gmail.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> 于2021年1月16日周六 下午3:13写道：
> > > +       git switch -c dev &&
> >
> > If someone adds a new test after this test, then that new test will
> > run in the "dev" branch, which might be unexpected or undesirable. It
> > often is a good idea to ensure that tests do certain types of cleanup
> > to avoid breaking subsequent tests. Here, it would be a good idea to
> > ensure that the test switches back to the original branch when it
> > finishes (regardless of whether it finishes successfully or
> > unsuccessfully).
> >
> >     git switch -c dev &&
> >     test_when_finished "git switch master" &&
> >
> > Or you could use `git switch -` if you don't want to hard-code the
> > name "master" in the test (since there has been effort lately to
> > remove that name from tests.
> >
> I have little confuse about I can use` test_when_finished "git switch master" `,
> but I can't use` test_when_finished "git switch -" `,
> why？

You may use either one. I presented both as alternative approaches.
