Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E64CC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 10:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiCCKBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 05:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiCCKBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 05:01:36 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FD517583A
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 02:00:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s24so5894000edr.5
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 02:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YyR1rmMgL1YoPQjz/WDsChxfWtqZa+waYul/4b2/RcU=;
        b=aEI1auvKLyaciaANmgJUFdO+C4omGg8bMajNk/WFNw3LvpJ7UZVz8c2ceXEJCms9UJ
         t4Ey/d8ghRms/yKQzkqe6ePsnumwSC9QlyU+T0nybnC+S74FLJqqxAXzah1weUsf1Kpo
         M2L1vTpr9bjjGj+Qbfe27jM0tSyLAuGNmNKjcVvLYGcVkdpin97olE2SwL0fBxSr5RXq
         euYDX5nr6OnAxY8gZBP8JEXBbmaJ1cDednV4ycA/3MMcIuWTAZKsY1fbXYO40XTw03ES
         D6ykTHHyeEitHbz5axgmj60BWYHmEoM7zDvxjRrsZff790lGCbpiRLTwO53Ga4V+Fhrk
         aa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YyR1rmMgL1YoPQjz/WDsChxfWtqZa+waYul/4b2/RcU=;
        b=7vmyr2YKEREny74Ux3vZXFx1gWwMFFlChpyY1dSLM6K2Vk5YJW5Ez2SGGZRAisxwv3
         UrC+q767mOi1ZthgDzOAYvqnQoNcTk7LQUV8wtX8eb0aPpiNuP4J8Yn0HXPFvQb6ydn3
         X5q1yhl05+kE3uVTWScX6fCIzyHm1vmoSiqy5TzymxSrXxFwhiWNIlA7yjBYdHMEm9am
         U53n+Ol9bbO+svMSOPlTincaxwSHlZF5kpsdF5bmBFHLcJ6pO+Tj6fCKoXL6rxitZi/T
         YcKtZ3fbnHztoUnUXMOqTtup2YnnLXs0thPjJDeA5r/ISpztAVTzTC3SMacRJ5ybf71e
         PC7Q==
X-Gm-Message-State: AOAM5303V30+iqYAIVhj3Dj4zXy2GuiwXAEG7Tph7MuirdvreR2XTm+M
        kR17wcLdFvEx+XB0s/ALWstl/lF1y+frBw==
X-Google-Smtp-Source: ABdhPJxkfnD0lZvkiDse+qK4cKz5GEX+yCSzJTjn5Oaci+xZK3fGDRoA0/KTaKggONuHfMdQWoIvmQ==
X-Received: by 2002:a05:6402:1941:b0:413:2b7e:676e with SMTP id f1-20020a056402194100b004132b7e676emr33983301edz.114.1646301648905;
        Thu, 03 Mar 2022 02:00:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v5-20020a056402184500b00412e1a73c7bsm637334edy.61.2022.03.03.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 02:00:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPiGM-000Oy8-Fm;
        Thu, 03 Mar 2022 11:00:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 00/13] submodule: convert parts of 'update' to C
Date:   Thu, 03 Mar 2022 10:58:57 +0100
References: <20220301044132.39474-1-chooglen@google.com>
 <20220303005727.69270-1-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220303005727.69270-1-chooglen@google.com>
Message-ID: <220303.86sfrz5p9t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, Glen Choo wrote:

> Original series: https://lore.kernel.org/git/20220210092833.55360-1-choog=
len@google.com
> (I've trimmed the cc list down to the 'most interested' parties)
>
> Thanks for the input, =C3=86var :) This just fixes up a few small issues =
in
> the previous version.

And thanks for working on this, there was a reason I was down to
nitpicking in v2, this is looking really good & I can't find any issues
with this iteration at all.

So I'm happy to give this my:

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Junio: It would be great to get this advancing to "next" so that the
subsequent set of migrations to submodule-in-C advancing.
