Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0A8C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 14:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbiCDOXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 09:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbiCDOXR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 09:23:17 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888BB61
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 06:22:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id m2so1884801pll.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 06:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=scEAQ/LMzjCoK5ABiHM+/7i5lKvqRAnsiITOtI0wELA=;
        b=qfIMlXGPPJ2uEhYbQILbRiPud1DoGuY3QkrktvqzKwyAMpORXiszDMcv/pzzXbv2RM
         kmbDFF3hYSew+G84kBb72hsH/IKBm1qR4EXKTvCIkGXgn6QbfnCzCzAd+MiUG34jo01U
         bJYoWjT1tu/hkgxzvCPnnIt8fhwjris9RYS2uwyLdQeTHvIMg42GknbmbyCe7vAsrJeC
         K5/E2DzaysMVuQ4J1EqAbQ/BTQgTyEJSTIEgVauLveT5VeEn7SMaEUlhaXeSELK+Ja8Z
         xBwfy1JKiIq0Ee/ZaAaPSwVC9Hv8DUFwKvxKanqJT5+mmY30zVJGHYuEb9RXnVRuxVfH
         PmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=scEAQ/LMzjCoK5ABiHM+/7i5lKvqRAnsiITOtI0wELA=;
        b=2ucZ+4a8n+ejUtWO8/xONg9/UZYh20UzEbXzjf+fzrQbesQ4utLqMUVjzkRv2Cel5W
         qjeIiNjtlttUUcZIDqZY0XgF8hDNcnyUhDndn18eC526VZ4MCzifkScvf1rx27KjYPPu
         J5c6wY3e9C3+Sah2QH0Xb05Ra3LSBQlnDOYw1e+oYwqTFmcm4TL3hn1CchLUPYmkngMO
         klvbogzP7ZNJJbezc3TaCPkSr5IG3xu14ypuuvSOBphjGW6QyK/+gM/SURmchpIR9QfU
         fU4zDi+N2pWidSN3cdFtgzccQNLSUYf0PMWjRda/y5uonW4eZcgYRq8o3/7vCTBrh2Mh
         H9Xg==
X-Gm-Message-State: AOAM531EagSgLjRnrBEZgiywlH688h+9qTZd9dTf5yA5C4RrFfOD4tor
        VvAI7TFTruW5EpWn3iqDb/I=
X-Google-Smtp-Source: ABdhPJwQ39QDE83BARQx/hMdGPMAqiumiQf3BuldyBljX3QpVquvS9qKUoC6ILbsxpAGFTCd0NrwkA==
X-Received: by 2002:a17:902:be0d:b0:151:6b8b:b3a5 with SMTP id r13-20020a170902be0d00b001516b8bb3a5mr26381824pls.27.1646403746761;
        Fri, 04 Mar 2022 06:22:26 -0800 (PST)
Received: from localhost.localdomain ([2409:4061:2bc3:d84b:b18a:7bdb:9160:2b60])
        by smtp.gmail.com with ESMTPSA id a12-20020a056a000c8c00b004e1a76f0a8asm6348388pfv.51.2022.03.04.06.22.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Mar 2022 06:22:26 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
Date:   Fri,  4 Mar 2022 19:51:54 +0530
Message-Id: <20220304142154.2350-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqv8wu7jpf.fsf@gitster.g>
References: <xmqqv8wu7jpf.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <<gitster@pobox.com> wrote:

> Yup, if we can have static and dynamic checks of the same quality,
> static checks are always better alternative.  In this case, runtime
> check would probably be an expedite solution suitable for a shorter
> term to fill the gap, as a static check with the same quality as it
> would probably need some time to develop.

Got it!

> I do not have any particular interest.  If it is a tool fit for the
> task, it would be good to use it, that's all ;-)

Okay, then I would like to research if that is a good fit. Johannes
is pretty confident about it though.

Thanks :)
