Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C532C433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 11:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiKLLvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 06:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKLLvm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 06:51:42 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB613DF6
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 03:51:41 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ft34so17870766ejc.12
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 03:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0jpBLh/vbYiIaoIyRzdLCdc2++asIVx2e+PjLuZLInY=;
        b=q5RnqXH64/2PiTG8W0P1g2i890m0uvPhf41UvGiOGY5M9+CDE1Ca4ZOUNrBU4m8ytc
         SWh46HpkJWFkYWe3hH1k8AG9yX7xxinRnOMe8dVkJJEtl2vg9YbdN3LdboPUEWTGbESb
         39jZkKYwkw+xTwvdX1Ags/xnLctT1877qVqclLKhBU4LdH5AlzBeLJMa2kGpsVx75yDm
         y7KRjt8zs6YqOxC7bdm3y3KgI78YsFDdWRSN3KJJFshZIBmhMwIxYup4oJX9h4Fo7ikA
         Fl0CINtYTFxoZr1OQa+WGA3QdTsewgsH4FM3/UxECdbqUhseFDaMsZxoLzm3mGQVvP9k
         WIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jpBLh/vbYiIaoIyRzdLCdc2++asIVx2e+PjLuZLInY=;
        b=Tjg86w0g2DZ8y/Tswe/7qEcBEqX0+rm5MHbMal+/8c/+6svjw45cWPsqaZJNKIdaJs
         xL22e9pg31PlBqvCMw88/iSwbWftY2gYMo/Xy9Cz796E3fTTklpobuq4oo4gAkXqakAl
         YCtdpSBkC8wwHosIXjym1FlmU1V8rIYwQjAnElbkSx/LXSVsvghbWfR70/NxWQmoUQ4u
         RgZrcC12fLPlzPrCvC2sRDOsjIHBzagInCsC9IQ+T1e/9dv5ZFHIk1nPWeE9PHszmb1g
         Pl3VPuT3zzCdzHqwaIm85Yp+/JolonztUgEfaK3WUiQ+IVLSI3qj5EcKnlzRZxZ4yipa
         hDDA==
X-Gm-Message-State: ANoB5pmQe7nCGhG080ZXzfHqGPxqCo6NseRTd6a6kfnazYum31EDPV1x
        TSYEfnkplBYAmKBfUu+oHk0=
X-Google-Smtp-Source: AA0mqf7rTQOJ+SBXwkFp1iBBdz0euS8LIb8aHGB3Oajklb2V9FftDH1BpjBTsJWlNG78em4IdlDHGw==
X-Received: by 2002:a17:906:f205:b0:78d:bc9d:756e with SMTP id gt5-20020a170906f20500b0078dbc9d756emr4934495ejb.59.1668253899581;
        Sat, 12 Nov 2022 03:51:39 -0800 (PST)
Received: from gmgdl ([109.38.148.58])
        by smtp.gmail.com with ESMTPSA id ku1-20020a170907788100b00787a6adab7csm1862635ejc.147.2022.11.12.03.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 03:51:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otp2w-002AD8-0P;
        Sat, 12 Nov 2022 12:51:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] pack-object: simplify --filter handling
Date:   Sat, 12 Nov 2022 12:45:08 +0100
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <59abb8d2-e8e6-7423-ead8-49382293aaa6@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <59abb8d2-e8e6-7423-ead8-49382293aaa6@web.de>
Message-ID: <221112.867d00mlv9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 12 2022, Ren=C3=A9 Scharfe wrote:

> pack-objects uses OPT_PARSE_LIST_OBJECTS_FILTER_INIT() to initialize the
> a rev_info struct lazily before populating its filter member using the
> --filter option values.  It tracks whether the initialization is needed
> using the .have_revs member of the callback data.
>
> There is a better way: Use a stand-alone list_objects_filter_options
> struct and build a rev_info struct with its .filter member after option
> parsing.  This allows using the simpler OPT_PARSE_LIST_OBJECTS_FILTER()
> and getting rid of the extra callback mechanism.

I haven't gone through the history again, but as I recall this used to
be outside of "struct rev_info", then (I think I did, as part of a leak
fix) it was put there, and now it's still there, but we make a copy of
it, then copy it into the "rev_info" struct again.

Maybe we've finally reached the right trade-off here, but it would help
to discuss some of those past commits, why those arrangements were
wrong, and why this is finally the right one...
