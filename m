Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41860C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiKSMvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiKSMvx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:51:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6306CA1E
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:51:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z20so9085189edc.13
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lGzQrhNV/FFBl1hp0+1rIF0ozcisqDEAq5rFNcwn/xI=;
        b=nzULbrNsDV5dsI+Qu3KwXVsUiA3BAyR559r1RzxYQzgGY2NTcRDGlY0UDI4HRkFXUy
         cSCTcqX6sBlBC7qFZAFMw6OjsiP+U+w1kN0ihBxv0e2Ynm7WscIi3CMxn+BDwXSJ9ZDI
         uDmL1zkoC1a8zB/Zj9v1VjpvBJv+UCSpi+HSlJ3pNOrIDRIJ44AVv2v+qAeAOh0qCuqz
         OcqaAjGWDTn37xsfvnZK1lFXn7RMLmQeCoqpL9XwGJoR+Nk4Ej/yloWbw+4Ohf1zOdz9
         QmgySh+1OQNrNWpAIvWd+jFyJwjbZ80E3A8yMIlob8+BVuwdFC5Pjk+1/xFYLn4r0pVp
         hUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGzQrhNV/FFBl1hp0+1rIF0ozcisqDEAq5rFNcwn/xI=;
        b=qPCfexIoteNGLaLdGvdsG8mzdtXuddHueLRCIlTCS6GQ5vo1V67NOraMiWQ0zLHBwz
         ZeXSMwDwQfsVBSZs0PYGWC9MOOhEooaUvi3eaWWITincYb9UeD9BOislKAv9skyb3PWi
         WxTgs7Cmm4vQbCJLip8xeTnT9SNrk+gPTKCsJAreBvTyDPQPuVyJoNgSXY/XozOKhvQc
         BvfFvb5XbZCMpoFwdhkW5/TU7HZIXlbPHjk0COZCrLfgAe6s6ki4CP+MVU2cFcv1IYVR
         HW8KU+YzmYGtgib13kp5dH4B+gx6n0Urqe1s1vbEAxV3SLTmWsseDkt5wcLP7/8QhPIT
         YLGQ==
X-Gm-Message-State: ANoB5pnP9S0coC/HQY2fAzl7UPhVaewkv7a6eBUTKpDtvtg3/zC0Cxee
        08L7XHxhrzXxJgtcj1gA1LA=
X-Google-Smtp-Source: AA0mqf50aqL4WLz1ukg0b5kNsSSk1S0GbpU4M6DIF3wq153KdGcpqdp/52UfdeBaxygtZmeMOlMF9w==
X-Received: by 2002:a05:6402:1744:b0:459:2d37:dfbd with SMTP id v4-20020a056402174400b004592d37dfbdmr9823657edx.336.1668862311024;
        Sat, 19 Nov 2022 04:51:51 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id lb13-20020a170907784d00b0072a881b21d8sm2835927ejc.119.2022.11.19.04.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:51:50 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1owNK2-006D6v-0Z;
        Sat, 19 Nov 2022 13:51:50 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v9 00/12] merge-index: prepare to rewrite merge drivers
 in C
Date:   Sat, 19 Nov 2022 13:46:13 +0100
References: <20220809185429.20098-1-alban.gruin@gmail.com>
 <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
 <Y3gVekgT7jLibjWo@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y3gVekgT7jLibjWo@nand.local>
Message-ID: <221119.86o7t3ds49.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 18 2022, Taylor Blau wrote:

> On Fri, Nov 18, 2022 at 12:18:17PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> This is a prep series for a re-roll of Alban Gruin's series to rewrite
>> various merge drivers from *.sh to *.c, and being able to call those
>> in-process.
>
> Thanks for resurrecting this topic. I couldn't quite tell what this was
> supposed to be based on from your cover letter, but digging around your
> repo, the best I could come up with was:
>
>     $ git log --oneline --first-parent --merges master.
>     00c0dd7b8a Merge branch 'ab/various-leak-fixes' into ab/merge-index-p=
rep
>     dc39d4bbb4 Merge branch 'pw/rebase-no-reflog-action' into ab/merge-in=
dex-prep
>
> when queuing, which seemed to do the trick.

Yes, sorry. It completely slipped my mind to mention it, but it's on top
of pw/rebase-no-reflog-action + ab/various-leak-fixes, except...

> If that wasn't what you had intended, let me know. The series does not
> apply as-is on top of 'master' (which is at eea7033409 (The twelfth
> batch, 2022-11-14), at the time of writing).

...just applying it on ab/various-leak-fixes won't *quite* do it, it'll
also need the more recent "master", namely the now-landed
rs/no-more-run-command-v.
