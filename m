Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6E9C6FA83
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 19:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiIWTRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 15:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWTRp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 15:17:45 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C969112C68F
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 12:17:43 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id v128so677602ioe.12
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=VLzV2iXPWSTfTVr4zJdlcGXvW2y6VVaVRLSs01Dtw28=;
        b=sl4/XbleplZFSWvnF1YWPBQalT5nTkvb9JaLlmDKfh5giM1T6TW/hBpqfD4OHd4CrZ
         NIMvkzzxbge9NSgOxaMNUE7Z7iGl4lZE1nl0bX1nlPcElDRID/26jwq3OQYByUhASNzK
         lfcFUJlYdB+OdxhMOP+pRTlEcKBW1HD71+THoyYB3AJto21jPFIpW4Rgm6QBSOcRPGsl
         axppWlWf3fKHFkQX1R4mfzaHJjnw9bmCsRh/UbiWXShrA1+P1w6e6dWHjzDMKacTd8FT
         DRuDmA/tplkza2trj8XDonjry000iNvAG93rRzv4CNa2XbtMghLNBFYLJe1TkCO0pI/N
         bpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=VLzV2iXPWSTfTVr4zJdlcGXvW2y6VVaVRLSs01Dtw28=;
        b=sjJFxYPfBWFWgpiBbIeVm1jzHc8tPi+AiUbcD8zIn1OzqwqDLjnTT6wqeh39A38hSP
         q3MfaoPhvit4Llyo6YWx28Mtu+LriKrmEHj3hPo8lJX2up+GMbCRedn5E6cv8Z2IjdX5
         N2Ix5mlbKtPp3MzlOjXsc8ieJygZJ4CZeGgbjSdaHFuy0BitpsDrThoj/H4XvDZY2rV6
         csZAJX7OdRx0cqMtjtkRp4YlSypiCKSVtUTkdee1XYaKWcNfB8LfTOPm0SdVzP/JOnBX
         cS7WPh9CSF+C1LRFhTR5jnNMd7T8WupXlIz6XhTwSyWMKRPESI0ZHxIWBhG5BOKmiETE
         tyYg==
X-Gm-Message-State: ACrzQf2PfJdEu79VKplQVYQlqPanTowraZyrrcuzbjif9zKhDpm4QLke
        qTAJRL+wkzA8ClCPJNrNeSjHPA==
X-Google-Smtp-Source: AMsMyM7KZ9eDu2h7bae7yNxZx0jbfkco+fm/s278WgPUa3THz7V8h7CeEDe1uJ9XgvATLiB0tmjDFQ==
X-Received: by 2002:a05:6638:35a1:b0:35a:6967:acbe with SMTP id v33-20020a05663835a100b0035a6967acbemr5634534jal.37.1663960662799;
        Fri, 23 Sep 2022 12:17:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i7-20020a056638380700b00349d2d52f6asm3709367jav.37.2022.09.23.12.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:17:42 -0700 (PDT)
Date:   Fri, 23 Sep 2022 15:17:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com,
        chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] pack-bitmap: remove trace2 region from hot path
Message-ID: <Yy4GVT8VZ4dOyGDy@nand.local>
References: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
 <xmqq7d1uuh5f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7d1uuh5f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 10:36:44AM -0700, Junio C Hamano wrote:
> diff --git c/t/t5310-pack-bitmaps.sh w/t/t5310-pack-bitmaps.sh
> index 7e50f8e765..2b1efc923b 100755
> --- c/t/t5310-pack-bitmaps.sh
> +++ w/t/t5310-pack-bitmaps.sh
> @@ -455,7 +455,7 @@ test_expect_success 'verify writing bitmap lookup table when enabled' '
>  	grep "\"label\":\"writing_lookup_table\"" trace2
>  '
>
> -test_expect_success 'lookup table is actually used to traverse objects' '
> +: test_expect_success 'lookup table is actually used to traverse objects' '
>  	git repack -adb &&
>  	GIT_TRACE2_EVENT="$(pwd)/trace3" \
>  		git rev-list --use-bitmap-index --count --all &&

Yeah, I would advocate for dropping this test entirely. That trace2
marker is the only indication that is so obvious that we're using the
lookup table to read bitmaps.

Perhaps the pack-bitmap helper could be taught to dump which extensions
it sees, and then write a test based on that? Although that isn't really
testing anything new, either, since we sometimes *notice* the extension
but don't actually read anything based on it (e.g., when disabled).

So I'd be content just dropping this.

Thanks,
Taylor
