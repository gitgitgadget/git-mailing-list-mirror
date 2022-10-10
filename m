Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E45C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 19:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJJTAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJJTAh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 15:00:37 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB38D6BD49
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 12:00:36 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o65so9162912iof.4
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7zG7lE/G0sSWedadfu9uHcYu3K+lUw6l1KsEPMnqy2M=;
        b=kK43Y0YKGzF9PlqAKgDHcW0lDJptvd7F5T2D568k+I00iyE1nVwzzef01L8rQXwrmf
         Jm1lD7kjT+ZDQNqvJfTKaJtgJfa4wyp2DH9hfuK89N3b9gjZaQWgpa7efAf21DgtS0Om
         yv1BrvxnoJhTME1ZUegMgMQgjWz0FNX7uf5KjUG7FJ2q0QdEl+OKtPMSa1APsTo4Pqa/
         MPMrkb9HmM0uzlQ0ToRocB0GwxzwUBMZwWbiwHlvpWdqjxF+ICSsU8BkjW8Ql/SodRV1
         1ACkW05hIVZ8WTTgMOfrvqcOhitCnh8+I6U/FkaCMXchPP8AhYrMUme+8UyvSU4Sh8nP
         Lqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zG7lE/G0sSWedadfu9uHcYu3K+lUw6l1KsEPMnqy2M=;
        b=uKoJzslx/vBdbprtKnbYKPnPcSuzl0GlOY8WknaaeKPtbf3CN9Gog4CotP1D8vXPH9
         KwGWPuvw3XbJ3ZFAS8n4sqZ+QVblNwIKCrtUC84MBQTVWbMSrT5ztpr60tV77A7uNq+e
         tmbVM3EHxjxeXrdBRxbqBhY1ZqJ8o1SxM05ojMolcCm7VKoqpRlUPMe0DTws/Oit2ZU9
         ckGjDqjYjsmZjDC9iVHEjIus5mbKAVTRC6kjK/YswtUOaU33zjtr51lOYERoRBm/l0aK
         Pu1mtyWmq3xV5BF019mE8tP9oF6W3nCdO2KBNXWZX8GkaPj6lmn9BUHGfJAVWUyp3Lnr
         z0Pw==
X-Gm-Message-State: ACrzQf0ozcJL2UyNco2c1Kti+C8uhdE9hdxLDc71b4leNmkn1/iW1RaO
        5v5A4QzXWeC5H+BOJhSatsvM/xF7dmYa9V27
X-Google-Smtp-Source: AMsMyM7TIPwiHtMZLWVzikp0SrRzi5HuUelJFuszucqBuMVGOxkq++HiZs5d6As/LXSdF3kMBvzMxQ==
X-Received: by 2002:a05:6638:2612:b0:35a:337a:8a4c with SMTP id m18-20020a056638261200b0035a337a8a4cmr11118046jat.269.1665428436019;
        Mon, 10 Oct 2022 12:00:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g1-20020a028501000000b003566ff0eb13sm4237728jai.34.2022.10.10.12.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:00:35 -0700 (PDT)
Date:   Mon, 10 Oct 2022 15:00:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        orygaw <orygaw@protonmail.com>, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] log: require --grep for --invert-grep and --all-match,
 fix segfault
Message-ID: <Y0Rr0sQ91C/SgmBJ@nand.local>
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
 <patch-1.1-f4b90799fce-20221010T165711Z-avarab@gmail.com>
 <xmqq7d174m6a.fsf@gitster.g>
 <xmqq35bv4lns.fsf@gitster.g>
 <221010.86o7ujpl44.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221010.86o7ujpl44.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 08:48:25PM +0200, Ævar Arnfjörð Bjarmason wrote:
> The rationale for changing it this way is that the documentaion says:
>
> 	--all-match::
> 	        Limit the commits output to ones that match all given `--grep`,
> 	        instead of ones that match at least one.
> 	--invert-grep::
> 	        Limit the commits output to ones with log message that do not
> 	        match the pattern specified with `--grep=<pattern>`.

This does feel a little academic, but to me the documentation seems to
suggest that `--all-match` or `--invert-grep` should both support the
absence of a `--grep` argument.

At least in `--invert-grep`, my reading is "the pattern specified with
`--grep=<pattern>` [...if any]".

In any case, the behavior has been as such for long enough that it feels
like our documentation needs to be changed, and not the behavior itself.
On the other hand, I have a hard time imagining that many/any people
care about this particular behavior.

Thanks,
Taylor
