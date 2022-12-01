Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994EDC43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 17:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLARP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLARP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 12:15:26 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53E2AC6FD
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 09:15:25 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n20so5852756ejh.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 09:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ziIE5LOFHm34l6tVQ2EJaRYkaDskH2GdE3r1B6tM+3A=;
        b=PDM9GXp/F5tjN4M8S4fkSzE29PvU5tJ8CO8jPMIe1xtZDQ2b+/mmOZ31g3C1VcYsz3
         YDynOphiwXjt63IoyTokm1HnXqrQQzSs/XHEy9AV/ibn9W+f7wEPB2Zf4VChoTBv524l
         ZWstizaAPf0b1IHQ/5fS/8f7LMeqhI7uGUD6ywpjHkzGaUdJDInCVi3CogXqWGGLF2NI
         V6yT3Jpfyhq04vX954zcncXhkv+PdkreIn+wOghJFoUEPWLsPwdbS3cOFq7QSZnqQ6vI
         JTUD1S/CJzBIm+oGvEircDaFUVyZQ31Ri9jdDw/+8fnVaIWJXwgJ0BPyF8AaZiLX1ix3
         3xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziIE5LOFHm34l6tVQ2EJaRYkaDskH2GdE3r1B6tM+3A=;
        b=izZWePryR/BC6NzAhNe8+2ZLPTGBJ2oiH9VpgpNX6Dsm7gDlh8XCeR2b5ifMTB9cA2
         9GRgYM0sGTJxj/3e0L4XwS33QQ/KZGHasJhoROnAYZD0k4crW23jAdnJny+iReqg9vaj
         IrTHqF9hZh6nveNwJF2n/joqofBfBDEu8zzxcTMPCjOeVIHraWt4eBhhGx4eV78AR5S3
         Huc5ptOvNw6wjj6RPfpYizumJx1oKP/yxZBYfozJWFxFfoeQs9EbyeMzJ9V/4/dKLQaC
         MPhftPXqG8YBStjuZxHIgAOLgf9SMEMr7jZ1/1Oy80Jr5Nu8tThABDtcefpc2ApSYKU1
         Yx0A==
X-Gm-Message-State: ANoB5pkpm3Xhjzx5jrUYrRFnV41+0PnCDrlVnkPXe/iNw9XjDNYw4dIp
        y4e8HZd74tjQPw3uJppNKm0=
X-Google-Smtp-Source: AA0mqf4umE57aKlP5FZBu0cbWnf4tDkfYHvu2mpyOgbhJVi1oAWiCFiklzazAfkUDT3Hm8W42g75yQ==
X-Received: by 2002:a17:906:4e8c:b0:7ba:9c18:1204 with SMTP id v12-20020a1709064e8c00b007ba9c181204mr35229481eju.262.1669914924391;
        Thu, 01 Dec 2022 09:15:24 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ay17-20020a056402203100b00461e4498666sm1943627edb.11.2022.12.01.09.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:15:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0n9f-002KhA-0y;
        Thu, 01 Dec 2022 18:15:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Date:   Thu, 01 Dec 2022 18:13:58 +0100
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <9c6400ce-6f71-6f1c-dd7e-719c7181fe83@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <9c6400ce-6f71-6f1c-dd7e-719c7181fe83@dunelm.org.uk>
Message-ID: <221201.86mt87gi50.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 01 2022, Phillip Wood wrote:

> On 01/12/2022 16:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix a regression in [1] and discover git built by cmake in subdirs of
>> "contrib/buildsystems/out", in addition to the "out" directory itself.
>
> How do you propose to find the most recent build? There are different
> directories for different architectures and different directories for=20
> debug and release builds.

I'm not proposing to do that, besides, if you built locally for
different architectures running the tests would just fail, wouldn't it?

> Hard coding the build directory is a bad idea and should be dropped.

I think it's a better idea to target the common case of a user building
& being able to run the tests form t/, rather than requiring
bootstrapping that process by running "ctest".

Did you test that case on v2.38.0 and/or master? I.e. is VS running that
ctest portion automatically?
