Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC79AC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 20:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiESUWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiESUWT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 16:22:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC65A592
        for <git@vger.kernel.org>; Thu, 19 May 2022 13:22:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id wh22so11866828ejb.7
        for <git@vger.kernel.org>; Thu, 19 May 2022 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0KJFSpmoBzyVz4W9fHMm/gOxB2A59Ou5uZz3BL3fJt0=;
        b=lmO78HYV87dYubwxchfjk5GIVFg6NAFULVe9PgwVy2ZqOhADCqXYj0nbxQlMyuWjh6
         wfkR1TQHvKdjsXpPRqoy5ssh11KPSYXoTnXAZmspqxmKdGHjiacH/ApBKdmG+573iSIQ
         yM0qJKTKZ5qQnP+iLxD60X2iKVrYBz+OXhJa2THSMJxwI/GQke9Gsv7nNUF6sicmmEz/
         Fzz9i9pUhQ6/IoThnjC5vOaO/TBVeUCjsnsMSgNOAG2tH/jTl8S/bbX+NU3ABd5PtdQ/
         Swi4ixiXE2sce36aXVLfwfXjHIdu0A5xip5N0gAjNBEOBK/f17PB0rEt8tY98T48Wyw8
         ksZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0KJFSpmoBzyVz4W9fHMm/gOxB2A59Ou5uZz3BL3fJt0=;
        b=rnryD0xYupd2/hdqOa7OiVD4xWAujcM3OuRAF4VdY/ZlUtzEfWXOiodLPaiLSUUKs9
         R2RVpjffT2kIHJ8g+TQT5LbBIggUPc2O48UZNAiaybVXQ6LmATgd+mhheD6yX2vi2BHd
         z72G5rcpnbDJ73zQ3diDAvd0Nj0l8cDezx47x+dEkb5pi+wPLr3h8JluFeWl5sLphOIq
         Yya44Scd6LmoYRQWB5zZbEJHhg+aCO/WS304pvoJDgQji8pxv1oDxEcZ+0+30CHC3Om3
         bz2eQHICMxGpFJsfHIg/zqRKd3dTBLpBmaibSXnNOrIY0de8F5ETY3wzDwvFMj3abc77
         ZNNg==
X-Gm-Message-State: AOAM530F2PcnJwEjCIEvS1TkuG5PteVeqV2fXCxl7esm4F9TRzpQe28x
        pyTg17dApFlr14HVr8Ojgu8=
X-Google-Smtp-Source: ABdhPJzjPX/BSygh1IInmro6wfB1lLu4pQcquNkc1lXovrT8wW8WvtNQu1mdPiEhladjI0tQJ9HwWg==
X-Received: by 2002:a17:907:6d87:b0:6f8:95d2:6814 with SMTP id sb7-20020a1709076d8700b006f895d26814mr5993480ejc.232.1652991736504;
        Thu, 19 May 2022 13:22:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 28-20020a170906015c00b006f3ef214da8sm2469484ejh.14.2022.05.19.13.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:22:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrmf0-002K2q-4z;
        Thu, 19 May 2022 22:22:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git-packagers@googlegroups.com, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Arenas <carenas@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git-packagers <git-packagers@googlegroups.com>,
        Tim Harper <timcharper@gmail.com>
Subject: Re: [PATCH 0/5] core: update our SHA-1 docs, use
 sha1collisiondetection on OSX too
Date:   Thu, 19 May 2022 22:14:32 +0200
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
 <xmqqv8v17xrl.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqv8v17xrl.fsf@gitster.g>
Message-ID: <220519.86k0ah2ryh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 22 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> I wasn't able to find any on-list references to it being intentional,
>> but it appears that while we made the sha1collisiondetection variant
>> of SHA-1 the default in early 2017 we've never updated the OSX builds
>> to do likewise.
>>
>> I don't know what various git packages for OSX to, but our vanilla OSX
>> distribution definitely uses Apple Common Crypto, and won't detect the
>> https://shattered.io attack.
>>
>> This series changes that, and while doing so in 2/5 updates our
>> documentation and Makefile interface for the SHA-1 selection. Our
>> INSTALL file was still claiming we used OpenSSL's SHA-1 by default.
>>
>> Then since we'd made sha1collisiondetection the default we hadn't
>> changed the code's default fallback to be that, it was still
>> block-sha1. Now our fallback behavior is "error" instead, which makes
>> it less likely that we'll get some foot-gun like the "OSX not using
>> sha1collisiondetection" again.
>>
>> The 4/5 and 5/5 then remove the PPC_SHA1 implementation. I submitted
>> this before as [1], and the range-diff is to that submission (it
>> wasn't picked up). I think it makes sense as part of this general
>> SHA-1 cleanup.
>
> Thanks for this effort.
>
> I'd like to see somebody with "building Git for distributing to
> macOS" background to comment (I am assuming that the mailing list
> git-packagers@googlegroups.com is the way to reach them).

*Bump* in case anyone there would like to chime on this bit of OSX
portability.

I also sent an off-list E-Mail to Tim Harper today, and addresses which
I gather (from some old git-security@ traffic) are involved in packaging
the Apple Git shipped with OSX itself.

In the meantime do you mind if this topic were queued up? If there are
any lingering portability concerns getting it into CI and exposed to
anyone else building on OSX would be a good thing.

I don't see any reason for why we'd decide that OSX out of all our
supported platforms should be the only one where we're not mitigating
the SHAttered attack (and similar future attacks) by default.

So aside from any finer details of OSX portability the direction here of
building with sha1collisiondetection by default on OSX by default seems
like a safe bet, just as we do on the rest of our (checks out
config.mak.uname) 20+ supported platforms (per `uname -s`).
