Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4234C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 03:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945F660EFF
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 03:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhHCDUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 23:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhHCDUx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 23:20:53 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05579C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 20:20:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t18so13119326qta.8
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 20:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bj2VaHWuqaOPOcsl+GTtUdmKrXZM1uL1QWj52BArbk8=;
        b=i/MJJheXjdEd54FRfGtpAQIYqVTEpnikQRTFRXj8f6EhFmJ5EL3LWC7B2Sf9sCSRcM
         d8gtwHj/9KWiJYwUHc57aBJarP7x1nP1Djop1VxvtKXA2E1Ug5LNxkVM8tPy4vdgERzi
         Rw6YF+wlVZkwAtvr114PPSAvnBZYuKvbleMWh6PZqU8QE/tqId+C8IEXw2RVX/oiQeHT
         6S0EptWEaAT27YlgoxBB8Y1YinA8zFfMRYxcq5QYagT0lGaST/0VW35548GIuQ35ydnT
         13tJ0qLBZdtyXhqhwRfxrH/6kN5zrpZvFZ0LGhWNhwLdlpmCB5XIxgFdMobajbqcu8zq
         VtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bj2VaHWuqaOPOcsl+GTtUdmKrXZM1uL1QWj52BArbk8=;
        b=NZwGn4nrr6fS8iwrIUf9vv03CPdQy51C0UB/T6QXaPsByTfXMnpGm244oUxJBDVIdj
         QJB2h3PrmLdyqoDMRW07MZ67RvsXMutSBJuIOjYfch13ScjYSZxxJq7yqfuq4CBZvajE
         y+G3VvZBlQU8Hg9Byhf51+zgP/uLAOf1hfhvcHd9Ve/xD+zKIZpsiXTEgLIoqACDKN0G
         NWPW0vU8EIDAhPFsWyD1zxUuk7L54+BarZW7S/jzkEDedqvhMBOPgux+F+DIauopUwu/
         /6lQeTtIMUgyf2OdLWNeKX4Y8Ut4Umbf7JG4McwCDaYKkkGI4yoWUhciIPJdoTuZ0sqq
         Edyg==
X-Gm-Message-State: AOAM5337qvsSh6mnwi3zTVtha2+FYOaQI2FmuaRuFEdaE51Qs4jmPDko
        TYvJwe9Hq/ZM1tnGl8Fv2Kg=
X-Google-Smtp-Source: ABdhPJzNEsenXBN71VFKdBOQ7IW4t+nXMYnMwLXWZA9+qTU83nvJwM7JilwJLDirPdTfdHaUs90HGQ==
X-Received: by 2002:ac8:521a:: with SMTP id r26mr16439898qtn.361.1627960841260;
        Mon, 02 Aug 2021 20:20:41 -0700 (PDT)
Received: from [192.168.89.76] ([198.168.101.205])
        by smtp.gmail.com with ESMTPSA id o6sm7062519qkp.111.2021.08.02.20.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 20:20:40 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] clone: update submodule.recurse in config when
 using --recurse-submodule
To:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Mahi Kolla <mahikolla@google.com>
References: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
 <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
 <fea3d6d72b63c06138d8eeb61e45edb30abbd79d.1627946590.git.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <e1bec4f1-d68f-2342-f759-8d0dc0de5eb4@gmail.com>
Date:   Mon, 2 Aug 2021 23:20:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <fea3d6d72b63c06138d8eeb61e45edb30abbd79d.1627946590.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2021-08-02 à 19:23, Mahi Kolla via GitGitGadget a écrit :
> From: Mahi Kolla <mahikolla@google.com>
> 
> When running 'git clone --recurse-submodules', developers expect various other commands such as 'pull' and 'checkout' to also run recursively into submodules.

missing space after period here. Also, maybe I would say "some developers"
or "developers might expect", or something like that.

The submitted code updates the 'submodule.recurse' config value to true when 'git clone' is run with the '--recurse-submodules' option.

We usually use the imperative form for commit messages, like if giving an order to the code base
to improve itself. So you might word this simply as:

Set 'submodule.recurse' to true when 'git clone' is run with '--recurse-submodules'.

> 
> Signed-off-by: Mahi Kolla <mahikolla@google.com>
> ---
>   builtin/clone.c          | 1 +
>   t/t5606-clone-options.sh | 7 +++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 66fe66679c8..f41fd1afb66 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1130,6 +1130,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>   					   strbuf_detach(&sb, NULL));
>   		}
>   
> +                string_list_append(&option_config, "submodule.recurse=true");
>   		if (option_required_reference.nr &&
>   		    option_optional_reference.nr)
>   			die(_("clone --recursive is not compatible with "

I think that this change is a big enough behaviour change to warrant that
an "advice" message be shown to the user, informing them that 'submodule.recurse'
has been set to true, and maybe point users to 'gitsubmodules(7) to learn what this
configuration entails.

> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index 3a595c0f82c..3daef8c941f 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -16,6 +16,13 @@ test_expect_success 'setup' '
>   
>   '
>   
> +test_expect_success 'clone --recurse-submodules sets submodule.recurse=true' '
> +
> +        git clone --recurse-submodules parent clone-rec-submodule &&
> +        test_config_global submodule.recurse true

This should be 'test_cmp_config', which checks that a specific config variable has
the expected value. 'test_config' is used to set a config for the duration of the test,
which is not what you want to do here. I see you've changed it in a following
patch, but not to the right thing. As I wrote in my response to your cover letter,
this series should be as a single patch.

Thanks for working on this!

Philippe.
