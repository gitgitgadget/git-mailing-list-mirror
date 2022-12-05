Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126E1C4708E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 23:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiLEXOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiLEXOD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 18:14:03 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D3AE66
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 15:13:27 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c13so5785848pfp.5
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 15:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpxLm5S7OvUxVBqx8ryxkYBvMYZBeDWwyrRqpm00LiU=;
        b=B15mitsZCHeJy8BFLjsOGr98akWX/rFjlwqoKqmtmV3B+LbHe6KJe3FYPinuPkLcnk
         Gd8GpDAE6CljRVSpldwUkkfYMaE10Rtac72dwyzDoiYgCugevJKeDsELK/TMPne3lAtf
         01LGSRIyPdCGEfNbhBRlPHvbThKp5by30eO8/Hop4M0ZqduzMEYvV9Eydn3OcTN8PoCZ
         EFmLEv2nUtrPiMRWbmv2ZOA7POAEQzyGSkdY1qq2mAxPJiMzE8LEuHjkfwH+hofNcQ+a
         rpSLk1wH0URWrxNOQBqdLxzWSAoJEDceC5f1mN9V/fA8Mes4lXxKy4Ef7vVYFeMtedQd
         X+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vpxLm5S7OvUxVBqx8ryxkYBvMYZBeDWwyrRqpm00LiU=;
        b=qcBq7BY7OZyHTtCp6cj5WWDh2CI02Y/ffdLcjpMpjGlkCmNzQFxB8pc4pi8HhBS2IV
         IR81VsAcENbAesU1GyYVyv7pI5Onarb1gqp56kEqoUkeVZN1OfT+x/o+g/2sCLkm7yii
         xGbKiFVgyqd2emtaBJG3rA0VM0bzs4wj1ftNZPDTSUQjK6u+NrhI5mCzlOOrXB/HzdG/
         oKDMGy0n6CFH5dWH1bu/ug6xYWYSp846tJ2OJ32NTtHyI0g1ehx49jZy/vVpJ/jKueMK
         sflz+qzY7850PFCqFBLxwkDG1hqShKZbcENdM4cRHL8Zg/CrztYL+4I5c3pjrVUvjSIj
         37gA==
X-Gm-Message-State: ANoB5pmS1pwmvNYa+KOqoI39hZIIADjcDErpvZhqgtYBbfmh4s943MeE
        BF7zXIsioInoLL+gwL70y+s=
X-Google-Smtp-Source: AA0mqf6GkcR+4+DfN8i9ORP0HojxRne1UClL21SITQckBMtxcMtKYLeryfBVXq36eic7HGkpP8/g+A==
X-Received: by 2002:a62:cd0c:0:b0:576:f200:b64f with SMTP id o12-20020a62cd0c000000b00576f200b64fmr7174361pfg.17.1670282007222;
        Mon, 05 Dec 2022 15:13:27 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b001899007a721sm11036954pll.193.2022.12.05.15.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:13:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
        <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
        <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
        <221202.867cz9fwnf.gmgdl@evledraar.gmail.com>
        <4711d955-02b2-f599-7f89-b442dd0b6215@github.com>
        <221202.86359xfs5c.gmgdl@evledraar.gmail.com>
        <1b090929-f2da-f075-01d4-458804fc0717@github.com>
        <xmqq1qphuwj6.fsf@gitster.g> <xmqqv8mqsm2g.fsf@gitster.g>
        <de558eb7-8931-a5b5-d711-459ae3f52216@jeffhostetler.com>
Date:   Tue, 06 Dec 2022 08:13:26 +0900
In-Reply-To: <de558eb7-8931-a5b5-d711-459ae3f52216@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 5 Dec 2022 09:34:11 -0500")
Message-ID: <xmqqsfhtphpl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I like this new text.  Let's do this and call it done.

Good. Thanks.

> Since I see that you have already added it to the commit message
> in the branch, so I won't resubmit it unless there are further
> technical review comments to address.
>
> Thanks all,

Thanks for working on this.  Let's mark it for 'next'.  Even though
we'll see -rc2 very soonish, being in 'next' this early would mean
it will be part of the first (if we need brown paper bag fixes) or
the second batch in the next cycle.

