Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C781FAE2
	for <e@80x24.org>; Fri,  2 Feb 2018 19:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeBBTBE (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 14:01:04 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51849 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeBBTBC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 14:01:02 -0500
Received: by mail-wm0-f68.google.com with SMTP id r71so14745478wmd.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=U2EIWx2EkE+3Fr2sVShVP5N5olRiCgAA8UsQ57W6O/8=;
        b=qYvDCM2jvbv2ZDjbcSAI0t+DrFwT96LlOvOYbkrFz+dWJn0kNzllPlqbAJqS1JOXoW
         54xTxtYVxkeQ2YoQYOTvR1K9CCSTXpIbY3vvtluMhR3pV2XHZ1B1crpvWlC8aEm92Khn
         ldckKDgwcUukxHLZz6DZiFKDHo9MkWGHlWole5CUm94SNoT5XtvpuBA6YjeNCpahTnIS
         pBN1KDwXjUK44t1IPzXeYxYU8F7Tq4rS5iASYL365boaiC8tB9Ifb0N2LuoFA+EBfCiF
         ZMX9LlgVCb/dItEVXrRUNqe6eYl7TkBbwJ75F6XlCz+QflaKgvs4kZbLarCmZHoF664q
         HNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=U2EIWx2EkE+3Fr2sVShVP5N5olRiCgAA8UsQ57W6O/8=;
        b=AtqYbQSSotIJfugJ/hblHGExhhuPqCwLtxycFSc1L+pc+CLb/ckcVOWNqM7o0O48xs
         1ybUIEWcqPFru5/yXanHtDMylVBXAjXARYbATbBR0MW15BqVm6tPHo87dDozvlcrQmSp
         bxR2hsf5Lr6Nl3GVuDki1YcDjkNNzKOOA+MruzFlZJNW73Peo4xWd4fha2xbxYeHaMx9
         ohLZXA53P4QDxRzxSxtD1fEJQpxNBTy94cchtvzDGntOlI9TakJa5x3y7wtskQAaoIbZ
         /mzDI2bqDMgXH5+1z4SKcbJJ+kBLpLCSDw/6JdFujBvfL1FEnv2T0caPl+yajab+xUUc
         G3gw==
X-Gm-Message-State: AKwxyteQEJ3c+FBFZUP37ifXylnbLnU1UPcBHkw25+IqxUALj+0I+uKZ
        O3dbsmsPYkXA/V4gbiP2010=
X-Google-Smtp-Source: AH8x2261V0B7tiKoO13GYUnoVPGSKjdVsJIKp6SDVxXI83jQYwkpcSTNEsLjomwsYQJquQ9legXjNg==
X-Received: by 10.28.100.213 with SMTP id y204mr31272959wmb.24.1517598060773;
        Fri, 02 Feb 2018 11:01:00 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k60sm4802430wrc.2.2018.02.02.11.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 11:01:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tim Landscheidt <tim@tim-landscheidt.de>
Subject: Re: [PATCH v2 3/3] rebase: introduce and use pseudo-ref ORIG_COMMIT
References: <20180126095520.919-1-pclouds@gmail.com>
        <20180131093051.15525-1-pclouds@gmail.com>
        <20180131093051.15525-5-pclouds@gmail.com>
        <xmqqlggdr519.fsf@gitster-ct.c.googlers.com>
        <CACsJy8D8PaDR0r+6AKMgPo9UBcWYQC8goaVkVhxMCXCa1E9F9A@mail.gmail.com>
Date:   Fri, 02 Feb 2018 11:00:59 -0800
In-Reply-To: <CACsJy8D8PaDR0r+6AKMgPo9UBcWYQC8goaVkVhxMCXCa1E9F9A@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 1 Feb 2018 17:02:39 +0700")
Message-ID: <xmqqy3kbcj2s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 1, 2018 at 6:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Hmph, how is this new file conceptually different from existing ones
>> like CHERRY_PICK_HEAD?
>
> Conceptually the same, except that CHERRY_PICK_HEAD can't be reused
> because it's specifically tied to git-cherry-pick (there's even code
> that delete this ref if cherry-pick is run as part of rebase, and
> git-status uses this ref to see if a cherry-pick is in progress).
> There's also REVERT_HEAD in sequencer.c, same purpose but for
> git-revert. Perhaps I should rename this new ref to REBASE_HEAD to
> follow the same naming?

I just found "ORIG_COMMIT" too similar to "ORIG_HEAD" that is
totally a different thing and feared unnecessary confusion.  I think
you are correct to suggest that REBASE_HEAD would be more in line
with the naming convention with the sequencer-like operations.

Thanks.
