Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B56C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE02360F48
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbhITHoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbhITHn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 03:43:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FA0C061762
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:42:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c22so57677487edn.12
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5DqutTXGBKSs49O4x5eSG/wL5vTcgMQsNldrogBtWAs=;
        b=EZvBUFLv0mYYjtJ4+4k+sCuy5ZbxOZQCiVjAiZPhws1kj7mDJwuSncD8ADzzSLgfoT
         42p5ZNewWccV7giSzsWCRXJCchcspoEPLRfUFJHHQnrxuzom8lwuBIWnaG+7Fd/txlJ7
         oXo2+w2wRsjUsjQjFKUrNWAV8Uis+wZT8SY5mbIyTwNr0Fnl9tBl6TO7cjxbWOYYjOeE
         ea7mmBHkqO6DelfmyQS5Mdh+oNAUSpBgyE4J+0Z+gK7Xb1CbwFRVdva7WJx2SH6yFGTN
         BjbVevsxPNmfggJykmPtt0veZ9mDbKD4anG7P435TzjFJR/nhG01aFJOxt1yfU/sVjI6
         cRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5DqutTXGBKSs49O4x5eSG/wL5vTcgMQsNldrogBtWAs=;
        b=kuP17k0Aq5WKHjUB5yxcwx7vuU3pIIajahqRFHdH8khMogX09D6sIRvz5EgV1q2iPM
         AvKATeEHuquDo608MugtgvqwBf3otlhm9l6JPvn8Ld7t4u9tYBWsbEu4jdUNQfv4Pyh+
         f5ezqsY4rLQviAryaMoqRBtHcVtG+/25i8KhMjsKpnb5yR+PUMBNMnQPVQGR1En5rww0
         YGXhj1uarbjjTsBHtt30xHAPaiojwsCXiFKGmHdQmrVzXVc934mtFDuz33MiSiicYM23
         aMJjX4XGzXHyPp6d9TAv71GvzC6ihqT79bGDyqtxgf9uy1+7bz3rNZuTqAMNOSTrL/+5
         jTAg==
X-Gm-Message-State: AOAM530ZgGU4zOxKV2cIRF5lcqVZCfhJTHcr2NWkkg35iwBYdxgrE59w
        On4BB8hIKsNSoyJN1u+3hGxh2kBoIceVFJ7pJdBhiDJvu2XOStjh
X-Google-Smtp-Source: ABdhPJzxQyAcTK0OXGOy0lVcNCFaFz4ZSMj1oStjapNJ5Cp5+64mtGvBNR73m0LzDUtzQ6vhRIB/+D90EG6UlPnftTs=
X-Received: by 2002:a50:ab18:: with SMTP id s24mr27992324edc.88.1632123748758;
 Mon, 20 Sep 2021 00:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net> <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
 <YTTARcEvpXWSDfYW@coredump.intra.peff.net> <CAOLTT8QbdNBSY95bCa+UNJBqsJEEHbnaKfZLzvN2Qzd-Np8Lqg@mail.gmail.com>
 <YTeo/dCFfpAIfo3K@coredump.intra.peff.net> <CAOLTT8Ru-Zhmo5j=jNjWexrahT0qAO5zEMW09XT00-TCca-SkA@mail.gmail.com>
 <YTtrF8C0mmT6kBJT@coredump.intra.peff.net> <CAOLTT8RPzutEQxbr9cu=ze7rgPKvG6Ghu4b2Bi47eStY1TqGzQ@mail.gmail.com>
 <CAOLTT8SYxUbfG7YvAs03nwRdee8JfNPUYCCpKcFoAgBjB2oqLw@mail.gmail.com> <YUO63qy2/5wibY4/@coredump.intra.peff.net>
