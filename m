Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8947FC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C8D20936
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PuIU4Jnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbgJSWCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgJSWCS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:02:18 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAD3C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:02:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id n5so2005122ile.7
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9+O//yi2Hxrz5iHjwoZ37wWgYgO4FVpgiaomDrrXdGk=;
        b=PuIU4JnmY16FPtU0en/7359dq7XpJp76U7y5kXderqGpcBDFZf6ExHxue2wJeYwLe0
         ++M1MedO+I0AvV/j4fNebh5rDsACM1XQD1SuSm7VXxxhr6rAc4rlhH+SHg1AOkYZba19
         6z+7Zfw3YP5sIJQRa9c0XtXPY9oBZ7qPfIKBeheB9dm3PnjPZQcqaTdDqZkut82k3FzC
         EfrP7w64VZqNrz/GbBZJIFc1mumMd6XIlhBPA+uDVNP5Nf/KHlRvZQlzALKdrsw8xjQn
         Kog22cJupnh8O/VnH9sGShSXfIuXtPJstZocUtUUPw3GnN5NoeAyE2jzEtzt5ZRWIK5P
         hkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9+O//yi2Hxrz5iHjwoZ37wWgYgO4FVpgiaomDrrXdGk=;
        b=icB6TApv4vYC60M1YMiZvOTsvC+WfgSbsJfSzdCPlb4HdGkhfd/ELtXr33CFBHw9ZC
         SST0wpN8P/V9qhBUgrRcBrfNbQE9pg0iBdvSHRtxN+34t/nDlLvKXap9RA1w9htPAR5G
         pfQdbC7kgJxlOhX1pIJJY1eOmM1+YJ6vjQ0YRamdkcqYTHwF4EAchAnYVNpn3mJbLBBv
         cfDoBd3OrGgJgFehxJoPou8k6wQnY/Q0jBsy1qQ4PixWk3SMqP89uG00y851S5kF6pGD
         +xj5x3RsZptPuFEK3N7HWAr9jNVavukK5IIde7POiDsEpOxsYsXDE50PtQz7AZh54J64
         nBew==
X-Gm-Message-State: AOAM533r7k7km1XvvR4HceTn8hBUXw+uKlPJcVLCh6B+j3J6R4dFD4Pu
        7Mz3S1sPl40TIMoexVNXLUjgLGHKnmlSRWgp
X-Google-Smtp-Source: ABdhPJxYWkOjNvXj/YN4CpfVRPaRYUBH5SayNY0g6pWRQbffgggOCFaAwNLZASQmWjlZ3dXSR6zzWw==
X-Received: by 2002:a92:610:: with SMTP id x16mr1846066ilg.169.1603144937301;
        Mon, 19 Oct 2020 15:02:17 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id 80sm450750ilv.13.2020.10.19.15.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:02:16 -0700 (PDT)
Date:   Mon, 19 Oct 2020 18:02:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Documentation: stylistically normalize references
 to Signed-off-by:
Message-ID: <20201019220214.GB49623@nand.local>
References: <xmqqmu0it6ls.fsf@gitster.c.googlers.com>
 <cover.1603142543.git.bkuhn@sfconservancy.org>
 <37a4932d48c1d36c3c512e9f8c0bcac878de6b76.1603142543.git.bkuhn@sfconservancy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37a4932d48c1d36c3c512e9f8c0bcac878de6b76.1603142543.git.bkuhn@sfconservancy.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bradley,

I think that the 3-patch series that Junio was talking about in [1] is
actually this one [2].

Skimming the differences between the two, this patch of yours doesn't
have an analogue in what Junio sent. But, I think it's worthwhile, so
perhaps it could be applied on top before moving into next (at the time
of writing, this is integrated into 'seen' as 1b98087e0f (Merge
branch 'bk/sob-dco' into jch, 2020-10-19)).

On Mon, Oct 19, 2020 at 02:25:43PM -0700, Bradley M. Kuhn wrote:
> Ted reported during patch review of the previous commit that an old
> typo was present in the git-commit.txt and merge-options.txt.
> Namely, the phrase "Signed-off-by line" was used without either a
> definite nor indefinite article.
>
> [...]
>
> Reported-by: "Theodore Y. Ts'o" <tytso@mit.edu>
> Message-ID: <20201018151315.GJ181507@mit.edu>
> Signed-off-by: Bradley M. Kuhn <bkuhn@sfconservancy.org>

  Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor

[1]: https://lore.kernel.org/git/xmqqmu0it6ls.fsf@gitster.c.googlers.com/
[2]: https://lore.kernel.org/git/20201018194912.2716372-1-gitster@pobox.com/
