Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D5C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA1261410
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhGAXSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 19:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGAXSf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 19:18:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0732EC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 16:16:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bu12so13244190ejb.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 16:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZWpzFaSuh1g0oAW/osIjJ3ja0U7GaifUtHTpdjc1AwE=;
        b=IWUNGzbkZsxgl97tE3Y30QxDnHqoZIbJi+GurYsuiE57JTd7YRJXguV3Ktd3+uBPHS
         RAqy9haqqPhjGmPk712HpNtuVbCSYvIeOWObo/vDcXkkaX7JnAJkc6Xf34GiYPRbjtdu
         OOGBQI74kDXLhMzKEHRRivRVbU4LfBZawfz7hbhHb0tAe1pb8VU/C9lnFhkS57gQUlgV
         7+g9L5PwQ8hFO78XEYf+CUZNUVqoHQEIpJs8HHKXVZHXO6o1Y3uRZxSC6ydczUPSmGOg
         WfJWaoPB5X1SFCqrEcRpIaIuZrk31DdBXlzahrsi3aQXOJ2ONsVgI5DEged6xHdG+RIg
         O0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZWpzFaSuh1g0oAW/osIjJ3ja0U7GaifUtHTpdjc1AwE=;
        b=gncepYrX+92IlZrkaeNE8QRgfq8D1b/ZIqm2VpFn4dbW1II1BaCYSCL/lyY+IHAg30
         L13JmliolrUEJua3oCzrypP9UPi0vzJxZ7bWneoI7VmK8eYsJmtIOa/ULieWNW5/GRYY
         7lkc5EWQPDJcV65hrBd7tphFk1xb0KzWGno0tluEV8KWYuiQAsaBs7pfq74FbMBYHkDH
         2Uhiwj/WJmjgXy7vSS5zxF2OL/jBCfQmIodVljV/4jotLgq23/H+YVZeVq0Yee6o8MCM
         EY1Ie83d0DgTvtIzKBfkH5m6lXGh1FoJo8xM+oWcDMZOPzi2BL7K5+2bYmX4+5jl01jT
         LR4g==
X-Gm-Message-State: AOAM533xFAccJzPLaOY5W05zMCMtr+o05S7S33punloUOUcIAheGmxZ4
        /A5u+OJphrfmjiLorsqlNRLU3T1nubIsIg==
X-Google-Smtp-Source: ABdhPJySQkYYbTUxUu/pN/ajoVhPdDb7hKRhVeCWu3kS7NK4P5jkqtDIhHeo94grHYB37mQNwWwxOA==
X-Received: by 2002:a17:906:58cd:: with SMTP id e13mr324638ejs.453.1625181362433;
        Thu, 01 Jul 2021 16:16:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o21sm521245eds.10.2021.07.01.16.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:16:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 27/34] t7527: create test for fsmonitor--daemon
Date:   Fri, 02 Jul 2021 01:15:13 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <99279c0ebd2b36fe276301f018ca4e24e4cdff36.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <99279c0ebd2b36fe276301f018ca4e24e4cdff36.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <87bl7lbp72.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> +	grep \"event\":\"start\".*\"fsmonitor--daemon\" .git/trace_implicit_1
> +'
> +
> +test_expect_success 'status implicitly starts daemon' '
> +	test_when_finished redundant_stop_daemon &&
> +
> +	test_must_fail git fsmonitor--daemon status &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_2" \
> +		git status >actual &&
> +
> +	git fsmonitor--daemon status &&
> +	test_might_fail git fsmonitor--daemon stop &&
> +
> +	grep \"event\":\"start\".*\"fsmonitor--daemon\" .git/trace_implicit_2
> +'

Seems like this and test_region could eventually be factored into some
common function that would be more flexible about grabbing trace2 data.
