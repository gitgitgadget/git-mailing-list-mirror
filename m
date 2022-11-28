Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F341FC4332F
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 18:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbiK1S66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiK1S64 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 13:58:56 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC11720BD8
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 10:58:55 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v8so16753618edi.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 10:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DvofmczWLhkhq9GF3sMBcA+4ZB2VGIdbwA9x10FWWj0=;
        b=SifUafe5bgo9K5xC/UMvL11fD0zeFbZK8k8FexIA4DpEHsfp787KHBdqzV4qUpExka
         nOobOEdOulGel73v+Wd4zSgwAPwU3qcxQj5ReP93b0j5yG/0vzVfyPdi8oPPpm6YCqrQ
         qg8t6sRVoYz1h/qJ0grxRKbjSXhbdKQBafXMfIa16ofb0kpSKX0uheyh6gkRDrPliiMc
         aPpC8SL7YrFZQIxkiXYNehZYBSKgV+wAf6OyHXwxGcmQmVLLxsmzaB2ynBd2DLmGoGE5
         yXGX7R2FA7mFya8Gs00v+qeIRPQ0bcco4AeCe66kWsrRMpztryqAQj8JKwyMivefWt1Q
         lTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvofmczWLhkhq9GF3sMBcA+4ZB2VGIdbwA9x10FWWj0=;
        b=SLH7izcH1WejObPE9kpbQrnOQH6EFNiRfbCfQ9rEowdAldIJUEbFwchkbW2I3XrxJ4
         7F3jJoYqvP6CfDjyQhzq/OvRpOcNat15hRo4KpFtXMIE7lzOBDkD76UU8M/man6zGRfZ
         mxO/ROCVCzh/5hSYhL9PnOr0AKr6gdUwpeaEtw5dLKwXDKwhUXfRJM1sTjmm9q+gDY3f
         BtTO0D+Oz3w+S2X3tDgVqYcraIFon73unVDBGnbe/F9zU02Hhi+J5GcuCZ0sWga+/2+4
         CvmA0OK2SiXd/1qP2QtES6oOPKN4nd5rfLcqu/Ma1MOJvO7FTgNHKIETgOgCVlAU5ofR
         iD1w==
X-Gm-Message-State: ANoB5pnidtb9+w1A6kGD71+G8uNm9YYJQGaStYybobL/HuUF0VfQG1Bj
        YZWk09RbXUz+MU4NsREsfYs=
X-Google-Smtp-Source: AA0mqf7c8q5+XLostNPFEnGPCSrG4V8l2AKRQ2A8PNnC5mxGRr1ZSX6AzdpNj87v2u5eVXRdWeF/Yw==
X-Received: by 2002:a05:6402:3642:b0:459:53dc:adc9 with SMTP id em2-20020a056402364200b0045953dcadc9mr41681154edb.166.1669661934183;
        Mon, 28 Nov 2022 10:58:54 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q25-20020a17090676d900b007bf24b8f80csm2207545ejn.63.2022.11.28.10.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:58:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozjLB-001FRE-0A;
        Mon, 28 Nov 2022 19:58:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     psmith@gnu.org
Cc:     git@vger.kernel.org, Alexander Kanavin <alex.kanavin@gmail.com>
Subject: Re: [PATCH 1/1] Avoid multiple patterns when recipes generate one file
Date:   Mon, 28 Nov 2022 19:57:56 +0100
References: <20221127224251.2508200-1-psmith@gnu.org>
 <20221127224251.2508200-2-psmith@gnu.org>
 <221128.86mt8bkyqt.gmgdl@evledraar.gmail.com>
 <43914959458ef34a0f29271afa9c9d981c2b3553.camel@gnu.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <43914959458ef34a0f29271afa9c9d981c2b3553.camel@gnu.org>
Message-ID: <221128.86k03ekis2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Paul Smith wrote:

> On Mon, 2022-11-28 at 14:08 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 wrote:
>> Whether we use eval/define or not (I just tried to avoid the
>> repetition) I think referring to $(DOC_MAN[157]) here probably makes
>> more sense if we're poking at these rules.
>>=20
>> I.e. in this case the rest of the Makefile is carrying forward what
>> manpages we're generating exactly, so rather than a wildcard %.1 to
>> %.xml we can narrow it down to just the %.1 files we're going to b
>> generating (but maybe that's best left for later...):
>
> I have no opinion on which is better :).
>
> I'm not sure what the above comment is asking for though: are you going
> to take over pushing this change?  Or do you want me to reroll the
> commit with these changes instead?  Or are we waiting for more
> opinions?

Just a suggestion in case you thought it helped, but I think we can just
go for your version.
