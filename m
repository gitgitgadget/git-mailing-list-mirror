Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A3C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 22:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbiC2Wm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiC2WmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 18:42:25 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C01232133
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:40:41 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-df02f7e2c9so7877198fac.10
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t1joDGcDq8gbec11UE0HP9M66cLf7cNXJGs6CYqhz2w=;
        b=LdJA5vVX2X8A8s8A5bd7KsAhOb7lzEkQwNhTENAJTSJFd4CLOHRYorY/wHidV4WqOa
         r6mLp5y1Goj8wD1/t/SjMaGJDDh2aOq3c+X/RL87GRZ5NjUOl9buupvXGIYewCw4kiab
         bJoeCqqH8ltv3PglZFM1VTOW8t865DSkW/wD1FbqZMFkZRZm7UTY6mSQN3nYC/SMc/Bd
         SgIU4l1p6O2UKuY4G+kGtWZcKn4Ox2RVaivdIUSQ6Fg9LZCn/qyuXj0Y81qxIWYKQpKK
         Rwu+vwvvKblDn+pw3zeLrYJF1JS0MF7wJK/UlDburJmCtpUn47HYWAaxjePeXOGpM/cj
         SvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t1joDGcDq8gbec11UE0HP9M66cLf7cNXJGs6CYqhz2w=;
        b=E70BSRxgLaT1TGWXBo9KsQrhfE8QH+XxTdx3+IXqCkdOaIFPTekFAf4oCebKl4Wf6L
         e+2Hd0UDDSXiSHX7ACvPhlOnfwTEKTKf0jyNj9yKfg2Uro346wKI3Rob9MzGpgn22taF
         8/fSnh/ivHDfPkPf9Ah2xOWB5jNf4w4xxgTGkVYI68sigXmdpVsFtJDIlTknRPeX8qyg
         FvXdc3TX4asT7I5r7eYXO+t7Nz/x8qRAlcOSSFManzVKjmnHgStCBuVhUxcrgCZE98Yz
         HBEapkMhME2jtVtbUBp0TX66Lx6idLe32GH2feZ+gh7XdFHn6CBDjYQQIdfJV/iwWoLW
         aOKg==
X-Gm-Message-State: AOAM532xuait0SPAHpWDQOzJT2UxIUOoHycmjWFoNUrLIxnail8yLJ5M
        HDowREeuHjx7eFajvhZ2fwGikmUgtOXUx8+3MlJDsw==
X-Google-Smtp-Source: ABdhPJyJ8Xfc3jgjrOV9nIJqkjU3j2T1TgeZ4IKtZmxw72w/k6ATWax7M8kL7Eb+O8koR6kKXUXlvtBWPwO4QgyFGI4=
X-Received: by 2002:a05:6870:d192:b0:de:691:81ad with SMTP id
 a18-20020a056870d19200b000de069181admr819807oac.165.1648593640719; Tue, 29
 Mar 2022 15:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220208235631.732466-1-calvinwan@google.com> <20220328191112.3092139-1-calvinwan@google.com>
 <xmqq35j0ts2j.fsf@gitster.g>
In-Reply-To: <xmqq35j0ts2j.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 29 Mar 2022 15:40:29 -0700
Message-ID: <CAFySSZDs0k-DVfmTQPnrgwhn3f+57rdc0tq-c-kGh5_KJjXx1Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] object-info: add option for retrieving object info
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I seem to have introduced a small bug with the advertisement while I
was making my final changes. Will re-roll later today

On Tue, Mar 29, 2022 at 1:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > Sometimes it is useful to get information about an object without
> > having to download it completely. The server logic has already been
> > implemented as =E2=80=9Ca2ba162cda (object-info: support for retrieving=
 object
> > info, 2021-04-20)=E2=80=9D. This patch implements the client option for=
 it.
> >
> > Add =E2=80=98--object-info=E2=80=99 option to fetch. This option allows=
 the client to
> > make an object-info command request to a server that supports protocol
> > v2. If the server is v2, but does not allow for the object-info
> > command request, the entire object is fetched instead and the relevant
> > information is returned.
> >
> > Patch 1 is a small refactor. Patch 2 adds a config option for
> > advertisement of object-info.  Patch 3 is the main implementation of
> > fetch object-info.
> >
> > Major changes since v2:
> >  * Added a fallback for servers that do not
> >    allow object-info
> >  * Refactored the fetch object-info code by moving it to fetch_refs in
> >    the vtable rather than having its own function in the vtable. This
> >    allows for the code to easily transition to the fallback if
> >    object-info fails.
> >
> > Calvin Wan (3):
> >   fetch-pack: refactor how packet is written to be more generic
> >   objectinfo.advertise: add config option to advertise object-info
> >   object-info: add option for retrieving object info
> >
> >  Documentation/config/transfer.txt |   4 +
> >  Documentation/fetch-options.txt   |   5 ++
> >  Documentation/git-fetch.txt       |   1 +
> >  builtin/fetch.c                   |  36 +++++++-
> >  fetch-pack.c                      |  66 ++++++++++----
> >  fetch-pack.h                      |   9 ++
> >  protocol-caps.c                   |  11 +++
> >  protocol-caps.h                   |   6 ++
> >  serve.c                           |   2 +-
> >  t/t5583-fetch-object-info.sh      | 138 ++++++++++++++++++++++++++++++
> >  transport-helper.c                |   8 +-
> >  transport-internal.h              |   1 +
> >  transport.c                       |  75 +++++++++++++++-
> >  transport.h                       |   9 ++
> >  14 files changed, 349 insertions(+), 22 deletions(-)
> >  create mode 100755 t/t5583-fetch-object-info.sh
> >
> >
> > base-commit: f01e51a7cfd75131b7266131b1f7540ce0a8e5c1
>
> I am getting the following failures when they are queued on this
> base, or on a more recent tip of 'master/main'.
>
> Test Summary Report
> -------------------
> t5555-http-smart-common.sh (Wstat: 256 Tests: 10 Failed: 1)
>   Failed test:  9
>   Non-zero exit status: 1
> t5583-fetch-object-info.sh (Wstat: 256 Tests: 11 Failed: 1)
>   Failed test:  5
>   Non-zero exit status: 1
> t5701-git-serve.sh        (Wstat: 256 Tests: 20 Failed: 2)
>   Failed tests:  1, 20
>   Non-zero exit status: 1
