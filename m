Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC2BC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349332AbiC3RhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349330AbiC3RhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:37:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B882A8890
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:35:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b24so25273404edu.10
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gXJJJzdGogtQadGo0poO9xUyX1dFOGwIY7AZrsYaiXY=;
        b=b55/C4a9T5ieFB9gznp7L/2C2kQYkA5AI3/i0crKRpZ9qIEHE6uliJSFPNVunPCwmw
         prCuHXRawjk5dXP/Nk/ZevRzxYvkrejVEma+Wm5Sr/BnlzzIxRbsvcerv11tbN/e+HSl
         Gld8pJ+PjArBp5I4x9tpomreSepQ7tj08LnQmzGxDduKmzYgwwvKXBsrZZyy9GnmQVV3
         MG2jz0vYJ/d4o5QJ5Fnd4Wk68KO+iJBpybpNRlLsWojW4nq9ibnAm4IQYg9lesMUTPIl
         nTCwragFgU425sw9295IFLWAt0ESUeIh/TeP5bQJrkshbCjQ/CVE/e4TvCE+Y/QbEQyx
         elGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gXJJJzdGogtQadGo0poO9xUyX1dFOGwIY7AZrsYaiXY=;
        b=w21UJEGL84qDrr/sheRFo8apv/zqYiH64B0+6ygEiSke4f7OoxTW8atsE61TIXBcCP
         Jt6NzTiZqPonfaHMDuek2yva10Or1wvA1OrbBl+fXUp2vgFmS632RH6/4aPRcMMIsk/8
         hz3iH2bjJelD/eTe/WSYEK50DILcWzhgQCaYF2B+eMWJQDFWVqP2WFrexyEHEmdl5/F3
         A4obfLQuK67CizMPUjLJj0h/j713jjFm0AGejVXGie1fFvckuuzAAPzsMDQz8XXc88bz
         CE/ONi80vXgy7oW3LVNxxtalkZ0T2EmRy7FPyOImM+Vd/xz6iwL6WIM5k9khsxphZGmC
         Oaxw==
X-Gm-Message-State: AOAM533MEFrs3NN6bgJUpzoyraDazS249oP4ceUsBuRIesAK7OIBN5fU
        UylzAMagHvRP6WAZ6FMZCbq9iajmC38=
X-Google-Smtp-Source: ABdhPJzUfsIbipZnIza1tLqHHu3JsuIvB4URZ3wCNw2uNrggcXKvHoDG1TcrP0sGQg2DzddF71bKOw==
X-Received: by 2002:aa7:c345:0:b0:419:12ae:449c with SMTP id j5-20020aa7c345000000b0041912ae449cmr12055878edr.300.1648661729700;
        Wed, 30 Mar 2022 10:35:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e6-20020a056402190600b00413d03ac4a2sm10773303edz.69.2022.03.30.10.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 10:35:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZcEC-004Nsn-Jl;
        Wed, 30 Mar 2022 19:35:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, hanxin.hx@alibaba-inc.com,
        l.s.r@web.de, neerajsi@microsoft.com, newren@gmail.com,
        philipoakley@iee.email, stolee@gmail.com, worldhello.net@gmail.com,
        zhiyou.jx@alibaba-inc.com
Subject: Re: [PATCH v12 3/8] object-file.c: refactor write_loose_object() to
 several steps
Date:   Wed, 30 Mar 2022 19:34:35 +0200
References: <patch-v12-3.8-3dcaa5d6589-20220329T135446Z-avarab@gmail.com>
 <20220330071344.25676-1-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220330071344.25676-1-chiyutianyi@gmail.com>
Message-ID: <220330.86mth7ny1r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Han Xin wrote:

> On Tue, Mar 29, 2022 at 3:56 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
>>=20
>> +/**
>> + * Common steps for loose object writers to end writing loose objects:
>> + *
>> + * - End the compression of zlib stream.
>> + * - Get the calculated oid to "oid".
>> + * - fsync() and close() the "fd"
>
> Since we removed close_loose_object() from end_loose_object_common() , I
> think this comment should also be removed.

You're right. I adjusted it for the "parano_oid" in this v12, but
managed to miss that somehow.

Will submit a re-roll with those changes, but will wait a bit more to
see if there's any other comments on this v12 first. Thanks!

