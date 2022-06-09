Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E503CC433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 06:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiFIGEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 02:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbiFIGEf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 02:04:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0873137A1B
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 23:04:34 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b7so12459415ljr.6
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 23:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUmNMKglABsFM/3KQnoEB14EqMW938f7Qct17rOmO2M=;
        b=dUOqQyTNjlUPmpvCs6iLN0bcZP8Ous/gQgzy/nVM5tUyQGpUxlRz3TtLnMHeSxRTF/
         nHrWkHJ6FgUlTraVJXIGSTLNmvH284VZF3XtNC9tyT5PEIeOXjAt0s6Rpr5gCkOIyKbT
         6vv1TZ9SKrSTtbGV47zGwDnQmVbvi4TqUFv9cKyTkUtNWUtj9HW48H1lodfM4WPC/fmq
         yNJJ5orC89UY2pjcIFcRIYVyLhXdgQyRW+SHsXoR1WWf8qpu+Cy7U7p9raP7mHhSbkHH
         F1MxjMdUsypO73fV4vw/3EMhiSKighp1xiZDnapOv4XM0mYfEGPaMWqjgPc7cGUmBAHQ
         kf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUmNMKglABsFM/3KQnoEB14EqMW938f7Qct17rOmO2M=;
        b=2XBLsZRRaKbsMxfBe24cRYOGxWylsQFnlwxPfKpKQHsQC2oqRdt478C4iJw/cXBu6g
         AiVuZQaUVsLFNeUEV/u1OrwC7Xbrvj6KlLVW3x11UbzzvYYtv4ZNJiym70EJdXK+GlvZ
         XujaCdbxKtsBBYe+y3QHCxCt5EygwXX5zCbPCpoE1OrT/hCD+RXY6YA8Se2Kn8b/UH9t
         tC3OJGsJsVvStwUuQnodr3ZpJg36caRLcUarb4q5znJ4XjAQA2vSjb5KdB31ldmk5dKp
         H6Hpngx5DdsrQrrZcek7bPFtsNkcQWj4Vn+soptBStnSYxFQeGRtau3Mqj5VPV8eaQU4
         BXhQ==
X-Gm-Message-State: AOAM532ZlPtegbPDJaI7Vi9lm9jcJIX0q4obOpkqOpM2BCMfvi3L820b
        z0O2CFvnSiwlpz26UTXdk9Uedxoz3VhJd9yAR6J12++sJ/bSibJ+OWE=
X-Google-Smtp-Source: ABdhPJwszSc2cpbn6CDxEdhM489I722EFLB82cPw6wCX5PtmDkNkgwEwPOLM1EYUsxfHx2XOcm4hK+pSCPT0TjGkrFw=
X-Received: by 2002:a2e:8686:0:b0:255:8474:f3af with SMTP id
 l6-20020a2e8686000000b002558474f3afmr15232482lji.402.1654754673214; Wed, 08
 Jun 2022 23:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
 <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
 <patch-v13-5.7-0b07b29836b-20220604T095113Z-avarab@gmail.com>
 <xmqqy1y960hq.fsf@gitster.g> <xmqqk09t5zmm.fsf@gitster.g>
In-Reply-To: <xmqqk09t5zmm.fsf@gitster.g>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Thu, 9 Jun 2022 14:04:22 +0800
Message-ID: <CAO0brD2bZ=QomcrbbSfPZ+8pgPmYr6=aM5WsqHWdcJQycJMi+g@mail.gmail.com>
Subject: Re: [PATCH v13 5/7] object-file.c: add "stream_loose_object()" to
 handle large object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 7, 2022 at 4:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I am very tempted to ask why we do not do this to _all_ loose object
> > files.  Instead of running the machinery twice over the data (once to
> > compute the object name, then to compute the contents and write out),
> > if we can produce loose object files of any size with a single pass,
> > wouldn't that be an overall win?
>
> There is a patch later in the series whose proposed log message has
> benchmarks to show that it is slower in general.  It still is
> curious where the slowness comes from and if it is something we can
> tune, though.
>

Compared with getting the whole object buffer, stream_loose_object() uses
limited avail_in buffer and never fill new content until the whole
avail_in has been
deflated. It will generate small avail_in fragments due to the limited
avail_out,
and I think it is precisely because these avail_in fragments generate additional
git_deflate() loops.

In "unpack-objects", we use a buffer size of 8192. Increasing the buffer
can alleviate this problem, but maybe it's not worth it?

> Thanks.
