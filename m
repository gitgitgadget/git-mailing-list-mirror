Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126DC6379B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC54604D7
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGVRgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhGVRgl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 13:36:41 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DEEC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 11:17:15 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id v26so7406823iom.11
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v6kEvH6g+Go0G++YQWBAPqIVEKvp0Xr8/dSrJ0aAs7s=;
        b=nIczSrTLguoNZNwf4vdzYhHGtkM0e9FwFjaQqKrHzA9xd0EKV7Ld6KXIOyl9igT/DI
         kz7j1DbSU5K6HvWxLSBw6NCzf0Wcur1GEX6zP5Qf0r6yvFJd/GEYSUxaA4vH9L9Qa0vc
         9QTV29CRi2CaZke14NDdhSx1pFzxSTXOq71/iZp1PjwLJKUpQZH2FPRMm4MXTqUiH5RV
         RofT0U35VsBX+Iuo5JKWXZssba/RFbkEZ5f1mjX8tO7kiKqPffnbOgxT21A5vzUYHpOI
         HbyaGaXsO2ZqL9qEj/STVYYWeHFPFPpqt9WHMOD8iOYsU8vH5LG70jc/PbT0Bnv/WliD
         2dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v6kEvH6g+Go0G++YQWBAPqIVEKvp0Xr8/dSrJ0aAs7s=;
        b=aTHf75miBxlxyuYsntrmQZAxjtRabTu/brIJHu8p54Uwsw/TAVCBOLENw9EmZFUKks
         ir2pwIYyc7k8AKWOdPDRQhIdc7gla20cpvlWdEtzCAxsxtxF42eL1sYtyi3yrnBvKjrc
         Gqvd2NYnCYdl7btKP0IFEyNpJXHJTd5P6hOxCydFLLghk6MQhYP/VXsSPIV7oMelsOQ6
         EaHaIRyTBhhlcQqd13K4dnk/TWXJN2zRXTJVwfJrUGlIZvqwsZbZLcFd7JoYnXiLb1pi
         98qs/2actJIZUyieHJIpfuaOLhhibTESJYb12w6EoHgUIUw0hIXrdok2UKBFQc+LpzSH
         MAAg==
X-Gm-Message-State: AOAM53175ZGgcql8oVjKMv/z9DmE85Nq3HXVJTqrCnNcsMD3Cj6JZzql
        Jbi7jqzvcH+r9ezP/3a6yXkQ7Q==
X-Google-Smtp-Source: ABdhPJzx2j4QimY4BCaUoMCkj4CFEfBOEj/XTtW3YXXccfvrk6ecAykrHH9l8A8t9gO8+yb6jjJk2w==
X-Received: by 2002:a02:8206:: with SMTP id o6mr719723jag.92.1626977835279;
        Thu, 22 Jul 2021 11:17:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z11sm16157485ioh.14.2021.07.22.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 11:17:14 -0700 (PDT)
Date:   Thu, 22 Jul 2021 14:17:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/2] bundle tests: use test_cmp instead of grep
Message-ID: <YPm2KsNQxaZTIjGz@nand.local>
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210721T235251Z-avarab@gmail.com>
 <patch-2.2-d5504fd764c-20210721T235251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.2-d5504fd764c-20210721T235251Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 01:53:29AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Change the bundle tests to fully compare the expected "git ls-remote"
> or "git bundle list-heads" output, instead of merely grepping it.

Thanks; this version makes all of those tests more readable. I did have
one idle thought while reading, but what you wrote is right (so I'm just
thinking out loud as opposed to anything else).

> -	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&
> -	grep "^-$OID_REGEX " boundary
> +
> +	if ! test_have_prereq SHA1
> +	then
> +		echo "@object-format=sha256"
> +	fi >expect &&
> +	cat >>expect <<-EOF &&

On my first read, I worried that this 'cat >>expect' when we're in
SHA-1 mode would append to the 'expect' we generated a few lines up. But
it doesn't, since we redirect the output of the 'if' statement into
'expect' instead of doing the redirect attached to the echo.

Subtle, but that's right. Good.

Thanks,
Taylor
