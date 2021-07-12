Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F6EC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE8361006
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhGLNaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbhGLN3v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 09:29:51 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4120C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:27:02 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k16so22554856ios.10
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sil3RGcNj5KjgBjOO1i5clsUDBCNatmZewcDVaR95Cc=;
        b=LRVTroe/JysRsV62ekYPdXyFuEzgaMCTDz3mzDue/E0jBr4OKWAlisKCrtmTidrh3q
         ELUtDW4e2Sf6HyvhToS8VLdCWZO6YFI3dbqIYZCRY2MLtrcvTe+B5tHnIx9A/ERhREHD
         U1X6Ox/ETTRbDy+WBOKCgaRNvV3VdkHKQOGoVcOnOXV/v7Icf4EIqZvRZeUttli9wBus
         PbqHMfTqgq8z2zQMZr9FUrtxr9Wu6refOMlIgznDWJ3RRDSjdTQybgu4zzw6JlO6wePg
         kE5LeZnBrul6JHt17BdNhh5Vi/WkFusO2ML4mpmTbEORkSMTs530fmO++AeDzlQbDsUu
         Ck6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sil3RGcNj5KjgBjOO1i5clsUDBCNatmZewcDVaR95Cc=;
        b=RA+pUwfrP+9OIOFQjhm3ilXu206QJpGN6xE2+hYh8+anywF3zJylA0XvXy5nPI3r6q
         U/n9JK0FzvnuDNJdpaj1pVEA+1jsYD/8CPeXRuGLaHOr/AuIy7UcBloRIUaleI+66Ez/
         awJrTnHOn+2r0J90hQx5Om51MDMYvbVeSa/w4aC6luUYetJW/disYTfXund77wVD6W4G
         TMMn4+jD8Saj+Qhe8LXuFLd+q2soMNEkkrC5K1VFlNXT5DzHA5NBlo0pe7x7PJqj6u3y
         XLtY4HqRdLwxg7OROzziIfRysnBEl2xCd7B0PCLEmDkeFBdIkYz/gOSejrFPu6AafIHN
         sXPQ==
X-Gm-Message-State: AOAM533hjg1QQMGcKNmJs2brlFgKrpVMP8nTVTRXnD5WLOFS/C8l+1Bj
        xlVf0QPR28NiZ5sSLyhcwwLJePTFQq5eGzgUlGagV/Rc/ldWGiYO
X-Google-Smtp-Source: ABdhPJxtDbiiI3P1I5PjrA+FVjUfPYr95dJT9vaqXri6/VwqeARf39j9PtTpM4H80w5J9CNBxrsgU+wZ4QpWVwBSjb8=
X-Received: by 2002:a02:ccad:: with SMTP id t13mr2466197jap.29.1626096422262;
 Mon, 12 Jul 2021 06:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com> <b6f661d6-d18f-9b26-da64-acad31b07188@iee.email>
In-Reply-To: <b6f661d6-d18f-9b26-da64-acad31b07188@iee.email>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 12 Jul 2021 21:27:12 +0800
Message-ID: <CAOLTT8TEq3Zrms7MTj9onTsqHgqK4NypkzPpRv2Zaze5SMbBsg@mail.gmail.com>
Subject: Re: [PATCH 00/19] [GSOC] cat-file: reuse ref-filter logic
To:     Philip Oakley <philipoakley@iee.email>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> =E4=BA=8E2021=E5=B9=B47=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:02=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On 12/07/2021 12:46, ZheNing Hu via GitGitGadget wrote:
> > This patch series make cat-file reuse ref-filter logic.
> >
> > Change from last version:
> minor nit..
> Not sure if this is a gitgitgadget feature, but would it be possible
> that a version indication be included in future versions of the patch,
> e.g. [PATCH vN 00/19] [GSOC] ?
> --

I think ggg have this [1] , but it is not for the user to control.

[1] https://github.com/gitgitgadget/gitgitgadget/blob/1df3c008552abd1fb788d=
4988e6d3b92f5765369/lib/patch-series.ts#L654

> Philip

Thanks.
--
ZheNing Hu
