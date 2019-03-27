Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071F120248
	for <e@80x24.org>; Wed, 27 Mar 2019 10:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfC0K17 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 06:27:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46403 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfC0K17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 06:27:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so1217563wrw.13
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DnpnsJRR78z8RjIgJ6mxT0o43uso9ZG5CAPykzPfLUM=;
        b=ReC/EE+sB7Mzp6hHAQcRUxWEeWs/J+ZVsFh0EwygHDlGO3eYINtQXON16UQ5Dpxo9K
         OXYPVUmnahD2hj7c7R+2hZcPx3i9fkUs6aiSf+kihyAu5zcE0eCrfLoYzgMnVsgFl44s
         a/FQXmIz5HhJ+EyvyfFmIZj9snqegaIrljFgJ5l5jAX104bRgleeNejst6scpO5cWRMx
         ANTTOcaeh/JSkQ5x6qlKlVe8paRwz8zgXyURcgywB4o4+q+0PKUpDl03pZDJveyAg7V0
         1h/0YXn96yq+nnZnJMWTPV21rC/oYmMydTQn+WzLsaJiPKy35WvRykReQKRCubV5FXBj
         6ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DnpnsJRR78z8RjIgJ6mxT0o43uso9ZG5CAPykzPfLUM=;
        b=pRABilzi8RifCuJY5y5Q290CUBDf34DmBuZjTEs1busBK1NqAkFI+RdUgIKgw9dewd
         ram+TI2RfHjerNKtJ4LYkvaQjoOWx2q4WCbCsJ9dw3Xp47zG8Iwk7F/C4+EiebxV7V6R
         AL/A83nhXEIrW0HtgsvdSByZSFOUI816KJv3nOaxaFjKHKU6BiyoRRIIdPIgF/YjtZPV
         vxlaUMuwVQdCwFnPMwfTAGV/D+jqmZOljFQC6sm3BmdFbDSqi7jk2yd1bwNye7dGJIAV
         KFlK8m/s8Ya4dTrUgc1gthpTx5Jp+D9srQLd1i3g1UQUXeqIodZNSdQloMKllb/5vp65
         p4sg==
X-Gm-Message-State: APjAAAWjgNt8JcYWAei9kt0wVOpdyGx8dzU7QRBTtjeUkl9T6s/+mm/8
        ZkaLiwxsntL/LN5qL5vvwtBhzmO2
X-Google-Smtp-Source: APXvYqxDKFmNOGade3DgbD1D981EkQ3+LxcGURXdJ9danmGq0oNVHz5voZoJpESx/zqZ5TWiPIeQCA==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr23157598wrx.32.1553682477412;
        Wed, 27 Mar 2019 03:27:57 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id a17sm37704261wmg.40.2019.03.27.03.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 03:27:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: [PATCH 1/3] tag: prevent recursive tags
References: <20190325233723.GD23728@sigill.intra.peff.net> <cover.1553586707.git.liu.denton@gmail.com> <c371a653b4049256f3427e467b144385ee47ef43.1553586707.git.liu.denton@gmail.com> <CABPp-BGKWxJVGfQC3imj8Z6RHxQ6zLOGRpkOjyn93a3RxmE0Lw@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CABPp-BGKWxJVGfQC3imj8Z6RHxQ6zLOGRpkOjyn93a3RxmE0Lw@mail.gmail.com>
Date:   Wed, 27 Mar 2019 11:27:56 +0100
Message-ID: <875zs4boib.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 27 2019, Elijah Newren wrote:

> On Tue, Mar 26, 2019 at 12:56 AM Denton Liu <liu.denton@gmail.com> wrote:
>>
>> Robert Dailey reported confusion on the mailing list about a recursive
>> tag which was most likely created by mistake. Jeff King noted that this
>> isn't a very common case so, most likely, creating a tag-to-a-tag is a
>> user-error.
>>
>> Prevent mistakes by erroring and providing advice on recursive tags,
>> unless "--allow-recursive-tag" is specified. Fix tests that fail as a
>> result of this change.
>
> Any chance we could use the term "nested tag" instead of "recursive tag"?

+1. "Recursive" sounded wrong to me, but I couldn't think of the
now-obvious alternative.

Some grepping around shows we use "nested submodules" fairly
consistently, and in gitrevisions(7) we say the peel syntax will
recursively peel tags (but don't call them nested).

So makes sense to refer to the object type as nested, and when we're
referring to the operation that'll iterate over that nested structure
say it'll be done "recursively".
