Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62E7C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 11:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350242AbiAULpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiAULpB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 06:45:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BBDC061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:45:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f21so41892911eds.11
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0Hb0c3JDYgimDAyZ0fBY5eQJKpv9NoPlRNPcKqkV8kc=;
        b=Pmg22q95eBzeAF1A3gFpolcYSOytME+TZ9+9v5ARUmX/WxJP3d8x3xtGbmVeEqp5Hi
         1ylusdREVgW/Bp/IDlnAhT28UBIbc3RV8fJL5LTOXRxDt6Hdq4XJvi72h0IsrGUpMC04
         dwFy+3gEa+fIQkXhh10adcQ10PrgHhgPEGhRWfFMDYH7VLWkbmfJx5RSlAsCKUdC3yhi
         Zk0ZCs61ucQ4mDz5FkRn9UGNiGCSPEa6ycoWjo300JGVRNxo+C0Afb6VOtK8798TVpRW
         0XmT5PCSESClT1EIaXEKoi2PrxH0J0xyIuZ2rgSziODFzqRADyl9hsS9oLZr/HepF3ee
         zfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0Hb0c3JDYgimDAyZ0fBY5eQJKpv9NoPlRNPcKqkV8kc=;
        b=n+NpJau0q/LTPP4DeOYMAnoBCykjyl5J+nCZV7zko3S0zc8RpqS1MEoYQeuNcBQ2Bg
         CU4DIwYXAfDf21liG7hka7pG7eVukq1O3yXf8F1S3AuKNoHJ8Mtyk/xv0iLA7JdMJCsN
         EPNETHboaoVmHkXbQzuq+fWs8cnaXhqRsxSkxfNmW1oDX3Ka8vXk2oAj95E84gDwdVc9
         ILNj8VmE/kuc8EG0+4HZQ4Eti6iDCzxfPlTytKpl4lxJz9/MC4K3SNol/n304S+B+WiX
         PkO+8r+loaFNnLPQgdG3KqlWmMRYvaowt/rjtJ6Q2H7oGQ8mZHkFPy1zAYFE3TM3U+cO
         Bhsg==
X-Gm-Message-State: AOAM532G74Hvz3Uepp6yrXejiDQpvK97RfcgB6xms+NLvUYv0vKg+aug
        Bl2kAH8E/5g8nOWNNrhTU7CJ8f01jJaqMw==
X-Google-Smtp-Source: ABdhPJzfmUsoJk7MLnIM03Tod6XpT6Nwlv5HkrK9tpWY/qlIxfUWOyZY3nbCsTfysHK+5IZ6RwkB4A==
X-Received: by 2002:a17:907:6d08:: with SMTP id sa8mr1898595ejc.278.1642765499179;
        Fri, 21 Jan 2022 03:44:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j15sm1963808ejx.199.2022.01.21.03.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 03:44:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAsLi-0027Q0-3y;
        Fri, 21 Jan 2022 12:44:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 04/15] reftable: check reftable_stack_auto_compact()
 return value
Date:   Fri, 21 Jan 2022 12:44:15 +0100
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <8740ba92981c77f85b855e69c237fdb7449cca58.1642691534.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <8740ba92981c77f85b855e69c237fdb7449cca58.1642691534.git.gitgitgadget@gmail.com>
Message-ID: <220121.861r11l3d2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Fixes a problem detected by Coverity.

Detected by coverity, but I think it's better to describe the
issue. Here it seems to be that we didn't use the "err" at all, so
before this change the test wasn't doing anything to check that we
didn't have an error?

Or would the subsequent EXPECT() catch it in practice?

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/stack_test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index f4c743db80c..e84f50d27ff 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -839,6 +839,7 @@ static void test_reftable_stack_auto_compaction(void)
>  		EXPECT_ERR(err);
>  
>  		err = reftable_stack_auto_compact(st);
> +		EXPECT_ERR(err);
>  		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
>  	}

