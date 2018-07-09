Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37C901F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 15:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933775AbeGIPzo (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 11:55:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38160 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933582AbeGIPzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 11:55:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so21170794wmf.3
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GkXkkaRq0pV7dVM/JFn21QvZLORblj7LP6hRNcn21kw=;
        b=H/x12vWbY6LL7CFc36xx3YIL+oylpe5qlI1QmFQ+ryEVIKeo30toxcaQFJM+eKxRLr
         BtDnJjoPRt3qgFv40VUBzvQFXmFEoq5J2aQBz593Q7ELtmn4UEKFOGD3dyrQE6O5Ses4
         0KTdNa+obJ6QXfrws1RoGAFC8kLmYI7f26iuiDO2/Km1hhpNKu98vZgcf2yr2eOd0UX1
         clV+n2vPkUoN4j1P+biItYLtjGoDS53xCsPFZ/II9DhkSreDciDZ1yt8rfDk0s93Dh0W
         jHgKxU2fGeIHP/rW2kGT2/ob7R9jTPbtFuIdcNLHThOcxOmKd+ORMBg8YnSsSyNK66Ld
         aOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GkXkkaRq0pV7dVM/JFn21QvZLORblj7LP6hRNcn21kw=;
        b=iEbFuHMCvhJ3FaZRFc+MOyWwh5BPn1MibrUXpGuM0hlfqSFtlB/ucpAfOlbKnBgArj
         d52EekivnjFfQIJdjP+xWWpPBuW9zQeosWBvQ8l/GaCAAmUFRpqGm8wLSzawoMb3Xfx3
         LvitkZ9x+lJ1YYQqDDcbhLn3R0lpPoEVkEIbqfApS9JqcvMCptoH5ZJQbNcQUKZr/p6n
         974FpJiarwWZAqg6Rq6Zm8twmwLSz1c9h21LU5m5bGR6kgXJw5ZY+yexerKuiMK5EDhy
         qJ9hU40wKL7n5EcJM7djLxd8+3xCgbvgIG08oLW44l9VkBZhg5TcEShoYh0Z0qPMTWom
         FpzQ==
X-Gm-Message-State: APt69E39Z3hjHTvtPC8zdjZOT5O45sDn0SFpbQfGX0muJq+wEXNj72kD
        FIilbcDpMVlvaByqCsGpSpg=
X-Google-Smtp-Source: AAOMgpcTs4kfAjqbIWhUJGSTggQqpaKeXmn2XkpnXjkJ1a1s2acUQ/V1bRVYFmEgf55DDW5wbMUOkg==
X-Received: by 2002:a1c:4885:: with SMTP id v127-v6mr12260495wma.161.1531151740591;
        Mon, 09 Jul 2018 08:55:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z9-v6sm28548271wre.49.2018.07.09.08.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:55:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     <git@vger.kernel.org>, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/8] builtin/receive-pack: use check_signature from gpg-interface
References: <cover.1530616446.git.henning.schild@siemens.com>
        <cover.1530616446.git.henning.schild@siemens.com>
        <f9e371c8dd2a17ddb5fd5989a7fdad1c0d1bb6e7.1530616446.git.henning.schild@siemens.com>
        <xmqqsh4wjg7b.fsf@gitster-ct.c.googlers.com>
        <xmqqk1q8hwta.fsf@gitster-ct.c.googlers.com>
        <20180709101854.2777aae2@md1pvb1c.ad001.siemens.net>
Date:   Mon, 09 Jul 2018 08:55:39 -0700
In-Reply-To: <20180709101854.2777aae2@md1pvb1c.ad001.siemens.net> (Henning
        Schild's message of "Mon, 9 Jul 2018 10:18:54 +0200")
Message-ID: <xmqqtvp8flok.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> I think 1 and 2 can be seen as somewhat unrelated to the gpgsm feature,
> they are more general refactoring. So i think picking them is a good
> idea. It will make the series shorter and ease review in the next round.

Surely, resending from patch 3 and upwards labelled as "add support
for gpgsm", saying that the topic depends on a different topic
branch named $X in my tree (after $X actually gets pushed out,
preferrably as part of 'next'---which is a promise that the changes
won't see any more drastic rewrites), is a good approach.

Thanks.

