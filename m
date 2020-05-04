Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6874C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F10621582
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpf63WxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgEDQ2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgEDQ2s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:28:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF4C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 09:28:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so5734785pfb.10
        for <git@vger.kernel.org>; Mon, 04 May 2020 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PUx9SlmLeEujSRwwFPemMgSSgSj12XfoEHL6mHxkY+4=;
        b=Fpf63WxElFY7wdwiTzltoMTA3oHq7l6ogxQ9S+NN7xVdiIRmB4O2dcvyGB2R6hub5P
         3yvKTkJioPOI0TCA2hSmUKY+P2rr1LA4Gz+QvbUtkx8TegOEmuQCq2cxJ7m2CUhM1Sne
         P6wQ/N+M2DCCAo+AFNumZawLgkkCvUaZPfAKv2yUtQMdsFYkUTiO6StR98pcFeBzlvo3
         CB4qUWHSv8gQVIC30aDFEYhGF53BY/IqklktDsKBIZqy0S4VQILrypxKCHaMUFAC68iA
         v2bsTpSsOGtrbranz1uHM7BDostvXiOA5zp/ohpASpsSUKtp4yh0ZTyQkn6zIq1tO80W
         Ektg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PUx9SlmLeEujSRwwFPemMgSSgSj12XfoEHL6mHxkY+4=;
        b=PIOcllqP6x5TRCH6YSStccPD3vtzs23Xz92hHQdoEzqepPvQdU1TQYqxk0jJF5tjhF
         bn8t68yu6U9JCQwYwImJAoUDB/5u4ZdsCcDaMVyRjIOvm92QSApB1CPu0ik9BK/DfMTF
         gZO2AX5YJDpbQpF9W6qp5OhedkyWBGNHQuV8SyZhgRXBO37KwjVu9S+amOGLU3o0NvzS
         Uy+ZB0Ygyjn2hVZk4iTmfBS0pLUbk7RZzqBkUDUBgcOB47mTxat/ip/LRmjBmrhKlO2s
         TUoMwSPiT5gu2JyWHTtR6cd39iJiisDEVFiDNc7MLcrq0qHghR6/Wlv86FBqsjXHBYCh
         +5Tg==
X-Gm-Message-State: AGi0PuY23sVTkpkuZruK821k1nrYDzKWpdEz1zQw9Ky1dIwALagKtP10
        +KIDq4hUff8s/OcoaFDBd+s=
X-Google-Smtp-Source: APiQypLy+parpF8Gpz2puozpzH7ZJuztEX8xIYW3YcwckBkcFR50fAKyedcVfpHkxm9HOcoZQOnmDQ==
X-Received: by 2002:a63:5445:: with SMTP id e5mr16890179pgm.185.1588609726878;
        Mon, 04 May 2020 09:28:46 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id o1sm7376825pjs.39.2020.05.04.09.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 09:28:46 -0700 (PDT)
Date:   Mon, 4 May 2020 09:28:44 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danh Doan <congdanhqx@gmail.com>, clime <clime7@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: drop arithmetic expansion advice to
 use "$x"
Message-ID: <20200504162844.GE86805@Carlos-MBP>
References: <20200503090952.GA170768@coredump.intra.peff.net>
 <20200503091157.GA170902@coredump.intra.peff.net>
 <20200503114351.GA28680@danh.dev>
 <20200504151351.GC11373@coredump.intra.peff.net>
 <xmqqh7wviud9.fsf@gitster.c.googlers.com>
 <20200504160709.GB12842@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504160709.GB12842@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 12:07:09PM -0400, Jeff King wrote:
> -- >8 --
> Subject: CodingGuidelines: drop arithmetic expansion advice to use "$x"
> 
> The advice to use "$x" rather than "x" in arithmetric expansion was
> working around a dash bug fixed in 0.5.4. Even Debian oldstable has
> 0.5.7 these days.

that would be oldoldstable, oldstable is actually in 0.5.8 ;)

> Helped-by: Danh Doan <congdanhqx@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>

Reviewed-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>

Carlo
