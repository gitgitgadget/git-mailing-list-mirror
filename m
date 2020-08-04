Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21C2C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 04:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F020E207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 04:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cz8NNU1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgHDE3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgHDE3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 00:29:03 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3B3C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 21:29:02 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id x19so6392399uap.11
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 21:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2yD/A619QWIPDYpGGA8tjbdX4cJHiQg3MmcNSrSgkSw=;
        b=cz8NNU1Po1EuNmdsmKWYaUTQ70ZE5sd6yDAqhx4FJnXBJ76BYv6nVOsjq48LDaLmae
         qLTBvE845HBliheR2hWohh34rFece99oOiYn0xdyoUxYnPKktHDSgZAJRT53nGwgPH+B
         jtiMVSbilPc/twTKALbinIGDH5bdOZJS9K1ZG1p28QXsUVABCDsfYJLaq0usVipf1Xf0
         EEDBBrhMDFYmvPRE3CoMtaQ3OSRPGRftxvJQdHFUy9vQTC8To5aSunKpqmvH2v/U7TWn
         YtvPKKE1c+UOzKneyhCCdrCHM3Mn+9kKmEZGbLbMIsAy9sfk26qR00HKSX2lS9ho1kFa
         257g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yD/A619QWIPDYpGGA8tjbdX4cJHiQg3MmcNSrSgkSw=;
        b=WpZaTebsF1z/dL/S8SKWLyr9Ge7s3pdvozSVHYPi9ByfAXiX3WjC4j4jUQbgyeXREU
         E04AFwW3MKNQjELtQSyhEbq0joaiKqqG3EOywKVQ1VG3Egvo2JUJkECVuzrS3ZNwY+FP
         li84O/c5F2Hjnf18jMJU/FZE6T4rc1xF7Z6LO8kVwsfz/TW6Cij/ZsD/IV3OPbGjPruz
         hinV1IAHFoa16oXtPfZVl8AWabYLacXOGBKeohl1WF3qSTgzHCAcVvtXR4d9fYEbJ+kP
         cI6Qa2OOZBffq3k0K8k6v6rUwVDNKjq2kzI4gnPsHwXI81PfzJX7sWF65O461F0cV4cr
         ejGA==
X-Gm-Message-State: AOAM530RfEbynoD0CM19TO++96kRMuPmU2w6MYp2oM4umBoMs/WmdPJg
        Nffcbx+jZZ9x9SY4ooPAkC57kC5zhPlkwCafY2A=
X-Google-Smtp-Source: ABdhPJw2BTaHwYqI5dFJg02URChCEspDYNT9K4LGSsLS/sBgM9bnrISexwE5Poeq/Uah4nKL6kmSLPvrmKtcDOY/JpM=
X-Received: by 2002:ab0:2ea2:: with SMTP id y2mr13253616uay.15.1596515341577;
 Mon, 03 Aug 2020 21:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200803053612.50095-1-sunshine@sunshineco.com> <20200804005535.5126-1-sunshine@sunshineco.com>
In-Reply-To: <20200804005535.5126-1-sunshine@sunshineco.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 4 Aug 2020 06:28:49 +0200
Message-ID: <CAN0heSpO4ocUTv2BSAOkRsuEX59V7phKn1=Y-PU2qq0POhp1Rg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] git-worktree documentation cleanups
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 4 Aug 2020 at 02:56, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> This is a re-roll of [1] which fixes some problems I ran across in the
> git-worktree documentation while working on another worktree-related
> topic.

Thanks for this update.

> Eric Sunshine (5):
>   git-worktree.txt: employ fixed-width typeface consistently
>   git-worktree.txt: consistently use term "working tree"
>   git-worktree.txt: fix minor grammatical issues
>   git-worktree.txt: make start of new sentence more obvious
>   git-wortkree.txt: link to man pages when citing other Git commands

s/wortkree/worktree/ in the subject of the final, new patch.

I agree with all changes since v1, except ...

>  CONFIGURATION FILE
>  ------------------
> -By default, the repository "config" file is shared across all working
> +By default, the repository `config` file is shared across all working
>  trees. If the config variables `core.bare` or `core.worktree` are

I don't think this is a filename (in which case it would have been
`.gitconfig?) but rather some sort of colloquial short form for
'configuration file', thus '"config" file'. So I could see the double
quotes remain or being dropped, but I was surprised to see them
converted like this. But maybe you have a good reason, in which case I'm
sure it's good.

Martin
