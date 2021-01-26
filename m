Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C1C43332
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5B220679
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbhAZWBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394225AbhAZSMn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:12:43 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275FFC061756
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:12:03 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id u22so4095795vke.9
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fQuIsNZi4oXUovvoZnmsNuELQOOWhyI9gwlvOe6M+KI=;
        b=tr6gLYcfwHwuo7TwQt7gO4eFhDe4qmvlEqi+66wHsc8voKRe8Li104hqO4CNolQZeT
         ODrwA92GEiEwvj2lt6ATTZoqZEeGVXl7/B5p1Vg/7f0/LMj7FS17TUkF1qsANNV1dRuD
         lkgm1F+UkaYTxk96c0YtvRfBRvDWt7UejnsMebHk3kaA2m6TjiYEz5ShXL6Jy7MlJNx6
         +IaudSXRH50jNzv/FtoLVK0qANRfcV1SYqZOVQuJbuV52jfMUEGEPuLgKTj0xVsu+G9N
         LJNYjNsYyc2jLbQtmu1VSnKv4zqNUwZ1t8VPF13C+MFy6x5dxXIHTXrzsmVQynBJprFQ
         SOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fQuIsNZi4oXUovvoZnmsNuELQOOWhyI9gwlvOe6M+KI=;
        b=DMQjKc7f77E8AbTXyti2y4McMAPBVoETWeigTxPd+2vxPP0yN0wuoLFxE9PwnEN2X2
         9Wld5dHv418ga3M/8+4tK9ivVTYqmHgsUP/FG8PN5AfNK+q1WauDVtt56Brbyp2usVGi
         6E4uVgLqDJCBcR2kjL3eMrafcwG6eIlp8Lb/kMl0bRTPCYubiQr3hh7gaTkefyjwHeiU
         wJpP9vykfe/T4xa5kJWl3oTPLQV2mkI11VCy6gr58Wh4i9QB+tnHulxcbwoqyaq101Uh
         Nq2AcO1gZT/lLqKw+xHWIPsG0GZvejLRCOTas767gQf/ZuPkpFvkiKQjURKxEKv8DuvV
         Ojzg==
X-Gm-Message-State: AOAM533hsYkSO7G78mEIIKhH1Xw9bEYfNxjJIg062Pa8TzMte9Kr0r2g
        upGXy7mZPDiv89K7abl2Qhz2YNc4swiqjvsvyAMIKA==
X-Google-Smtp-Source: ABdhPJxRXbYT0ddq16vPAAejroIIPY7a+czwbIF6vK4ayLtOigbVBmtix5eldcMpnIy9AAO8+E7CIAxrIaOs5IEyMMY=
X-Received: by 2002:a05:6122:31a:: with SMTP id c26mr5923175vko.0.1611684721943;
 Tue, 26 Jan 2021 10:12:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.951.git.git.1611589125365.gitgitgadget@gmail.com>
 <xmqq35yo459k.fsf@gitster.c.googlers.com> <CAFQ2z_PCh2RfWALhAUXm01Xq0o+ibuEGJ2p9sCtvTASQ0FLUag@mail.gmail.com>
 <xmqqtur338bg.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtur338bg.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 26 Jan 2021 19:11:50 +0100
Message-ID: <CAFQ2z_PN8K6sKq=Rdw=maVhd67GhCtxWgGSUb5KhZ85EYV6jOw@mail.gmail.com>
Subject: Re: [PATCH] doc/reftable: document how to handle windows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 6:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> >> Is this because we have been assuming that in step 5. we can
> >> "overwrite" (i.e. take over the name, implicitly unlinking the
> >> existing one) the existing 0000001-00000001.ref with the newly
> >> prepared one, which is not doable on Windows?
> >
> > No, the protocol for adding a table to the end of the stack is
> > impervious to problems on Windows, as everything happens under lock,
> > so there is no possibility of collisions.
> >
> >> We must prepare for two "randoms" colliding and retrying the
> >> renaming step anyway, so would it make more sense to instead
> >> use a non-random suffix (i.e. try "-0.ref" first, and when it we
> >> fails, readdir for 0000001-00000001-*.ref to find the latest
> >> suffix and increment it)?
> >
> > This is a lot of complexity, and both transactions and compactions can
> > always fail because they fail to get the lock, or because the data to
> > be written is out of date. So callers need to be prepared for a retry
> > anyway.
>
> Sorry, are we saying the same thing and reaching different
> conclusions?
>
> My question was, under the assumption that the callers need to be
> prepared for a retry anyway,
>
>  (1) would it be possible to use "seq" (or "take max from existing
>      and add one") as the random number generator for the ${random}
>      part of your document, and
>
>  (2) if the answer to the previous question is yes, would it result
>      in a system that is easier for Git developers, who observe what
>      happens inside the .git directory, to understand the behaviour
>      of the system, as they can immediately see that 1-1-47 is newer
>      than 1-1-22 instead of 1-1-$random1 and 1-1-$random2 that
>      cannot be compared?

The first two parts of the file name (${min}-${max}) already provide
visibility into what is going on, and the file system timestamp
already indicates which file is newer. I picked a random name as
suffix, as it gets the job done and is simple.

We could do what you suggest, but it adds semantics to the filenames
that aren't really there: currently, tables.list is a list of
filenames, and no part of the code parses back the file names. If we'd
do what you suggest, we have more ways in which the system can break
subtly, and needs to handle error conditions if the names are
malformed. This is the complexity I was alluding to in my previous
message.

We could stipulate that a compaction must always increase the logical
timestamp, ie. in the scenario I sketched, the compacted table should
be written with a max-timestamp of 3, even though it contains no
entries at timestamp 3.  This avoids the error condition, but it's
also surprising because it is actually inconsistent with how the
format is described. But maybe we could update the description of the
format.

Or, we could rename to ${min}-${max}-0 and if that fails try
${min}-${max}-1, and if that fails ${min}-${max}-2 etc. I think that
is somewhat nicer than parsing back a counter from the existing
filenames, but it could have the effect that 1-1-0 could be newer than
1-1-2.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
