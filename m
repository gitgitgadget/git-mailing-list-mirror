Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C031CD6E40
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 08:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjJKIrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 04:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjJKIrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 04:47:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F589E
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 01:47:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ad810be221so1108003766b.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697014052; x=1697618852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4M0EZ6ubS8G+Tf5b2lTmlqnTsaR1UMW3NSG73yDWeQ=;
        b=DGWNugsvVKo4JzjX46ZDGRESh/+F5o+hxoTMvOizD16Fu2GvFKLgq0aUe7NXrPkQwu
         j93C6bkM74DeqBYusuWQRwPXqmazWxWuLGaVTHgctHp/XEdIIsEZE7gWS2DFzULRJ7Td
         JhI+MUKPOD0gvPvfPXwAtJ7H1VSAoSRjCSTfeKz13Xqs2kAGF8NIbuch8qpfhZ8YoJuV
         x2qIrk3/srcS1B66XyIZhUIBGASaCziTp/609Srh8/8+y4uWHiNpzGxMB6l1C34wM1rX
         UFGxkjSaM3ZuLG2/QAigSn579ROTxASezjvgKUt1q3wegzVTCbUkmyN1pHNZcKsEz0lI
         F/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697014052; x=1697618852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4M0EZ6ubS8G+Tf5b2lTmlqnTsaR1UMW3NSG73yDWeQ=;
        b=nlK+AP5G3ali4GNGl0jb5nb5ISweu9QedwxiED+1Ep3kOJjLv7yBsB8FJxUFApxWdY
         TWLjePHlxclNKjDpUhGpBp/WMYgt2vj1OcMtJOxZuIdTMGvyMS10Q5XlPriR/WpyKMqU
         CCa9PbVGSOl1qrAV/tYFi1Yhgz/m112wGkPtSexx0FR6VESU/tmL62JovhY31P8VaqPV
         30rMbEGazyDcAgwsnj7rPNZlBEHtprNJBLb+7zvifrs/5NsBH0gwdwJ4ju2oj/wuwzdd
         W2WaDDEWkrEGg4rjrswHrKoiJ0S+uCdvnOqyB7iVQAf/DaW7gUajhSQdg8h9CjTn9BpV
         qNUA==
X-Gm-Message-State: AOJu0Yxrs48ELNzevosH/eij20fCtufKtuSZnYFgLtfK41gE7WwmCtnr
        yMfPGnuX4tRYU3aFlZvoBZmCRsU9HGgDuLUXrWvZI84/C/iNVQ==
X-Google-Smtp-Source: AGHT+IEUiqs7CWDUXStIzQfshv4IM2G1HBj5YDKikaOb2smIEU9i4JYDcvII9di8dLVV4aYVxknEFyEOBdgZqkOs+C8=
X-Received: by 2002:a17:906:518f:b0:9a5:c4c0:2d8a with SMTP id
 y15-20020a170906518f00b009a5c4c02d8amr16139486ejk.24.1697014051316; Wed, 11
 Oct 2023 01:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJHH8bHBA4emP2DkDEzcXncT4K5zEN-pCS+7jjer4R1_kkCkFA@mail.gmail.com>
 <CAP8UFD0mMi2JkvqMdf2mfUw2gA0Sog42ks3umMgsG5k_+W75xg@mail.gmail.com>
 <CAJHH8bE4QWR1gCgH5mG8qaa5Dq19L25y3VyRxAc3+PQn93oEbA@mail.gmail.com>
 <CAP8UFD3WzgADiy07uLGpj23r3jrUnYh_Wdsc1N8ZoaAHQPDZag@mail.gmail.com>
 <CAJHH8bEa=xE_xNdbW4rDJQQ9dacAuFQseajdtBmGnZ1bDxZsxQ@mail.gmail.com>
 <CAP8UFD3RV-70RG6H86+7E-ZKrqhfgFRfRQdMc6DLGMXPAEf31Q@mail.gmail.com> <CAJHH8bFLqs7B5UaCFZv+P8yS2zeXLoKoV6YTUB_xFcG8ZLn_WA@mail.gmail.com>
In-Reply-To: <CAJHH8bFLqs7B5UaCFZv+P8yS2zeXLoKoV6YTUB_xFcG8ZLn_WA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 11 Oct 2023 10:47:19 +0200
Message-ID: <CAP8UFD1f2o2mmK1kBug52WE+PXOzhhPCi8y-jELkF2J+VZos5w@mail.gmail.com>
Subject: Re: [Outreachy] Introduction and Interest in Contributing to the Git Community
To:     Isoken Ibizugbe <isokenjune@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Isoken,

On Wed, Oct 11, 2023 at 7:48=E2=80=AFAM Isoken Ibizugbe <isokenjune@gmail.c=
om> wrote:
>
> Hi Christian,
>
> I hope you're doing well. I did some research,

Nice that you did some research and are mentioning it.

However please reply inline instead of top-posting (see
https://en.wikipedia.org/wiki/Posting_style). On
https://git.github.io/General-Microproject-Information/ there is a
section called "Some conventions and tips" which has a "Reply inline"
subsection about this.

> but unfortunately, I
> couldn't find any clear documentation stating that setup tests should
> be renamed.

Ok, so it's indeed better to find something else to work on.

> However, I did find another issue that I think I could
> work on - 'Amend error messages and prompts of various (sub)commands
> #635'. Should I go on with it?

Yeah, I think it's a good idea to work on this. See this discussion
thread where we give advice to Naomi about improving error messages as
microproject:

https://lore.kernel.org/git/CACS=3DG2zsJxP+NWuosZyrFGctJptHNYTrULErRo_Ns41K=
eMuMqA@mail.gmail.com/#r

Thanks,
Christian.
