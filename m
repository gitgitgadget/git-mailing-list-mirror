Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E18C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 10:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiLOKpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 05:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiLOKpa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 05:45:30 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FD128E20
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 02:45:29 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id i186so2967085ybc.9
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 02:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2PLdy/vXe4UjUado11zWInOoX1DMJCVzvEVazqB+qI=;
        b=cKOxLUbI231tsY0pgnNr9hpsAPJnoihTC2u3NQSeC/soGW7enpPa/W0k/soz9uXfyQ
         H29AXGj8WhI7U1LRkKTo3sIx0DsXvxYXqz/wvwonu+JRcN9ANWubMY7LpObwTJeFT5JP
         lg7OiCXw/bLgiqVCr+ZTngqRSYUx/4Jl6vk6qmJhCVtOsojgAKjmytr56FwX1k7Jr13j
         GnERKlPc9nGTo8oXry3IRi7OOlkIMZGuAR722iM+WqStMlC/YC7c4kp4EzIIPr2pcp2f
         e+VdVQW1CnfIKPFUgK2zM0PL87G7fDkMA7M104Sg79h5KqcE4UJ2HF4o1FwCoqykwjdj
         +XyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2PLdy/vXe4UjUado11zWInOoX1DMJCVzvEVazqB+qI=;
        b=eDwnFDmvOtcJpY/74okltmFn6ViOX6Bkh2dOWxAHiqUPnkl54hdhR59VGPg6Lb+v1h
         xuRdiWG9p9W554qfbzKL6NP2FTr5btH3ymfRFAPcO6EEgMrx4gHBjwg3jJo0fRfJoXKX
         FD8/wTonwOw6NqpcDG7bXk9istHrDz9kDN9TrTV1S5OuhwZyhorQzb/ftcCQ1y6dD7NK
         1Uls99WBP1IdObFVhZNRYWkHwrROktpig8xVG2/unnUMPv67QSgsYYIqJIHq0/y/MqVo
         +ihe4iJT0/Hw+hsfEVq45EEDQHcsRFQL7lL3c8bYpkWIXzJikkzuw7wM2NsRoCLbkj4r
         fUwQ==
X-Gm-Message-State: AFqh2kpzQXeCF46FTD7w0cpxhDdUywDZ2Mf72oQtOILzt5G+AUYDXp+5
        KGRPgY/ATW00eP+RNEAeI+PD5qMfyP8I4BGr35E=
X-Google-Smtp-Source: AMrXdXsHufpaz1a4QHwufi1Whyu87ndqLWWRUZE0r7EDLCi/kLFWY3z4ZoF0CtM80PMIFjTLGB69IVbspNq11mExxlo=
X-Received: by 2002:a25:af4e:0:b0:733:6241:6b0b with SMTP id
 c14-20020a25af4e000000b0073362416b0bmr639435ybj.447.1671101128436; Thu, 15
 Dec 2022 02:45:28 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
In-Reply-To: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 15 Dec 2022 11:45:17 +0100
Message-ID: <CAP8UFD2KT-GnBa1jGjXGc=bH_hQHhO9k0Qw6qBwmsXdsaHxnKA@mail.gmail.com>
Subject: Re: [PATCH 0/6] bisect: follow-up fixes from js/bisect-in-c
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2022 at 11:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> This small set of fixes is a cherry-pick of various miscellanious

s/miscellanious/miscellaneous/

> fixes that were part of js/bisect-in-c that are still worth
> having.

Thanks! All the patches make sense and look good to me.

> Johannes Schindelin (5):
>   bisect--helper: simplify exit code computation
>   bisect: verify that a bogus option won't try to start a bisection
>   bisect run: fix the error message

I just noticed a nit in the commit message of the above patch. It contains:

"Fix that, and add a regression test to ensure that the intended form of
the error message."

And it seems to me that something like "is printed" is missing from
the end of that sentence.

>   bisect: remove Cogito-related code
>   bisect: no longer try to clean up left-over `.git/head-name` files
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
>   bisect--helper: make the order consistently `argc, argv`
