Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2563C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 01:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831A420723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 01:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2zjhgA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390573AbgE2BhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 21:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2BhD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 21:37:03 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD8C08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 18:37:03 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id w3so860915qkb.6
        for <git@vger.kernel.org>; Thu, 28 May 2020 18:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ol4X4SveP64QuKAuRq0l93CdM1igARaFMbUBOwRU9AM=;
        b=u2zjhgA4CW5YJm67kIYVmJ2MJOF1ZkXkNc69j5JD4Y8c9a14CR9cVGFKY2+qCtmwkp
         7mGHb1ORnzZhsjwgScJyNHIEbIhwDqc269MT1qt3NScUbkFvQOUap0VqyCrzxdAPiE0Q
         5vnE2iCjW2+3UuWy5zy0Ha9Rv8snGlhGavnYsVlOZkvsdaJWeu6RsNxu28aMAMseNwJ2
         PQxtYpw+hNJHWpnlhNjRX2DR6ttPJVABK5gVYXJfoWCm85pAhwYVSnvvFC2YaOUu8ELX
         lwwdSm7kFdwT1AZimUQoESTMYMoe+ZnLINj+q0x5PEwPkVV7tl0ZCE57WWXQTvVW5OAD
         Mq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ol4X4SveP64QuKAuRq0l93CdM1igARaFMbUBOwRU9AM=;
        b=eKMOseOezm5fbCL/bMNuOrgTZMCMSXYlib12xEL9QqzZj3FBh8VIeR3o9sDlq+ZWhP
         dQu/uswBtQr2lcWqG0GGj+uDoEsA5GiqE8SdCtkivnxEAAC33OEBu/fkgyp4U0u/e1G3
         XgkexfNMcTHY4MIveWBWAtkCp6hcbxbl4/qY6dVWp47H3KAMfmfbAE2A4oKkcfM6Uy9s
         WpTllzvvhtaW/n07eacEhnZ7+jjPkpEi4EvCKid9TMcSINaeVLb1Gqmac/yfe0dDFa+o
         c+PTxnLJcMzdWBdXnK+taQY47s+4JYv07ghbSoi271gl2k+4iOgzjPfDVx7Y6jTX9Bns
         N2QQ==
X-Gm-Message-State: AOAM532X8PHnB4Fcvoj3Xxx5+DPoybQqasb4aaph/B/e1FCI6w1n5CCz
        ZNfY8Dvx0fUCy5ihOJxq1Qw=
X-Google-Smtp-Source: ABdhPJznV8esPddmfb5GnuqCb3tVUk/QYI7Ch4tGDT7tZzPRpp/YzOdClzyq8nRupbsZeEdmDjCCPA==
X-Received: by 2002:a37:7984:: with SMTP id u126mr5564723qkc.73.1590716222406;
        Thu, 28 May 2020 18:37:02 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id t43sm2854391qtj.85.2020.05.28.18.37.01
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 28 May 2020 18:37:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] docs: mention MyFirstContribution in more places
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200529010608.GF114915@google.com>
Date:   Thu, 28 May 2020 21:36:58 -0400
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7746C7A0-F328-482C-9B19-51BA5CB17C0A@gmail.com>
References: <20200528234939.145396-1-emilyshaffer@google.com> <20200529010608.GF114915@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,=20

> Le 28 mai 2020 =C3=A0 21:06, Jonathan Nieder <jrnieder@gmail.com> a =
=C3=A9crit :
>=20
> Emily Shaffer wrote:
>=20
>> While the MyFirstContribution guide exists and has received some use =
and
>> positive reviews, it is still not as discoverable as it could be. Add =
a
>> reference to it from the GitHub pull request template, where many
>> brand-new contributors may look. Also add a reference to it in
>> SubmittingPatches, which is the central source of guidance for patch
>> contribution.
>>=20
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> ---
>> .github/CONTRIBUTING.md         | 3 +++
>> Documentation/SubmittingPatches | 5 +++--
>> 2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> Yay!
>=20
>> --- a/.github/CONTRIBUTING.md
>> +++ b/.github/CONTRIBUTING.md
>> @@ -16,4 +16,7 @@ If you prefer video, then [this =
talk](https://www.youtube.com/watch?v=3DQ7i_qQW__q
>> might be useful to you as the presenter walks you through the =
contribution
>> process by example.
>>=20
>> +Or, you can follow the ["My First =
Contribution"](https://git-scm.com/docs/MyFirstContribution)
>> +tutorial for another example of the contribution process.
>> +
>> Your friendly Git community!
>=20
> Looks good.
>=20
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -3,8 +3,9 @@ Submitting Patches
>>=20
>> =3D=3D Guidelines
>>=20
>> -Here are some guidelines for people who want to contribute their =
code
>> -to this software.
>> +Here are some guidelines for people who want to contribute their =
code to this
>> +software. There is also an link:MyFirstContribution.html[interactive =
tutorial]
>> +available which covers many of these same guidelines.
>=20
> nit: when I see "an interactive tutorial" I imagine a "git tutor"
> command that interacts with me to guide me through my first
> contribution (like "vimtutor").  I think this means to just say
> "a tutorial".

I agree. Maybe "a step-by-step tutorial" ?

Thanks for taking the time to do this. That's exactly what I had in =
mind.

Philippe.=
