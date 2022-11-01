Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C1C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 20:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiKAUyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKAUyn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 16:54:43 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217B10579
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 13:54:40 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d123so8680638iof.7
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=meIcIA8MWO1NLFgjGrne1Y+8Dlz3wfNZwrYN1+YZHM8=;
        b=RJAwRs3LefnubvLakjvl7k3cnfM82F045Qx7LQZyTSNq5/euEPI8XMU7nKLkMuUADr
         7r/AwX+4Z1rj0q/L57cTemU1RKEPZ3ZHncdec1FnuXNhHtT5gRYO1HHCedA0/JQ+qLeZ
         jnXBLaaUir9PKKCHZxBOS61MEWVcnT7iFwaaV7MVyVl73uv+2v3xUqcZXOxc+/r6+MI2
         Wqp8G1kISQvH/v6jjbRwYiSO2Xzm5xZrg+ZfwrjJBLEaht3Pt8auC64fNEyvSbdCSvJg
         Xtbuk76A9BLduQCRukp6+XxxQDqF+LjpjDLCqplFJdMKxAsnutzZpTngDLwtYROLrJpV
         w4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meIcIA8MWO1NLFgjGrne1Y+8Dlz3wfNZwrYN1+YZHM8=;
        b=MY6cG+XZlQ83aA1MxNQW5b9I4aJlSMdWWtu1WbuvUyCg53R1j2dCQEXLNKwYnC+ijt
         pRbJ8mLhCux4KSSmbK8d4PHjXxYi529LopqbQL7hr3t66bp5sUuzJz4YOhBkubFO5chY
         +Y/ErlPmYZ/aCiv74NJpm6v8qkWzYV9CPb2CM99ccAzcUJ5s8exMb13ozIWIv35lOg7g
         +v3woM3PaMF9Xz0h2h/rHqghtC/nvzcsTEqPwElfn8Anq65gXnvsxBsVbEAlPuKgjpJH
         paajLynd/dwKxUxzbyDB2kTEf5onzkq0z7zjKKgOaUZQE5q/OHxaLnGBwPnOH3zO2qQU
         aYDw==
X-Gm-Message-State: ACrzQf2Q03/nMymshHolh97JcL4zf8KhbDINv7UgbkOXLFwEernsf6j4
        TkmQvjWckPi+nAkbnbRcOkkbBQ==
X-Google-Smtp-Source: AMsMyM5v+TCnzsQZI0NR+mlaUqiFZqi/LZaJw0RidXQvaN6He9bG9g5DIp6CSFmx68WkjTYI9wOk+A==
X-Received: by 2002:a02:cc71:0:b0:373:1604:274d with SMTP id j17-20020a02cc71000000b003731604274dmr12801493jaq.119.1667336079663;
        Tue, 01 Nov 2022 13:54:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y88-20020a029561000000b00363aefdf040sm4209343jah.83.2022.11.01.13.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:54:39 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:54:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Message-ID: <Y2GHjnuyuwGpY3II@nand.local>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
 <221101.86a65b5q9q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221101.86a65b5q9q.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 04:01:18AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > Yeah, I think it is crappy UX, too. It's just that I think the tests
> > should not _asserting_ the bad behavior. At most, they should tolerate
> > the bad behavior as a band-aid. So I think Dscho's patch is doing the
> > right thing (and I do agree that we should fix the immediate CI pain by
> > adjusting the tests, and letting the user-visible fix proceed
> > independently).
>
> The tests aren't just asserting the bad behavior, they're also ensuring
> that it doesn't get worse. 1 warning is ideal, 2-3 is bad, but
> tolerable, but if we start emitting 500 of these it would be nice to
> know.

I admit that this kind of argument does not sway me.

Is it likely that we would suddenly start spewing 500 such warnings? If
we did, are there no other tests that would catch it? And even if *that*
were the case, would nobody happen to notice it in the meantime either
during development or when we queue an affected topic onto 'next' for
wider testing?

I guess the answer is that it's possible that we'd miss such a
regression in all of those above places, but to me it seems extremely
unlikely that we'd let such a regression through without noticing.

Thanks,
Taylor
