Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F41C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjBFXQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBFXQg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:16:36 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9154191
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:16:35 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso11950589wms.5
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KluBwjdWFOEyfhxDaJT9dVJzoP07iPLYvUtwCnWEIfA=;
        b=dh7/jkT4ioGy+7ZqD77un/SPDf9U9OQRyEqZ9xNRKXRwtBaq7qO2mEXRhOkYe5eWLZ
         yd76fM8OnOYiRbPcaLo9E1GlAYTuS42eJKTGBVCsHv/jxejf0DvsHIHnlLnJgJELDb9V
         nlR5q5Shq1IB+KCAPZrXL6hOgb2GixblzcP9eex+4QuPaCc2QoxMY1NuOxWZmeqhNgfI
         l/Etotd9cJyOrFsLjJlqut8p59hfuwxgfPu0j2/thHnrfGatkEZMqnZa07U4p4EY7C4t
         Cc874DL06uY4f++43E/f/5gTExZzImz8ibFdK2/5cauuEvkKiiFoxQ30ex1LdzpnT+XE
         59hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KluBwjdWFOEyfhxDaJT9dVJzoP07iPLYvUtwCnWEIfA=;
        b=zZulq88EqQNKpbLHv8gmPd2i4zeHIcV8+F+hyehhRIGqkPb6KYGZv2CNAl06mYt6W+
         21nAsb/XZ+4OiC15H8Ry7iQRK+/KKi3T6m482VK/iTfxgEK3W6isrAli//we51AFAaeZ
         Hj1F7YR4yq14M3KzFL5MamdkambAP1Y5hHlicD0Bk9gvVYUaeXX6V6tfAVbaJQKBP0uz
         K+P27Q/bD+VsM0wqHq4twRedzlapfm0XWRySZvzV8M5JQHpXSiGuBPqsp3xmvl3ANu0i
         ILHRXQxib7RAK0u4rUeS2FjclyZqGKsfyE/pEPIQtnGQGBJlsPxLpz8pb0xuOqcyGRla
         VxZQ==
X-Gm-Message-State: AO0yUKWwbGRykxNpNt+KS5VyyiyJfxi8Tp7OJbCvmzqQ95BDOdd2mHdO
        MYnYQc3IHrkA5Nzs4yCXxHQ=
X-Google-Smtp-Source: AK7set/t9Nh3aR7jgXP9/VirRU8O5XEnSallGXM6BWDeYuHkCKjszkFWbxjYO6j/bMuJuUOREl85XA==
X-Received: by 2002:a05:600c:5028:b0:3dd:1bd3:4f6d with SMTP id n40-20020a05600c502800b003dd1bd34f6dmr1185737wmr.32.1675725394346;
        Mon, 06 Feb 2023 15:16:34 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003daffc2ecdesm17098439wmc.13.2023.02.06.15.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 15:16:33 -0800 (PST)
Subject: Re: [PATCH v3 3/4] rebase: refuse to switch to a branch already
 checked out elsewhere (test)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <5b0d5b6e-5055-6323-1b6c-fe98137e81f6@gmail.com>
 <230206.86wn4u6859.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <4580b825-b117-4581-4ea2-ab30e350b6ad@gmail.com>
Date:   Tue, 7 Feb 2023 00:16:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <230206.86wn4u6859.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06-feb-2023 17:59:11, Ævar Arnfjörð Bjarmason wrote:

> > Let's add a test to notice if this changes in the future.
> 
> I for one would find this series much easier to follow if you started
> with this test, possibly with a test_expect_failure, and as we fix the
> relevant code flip them (both this and the subsequent one) to run
> successfully, and include them as part of the commit that fixes the
> bug).
> 
> Maybe there's reasons for why that's tricky to do in this case, so
> please ignore this if so.

I'll give it try, I like the idea.  Thanks.
