Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D6FC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531B360C3D
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhBQVWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhBQVWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:22:04 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F48BC061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:21:24 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x136so9278513pfc.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ZZsbUFtX0LPCImMrVYZCtG1TAnMCG1zDpjY+gfQc7I=;
        b=Kk+FNnO67wAz2jzPULa0Jz4bbInJz0DeL9JtqBWYT2umyR3rid0T5pmuvkg2pdYrKi
         eqpGBMXK90DvPblxJYSJ++6XfJjf40YjwNMYWWBJfrqP2kGb56AhDLdjJPx3DTShZFGl
         Sfr+kRIxIA4paolbRTkOil8BjuNxf8T7Bmp2oKT9N/6PHm/noRwC/JmtR9qpa1F2QylO
         NUPYB/UX1abRvSDGgdJ+LMSNT5XymyNO6C+YExNfxX+HuZrxYUog0zltQfrU1PKDNlQf
         6kCm1ohKSBnngiulX0ev+Zlre4kENLwPao++g+Z4jw5XrZ/115ob99OB0ronoX3ml3lb
         HqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3ZZsbUFtX0LPCImMrVYZCtG1TAnMCG1zDpjY+gfQc7I=;
        b=iKOYkBSbqxaUfa588I1bgY+EStc1mWXnnCu3Y4LVZcnCLU/gjb8v8KEBVZPcoLtc9J
         9Io5kiuNVwqjWjtP0BvlZ/luczAGhFy/UWBzIhzfpTldgiNw8uvvYapPMFMOXynsNf3Q
         Buh/Qu6lsZHF9SH99R2yV3I1HSlTVVxkZTLxS9NYoL5eZEqOVzjDU/r/mhevQtp/qCIW
         v0Obza+auzeeaTjEJovgUH5j3O7Bqg6Gmi8aJW1cUXlznZGdIoKGRqxW5gmov5CRIiQv
         FiMLT+ZzweJ53hijwTrDqtHILGwQZstUGNfAO4s2uQdPwIkd14G9YeK9NXDM1HEp4KKq
         K43Q==
X-Gm-Message-State: AOAM532Kmi28zBDsdfS2APMoyJYIP2mpnB8/Dhn5Ej44miTJf+L7Vtdg
        lOttpt3O/npVsLx4iY/WLpYAbA==
X-Google-Smtp-Source: ABdhPJxn75CuFZVuSwvFefA9Nq8KxXhPyYPTiAMuqbvKHxY0K7MaasowzbYVkcCPIn4Z1A0W20wIIA==
X-Received: by 2002:a65:6688:: with SMTP id b8mr1175651pgw.158.1613596883868;
        Wed, 17 Feb 2021 13:21:23 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:61a2:bc0a:8da5:5122])
        by smtp.gmail.com with ESMTPSA id w188sm3278002pfw.177.2021.02.17.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:21:23 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:21:17 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 00/17] propose config-based hooks (part I)
Message-ID: <YC2IzVxLgvC7N8qd@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201205014607.1464119-1-emilyshaffer@google.com>
 <20201222000220.1491091-1-emilyshaffer@google.com>
 <YCwhA6VIs16uMnJG@google.com>
 <xmqqy2fnocjc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2fnocjc.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.02.16 14:47, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> >> Emily Shaffer (17):
> >>   doc: propose hooks managed by the config
> >>   hook: scaffolding for git-hook subcommand
> >>   hook: add list command
> >>   hook: include hookdir hook in list
> >>   hook: respect hook.runHookDir
> >>   hook: implement hookcmd.<name>.skip
> >>   parse-options: parse into strvec
> >>   hook: add 'run' subcommand
> >>   hook: replace find_hook() with hook_exists()
> >>   hook: support passing stdin to hooks
> >>   run-command: allow stdin for run_processes_parallel
> >>   hook: allow parallel hook execution
> >>   hook: allow specifying working directory for hooks
> >>   run-command: add stdin callback for parallelization
> >>   hook: provide stdin by string_list or callback
> >>   run-command: allow capturing of collated output
> >>   hooks: allow callers to capture output
> >> 
> > Sorry for the delayed reply. I am happy with this series as-is. Thanks
> > for all your work on it!
> >
> > Reviewed-by: Josh Steadmon <steadmon@google.com>
> 
> The topic branch has a lot more commits than these 17; I am
> wondering if the reviewed-by applies only to the bottom 17, or as
> the whole?  I recall that the upper half was expecting at least some
> documentation updates.
> 
> Thanks.

Just to these 17, sorry for being unclear.
