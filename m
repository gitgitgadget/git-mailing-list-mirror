Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC65AC433E0
	for <git@archiver.kernel.org>; Sat, 23 May 2020 23:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87FC207FB
	for <git@archiver.kernel.org>; Sat, 23 May 2020 23:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G321YVzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbgEWXFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 19:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388010AbgEWXFb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 19:05:31 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47C4C061A0E
        for <git@vger.kernel.org>; Sat, 23 May 2020 16:05:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b190so6919168pfg.6
        for <git@vger.kernel.org>; Sat, 23 May 2020 16:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ToDnEe0PvDL7y5vjjI1bBeUj79faSN4akz50pZJUQBI=;
        b=G321YVzy2PIyC+ATAGz4erklc07OObeGCw5Gbz/BnH2ZYT/s0qIi+4vbmu4/Y/suUF
         uJ9qX3KRqfhU9tyQzvl9zA9yodccshZC+hswH/HcEouWxl45wd+SEFDEGXEuxXEfPPWG
         avqZfMSBEdoW3y1f+5K9G/dIwt4TKO5FWiAv/5gt3ux3FkzHBhggx1XMeKdo7JsVDc55
         hXHRj7fSWDJyAn8s58XKRwzx5d0sTe+Ci1ZrRmNe1fuwRsatUOIR03lE0GXxWzJkuXE7
         w3wY222dQSRJZTVtp+FGg8LsKn6DWBL5r6gtp3U/7l1zWtyu2D9SONfhhs5y1dySoLb0
         K9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ToDnEe0PvDL7y5vjjI1bBeUj79faSN4akz50pZJUQBI=;
        b=VMyNq9u1VZzCL1UxBC2j6wqak8BB+jlfJYKnR3sfBO95/BtUa2sBu2H/OGBiviNBvn
         RI8ABJjwEeqNHSNIUbgIUk9RTfm3FStIRsnTTDqRaK4FFII1fMwJsiHbVbCIZejGhBJU
         UlFSf/5jH5c1JZtumsN5OLH8UsOI4hsGkGl8OOsLSczKhRO8Ilnr/aLvN59OyCP7XiyB
         tEnB5oeWH+Y1SukbaiDTzzg9zy3SE1VEVzFaeSFFQtsYduGZi1RPVkXSL0z11yPJ02XG
         Djbt+hyAyeonCK8o+uQ5+D81WQZZV6Nl29xFhD15gfqYh4cOAwx+lyFiDKUoZTUIchX+
         Q2Hw==
X-Gm-Message-State: AOAM533Mf6Ve7X0je1e3Ujb7SK3ga9VH0Qffm9f98RvhVBDW+rA19Wpk
        lK0eBoY5W5uyziOq5Gf0Xhs=
X-Google-Smtp-Source: ABdhPJxxqdpSnUphpstIPE4pxjbKdGXu0d5BV939q6X9EUIti6XCt01qXAJLpjjEy/E8f2y6s7PLzQ==
X-Received: by 2002:aa7:9e52:: with SMTP id z18mr10410624pfq.57.1590275129073;
        Sat, 23 May 2020 16:05:29 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id m3sm9140854pjs.17.2020.05.23.16.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 16:05:28 -0700 (PDT)
Date:   Sun, 24 May 2020 06:05:26 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] rebase -i: support --ignore-date
Message-ID: <20200523230526.GA1981@danh.dev>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200521101455.63484-1-phillip.wood123@gmail.com>
 <20200521101455.63484-5-phillip.wood123@gmail.com>
 <20200523123025.GA20683@danh.dev>
 <bc6bc4d4-79cb-f788-deca-41a3735fcaae@gmail.com>
 <20200523155203.GA10163@danh.dev>
 <0cf07e92-25f2-ae0f-6f44-c2cd9e9f4851@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cf07e92-25f2-ae0f-6f44-c2cd9e9f4851@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 2020-05-23 19:50:40+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
> The part of my reply you've cut said "I've checked the log invocations in
> the other tests and I think they're all OK." So it is just the one that you
> pointed out that needs to be fixed up (the others without -1 are all
> checking the result of rebase --root). I'm happy to re-roll if Junio wants -
> lets wait and see what he says.

Ah, I was thinking "they're all OK" meant that part can be left as-is,
and the only part need to change is the --pretty=format.

Sorry for the noise, (and my bad in reading).

-- 
Danh
