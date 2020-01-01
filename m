Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47250C2D0DC
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 08:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07968206E0
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 08:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuNgBO9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgAAIxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 03:53:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40087 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAIxs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 03:53:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id c17so29515082qkg.7
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 00:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uirjHtXzjzDDb94E+dJkn/KkHwYn9jlynoqROtuImUA=;
        b=fuNgBO9+kLVVh52YyCoh2BJVsYm57oz2Y9h4miuXfVTjDTxKaudfBQNhm6CjJmjJnA
         XVSA5HfPgG1zbJyIVXXrhblwzAqVQ8gmKKHpjr4Y+6k1pd2N+70KWqGBGa8Ne1kaOcp/
         xTfDZjrcxNxXC5m68n5YUF6Em3HhgK/53hMDtfw6uqDUN0JO3CeUvnVFLNStb39e7LkF
         kXA1r+8fSLw1XaIVLhg7Fws3VdC1OOmdV0Khl4PXsTU/0NsuBr3kLSETCw/GZUtkp7+X
         QrfydQO2Z9PvMsZ+7faDV2Xq5EX81UHgdUJfIvQQclDyrsI/hCRzFm6ISBy6aFSvXRcx
         HdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uirjHtXzjzDDb94E+dJkn/KkHwYn9jlynoqROtuImUA=;
        b=dp4jvdFi+THZ/UHIKxFguqWSoEC9P56fIghGAZWxKw+Hl6D4x7WB5BsdXyyZnw1w6H
         7Zc8WACD/s4RNwqdDUgzRQdaJ8MXBP43NWP6sQgkYOuSf6Oa7Ej+unPGJxAmSZL5tHXY
         uVWvk/AkRIc9+EHrgLsJ4z/MzlvGrcLapxDL2c893G7w5kaJf2fL36xsnnKjaoDfAxxw
         hIlPS8Rw3xyXRdVkknQF/XoX2AfjpiNY+EmRG7N8UuRdp5OiPFTrHapmjHoWV6p2IMvu
         PwM5iXYnishdLNL4PF5zQSaDytu/Ode+m1kxxKOoCStv7iq/JBOTQJy78VodVLCosuzP
         A2XQ==
X-Gm-Message-State: APjAAAUC70A5rLm7/8B6zdskKYqyY2SX/TuMT7SniItKj8xIxB70uzvP
        SAfM3onu6ByIdpPnaf3dJu+aVcJV
X-Google-Smtp-Source: APXvYqydCpT6OVDqO1s/2yM/KIAzIezi2tYUxpw/t7Sizt9njldPoKUbCCBh9dQxgDJIhd4iBbDaHA==
X-Received: by 2002:a37:a042:: with SMTP id j63mr61188540qke.156.1577868827654;
        Wed, 01 Jan 2020 00:53:47 -0800 (PST)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id m68sm13723649qke.17.2020.01.01.00.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 00:53:47 -0800 (PST)
Date:   Wed, 1 Jan 2020 03:53:45 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 16/16] t4124: let sed open its own files
Message-ID: <20200101085345.GD5152@generichostname>
References: <cover.1577454401.git.liu.denton@gmail.com>
 <54315fecfe373d8020f2172b9b43e02c0dae137d.1577454401.git.liu.denton@gmail.com>
 <868smt2zqh.fsf@gmail.com>
 <xmqqfth1fl72.fsf@gitster-ct.c.googlers.com>
 <20200101082443.GB5152@generichostname>
 <CAPig+cQWgH2MPZWZm1iL20at7BWN7-0p2=ogf8pHjGKvHDLL6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQWgH2MPZWZm1iL20at7BWN7-0p2=ogf8pHjGKvHDLL6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, Jan 01, 2020 at 03:33:59AM -0500, Eric Sunshine wrote:
> (In fact, after reviewing this series -- and its
> predecessors -- I was strongly considering asking you to limit these
> cleanup series to 10 or fewer patches rather than 16, precisely due to
> feeling reviewer fatigue.)

Will do. You've been unbelievably helpful as the primary reviewer for
these cleanup series and I'd like to make sure that I don't cause you to
burn out.

Thanks for your patience,

Denton
