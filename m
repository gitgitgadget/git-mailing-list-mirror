Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C94CC433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441933AbiDUVZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbiDUVY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 17:24:59 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927694CD57
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:22:06 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 125so6691347iov.10
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zx4jcO3yVYyBlsQdaGjQ/jzNJ95bDxfUU8SeFSvT5JE=;
        b=FbC8HzZnCd0PQ4vWJwVsh5+Y6Gnu2+6CQxTbmIr9SqbkdNDU3IpzAR59l6yEN+ujxu
         ab9sP4NiFJhFrtiYdNBNlxgm5n9qSsMvGH1pXUofXsieynTBr1iBbrRS4PkqcfV0HZME
         AMoJ99fjpz2cy7aIDURkmS7Y97gjLwg0rYC0NlkDHss3BzjgX9JBTfQBHXiYiuP4vkG3
         C2cE+KypdhVyhhe5GML+za8/YZM3Od7QL0uF7+YJN3/j7j4T35EKhWmPpA6Eum3aWY6+
         yTNxy95MJ6CoBAumDqZGLFlwoknTiilo1t5fKIT0Mf2HP3NJUbl108i1qMbt5+vFt1IL
         +07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zx4jcO3yVYyBlsQdaGjQ/jzNJ95bDxfUU8SeFSvT5JE=;
        b=BMlSvvvUtB3lsWcmETh+jQJfWNMwfLIDH7gcSNMuSfejsfk2HC1h+rh9HYHxQSsZAQ
         q5qxvAE8J2njrHmQsMXVYzr7kZSFChlo96Cuuioca476/8+aD8W0XcC88dhLMwMy2gIx
         6PDJrZwI67j185twuCeMw1bNGCtvNecJoGCg8mjIdKgXhwg045eCjiSOvPFhCsubJG80
         H7IubL9fCpzoQl5jVYoLsMNiq+VvXZYtxlFXGedv8Iyjbz6B3tPSljASGSomtrNoLGPC
         +hsc9gfTkSWmJYAyxs45mSrQyyzCwEMyHAyESArThBoQXyTtfKCbMOMpdJBBCJXrr66o
         LcOw==
X-Gm-Message-State: AOAM530yW4IQA7lGkYak5w9c+DsvD073ruywDySpQe0Sh95GDHe60ccX
        x/HODop/yw9QIEBvQeqD2XFyPg==
X-Google-Smtp-Source: ABdhPJy8O3S4IqOD4gLkSsq3wcOH3+Cpbd1wPslWnXydtaZ5nSbyfKRdQr5p+7U2OIGu+4A3fZ/eCQ==
X-Received: by 2002:a05:6638:1306:b0:326:33da:c673 with SMTP id r6-20020a056638130600b0032633dac673mr793748jad.270.1650576125962;
        Thu, 21 Apr 2022 14:22:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c2-20020a92dc82000000b002c9b0f25e62sm75933iln.60.2022.04.21.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:22:05 -0700 (PDT)
Date:   Thu, 21 Apr 2022 17:22:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>,
        Git List <git@vger.kernel.org>, justin@justinsteven.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Martin von Zweigbergk <martinvonz@google.com>
Subject: Re: Bare repositories in the working tree are a security risk
Message-ID: <YmHK/GJ3qa7QuVUD@nand.local>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Ylobp7sntKeWTLDX@nand.local>
 <CAJoAoZkgnnvdymuBsM9Ja3+eYSnyohr=FQZMVX_uzZ_pkQhgaw@mail.gmail.com>
 <YmGr0upicQJML+9B@nand.local>
 <CAJoAoZnd=BKycr0c71-BQJyO3zoymC7p++Zke+OSkV4neweAOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZnd=BKycr0c71-BQJyO3zoymC7p++Zke+OSkV4neweAOQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 02:01:44PM -0700, Emily Shaffer wrote:
> I don't think there is much reason to continue searching above the
> first found '.git' because we disallow '.git' from being committed or
> checked out, right? So this extra filesystem hunting and ceiling math
> seems unnecessary to me. I know I am slightly allergic to searching
> the filesystem for a parent repo to begin with, so I'm sure I've got
> some bias here ;)

Right; once we find a non-bare embedding repository we should absolutely
stop our search. I was suggesting we could stop our search earlier for
environments that use non-embedded bare repositories with a fairly deep
directory structure.

E.g., if you store lots of bare repositories in /data/repositories and
you know that none of them are embedded, we could quickly determine
whether or not the cwd is a descendent of /data/repositories and avoid
the search entirely if so.

> > We'd probably want to allow saying "all embedded bare repositories are
> > safe to read config/hooks from", too. I hadn't considered this approach
> > as a way to read some embedded repos and not others; I suspect the
> > overwhelmingly common use-case would be: `git config --local
> > safe.embeddedRepo '*'`.
>
> Ah, I dislike this option for the exact reason I mentioned - avoiding
> a malicious repo being snuck in next to legitimate repos. I'd prefer
> to rely on exact matching only - but as the config needs to be set by
> every contributor every time the set of bare repos changes, that
> sounds impossible to manage for a project which may be constantly
> adding and removing these repos.

I share your distaste for this sort of thing, but I think we have to
recognize that there are likely to be many repos that embed dozens or
more bare repos inside of them, and asking them to opt-in each one
individually seems like a fairly large request for Git to make of them.

> That said.... I'm biased again, but if you want to be certain of the
> state of another repository in order to run tests in it... why not use
> a submodule for that repository? Not a helpful comment for those
> already using embedded bare repos, though ;)

Exactly, re: your last sentence.

> Thanks for the food for thought.

Ditto!

Thanks,
Taylor
