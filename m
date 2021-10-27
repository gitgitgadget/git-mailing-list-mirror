Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A826C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC5C6109F
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbhJ0R7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbhJ0R7W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 13:59:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B4DC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:56:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ee16so831127edb.10
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=uDb1HkQSpOEI4vr/NtopMuNsfV9I9WzDE3bBHoyO61A=;
        b=cbvElaqRSIuqR9/61JtutoREX0x+7zYpKLk46W0IWZDY2aXp+xJG21OzQYQZo5reMo
         W56gV0xtLhvCJnynOl7yg5rmtLOQPco0d+XtaVbm6qgy/uev7kNZKXTSnTfCRGO7Mlp1
         8njZactx5W4bnm23WigbtPPrhPSwXsCWQB4pTy3x/GCGOryP6zyl3fuLCOC0wdztVriW
         Bhbjg8XE9H2804DTna3HID15CfM82iDNHR1SArIL84beOxUvNg4haG5Z3IblmV6se4Sl
         wde3kekaw4H2uK7uNrbhlO9exBw5HNWug9al0g6HJgk5UKMffCBsZ8e/39xy0iPAVIUR
         GH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=uDb1HkQSpOEI4vr/NtopMuNsfV9I9WzDE3bBHoyO61A=;
        b=Don/zxKR9swGPTq/ISJsRjcoPLK0m8vr5bUZXKH8iwbe99EVoV+WJKDAmWu6nmp2uJ
         ElJH/y+9Udrn8PBE/hqhSp5FxGtNcxU1BYFjZ+5mq6JeMPu24UXqxBok6H32nO6aOrdA
         qgLDUTtYTbb9wwKCG23bPhnzlMS67eBtrCYwCQNJFmfo/5QAaiQt87rD8vXAwqxB6tAb
         NorsQebdoWkHINd7pHv6+N8Dmwn4U4g8NGwyN7NPypUv/uQtoKYd0xVjY6mgEQmTsZC9
         O0bHMrxKnB65TO4FqWymHvSIvpI9CYsBtcTd+7gNe30eNtzmOSUjoQX9W7O5V7pk/gnf
         9IaA==
X-Gm-Message-State: AOAM530Ik85tgDxHdbTCN5yGC+NzC1i7Zt4+jtMG4Q+yFAwqL4uJpIKo
        Neg5k6wOrNPRWxwiCIpgmzl9bKjTb3E=
X-Google-Smtp-Source: ABdhPJzoRnlyRkrUQp9i+nBtB/sxrS8IKNeAO6kTyjPj9/NdWMs6CYGSx3UDqMllIpO//Ia1AZjlrw==
X-Received: by 2002:a17:906:3784:: with SMTP id n4mr40471021ejc.129.1635357415271;
        Wed, 27 Oct 2021 10:56:55 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l10sm424815edk.30.2021.10.27.10.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 10:56:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfnAT-0020xa-5f;
        Wed, 27 Oct 2021 19:56:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 2/3] protocol v2: specify static seeding of clone/fetch
 via "bundle-uri"
Date:   Wed, 27 Oct 2021 19:49:31 +0200
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
 <f2269fc7-1688-d62e-02bb-01c5b5e33143@gmail.com>
 <211026.86cznrzu8g.gmgdl@evledraar.gmail.com>
 <b22b894b-af03-c108-a3d5-0072c252f513@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <b22b894b-af03-c108-a3d5-0072c252f513@gmail.com>
Message-ID: <211027.86mtmuxsey.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 26 2021, Derrick Stolee wrote:

> On 10/26/2021 11:00 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

[I'll reply to the rest later, either here or in related threads. I.e. I
might end up entirely revamping the config etc. format]

>> There's also the small matter of it being consistent with the
>> packfile-uri config in its current form, but that shouldn't be a reason
>> not to come up with something better. If anything any better suggestion
>> (if we go for that) could be supported by it too...
>
> What do you mean about being consistent with packfile-uri? This layer
> that we care about isn't even implemented in git.git.

It's rather limited, but we do support a uploadpack.BlobPackFileUri as a
server-side feature for upload-pack. I.e.:

    uploadpack.BlobPackFileUri=3D<OID> <pack-hash> <packfile-uri>

See Documentation/technical/packfile-uri.txt.

The <pack-hash> is part of the protocol, but the <OID> is just an aid to
upload-pack to peel out that OID when it serves up the PACK, the <OID>
being what you get from the URI.

In terms of server implementation it's rather proof-of-concept-ish,
i.e. it's not really all that useful unless your use case is carving out
a small number of really big blobs. JGit's is much more mature, and
there's some patches on-list recently to make the git.git one more
practically useful[1].

1. https://lore.kernel.org/git/cover.1634634814.git.tenglong@alibaba-inc.co=
m/

