Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A28C4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 19:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C8160F92
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 19:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhHHTAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 15:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhHHTAd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 15:00:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C982CC061760
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 12:00:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id z3so14044889plg.8
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NpqDU1hQYpnKT9G6E3hczjWGbx/KpG5j6SQXsagO7ZE=;
        b=YS+AahbXEcoWCRzTtB3mxq9W5axm9WdnaTLOWfpDv5tv19t36Z1gETcAtNxtRgB5iB
         Uc5iNTngp+qAP3f6PjH5IBwy6xzyAcUd6rh8MNvoqSykwUCtCSlDAjKldcvqrEpbhCYX
         4rns5mdwz8bqiizbjRaZN8XWX4eHwUgj9suFNs2BiTQxN3MEeZPNzFnx8bHELkKPWxFQ
         yQYRQif5yCYXpad9q9KrOKWOqvP1lNiLtoziGDD0rRgZaYHrONpITf5dHJLv19y/EB2M
         G8f51iU1YDBLUgGdqnG5QLnHQyf4UqJ91FoZkQpByPqgJFQe4aKn6dzp2XkNdrq3DjzY
         Al9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NpqDU1hQYpnKT9G6E3hczjWGbx/KpG5j6SQXsagO7ZE=;
        b=rpSUgK6TKWLMal8esy9fthIclBrMKnQ4h8RC8yLzQGYrCHJvuT+DEBe7U4AntHEDwU
         5425CpvVeHj4nWRSM6Nb7Nwu252MlJXbUkcUisWusfSPCCpoQmLW0h5qQ4m1kjQFhtPT
         lq18E4HNuwZwwy09DFbdS3ibHJ8WS1I4qAJi0mUCMFW9ry+9Euv543aCjpILEzAZaato
         rdF5PU6T8/fJj3lBwU0R6xHX2h5BNf4BivFs5Hxnm1i3mihCarq9e6eAv0Xmv6wSnmC2
         DPvzydlCbfrnqhLIgeIISr+0LEv0sJ6cOFNo7oo4Ofe0YbhyA2I3ypuoUrKUxwi9k9WU
         NkCA==
X-Gm-Message-State: AOAM530pt3/mb1/HR0MGGooG5qUn6AwnYLP1A2DrW7MBSjCkyD89goYf
        aRD5rxB3murW/yqTkAB61i8=
X-Google-Smtp-Source: ABdhPJzz939tvzHEh5vAu/fKYcYUjFYXgRCN9t7ooVvsFQ/iZzCsHKHPlsJ8izURmFd2fQE2rHJ7gw==
X-Received: by 2002:a17:90a:c7cc:: with SMTP id gf12mr3074157pjb.152.1628449212233;
        Sun, 08 Aug 2021 12:00:12 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.84.169])
        by smtp.gmail.com with ESMTPSA id k25sm17161081pfa.213.2021.08.08.12.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 12:00:11 -0700 (PDT)
Subject: Re: [GSoC] [PATCH v4 3/8] submodule--helper: remove repeated code in
 sync_submodule()
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210807071613.99610-4-raykar.ath@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <d37adee0-8636-548b-c581-16eaa417a05c@gmail.com>
Date:   Mon, 9 Aug 2021 00:30:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807071613.99610-4-raykar.ath@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/08/21 12:46 pm, Atharva Raykar wrote:
> This part of `sync_submodule()` is doing the same thing that
> `compute_submodule_clone_url()` is doing. Let's reuse that helper here.
> 

Nice to see more code redundancy being removed. Now that we're using
'compute_submodule_clone_url' in multiple places, I'm starting to
wonder if the name still suits the helper. Yeah, I just started yet
another naming discussion ;-) I guess this one wouldn't be tough though.
It feels to me like 'resolve_relative_url' is a good enough name that
doesn't mislead readers by having 'clone_url' in its name. In case anyone
else has better name suggestions, they are indeed very welcome to suggest
those :-)

Once there's agreement on a particular name, I think the helper function
could be renamed. Possibly in a new patch next to this one.

> Note that this change adds a small overhead where we allocate and free
> the 'remote' twice, but that is a small price to pay for the higher
> level of abstraction we get.
> 
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> ---
>   builtin/submodule--helper.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4b496bac6..9b676c12f8 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1373,20 +1373,10 @@ static void sync_submodule(const char *path, const char *prefix,
>   	if (sub && sub->url) {
>   		if (starts_with_dot_dot_slash(sub->url) ||
>   		    starts_with_dot_slash(sub->url)) {
> -			char *remote_url, *up_path;
> -			char *remote = get_default_remote();
> -			strbuf_addf(&sb, "remote.%s.url", remote);
> -
> -			if (git_config_get_string(sb.buf, &remote_url))
> -				remote_url = xgetcwd();
> -
> -			up_path = get_up_path(path);
> -			sub_origin_url = relative_url(remote_url, sub->url, up_path);
> -			super_config_url = relative_url(remote_url, sub->url, NULL);
> -
> -			free(remote);
> +			char *up_path = get_up_path(path);
> +			sub_origin_url = compute_submodule_clone_url(sub->url, up_path, 1);
> +			super_config_url = compute_submodule_clone_url(sub->url, NULL, 1);
>   			free(up_path);
> -			free(remote_url);
>   		} else {
>   			sub_origin_url = xstrdup(sub->url);
>   			super_config_url = xstrdup(sub->url);
> 


-- 
Sivaraam
