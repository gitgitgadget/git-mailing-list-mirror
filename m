Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB2AC433FE
	for <git@archiver.kernel.org>; Mon,  9 May 2022 22:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiEIW0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 18:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiEIW0U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 18:26:20 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A11215E601
        for <git@vger.kernel.org>; Mon,  9 May 2022 15:22:25 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id kl21so11494629qvb.9
        for <git@vger.kernel.org>; Mon, 09 May 2022 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=27PmDnUpOu+KdGpp3BWaYqqoHsdya6uHHeGP0/Z8cZw=;
        b=S402PckPYv8RwTKS01otRr2FU703VUxwOFlyBLScv2XlxV/zVJpiSADadBn2g3Vvka
         w/DbTODgu8fgW++sp9uROG192lBaH3KnIRJDxLYOXQjbLRtvv5PYzlaOR75sB8bemRM7
         EMr/T3i/4Su59Qc54XMJXW/D2RaZX2adTtKcsES0VoiazCvR3FJeNel9coZVu9KLRHRS
         8l+471tfU/GaZYG3/RbayFFj6685ZEKQT4D4rFH8/wBcrmLGireykK0Z8EFMvpGHcQiZ
         7z1WHsA4U+CnJMM9qm9nqYNfxFWhSbmEXc7JWCnaqgb6x0Dqx6je+tcH5SWXiFyf9Vh5
         2kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=27PmDnUpOu+KdGpp3BWaYqqoHsdya6uHHeGP0/Z8cZw=;
        b=JfHPweEyz8s1+mNfAcLJA9C27zVCo4T2S6aBkSgf/6+j/bEJkQMH5TL5++l1bVdDfT
         jyKh9LE0oIpY8fItD3Dr3ZqWj4HXmkdM6326X9kFItSZeJ819YZRh6xVJ2iKbuttYI23
         Bohqo1L2DsIDwoa47q+Ai5udDx6VPkozEiF3h2Rm1CxON04sTwE7pnqNdTFp4umMZHJR
         qqVMRcxr204FCgLUYjsMa0D/LqDsvXW39EhDDoXf3FY8PXGUj7HyXSnHUSiwTb4IxwKl
         7GZgeDOnKtUbYYoOC1US2HQDDUwTq4e1W4p1LdubYgtwJapXNapviE3K9PE68r2qPi+W
         qYFA==
X-Gm-Message-State: AOAM532tzFQppnbXk6R/Zc6cM+dq25q8QW2Tx1qbTbjgxFT4lMyS84eC
        jH8KQixGqBjxonaFsCVUjVupDQ==
X-Google-Smtp-Source: ABdhPJy3bsilYfpj2cONUVVY9uhSHbrHMYeCrakjAc+qgoQ7mO3OksFzIfLRyTMxZBL/sbf6hWblUw==
X-Received: by 2002:ad4:5dc3:0:b0:45a:cde5:f31c with SMTP id m3-20020ad45dc3000000b0045acde5f31cmr15631931qvh.90.1652134944333;
        Mon, 09 May 2022 15:22:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g15-20020ac87d0f000000b002f3e127be41sm1248184qtb.20.2022.05.09.15.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:22:23 -0700 (PDT)
Date:   Mon, 9 May 2022 18:22:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
Message-ID: <YnmUH5MKeKiafn94@nand.local>
References: <Ynk0mADTSJU/xVUd@nand.local>
 <20220509172157.28593-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509172157.28593-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 09, 2022 at 10:51:57PM +0530, Abhradeep Chakraborty wrote:
> Taylor Blau <me@ttaylorr.com> wrote:
>
> > But there was a good question raised by Phillip in
> >
> >     https://lore.kernel.org/git/ab047b4b-6037-af78-1af6-ad35ac6d7c90@iee.email/
> >
> > that I didn't see addressed in your response, which was "why not put
> > this behind a new `--show-partial-filter` option"?
>
> Actually, I addressed it[1] -

Ah, sorry that I missed it! I think Phillipe's GGG issue is probably a
good signal that we are not making this information as discoverable to
users as we could be.

I share Junio's concern that this change may tempt future contributors
to add more output still to "git remote", but perhaps not. So I'd be OK
with this change as-is.

> [1] https://lore.kernel.org/git/20220501193807.94369-1-chakrabortyabhradeep79@gmail.com/

Thanks,
Taylor
