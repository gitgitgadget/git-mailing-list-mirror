Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C2EC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 15:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiLSPKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiLSPKm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 10:10:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0D83A9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:10:41 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a16so13265229edb.9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Em/car1iL96S6RqPbnRKqFd6iuclA1tRyMReeMvUAig=;
        b=ITfXgPBI0BXsBHcMKLsjHlTPx8gtWvj3Mi0SN2nixDd9tu94LItAnHFhOR8mtChHBM
         Laqz7RI+bYxSDAyncx8NswZGM9RHjiktKoOfGz+qPr5CJ2Ps7dKBb4guAL0hzF9hkg/A
         F3kdYVOKK9BH8ns2je/CrcHHEFZ9l+FHTxkDIIiBPYzA6l/r5kilAbzbSMRSPIrOXl2W
         YUHG9ZNO3jkazbd9XbGvSxrp1HZu+G1zdUFAFgjOd1oHJC/vH95GxZhxGP9s5JvIRDHp
         J+WxqTFTD4muusaTA7toEl7oAAEp8PEp/a0nCS5mrybGSuGIA5xw1CuwlRMwa4MlT2K3
         GFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Em/car1iL96S6RqPbnRKqFd6iuclA1tRyMReeMvUAig=;
        b=fT5hW9V2qoKig1VhycbP34FZE+ANhnKsyMRcLCYp6wOXa4LK6AAQOsdKWfBiE7a9hV
         6tjhIZE4mr3BgkoDzn+MzuRwGGLCUNgn/oFdW4fM0TZDZuoEMZl3TwVcrquEKzqUejrJ
         vJJCFbBzIp7aO1mvhdpjWMuTmMG6mA8MC/IRWaC8dku3rNJJMhMajVsmV7UO7SbVnQbb
         yeyAgAdOpmaSaUI4k4Rag7avzimRmrDFw5/OEVV18jso4YndBlzv67JFMaPJWF++oo0d
         jdNoTlPtWGhS0DUC71083vfubArYj7igox/pEw2bWFIirg54aXB28lhhPLdYKYC84eDX
         4/xA==
X-Gm-Message-State: ANoB5plQnDwZ2AkCIENNf729gopkTl3bizLG49yAPXAVrfHo2HrV1E/H
        ECphvCZME+p0nfihhl2jXBM=
X-Google-Smtp-Source: AA0mqf7az50RTbRSLHu8NHqtnMLoD+6isMLlBstXsu0YtKhMTJ15frukw6RsCUrIn6AyqoJHZeqj+Q==
X-Received: by 2002:a05:6402:12d6:b0:46b:444b:ec40 with SMTP id k22-20020a05640212d600b0046b444bec40mr35858400edx.15.1671462639842;
        Mon, 19 Dec 2022 07:10:39 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id s2-20020a05640217c200b004615e1bbaf4sm4507780edy.87.2022.12.19.07.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:10:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7Hmo-006arM-0x;
        Mon, 19 Dec 2022 16:10:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 0/2] cmake doc: modernize and cross-platform-ize the docs
Date:   Mon, 19 Dec 2022 16:06:13 +0100
References: <cover-0.2-00000000000-20221219T102813Z-avarab@gmail.com>
 <f67e0281-8a14-669d-0d1c-ed0b1351a64a@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <f67e0281-8a14-669d-0d1c-ed0b1351a64a@dunelm.org.uk>
Message-ID: <221219.86h6xrzaxd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 19 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 19/12/2022 10:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change the cmake docs to use one-command build instructions using
>> options that "cmake" supports an ill our supported versions, and in
>> 2/2 re-arrange the docs to make it clearer which part of the
>> instructions are platform-specific.
>> Like the just-submitted [1] this extracted from [2], and the range
>> diff below is to [2]. The only change since [2] is a trivial reflow
>> change in the commit message.
>> There were no outstanding issues or feedback with this part of [2],
>> so
>> hopefully this can advance relatively quickly.
>
> I'm afraid my inclination would be to let the people who actually use
> CMake make any changes to the CMake documentation as I think they are=20
> best placed to know what information is most important.

I think that after kicking this "cmake" series back & forth for a while
I can be described as a person who "uses cmake", I also have cmake+ctest
as part of my local build & branch integration.

I'm not sure what else to do with this comment, if you think that
e.g. there might be some issue with the proposed changes here due to a
blindspot I have in not using it with MSVC can you comment on the
specific parts that you're concerned about?
