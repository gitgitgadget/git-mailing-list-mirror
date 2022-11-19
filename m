Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7748C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 02:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiKSC42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 21:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiKSC40 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 21:56:26 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6BF976C1
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 18:56:25 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id 11so5238310iou.0
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 18:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2dnJduIE5k4Bo6wPq5xfV0sgy4U7S00/ofLqsSq0XY=;
        b=5zpwY2BxeWpONURFhEmb0uct7ih+vwWaow2aOq1Mn/ZDUqLbCcpHYuE+oJsXRVzKZm
         NaUZ2l94bRS3GoAPnBYyU0/RDXt3fYiI7AuaW+1R22L22GA3tt4klBuOnm2o2OqA+3m+
         qG6riNMzVdBliTQ1/XgReH6MD2ycP87zPVgyPsDlPobf7sthqiXa5XGN5q+Z8Hu8WvUE
         /GJTMnsHllBAbXII+RM5vuBdQnL272/nxjSdZFzfvTGAFxTrJJ74lhntQ3VdvQmXObg7
         vN667rOS36RrEAtwB16BDFSZ4t3qKDwMF2k2vgwvfHgj4RG9AM5apQuUoOmJz3GD27yD
         Psqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2dnJduIE5k4Bo6wPq5xfV0sgy4U7S00/ofLqsSq0XY=;
        b=tAt0+CNISGCCzNqVYQRCHfLs4c+PO1XI7GDff6e8DjpxzyyT0lzhRZ5I1FtBzooodt
         I+VEnNiRpVHd+hBvZoAkBiN85NcCD5w1+fL0ClzsGzP8R26SE0w8W9a1sm10F0cMOwXy
         qJZkn8iUrK+rGzZZIpyhvwgDF9GJZDA52Zl9zw0RNPEiwTSQhBHXhnrsMHM/o3Esn4+i
         wJIAIg5ECF5RNf7fwhmhhkA7m9vyPnLbMEp6TmC0j1j7rc8UhhwkiJH0/uCICBRMBtb7
         wMrO5Tskmjhj4OMSxNz4eAuv19HuDK1bGYwM+p8qp8/FwIi0tieiN34GgK3SBeuwdv7z
         shkA==
X-Gm-Message-State: ANoB5pmoRhjcgNGVgU4WAYgtl9zT9PZVhuKsSnSsvkrSa3sC6YpcBwdJ
        VsEIEw3omiAgXSeHAWUfOM+Gjw==
X-Google-Smtp-Source: AA0mqf62GtuwMZMexJcoV958RU8F4WH0ogq4dfH2luDOKKZuFGYT3j1WoZIX/J0kjs5NZwnGt9JNyA==
X-Received: by 2002:a02:a04e:0:b0:375:b099:e48e with SMTP id f14-20020a02a04e000000b00375b099e48emr4051519jah.319.1668826584538;
        Fri, 18 Nov 2022 18:56:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d8505000000b006bbddd49984sm1881799ion.9.2022.11.18.18.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 18:56:23 -0800 (PST)
Date:   Fri, 18 Nov 2022 21:56:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Message-ID: <Y3hF1vOQ8waqpvXo@nand.local>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
 <221114.86tu31lnwr.gmgdl@evledraar.gmail.com>
 <pss2rp96-qr48-21p4-36on-ns04nnp0944q@tzk.qr>
 <221114.86pmdplbs5.gmgdl@evledraar.gmail.com>
 <xmqqr0xzkfz8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0xzkfz8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 03:19:55PM -0800, Junio C Hamano wrote:
> Well "! test_cmp" is wrong anyway, because it _expects_ two files
> are the same and gives more detailed diagnosis when they differ by
> giving "diff" output.
>
> If you expect them to be different, "! test_cmp" would give
> "detailed diagnosis" in the wrong case, i.e. the outcome is what we
> expect.

I agree that "! test_cmp foo bar" will give output about how "foo" is
different from "bar" (and halt the test only when the two have the same
contents).

> So the caller must do "test_cmp !" whether the underlying
> implementation of test_cmp uses "diff -u" or "diff --no-index".

But this confuses me. "git grep 'test_cmp !'" turns up no results, and
furthermore, test_cmp() itself begins with:

    test "$#" -ne 2 && BUG "2 param"

So I am not sure what you are referring to.

Thanks,
Taylor
