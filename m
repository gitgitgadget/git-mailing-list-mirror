Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D68C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826ED610FC
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhDHWTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWTb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:19:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134BFC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 15:19:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mh7so5534964ejb.12
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=mPXdBCV0X7a63rEP1Y9yAKtHITHErxPf38n80cfwXCs=;
        b=GB+IWaWAJsA1lH2hX6fPUxoaqyAYzS3CFwiG4+0ieclECokBRGTS8kcdHFFmGus2lt
         d/WO8iZwUpA97WTqxT81Hywy6hKhbM37ArI6ic2/3k2pel0ppbjm1fpagSxw/N5Dtjha
         /FG6lrMn8MrbQQuKlc9qLAkEwPdvbRwfSbhwEkDBRyjX9VKS/op95oA1EA1aG5d0Df7Y
         PNk/KbYX0mKXI4hmMliRRFgYKxRI8/wIa0u3JcPupN/M6YWPnfRlqgJKQWBMiiqiRhSR
         1AU1sQw+3VHFhguBwusmKZVDQqV3u9/HE66mlfrfbBjjlbCCgu7r2zNavJ2hRyxs3dOG
         +u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=mPXdBCV0X7a63rEP1Y9yAKtHITHErxPf38n80cfwXCs=;
        b=JeN6mdEWK45/b3+LWteveJXr5l/TmUamK4i68ZB75yoCsnDeiCWGEuj41TNzrvjxTN
         qbjzo+TOlxK4MSep5FRWLYtz++cvN3RpOInyFX+snzafkV8YdZ0Luo1HmQrh+wTkdUfN
         ALcYHuLqnaUHs/niu2iaCxndEL3nReSShX6vxZpOaFr1VREnH3q7F7bmt2Oj4pAFVzPj
         uS2QnAaoJOjI1XOeKcIpW4aGsqPot1CcGRFHZ4mXKBluLbY/RNOsFlxU5FzVwP6UlnGc
         ElsBkJ3AAAGxyzRtkKjhoAS2aIvtQqcCKMX3MhQCTZqX86/jnj1Lu1z5WDNXeBnTCp6r
         Vzfg==
X-Gm-Message-State: AOAM533D3hotnyMAEDqjwmVS7NTbXql0EEVAiBrTttxsznqBRBmG0f67
        cIbens3NttUXVHIbLxFpzW4lqg6TFIj+xw==
X-Google-Smtp-Source: ABdhPJyvbGclEf30s0hJUi9tZ9bB12NBJ1VtLClLynTf2beGnNcwbsgFHEc8Jyw13c6drmyP5kxo+A==
X-Received: by 2002:a17:906:2e14:: with SMTP id n20mr13026670eji.16.1617920357766;
        Thu, 08 Apr 2021 15:19:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i2sm338692edy.72.2021.04.08.15.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 15:19:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v13 4/5] bugreport: add uname info
References: <20200416211807.60811-1-emilyshaffer@google.com>
 <20200416211807.60811-5-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20200416211807.60811-5-emilyshaffer@google.com>
Date:   Fri, 09 Apr 2021 00:19:16 +0200
Message-ID: <87mtu8ifmj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 16 2020, Emily Shaffer wrote:

> The contents of uname() can give us some insight into what sort of
> system the user is running on, and help us replicate their setup if need
> be. The domainname field is not guaranteed to be available, so don't
> collect it.

Even with _GNU_SOURCE would anyone care about the domainname (the NIS/YP
name, not DNS) these days, as opposed to the portable POSIX "nodename"
field you're not including?

In any case, I'd think it's a good idea to omit both. People tend not to
want to want to include their FQDN (e.g. their employer), and I can't
think of a reason we'd care about it for debugging git.

> [...]
> +		strbuf_addf(sys_info, "%s %s %s %s\n",
> +			    uname_info.sysname,
> +			    uname_info.release,
> +			    uname_info.version,
> +			    uname_info.machine);

Since this is completely free-form I'd think:

    "sysname: %s\nrelease: %s\nversion: %s\nmachine: %s\nnodename: %s\ndomainname: %s\n",

Or something like that would be better (after pruning out the fields we
don't care about).
