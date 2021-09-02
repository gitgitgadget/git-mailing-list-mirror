Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C3FC433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41B76054F
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348519AbhIBWsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348515AbhIBWsu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 18:48:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234BEC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 15:47:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a25so7990106ejv.6
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 15:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Uc+ktKUcuG5PZEXcJjFx7jtqvwJlpnwmNb2Brk/TXYg=;
        b=pdyW7+4ZSroN0/j0gdfVNaz0aTD00GzLQVHWqKSXE5dnL0V9SV2u3RDYKJ5hTdQXXZ
         xNpcFBqAitcmDZKQi/ZsrYKanuT5Aptc8Fss1qynSMQUbLp0EVvJcWu0v46UPB563t3M
         eP4SvvgTaX1TnALezT6qXBfNkdb/sKgDgSYLueDRsMpisXfrrLmgl5pq4wFnvG8LWupX
         JPgIFnAEzIC4hNtVvyhFnXZ9zJfwDZ7noxxhlhzDrVVkHyfR0XLpSAug69LDlp07ff9B
         2QjCgEJlM40Cbg6cSsKvL6sQOwYG4P7mAYlmgRLgVGJMiG8fA/2qI/2gd32zYxC4jQRe
         h0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Uc+ktKUcuG5PZEXcJjFx7jtqvwJlpnwmNb2Brk/TXYg=;
        b=VgbsiF2/nc9uVdrMCgPluOfr5XJhxoEhAivo5xzSdjaNBOJ64jJi3b4pikLpbwQBq9
         dZb83CpE261fCQCyBXhbYKsN6z9HmBAFqF7iEwyhiq1n4AS0hydUUimv+eHcdidJhsx2
         T/QWbkzSbO/mrFEDbTlXWcRpSIsRyF0KMf5aBkxM9jkkRYqgiD+MZWXBi4/as3ZF3lHE
         51QJEfjdJaC5JvYwV5NWrnjH0mIuNNbzE1pQ48+LmgsTas+9h2Xm2qd4wgdNcoYnnZwh
         PP9ZMQGooilmF5NOR1k9+SecbyonZjbpWPvA39YqB4ELkgbS2vtJe4HwI1SjnbpcktP6
         7G2Q==
X-Gm-Message-State: AOAM531t9IzJjpr0b2UuZ7xptWrsFLUMxWkZ+xomesq6o45zWnEVQYb3
        hgJKqnHvgnEEY/wvS2NYH5NA1Nofrrg9WQ==
X-Google-Smtp-Source: ABdhPJz8kaFoQjvd406wC5yEJkwOaV/aGMhquhKv0L0PukMTnvnnm2g0zcnXL7U8F3RguvNhC4xaAw==
X-Received: by 2002:a17:906:165a:: with SMTP id n26mr589190ejd.236.1630622869722;
        Thu, 02 Sep 2021 15:47:49 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g9sm1821638ejo.60.2021.09.02.15.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 15:47:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 5/5] bundle: show progress on "unbundle"
Date:   Fri, 03 Sep 2021 00:47:05 +0200
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
 <patch-v3-5.5-cd38b0f0fed-20210826T140414Z-avarab@gmail.com>
 <xmqqmtp28hbv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqmtp28hbv.fsf@gitster.g>
Message-ID: <87zgsu8ui3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 27 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> +	if (progress) {
>> +		strvec_push(&extra_args, "-v");
>> +		strvec_push(&extra_args, "--progress-title");
>> +		strvec_push(&extra_args, _("Unbundling objects"));
>
> Nice.  I would have expected to see pushl() though.

Will fix. Thanks!

>> +	}
>> +
>> +	ret =3D !!unbundle(the_repository, &header, bundle_fd, progress ?
>> +			 &extra_args : NULL) ||
>
> Again, I wouldn't make the &extra_args conditional to progress
> here.  Future code change may decide to pass more args to underlying
> index-pack and the criteria for doing so may be different from
> progress.
>
> If this code cares about readability, it should uncondtionally pass
> &extra_args.

I agree, but I landed myself in a game of reviewer ping-pong. I had it
that way originally, then Derrick Stolee suggested changing it in this
way in <30620e13-4509-1905-7644-9962b6adf9c5@gmail.com>, I'll just
change it back :)