In-Reply-To: <YUO63qy2/5wibY4/@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 20 Sep 2021 15:42:17 +0800
Message-ID: <CAOLTT8QxZ3rMwrgD3LkqAUb98gdyVC28=b4SQ5xKwGteFvwOFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=8817=E6=97=A5=E5=91=
=A8=E4=BA=94 =E4=B8=8A=E5=8D=885:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 15, 2021 at 10:23:43PM +0800, ZheNing Hu wrote:
>
> > ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:27=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > > So yes, it's complicated. And it must be explained to the user that
> > > > "%(refname)" behaves slightly differently with "git tag --verify", =
but
> > > > that is unavoidable if we do not want to break scripts (it _already=
_
> > > > behaves slightly differently, and we just never told anyone).
> > > >
> >
> > $ git tag --verify --format=3D'verify: %(refname) %(symref)' annotated =
symref
> > verify: annotated
> > verify: symref
> > $ git tag --verify --format=3D'verify: %(refname) %(symref)'
> > refs/tags/annotated refs/tags/symref
> > error: tag 'refs/tags/annotated' not found.
> > error: tag 'refs/tags/symref' not found.
>
> This is expected. When you provide a tag name on the command line of
> "git tag" it is assumed to be a non-qualified name in refs/tags/ (and
> ditto for git-branch and refs/heads/). It is tempting to try to be
> friendly and accept fully-qualified refs there, but it would create
> ambiguities (e.g., you could really have refs/tags/refs/tags/foo as a
> ref).
>

Yeah, maybe you are right, for git tag --verify, there may have ambiguities=
.
But for git verify-tag, if we have tags like "refs/tags/refs/tags/foo" and
"refs/tags/foo":

$ git verify-tag --format=3D'verify: %(refname) %(symref)' refs/tags/foo
warning: refname 'refs/tags/foo' is ambiguous.

We see the ambiguities too here.

> I think we can ignore that for our purposes here, though. It's a
> question of input from the command-line, and we focus on just the output
> that we produce.
>

Yeah, but using different functions (read_ref_full(), get_oid()) will
affect what
kind of input we can provide.

> > $ git verify-tag --format=3D'verify: %(refname) %(symref)' annotated
> > symref
> > verify: annotated
> > verify: symref
> > $ git verify-tag --format=3D'verify: %(refname) %(symref)'
> > refs/tags/annotated refs/tags/symref
> > verify: refs/tags/annotated
> > verify: refs/tags/symref
> >
> > As we can see, there is a slight difference between git tag --verify an=
d
> > git verify-tag: git tag --verify can not handle refs' fullname refs/tag=
s/*
> > (because read_ref_full() | read_ref() can't handle them). So, as a stan=
dard,
> > which characteristics should we keep?
>
> Whereas are you notice here, verify-tag takes any name (which could be
> fully qualified), and uses it as-is. In fact, it might not even be a ref
> at all! You can say "git verify-tag c06b72d02" if you want to. And as a
> plumbing tool, we should make sure this continues to work. For example,
> careful scripts may resolve a ref into an object, and want to continue
> talking about that object without worrying about the ref being changed
> simultaneously.
>

Yes, this feature is very bad. %(refname) seems to do the %(objectname)
work.


> But it also creates a weirdness for "git verify-tag --format". We do not
> necessarily even have a ref to show. So IMHO the feature is somewhat
> mis-designed in the first place. But we should probably continue to
> support it as best we can.
>
> The best I can come up with is:
>
>   - when we resolve the name, if it was a ref, we should record that.
>     I think this is hard to do now. It would probably require
>     get_oid_with_context() learning to report on the results it got from
>     dwim_ref().
>
>   - if we have a refname, then feed it to pretty_print_ref() as a
>     fully-qualified name. And pass whatever "default lstrip=3D2" magic we
>     come up with for "git tag --verify". That would mean that "git
>     verify-tag --format=3D%(refname) v2.33.0" would behave the same befor=
e
>     and after.
>
>   - if we didn't get a refname, then...I guess continue to pass the name
>     the user gave us into pretty_print_ref()? That would keep "git
>     verify-tag --format=3D%(refname) c06b72d02" working as it does today.
>
> The alternative is to do none of those things, and just document that
> "verify-tag" is weird:
>
>   - its %(refname) reports whatever you gave it, whether it is a ref or
>     not
>
>   - some advanced format placeholders like %(symref) may not work if you
>     don't pass a fully-qualified ref
>
> -Peff

This is my solution according to your above suggection:
https://lore.kernel.org/git/pull.1042.git.1632123476.gitgitgadget@gmail.com=
/

Thanks.
--
ZheNing Hu
