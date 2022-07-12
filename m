Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D44EC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 05:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiGLFdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 01:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiGLFc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 01:32:57 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BEC8C75D
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 22:32:56 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31c8a1e9e33so70140737b3.5
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 22:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLdV6829UaVJ1sqybzCkAEbdh3FarHc/VnJruX1/OL0=;
        b=bNWHOxwW0onXT/nokffmLuLn+Zf9Oz64YnjSgiDcIpRD81E1f/rSYcawyugapFs0PP
         XQ9ddO077l64nEjprt+DCAQfYu7zyqLbF5KUIGTYg1ozvNrQELxUxuaGdmiksQ0bCalS
         rrdLspLNZz6a+PktMJhRRlDkKihPuCbguM8ImxGWoa2NAScixSjK2ADD+JR3reJ+AuSa
         +MWGQwvQb6IjHy9eNhfuiOPZLRTJg1kOxi2zf3Fueseioo7Dg4y/ZxADjr06H9chWXuR
         GlqHObGpaW05PbYURvJzX2Z6Dwzi4HTdEMvYBmc3ZAo/0E6iEY+TASRMHph/kTm2euZE
         s8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLdV6829UaVJ1sqybzCkAEbdh3FarHc/VnJruX1/OL0=;
        b=vt263Q+z9MXMzQxsfaFp3ZmfvJXCvXIKijOVcrEQm/d/77TGfOrpLHPP7sC2HoW38W
         3KxeHKKJabBDG41mbxxjRWt2SUwxF+GgGruyPpH9ArTlAKgN8fh8R0/5ZV4COi0LcSFF
         7+a46l/MobBdmgVKQIz5kPhtEUqbiYH22VKa/2e0zNJ6VifF9zpvjLBjUldLoW2QoPz2
         J+JBZJjZkPFT1BdbTPRlS/9cIyy3vLv4Frurs65awcLGD7QCPbyFec6LuZl5iWDNER9O
         nlSuj7KraoUeu18EGgyanrXECgns25f5DtIqW8+eEflr4n7LZhS70x+OgAyJM7aiDGp/
         mZwQ==
X-Gm-Message-State: AJIora/La7NusfiCxvgdyqKP2EEz5OCnrogMxE51I6gNXZao18A9MFm4
        bCoU1bUCOBc70SVA67TuDSioT7kNa1NyCt7GI7GzYw==
X-Google-Smtp-Source: AGRyM1tUGQ2O6I4KRb0REK/UDbscsHdSdv7pfrckZ1uZs2Ed16t4z0U92TjORhIgfE+BmBwipBaFsd6mSNwoutADFqM=
X-Received: by 2002:a81:238e:0:b0:300:642f:fdb2 with SMTP id
 j136-20020a81238e000000b00300642ffdb2mr24607775ywj.373.1657603976159; Mon, 11
 Jul 2022 22:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656381667.git.hanxin.hx@bytedance.com> <cover.1656593279.git.hanxin.hx@bytedance.com>
 <96d4bb71505d87ed501c058bbd89bfc13d08b24a.1656593279.git.hanxin.hx@bytedance.com>
 <165736941632.704481.18414237954289110814.git@grubix.eu> <Ysw9LmBFGbRy9L7c@coredump.intra.peff.net>
 <xmqqk08jo147.fsf@gitster.g> <CAKgqsWVD2108f0PyJGp6mVKp2cGd_V_MiiQO3SAPm+LEHcb2mA@mail.gmail.com>
 <xmqq1quqkiq2.fsf@gitster.g>
In-Reply-To: <xmqq1quqkiq2.fsf@gitster.g>
From:   Han Xin <hanxin.hx@bytedance.com>
Date:   Tue, 12 Jul 2022 13:32:43 +0800
Message-ID: <CAKgqsWW+OECFnEy+uib1W6UzB1Sy_MQ5towDwH28fg=ni1v_0Q@mail.gmail.com>
Subject: Re: Re: [PATCH v4 1/1] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Michael J Gruber <git@grubix.eu>,
        chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 1:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han Xin <hanxin.hx@bytedance.com> writes:
>
> >> I wonder if we can just run the test without any limit?  If in an
> >> unattended CI situation, hopefully they will kick the job out due to
> >> quota, and on a developer workstation, there may be processes killed
> >> left and right, but that is only when the "infinite respawning" bug
> >> reappears.
> >>
> >
> > The tricky thing about using ulimit is that it's tied to the entire development
> > station. I have tried to run the test without any limit [1], it did finally be
> > canceled after 6 hours.
>
> I am not worried so much about developer workstation, which people
> are sitting in front of.  They can ^C any runaway test way before 6
> hours just fine.
>
> I am assuming that we do not have to be worried about CI settings
> too much, either, as they should already be prepared to catch
> run-away processes.

OK, let's remove the "ulimit" and leave it to the followup checks.

Thanks.
-Han Xin
