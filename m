Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AD3C5DF62
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 00:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiAZAOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiAZAOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 19:14:00 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95443C06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:13:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id k25so34360233ejp.5
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sVkBsxpuy/ywRGDRWriHPcGxvfBqG9GSpNucWh0zRfo=;
        b=XeEa7Gb5dPYFzYz+z909UDrhop/mQ+R00AhHrcrGDvqK1jHwJ3TMsLelavtSJbUVz6
         qIpTZJWj1w5GlMGAIOma50hEh9uTvuq6qUEVIEspjeMBrj2NHOEw00rh5NKc4is+RJzF
         ncaRBl4wbmdgmAL7QTEzwYY4UhGcc7F3eFb5iHqon6zd6yKmUBQVF0aLgEDrEx8Rcdw9
         qPpJ+9Yv012WE1TzB5z0EYnck8a0EWHYGK3foKpc/KgYUwDgCeNslIrsPgrXETbXZwre
         axMeeOx6I+QVgs9jYZVPmFL15iBFjr/SeLiW6SYi2h93dRJjWj+HmcsxXHOAa8qbyeGL
         qqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sVkBsxpuy/ywRGDRWriHPcGxvfBqG9GSpNucWh0zRfo=;
        b=MWwMrPouRRWI+e6aS32RAtmYEDDcy8pF4acS8lqbX8mj9g24tIoyLXXjyG2xBA1CvQ
         8Ihl0qEwSgnVdvS4we0gbvJoy027y8om6vPbictjEMl8OAVDyCM0lIdH65JSaCBhXuVx
         kLbKZ7pya6d1JHmbLDyE2ONSm6gxIW79RMKwXqw0FeMYdWhWrzaKeJ9oyY1RcwYHOSqE
         zxIUftpzlPYYiFEDEXvfmTrh2VX3J7LZE4VfAUrHgGF9Kd6Zt4uOQH7fff8W91gcvVa5
         GicAivTiL5MqDK0mRnk0AnbgtWEqioOR0wQs6HvjHLrmmWzJEY+afVgFioT8kTWeMxFS
         QlJg==
X-Gm-Message-State: AOAM5301EO24pwB9mUrB67r40nav7cUOQ9tTSjMMl+LPUiIEqNhj9KDm
        pjoRgQwncOGiaW/uHObZ1dCKmiNUopJjGQ==
X-Google-Smtp-Source: ABdhPJzTJ8svazN5aMjFxH3+AlWsB5IxuYN7KTi78jGC81lpUaWXOcCz4KY3s8OjVF13mS4K7Qb1gg==
X-Received: by 2002:a17:907:868b:: with SMTP id qa11mr9538055ejc.585.1643156038079;
        Tue, 25 Jan 2022 16:13:58 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qw3sm6792572ejc.128.2022.01.25.16.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 16:13:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCVwj-0034eW-5r;
        Wed, 26 Jan 2022 01:13:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 5/9] tests: refactor --write-junit-xml code
Date:   Wed, 26 Jan 2022 01:10:01 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <94dcbe1bc437dc9738cfc635e9085d743eb4ec98.1643050574.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <94dcbe1bc437dc9738cfc635e9085d743eb4ec98.1643050574.git.gitgitgadget@gmail.com>
Message-ID: <220126.86o83zfj5m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The code writing JUnit XML is interspersed directly with all the code in
> `t/test-lib.sh`, and it is therefore not only ill-separated, but
> introducing yet another output format would make the situation even
> worse.
>
> Let's introduce an abstraction layer by hiding the JUnit XML code behind
> four new functions that are supposed to be called before and after each
> test and test case.
>
> This is not just an academic exercise, refactoring for refactoring's
> sake. We _actually_ want to introduce such a new output format, to
> make it substantially easier to diagnose test failures in our GitHub
> workflow, therefore we do need this refactoring.

I'm a bit confused about the need to patch this JUnit code & to
generalize test-lib.sh to emit things in three machine-readable formats
(TAP, JUnit, and now this Markdown format).

In
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2112201834050.347@tvgsbejvaqbjf.bet/
you replied to my patch to remove this dead code with wanting to keep
it, because:
    
    The reason is that there are still some things that Azure Pipelines can do
    that GitHub workflows cannot, for example:
    
    - present the logs of failed tests in an intuitive manner,
    
    - re-run _only_ failed jobs.

Which is fair enough, but in this series we're further patching it, but
it's still not used anywhere in-tree at the end of it, or am I missing
something?

This series is seeking to address 1/2 of the points you mentioned, and
presumably the latter is a question of us juggling around our GitHub CI
job definitions.

Then in 6/9 you note:

    This seems not to faze Azure Pipelines' XML parser, but it still is
    incorrect, so let's fix it.

So this is running on Azure somehow, but not via the previously in-tree
azure-pipeline.yml removed in your 6081d3898fe (ci: retire the Azure
Pipelines definition, 2020-04-11)?
