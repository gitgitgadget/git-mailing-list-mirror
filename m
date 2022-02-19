Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F96C433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 03:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbiBSDuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 22:50:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbiBSDui (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 22:50:38 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905745FF23
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 19:50:20 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id v10so18650391qvk.7
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 19:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZYgVix/NDW3YAyW2Z4iHKkFrn9kyOkkTk8iyjibuFss=;
        b=YvGEj+gZlAlfXXk2w669ZUtQPo3nhnYcxLVzHAO40gdOrt3/aFPd3JawxA+Qn0hF/l
         svxn4893rcOdLoK9jccTdoVHtyiIGsNp3+VrmEt0uSUR11BGmSji69wYEcw37Hpg18Wx
         zWZX/IMhLvsgKZx/F3qEbdhBPkEBt4ryfcYQG7WuVL2Uj0SOMlU4oSYGzzYud/vyK/as
         LdXbDgqpnVXbJvZu/cCNufxfhfQ4QT5Pla9um+aSGqOCwBWuI+52Yx+knKibImMBSkbg
         FgMWdqvMLQLWhf32KhtiozqQGCloxWpjBRWxVWA00VNCukGjUcJ1Wk3moPijJ5fCYVys
         Wyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZYgVix/NDW3YAyW2Z4iHKkFrn9kyOkkTk8iyjibuFss=;
        b=w2c5Z7dDZwqoSvp+eGrgjt9sUuXBorsADKmjQ/w4ocDliIwLI/63Lku4y4BGBEWfgM
         rg0hP/J9ViupvelbTvM3IYE5FtaRaU0B7bFrs9cQr5AenokI3c9KUuIU20hcoKGY8oI2
         NRfCG1dqkqEL9rnU0UmxkYkNdnX27p9nQUi4it/96aVqQOAiarLumUbVekXA5pzvVpX4
         /YmwDg1f3L1vtbx/GY0dHMTMQS8YCZpWAJqv++LbRXgvkgYjsN4WQtPkhQyz/tRnQ49n
         6SKk0SetKfbG5QfGW3EUe23TnJghnNyqdWWmNQtubWBa/H2O9CHlCEvQFnhSain86fxe
         0/8Q==
X-Gm-Message-State: AOAM5315lB+RF2lmmErKeCKpEeReHnMRPEeBI6KQ0qMV62lWvzwwg3BU
        7lhCzx1NFhcTNb+pUggCtSg7FQ==
X-Google-Smtp-Source: ABdhPJxwPUOHBawBnuFigf2p5oG3JpaO58gAvT5Vv2FZtfyo47PNh8jMoZDgAwMVV+RH472Ae2dPTw==
X-Received: by 2002:ac8:4e55:0:b0:2d2:2e5a:444 with SMTP id e21-20020ac84e55000000b002d22e5a0444mr9449191qtw.150.1645242619708;
        Fri, 18 Feb 2022 19:50:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a6sm27524845qta.91.2022.02.18.19.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 19:50:19 -0800 (PST)
Date:   Fri, 18 Feb 2022 22:50:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] ls-files: support --recurse-submodules --stage
Message-ID: <YhBo+hg8yxIOGKNS@nand.local>
References: <20220218223212.1139366-1-jonathantanmy@google.com>
 <220219.868ru7fsad.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220219.868ru7fsad.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 19, 2022 at 04:11:30AM +0100, Ævar Arnfjörð Bjarmason wrote:
> But why do we need to test the OID abbreviation at all, isn't that a bit
> too much paranoia? Isn't it sufficient just do:
>
>     opts="--stage --abbrev=4" &&
>     git -C submodule ls-files $opts >expect &&
>     git ls-files --recurse-submodules $opts --stage >raw &&
>     grep submodule raw >actual &&
>     test_cmp expect actual

Yeah; I like this direction. I try to err on the side of reconstructing
the whole output and then calling test_cmp on it. I usually go that way
because it's nice for somebody reading the test script to see what the
output is supposed to look like.

But because you have to have a bunch of $(git rev-parse --short=4 ...)
in subshells everywhere in order to produce the right output, I don't
think the result resembles the actual output in this case.

I'd probably go a bit further than what you propose, maybe replacing
that grep with:

    grep "0.submodule" actual

to make sure that we got the correct stage number, too. But I agree with
you on the general direction.

Thanks,
Taylor
