Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8023C433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 14:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiCEOSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 09:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiCEOSI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 09:18:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99F222F960
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 06:17:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id h13so2020490ede.5
        for <git@vger.kernel.org>; Sat, 05 Mar 2022 06:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PuLP5FxbfOrZTiCulQTTKFmgeUSWEskEi9tc0klCJIA=;
        b=j/9SwfYEvdV2YG+Hp8LwD3mmM7aB9KmB6z552bErcXGXn5LeHscR9ToY5D2V3RevLV
         h1cw20Ylab1kNnHhvF/C9D9n048lDkMSq+1ypqM44KFn8x41ey1uwJfCm3ltxcFuY6cX
         2mUyo9kUva0J7GmXSqb6aAq4unBqDUEAtKRhXFBSXdel3odqqEfWbPI6GAWb7+xFDImE
         uL1oYzWLXWL5UpRwVfYRfEld3v9kO9/lXGae4sWPoP26mmLdHP35h6LKgs3NAcpMV8DH
         HTfoWZ9S9qEFUiZUpXV40tEtzXdtB7ea6VRnrBN7E/fghP54kcR++G9W49xCQPlqQ5H3
         dJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PuLP5FxbfOrZTiCulQTTKFmgeUSWEskEi9tc0klCJIA=;
        b=AUyOoSs0mU9FvIUw2x//fu98cJwuHkOjar3MMz8ksN8TqwJID3F6KzfYvs3BlHvb7I
         SmSY5HkKorLirZAOcK7sWK6ggmprGpEnorGG3upJTuxvhhcb6s2udf6hU/ASeqfpWqsq
         3imGdOJCeOHaSfzkCrBwYUb/IPR/j66SHtgni5vS80cQSDfCAI+h7LE0UtbtL20xT/zG
         ysmuijWCuvkiGEMrNLq1jq9zgNZA97ZtsZOTl+lTzdKVreDmGMJbxADwRFshJk2mkPhL
         UcoaimRRYg59p6ghupE1fkiOuiiQDf4bxWDRXT9iWZfo8DAyAIIk0eq8dSYZHqzG629v
         cfYA==
X-Gm-Message-State: AOAM533UPkyFNC4AkOyfGs+DV8BqtvJ0REjux4JvjJhTEW/PyVVnBxvJ
        vk8UhVgErzgwIVM01WHdPOgjlMk5DdebuA==
X-Google-Smtp-Source: ABdhPJwt6leqag5uGblVQLpBevT90cCVN482jpC56yUBQXUKsH6YqOKMSnwGiTwTm4OywUaIM7LXaw==
X-Received: by 2002:aa7:c54b:0:b0:415:c714:7a1f with SMTP id s11-20020aa7c54b000000b00415c7147a1fmr3068220edr.385.1646489836898;
        Sat, 05 Mar 2022 06:17:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm3404597edt.92.2022.03.05.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 06:17:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQVDf-000Wrx-9G;
        Sat, 05 Mar 2022 15:17:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 23/25] CI: stop over-setting the $CC variable
Date:   Sat, 05 Mar 2022 15:15:01 +0100
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
 <patch-23.25-8a8b7ecf16b-20220221T143936Z-avarab@gmail.com>
 <20220305081746.GA1655@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220305081746.GA1655@szeder.dev>
Message-ID: <220305.8635jw4h78.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 05 2022, SZEDER G=C3=A1bor wrote:

> On Mon, Feb 21, 2022 at 03:46:35PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> As detailed in 2c8921db2b8 (travis-ci: build with the right compiler,
>> 2019-01-17) the reason we started using $CC in $MAKEFLAGS as opposed
>> to setting it in the environment was due to Travis CI clobbering $CC
>> in the environment.
>
> This is not what 2c8921db2b8 detailed; in fact 2c8921db2b8 detailed
> the exact opposite.  Travis CI did not clobber $CC, it set $CC to what
> we asked it to.  We started using $CC in $MAKEFLAGS as opposed to
> setting it in the environment, because our Makefile _ignores_ $CC in
> the environment.

Thanks. You're completely right, I don't know how I got that wrong when
writing this summary.

I'll fix it.

But as for the body of the change I believe it looks good & is
consistent with avoiding that issue. I.e. we'll set it in MAKEFLAGS both
before and after this change.

We just won't have a separate "CC" variable in the environment as far as
GitHub's environment variable dump is concerned, which IMO makes this a
lot easier to follow, i.e. we only need CC as a "make" argument, so
let's add it and other such things to MAKEFLAGS only.
