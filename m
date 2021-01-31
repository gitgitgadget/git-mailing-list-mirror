Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258D2C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65BB64E11
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhAaU2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhAaU0f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 15:26:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F8EC06174A
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:25:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j13so16580558edp.2
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=8AHBVJssYVEwgY5WH6utw5ZBqJR3rTB0rAFR+uuUAok=;
        b=M4XM2UxPj2czXtArm7g3G4HRth699NC/tV0mM+K3pHuhEzbGYUBidVMrVrcHoB0VCQ
         6lrgu9flrNr/bUBKWsRQ3946axKONxBmt13RlLwDacf9mEb04BejP9xg6YWxyGAjZrEe
         lc+D6MYHCFOIu7Pc69rhdjbXU3DQCEB1nZSxCIpOasQE08uJlIbwQIwsnnUKntedLmS0
         IdRb4d9BDyeRFZid2OrUW3llm/Ee84EnxmIFby2vkgfh3CSJnwZGOQVYHkbNGZqvOJNO
         Kg9WhhP1bTrP+nEqGaaPvaY92NBsc5d5QdDhmViZNARxw8zrsbKAkCyEsBIQ1gwBAeoN
         KpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=8AHBVJssYVEwgY5WH6utw5ZBqJR3rTB0rAFR+uuUAok=;
        b=KzwAS4Je3pe+5iKqO5hRS6iGBIr4UtaOHm0rHHJ6JrHCseP4crCfxyO0ur3Udkhc6l
         k75ITdV+QBapneavg8iD5MVt19A7Qj5c93W5p96OfJlL+zvyPI0f/zMhBwunekq7UfdV
         ho2HP/sjsMyHOGhr1KVPQxYDU1Xzg/Dd9ZO1rQkMKJQllkFMauy7D7Ib6AkRS3wz9CYG
         TU8QTsKh7PWzBdk/VaXr38niB9LpJtPushu/BvbOLrM48B+CvOpdkTO9K2+8MEmnAACu
         krIjWl8srYxY88CJ86ci2xB6XcbxAyR6fJjtUwzyO2N2U9JO7uwgDLDLt9HtSX9h6Psz
         u1xw==
X-Gm-Message-State: AOAM531nEyAlwQrjx5kWFlkYb8gbD1GHhXbQWko2Gu6+l8avGv+n4724
        Ho3tBTXjj3xtCdzNx95S9cw=
X-Google-Smtp-Source: ABdhPJwGzwSVYHdZYz1K4CafTkOtrwYYdSyRirZxdIWchSQ5bEYaIb2z0mR9VH+il94DEQL9YmQtUA==
X-Received: by 2002:a05:6402:1a56:: with SMTP id bf22mr15798358edb.284.1612124753674;
        Sun, 31 Jan 2021 12:25:53 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id w18sm6890858ejq.59.2021.01.31.12.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 12:25:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH 4/6] doc hash-function-transition: use https links
 consistently
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
 <d4abf1cf78e2e59e49b81bd458d85848bd3d7ff3.1612093734.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <d4abf1cf78e2e59e49b81bd458d85848bd3d7ff3.1612093734.git.gitgitgadget@gmail.com>
Date:   Sun, 31 Jan 2021 21:25:52 +0100
Message-ID: <87tuqwonu7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 31 2021, Thomas Ackermann via GitGitGadget wrote:

> From: Thomas Ackermann <th.acker@arcor.de>
>
> use only https links in References

Per my grepping this leaves just 2 more such links, in
t/t0021-conversion.sh, in the whole source tree. Might as well convert
them while we're at it...

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/technical/hash-function-transition.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
> index 2eba25cf87c..dc0c4976a62 100644
> --- a/Documentation/technical/hash-function-transition.txt
> +++ b/Documentation/technical/hash-function-transition.txt
> @@ -831,8 +831,8 @@ Later history:
>  
>  References:
>  
> - [1] http://lore.kernel.org/git/CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com/
> - [2] http://lore.kernel.org/git/CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com/
> - [3] http://lore.kernel.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
> - [4] http://lore.kernel.org/git/20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net
> + [1] https://lore.kernel.org/git/CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com/
> + [2] https://lore.kernel.org/git/CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com/
> + [3] https://lore.kernel.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
> + [4] https://lore.kernel.org/git/20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net
>   [5] https://lore.kernel.org/git/CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com/

