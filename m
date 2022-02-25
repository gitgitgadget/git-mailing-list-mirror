Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20290C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 11:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiBYLoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 06:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiBYLoi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 06:44:38 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A701E1120
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:05 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id d10so10268949eje.10
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=JTjy0DZedaQ+su1xSxHpuJjb5gsVywWO8ynLmCjJDtA=;
        b=q2+PiLXUPNwL9zzQ86pwCT3Mz78AFFDAQJkIbkMwV/Ihtlab8dnb4zZ3j0lZOQ+Xeg
         U2J1oQOKtLaVz0czYkyPcL2SWDsqJDUrS9vIVQ9Kog8CJMpWMMJrtb/lrfiUENtG7pGm
         XPYtR9dk6+0fv+ioAM1f/Lc6uFbNFsTL52/JhYdFmj+WLuuknhYo0iTqMN55JAkeCj3B
         PEZoRvtSPoOHfYTBBPLZRryZU1x7TfjJlc3m/ZUo+aO9PYbwPLsXNCD7Ktk6gmqTzRaK
         Hl3N8sZsznOaD7YbJO1T589ZqlYbiOQ97UA1JtoSmFVo7HuVC+banGcjRLP0Nthyo/Y5
         bFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=JTjy0DZedaQ+su1xSxHpuJjb5gsVywWO8ynLmCjJDtA=;
        b=cF5YkKyCAxG8GCWQvqeFnT9fjdcxjuvNXFEYdqJJ0TUcR4ByAYK4ftnZzSZdAS75CS
         bemcp8kakE93CvLJSCZ+J/HUHqCY9BgMoPwokNytOBRNmEj9zYdlgwVbSRHK0i0IgK94
         +Y0wOVEFnXLENnZuodPKMEuu3W6PeIW6EGbyyedwV7H/EY3mb3X1fKuMVVZaMYq1/+RO
         WkPBEt7PIft6nrSL7/I/syqAD7qv26Radkb8EraacUIPBXC2CraU1rDtPuvcxrzq8BTo
         BmoF0EfAXKQIwJFXwvaKmePexrkj/UXMlMZRB1nD7rsAgK4p3Q67Lfajq1s0EORZ8v0C
         88Cw==
X-Gm-Message-State: AOAM530AqrnCjRQb4NiO4fUtSrsvY/0jWdqAG3m22Eaj6rpkqp0GZXhE
        lYj/UsyJ/9RXd4sqrQga2jyF9XpXEyMK0A==
X-Google-Smtp-Source: ABdhPJxsW7XYLXBPRAl14kJ6gW6gL9C7YscHcJtDpWCf/u0fxXq1+yOYnVvrlvYCXtCOvleoQwH+AQ==
X-Received: by 2002:a17:906:2991:b0:6cf:6b24:e92f with SMTP id x17-20020a170906299100b006cf6b24e92fmr5744894eje.748.1645789444110;
        Fri, 25 Feb 2022 03:44:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906341700b006ce41e20023sm892666ejb.173.2022.02.25.03.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 03:44:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNZ10-000UG9-Mp;
        Fri, 25 Feb 2022 12:44:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/10] t5526: create superproject commits with test
 helper
Date:   Fri, 25 Feb 2022 12:42:46 +0100
References: <20220224231420.2878760-1-jonathantanmy@google.com>
 <kl6lfso74pzm.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <kl6lfso74pzm.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220225.86pmnb8931.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 25 2022, Glen Choo wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Glen Choo <chooglen@google.com> writes:
>>> +# For each superproject in the test setup, update its submodule, add the
>>> +# submodule and create a new commit with the submodule change.
>>> +#
>>> +# This requires add_submodule_commits() to be called first, otherwise
>>> +# the submodules will not have changed and cannot be "git add"-ed.
>>> +add_superproject_commits() {
>>> +(
>>> +	cd submodule &&
>>> +	(
>>> +		cd subdir/deepsubmodule &&
>>> +		git fetch &&
>>> +		git checkout -q FETCH_HEAD
>>> +	) &&
>>> +		git add subdir/deepsubmodule &&
>>> +		git commit -m "new deep submodule"
>>> +	) &&
>>
>> The indentation looks off. Also, no need for "-q".
>
> Ah thanks. I think the "-q" is there to suppress the detached HEAD
> warning, which is very large.
>
> I'd prefer to keep it unless there are stronger reasons than "it's not
> needed for correctness". 

FWIW I was going to comment on the -q, but didn't because you're just
moving this around.

I think even for large warnings it's fine to omit -q etc, since that's
what --verbose (as in the test-lib.sh argument) is for.

But in this case it's probably better to leave it as-is.
