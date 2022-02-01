Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EC4C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 17:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiBARwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiBARwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 12:52:40 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD00C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 09:52:40 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n17so22223976iod.4
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 09:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kngBkB74cd0TvJS2JyiPkOLUfjS7yUT24yDlVO0WMGk=;
        b=tFxo3SHd2C3R7nGG1GYXJxN5+Pkgb4OJVMBizcb1GedQUNfVYXuby4XLBBptjnQ2x3
         KL9u9nc6H2KVvfp1xclgX1ZqNhfcVmaSTNaWgGe1h8ro+NwAS8HkREGts2Niog/Ah4gX
         8X5oddt2CZvclFVd9lQtl3l0dHes3SXL/qNbT62qLvPbWiKdrc+s751tHiVuBaePFceN
         cAxb1Cz1L21TQdVFXm8nmHGXZ2rOhnFQsPCrf2YdhQXao1kPDCqFtogPItVxC00eoVJd
         Sb7UZmr46BZfYR2b9UCS3ytB/goCLNi9/00/rCaVPVCItn0Io//P5suWvRXddkiDxnna
         nLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kngBkB74cd0TvJS2JyiPkOLUfjS7yUT24yDlVO0WMGk=;
        b=PSWYm4KMaxO3wFY3gh4pOiDaOeuryNje3APmTWhiiDomiMjPsW5rKKi8f2JsnQ15Cd
         ky7eJvPr67s+TijA8ONTUVBG1uU3jW+fygFxFznSNxYHzagOIcF/nD94TUlB6dcIEbLx
         cuM2/feKJQ4mpFUSrSsqEyV1VgkFSla2EDi5KwxZ7r1/CQA4CiloSa369VJo8D+FaPYc
         WBcTON2i87SvXivqtI6daAZgiMFarrhG4Bp13URCy+4E5dETyY93kXd4Yepi9r4JHkHK
         UdwQVN+XBy8rvK98gDFMDHLQVhUGVqZFti2kNaUk3lucQ8+pyQz4+L8fTHrFrZtHaKlI
         UlsQ==
X-Gm-Message-State: AOAM533JmL/On4nv+bWE6t6o836hFsu2/nW0A25VzkrrNYGBsff33Iuu
        xCoBd9zoaVW1pGfly0TjUAnrvw==
X-Google-Smtp-Source: ABdhPJyvZvgxHWDKQ15lIXClFFpk7s5TCfHo8/JVnBn+efih0uZa1Wj70BwyAFK0Kpn7n7fPjinoew==
X-Received: by 2002:a02:8641:: with SMTP id e59mr13223584jai.17.1643737959986;
        Tue, 01 Feb 2022 09:52:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r64sm16849198iod.25.2022.02.01.09.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:52:39 -0800 (PST)
Date:   Tue, 1 Feb 2022 12:52:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     John Cai <johncai86@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [RFC v3] cat-file: add a --stdin-cmd mode
Message-ID: <YflzZsb/txsopusP@nand.local>
References: <20220128183319.43496-1-johncai86@gmail.com>
 <CAP8UFD3sHvA3Gx9+d=VjQ11sEqWF47AEeo-m4bGsVO3OUJ4dLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3sHvA3Gx9+d=VjQ11sEqWF47AEeo-m4bGsVO3OUJ4dLw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 01, 2022 at 10:39:30AM +0100, Christian Couder wrote:
> Also I think at this point this should probably not be an RFC patch
> anymore but a regular one.

I think that this is due to my first "review" in [1], where I tried to
get an understanding of what John's concrete usage plans were, since I
couldn't figure out what they were on my own.

I'm not sure that I've seen a response along the lines of "we need to
control when the output stream is flushed in order to do ..." yet, but I
would be interested to see one before moving too much further ahead of
where we already are.

(Apologies if such a response was written, and I missed it).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YehomwNiIs0l83W7@nand.local/
