Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720F4C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiF3WOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiF3WN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:13:59 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074F4D175
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:13:54 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c137so363676qkg.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jxiHY5aqywCpW9S4s0igf3Dr14M/5XwOQBwp3qqQI3E=;
        b=B79mcJPuIhZz24F/0kjfQQJs9uW5RV1VhRnv+WGzfM8RKl7+58alZ9PVagDCyyS9qm
         GUEvoxmYewQ+C0+8AfBMsFG6F1urD0IXFrTc0SIe44EQIoNeRY7TeErb2YiTkH72C8FB
         xHTGOk4553fv4Cdzr7BWVi4Q2z0F4bug7pLE/1xGqNQdMblYIL291YPEu5yfardwJq+y
         p8ykEz26CPJ09PlHaq6NPAGD7WHgUJGD4F6LEsWq/aVaoabDlkaIun3EkPamrlQ0Z6EK
         ZxTnc8MhIkkvr1u1TcryT19ffUGtn2xDqd8RVxXico64ef0+FVFL+E5j8t/l5COjVNUH
         2uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jxiHY5aqywCpW9S4s0igf3Dr14M/5XwOQBwp3qqQI3E=;
        b=Nt9qw1mKCVNkvlJGOPHczi9lOWsAhtaAQoBDvEHlL2xYhCmzbQlp/JdR+jMtin5QpB
         6PKz4IqLMwIGTyqXiUHic4nAadcQe09nUXRpSbSExNSwJZtqppiPRE3Aa71I65B5BrbT
         iXzSSma814VcZkBzeZgU82B4/5TDE+eWvUjpBhXX6WeUMKW8S9oyxAWNlgW9+eFUXVOa
         Pv3ofAtMKhcwkHAGEiw/qc5lHrlvADzxHzHKbF2sI6GCc2uE6E0l77JXtUQmeE9Y7w3N
         cUNT5L9CB6NrNt6nw+K77kGV+ssqeUo28pmcwaB0AZLLVZC9U/x8txNeIrJKlFmMyons
         5Njw==
X-Gm-Message-State: AJIora9DZ5t++x8dL34CH7bp9PtGgiQD1NLvnpVIx8V0DzsZA+ni1XzE
        cDemWjuU2xr9Z6uCyAh3NqxLNQ==
X-Google-Smtp-Source: AGRyM1tQmED5bC3f8ZaV9Vu/kbLLDj2NPp/LQwgtXcP8vs7dm4AgweTW0IqY9sFK4Bsjv+ImokelBA==
X-Received: by 2002:a05:620a:211d:b0:6af:9e8:f08d with SMTP id l29-20020a05620a211d00b006af09e8f08dmr8085339qkl.458.1656627233821;
        Thu, 30 Jun 2022 15:13:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s9-20020ac85289000000b00304efba3d84sm13575310qtn.25.2022.06.30.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:13:53 -0700 (PDT)
Date:   Thu, 30 Jun 2022 18:13:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v6 0/5] config: introduce discovery.bare and protected
 config
Message-ID: <Yr4gIBBWR0Yl9krH@nand.local>
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 06:13:54PM +0000, Glen Choo via GitGitGadget wrote:
> This series does not change the default behavior, but in the long-run, a
> "no-embedded" option might be a safe and usable default [2]. "never" is too
> restrictive and unlikely to be the default.

Thanks for this summary, and sorry for not taking a look at this series
earlier. I spent quite a bit of time with v1 and the RFC patches but
haven't had as much time as I would have liked to devote to reviewing
the later rounds.

I'm happy with this direction. I think "never" is an understandable
direction to go in for compliance reasons, or in deployments where bare
repositories are not expected. And I am glad that we are treating it as
unlikely to be the default in the future, I agree that it is likely too
restrictive for that to make sense.

So leaving the default behavior unchanged, and providing a big hammer to
prevent bare repository discovery entirely seems like a good first step
for this feature. I'm interested to see a potential future no-embedded
implementation, since I think that has a reasonable chance of being a
sensible default, depending on how it's implemented.

> For security reasons, discovery.bare cannot be read from repository-level
> config (because we would end up trusting the embedded bare repository that
> we aren't supposed to trust to begin with). Since this would introduce a 3rd
> variable that is only read from 'protected/trusted configuration' (the
> others are safe.directory and uploadpack.packObjectsHook) this series also
> defines and creates a shared implementation for 'protected configuration'

This concept is new from the earlier rounds, so I'll be curious to see
how it plays out as I take a closer look at the patches.

Thanks again for your work on this complicated and tricky-to-get-right
feature ;-).

Thanks,
Taylor
