Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681B6C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 10:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485EA60FC1
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 10:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbhHZK7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 06:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241761AbhHZK7O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 06:59:14 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB6C0613C1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 03:58:26 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id b30so1734887vsj.3
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=60scOPuXNvu+wkczs0DNHpb4Nagd7aOb30Euu8SAuHY=;
        b=HNsOyrXP8NCsuoPgmo8+Wv9NXEqNz/gqYbC5uy3r3kLlrLlbD43AniZYjBa/PhhBQK
         cr8nIKpaNGtUINk/tk/nDaGgNonMFZ/9QPXpkxU0MClF/7aFFfEZs5aDxxSZM//XhbLD
         kktIlqPgqjnKrUoYjj08/KhWFO4TC1oY8xoVS4ry7FszL+UcX5qxqCFn154MOYQjsBH1
         EZymv61ewnAy66AdJTgeXRXuWB4yU54PYaSgF6c+NX19+6VeN576fy7tSA5DWkPZfiD6
         8QrEQRJ+YIguReay4nK9bHuag41khngQPCr015k68Mz0hIBRGTQ2EuKi6uZvyURxo+et
         SgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=60scOPuXNvu+wkczs0DNHpb4Nagd7aOb30Euu8SAuHY=;
        b=bldmHPog1r3ZDJ2ht329apnZp/BhpX2W5OxQmca0e0LGkUjzXPqMMPHLhrgFMhcLOJ
         kN+IWfaLEBvKY5dErCMkH/qYZLXRg5iIQmj6wJDQIpJ6CQcSfCLR3ZHa7F58U1xF7qXT
         fmOajcw8xHvr2b0AwLpq1o0VXNavsDKILrfIO4t5s30zzpJuot2Z2MU+m+5EbPUrr3Sg
         NsJEPBh2H7/yYg68dCEKk7smxh5YQX7xryatri6pY6MtLEysdDmb5QK+Ro3htOfSREwK
         Koilr+v65Cs5CVSNy+hku0YfWrwi9679n2OCYPEPTywF7bwe/neOXBzP0ew1wwnUkf7e
         B89g==
X-Gm-Message-State: AOAM532xEBmGMmi/i64RRXhe9QcJirtUXqqLdEs4BCcdrG3d2bwknBf6
        BFY6kBpXsX3OhathytvxFoN/JnvbmcXnBzb6BIG9g5EL
X-Google-Smtp-Source: ABdhPJwMm+ppmHBI0v9l52SkuWG/lftR+5DCRwHzKiPwskNoiaaSp5RGYz96jQuvtCMIrQibt0UmqYJB6bvWDYfO+J8=
X-Received: by 2002:a05:6102:10c7:: with SMTP id t7mr1250237vsr.44.1629975505974;
 Thu, 26 Aug 2021 03:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210824114135.54810-1-carenas@gmail.com> <5a38e420-eea3-a5f2-38c5-64682bd1ba2e@posteo.de>
 <CAPUEspgmKPhbPGs+ujy7KVJCyNxS95ph2Dwvd7A7cH2J0em20g@mail.gmail.com> <e781b15c-8c59-9827-b052-ebe971b01cad@posteo.de>
In-Reply-To: <e781b15c-8c59-9827-b052-ebe971b01cad@posteo.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 26 Aug 2021 03:58:14 -0700
Message-ID: <CAPUEspga0yGn-u-7poRQZomJPAH43AHyegd=chR_z+3gxRxVdw@mail.gmail.com>
Subject: Re: [RFC PATCH] send-email: allow fixing the cover letter subject
To:     =?UTF-8?Q?Marvin_H=C3=A4user?= <mhaeuser@posteo.de>
Cc:     git@vger.kernel.org, tr@thomasrast.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 11:31 PM Marvin H=C3=A4user <mhaeuser@posteo.de> wr=
ote:
> On 24/08/2021 18:11, Carlo Arenas wrote:
> > On Tue, Aug 24, 2021 at 8:19 AM Marvin H=C3=A4user <mhaeuser@posteo.de>=
 wrote:
> >> On 24/08/2021 13:41, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> >>> @@ -1719,7 +1719,6 @@ sub process_file {
> >>>        @xh =3D ();
> >>>        my $input_format =3D undef;
> >>>        my @header =3D ();
> >>> -     $subject =3D $initial_subject;
> Can we somehow agree on something? Because I'd like to submit my patch as=
ap.

I think you are correct, and from a flow point of view it should be
reset there with the rest.
Adding something to the commit message to explain it might help, and
the documentation path
I suggested (or something better) might be worth squashing to better
explain why the last test case that resets in-reply-to headers is
correct.

Carlo
