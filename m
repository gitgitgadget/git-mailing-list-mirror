Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F04C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 11:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350236AbiAULt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350122AbiAULt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 06:49:56 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2BAC061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:49:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z22so41821780edd.12
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vF3lrB6s7iSp37aE9GfkR4BS2sKjwUwfM4aofNENhKo=;
        b=jLmrNRHRsWA4ACcfj29XT06y9BLHuC7Uz4Y2lyCYcpVE2YC2AKFdvnW5jE5+7Rxztz
         BFwvQBh5CTy0BZ2KFMUGSyf1YBwaof3ciyU3LB1v3bymegJDk+wptuI+LCaUTqax2Toy
         ATFtWieWSSc2BTNC6FYFJOQkgzIM5I6SwyGJpDY4wprcI70OfbsTpH24Vad5hWHo04rg
         4aVDvHfR+HpwNffOrKzIf/vlKsotRJC66uyjPP68JD/GZzmIiTvDDmHIosr+qUquuWw9
         h998bTLXYebWX1/F7YlMpIMIBF5l7xXyzymLDRgxNPRR0VWF3MFI+Di9L1etXC7xIj5r
         O5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vF3lrB6s7iSp37aE9GfkR4BS2sKjwUwfM4aofNENhKo=;
        b=JXFycmYCNKhmrvV9HFNhpXgGwyoFd19qN+OE463qE1Ujgbn8ppE+7rOXLd3MJ8Pq5p
         2kRMEsEFl3154s0oD7t/KrFbGtFSnwsnzrX2Mkv55fVOcs3ln3SVLGOtn2r+ftUUxTKy
         Z0nXjF3iXJkTI8+7euM61/pnp95gVBh18jG1hLu7VrNgvFhLZcPgTT5xJY2CX2t6q05J
         RuO9Qgn45On5OrWgWDVqagMC2OmRI/9C7rEJFhoJfhzWj/fFXioOHlhc2qV3ETMAEoci
         c1jtKj0YIYGeJvKejuKiLE9A+b1rxecR8luZTTddaCQmYkRR/jfk7/4kWleaDQnvMDKY
         y2eQ==
X-Gm-Message-State: AOAM532YCRMbi+6YYeOSSRzFPyqwoumMKm3ZLZf8SFKP2A2b5j+R0kd0
        orLBLiT2GXNnTHJLZnum59w3/BLGR6kZ5Q==
X-Google-Smtp-Source: ABdhPJxLkI2tntlrnMeGfPCQ1HCsnevJSEjLuiFVOmRHy8xi+/lNf2m+uRG5nuNsazMqTLPWRjE00w==
X-Received: by 2002:a17:907:7f86:: with SMTP id qk6mr2977407ejc.631.1642765794209;
        Fri, 21 Jan 2022 03:49:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r22sm2503856edt.51.2022.01.21.03.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 03:49:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAsQT-0027Y4-4b;
        Fri, 21 Jan 2022 12:49:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 05/15] reftable: ignore remove() return value in
 stack_test.c
Date:   Fri, 21 Jan 2022 12:46:05 +0100
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <08be6d90a4890b63fe9b0885af0df084c9ca81fd.1642691534.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <08be6d90a4890b63fe9b0885af0df084c9ca81fd.1642691534.git.gitgitgadget@gmail.com>
Message-ID: <220121.86wnitjoke.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> If the cleanup fails, there is nothing we can do.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/stack_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index e84f50d27ff..19fe4e20085 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -90,7 +90,7 @@ static void test_read_file(void)
>  		EXPECT(0 == strcmp(want[i], names[i]));
>  	}
>  	free_names(names);
> -	remove(fn);
> +	(void) remove(fn);
>  }
>  
>  static void test_parse_names(void)

Well, if we fail here due to a permission error or other I/O weirdness
surely it's better to:

	if (remove(fn) < 0)
		die_errno("unable to remove '%s'", fn);

Otherwise we're just silently sweeping that under the rug, and likely
having the "rm -rf" we'll shortly do in test-lib.sh catch it at a
distance.

Also why are we using remove() here at all? Shouldn't this just be
unlink()? Or per the feedback above unlink_or_warn() or
remove_or_warn()? I.e. looking at the context we just open()'d this
"fn", so we're not unsure if it's a directory or a file, are we?

