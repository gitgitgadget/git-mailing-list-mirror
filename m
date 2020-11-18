Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E73C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D031A20897
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZErMJw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgKRSce (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgKRScd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:32:33 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C41C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:32:33 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b6so3210711wrt.4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=10LXncBXX/k/G4XB4UAi4PPUQnTetzV6o1STR3uThqM=;
        b=VZErMJw7F29zwFL7+blxmF/gosXw8R8s0Vyxg15a6bDF1D4CWOssOn6AZB44VX99DH
         sUK+BeNJjGojcHBJARX7aAT6aIGv8TWcF4b6iVMsNGcQKuLdUHh6BmORsKLQ7xpnGbNE
         qSvHJw5cbLKuRJ5gmDDUH5hERi+gnPPE0/ZS3omICgRnLB5d1/segVgtkMzb/Y13gHee
         W6RhSzQm/4JlWuTxPgSK0tfCq7Egm9MQMar7T+hq4sHT278g2p8Td6+sjfnakI0xh6/O
         hpUjmxH1Ih+98TLt0ZBxRcLo40gVZyc1s58aseVcnOrwnxkn5CnB/1TPw4wzBiEUkAfp
         VseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=10LXncBXX/k/G4XB4UAi4PPUQnTetzV6o1STR3uThqM=;
        b=dLfkJNRYuEAgIDsbXfRRow+lTd9xFSV2L4iCLoEo4klyQ4x+BdO3mq3K08RIuzxjJU
         /MW4liq2JLcwOP99fBIZC6aKr2FZlwgNL2usNro8xU0E9d3T0+AljksiwHJxJ1Vc1WiA
         PN1NeRkHP5ny4ETDVfdIQXJOke2fDS1ubh/c9VuC5W5IqFGTV0huoa7JPcSdC/IpjFDx
         rVyrHmzJTM6pTknVFVy6zwt3ybff1iQp1e4W/Iu6mW2dD2kyXxHwHb2fCTZ8BqNdUaK7
         IWp2z1GxskB+BcPV57ZQwUeS/m97SUXNG+rHau7hhAVkmfXy1ym1149dwwhyHTrYuICA
         yetQ==
X-Gm-Message-State: AOAM532+VwSP2QWEeLwBXBmAFtGP+dgyZTNnTMoRKu6e7IMRyki9AVSp
        ZIFPP0d5UHesVFWOjk0n+5k=
X-Google-Smtp-Source: ABdhPJy20c9qE0lcerToWvZnhwxqdms1Y+fIFLK1pWbr1kIYC1PP3CFTXJ53gPwufG7EvGlvErUBnw==
X-Received: by 2002:a5d:5711:: with SMTP id a17mr6042077wrv.136.1605724352058;
        Wed, 18 Nov 2020 10:32:32 -0800 (PST)
Received: from szeder.dev (78-131-14-45.pool.digikabel.hu. [78.131.14.45])
        by smtp.gmail.com with ESMTPSA id 8sm3601694wmg.28.2020.11.18.10.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 10:32:31 -0800 (PST)
Date:   Wed, 18 Nov 2020 19:32:25 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <20201118183225.GB8396@szeder.dev>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 04:46:16PM -0500, Taylor Blau wrote:
>   - Harden the tests so that they pass under sha256-mode (thanks SZEDER,
>     and Peff).

Fixing this is good, of course, but...

> 16:  86d77fd085 ! 18:  5262daa330 pack-bitmap-write: build fewer intermediate bitmaps
>     @@ t/t5310-pack-bitmaps.sh: test_expect_success 'setup repo with moderate-sized his
>       '
> 
>       test_expect_success 'rev-list --test-bitmap verifies bitmaps' '
>     +@@ t/t5310-pack-bitmaps.sh: test_expect_success 'truncated bitmap fails gracefully (ewah)' '
>     + 	git rev-list --use-bitmap-index --count --all >expect &&
>     + 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
>     + 	test_when_finished "rm -f $bitmap" &&
>     +-	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
>     ++	test_copy_bytes 270 <$bitmap >$bitmap.tmp &&
>     + 	mv -f $bitmap.tmp $bitmap &&
>     + 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
>     + 	test_cmp expect actual &&

Please don't simply sneak in such a change without explaining it in
the commit message.

