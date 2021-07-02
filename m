Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFB1C07E96
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DAC61167
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhGBVFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 17:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhGBVFC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 17:05:02 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E56AC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 14:02:29 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso2801222ooc.5
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 14:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Y7ZSWqX2AivvZRIzt8DPs0ePCwNtKSu4MiGpxRYhrtU=;
        b=MHyfZCrv5Pg99GgXiiy1W5IXY8dAJ9CYPMQ1s44ZD6NS4XdkKK88oMPWmkMDBCxGNR
         OodUxbFLl2k3o4HyOxyTuCY3XiVaIJFj+LXnhZC4Rg1wA7AZJ26sD2b5+Be+3Rtw35bn
         tSQCgJA8jBO34U8eX+ZEHr9KIZY1ClCQmLYEVeite4QGuN8Uk1ZdR+AA73gEEpprCru6
         ZVHIroMG9n91CahEMB7JppCB2JBaZa1uSkIlIjMOGHwCA7gpA6DEn3lXzGSx895DX6Kq
         +I7jSiDbRUwvZnhFpvGUN2pwwi7alUNllyUu7NQy935+NcbK4aVVxmXb+sfBTC8fA1Lu
         CbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Y7ZSWqX2AivvZRIzt8DPs0ePCwNtKSu4MiGpxRYhrtU=;
        b=KMQRxQ3uvUfqATBch9YTOxmOZbuu4+Wq90gGiQhjHxptN87HtzgQ38Ke1O+XGu8waS
         f0MqjhL2hGF+nLANsPKr1PG019Goc+f+dxya7iMXLmctEgejdR+XFY+YiPsoM8LGFxtG
         sVauH+j6MN/DDJtAC+NsA6MlKR5XRAVPmoDoJ4IyRxcsHJVUfRsauXeNYRWvrwSk4v7x
         0F+uwamnegy43j2NoAKq0aSv3lvHjXtE74ILdKLY/BKDGH3o558EitCeWby75U/160KT
         5DmC1LLQRhaMi4ikalQySomsOnS3f7FelgyRKw525AioQmhC4AO5ORnIgrVFD9++w52Z
         jGqw==
X-Gm-Message-State: AOAM530WLkzx1cbEvnHjQHZX4AOVH3IX8bausvk7Ihh+rmykVt9AKJae
        pCxw4w5z1rR+jhzRaT5TJxI=
X-Google-Smtp-Source: ABdhPJwjXbB6zURDuJSAXga3HpvPGZx4ixizeQQTM+25RyE7wWKpRyue63tmgyj/6RO/bO9IarWiUQ==
X-Received: by 2002:a4a:6049:: with SMTP id t9mr1285747oof.14.1625259748768;
        Fri, 02 Jul 2021 14:02:28 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id d7sm785601otb.66.2021.07.02.14.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:02:28 -0700 (PDT)
Date:   Fri, 02 Jul 2021 16:02:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'martin' <test2@mfriebe.de>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        'Andreas Schwab' <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>
Message-ID: <60df7ee3128d6_28bb2086c@natae.notmuch>
In-Reply-To: <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home>
 <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
 <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
Subject: RE: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:

> In my opinion, default aliases are not a good path. If a command is
> intended to be part of the git command set, then it should be a
> builtin not an alias.

Commands cannot be overriden, aliases can.

All SCM projects have aliases, except git. Why do you think that is?

> Users have their own alias setups and implied conflicts are just going
> to be confusing and end up in help, examples, presentations, and so
> forth.

There's no conflict. Either you use the alias or you don't. Just like
today.

> If you want a default alias set, publish it as part of an extension
> set, like the bash-completion, so that the user has to take action to
> install them in their environment. Do not do this in the base git
> product by default.

The whole point is to help users so they don't have to do extra
configurations.

Today git is pretty much unbearable without a configuration. Default
aliases would help quell some of that pain.

> If I was a committer on this project, I would have to be much more
> convinced that there is long-term value in this series than appears on
> the surface.

 1. It doesn't affect anyone negatively
 2. You don't have to use them if you don't want to
 3. They don't affect your aliases, even if they have the same name
 4. Everyone has aliases
 5. Every SCM in history has had aliases

What more would you need?

> I am sorry if I am coming across too strongly on this subject, but I
> do think we are overloading alias capability and intruding on a domain
> that should be reserved for our users, not ourselves.

But why? We provide plenty of defaults so that users don't have to
configure git in order for the program to be useful. And we will
continue to add more defaults.

-- 
Felipe Contreras
