Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E564DC56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 08:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAAD20637
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 08:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8hyikSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKYIrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgKYIrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 03:47:25 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4AEC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 00:47:24 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id m16so1692398edr.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 00:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=c+Q2uDJHoGwJHEcJdW4GTxAD2XWzSuahH2Xsm7yaGpM=;
        b=M8hyikSmtjKn2aPdZaGUeO0jRMv/3q/Sw8aHjqmXw6veaBIQekaf6JabP0wbvzwIt/
         /WJdTGRrcLxwRqMVvVs5H5/7PpamlUNQaj0c0tCsQuJayOBRr+EHJnhtz2dAXARAABNV
         haqNsInYB0J0XkqRf0CZD6RHFZ6EJoFShngbRaeF9caOru0f3ay19aHBUjNCWnGJp5BA
         VIvNn61UubsF+kaB7RHaL8kKWDeqQ3cNvQh2R+M7roDOEnstCV07QsLEAeF5t/IHvipN
         pi1zZJtaXmT15hM9TvsitXVEiHX6ky2wlMumDpXauxMtejvTojEjgckI7DSjWNbcOUMW
         r2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=c+Q2uDJHoGwJHEcJdW4GTxAD2XWzSuahH2Xsm7yaGpM=;
        b=WRDutZ2vD9LEzsLUFC3BvrUbascjRvZGwBRR0D+zvw4VSmI7J8bDWMJctu1D4tOWQK
         q0iMDX23+Ux2AQD7hJUMwhoyefF9/6FoFOv3clN6v+8/k+Rt3XuaWw/f9SFK3Bro9RMO
         +00OadUxvOvm+fRDHU6fqKbaT919HHFZ0u3XzolvJAVotQM0LVZWDQqGGK7zG4FWeuED
         O7seKRrFo/NhQvklTEOFIVUJfCbYRdWflVyNASRDYiBc1u797k5JotTb2ZHW9qHMJ4xe
         mncbYX+j16+KV6Dg6dguXatw+gSULqrKx+0zQ63Q0ftjVZQWjhxmfzWQFXgP9uAA63m7
         S+vg==
X-Gm-Message-State: AOAM5334v1kqkTknNiS9kk4eNmPFFvo2VcwE2F1KHzFP58+ZncQS0SM1
        +xK4c2XmWzp2MD198ZaoNcmK5HVXJuA=
X-Google-Smtp-Source: ABdhPJyNvQwWBanpsIVDnWC4tdhOZ5iCSdcxjJAeA+VZABDJa3cyyoFqGwqFcWjcqGqXqQVZrkGk1A==
X-Received: by 2002:aa7:ca57:: with SMTP id j23mr2386783edt.292.1606294043505;
        Wed, 25 Nov 2020 00:47:23 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id f24sm763216edx.90.2020.11.25.00.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 00:47:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 2/2] config: allow specifying config entries via envvar pairs
References: <cover.1606214397.git.ps@pks.im> <97740ada840a1e2f151003e695de9f2efa5a7e62.1606214397.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <97740ada840a1e2f151003e695de9f2efa5a7e62.1606214397.git.ps@pks.im>
Date:   Wed, 25 Nov 2020 09:47:22 +0100
Message-ID: <875z5tq0v9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 24 2020, Patrick Steinhardt wrote:

> +test_expect_success 'command line overrides environment config' '
> +	GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=pair.one GIT_CONFIG_VALUE_0=value \
> +		git -c pair.one=override config pair.one >actual &&
> +	cat >expect <<-EOF &&
> +	override
> +	EOF
> +	test_cmp expect actual
> +'
> +

Maybe a test to see which one of this new-style key-value thing
v.s. GIT_CONFIG_PARAMETERS wins? Helps if/when we ever refactor this to
at least see the behavior of the purely internal thing changed.
