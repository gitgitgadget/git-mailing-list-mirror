Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D40C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBFXeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBFXd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:33:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC118A5B
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:33:54 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so12405153pjp.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVQ/0rVp51BviurrOgZq7CSj8VwldHxJGjlGcz89Hoc=;
        b=Flm+2/YcmBRmOL87v2rendV1F/s+M8c39u/vncqWbTILnrkyltI55IdlMNzs7JLXhI
         MrRBwK6X5xTXLo1qRAHy5cACc7h+9iOwMcORbL9AkdDvjWrIusahiVzz5P4yxo62R2a7
         AbniZt5RrIPxNW7D+D3TQqb8DIX0PYRPFlqdaNzSaBzC17hLwkcN3zVxYicAjZkahrNJ
         ou/63yALQyVIQ2nHd423yqJZUlRlSy+99ZL3GXjDarf8/ISxMUJleDFkjLGRyLff/QYS
         EY8k9gMgUfFnoNkwyTwBD97BnKe+UVxhabK9IilY5WE294M7xUpupIO7IXtV1Ub/eKL8
         Gdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVQ/0rVp51BviurrOgZq7CSj8VwldHxJGjlGcz89Hoc=;
        b=z/TxzdJP+08xqFTn4hzQMNXUyvqPeTdoyJ/IOZSkVMsASb6wCj8jl0s1xS9Eb2hRhW
         XvPcDc4um9Pd2K1doXZ7hQXsi2TMI8BQEWAymlyaqA5/DIPvcGpKhnOtAs4+AY2Q1NUQ
         YR0SzwB8BWd+ZfSYzAeZ+gT8Lrm9b0HccLzIWk86XLGHhlis6wwtURe4p5fFXira2tGd
         AgAzUimcOFEz7owHdRF8srF5Vv8F2RpywKXj41nhDzijBM++N7IHCrzdDO1cEkLRkHYP
         F3qPS8TMzxYwCfS5s8jrYmAJ0XWGrcDILFmXraLPb4JmmGztpS0m772yLc+1KLt6jBzw
         +afQ==
X-Gm-Message-State: AO0yUKVPDbwNwxQwUDNfEzRtnXXS3GRZaMtCNfCntQPZv9zYvIZGYeNi
        Xt3cw5s1EHtG9kTxBSDoa7k=
X-Google-Smtp-Source: AK7set/7IISKlY4+7BD5sjzc5H2IiPOTeAvcFLw8Y2rrFEzPw79eAuQohhAF/JprkxXkfVIkZXaffA==
X-Received: by 2002:a17:902:e1d4:b0:199:109e:832 with SMTP id t20-20020a170902e1d400b00199109e0832mr522377pla.37.1675726434388;
        Mon, 06 Feb 2023 15:33:54 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id iw7-20020a170903044700b0019607aeda8bsm3256711plb.73.2023.02.06.15.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:33:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 0/6] tests: fix ignored & hidden exit codes
References: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
        <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
Date:   Mon, 06 Feb 2023 15:33:53 -0800
In-Reply-To: <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 6 Feb
 2023 23:44:27
        +0100")
Message-ID: <xmqq7cwu2wta.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Ævar Arnfjörð Bjarmason (6):
>   auto-crlf tests: don't lose exit code in loops and outside tests
>   t/lib-patch-mode.sh: fix ignored exit codes
>   tests: don't lose exit status with "(cd ...; test <op> $(git ...))"
>   tests: don't lose exit status with "test <op> $(git ...)"
>   tests: don't lose "git" exit codes in "! ( git ... | grep )"
>   tests: don't lose misc "git" exit codes

The changes relative to the previous round look OK.  Will queue.

Thanks.
