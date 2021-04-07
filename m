Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5256C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1E66120E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhDGWXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhDGWXk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:23:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F95C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:23:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u21so30192925ejo.13
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/AyrCdgPcLK4eVWrgqOcJ6DclsKGjRx82Gjd8DVgUlo=;
        b=r5Pe/DNOW8rUs7bbLIkdQEg4kyv+f70Hj0K2kXObCjkuO33riEoS8NQaoZOBqNjEEL
         1mn/MFgwCTfLqKQmJckql94LFHvfiV5vovUulJdN/JI45IWYfxj/T0cOaSsgHhHfDNRY
         Ji4FgBHFaEQ86qAqu+J/AHMxOccIVEeHdfD8mDNMyJYMUcmJGlVy1xFq1hdP0gnINHiF
         4nXbVJOFYdX8pTuP7jaAW10Vj7IY6iTbZCe9hXkg16bhNjYEDGxTLcFpbLQv7ogrdt2G
         Dua6KASvZmrXbjCcxCZeijW/N5Q5fFcFQo0E3x4P3dE3dH0+aY7onWilDLHVx0MBJxZR
         d0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/AyrCdgPcLK4eVWrgqOcJ6DclsKGjRx82Gjd8DVgUlo=;
        b=PGsAfD/ZQ5QdKQb+A4F2hXnBsl/kXDgLRLlni0LSTu92YnajMAVYhb1GTOFaHcd8i0
         +aRz0zUurfPePkCGErzJEK8G1+a1o1ZRyJ1yoPnvgmVPJYkf8o5mzraRfod+imeKHD87
         zz7KpBfRh7ZFWZUygKqXxffCIwk8MMo6kSyG0Utj1kxv1fJuT860A7ZRvSWhuvUhIaKH
         +4YPZc/AkL1vmSU22KG4qFjty2r5n1I8/pFQ5lblYdeOKAGxZTCI1E6J9s7wflBcScjG
         7wcIQ483axcKnZg2oUUpPobQLNnqiO3xbqLWRsAseezqM3PZR2XnHLNx7f15z4D5U9Zu
         k4pw==
X-Gm-Message-State: AOAM5301qYf8DdHXQfrBj23HiOwCApgbMGVk2Az5n8/VBbt5U1GvkZU7
        iH5spRYyJn425Mg+mqljqGdRHpKHd2Wm2Q==
X-Google-Smtp-Source: ABdhPJw/ZwTavGLw+RrfPjrU9uVJ0DQowdqvSNIl4yfdY/vr1Ka6GXS7+sQwf6jmxpsE5xxKfWBk1A==
X-Received: by 2002:a17:906:a40b:: with SMTP id l11mr1508135ejz.473.1617834208742;
        Wed, 07 Apr 2021 15:23:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lf6sm8289785ejc.33.2021.04.07.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:23:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Albert Cui <albertqcui@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] hooks: propose project configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
        <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
        <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
        <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
        <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net>
        <87tuoijzsy.fsf@evledraar.gmail.com>
        <9af3770f-204b-253b-d7f2-c9d5e7cf2fdb@gmail.com>
        <CAMbkP-QDzCQbekBf7tdN6zccDU8xnXdYFAuSZSbsdS6hSumghA@mail.gmail.com>
        <xmqqh7khzwv1.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqh7khzwv1.fsf@gitster.g>
Date:   Thu, 08 Apr 2021 00:23:27 +0200
Message-ID: <877dldka3k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 07 2021, Junio C Hamano wrote:

> Albert Cui <albertqcui@gmail.com> writes:
>
>>> Here are the hard lines I draw:
>>>
>>> 1. This should not happen in "git clone" (other than maybe a message
>>>    over stderr that hooks are available to be configured through a
>>>    different command).
>>>
>>> 2. Hooks should not update in "git checkout" (other than a message
>>>    that hooks have updated).
>>>
>>
>> To =C3=86var's point, maybe it would help to separate the two user bases=
 of
>> project configured hooks.
>> (1) Employee working at BigCorp. They are cloning from a trusted
>> remote on company machines where the company controls what gets
>> installed and how Git is configured. Their motivation is to make
>> changes to their local clone and submit changes to a central
>> repository.
>
> Hmph.
>
> If the assumption is that their configuration is controlled by
> BigCorp when they arrive at their desk, why do you even need any
> change to upstream Git, especially with Emily's "configuration file
> tells Git what hook scripts to run" in sight?

FWIW I've been assuming that this is wanted for BigCorp people who have
devs using vanilla OS's / XCode etc. Having managed laptops with a
managed /etc/gitconfig certainly makes some things easier...

> Wouldn't it be just a matter of the BigCorp installing
> /etc/gitconfig on their BigCorpLinux installations?

Whether you're at BigCorp or not you've got the problem with such a
/etc/gitconfig that it applies to all repos, but someone at BigCorp
might clone both a BigCorp repo (wants custom config, hooks etc.), and
also some random node.js github.com project (should have no such custom
config).

Having a .gitconfig or otherwise making the repo suggest/control the
config/hooks is an elegant way around that issue.

You otherwise need to do something like have config includes apply a
rule to ~/work/, and then hope your users follow your suggestion to
clone repos in the ~/work/ folder.

I think extending config includes to e.g. operate on a glob of the
remote URI was suggested at some point, which would make use-cases like
that easier than they are now, and would be a less invasive change than
what's being discussed here.

But right now we don't have that, so we have a gap there...
