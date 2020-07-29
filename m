Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC64C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 13:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20EE20809
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 13:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2Nct (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:32:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35602 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2Nct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 09:32:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id f1so21110304wro.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 06:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLYDNhK9mx1XPVLd6J7lOekm70yK0X27zFLqUFsV2ys=;
        b=SfGtmHg6sZX2Xf93RP4ol94kBxawBEfOrLuJlN5BHVFfW7rrvVu+EZBmxLCVgBz4+D
         UraMe9na3JHaZBEjatz61QO2jMouTHXVP1sq5W4tPA/2YqDkfQcLgFgWPfmTAIfOpa8V
         CIqiF71GU9++zVguDd0D8JqkflHpjTMrrMGyXFYVahlj+IkxesXmS8FsuZGeclGXYrEo
         lpP9GoluDgSnIWBUQy4vrPc4oP3+TFrnhfONBifm6oIucN4Zj3486+0bLNWkyq/jWLMI
         YrlvTqayTBBrdAcb6gkm2q+KBvmyQ5V9BBNfY687l+MPUPu0CY67MgvwSJny7sMPozGf
         pODg==
X-Gm-Message-State: AOAM532emg9kJGdaiiKMABcWh0obplLIQkJAhfoy5SFpBHNZzjbqhBap
        ftOVhs7RER6BIgnyVWSxGzw2E081m37jFbk7GJc=
X-Google-Smtp-Source: ABdhPJw7FZFQt6IB413SgzOmSYr6jojmWsbEvvAgt1wyXeDcqd0opeWsZthWoqN4hM4s/2xjXfCC8qtx2HJzsDG8yzk=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr30233903wrn.415.1596029567032;
 Wed, 29 Jul 2020 06:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200728202124.GA1021264@coredump.intra.peff.net> <CAP8UFD26J6W50SeQqJiG0y04kcdNzr6RRT7ZeJmrQ2V-QTS3Lg@mail.gmail.com>
In-Reply-To: <CAP8UFD26J6W50SeQqJiG0y04kcdNzr6RRT7ZeJmrQ2V-QTS3Lg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Jul 2020 09:32:36 -0400
Message-ID: <CAPig+cQEqhpu3-_wXUFjfokSuesu2a5QdiaT8ks4kPiYkUsOvw@mail.gmail.com>
Subject: Re: [PATCH 0/11] renaming argv_array
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 2:16 AM Christian Couder
<christian.couder@gmail.com> wrote:
> I would expect after the above sentence that you would rename it to
> "string_array" or "str_array".
> [...]
> Also we still use "array" in "oid_array" which is very similar to
> this. And the implementation is based on the ALLOC_GROW macro which
> uses the REALLOC_ARRAY macro.
>
> We also use ALLOC_ARRAY, FLEX_ARRAY, CALLOC_ARRAY, COPY_ARRAY and
> MOVE_ARRAY macros.
> [...]
> If you want to change only "argv_array" (and not also "oid_array",
> "REALLOC_ARRAY" and perhaps other *_ARRAY macros) into something else,
> then I think it would be better to be consistent with them.

Dipping my toe into the bikeshed paint bucket...

Naming consistency is certainly a valid concern, and if this was a
public API I might agree that such consistency should outweigh some
other concerns, however, this is a private, project-specific API in
which convenience and concision weigh more heavily in my opinion.
There is value in succinctness, not just when writing code (by having
to type less), but also when reading it, for the same reason that we
use short and sweet variable and function names. To wit: short, well
chosen, idiomatic names let the structure of the code show through
(often) at-a-glance, whereas long names force us to laboriously read
code, making it harder to discern the overall structure and logic.

There is also value[1] in having "vec" (or "v") in the name as opposed
to "array", specifically because this isn't just an array of strings;
it is a NULL-terminated vector of strings. Thus, it is suitable for
functions which accept such a datatype, which often have "v" in their
names, as well (for instance, execv()).

On the topic of a "terminated array": As a NULL-terminated array of
strings, the name "strvec" provides naming consistency and fits nicely
alongside the name "strbuf", a NUL-terminated array of characters,
while also sharing the relative concision of that name.

In my opinion, the name "strvec" is a good and reasonably succinct
compromise between other names, such as "strv"[2] and "strs"[3],
proposed previously. It gets my "+1".

[1]: https://lore.kernel.org/git/20180227221808.GE11187@sigill.intra.peff.net/
[2]: https://lore.kernel.org/git/20180227220443.GB11187@sigill.intra.peff.net/
[3]: https://lore.kernel.org/git/CAPig+cS+G-xC51n-Ud0Wbmcc-zeHBM3-5WQQAFm9gwm9LNk3Gg@mail.gmail.com/
