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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE35C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7575C6523A
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCIRWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhCIRWa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 12:22:30 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45623C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 09:22:30 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id y131so12890329oia.8
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 09:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d0P2Qlez7S9a2qpaCCv1l8ZnxSAZe6xoW+NV09hLDV4=;
        b=tNcHPmC+TEaBD/W5NWh6tAOQKAQO1YTcJwFD2/vQy2U2SMQPoO3zE6MPaJg7HqhNyV
         bfrajX8+QFAfLRu2+XZG1oY3SCWx6hpamq7by11saReYuevOZGgFMjYDnj8p8CLLBu1q
         plJ8owCZWlVrxq9+bZuYCi7wqmIf/6yt7vT+j+HhS9rGeF4AclP2luuwL3EVXruW7OLh
         LsEtToKoLHBnl/AH4OvqmWZK60+3r136enfmIvKV9C797AHvfAw/qlNdsGIVE+3zx+39
         lYyybQ7Bnri6TfNsmh3/yd+NHNiAtkaWoGo3dgO6uZvoegZm6tA9p+oesH6tCJyMjX07
         xtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d0P2Qlez7S9a2qpaCCv1l8ZnxSAZe6xoW+NV09hLDV4=;
        b=aMyDN83aozD4i68FPf/3Z7WQ2/pAwB4L6kP4NWbmAGC1SwU+S3DFNTVad9NyH8wPnh
         ynZ1D4gXF+jWpPBh8K66nPvA1jBxBkMQbMHvh8EEfOgN0Vh9jZBJXcSQkoCwDcX2h4f9
         2i+PjNp5jLcgfTGyEgDVZMPsE5yTr+wI2hJRsO4f6DrFimGSNVjzrCGauSZ00ex9EkL7
         AT5XM6CCko95ySq1Sga7Nd9OiTvMt5xH3TsYicH9VWfrYVqmZufdSuWXeFkhCvzmZeMQ
         WwLthGjbDYiD5UWRDvMM/zlALGmKCHjDt0VDc3XUvpYkNMsxQp7amdeTPSIc3NKIqEAl
         H4jw==
X-Gm-Message-State: AOAM533VcfCz0Gs7DKG7KPFK9XOhMjVDwdM6kXFMDQyQUY1EK5RZ4YIR
        nO/YVYt1y9iFz+Ei9Czx91HMXaqRVGdszVi4IU8=
X-Google-Smtp-Source: ABdhPJxwHwGM2BWlROdNnJ5+FhRqrapGCKVoPsrLgbX2lWJOM9NqJJS1J8KgpTolcpUTxpInoMNvzKzeFjoX0fBNXw8=
X-Received: by 2002:aca:4fc1:: with SMTP id d184mr3727476oib.31.1615310549722;
 Tue, 09 Mar 2021 09:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-17-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-17-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 09:22:18 -0800
Message-ID: <CABPp-BFvjHZWebkAHOYcLDZK77tKULXFhJc25rXB52C4GMRLSw@mail.gmail.com>
Subject: Re: [PATCH 16/30] merge-ort: correct reference to test in 62fdec17a11
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Fix a comment added in 62fdec17a11 (merge-ort: flesh out
> implementation of handle_content_merge(), 2021-01-01).
>
> The test being referred to here was moved from t6036 in
> 919df319555 (Collect merge-related tests to t64xx, 2020-08-10).
>
> It has also had the plural of "mode" in the name ever since being
> introduced in 5d1daf30cce (t6036: add a failed conflict detection
> case: regular files, different modes, 2018-06-30).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  merge-ort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 4375027914c..e54be179bd5 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1079,7 +1079,7 @@ static int handle_content_merge(struct merge_option=
s *opt,
>                 /*
>                  * FIXME: If opt->priv->call_depth && !clean, then we rea=
lly
>                  * should not make result->mode match either a->mode or
> -                * b->mode; that causes t6036 "check conflicting mode for
> +                * b->mode; that causes t6416 "check conflicting modes fo=
r
>                  * regular file" to fail.  It would be best to use some o=
ther
>                  * mode, but we'll confuse all kinds of stuff if we use o=
ne
>                  * where S_ISREG(result->mode) isn't true, and if we use
> --
> 2.31.0.rc0.126.g04f22c5b82

Oops.  Thanks for cleaning this up.
