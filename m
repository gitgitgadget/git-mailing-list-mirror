Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD97C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 22:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbiCAWFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 17:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbiCAWFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 17:05:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9886165482
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 14:04:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id bq11so23864285edb.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 14:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2qJ3sWz5AMCcWA7dYF4c+e2eeXFTOkDm+P0JqdC+8Pg=;
        b=KtbXj7DeynoNd8PKK89eBce1rbxxdgf2j5+Mh0TjOtOW60x/tx9teCN1WrcArEwU9b
         mNLHywmGU9BpqmCU1AJKAEYg3tPgqpYOtqK3zBOTXiHSqe/P8675fWOZiOWluBLeA/NE
         39pTZ26jvTByEe7HvK1t717MX8aCuioszOp8vnZpoF5qwZ3QATudM0NsRyxYjiiXFQvQ
         2DkFzEBHr6twB9/hckOUacPXV/uXtqcs7pfJANKCvl3ppw0nIfC416jDbQaBcF3O1hm0
         /2tX1lxM6JQzBvejEu07orMTOX7eUICwIcRBftPLkkcO4wXD0eQvbiWh4gkg+rdw2Ikr
         NWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2qJ3sWz5AMCcWA7dYF4c+e2eeXFTOkDm+P0JqdC+8Pg=;
        b=DXxdJvBHK/RdXSDckfDU8Uc//5AOcMB9l63nBHIpGj465lNDuqbWH9lIYxDkDF/hd6
         TlcLkdDuW9yoiCnNbr5zFxze/cYOURwyTIriIC15pt/lZUeT5JstvnyzYmvEXQ5LDrrX
         2PWiWCmLQ1eVEhFtKkoPJZ7w7VV4tNN+n/WQfdMOy1ASh34jVMStaGLaEdcP3VACsGCt
         PmSyy4Cr5fhj09zTLVqHOisMXCuD0aViOMGPuh6a1SRK6Vkscf+BJKX9yE4keQM3R+Y8
         cjiO7cdKdq8QE9SxZvsO3O2TnWgt7p6hbaQuMYBv2ESg8IUXUgmsPk2dQjIX6pudo7WI
         ptug==
X-Gm-Message-State: AOAM53205mcIY2jV4UupF8r8IWI6iFoWAWwCBznEkLlmqVT9bndase1l
        iBXj6eaJKK53g+XpPw91rX2LdnXr58M=
X-Google-Smtp-Source: ABdhPJzqSSSYJYxYe1pfpqMCjGXjxytLIg0wGmgAVnlAIguzrWIc5pN0YUgpIC5eDvI1lO30Y6fz6Q==
X-Received: by 2002:a05:6402:40d4:b0:415:b355:a72a with SMTP id z20-20020a05640240d400b00415b355a72amr869307edb.153.1646172258948;
        Tue, 01 Mar 2022 14:04:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ee21-20020a056402291500b00410d4261313sm7581842edb.24.2022.03.01.14.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 14:04:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPAbR-002Hmk-Nd;
        Tue, 01 Mar 2022 23:04:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] parse-options: make parse_options_check() test-only
Date:   Tue, 01 Mar 2022 22:57:17 +0100
References: <xmqqtuck3yv2.fsf@gitster.g>
 <20220228073908.20553-1-chakrabortyabhradeep79@gmail.com>
 <xmqqzgma287n.fsf@gitster.g> <xmqqr17lphav.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr17lphav.fsf_-_@gitster.g>
Message-ID: <220301.86pmn5z5we.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Junio C Hamano wrote:

> The array of options given to the parse-options API is sanity
> checked for reuse of a single-letter option for multiple entries and
> other programmer mistakes by calling parse_options_check() from
> parse_options_start().  This allows our developers to catch silly
> mistakes early, but all callers of parse-options API pays this cost.
> Once the set of options in an array is validated and passes this
> check, until a programmer modifies the array, there is no way for it
> to fail the check, which is wasteful.

That's not true due to the "git rev-parse --parseopt" interface. I'd be
happy to deprecate it, but I think the last time I brought it up you
were opposed, i.e. it's documented as plumbing in "git-rev-parse", and
it's easy to have it hit some of these BUG()'s.

I see the benifit of Johannes's suggestion of checking this once (but
with t0012-help.sh etc. we're nowhere near being able to do that).

Now this runs for the whole test suite, so our tests will have the the
same behavior.

So it's just an optimization? Isn't it premature, if you run
parse_options_check() in a loop how many checks/sec can we do? I haven't
tested, but I'm betting it's a *lot*.

So aren't we shaving microseconds off the runtime here?
