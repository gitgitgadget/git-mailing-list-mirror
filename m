Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C316C433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 14:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359120AbiDCOeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 10:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359051AbiDCOeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 10:34:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395D39B85
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 07:32:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i27so7907755ejd.9
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=b+EjRsFODdslocqWYLuLT/Yrs4NvG/AP9jcjtZy3IXM=;
        b=gvTnQ5cvxkwAmGo2vfrincXtXbGPK4k9y/JOCKFK/S7DEZ1vwrRTupbSUP9DdLH6c5
         TUHst2+oxzFKpKPC2fYiptjTgi02WLpfjFcNDihwzYR1JEjGANXu7tPozJuuYXeQe5Qj
         ThSz/wq8uf2smoBl59hCFt0alu7FjnC/A+pw4+QSU9cqSu8nCGyrEaGRyQaqL2AhYGbX
         3JaDuspdftFNmTxHXF/zJ1mhVswqao6ILwH6ivu3bM0Tfq4NMCc/81r/zhlrOKJ9HPCy
         aB8zlMcst61Sj8TcbOzHon3HsLH1wAYmj/f+FxgQBuOBMn2UKJZSVUAXXq+o296icrXT
         JIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=b+EjRsFODdslocqWYLuLT/Yrs4NvG/AP9jcjtZy3IXM=;
        b=aaiA2+w+6EQ0R7hP33cjgsd54vJ2HSYzY0qZPdzFFO1DkrBre4TOlKoQ5mzHIK/lY3
         eNZrZWQTS9eaPShYm9299jXB66E3X5ZsroZ1oE940z3gfrWx/F4EVhlwUNqgQkM7p9AW
         5eegS26EADxWUi+kKOaHIN9Aygf7WVNwLduIdJzNHp59F+5+beFo/RwR8fR54jZWRLAs
         HOHUfzYWZyLDsNbiBjE46WcnB01c+TRoaW5TRishbgB2FjLPeD3bVnZkrjRiQ+9YQ42Y
         qNhLtWWes5NpVpWjSCzgsxgz8CmlYAmDySpJkgfW5flHAilqROhM/8voFOvBQKJ/wSsu
         fMaw==
X-Gm-Message-State: AOAM531uBTXwgVhBr/SjTWgcahe5Jc30+SPorWoysNFw1tzqxu518nhl
        5b30kxvPNawVOXc3SRmLv1y7zNUxW+c=
X-Google-Smtp-Source: ABdhPJxuTWmH1fkz+IpM73ofC+04RIP7ViUIgXiPthwZdi7aPrmpZliCC1K2+S0HfGB/IXOFK4eW4A==
X-Received: by 2002:a17:907:971c:b0:6e0:dd95:9fc6 with SMTP id jg28-20020a170907971c00b006e0dd959fc6mr7446454ejc.256.1648996327000;
        Sun, 03 Apr 2022 07:32:07 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090651d100b006dfa26428bcsm3276850ejk.108.2022.04.03.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:32:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nb1Gv-002Ei2-PE;
        Sun, 03 Apr 2022 16:32:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 00/27] revision.[ch]: add and use release_revisions()
Date:   Sun, 03 Apr 2022 16:18:09 +0200
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
        <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
        <5d3345d9-3c7c-a761-9c7a-03468a653e48@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <5d3345d9-3c7c-a761-9c7a-03468a653e48@gmail.com>
Message-ID: <220403.861qyeme56.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> I've left a few comments on this series for the patches that I had not
> looked at in v4. There's nothing major, the changes mostly make sense
> to me (though I'm not familiar with the revisions api)

Thanks a lot. I'll re-roll a v6 in response, but will wait a bit for any
other comments.

> On 02/04/2022 11:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This series reduces the memory leaks spotted by our tests by at least
>> half, see v3[1] for a more general overview.
>> Thanks a lot to Phillip Wood and Junio for the v4 review! I think
>> this
>> v5 should address all of the things brought up in v4 in one way or
>> another, changes:
>>   * The "extra_headers" or "ref_message_ids" freeing is the same,
>> but
>>     the commit message is altered to explain that commit.
>
> I'm still not that convinced that these are owned by the code in
> builtin/log.c but lets leave that for now.

Thanks.

> The rest of the changes
> look good. Thanks for working on this, when I use LSAN on my patches
> before submitting them I often see a lot of existing leaks coming from
> struct rev_info.

Yeah it'll become a lot more useful now.
