Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6CAC54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 11:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiISLF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 07:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiISLFY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 07:05:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776F365FD
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 04:05:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a26so34847280ejc.4
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=wOX4bFhpQnC/yX4PfWXD+nMI3yER48ZHneQxSDxInQs=;
        b=D9XirPzdq463FmHXuZE8eZ0dqVPZXNFW+ufTGlage8aAtb25cy6xZGKBcpP7ykQ5HB
         wacPS44AXkBABhpdpsEprqYPuyT2i7a7y/b5bYjFt1F3zps+IBtyRBrf1cmaS6qe8W+i
         xGFZi/9nN/IByiZs/wo4z31l/0wcescBB6tyPXdVj89VbqPZapvSaP4ZMOy74LNI6h4k
         Wx+ntmbmj3UwNglxHTFJGBgGRd4Y5Zmgh4XCUSQa0hK88bW8rZr6q/tX+EvgHizo+U+P
         pq0eaH/sYxMkdEgKZ9NyJvjeJmQWMvP5gXxoRhyGonr38dhKvXmKDDnOlikoGbrrucoI
         st+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wOX4bFhpQnC/yX4PfWXD+nMI3yER48ZHneQxSDxInQs=;
        b=ldG8tJxz0l3caUnL2WAXNpw9xBlK2+IzONGUR8rZEB8QdAo+jzMaFf/4m9yHvIrvTi
         hpVXlHYrK63lH0itgoWPygMzWcwhoeE337rbSC8kTlX6I3r2EkZcObbPEEAetWjJGWyY
         8ZjJqlVIt7zwDr7iTfbKLeH96ergs2xL0ds0h4Xy75o8pzCYFtPmAS4mJ7g9xauPKyqY
         i2EuwKiR8svYNszJO+j/JxjqJw7VfJ93Y8aGxeb8YOw5U7FxJ18hzs1eEstK/LHDNsXx
         jySbMgooiyVcxiU6Yp8H3KfOissjADP2FzD5glDxCCZ8ls6wvOEZ7Tb1Rwihn6O4bVlo
         emog==
X-Gm-Message-State: ACrzQf2HMyY/u64sU1O5g+5kYL2z+a6A0Emqzhva5xp6piHBJCJ2hT+d
        g0CoBlmUBe5wsypgIkDRVaab9lsqR4o=
X-Google-Smtp-Source: AMsMyM6LwBF+vi7FbKmPGHRpqECFpHsqly2N9sKeD5rY7rqe2PVXBv3V7I45UlIriEbNz9COQ5gSmg==
X-Received: by 2002:a17:906:dac9:b0:780:ab6f:591f with SMTP id xi9-20020a170906dac900b00780ab6f591fmr10761532ejb.77.1663585518848;
        Mon, 19 Sep 2022 04:05:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q10-20020a1709063d4a00b0073c74bee6eesm15245356ejf.201.2022.09.19.04.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 04:05:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oaEaT-000bUW-24;
        Mon, 19 Sep 2022 13:05:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
Date:   Mon, 19 Sep 2022 13:03:44 +0200
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
        <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
        <xmqqh719pcoo.fsf@gitster.g>
        <CABPp-BEOVGfgmAMGCjP6Q3k-t=C1tL=f27buhiCiL-Wv0eDF_A@mail.gmail.com>
        <cafcedba-96a2-cb85-d593-ef47c8c8397c@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <cafcedba-96a2-cb85-d593-ef47c8c8397c@github.com>
Message-ID: <220919.86v8pj62vm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 18 2022, Victoria Dye wrote:

> Elijah, would you be interested in compiling your thoughts into a document
> in 'Documentation/technical'? If not, Stolee or I could do it. If we could
> settle on some guidelines (option names, behavior, etc.) for better
> incorporating 'sparse-checkout' support into existing commands, it'd make
> future sparse index work substantially easier for everyone involved.

This sounds good. I'd just like to suggest that incorporating a table
similar to the one I made for checkout/switch in would be useful for
such documentation:

	https://lore.kernel.org/git/211021.86wnm6l1ip.gmgdl@evledraar.gmail.com/

We ended up dropping the ball on that topic, but for cross-command UX I
think it's a very useful way to present how a "meta option", or an
option shared across many commands is expected to behave.
