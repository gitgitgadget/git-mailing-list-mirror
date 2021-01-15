Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17749C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 08:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85E32072D
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 08:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbhAOIPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 03:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbhAOIPw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 03:15:52 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D764C061575
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 00:15:12 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id h10so5003965pfo.9
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 00:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+TkoNIyQ9qClSRL6VOIydrSoihIQkPbPIA+lVLupwXU=;
        b=MqzWEPXe7fz1z1QoI09R5Oq9fyOzaTjfzIMFnVWFBGSDTI5od6aQd/88mXN7Lw3ZSu
         VD2me7i5suDu+Wpmm7QkDYbpHXVnFdpa+7zSqGwcW8UUYzKLdLYFK47vUPbvnnS2Fr93
         AJHgkrJbEnOLtre3znS6VHVq0f83Tz7bGpcxshGZj1JXurJZ73yxaFFfCpqHzPSFjdpB
         A6LIulkrVIJdAhcbGUFHpdjXPtqag9r0GUlw48WEuprQslwqauCTqPxfkf1afvtzblKG
         rxiKGYOFk2ioh+2+338K6SP3dyW0zoH3k763gX5jIKxssTZp3JNkuBINvZYAo7o7dS11
         hYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+TkoNIyQ9qClSRL6VOIydrSoihIQkPbPIA+lVLupwXU=;
        b=joBCXHNt+f3eikoRRpvJ1AIYTPBV274wadiuZWdVKBcUUUq/xQsYQbNhBYBA2EsgwC
         lee+z8I0MoXILYHcUykPydbH9ERoZ57iXLCANzBi9eEhUQa9c+orxluAceTC1NoSCuvX
         ErB6Y6UWrtyR7fqLVY9Ijs2tk83+1P0qkxwuwarfPG3pe0a3yDZqQxJsTeEEUMOp+DIU
         KTOVpRpfkmbB8Ela0PyfjCQin56010vNeJfg3hBqs12qRLGVFhr2UiMhgNOeMuNzYHsq
         2jfUSdG2MUY19RxAuZrziZVITrODNseVHAd2yaKFmh9K7EirmcElx9qAFQSYm0NQHwKg
         MClQ==
X-Gm-Message-State: AOAM532EbR8XXbxfE5ZFVtBOIrp1zM2j7inQgZbn17TNyWexnn9iHsNx
        qx/EH7gbV2VGfb+Xp90CMECbNKrq2RU=
X-Google-Smtp-Source: ABdhPJzBrZO9tId8+8rQfaVThOmOEyKAfmU6rf1sstb8ItmrjZTL4v+3JOy5cMl+DyMnrgYDdPhmIA==
X-Received: by 2002:a65:64ce:: with SMTP id t14mr11619477pgv.36.1610698512095;
        Fri, 15 Jan 2021 00:15:12 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id c12sm149009pfj.135.2021.01.15.00.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 00:15:10 -0800 (PST)
Date:   Fri, 15 Jan 2021 00:15:08 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/6] test_lib: allow test_{must,might}_fail to accept
 non-git on "sigpipe"
Message-ID: <YAFPDJHH7ChvnVSD@generichostname>
References: <20191115040909.GA21654@sigill.intra.peff.net>
 <20210114233515.31298-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114233515.31298-4-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

First of all, thanks for reviving this series! I hope that Bash accepts
your proposed patch because it would definitely be helpful.

On Fri, Jan 15, 2021 at 12:35:12AM +0100, Ævar Arnfjörð Bjarmason wrote:
> As the documentation here notes you usually do not want to do:
> 
>     test_might_fail grep ...
> 
> But instead:
> 
>     ! grep ...
> 
> However, as a future commit will show it's handy to be able to do:
> 
>     some | test_might_fail ok=sigpipe grep | commands | here
> 
> To allow "grep" to fail in the middle of a pipe, if we're in a mode
> such as a "set -o pipefail" that knows how to accept check intra-pipe
> failures.

From what I can see, there presently aren't any other use cases here
except for with grep. I propose writing a wrapper around
grep, à la [0]:

	test_filter () {
		grep "$@" || :
	}

This has two main advantanges: the first would be that we could avoid
complicating the test_must_fail_acceptable() code. The second is that
it would be much less of a mouthful to write and it would be more
readable.

Compare

	some | test_might_fail ok=sigpipe grep | commands | here

to

	some | test_filter | commands | here


Thanks,
Denton

[0]: https://lore.kernel.org/git/3f79d23b40c0586d0351f4d721097be4f7ba26b8.1573779465.git.liu.denton@gmail.com/

> To test this in t0000-basic.sh we don't actually need to have
> test_{might,must}_fail in the middle of a pipe, it'll just that it
> accepts e.g. "grep" when we provide ok=sigpipe.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
