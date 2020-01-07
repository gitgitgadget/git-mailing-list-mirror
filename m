Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090BDC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D189D2081E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjFMgPL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgAGM4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:56:04 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:41230 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgAGM4D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 07:56:03 -0500
Received: by mail-qk1-f180.google.com with SMTP id x129so42493757qke.8
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 04:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A9zsEBFmv0oV1ssg3oqwjc//flAXdFNibwqrNQ/EhWI=;
        b=VjFMgPL2HSPhVAIi4MdtFLucOWYXTBqlXeHj3evA0qkV1RmrSHCYYvIvaDKi+035mg
         H0YU+iKAKe0ebI2JoSeTp4AiiypfMqVjj81E5lO4Tcnp10uUORDXUUBpHsxf97bwrEwC
         KFlsj336qR2Bn/pqsnWNhbrOrZBQ1pR+llIA1+F7HUHEKqOU04AMWux0f0BEaxqYsipH
         PbB2D4witsnAlLDxrK8C9RuJ3UKGFSRVoIsakiTcqkRyS2tAZYMNlZmm1mx1AUiLY1qJ
         Y5gKAe60YDD/XwEx+bGasBEkS7dXdszYPnhcZlNj18M0Mvizw2cxw2Mo4KkfcZuAn7Y2
         KxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A9zsEBFmv0oV1ssg3oqwjc//flAXdFNibwqrNQ/EhWI=;
        b=YX93LZdswKl5SU5wkTlFbvSjsi++Frn0ZYNeyIz5XjD5dcZAsuw7WgCLze/GeQqsO9
         ZOlTgg8Fxc2sSW+CmG60yQErnoXH68V3Rz438VrJPJzIxdgciNcIAaC4QOFasxPyW21p
         BFDpCixG+idJGBt2ElHFp1KhT/5I7BQRcHTvaGpcWnjHv/H1NgsEfjlwt4zi/367UeV5
         h+Ei5IHNVaIbzWvoM90wU6AmOkVqmIX38kQGtLhDXGXCfE8XwZDE3DSAaj2Hw/W6vrFS
         QXX4FdsEXWtDntbDPRQ28xBH8XcZRduAxH9xeDUta/uN/WNVDzqyD4ELn82KuOLZZyE/
         smPA==
X-Gm-Message-State: APjAAAW8JYf7xmfPwVOOX0Xs2/1Xp9e7ClHEk80HWojIPoV2jO3JJQ2S
        LVDAP6BJBgTT+sCQx6OaiIk1eRhm
X-Google-Smtp-Source: APXvYqzdrS82GBolFIHrivYBYypiwNvncFpcuruK3VDiM3rsSSoa2O06jQgcpu2/0nEhNa8nxPFFlA==
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr81267249qkl.76.1578401762488;
        Tue, 07 Jan 2020 04:56:02 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:4018:daf7:6551:6995? ([2001:4898:a800:1010:f14d:daf7:6551:6995])
        by smtp.gmail.com with ESMTPSA id m20sm22288365qkk.15.2020.01.07.04.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 04:56:02 -0800 (PST)
Subject: Re: Assertion in git log graphing [regression in v2.25]
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Bradley Smith <brad@brad-smith.co.uk>,
        Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
 <20200107114812.GE1073219@coredump.intra.peff.net>
 <d694a5b5-9c88-0a34-b9fd-050e5e02c312@gmail.com>
 <fe1cd838-d390-96ab-d3b4-72df5aa61947@gmail.com>
 <CAPig+cRH-yeHmeikf=cbTTMDom+7SLtT2dmya=WP7fsy8tTY3g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3fd8d52c-622e-29a6-442c-66797a3ae1f9@gmail.com>
Date:   Tue, 7 Jan 2020 07:56:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRH-yeHmeikf=cbTTMDom+7SLtT2dmya=WP7fsy8tTY3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2020 7:50 AM, Eric Sunshine wrote:
> On Tue, Jan 7, 2020 at 7:42 AM Derrick Stolee <stolee@gmail.com> wrote:
>> Here is a a patch that reproduces the test failure. It hits the
>> assert, so it definitely fails.
> 
> What happens if someone builds the project with NDEBUG? Then the test
> won't fail as expected. Perhaps this patch ought to also change those
> asserts() to `if (...) BUG(...)` to ensure consistent behavior.

A final version of the patch would probably fix the bug and not use
test_expect_failure. The other option would be to replace every
assert() with a macro that did the "if (...) BUG(...);" conversion,
but maybe that's not necessary in general.

-Stolee

