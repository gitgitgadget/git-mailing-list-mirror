Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC223C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 03:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhLFDNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 22:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhLFDNp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 22:13:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACC6C0613F8
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 19:10:17 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k37so21913041lfv.3
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 19:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMBY0zQg+oerudXdREtCvJYBNQp1GyAV9/wIoU9Qi2A=;
        b=F+spaIqr/pRELvmC9F1Bg5HQxibOHGwGSgzVlr9CbsgkhCjUWXIrHEm8mK9ZbrRGCf
         k/XM99afUmmIwJGQY7sNUxtnD4glZdyrzPJNai9Q0h1O2znHOfYnfkJRh9JPEtTVy7rG
         c+jPGGqtjRgE9wPkX3Z8gNY64p3MTzVvg6ELRm9Y2/W1nPbVDJOOHz7sOI9Kaj9vUtNG
         DdZ7LMomSIX07UXI28+vVvZuQI/U6iSzndtBCuCYd9k2hfW/gm3L2OlIkzgf8NbcsdXI
         v5J1zckMfn9V5aliFwnYUIqMpgR/IITgfyWnmr1wUpjfX9dM0fwCh2/qwUuGH60QHdSL
         hqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMBY0zQg+oerudXdREtCvJYBNQp1GyAV9/wIoU9Qi2A=;
        b=qHxSo/1SKDvAkV21OhetW1P0CTkPhAGuWp4FuDGZoatOtaoDw1h/LKOzuEV/jGkMJJ
         ZoWkAgPOCfAiwNpWRc5Bqeuvm9nkPfmh/iMgZa3EEcqhxlDCrDrlxwSZG/CTbJxsRDVW
         PW2rgoh7iKm5AWfoRNaqn4oZkB4254FDMYS90w4QfWV5+M78zQW7sWKifwLDlXLIQeH2
         GGfnf2cRuofUGDv5CmCI+FzkikJMuMbhVZ9Qq9GHLKVdpkCPV63V4B0CS88W/VWp1Bji
         O3U8wnMoNmRFVNEL1wsChaDIvLYJhm3esHY2BmyWBH/2ldSZ/HsLeM97fiVG8sc4PvAT
         kuZA==
X-Gm-Message-State: AOAM533XkXFdmkEDaiunS7+/WvdZ1z+yiFkxninKeyhox1PQHv1k7F7u
        FfA9XOm8Dgle8PelbFVxtNd5KAziFkBEz58e4fI=
X-Google-Smtp-Source: ABdhPJw27TCKhP6D5FihSuJydtF2flZlU9CJy4RZeUy2hbk4qGYXHUhEiSmf5T8giJxbgt2xPAI3c90XwCXYvKY2O6E=
X-Received: by 2002:a05:6512:50f:: with SMTP id o15mr33241649lfb.522.1638760215482;
 Sun, 05 Dec 2021 19:10:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
 <d8ae001500c788cdabf4e6918da0a7ce89a48fc6.1638585658.git.gitgitgadget@gmail.com>
 <xmqqtufmlxmb.fsf@gitster.g> <20211205234408.GA26229@neerajsi-x1.localdomain> <xmqqsfv6ip1y.fsf@gitster.g>
In-Reply-To: <xmqqsfv6ip1y.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Sun, 5 Dec 2021 19:10:04 -0800
Message-ID: <CANQDOdfyoEM0pELKWzoK5ZUrDqwWnQLtbAycESzCqRRdWyWUSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tmp-objdir: disable ref updates when replacing the
 primary odb
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 5, 2021 at 3:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > On Sun, Dec 05, 2021 at 10:23:08AM -0800, Junio C Hamano wrote:
> >> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> >    /*
> >> >     * This object store is ephemeral, so there is no need to fsync.
> >> >     */
> >> > -  int will_destroy;
> >> > +  unsigned int will_destroy : 1;
> >>
> >> <CANQDOddCC7+gGUy1VBxxwvN7ieP+N8mQhbxK2xx6ySqZc6U7-g@mail.gmail.com>
> >> ?
> >>
> >> (https://github.com/git/git/pull/1076#discussion_r750645345)
> >
> > Thanks for noticing this! I also lost one other change
> > while splitting this out: we are referencing
> > the_repository from the refs code, but as of 34224e14d we
> > should be picking it up from the ref_store. I'll submit
> > an updated series as soon as it passes CI.
>
> No rush.
>
> Reviewers and other project participants would appreciate you more
> if you took a deep breath, after seeing a CI success, and gave a
> final re-reading of the patches with a critical pair of eyes, before
> you send the updated series out.
>
> Thanks.

Fair enough.  Of course I didn't see your email before I resubmitted.
Thanks for the feedback.
