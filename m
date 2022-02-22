Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8FBC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiBVAXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:23:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiBVAXT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:23:19 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF92AFE
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:22:55 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d7so11300788ilf.8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hIpQ3Ahl2xbx5JhIl+X4UipU34IEuJMi6+BUJcndGAU=;
        b=iqiUBsZSHsdI9P8vGnZikoG0UAV14qEdbcZyMmnmdprl19Dp8l5HsdOuTNOY4pqGrV
         cGJcmUXIKR75usnwQqbeIEs6dL+xpg8kf4qMFUQkDcuwBV4xwJUDLiO0cFhkyGsskfKv
         BTWkFOsB16+H3ERuCwSutjNnaSgKprTa0gHCkcASUSFQ9/8D1AhEfNlh4lc9R6k56JY5
         B4xtop4zLg3WAFixRJZeOmuxdXy7aV0Xoqr/+3z9yYsbMr7uwIwTPS7CrbRnS5YRAzcK
         oUqFFqpAjW2QGyS6Q4LOS0eBHoXchegPg5BTDLeZloIHzdtPFI5r20pLfd7cg98EErSM
         6Bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hIpQ3Ahl2xbx5JhIl+X4UipU34IEuJMi6+BUJcndGAU=;
        b=RTvuXfzcrsQhoAFkJ8pZrMj01NtgiTLb3/64McYwTVLpjcAoFAcmT1eTdjoV3yFl4/
         7ullwdRkUw5JTci/4sW7EPyCSQhztEP5fCO2kE7ljtbVoCAVkXraMOUXM+UG+ZE3Xc5H
         GGJ6B1S6GqClnCpIkdewokuatnfV4sEKwOGg4LAB+CxgJrWurhrL3jlcZ7lEVB9ji1c7
         NdOrnF1aBVuB4vUeKKRA475TTTr+u7AcYQMpgAStjs2uQYnYVT7Eye37WjTZKpT7uP+I
         t4/LLxm0ThpkdPwSHcp1d6Hrc0eXPncdsmGh1yJcXfkmn0xwaadEZQFp+QHICDg7Pf9A
         cFhg==
X-Gm-Message-State: AOAM532kXKK5GD1HPgtT793c2nPdgxOoh+TTierykb9q0h2E29zK3qZr
        whHjnGdotKb8IBfleBCwxtH4Zg==
X-Google-Smtp-Source: ABdhPJzWYNmmMp+fKhTyKYFgaTqXah0hrO0ZN+qnE3NeAgYR08+MV9nGjEZThWEKZajoLr/E4CeOsA==
X-Received: by 2002:a05:6e02:17cd:b0:2c2:49b0:c740 with SMTP id z13-20020a056e0217cd00b002c249b0c740mr3662198ilu.77.1645489374797;
        Mon, 21 Feb 2022 16:22:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y10sm9083849ill.15.2022.02.21.16.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:22:54 -0800 (PST)
Date:   Mon, 21 Feb 2022 19:22:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/8] Makefile: move ".SUFFIXES" rule to shared.mak
Message-ID: <YhQs3VfjacB+Ryvh@nand.local>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
 <patch-v2-4.8-4c6d8089fff-20211224T173558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-4.8-4c6d8089fff-20211224T173558Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 24, 2021 at 06:37:43PM +0100, Ævar Arnfjörð Bjarmason wrote:
>     $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -C Documentation man' 'make -C Documentation -j1 man'
>     Benchmark 1: make -C Documentation -j1 man' in 'HEAD~1
>       Time (mean ± σ):     121.7 ms ±   8.8 ms    [User: 105.8 ms, System: 18.6 ms]
>       Range (min … max):   112.8 ms … 148.4 ms    26 runs
>
>     Benchmark 2: make -C Documentation -j1 man' in 'HEAD~0
>       Time (mean ± σ):      97.5 ms ±   8.0 ms    [User: 80.1 ms, System: 20.1 ms]
>       Range (min … max):    89.8 ms … 111.8 ms    32 runs
>
>     Summary
>       'make -C Documentation -j1 man' in 'HEAD~0' ran
>         1.25 ± 0.14 times faster than 'make -C Documentation -j1 man' in 'HEAD~1'

Nice speed-up. Though I am not sure I totally understand where it comes
from ;). Reading 30248886ce8 and the documentation on .SUFFIXES from
[1], I am still unclear. I guess removing the obsolete built-in suffix
rules gives make less work to do in general?

So long as we're not depending on any of these, this seems like a nice
little boost to me.

> diff --git a/shared.mak b/shared.mak
> index 29f0e69ecb9..155ac84f867 100644
> --- a/shared.mak
> +++ b/shared.mak
> @@ -9,6 +9,11 @@
>  %:: s.%
>  %:: SCCS/s.%
>
> +## Likewise delete default $(SUFFIXES). See:
> +##
> +##     info make --index-search=.DELETE_ON_ERROR
> +.SUFFIXES:

Hmm. s/DELETE_ON_ERROR/SUFFIXES? Or perhaps I'm holding this whole thing
incorrectly:

    ~/s/git [nand] (ab/make-noop) $ info make --index-search=.DELETE_ON_ERROR
    no index entries found for '.DELETE_ON_ERROR'
    ~/s/git [nand] (ab/make-noop) $ info make --index-search=.SUFFIXES
    no index entries found for '.SUFFIXES'

Thanks,
Taylor

[1]: https://www.gnu.org/software/make/manual/html_node/Suffix-Rules.html
