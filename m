Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6183DC433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 18:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiECSzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 14:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiECSzT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 14:55:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF563B01E
        for <git@vger.kernel.org>; Tue,  3 May 2022 11:51:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w4so24524655wrg.12
        for <git@vger.kernel.org>; Tue, 03 May 2022 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J4++OQTKGel1pkbFWocxrl9pRb4h+MMzYLq9DZ/sgRs=;
        b=W9we7DcOJmRx5qJzLIQVRjHDyVW20Jx8ajx2rZKdYzwvaj81H5qBhc9VjotTpAeM3f
         CqHqEo+EOZR3pS56nPZHo7CpN977so9ZBzJcLnU4IKqZzn8eIPWYQ4Ac4aL5dGXEPN1/
         /n7xQUjkKlCY7iPe13O92Pp7CkYFZMsifHhNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J4++OQTKGel1pkbFWocxrl9pRb4h+MMzYLq9DZ/sgRs=;
        b=Ulp4CVtxzaksGdMCfZOYqVMwYRMtOe3lJWzGF/MuBVklXzWRp5ZZYzt8h4liYAGkzT
         70OcB8Sj2Kv2SZdfjsVLC3yBzfBGkI5Rzf3JEcp2Zsbmc1Eaml0xv3YPVUGhGKoLVPG5
         CzYYX5n6VONjczreqHHxJ9Wx/Suau/Xb1EAUrXdNeJCvvZCqhS48jEQXNeSRYy9BjosQ
         CzyKv5jMNG6BJ5Js4j0ZoglGP7cEmvtmm4ALdSFkgNxJZDwin/XFxm/8SN8zt/FB10Od
         mPQN42UF1jFP4fmQkoxwWWP+lpBvJAl5xdSPkJx4kSzH6mVL7lrnxFPlTQ5A03gf8Tky
         g1uA==
X-Gm-Message-State: AOAM532HbrCK0/YBlBp173bHu+TceEPGNId+gkh+K9KoDWoHcpmrxZzc
        57Vt4xkebCPt0hx1yXAV8vfz9w==
X-Google-Smtp-Source: ABdhPJznPWu0A96LbZIfF35olWQhvhN1Xn73wOYV0ectUznci3gvrjnWO/ldCFwW0zgvKhTizV8x2w==
X-Received: by 2002:a05:6000:168c:b0:20c:6072:f82a with SMTP id y12-20020a056000168c00b0020c6072f82amr8969836wrd.410.1651603904654;
        Tue, 03 May 2022 11:51:44 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:5fae])
        by smtp.gmail.com with ESMTPSA id g4-20020adfbc84000000b0020c5253d8f7sm9874119wrh.67.2022.05.03.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:51:43 -0700 (PDT)
Date:   Tue, 3 May 2022 19:51:42 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] bisect--helper: warn if we are assuming an unlikely
 pathspec
Message-ID: <YnF5vpcBCJftFdH+@chrisdown.name>
References: <Ym59GmfWpCSV9Bqr@chrisdown.name>
 <48cd2ce4-feac-b028-daad-2df6aa71e363@gmail.com>
 <xmqqv8uo1mk6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqv8uo1mk6.fsf@gitster.g>
User-Agent: Mutt/2.2.3 (d9199322) (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:
>A model dialogue may go like this.
>
>    $ git bisect start -- bin/
>    info: bisect waiting for good and bad commits.
>    $ git bisect good master
>    info: bisect waiting for a bad commit, one good commit known.
>    $ git bisect good maint
>    info: bisect waiting for a bad commit, two good commits known.
>    $ git bisect bad next
>    Bisecting: ...
>
>Then the exchange for the lazy short-hand form of "bisect start"
>would fall out quite naturally.
>
>    $ git bisect start d93ff48803f0 -- v6.3
>    info: bisect waiting for a good commit, one bad commit known.
>
>For a bonus point, we may want to also say something on these
>"info:" lines that we were given a pathspec.
>
>It would also be a good idea to add a new subcommand "git bisect status"
>to recompute the state (i.e. what it is waiting for and what it
>already knows) when the user forgets, which can happen quite often.

Sounds good.

>With such a bonus feature, the exchange might go like this:
>
>    $ git bisect start seen
>    info: bisect waiting for a good commit, a bad commit known.
>    $ git reset --hard maint ;# choose an older point, hoping it is good.
>    $ make test
>    ... pages of output scrolls the "info:" out of window ...
>    $ git bisect status
>    info: bisect waiting for a good commit, a bad commit known.
>    $ git bisect bad maint
>    info: bisect waiting for a good commit, a bad commit known.
>    $ git reset --hard v1.0 ;# an even older point, hoping it is good.
>    $ make test
>    ... again pages of output ...
>    $ git bisect good v1.0
>    Bisecting ...
>
>Hmm?

I'll wait a few days to see if anyone else has any other feedback, and then 
I'll send a patch to that effect.

Thanks!
