Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92C120248
	for <e@80x24.org>; Tue, 19 Mar 2019 18:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCSSrH (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 14:47:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35481 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfCSSrH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 14:47:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so32569wrp.2
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 11:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wh6Vyhmt2tzQw+ENfc56KjKm9+3J66dPM9BKiMwoqdc=;
        b=cxzOdICvmDEuk4GuzKU5D/xTRjVBKzvpiVdvNIQsTaxeHqBAhPxLeZK7MlSdl3xHNL
         tJsvY7llqXDroajL6GC0Xejguz/g2oJAjcJ0LfOj7MmoCUKZiXHiNhdBImJ8PH/LQNX5
         DzjVy/bwR7LktbFkWKEiU+M3pQaNFFd0flvWkX/GgHDTnHJeHxpCGKtjSeM3Hakft+Ui
         NmEv/cd77TI8Bolu1Zi+EeAwhJpMHAmmtqOYYGeEwLj36Ux4A2LkYS/omCFSv/K2h7nx
         /HyS1IL7jX0K8MYv2CtFNUb8iTJxakcTVKFM3tgX2BNeE0Mk9STGxcitPKVfpXD79Bro
         AShw==
X-Gm-Message-State: APjAAAV1PGgqMcgVSPSxVnHGM0iH6UusNp/ma+oA/EGub92ck7tXKO9d
        gBL7kMbXi+ZN4NgeBLV7TDSUQ1KNcKq48R2TN0k=
X-Google-Smtp-Source: APXvYqyXgyI+rrXc2710qp0V7JGAZzeo1MA3BDWLG/PC8P4PBnfwgspiuP2K4jLv5L0J/FKBmRvAoL37ojHHskqi1c4=
X-Received: by 2002:a5d:62c4:: with SMTP id o4mr12942034wrv.282.1553021225911;
 Tue, 19 Mar 2019 11:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.166.git.gitgitgadget@gmail.com> <pull.166.v2.git.gitgitgadget@gmail.com>
 <e1da1f84a85165703e3b6be4a240bd36d62b4b01.1553006268.git.gitgitgadget@gmail.com>
 <CAPig+cTC0AmJyU7D=f9VAGOOwJpk+aMe95MDqiiCqMdU5-kk+A@mail.gmail.com> <fbb2ce21-18ce-3d1e-e6f6-907c8b9693d9@jeffhostetler.com>
In-Reply-To: <fbb2ce21-18ce-3d1e-e6f6-907c8b9693d9@jeffhostetler.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Mar 2019 14:46:54 -0400
Message-ID: <CAPig+cQhs-YDv2LySbAJkXOWGEAQohkPipj1WLz-BZqrWFyo1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] progress: add sparse mode to force 100% complete message
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 19, 2019 at 2:33 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
> On 3/19/2019 12:42 PM, Eric Sunshine wrote:
> > Rather than adding a new "sparse" mode, I wonder if this entire
> > concept can be boiled down to a single new function:
> >
> >      void finish_progress(struct progress **p_progress, const char *msg)
> >      {
> >          [...]
> >      }
> >
> > without having to make any other changes to the implementation or add
> > a new field to the structure.
>
> The existing model has start_progress() and start_delayed_progress().
> I was following that model and added the new option at the start.
> I'm not planning on adding any additional flags, but if we had some
> we'd want them available on the startup next to this one.

Perhaps it makes sense to just take a 'flags' argument instead of
'sparse' so we don't have to worry about this going forward. In other
words:

    #define PROGRESS_DELAYED (1 << 0)
    #define PROGRESS_SPARSE (1 << 1)

    struct progress *start_progress_x(const char *title, uint64_t total,
        unsigned flags);

which covers "delayed" start and "sparse". ("_x" is a placeholder
since I can't think of a good name).

> >                                It would mean, though, that the caller
> > would have to remember to invoke finish_progress() rather than
> > stop_progress().
>
> Right, I was trying to isolate the change to the setup, so that loop
> bottoms and any in-loop return points don't all have to worry about
> whether to call stop_ or finish_.

Yes, I understand the benefit.

Anyhow, my comments are akin to bikeshedding, thus not necessarily actionable.
