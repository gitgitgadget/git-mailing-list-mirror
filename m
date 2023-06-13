Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FC2EB64D8
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 23:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbjFMXLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 19:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjFMXLB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 19:11:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F5CE6F
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 16:11:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25bd4d3f35bso1844764a91.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686697859; x=1689289859;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3dE7+rd/bGq8c8P3FFpNo/MHBYX7kTWcsDVauxPvmY=;
        b=sjETV9VkEPk7e9VAof2D1FITxe9ux5aDzv/pvsVpDPdGve0a3yBreHpogT8JX2MG0h
         HNjN8GxOui2ZXY1wjyhnd2ttwUnmDL47VHX1k1VlXBRTKcNi/qfAnV+Sz2RKOev17R+N
         STlb+2dWyfc/G9z3kpGQZilWDc14o9zQQRZAATc1fkCrnHTJM2tFuCRGOFGL1HNYykMZ
         Gt2LH+ZcQJP8wkvvjB8AJ7O24+2dOGwX9RBKsoFYGrshcBtkNEOcSVOlOOWPOfoy7mK/
         38kiNC4cBuUdvEEImCGnF7rVX918Mf6vlILk0ZgKjWJYA4TTcdpwCuhgc8O1M3jhb2di
         1o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686697859; x=1689289859;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l3dE7+rd/bGq8c8P3FFpNo/MHBYX7kTWcsDVauxPvmY=;
        b=QHtTmOj+8CAC9Idf/w1XivPE/MMLcae8aV4cYh6Mpx2CnSZzui8/dTfzAwLQY0FCgy
         Db+9qcRwOsBjDXkhEr9Y+UJeEp7dH1USwO/rAo31qWfzuZ5D/CjQo/ZeiMh/FOWSV2Z9
         LbqUIcBCmQ/XcTOAOoh8qqCbfOxnE/VLmSJv1uYHf7N7SB1SxlS0e4zs03+q+157BrQP
         B7HQK9CHPrHrefbaN0P6tt17CI7cUKnlvNk0wQ8FXVqszvQl5hG4tyTkk28XA0I8p4dK
         ImZpgdkS9Luz+k98VC4p54sM3SGxKR0jxlG5Lyt74ZFpBglac8A7TDeHXHdJP++qenpk
         duhQ==
X-Gm-Message-State: AC+VfDxKZ7ie+mPUSmBHHVy9b7BqEK86qa/pklorJQaEM5TWUcMHoEUe
        AAU+LyBMEYislNpwpMmHpt4=
X-Google-Smtp-Source: ACHHUZ4FZvCO9ZICDCVG7QHt1VBQZLXIwboTBoB7kgOKbHmOXbm/hiK+VypfpwbZ4Yj8yOOWjVhShA==
X-Received: by 2002:a17:90a:b28b:b0:259:343:86b5 with SMTP id c11-20020a17090ab28b00b00259034386b5mr99349pjr.47.1686697859393;
        Tue, 13 Jun 2023 16:10:59 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a19db00b002568f2f8102sm12304037pjj.30.2023.06.13.16.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 16:10:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 5/8] common.h: move non-compat specific macros and
 functions
References: <20230606170711.912972-1-calvinwan@google.com>
        <20230606171002.914075-5-calvinwan@google.com>
        <25d47081-2096-bb8a-dca3-bd5ea931c879@ramsayjones.plus.com>
        <CAFySSZBZVn=7gBB19_uNxeUwS9Y8Q6ZZiCT=AwfuBy4+d34piw@mail.gmail.com>
        <xmqq8rco9zkl.fsf@gitster.g>
        <CAFySSZBf51JFAY5fYRsYvk2RkZ8rDmoQOHKrCte4ERkBeoiJWA@mail.gmail.com>
Date:   Tue, 13 Jun 2023 16:10:58 -0700
In-Reply-To: <CAFySSZBf51JFAY5fYRsYvk2RkZ8rDmoQOHKrCte4ERkBeoiJWA@mail.gmail.com>
        (Calvin Wan's message of "Tue, 13 Jun 2023 15:42:25 -0700")
Message-ID: <xmqqy1kn2c1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> In that case do you have any recommendations as to how I can make
> clear that this recursive inclusion isn't problematic or refactor away
> the recursive inclusion without having to change the header inclusions
> of every other Git file?

"Without having to" is an unfair restrition, given that you do not
have to create common.h and move things around in the first place
;-)
