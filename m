Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4D4FA3740
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKABGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKABGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:06:34 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FB911140
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:06:34 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id o13so744260ilq.6
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rU27yuCz34fkxwrG8TTR9yym9w7Mp45S2S4gTzXeZKw=;
        b=GMMQ53Baw+xVA0OB1hbhx8RVb2DERPLkrNj/JbF7XgQU7WTKA01UBgbAR4G+xz+PWn
         YVAKAF8MTpDOaqlBCcG6nf69QD7KzFRjYdqhbplNdCYtb/4Pm92FI0e8mDugWHHN8AuB
         m2MLo1Z6po1iZv/sx4s4QOJBO1JXV5BsNs+jyBDq7YFYCpG22mfDPzrNjluN9qDu1amI
         T1XZYVMjDA2+GiGrtcFa5kJyNEbjotC7lFWJjjJ16/l/ixeWwNuwtOtcu0A/gSAlKim9
         mGFmQNvhjyhXhkJILul64cKBo8soGqpNBJPcgQ1ZIwwCV+2IxlXSpjlK/bmPmEa+CEgt
         2GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rU27yuCz34fkxwrG8TTR9yym9w7Mp45S2S4gTzXeZKw=;
        b=NksofAPNNgSZJLJtjI4Gnt4fQo8iHNNp2gR9MC4zSJgnW0daOb2dLl2WAwXyulPBen
         WyI0YypSADVi2JK4MLlLwgwipPvvIkcwV/vJghtHQ/Dl2r10onlagQLoJgCWmf6UM3Zx
         sS4TzTOyrrikwIb3kWQxbEO+wSJ03UFao+xox0RTc9dmyVPXwTe0s75BeRf+FAoyHjJF
         bhngdn2+KyFiMPe/r4GhQIV3/FH2mbMmYH+/ZcxrrXHk/Zf5mHY/bfEUOAQYWvsOc1eL
         zACGNZbxG9RnWjGhwo5R7T//VkeAWGbg68GTVQQihUm9UP/iVCmzHHh7GvbtpNsuzxXY
         HNyw==
X-Gm-Message-State: ACrzQf11n9B+B6bs3Nj7AlVVCnSZbUNT82XaCnabhomH2bUV93F5ZwtX
        Y1u7DJZlMWAndvJvzCTVuLZpgw==
X-Google-Smtp-Source: AMsMyM4fo+14042zkURCfhzNQkoHSLNziSGqsvuQiprIVnEjhYxJJHklvbqd4fUH9G955JQw+UAVog==
X-Received: by 2002:a05:6e02:1a8d:b0:2ff:1ffa:a53d with SMTP id k13-20020a056e021a8d00b002ff1ffaa53dmr9108922ilv.175.1667264793330;
        Mon, 31 Oct 2022 18:06:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f9-20020a056602088900b006bc3bf6e5b5sm3394007ioz.55.2022.10.31.18.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:06:33 -0700 (PDT)
Date:   Mon, 31 Oct 2022 21:06:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Message-ID: <Y2BxFxZqA9GA40AB@nand.local>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 09:47:08PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Improve on 6dcbdc0d661 (remote: create fetch.credentialsInUrl config,
> 2022-06-06) by fixing the cases where we emit duplicate warnings,
> which were:
>
>  * In the same process, as we'd get the same "struct remote *"
>    again. We could probably save ourselves more work in those scenarios,
>    but adding a flag to the "struct remote" indicating that we've validated
>    the URLs will fix those issues.
>
>  * When we invoke e.g. "git-remote-https" (aka. "git-remote-curl")
>    from "git fetch". For those cases let's pass down the equivalent of a
>    "-c transfer.credentialsInUrl=allow", since we know that we've already
>    inspected our remotes in the parent process.
>
>    See 7390f05a3c6 (fetch: after refetch, encourage auto gc repacking,
>    2022-03-28) for prior use of git_config_push_parameter() for this
>    purpose, i.e. to push config parameters before invoking a
>    sub-process.

Both make sense. I was skimming the diff before I read the patch message
here and was scratching my head at the calls to
git_config_push_parameter().

But for crossing process boundaries, that makes sense.

Thanks,
Taylor
