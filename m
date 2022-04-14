Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE0EC433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 17:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbiDNRFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244475AbiDNRFd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 13:05:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C7563F3
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 09:45:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v15so7070415edb.12
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kEhGuttfl/OGbH39jARrGWI+sJtuB9oNoJel8VDoi+s=;
        b=hyt7+apsYfabVqvtCIn1jMHESUlCDzKA0mAlj7KZIjPuex/+/v5+6huHQ2IajRCr43
         29+8ullr61MEdF7d8xRsvQ7OqM8YCX/Djyra/vUoENG1czl047wAvOFaYlwMd0dERNVm
         3z4+yoC01TfBwUjftsSFludeUUHE1EMZqIE+DTBOKrB1XKCW/sF6pmvTMEivduTHLVGv
         vUtdWpo2WQBXRk7FwWfBOW/jrgZMpq9X99h8uapCM4aZZD+vEXvyjP95VApdX4E/5fyr
         5LIhOmpitWontzrnrlQyyBszhcPCHFCpGyOwZXJUN1H8cyrQW7NgKeCagLAoIh8GFHmb
         enNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kEhGuttfl/OGbH39jARrGWI+sJtuB9oNoJel8VDoi+s=;
        b=fSn4gpOe84Nd5SGsQqGnxw8/vaCWaJ8RX1d7bimEvWhOw8yPc+eLpMBWHIC79yMja8
         y823ln24VsbfOnvMbN9btq/sfQhdE1S2Y4xISAvICRRERX5VB6Z2ZYJqBUfl7q4fXLer
         07jG5+9kBhctXfWmhP3xBMIJKlkZMdVrowhxni9aHuzYdeqgAo0hCnbPlAbUrp0JhH+2
         3a6J1rIDnd0dfzAvMA5k4mNM7TK4Il/RdgmG+urjriD9kZg5NsUinYKwSjvJj3tyAmmS
         90wUUxBkxuJgSugZtGyFUfCKrVu9yb7nhfrOVjAHn8CwY/3FWCWcZZ4AxgKsv4U86SSJ
         J1DQ==
X-Gm-Message-State: AOAM530At0XubtFkM8tv339EQwGgFKv95iAx0/R/x29pcHelny18MxN9
        bOTHmFn0hRUCmy8+CwOTNUQ=
X-Google-Smtp-Source: ABdhPJwNv7GSrLwtfV5V7vqPLXJsdpRuITLhhlYdsd1VP9gLIPfcRj1keQs/+1QGob6nhq13RltPtg==
X-Received: by 2002:a05:6402:1e90:b0:419:4cdc:8b05 with SMTP id f16-20020a0564021e9000b004194cdc8b05mr3985278edf.211.1649954749814;
        Thu, 14 Apr 2022 09:45:49 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7d583000000b00420a8b66566sm1240209edq.97.2022.04.14.09.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 09:45:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nf2bL-005UnT-DH;
        Thu, 14 Apr 2022 18:45:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Tao Klerks <tao@klerks.biz>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        rsbecker@nexbridge.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Subject: Re: Make commit messages optional
Date:   Thu, 14 Apr 2022 18:43:10 +0200
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
        <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
        <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
        <20220409113244.GX163591@kunlun.suse.cz>
        <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
        <220411.861qy3khkk.gmgdl@evledraar.gmail.com>
        <YlRyHR5rvG5P/Acr@mit.edu>
        <220411.86k0bvidja.gmgdl@evledraar.gmail.com>
        <YlgzrSAJnYpNYDV0@mit.edu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YlgzrSAJnYpNYDV0@mit.edu>
Message-ID: <220414.86czhjd35w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 14 2022, Theodore Ts'o wrote:

> On Mon, Apr 11, 2022 at 10:10:23PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> We could add configuration or whatever, but the topic of this thread is
>> whether we should change the *default*. I think it's better to stick to
>> that.
>
> I would have thought it was painfully obvious that changing the
> *default* is a ***terrible*** idea?
>
> Is anyone other than the OP seriously promoting changing the default?

Urm, yeah? I am, in the E-Mail upthread that replied to. The OP here is
jurgen_gjoncari@icloud.com.

> If someone wants to do something terrible to their own development
> workflow (or if it actually makes sense for their workflow) we could
> add some configuration, but if the question is changing the default,
> my ppersonal opinion is, "Heck, no!"

I think you're almost certainly correct that there's worthwhile things
we can catch with the current default.

I just suspect that we can do so much more effectively and encourage
more effectivey workflows by doing so at the point of propagation, not
commit.
