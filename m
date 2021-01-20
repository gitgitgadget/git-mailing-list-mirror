Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB53C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 13:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3256C2333C
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 13:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbhATNAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 08:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390028AbhATMnj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 07:43:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C86C0613C1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 04:42:59 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d22so14570920edy.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 04:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+TxPVWKxaYzsFzB7IX+47PCPHyzLB/qWFdcS00upu70=;
        b=KnW95a3dXY2Ceeb5k+Nk9yeGPAlMCitxNgKfAzn85f6yGcQgI5YXszndYpzPBJT+m7
         pbUdg7YMPXIh8xXhujQ/7wnI2Xpxwr0MHmEg10tXwidLM5olyjR4uwFwDP28Ky+eH4Ol
         1rpmGqxLJTPlAM4zYS2NLRv9zOjIl7YioDJbEbSvWw2tCXsa2WgXlgX2xXNWCjTvFylN
         0odoqECgd4nluoPQ7t/Q6JAJn5mimtQaaxrxtzRsYvAEJ03AirOn6+Zc/e6YU4h/+xVX
         r6xJe6ETsX9auzAy6ONIFiie24F/udiutibM3lIsvrgIAOHvO6Gba/hJrkBuIB3CDRus
         cGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+TxPVWKxaYzsFzB7IX+47PCPHyzLB/qWFdcS00upu70=;
        b=HwO19oNerGgK5AlkqkT9KV0DZIhRGfCEc09K06Ma2oUjjm3cHIcXbQmZv1s/vQZhd1
         akqxGuDcwsMs9fHumtGv67hxCAz0ISk50cAg12GHNLZc11Km2Kx6RKgHE4gukMtWC54x
         HHvBysSZ0AH0YAhBtli463QPmKD4RDvSwarya256EIRgYxUJbEIRdGPsoM+Ik3DN4es7
         UMnf6+gMPsOZ8FJye0Xj3e2d4OcTf8KvZf+6SBTT6KFTU+c2jwq1MelCgkjQn7nV1mLj
         aXlsWForM/z/ZOaHl29z5RsvjLRtEu1OTWwEEmgRaeQF/Aq3P17MdNd0IIEoMefp/Xye
         xISw==
X-Gm-Message-State: AOAM533RoOcz/LmkFV40YduY2HaP4XQEC7uC1l68NZHD3e8Xxwlmed5I
        LWUMXK5rhjYrS6NQNNqjn+vyzmrfV50=
X-Google-Smtp-Source: ABdhPJyPYAboYpjItdVT+f12vkOJfuUVfGr6pNl2rU8+gWDAoZiPWXWIiwHJRXG6ADCjiobzRyn8eA==
X-Received: by 2002:a05:6402:8d9:: with SMTP id d25mr7090525edz.278.1611146577977;
        Wed, 20 Jan 2021 04:42:57 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id zg24sm853676ejb.120.2021.01.20.04.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:42:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Harley Paterson <harley.paterson@hotmail.co.nz>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: False negative authentication with multiple accounts on a
 SSH-GIT server
References: <DB8P189MB10460B9A3CA31ADF5C05A39FF9A30@DB8P189MB1046.EURP189.PROD.OUTLOOK.COM>
 <YAdnJabiJlu9Qlli@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <YAdnJabiJlu9Qlli@camp.crustytoothpaste.net>
Date:   Wed, 20 Jan 2021 13:42:56 +0100
Message-ID: <87im7r93u7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 20 2021, brian m. carlson wrote:

> On 2021-01-19 at 06:17:21, Harley Paterson wrote:
>> Hello,
>> 
>> I've noticed an edge case in Git when a user has two Git accounts on a
>> single server - as might be common for a personal account and a work
>> account on a Git forge (Github, GitLab, Bitbucket...)
>> 
>> When attempting SSH login, `ssh` and Git will eagerly connect with the
>> first matching key. This may or may not be the key right key for the
>> repository the user needs. As a result, Git clones, pulls, and pushes
>> will fail with the `Repository not found` if the wrong key is tried
>> first.
>> 
>> For example, the user `alice` has two accounts on the host
>> `git-server.com`. `alice`'s accounts are `alice-work`, and
>> `alice-personal`. `alice-work` has access to the `foo` repository, and
>> `alice-personal` has access to the `bar` repository.
>
> Yes, this is because SSH authentication happens before any command is
> run.  The server never knows what resource is being requested until the
> user is already authenticated.
>
>> `alice` attempts to clone `foo` with both her `alice-work` and
>> `alice-personal` keys in her SSH Agent. SSH Agent does not define
>> which key it will attempt first, so SSH may connect successfully to
>> `git-server.com` with her `alice-personal` keys, which do not have
>> access to the `foo` repository.
>> 
>> I'd be interested in your opinions for fixes to this. I am willing to
>> make a patch, although my knowledge of the Git codebase isn't perfect.
>
> We've documented how to deal with situation properly in the FAQ, which
> you can see at gitfaq(7) or
> https://git-scm.com/docs/gitfaq#Documentation/gitfaq.txt-HowdoIusemultipleaccountswiththesamehostingproviderusingSSH
>
> Is there some reason that this doesn't work for you?
>
>> - Should Git servers provide distinctly different error messages for
>>   `access denied`, and `repository does not exist`? Currently the
>>   server immediately closes the connection in this case, so
>>   `transport.c:handshake()` with fail when attempting to
>>   `discover_version()` because the reader hits the EOF. Perhaps the
>>   server could send a hypothetical access denied packet here, and a
>>   more appropriate error generated?
>
> Unfortunately, this leaks whether a repository exists.  If Company XYZ
> has a repository for each of its clients, it then becomes easy to see if
> Company XYZ is doing work for a particular client by trying to see if a
> repository exists.

I wonder how many hosting providers are confident that the code involved
in this isn't vulnerable to a timing attack.

> This would be bad and a huge violation of privacy, so nobody is likely
> do to that.  I can tell you as one of the staff who maintains the
> GitHub Git service, we're not likely to change the behavior, and I
> suspect nobody else is, either.

Let's be clear, it's a violation of privacy in the case that involves a
private repo.

But the fact that when you e.g. clone git@github.com:git/git.git with no
valid key and get a "Permission denied" is just an emergent effect of
how people string together openssh & their own auth solutions in the
wild.

You can just as well let the dialog proceed down to a shell without a
valid key or password, and then check that the user wants to run "git
upload-pack git/git.git", and then decide "sure, it's a public repo" and
proceed.

Indeed that's what e.g. GitHub does when you make up a username &
password to clone a public repo over https.

    # Under OpenSSH, See https://tools.ietf.org/html/rfc4252#section-5.2
    Match User git
        PermitEmptyPasswords yes
        AuthenticationMethods none

Why would a site like GitHub treat ssh differently than https here? I
think it just comes down to openssh's support for use-case being a bit
of a pain to configure.

I don't know of a way to do that *and* pass down to e.g. a login shell
wrapper script if/how the user was authenticated.

Hrm, maybe I take that back. I suppose you can make the default shell
for the "git" user "git-shell-public" and set the rw login shell to
"git-shell-private" via an Authorized{Keys,Principals}Command". But I
haven't tested it.

Anyway, just saying that there's bad error messages for good reasons,
and bad error messages for lazyness/not wanting to deal with the edge
case.

What Harley Paterson is complaining about is sometimes in the "good
reasons" bucket, but sometimes just server operator lazyness, or not
caring about this marginal edge case enough to provide a better error
message.
