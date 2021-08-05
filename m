Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D076C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B3B6113C
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbhHEXqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 19:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhHEXqU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 19:46:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6DCC0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 16:46:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x90so10706601ede.8
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 16:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ry1qgwop2jI9FE1wQjdZoRq17Bc7ylF8+LaZ6aUIS7Q=;
        b=jETDMDfBxN9u9qZpRGQ0ySW30nnokdmL6f21GBofIHOFpvG8FGZ1a+OBK/Q7y8fSkj
         OMPzrN4pCHIHRa/ps6kRqC6w5K7OKBf1AVmdyAxV1XZK/fkfGl5UJzIi+oU5nSdIIzkK
         3gySupoq9eNgzcHCZIXV8vWqHhD3Y9MVWdeyOIk74RkwL8amSRDiEt48rOce8ziYKThd
         +Bpok2k3bb4TbFlIBvyw3pa+CieiLYG/q+4raoQgUjoM9Yp3VXt4MXWSW/Tqnn0VePks
         pi9oPQj838VRVSe63BQ5pi1AgNIfa+XgF7YFhxM51Qd3Egdk4WLHr5B0qe+WU5s48zks
         UtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ry1qgwop2jI9FE1wQjdZoRq17Bc7ylF8+LaZ6aUIS7Q=;
        b=BgigZ6Hk+s1VoIb1thJHjWu8e68Ge97FazOdWxONkGQYkBAGm9NaJYesosbBiWSX2w
         7qxwpx5haVegIP6yzktwkHWc//iJ4q+7ruzYEjWNQtD4bCPzIB/rUNLSXPKcRSCh4+zr
         1TQBa7gK7oGpgtlbW7hP/4z1elbmjUBciTpFMB2JQQyatvk7e9swY3j5tLBH06a2L7c6
         NFX3pFXvVx5oWPtyaFYcCVQDIYEuK/fr7rRhubJA2MZ+q9pvoY8khlgy9oqRyiOwqquY
         JcVEvk+r/pZApT9AfYyvhiUfKFMSOVYKec5GTHMocO/KviEaX/umuSLMzxAXhXNeobUo
         eU/Q==
X-Gm-Message-State: AOAM532MG83c4/eLZnPY/dIKnbxAr9ChaLxMe6bi0zo9YyrG2dPzTQZg
        jKj8GGvLGvu77WQZBshyKBLNBizv2hWDew==
X-Google-Smtp-Source: ABdhPJzR3Dljx+EjCI1vCdnYp5ZmmFiJYdcnRpJhTnkEtWQNierKYTIMK1bJh+bHyZU7jryxWIbRvw==
X-Received: by 2002:a05:6402:4cf:: with SMTP id n15mr2183062edw.269.1628207162854;
        Thu, 05 Aug 2021 16:46:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c12sm1298233edu.76.2021.08.05.16.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 16:46:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: fix for COLUMNS and bash 5
Date:   Fri, 06 Aug 2021 01:35:42 +0200
References: <20210805194825.1796765-1-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210805194825.1796765-1-felipe.contreras@gmail.com>
Message-ID: <87k0kzzc91.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 05 2021, Felipe Contreras wrote:

> Since c49a177bec (test-lib.sh: set COLUMNS=80 for --verbose
> repeatability, 2021-06-29) multiple tests have been failing when using
> bash 5 because checkwinsize is enabled by default, therefore COLUMNS is
> reset using TIOCGWINSZ even for non-interactive shells.
>
> It's debatable whether or not bash should even be doing that, but for
> now we can avoid this undesirable behavior by disabling this option.
>
> Reported-by: Fabian Stelzer <fabian.stelzer@campoint.net>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

I've got an alternative way of solving the same immeditate issue in[1],
there's discussion on that approach in the latest What's Cooking[2]. I
belive this approach would make at least SZEDER happier than with my
series :)

As noted in that discussion I'd prefer going for mine, but would also be
fine with this if it's what Junio decides to pick up. We should have one
or the other before 2.33 is out.

My preference for mine is in no small part that I'd like to not be
responsible for into-the-past test suite breakage the next time a
popular shell decides to be clever about COLUMNS.

But this way we'll solve the immediate problem with bash, and I can say
I told you so if that submarine breakage occurs with this approach :)

1. https://lore.kernel.org/git/cover-v3-0.3-00000000000-20210804T230335Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v3-0.3-00000000000-20210804T230335Z-avarab@gmail.com/

> ---
>  t/test-lib.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index db61081d6b..a2b7dfecee 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -419,6 +419,12 @@ COLUMNS=80
>  export LANG LC_ALL PAGER TZ COLUMNS
>  EDITOR=:
>  
> +# Since bash 5.0, checkwinsize is enabled by default which does update the
> +# COLUMNS variable every time a command completes, even for non-interactive
> +# shells.

I don't think this needs updating, but FWIW I think that around bash 4.X
(I think 4.1, but that's from memory) is where it started doing this for
non-interactive shells, so we could have had breakage going back that
far.

But we're seeing this in practice now because with 5.0 this was turned
on by default.

I.e. I think if you turn on checkwinsize it'll also break with the tests
on bash 4.1 (or whatever it was), but not on 3.x.

None of that's something I've tested, just from memory of skimming the
bash commit logs for changes related to checkwinsize a some days ago
when I came up with my fix for this.
