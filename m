Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD4C28D13
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 01:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiHWBSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 21:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbiHWBSr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 21:18:47 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0902B262
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 18:18:45 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h22so9351754qtu.2
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 18:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9tVNSFd4HHuTYseQwsiDoz7GEONqPsfKTbJTEtVK3M8=;
        b=BmBmpRKqs+xpa0ZWJ+f2bPIQO9/SSIH4JpYLcqkDzpZ/K3WhZlF1WJD2R9suPcn5rJ
         LdxNxK6eQ7oPqvAqFq1XkQnFeoT3T/qJjLe7VqL5e7RoUM+9s9ug9n7fpelO9eM7JLQW
         E3eBXEPUWNagzkjeySTrXs4XMLJfjoLQ3KNTLIUhcym5a7blYEBNrunGozy3Ozap8LRe
         YrJhj2k2q8sWi/2K2g3juCf96R1nv/4t30URBAwB30K80+sr3B0ienemu1kIYlRwdfVe
         jD64DvJRQwjJ8OFwtHkUFjuZSDy38rUIaLRRdGBwIueefqQPOGkDi/s13W6/aJga/QHf
         FaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9tVNSFd4HHuTYseQwsiDoz7GEONqPsfKTbJTEtVK3M8=;
        b=Afo9H3uQ3hr8QEftPiipFr8Ze55jp5T0dSaP+T3paqEk2VIXxPtOliBbMFyk4jGpjI
         yXyN5svtD79k9BSjOTF2iZ9YUZwD/EM6zcbrxizXhKpl8q08T4R8yP0OvU6o5on2LPtW
         2jaGVbPNddzkkRBbNU696YUUeTUCqnuc+b7zgWilGpbaRO4wjPD7K2qeL0X5jB7PIwtu
         dWVttqJ0Jrn/BFeqo8PycLD1JYCrvesQK7LNsSPZqgQkSrbTWC6ovUGH+ZE5eqU3ZhFH
         lQ6gRe7Gv4Z6FhxBvipDdisFsXzrfCx8+we/E4UmyjkPT6VhZghXCy7WlmT4niqfJpMs
         DoXw==
X-Gm-Message-State: ACgBeo2GkEFcpIYi7laZ9fG0zapiBc9VVHLeAH60RwPypZgo464A2dc4
        czRf2VzmeI3rEn7GhnVhB8XjNv4x8obqLZRsxSw=
X-Google-Smtp-Source: AA6agR6fT/pNbhQ/QyJMHNwUUQwrnRMzXaa/FTCJqqpWnm8kMYxvZHncrH5XxDyGWuZ6r1glsCR/7ZtiVEzzyD9Z2rs=
X-Received: by 2002:ac8:5f09:0:b0:343:67b3:96f5 with SMTP id
 x9-20020ac85f09000000b0034367b396f5mr17686558qta.470.1661217524388; Mon, 22
 Aug 2022 18:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
 <5657a05e7635ecadbb8d2e41ad97fe19f3633fdd.1661056709.git.gitgitgadget@gmail.com>
 <xmqqwnb1fp5n.fsf@gitster.g> <CABPp-BHy-Xs0S1-9kL7X4mi6JNfd420-vpVsswXNuXsc5C7AtA@mail.gmail.com>
 <xmqqr118dzek.fsf@gitster.g>
In-Reply-To: <xmqqr118dzek.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Aug 2022 18:18:00 -0700
Message-ID: <CABPp-BHH6isv7iRKee34c1AEJ8JT5iUX7i7j6s9CVbmYN0Ervw@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge: avoid searching for strategies with fewer than
 0 conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 9:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
[...]
> > ...  In contrast, if the user did specify
> > --no-commit and the previous strategy succeeded, then we will continue
> > the loop.  That seems rather inconsistent, since --no-commit should
> > not affect the choice of strategy.
>
> Yeah, exactly.
>
> > However, I missed two things in my reading.  You are correct that I
> > missed the "<=" as opposed to "<" when I wrote my commit message,
> > though that turns out to not matter much due to the second thing.  The
> > second thing I missed was part of the code at the beginning of the
> > loop:
> >
> >     for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
>
> Ahhhh, that explains it.  We leave as soon as we find merge_was_ok
> so this patch is not necessary.  There is nothing to fix.  The
> original was fine as-is.

Right, there was no bug or even optimization opportunity in the
original, it was just confusing...as evidenced by the fact that we
both misread the code.

The fact that we both misread the code, though, suggests there is
something to fix: code readability.
