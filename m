Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC84C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 14:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiLHO32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 09:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLHO30 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 09:29:26 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8716E1DDF0
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 06:29:25 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id s10so1745571ljg.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nf/K/316EYp5JtSCrvabZWNJ3umsdzgMX7+GNU+itoQ=;
        b=XDV1Y3/y0MR5yEY2vrrOGFbEj11rzlwqspTbCmehdus5XwadHRbOGWV1/70wnQ9H9a
         3a440s2KE1Br4uyRO74d1hG4byKJ0tuG+aGrARjhgrKvPr+l614r3wSCbw1KQptNMbsM
         pVKCDDB9O7u8YQlO+Q909bydSpV9GjCx+stGuR/qvg8js8heAe3/FdYhO0KUr+JxRtsq
         aLM/zSfmjaCikRj4FwWaxK/WC0m8tU5sbf768F5fIGz22KjCjovWz43kR1VXcEeQSgqX
         jfuCL9eaRHoafrF51zZe3p1YLkmn+ZxjrjEAE8LnGMeLA0XutS99SW6zoObJ3h5cC2xz
         /NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nf/K/316EYp5JtSCrvabZWNJ3umsdzgMX7+GNU+itoQ=;
        b=R9KtlNc7+6W0w5yPh9CwWTtq2KsVKtz4WuXW+6jcKQd1w350fOk+/qAXIOkcVY9TWA
         eOV8MxfzS0pMH77SBtywzO/+L1SXJFOJLytyODEsUGqytLouMFFbRl+LWysihq+Ttr0o
         NjBbwbM+jLTDCtXky2MbnIntm1OayoBVT0tfn0W06/2Ge2DhpReCYwiRxqrurjSIneTI
         nrBeEqEEtc/wnhgc3mLyr9nV+4cRrxCfWb8NMoC2uAuDVEoPkIjz5wQ43/HijiIjjkTG
         5FY5V68uPL14FM5d4zw2hYXm5D19KRCfCvZINkl0+a3yCIqKxjCecV55ycO5NHZzs0f3
         J/Lw==
X-Gm-Message-State: ANoB5pmdZiR3T+1Kku/0hiXVNhpn1jLIeddf4/3SmLKq7REApGCiigjQ
        Hi4DqXLZQSYUQBTXNuvon6qi4/tzQAs=
X-Google-Smtp-Source: AA0mqf5HOXKfpX2kRRNDQ+kLIKStAtRQa8SAd1Plp2nMEnpRvdERt/L8pv32DVLb1TgQYWevKDLoqg==
X-Received: by 2002:a2e:868d:0:b0:279:e06a:bb45 with SMTP id l13-20020a2e868d000000b00279e06abb45mr542189lji.30.1670509763044;
        Thu, 08 Dec 2022 06:29:23 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r6-20020a2e80c6000000b0026daf4fc0f7sm2298083ljg.92.2022.12.08.06.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 06:29:22 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] diff-merges: more features
References: <20221127093721.31012-1-sorganov@gmail.com>
        <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 08 Dec 2022 17:29:21 +0300
In-Reply-To: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 07 Dec 2022 15:55:21 -0800")
Message-ID: <87tu26arzy.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> We covered this series in Review Club, thanks for coming Sergey! For
> those who are interested, the notes are here:

Thank you all guys for the review and for valuable discussion!

[...]

> During the discussion, it also appeared that this "modification of '-m'
> semantics" refers to a patch that changed the default but got reverted
> due to breaking legacy scripts. It would be extremely useful to include
> a link to that previous patch and the discussion around its revert,
> especially given the discussion about whether users actually need
> '-diff-merges=hide' ([1] and elsewhere).

The last time '-m' issue appeared on the list, it all started here:

https://lore.kernel.org/git/CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com/

In particular, the final patch and its revert is deeper down this tread:

https://lore.kernel.org/git/20210520214703.27323-11-sorganov@gmail.com/#t

and

https://lore.kernel.org/git/YQyUM2uZdFBX8G0r@google.com/

Where do you prefer these references to be put, in the cover letter, in
the commit message, or in both places?

-- Sergey Organov
