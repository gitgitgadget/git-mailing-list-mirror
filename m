Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6722C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 14:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7886764E0D
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 14:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBIOHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 09:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhBIOHn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 09:07:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2853C061786
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 06:07:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t5so23742428eds.12
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 06:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=zXBavbZX4zgHSuA2sVlldbcLxzZU9tltdFJ6zrKIf2s=;
        b=Dv502sm5TmHjlx2hp+GUwNKTydVOOEsNH8vvSsCkvHWb69W+JandWnhr3BI7kBP/PO
         50+ISDcM4e0xt/qW5hnujKB0wteam6aITWXc42IaoxfI4SgDyMR2drrEoGZSXKgDhkpv
         6oufo4NAKmwNvMV4W7OlTpKSKaoV58DyBkADHlkMdhpFf0Z9YEqlFublJ94EWGVEYnd7
         cJKa+rWWW6Wz7lf1Axw1uyWWi5ZYYEtZaNfU1Wo39is6qjks19XUXHW+mMvcWOBPIeP+
         tv4eMmbyWXzbRIxwGmhmBIaoG3nkWaJA/2ZkYbyswjx4IVbFeIUCAnrElzh5EeEmHPzB
         peYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=zXBavbZX4zgHSuA2sVlldbcLxzZU9tltdFJ6zrKIf2s=;
        b=UfMaeheOt0iaYL+SmzTxyB0I7NVUxjCuwLDAPEGktrBwnjGOFmNePCg5GAYD+cfJcS
         Ai0ejZEu92j9vRe52Bu9qC7xPLZfL8tYHb1LH2mRNuQTy7gENPBwX7N+yRFCjb1tvB+B
         l6IVriDga5bp+Wdxf34GST25n/tuyEDWAQVjHw3ukoq3ypLKdhKYH2NCZq3ODRk9xX6q
         gj41SsQIH4kxt9HOsl+HnSKjtVpVPd73y90cul/OJUPRqYeNzAbdG+7pxEsh83AS9cqY
         mdlDSE1C+fDueMZC6h3CMeqQn8NgmNP3r7vfJs+z6/9gpBoPxprDQHbAEf35YyxAHJJQ
         fosQ==
X-Gm-Message-State: AOAM533zXMlbLK7dxJ18OdQqivThA08dzyWlVQGCkarjKSx/d/X2CD57
        63P50mU7i0iw8Fbov3oOlgZHM5UkPTDaLw==
X-Google-Smtp-Source: ABdhPJxM6uMRlCTDUyJlFWwtiRziRgVTGoapG7ulYCjuDMbPzqec6rRpJv6aAtKMlkJLYb3vQv1abA==
X-Received: by 2002:a05:6402:215:: with SMTP id t21mr23284452edv.363.1612879621437;
        Tue, 09 Feb 2021 06:07:01 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id ha21sm4724830ejb.97.2021.02.09.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:07:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 2/8] maintenance: add --schedule option and config
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
 <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
 <dae8c04bb5523c9b63c770862a1104a0ff4aa6c4.1602782524.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <dae8c04bb5523c9b63c770862a1104a0ff4aa6c4.1602782524.git.gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 15:06:59 +0100
Message-ID: <87blctcp30.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 15 2020, Derrick Stolee via GitGitGadget wrote:

> +--schedule::
> +	When combined with the `run` subcommand, run maintenance tasks
> +	only if certain time conditions are met, as specified by the
> +	`maintenance.<task>.schedule` config value for each `<task>`.
> +	This config value specifies a number of seconds since the last
> +	time that task ran, according to the `maintenance.<task>.lastRun`
> +	config value. The tasks that are tested are those provided by
> +	the `--task=<task>` option(s) or those with
> +	`maintenance.<task>.enabled` set to true.

I see from searching on list and from spying on your repo that patches
for this maintenance.<task>.lastRun feature exist, but there's no code
for it in git.git.

So we've got a 2.30.0 release with a mention of that, and it can't work,
because it's only in the doc due to b08ff1fee00 (maintenance: add
--schedule option and config, 2020-09-11).

