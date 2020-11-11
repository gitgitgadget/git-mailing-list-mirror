Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADDFC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 18:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A23206FB
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrNlUktQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgKKS6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgKKS6S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 13:58:18 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9ADC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 10:58:18 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id u127so3352128oib.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 10:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJAm8cvyuHxGmWQxKlGyrA8z4EwQpmk4e6OcbrqL54w=;
        b=SrNlUktQ5Lu4HEFxcewfdEZcbzSx6GRXVBu//DhBLw1TtgdC5Fm5+8xRdFPVRUijF5
         YDnxNPpSEbab0DCHP6dZBkRIzG8zifLlehH9zq67SZuQh6Y/MpaF+cKz0RwoaTbRb3TN
         sSZy5di9wj+obTQ7xMS2QAcfzMVLyoAsTRQZtT/ZDA29Ke5l7jl38yeuNe0ziUeI1Ooy
         hOJJbukAEcgJztw2Q4Ma3Wl0UDG0/PpHjjBejy3kRyDtgQLAD5z/HEqFLnSNtvS0/5HH
         ihfuj0T+RI0OQ6Ju84ukiCAdZKefJENpDZCzA1aufez/P4bZ0dlrvwd/9sr/NZu3Q/BN
         PtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJAm8cvyuHxGmWQxKlGyrA8z4EwQpmk4e6OcbrqL54w=;
        b=s6aUmMHG2Xhx2rqJEqxLkqSIF3/DRQ9oxyyA3gK8VdntIgSfIsA2v/TSh3cMgQ3HOZ
         S3i7bXrhEOBQfsi1rD3buNFoWpKoVj9GRStxP8Z3O5Dfw/YcOrg8P3GBlqxETexvuVyo
         lSOlN1whslmRqZ+BlBtANTURCa/EKeepq5kBDQLtjLL3iazv02r4ssc0itptyxWw2Dew
         HPeUm64jRUHb7a2X36jyNmxwLKoUH7Th5HurrypTPkF0l7B+LgYBMBKxBxSA6q3YgZlp
         gMxgI1v7ULZthqQ3qvssNJ/erT33m7kqUO41y8I0AXKd9wnZPN86dVxEiFcUaxkUpupi
         1kvA==
X-Gm-Message-State: AOAM532Kdx49fPscira8Jy9FkAeYxXRJYuRpnHBTl5iE8tGSSmtRr4XL
        Ty8+OAG/knz2HQe1DJcVVdqnRawcS2f7IS1aaZK/RN9mYO0=
X-Google-Smtp-Source: ABdhPJxwS6jfK75WHrx0sTwttjzPOUJ2gD4/b2FjWZvjlsmpr45wuDdn+i8sdTlhuOCoXa3FN3PVVyWtuHQFynEHlDM=
X-Received: by 2002:aca:49d5:: with SMTP id w204mr3179367oia.167.1605121097532;
 Wed, 11 Nov 2020 10:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <20201102204344.342633-13-newren@gmail.com>
 <4432ae6c-90ae-90d9-218f-15856395efac@gmail.com>
In-Reply-To: <4432ae6c-90ae-90d9-218f-15856395efac@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 10:58:06 -0800
Message-ID: <CABPp-BEEoqOer11BYrqSVE9E4HcT5MNWcRm7ZHBQ7MVZRUDVXw@mail.gmail.com>
Subject: Re: [PATCH v2 12/20] merge-ort: have process_entries operate in a
 defined order
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 8:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/2/2020 3:43 PM, Elijah Newren wrote:
> > We want to handle paths below a directory before needing to handle the
> > directory itself.  Also, we want to handle the directory immediately
> > after the paths below it, so we can't use simple lexicographic ordering
> > from strcmp (which would insert foo.txt between foo and foo/file.c).
> > Copy string_list_df_name_compare() from merge-recursive.c, and set up a
> > string list of paths sorted by that function so that we can iterate in
> > the desired order.
>
> This is at least the second time we've copied something from
> merge-recursive.c. Should we be starting a merge-utils.[c|h] to group
> these together under a common implementation?

I'm actually going to replace the function later for performance
reasons, but trying to make the series as simple as possible prompted
me to "just copy something for a starting point".

There will be more functions that I copy, yes, but since I sometimes
also tweak and since the goal is to delete merge-recursive.[ch], I
didn't really want to set up an infrastructure to share stuff.

> > +     /* Put every entry from paths into plist, then sort */
> >       strmap_for_each_entry(&opt->priv->paths, &iter, e) {
> > +             string_list_append(&plist, e->key)->util = e->value;
> > +     }
>
> nit: are braces required here?

It might not be with the current macro definition of
strmap_for_each_entry(), but I think at one point it was (the macro
has undergone some changes over time).  Given the difficulty of
digging through the layers of macros (and the possible risk of it
changing in the future with hashmap or strmap changes), I wonder if
it's simpler for readers to just keep them?
