Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC4EC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 02:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CB3206F1
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 02:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbhASCzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 21:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbhASCzj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 21:55:39 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F357C061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 18:54:59 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id n186so11873767oia.5
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 18:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LSyxnimB1KmG4u7bw6Ymg4eC3jzn+LpSoytFiwMcgDw=;
        b=PzasSDfA5imVf8uFdcZfhOrmMiVbj0QtIbINYcKpmAv9y4jm9r0/s8AUii6Rj7A80l
         Io/OwpE2WbIxGj28lwJen5GNZ5JrN3GA2tdgQwLx5tRwE/DiGRPxmETGvRKjpyPUFh5l
         QaH/pZj+9YMUNGDXUwkJSSws7iw2WnSFYkKEhfKiWDHeKjTaWMHfo1MDSAqZMssEOj8n
         v2s7QkxEmEL0KKhDwO/yHP4wgY3FI0TuWOfeVSa5kv6R5T0wiZJqsWQlSOjpVY/Jdcju
         KFuTddf2g/tHTkX3YffqKFjZhKgDCrIQ9TzGAVhAP95eqET6P4r1e8djECABC71PUW9r
         ANMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LSyxnimB1KmG4u7bw6Ymg4eC3jzn+LpSoytFiwMcgDw=;
        b=tyYI5x6vDoVIoy1Nf7aLsDvz4Kqn9joILOoUu1yHzKPVdFYnC2YWC6rMIdjb2mDapf
         WJIrZmrVKQyoCPvFJxHLSpezUCIO53uELrkj072CucLsqCX/weU4H7XZICDMNude0CmO
         7DfSeAcA3hzvLScDWmjlomnHK6ND0/+yF+53IMQGWq6q2QHtloJHYiQenTIZYLpjR6Ep
         dYDAbuFCtr02QB7sv+HqMchPRQdPDNfxoIIiPxDfS1x3mT+Bm1gcthxVcMdjvQQ5jJxR
         lVgUaAbOpzjDT2mR15gJ2xy1qZZgyS2kDwMuNhdzScHz2jmSFzYy19QInoJaZ04KIQqm
         oKlA==
X-Gm-Message-State: AOAM533cFIzuFP0fwOY1V+wtHD6HbH6QV4KtJh2XQjUKtkRZUh/N1WqB
        a038FPYNJhBbDBFCw2uWJOk8vKcsrVtxvuFTXIg=
X-Google-Smtp-Source: ABdhPJyAoo78jNWuNx8opg91AqpU18wsyQVoIGhkUhX9JD01oNpqZuuqyQ0bVG9AS1gOmMBJNgA2p/gD0H1ZVYCfFbA=
X-Received: by 2002:a54:4083:: with SMTP id i3mr1290598oii.120.1611024898526;
 Mon, 18 Jan 2021 18:54:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
 <pull.832.v4.git.1610856136.gitgitgadget@gmail.com> <0c7830d07db0aa1ec055b97de52bd873d05e3ab1.1610856136.git.gitgitgadget@gmail.com>
 <xmqqbldnkuja.fsf@gitster.c.googlers.com> <CAOLTT8Syp2ZeTXW-m+e=dn2W773nScB_kwZLS3MjLTcFQ_bctw@mail.gmail.com>
 <CAOLTT8QnhNqnJCgiqOZnd9cjxicAuk2Js1GKdHEJD_XK15UU+Q@mail.gmail.com> <xmqqczy2j5k0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqczy2j5k0.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Tue, 19 Jan 2021 10:56:27 +0800
Message-ID: <CAOLTT8Qd81K7gjH7nq2g=z2j2YePntGzLfdzY3NJF0_nihdyMA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ls-files: add --deduplicate option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much for your answer,I also learned a lot from it, then
I will use the description of "suppress duplicate entries".

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:31=E5=86=99=E9=81=93=EF=BC=9A
>
> =E8=83=A1=E5=93=B2=E5=AE=81 <adlternative@gmail.com> writes:
>
> > Here I am thinking about the role of this "--deduplicate" is to
> > suppress duplicate filenames rather than duplicate entries. Do you
> > think I should modify this sentence?
> >
> >> > OPT_BOOL(0,"deduplicate",&skipping_duplicates,N_("suppress duplicate=
 entries")),
>
> I see no strong need to.  One set of output entries from "ls-files"
> may say
>
>     $ git ls-files -u
>     100644 536e55524db72bd2acf175208aef4f3dfc148d41 1   COPYING
>     100644 536e55524db72bd2acf175208aef4f3dfc148d43 3   COPYING
>
> and these three "entries" are not duplicates.  Another set of output
> entries may say
>
>     $ git ls-files COPYING
>     COPYING
>     COPYING
>     COPYING
>
> and these output entries are duplicates.  If you deduplicate the
> latter but not the former, then "suppress duplicate entries" is
> exactly what you are doing, I would think.
>
> And if you are asked to show entries that would look like this in a
> not-deduplicated form:
>
>     $ git ls-files -u
>     100644 536e55524db72bd2acf175208aef4f3dfc148d41 1   COPYING
>     100644 536e55524db72bd2acf175208aef4f3dfc148d41 1   COPYING
>     100644 536e55524db72bd2acf175208aef4f3dfc148d43 3   COPYING
>
> "suppressing duplicates" would give us the first entry and drop the
> second entry that is identical to the second entry, I would think
> [*1*].
>
> So "duplicate entries" would probably be more correct description of
> what we want to happen than "duplicate filenames".
>
>
> [Footnote]
>
> *1* Multiple "common ancestor" versions at stage #1 for the same
>     path is not an error.  That is how "merge-resolve" expresses
>     criss-cross merge where multiple merge-bases exist.
>
>     Multiple "their" versions at stage #3 for the same path is not
>     an error, and "merge-octopus" should use it to express contents
>     from histories being merged into ours, but the implementation of
>     the octopus strategy does not use this feature of the index.
>
>     Multiple "our" versions at stage #2 by definition should not
>     happen ;-)
