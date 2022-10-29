Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE61BC38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 20:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ2ULe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 16:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ2ULc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 16:11:32 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66404DB5C
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 13:11:30 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 11so7178852iou.0
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tASIwqbZ7PPXMENO+UfIbTZSpa/TJLgDfDKDvFTTmKM=;
        b=uimTfiRH9mWC949EgaWFasGLMaOsIV23C1bTQKnYUCEgGSl+MOQFSb+HoR9EsQGd32
         jqlvb/FYs0PHAm9E7iPTYQaIreNad+jp5Rg1qJI/oJd7AebI8V4FSFpBjJ3q1BUTJz32
         DI7YZcCAZ/2TuTz3SUb+ZLDMjX1ON3CY/qiK6uz7qPwtCjaWyOuSLtMtvaJX7y3cPbup
         +y+HUhp06s4nUa57NNnba9kCKxVxVTUOFdw2BVcyTLE5Th3R33CTHgz38CMcyFnYkO08
         vRa2SiCgiV3JagTPlwvMrUKm8NqBsrzChhFEWiVC4HeAyaG9NAzGegYR4jUQm8G1RRV7
         It6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tASIwqbZ7PPXMENO+UfIbTZSpa/TJLgDfDKDvFTTmKM=;
        b=HlqOBu2QXnvE4sLluYCL0O9J/5lq06vu1Lc5/v46Cd/oXedSo4Hg/ypEwyQXGUpXuQ
         5FjhON+HPB6kQ4/7F+W47VDhy26rWZEXqEC89SMseUPZXsIfEYn9sWgL81VkT75gZhjo
         KSj9aqcnhMSVyXY6PiCR6cYh56qYT+TSQFH9gxMkTUzTBbjWIqwPRUS6gbVODe8UbJ2e
         Tl+14edt5TwSgHiT0D1sI2v6q1fTHiyAMsWkU/Xwtm2On0x7U+4whnZUohgkSCQo3ZKk
         H9Id1fyZMNxMkD1wvtQ37veoAwYHIJuGyO62aTh1Vta6tSP32XRiseDYb+l/QZRy2Rzp
         kTmA==
X-Gm-Message-State: ACrzQf1OfB8Y4YZy9lOcNgy9J44fWV6WTko/NybOX5mxA2y1UiB+l+98
        4r0NDip9WJMc5qnU2hePRHSrdA==
X-Google-Smtp-Source: AMsMyM7MyGyDx7v4AD3y7VxCP/GXeFv8wQ4JqeaMmLujUyYtncXnaHweVPWohX222U5NUymYy/tKVA==
X-Received: by 2002:a05:6638:4814:b0:364:1291:56e4 with SMTP id cp20-20020a056638481400b00364129156e4mr2783401jab.2.1667074289958;
        Sat, 29 Oct 2022 13:11:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c16-20020a92bd10000000b002e939413e83sm855948ile.48.2022.10.29.13.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 13:11:29 -0700 (PDT)
Date:   Sat, 29 Oct 2022 16:11:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/3] hook tests: fix redirection logic error in
 96e7225b310
Message-ID: <Y12I7zSohPu2cyJt@nand.local>
References: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
 <patch-1.3-1ba41a5842c-20221029T025520Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.3-1ba41a5842c-20221029T025520Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Emily]

On Sat, Oct 29, 2022 at 04:59:45AM +0200, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 43fcb7c0bfc..2ef3579fa7c 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -95,7 +95,7 @@ test_expect_success 'git hook run -- out-of-repo runs excluded' '
>  test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
>  	mkdir my-hooks &&
>  	write_script my-hooks/test-hook <<-\EOF &&
> -	echo Hook ran $1 >>actual
> +	echo Hook ran $1
>  	EOF

Looking reasonable to me. Though let's see what Emily thinks, too...

Thanks,
Taylor
