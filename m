Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D147C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 10:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiLNKit (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 05:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLNKir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 05:38:47 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914322B0D
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 02:38:45 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gt4so6494188pjb.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 02:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9lP5vsaj04oomii/TQgX21ZX/cpgDDJ797ug4dOa0M=;
        b=fCEy9brxTJsY2X7Rm+MpzTOWktaUnfr/gyKWJxD/grGOP9kIZT1/9ic5XtgNo+wpzf
         q3vd7yRRv/vh/f9AOPXZI89/MeBkCdF5QT5zxg0Ca9lkOvaNpxoGctd4Y5zZQ1kp7nbH
         FcHX+0tukcYEieD/BUUNGQO0rqnOh6w2uaP10nEP62EGGDsGhtAqRK+UpBHyTGkkpLB6
         6ZiaJ1aiWZbnGvIPyyp32kh5YGrtx+DloQ3S7J7tqeFWh3JeelZGPAjh+dl/tAXaizXJ
         KPEUZRQVWdDPfgGWb1yVjWLfjgJ8kxVBoMhM/lY8LmTFhhGY2uNaC6kTSUHLWCcIGZit
         QyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9lP5vsaj04oomii/TQgX21ZX/cpgDDJ797ug4dOa0M=;
        b=Dvlh1BOd/2JAMCpfsacMX9eUWE3fNGroHSo+1qutPwnX1eR2MP1oSeZNxogP44fUbH
         ZgMq/tkn2NmWxPcT9aWj1ho+tvAFYz2x6Cu5Gnq8ZNJMGLcg0CUcTdRwpcd/ck8RXM31
         8e9h3gI22FIMLGFWPqesUV/ZUVDmi7UCHIsDsq5kI11k9QofI4gFGbd2lD0dQv7XL/ia
         StT58pS6xOv2AmtbCVzKXvFOty54s/vr2sPq3TxvJt/iRIJij92Ajq19eAYoSGiR+65s
         LadANQjlyJkQ2OjpDApVZ2TyavKN4SJrbOOCYLPyfN3c4qNae/4g4hUZcl4T4/GEdjXb
         bYGA==
X-Gm-Message-State: ANoB5pnk97s8oUfI8i/pPZ3OxgzXp35tICW6Xc82eB5hd9wEyHfvoEL8
        IXxNdE4CpgS0XNXp1ZoRF/o=
X-Google-Smtp-Source: AA0mqf5wOROivoSAUFJQ1QBUMvsUcXUm7fBKNLtFJa50bHM5rzFtVKO2yh99Bkrnzl1xllT6Ujfinw==
X-Received: by 2002:a17:902:a70b:b0:187:2501:72fb with SMTP id w11-20020a170902a70b00b00187250172fbmr24458526plq.46.1671014325314;
        Wed, 14 Dec 2022 02:38:45 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b00189fd83eb95sm1571513plx.69.2022.12.14.02.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 02:38:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: [RFC PATCH 6/6] ls-tree: introduce '--pattern' option
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
        <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
        <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr>
        <xmqqtu20qinx.fsf@gitster.g> <xmqqbko6y2q5.fsf@gitster.g>
        <221214.86edt247xk.gmgdl@evledraar.gmail.com>
Date:   Wed, 14 Dec 2022 19:38:44 +0900
In-Reply-To: <221214.86edt247xk.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 14 Dec 2022 11:03:39 +0100")
Message-ID: <xmqqbko6w9qj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> This is simply insane and goes directly against the "one tool does
>> one job well, and can be combined with other such tools via pipe",
>> which is a key to scale the usability of a set of tools.
>
> I agree, and FWIW I read
> https://lore.kernel.org/git/20221121114150.3473-1-tenglong.tl@alibaba-inc.com/
> as the submitter of the topic agreeing to drop it ~3 weeks ago.

I actually read "it's useful to me" as resisting, but I already
discarded the topic (not just "I stopped merging it to 'seen'", but
"I no longer have the topic branch with me").

Thanks.
