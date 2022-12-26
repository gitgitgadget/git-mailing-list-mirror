Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8781C4167B
	for <git@archiver.kernel.org>; Mon, 26 Dec 2022 01:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiLZBOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 20:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLZBOt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 20:14:49 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67C1037
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 17:14:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id ge16so5889429pjb.5
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 17:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwKMqntVPFegkcrGxNTHdSBPX7gKc/TorSHsQyYufeo=;
        b=J+GZ0yhsCIHati0kq5zLyG27Cl/ChjyBpIrBvDbQl49pYi+AHfwjspzzaOq9Uqgee0
         3qflOeHdCSg8YbYGOuU/aI8KmuTdWiFMJE+ElVvW0YuaC4a5fyh6odjo8QW7hnRtkK6r
         R629UmMd+a/Qjdp1rcteJhBvscwPbzKu/sJi2kmMuHAYJJmIKke5nt6h3+73eIZjG4RH
         h5E0qIqlAjnzpe6lgGCzy1zm3iTC/vykUTfLVGffd/89PpnDgyJz6A/FViF+l/OBoEdq
         +1uHfmjnrWLycesU9ergPSzDGkfmjNcZeetcPD2t6TyhjGDLrlA6uHcDTxQ2nqhwF3sw
         m5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwKMqntVPFegkcrGxNTHdSBPX7gKc/TorSHsQyYufeo=;
        b=tZRj9fAMjQZLKfbsAxvb1qjkDjKMBEFKMjjrKKbhv+rUOuThxNUMtucXdXLxE37f0v
         sOTOJEfY+g7gSrLBhWVjIUknX2gYSmrMXv0rbkzDbGxmteF8W2hE86SlIJ5xodF/T2AQ
         tdKW8WkQ+RLwUQCzQVJIgjlEKW+jiXAp+yX3BdTtrjDv+1J2Bqdcs6w7zNLxdiNK/OFn
         kgNwpgasrM2yrpzyABj4FCrAzEticfTr8h0qKKmhrZGjEw6wmxZMDgQoVhG5lBJQO7lN
         aDVrfZIw8HkM9Z7sxFmkWo4dbhCm5/8ufKXrRfbSo6AKr3ugceec3FbFtYNHnniThq5h
         btkg==
X-Gm-Message-State: AFqh2ko0+CFl5LAQShCiRVuVfXPZ1K1RxSYpW1XYl3FHePtng5q/DAX1
        ti23uL0QQ+FEJuFAM2EWUGI=
X-Google-Smtp-Source: AMrXdXtDMFB2gNORLppsJ7cpHdGFErxs2vAdG7v1y8Tqy9CI/xKuGdmAxYAp+VeUQmzSJL1DAzDnag==
X-Received: by 2002:a17:902:7594:b0:188:5e99:d84f with SMTP id j20-20020a170902759400b001885e99d84fmr19692216pll.42.1672017287462;
        Sun, 25 Dec 2022 17:14:47 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902d18c00b00186bc66d2cbsm5927495plb.73.2022.12.25.17.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 17:14:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 4/6] tests: don't lose exit status with "test <op>
 $(git ...)"
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
        <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
        <patch-v4-4.6-da66e5bf1c1-20221219T101240Z-avarab@gmail.com>
Date:   Mon, 26 Dec 2022 10:14:46 +0900
In-Reply-To: <patch-v4-4.6-da66e5bf1c1-20221219T101240Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 19 Dec
 2022 11:19:27
        +0100")
Message-ID: <xmqqwn6fm0e1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> As with the preceding commit, rewrite tests that ran "git" inside
> command substitution and lost the exit status of "git" so that we
> notice the failing "git". This time around we're converting cases that
> didn't involve a containing sub-shell around the command substitution.
>
> In the case of "t0060-path-utils.sh" and
> "t2005-checkout-index-symlinks.sh" convert the relevant code to using
> the modern style of indentation and newline wrapping while having to
> change it.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

Unlike the previous one, this looks sharply focused to deal with
having $(git ...) as one of the arguments to "test".  Looking good.

