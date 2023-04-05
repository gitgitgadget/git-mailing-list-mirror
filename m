Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A74C77B6C
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 09:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbjDEJbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 05:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbjDEJb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 05:31:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BC15FF0
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 02:30:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50263dfe37dso1330772a12.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680687029;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6bB9DRpIAxgK4rzrojtHGMAg3nfu7+vD79wG4Ff5YGo=;
        b=DaRdBVF7jAZGFXqDQD6ZwMHxyt4G7jYMp0aDBlsORVog6/7+pwKCg245rc3Lj9EC0/
         TD0bgF+pUsUi1YIwhl3fBhIYUZoJx81FS6BtYucU/F6aMZWg75pEcB6Ab6cquuYovz33
         wgkN+MlvIhXmdCFV8ZTIezYoKQln5Gc+JUcvEKtxGU/XobFfHqhhIaKekC4rLXG9/iz5
         oSC/BmljmR+DWd0+qvofjt1HN0NMiY3zjiSAyt/3Z28HX6gkghDA3R4+zoxYiYDDKRdy
         VQ5zYyQc6Zvp+hYEzgH2sZpMhmE634WQ8bwFhUcQ3LCR6jMX6funpZxZ2Zmb59mW/GGY
         2e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680687029;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bB9DRpIAxgK4rzrojtHGMAg3nfu7+vD79wG4Ff5YGo=;
        b=PUCi6drsW9bES32tMME2XEYirqz1a7zbNfPLRZAHG1Fa+DBKUntGspzJWGo/EWrG9K
         e8ddCnRrpvnyeUcbJzhQCoI+7nNOQweIwEGyb53e0VZpEMQIVi82nz0xmtutvlKJTk7z
         3+ok3k3YneNtpKsSS31OnGmUV+Fjmaun+GHop/9p1V2oiSaXX9RqGQVlrlFNao4q/0qA
         TPX04D2Fb4y45n4oL9ZFuTailsyuGhqd9ACUTWyUBDe1535tcDqaPAQvQrpGXBDcccZu
         CEf7YlI0sjss2AqkRcELV1VNS2ouVjk+t9lWTUAMn0fXf7gcdjY+czJONk3VsPZOorEa
         TLyw==
X-Gm-Message-State: AAQBX9egTTpd04gJBUp34HZr6nTfFah/4iLF2OmnzT/jqXw8zkObUiiQ
        5moHeZJQD3enJDIkW7TIf21XqyhTCuc=
X-Google-Smtp-Source: AKy350alIrPHMKsVcx1LUKIQNv6oMmLcFyJX+zCj/qSdMQxIYPMv+Vx5XaqXQxJjW9buxA8I1WOvxA==
X-Received: by 2002:aa7:c0d1:0:b0:501:cf67:97fc with SMTP id j17-20020aa7c0d1000000b00501cf6797fcmr1074874edp.10.1680687028490;
        Wed, 05 Apr 2023 02:30:28 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id x43-20020a50baae000000b0050299cebf6esm4706422ede.54.2023.04.05.02.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 02:30:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pjzTH-005K9B-2C;
        Wed, 05 Apr 2023 11:30:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Daniel =?utf-8?Q?Mart?= =?utf-8?Q?=C3=AD?= <mvdan@mvdan.cc>
Subject: Re: [PATCH 1/2] Add fetch.updateHead option
Date:   Wed, 05 Apr 2023 11:28:56 +0200
References: <20230405012742.2452208-1-felipe.contreras@gmail.com>
 <20230405012742.2452208-2-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230405012742.2452208-2-felipe.contreras@gmail.com>
Message-ID: <230405.86bkk2vfpo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 04 2023, Felipe Contreras wrote:

> Users might change the behavior when running "git fetch" so that the
> remote's HEAD symbolic ref is updated at certain point.
>
> For example after running "git remote add" the remote HEAD is not
> set like it is with "git clone".
>
> Setting "fetch.updatehead = missing" would probably be a sensible
> default that everyone would want, but for now the default behavior is to
> never update HEAD, so there shouldn't be any functional changes.
>
> For the next major version of Git, we might want to change this default.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/config/fetch.txt  |  4 +++
>  Documentation/config/remote.txt |  3 ++
>  builtin/fetch.c                 | 64 ++++++++++++++++++++++++++++++++-
>  remote.c                        | 21 +++++++++++
>  remote.h                        | 11 ++++++
>  t/t5510-fetch.sh                | 31 ++++++++++++++++
>  6 files changed, 133 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> index 568f0f75b3..dc147ffb35 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -120,3 +120,7 @@ fetch.bundleCreationToken::
>  The creation token values are chosen by the provider serving the specific
>  bundle URI. If you modify the URI at `fetch.bundleURI`, then be sure to
>  remove the value for the `fetch.bundleCreationToken` value before fetching.
> +
> +fetch.updateHead::
> +	Defines when to update the remote HEAD symbolic ref. Values are 'never',
> +	'missing' (update only when HEAD is missing), and 'always'.

Missed the first time around, I think it would be useful to explain the
historical behavior heher, and why it's been in place.

I.e. that we use this during the initial fetch/clone to find the "HEAD",
for discovering the default branch, but then proceed to not care about
it after that.

We should also link and cross-link to the other recent-ish config
options (whose name I'm blanking on), which implement the "take the
remote's suggestion of a default branch name" here.

