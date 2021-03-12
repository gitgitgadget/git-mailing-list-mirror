Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237FBC433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6B064F2C
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhCLHFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 02:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhCLHFI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 02:05:08 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA006C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 23:05:07 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id o22so16147185oic.3
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 23:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQXBQTlTPnqjVYWyX5qdvNWetBXCgcxQj1h3gHcvY3U=;
        b=mVuC1eysEBgfWPUD4ZAlgxtgTB0SVj5ffHSCB9CMZseyHhG3+yrLt6hRkbyyLivARY
         u/JvaRR8z2+CPFGwcRuFDWDtxwL7+NJcaes7c+k7lL8Y8jwucybI5ExcY1j9v2F8ybaC
         syK+Ev/PC/TicBiIiQSy3lUC/F+J4R85ugLoCt72NbK3z2wxmY09U7hqq9ceD86x60nA
         EzkxfJ9b+y6wApo+xK169l8yBS1tfCg9bz0iIGv2z4GewmYUcXUsSoadwr7sYMxwoCPe
         5n3tE6zTqUeImSAep6pqDuuFmvfefADRAZShu6xLblrJaZsBYt3hOCeZ2tpHjKwF+Ffy
         skGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQXBQTlTPnqjVYWyX5qdvNWetBXCgcxQj1h3gHcvY3U=;
        b=df8fPBZJh5NnN81OLr0w5w8NPPbVIpn0sV2PxOWzbrrxD4xL9Szpn3ilznCS3lf+cV
         b/Pglj58OgWeNJ5FOLQJBZ9QuGFmmyG2epo6q3AVCokMDASW5CWDkEPztNESyMIB5I1y
         xfj+qsrV5xR95oLdTLnYMrRB6JQpdJFUjhawgjytZdPQ7IHxgJESsMkMp5WVJKb78gd/
         t7TsuTfIuu8dW2rwaMne/m2JEB0OfgS6qhUcjDzyR+ZOVzk+jZxIfSN2XZ83YEnNkR/i
         ePt+SaPTp2N5DWhu1b4hA5KLjnZmhWoSEn1IENBnfMIXUiJiIgqVdg0zn9OgNiXv32yF
         A2xg==
X-Gm-Message-State: AOAM533c5IccZaIEIqQ4Ts4epbtTeU9sx4HuRhdg4UJW3hK0vWoiB1UY
        8+iyMFMmAXdv0YHOyv/lgGeCzxabhtDmis2OU6U=
X-Google-Smtp-Source: ABdhPJy2GIelZ4HQZKxk/DzdFD22s1BLBtGxEmKabCZl8vblYkhZNw11tKmlQwmMvQbVZ9eXxLxzlD8PtvrRZxVrkf4=
X-Received: by 2002:aca:4fc1:: with SMTP id d184mr9174211oib.31.1615532707296;
 Thu, 11 Mar 2021 23:05:07 -0800 (PST)
MIME-Version: 1.0
References: <875z1xwznd.fsf@gnu.org> <YEpusE7ZIE5RgOws@coredump.intra.peff.net>
 <87a6r9o1yo.fsf@gnu.org> <CABURp0pFdHAx_+-e+O35Qxtbe3_+cZy9SZcOSeR2R7v_neRwKg@mail.gmail.com>
 <xmqq5z1wc389.fsf@gitster.g>
In-Reply-To: <xmqq5z1wc389.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Mar 2021 23:04:56 -0800
Message-ID: <CABPp-BERNcL-vx5eZ__Vc6cO2a3Tx4f+HzRPKenERk6mZi7ZDg@mail.gmail.com>
Subject: Re: [Bug] Stashing during merge loses MERGING state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phil Hord <phil.hord@gmail.com>, Tassilo Horn <tsdh@gnu.org>,
        Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 10:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phil Hord <phil.hord@gmail.com> writes:
>
> > On Thu, Mar 11, 2021 at 12:45 PM Tassilo Horn <tsdh@gnu.org> wrote:
> >> >> Or that popping the stash again would also restore the MERGING state.
> >> >
> >> > This would make more sense: the stash records that part of the state,
> >> > and then we make it available again later when the stash is applied.
> >> > However, that feature doesn't exist yet.
> >>
> >> Too bad.
> >
> > Consider also what happens when `git stash apply` results in a merge
> > conflict because of differences between your current index and the one
> > you had when you originally saved the stash.  This results in the
> > usual merge conflict markers that then need to be cleaned up.
>
> I agree with you that allowing a stash while a merge is in progress
> will introduce many unpleasant corner cases the users wouldn't want
> to deal with.  We certainly do prevent "git stash push" from running
> when the index is still unmerged (which is a sign that a mergy
> operation (like pull, rebase, merge, am -3, cherry-pick and revert
> that stops due to a conflict in the middle) is in progress), but
> once the end user resolves the conflicts in the index (either
> manually, or having the rerere.autoupdate feature in effect), such a
> sign of mergy operation still in progress that "git stash" currently
> uses will be gone.  We should teach "git stash push" to pay
> attention to other such signs like MERGE_HEAD etc. and stop before
> creating a stash (and also do the same to "git stash pop/apply").
>
> THanks.

I should have read the rest of the emails before responding.  Once
again, you manage to say roughly what I was thinking, but do so both
more concisely and more eloquently.
