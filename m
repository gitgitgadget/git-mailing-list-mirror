Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7F9C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6872151B
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrU0ZLZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgKYAOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 19:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgKYAOd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 19:14:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58697C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:14:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t4so168567wrr.12
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGJZo6rpjR1YoxwIbEixNR14dj6wny9GqzhACNE0LS4=;
        b=XrU0ZLZim9fUnJP2gMa0D4OztWQ3v/Do+kLTM/nJegkhRxgppJIthEszm4w6KRzj5b
         0gNOQNwRNODGKTz1xrJbvauHg6P12GEeyNYPtk/JdXzgxTpZlgL5TraDvW+xIpJ5Uwmz
         ki8/hsjn0NR18+nHgEOJBzfkEyRA1CBjJA9KYAqUooiznnMsdyJ2egJlpLnePP1Ps5Ia
         IboHHNPv7PQjm27MUjB+yXmT4+UmFAvuo6RDbuSF7Vtby2tpjnGswZ8mOMOxvfVvf1jc
         dpHEs1E4TdXh0pXc1C88+RzKzEmMEYXOhhPxWRxYwt+ay95U54GL0p6zIKrSD4j+NUya
         XrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGJZo6rpjR1YoxwIbEixNR14dj6wny9GqzhACNE0LS4=;
        b=M/o/oFo+EMgeCAwyc7zBe24k14c/+2ypmf5LLCuZD71e5PKzH4A4mCfsIXeK34infs
         rx2vpPLr6lczdJm7MuBmDWMUOEV10J4BI3xhVnvb/IsomOuIhTBAMntRDagyJVNxu4pq
         FAlwOYFMhz70wGX9nhWtBbnMv8/1kPki1yvh0O1NIag5Co/ejdoOUUDPxkA9MqEQjJj3
         PGyQqEjPspwcQZgfu13fw07hthFqmqJ/u3FuD5pQFUF3ILTBiXxib7eDfBjzxnHIW47w
         JyZxDGk7BRuS2eqQuzAuI/ZiephzdpMpUsoD9XByFIwGA/15bLp5bsU8TI8BJPILZUL0
         wk8g==
X-Gm-Message-State: AOAM530NQPtGJrQCzn5akJ0hj64muyH6g75DfJy6yaaQ7tzPs+++mr94
        TpLciyBoBy0KBCJLOvfcCsbpeTEsh0kfgrsVgj8=
X-Google-Smtp-Source: ABdhPJwuvxto5lvimLY0DCjuWzWZbISRtkCcC6i41a+4p8SW8x7Ju7G1NX2ThvQaL2U1d/GONtN3t71tnPvHSoqrlic=
X-Received: by 2002:adf:e788:: with SMTP id n8mr1051682wrm.84.1606263269990;
 Tue, 24 Nov 2020 16:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
 <X7y5Wxu1eY4k6753@coredump.intra.peff.net> <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
 <CAMP44s0PwJ8qEuCCpavshpm0GqV8p37rF8McR2=gdCk2kj+JiQ@mail.gmail.com>
 <xmqqo8jmgyrd.fsf@gitster.c.googlers.com> <CA+P7+xr8_s0Fq_TGjDjHEPpGJ8Br5x7omY1fsg0HjcXjutyRkg@mail.gmail.com>
 <xmqqk0uagxei.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0uagxei.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 24 Nov 2020 18:14:19 -0600
Message-ID: <CAMP44s2Yt_Vin1rLg-q9Jt8pA+bTDMjYbwSaGHZLgoNKL_nEvg@mail.gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 5:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:

> > However, @{0} *does* refer to what is currently checked out, which
> > would be head.. So in a sense @ meaning "the current branch" and
> > applying @{0} would always be HEAD, no?
>
> Not really.
>
> It happens to hold true for @{0}, because by definition you couldn't
> have been on a different branch than the current one when you made
> the topmost commit on the current branch.  For @{1} and higher, it
> is always "where was the current branch at N commits ago?" which is
> different from "where was the HEAD at N commits ago?", unless you
> always use a single branch and never switch away.

But @{0} is always the same as HEAD@{0}, which is always the same as @.

-- 
Felipe Contreras
