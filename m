Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56028C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 14:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbhK2ORm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 09:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhK2OPm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 09:15:42 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B008DC008197
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 04:51:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id t5so71641103edd.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 04:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+5D6pcRXlzNefhSSimU8y1eD1aLTjMUCuSdIh+7juN0=;
        b=BSRtNK/ZKBzIqK9WglCmyZWT+DwpUL2syzFRxLUsElzQcdFr7QvptKJ91u/PPrTxTm
         qIYdWxmSbD8yPV6j7Y6ks3/dq3rUkeUtWyMJ1CQdxHxFFOazK9f7mCeC7fc+jvPIo7x7
         oeQjZwyyLwdoQ0bT/lOiwoQdKfc3noDsG91CzJMejcz0+CO3umnNwW32GhXEy3zOGWTT
         3/srOxEg6IkUeX3mUwxG9WzskZpsg/iz9w4+j9n6W5mf7upf0L7+KR0puXpndLPS3KNZ
         vPQxEfOwAnHc+DgGQXMRsFmvH6CprbIy7xIIcLwJmLRQOcN0vjESyVm/1gEEeWGrow16
         8U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+5D6pcRXlzNefhSSimU8y1eD1aLTjMUCuSdIh+7juN0=;
        b=pcfkcQIYxwCmavMpkBTDt69xM4v791U6qBGEanckIwuSYWz/defciFsAXumixalZ/1
         l+t22Libm1sD6Bqem2QwBNFFRk45K0RYOObcWhL7RRUzkovmfEnYWypsvVG8TOedKzRC
         2AijElC0iBdurC+ItwxBRoRn2kCpmOipGTyJpKX4DhrasEBZn2wHw/zqgDe+Io2Vjq0g
         WwZ4WmaadaoCKBytrzZyK+m6h87edVqYpGMh1KNkrGKRXS1FVvqxDyWLKag111mkoVRW
         rGjpqxbs87C5iB/ton57L12PxYwb0C6hGOVVOsH04F8x0J3BQIlEsGfR9CRKpPK9C+k7
         Ugqw==
X-Gm-Message-State: AOAM530LL61uyp2FmaRM9juFx15km/5aSHxuWtaUkhLtfyDbv7lgsu6t
        Fp8EYZHKXsW3LEyFw5fGCpk=
X-Google-Smtp-Source: ABdhPJx4Hy0I0nWmEkQI/tOK25euW3KWtHyxyNJNKXB1Nd76PUP8tm1A/cVfu/U6SPaewSMsh7aXQA==
X-Received: by 2002:a17:907:1c07:: with SMTP id nc7mr58021426ejc.546.1638190282103;
        Mon, 29 Nov 2021 04:51:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w22sm9878043edd.49.2021.11.29.04.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 04:51:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mrg7s-000izU-Vq;
        Mon, 29 Nov 2021 13:51:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Mahdi Hosseinzadeh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
Subject: Re: [PATCH] githubci: add a workflow for creating GitHub release notes
Date:   Mon, 29 Nov 2021 13:49:20 +0100
References: <pull.1146.git.git.1637840216877.gitgitgadget@gmail.com>
 <AM0PR04MB60196EFE984652ECCBD591A8A5629@AM0PR04MB6019.eurprd04.prod.outlook.com>
 <nycvar.QRO.7.76.6.2111261455590.63@tvgsbejvaqbjf.bet>
 <AM0PR04MB601972377B5CC2E24B6BA1DFA5639@AM0PR04MB6019.eurprd04.prod.outlook.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <AM0PR04MB601972377B5CC2E24B6BA1DFA5639@AM0PR04MB6019.eurprd04.prod.outlook.com>
Message-ID: <211129.86k0grf7lj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 26 2021, Matthias A=C3=9Fhauer wrote:

> On Fri, 26 Nov 2021, Johannes Schindelin wrote:
>
>> Hi,
>>
>
> [...]
>
>> One thing I had not thought of earlier: do we really want to do this in
>> every fork of git/git? I know for a fact that microsoft/git has a very
>> different workflow upon pushing a tag.
>>
>> So maybe we need something like this, too:
>>
>>   create-gh-release:
>> +    if: github.repository =3D=3D 'git/git'
>>     name: Create a new release or update an existing release in the GitH=
ub repository
>
> I think you're right. This would have unidesirable side effects if it
> ran in forks.

Rather than hardcode given repositories, which e.g. for testing the CI
itself can be bothersome, perhaps a better thing is to put this into the
existing ci-config? I.e. git/git.git could opt itself in to behavior
that would be off by default?

I don't know how much that matters in this case, but I don't see why
we'd hardcode repository paths in general since we've got the ci-config.
