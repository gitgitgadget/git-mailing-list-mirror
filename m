Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D96AC2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 20:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D47720702
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 20:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eImjoNer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgAZUHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 15:07:32 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:42923 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAZUHc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 15:07:32 -0500
Received: by mail-qv1-f53.google.com with SMTP id dc14so3546205qvb.9
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 12:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xO4mnRvqdgVxWTwXPd0HlDEo/Ux29NES1yuzLMbsuGI=;
        b=eImjoNer2oUjp2f+iOnwDXS1FmDzYs6+WydVZUUh0Ld+MJ94RivdGhYuFBNkW7ztV9
         KbI0qJ0+Ri+AKmy0u5suGxfEeFedeKD8Yp15uwgPpnInXq23mPWP5/wYMR8fB2klRGhp
         CK4Q9BYINexaBLseYggKRh1o4KHF+unZJGy4dQ4HJ1eltsjSnzbODQmrtmLcgqD3EtTE
         w2F59/cOhRWvzBSRK40x8MRY3dCfv4FDsgTBfHO706xBlrFhwayNjyB3beFnX9XfP4qr
         V2OfXh79twKXBCMFE3y7Li6U0PsE4vRvfXTtXLSJNvLEgiBhwI6fQZ2q8YDAm4S8qvMK
         rbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xO4mnRvqdgVxWTwXPd0HlDEo/Ux29NES1yuzLMbsuGI=;
        b=U7Zzwcuj8aZuTgg4q16EGQDVzrvOtTsehMxVZ4Tw1LlnCuXLLHAU4ug0LD4D1vSVdx
         uGzIFZVlgasZNZLUVsY/I/YeV6fZQnfTZO21fF8kgJAzuSNque8AdgHLJo2fT6EvbqIo
         yxf3h+IdEUyS5PpVt+b6IuTAssURX6ASVu1SMsW6U1VL82S4ZpzrCj3AQxRCetmqMR50
         a0uubAeW3KgiahNgURMkGZaZiFdongb0c2sEXLGPzB+K68MOgVAVJ6YJ4qqJ7DekxAUx
         D28cySHCUuxYGbQHECd3cZW9pALvR6T/pXmdJPG/m+QS5bbJNPTIuoqD+WcCN4Ppncay
         SKTg==
X-Gm-Message-State: APjAAAUBDYZ9DGb6nzoJ3pxtIzBHb09jiqKfJznZZszxnzu9kUVCw88+
        m3iVWse+iUojAouUagS8YyM=
X-Google-Smtp-Source: APXvYqzOWdLWbu7yhYpD66psRh4Mn2TBdtW/06B/Oy+3Q9CP3q9z6/LIeII2MkOfGYC9+m1d/ci1BA==
X-Received: by 2002:a05:6214:80c:: with SMTP id df12mr13260219qvb.113.1580069251622;
        Sun, 26 Jan 2020 12:07:31 -0800 (PST)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id m18sm7774222qtm.60.2020.01.26.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 12:07:30 -0800 (PST)
Date:   Sun, 26 Jan 2020 15:07:28 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
Message-ID: <20200126200728.GA233163@generichostname>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Jan 22, 2020 at 02:18:05PM -0800, Junio C Hamano wrote:
> * ds/sparse-cone (2020-01-10) 1 commit
>  - unpack-trees: correctly compute result count
> 
>  The code recently added in this release to move to the entry beyond
>  the ones in the same directory in the index in the sparse-cone mode
>  did not count the number of entries to skip over incorrectly, which
>  has been corrected.
> 
>  Will merge to 'next'.

This commit has incorrect authorship information for Stolee. The author
is listed as "Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>"
due to a bug (which has been fixed) in GGG. We should fix the authorship
information before merging to 'next'.

On the topic of faulty authorship information, I sent along two mailmap
changes that were dropped[1][2]. Could you please pick these up?

Thanks,

Denton

[1]: https://public-inbox.org/git/20200114024938.GA17003@generichostname/
[2]: https://public-inbox.org/git/21b8a0d08764c31de12ef7661667eb1117d41ac4.1578972215.git.liu.denton@gmail.com/
