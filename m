Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29404C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 04:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D3D6127C
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 04:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhGKE5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 00:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhGKE5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 00:57:46 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A968CC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 21:55:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so14533798otp.8
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 21:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtq+CKvGjZedY8LOX8tYl/34sXWcC4p4F05Is1IXHN4=;
        b=eqM9q/+V83oPQ7bAwgUI1rQsI3HdDAn77zPn3O2zplRIFg1l+6YZaQWjMCPlI52hwh
         PKPuudfe2K7RoGsX96fuwNPIswmVWJVUyM0d70k+lWJ5MFSZ0B3/jkwevA3VWE0+aths
         LMIFBJhVSHonLlBGqQfyKs0POwsD8JQNSrc9VMbqdD7mWeODjpTrb6OfG5iAH9+71Gs2
         9UkSYhcqA2ca3gRsUuXnNPBXJ4B3gJa6NID+JIPjHBCiZcDN66QbjydZPeqyzhkHJjTu
         39r3A2Y6x140HCq7uByeLYp3jHNRF15XanR7nAtWrJbb05UzcuLwuZHgxLAxBif0Ti3J
         TFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtq+CKvGjZedY8LOX8tYl/34sXWcC4p4F05Is1IXHN4=;
        b=eeHdiOpXu9GY5lrs60Bs3EpZEQ8Ph20Q47TI4HNYXNWPpL0tQ2HjnQD+dPyZ4bqcq2
         vs4O0jnH4ivZfnHHBunURnmzHHhXMkstvupB9VyUmYwQDMfvokDMqZQzhdhHNUwEYUL3
         9E/Gi6lCD/UsU5dg9ulS2gpG+slSl67JTfuEOXr67p2FzHnWrCLTS2/ZMSKUsB0GR87X
         RP+GdTpWrDWG1ImPDVbrzAPtxAfIk6FKr2l4GwULHiZhvj5NJ6UBo2X2mu/QZlp6epbj
         I0qSO+cqldNU6S+PxiywyAiU1yWNJzowKnsQ9GCH00rN+HWLVz/eUAvxmjo0BUk0R0d3
         FAYw==
X-Gm-Message-State: AOAM53076SKUqoG+mrpngUO82bmJHHc/Uyu6AjzoqurkvK/GtmJERoHJ
        nxirUqYAYru2Ju35lpdNZSPA65xUE10ueWSpnuw=
X-Google-Smtp-Source: ABdhPJz4dzU73/zi4ogCb9ni4f+WUcQ2FhO4eWoPh00hzyNebyBr6bx4R9I0MTfyLAyjpCD/e8fVPClYwDNBkHgV5m0=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr5538447otd.345.1625979300088;
 Sat, 10 Jul 2021 21:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <ee0969429cba837ba6d79712706c899d5b231798.1625964399.git.gitgitgadget@gmail.com>
 <CAPig+cTFoLaUd8+VRsaJuP24C7fnbTTFx0i7PizyasES7K2jdg@mail.gmail.com>
In-Reply-To: <CAPig+cTFoLaUd8+VRsaJuP24C7fnbTTFx0i7PizyasES7K2jdg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 10 Jul 2021 21:54:49 -0700
Message-ID: <CABPp-BErUpi8cS=-OQb3vLHDOSEygV1+bVbKRWWQ-eOvNQ561Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] doc: document the special handling of -l0
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 10, 2021 at 9:54 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sat, Jul 10, 2021 at 8:46 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > As noted in commit 89973554b52c (diffcore-rename: make diff-tree -l0
> > mean -l<large>, 2017-11-29), -l0 has had a magical special "large"
> > historical value associated with it.  Document this value, particularly
> > since it is not large enough for some uses -- see commit 9f7e4bfa3b6d
> > (diff: remove silent clamp of renameLimit, 2017-11-13).
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> > @@ -595,6 +595,9 @@ of a delete/create pair.
> >         specified number.  Defaults to diff.renameLimit, or if that is
> >         also unspecified, to 400.
> >
> > +       Note that for backward compatibility reasons, a value of 0 is treated
> > +       the same as if 32767 was passed.
>
> To get this to format properly, you'll need to drop the indentation
> from the new paragraph and replace the blank line preceding it with a
> line containing just a plus (`+`).

Ok, will do.  Thanks.
