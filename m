Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6831C636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 22:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjBHWJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 17:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjBHWJe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 17:09:34 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4A92FCCE
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 14:09:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg26so232442wmb.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 14:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACJZZBRZFCHSYgtR9mLWXKkY1BKUq/Tz0EdNMneMCp8=;
        b=i4BQVGJqLxW8xXJi4QglintkcIbiU1kV4bSNf0ziNhuK4EKfHKOJzUfN52apnoH+M7
         VMVYMQXvSck4lfEi5FoSGymwAHuQUP+bLjza9m5LY72OgsrlEIbHdHmqPG7+mhqdvfXZ
         xjJiOSCH3qNYbmm64s0mQ+vhdv0swb2PjqfEbT4q5qrrK+6zEnLQzH8Y6rrK8bhAgeaK
         oEqHyADhNpyUVdwE4pECfsDokUJZSh136/ph90PC4nRDh6cwXh5LwE5Tasqd5fru91js
         +rrONljAXRVml/NOgZIKIMN0APNjx8vHHt8ecBbv3yZyXLmLZ5AzSXsXindBUCauEiuZ
         rXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACJZZBRZFCHSYgtR9mLWXKkY1BKUq/Tz0EdNMneMCp8=;
        b=u5MFXs5onIJevgy2+9C9eYU88qV/hgaTKJsC0QPGMK2nIJ7YpJJsr4W9jgt/U3zEfn
         WxGIGGPr5QmlJ17DuPCt1Ta6mMO2nxfXqKFv27WQqPMg2Ju7ZX193huxnYPzcsxsXIPS
         IHBGnSVLdGhWyNtOMmQNwXUhoBsg/q3wBxTJSs9jsgKYI4xBa+afgbYE8y04St3sqYdg
         eo7qXo1umsKay5xcYS+/sxVP6uAEyH5VPe6fzLZlWJo1fOI+aJoLun2Qz/BYEuEgdEcN
         17kFinMlDz+dhvmPs3cr8vG3p1cxi9C20c63eUuGi3JEtbFrq3OvjrEfrWXl9FQXpwPH
         sqVQ==
X-Gm-Message-State: AO0yUKXvwCTGBFMVS9tbL4SikzM0AQKxHheIarsmX/ELhhCfQZgF8+Eh
        cOzWJ/1y4PDyDtpk3zBPXql3l/K/Ovk=
X-Google-Smtp-Source: AK7set/0MpYXyOjOVpT6WsxhMZjWLWb7pTCB5pg8VmLIazJBy21/R2dq6P2WqIdH3sgsHzEtwQtWJg==
X-Received: by 2002:a05:600c:4383:b0:3df:f7f1:4fbe with SMTP id e3-20020a05600c438300b003dff7f14fbemr7889767wmn.1.1675894171751;
        Wed, 08 Feb 2023 14:09:31 -0800 (PST)
Received: from [192.168.2.52] (141.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.141])
        by smtp.gmail.com with ESMTPSA id bg23-20020a05600c3c9700b003dd1bd66e0dsm45236wmb.3.2023.02.08.14.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 14:09:31 -0800 (PST)
Subject: Re: [PATCH v3 3/4] rebase: refuse to switch to a branch already
 checked out elsewhere (test)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <5b0d5b6e-5055-6323-1b6c-fe98137e81f6@gmail.com>
 <230206.86wn4u6859.gmgdl@evledraar.gmail.com>
 <4580b825-b117-4581-4ea2-ab30e350b6ad@gmail.com>
 <f4be3c97-eb15-790e-9746-96d0c9bbc5a7@dunelm.org.uk>
 <19e3e0d9-406e-ac2f-c43a-b4e994035529@gmail.com> <xmqqk00svimy.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <c1b3dc07-f3d3-273e-6486-9aa709b1c269@gmail.com>
Date:   Wed, 8 Feb 2023 23:09:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqk00svimy.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07-feb-2023 21:19:33, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > ...  If the tests fail, I think it will be easier and
> > less confusing to reach the original commit where the implementation was
> > done if we keep them separated, rather than combining all three commits.
> 
> No, if the test were in the same commit as the implementation, then
> upon a future test breakage it is easier to see what code the test
> was meant to protect, exactly because it is part of the same commit.

Yes, but my reasoning was that those tests protect what we did in 8d9fdd7
(worktree.c: check whether branch is rebased in another worktree, 2016-04-22)
and in b5cabb4a9 (rebase: refuse to switch to branch already checked out
elsewhere, 2020-02-23), not die_if_checked_out().

> > I'm going to reorder the commits and change to use test_expect_failure().
> 
> Do not do that.  Adding a failing test and flipping the
> expect_failure to expect_success is a sure way to make the series
> harder to review.

Hmm
