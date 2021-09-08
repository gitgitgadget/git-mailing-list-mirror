Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1556C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0C861139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbhIHBWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhIHBWo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:22:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3839DC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:21:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t19so717030ejr.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UkrZx1MyjUuRNSIuX5JvfQkfRfwLJViMi7/99QgbU10=;
        b=nTj82umLHc99H7bjUI25f+C8VnuEpzCG37UNcGItlDtjxbSmK5ep8Bf6Ck2OSefztq
         lcBacABMhc2X3lOeRV2ihUpy2SYoPbGO7hL4iKj/Lnv42GExtbAAXkPc1ZeSz8dLT9Rk
         QATo6nUc1OeODy78UCzsGws8C0AwUCxgP42CgX3UBEHUJjFNuDL2s94RYfC5UeSFcXiD
         9wq4ksPvtCznnz+4OisAi0tle4oZuBR2FuvFiOg8UApWy3poC9/QjzwPfIFWXoq6y7/D
         xVNgUp0P5RTCxgRuMZSgXMpivsqGUY+2XN9G6pvue/fFonGWSsn/F2+awi5sqUD2ETRQ
         QwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UkrZx1MyjUuRNSIuX5JvfQkfRfwLJViMi7/99QgbU10=;
        b=MkcR9H+BsjLD7AEeGfumumDG6HJaeKMXcOLnSObwUqm0xla5k9Kt1mhyzfNSYpnSu5
         MD/OXgRIzXZtm0TYpMXk1OxwgConvU2eSmdclwSL2kG9UPnU+JIwBYEO0HE8E+VlX+4F
         Vjvc2VeEcTwLWd6jTqs6qSDD6f3vpZnxX1AuziHVW9FK4nuR1NA5VOzuLzDj6P2ccZuT
         cTa1DjnQyDn8D3e32/e1V8DPD+opWUWhyXAqhuTLcZ+YJX4VPnyXciWAKZ9OX21TJoiB
         pLaYM7t2+I/oAJoBr/ejOn6iArhJhWegCoUcesWhsMh2ootnghCoKt6ZhSFFdJ57+XJB
         Xm0w==
X-Gm-Message-State: AOAM530oaM5HBMwbUgdJsqn4YYUMbEaJKSYQyXnWpmCENILWXwh5ruM6
        BOFa+FqZAIwp3L7aUIgpjidCvRRxN97cvA==
X-Google-Smtp-Source: ABdhPJwTfRMPZds+AcghRvfdsDCeb7EhQxxj0GG6AO29cEQNt31jYUiXoThN+jgi7emGZ4fkJj+WKQ==
X-Received: by 2002:a17:906:840f:: with SMTP id n15mr1360126ejx.460.1631064095583;
        Tue, 07 Sep 2021 18:21:35 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cz15sm281003edb.50.2021.09.07.18.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:21:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] pack-write: rename *.idx file into place last
 (really!)
Date:   Wed, 08 Sep 2021 03:14:12 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
 <patch-v2-4.4-70f4a9767d-20210908T003631Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <patch-v2-4.4-70f4a9767d-20210908T003631Z-avarab@gmail.com>
Message-ID: <87lf47kgkh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Follow-up a preceding commit (pack-write.c: rename `.idx` file into
> place last, 2021-08-16)[1] and rename the *.idx file in-place after we
> write the *.bitmap. The preceding commit fixed the issue of *.idx
> being written before *.rev files, but did not do so for *.idx files.
>
> See 7cc8f971085 (pack-objects: implement bitmap writing, 2013-12-21)
> for commentary at the time when *.bitmap was implemented about how
> those files are written out, nothing in that commit contradicts what's
> being done here.
>
> Note that the referenced earlier commit[1] is overly optimistic about
> "clos[ing the] race", i.e. yes we'll now write the files in the right
> order, but we might still race due to our sloppy use of fsync(). See
> the thread at [2] for a rabbit hole of various discussions about
> filesystem races in the face of doing and not doing fsync() (and if
> doing fsync(), not doing it properly).

Actually I think it's a bit worse than that, we will unconditionally
fsync() the *.pack we write out, but in stage_tmp_packfiles() (the
behavior pre-dates both this series and its parent, I just think my
stage_tmp_packfiles() is easier to follow) we'll not write the *.idx
file with fsync() since we won't pass WRITE_IDX_VERIFY.

The same goes for *.rev (which oddly makes its fsync() conditional on
WRITE_IDX_VERIFY), but not *.bitmap, which fsyncs unconditionally just
like *.pack does.

And then of course we'll do all these in-place renames but nothing
fsyncs the fd of the directory, so the metadata and new names being
committed to disk & visible to other processes is anyone's guess.

But not only is that metadata commit not made, but due to the
inconsistent fsync() we might end up with an *.idx that's partial and
renamed in-place.

In any case, any such issues pre-date this series and the series by
Taylor it depends on, just adding some #leftoverbits for future fsync()
fixes since I spent time looking into it.
