Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3D2C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C362054F
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfURDro/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgDEPS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 11:18:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38527 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgDEPS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 11:18:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id o17so76285wrv.5
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M673bH2+4opp6giqAhCVT5vYrQxi8tLc0PN2CCldJDY=;
        b=HfURDro/mp8ymA7nKNbGE1O37T4FBaZPNLw2wpY9cNowFjOsgKmn75ayNY2GrFTm50
         aJhlN2uajA9+P0ASLURbwPXpTGrfPV8oSSFQAiQF7rDEn5Ch/M+nLSuNMSX7dGW4N/mI
         TT2gWG5qDYSw/9+dx54xeAK41jYfYrTeReepoCitaR/vV1yTkCNj5VEymjQ+UfsrXTnd
         6QbmDNLpDYqbOBSxGkVE2FoAHPeqtZUmVEfhl99mJ+tKrx3QbfagQ9G5J/U5NA3BkZKJ
         l8v5UvfmgkLvFQK6sXI5kNKNpq5aGX5aJ950O1zMYrkxRWe0BQ5oTQGCatezkU3uq7qh
         g8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=M673bH2+4opp6giqAhCVT5vYrQxi8tLc0PN2CCldJDY=;
        b=Y9qIxAdItQSOtAHxiOm2Y5cI+p6KrtIFadfIFtcLX2QUF1R4UYDrQdq4ZVtaIQFblz
         t6puPzOwC8WnKfqGy5EKUMAxTR6tC9F5K3GpJVHKbMUqezLYALU2cA12H6ueifMKltJQ
         BljGVIXx0IHZruEWBOMjiPgrDJBNsbWiGt/+6d65rnxNtotE0PLFOJeMD6QhT6dKDDg1
         NmCQT37XXakAy9s/09fGC5ibAcPQ7bWNFfzLcedSOKko6obRUwJ4aQDOoRIOWRgFVXBm
         3mF6OP5t9xTW5lb9e4slstC5zn7e7AcU++EZhExr/+upfeSkODOwYreDA3F6/VuB5M0A
         zdXQ==
X-Gm-Message-State: AGi0PuZsGfZDeoGGJZWH4mCF3v4KBpli0Lgc6tCpA9fFfSqd1xY+yZL/
        5Bnr50scmfSFt2dEGxndY5U=
X-Google-Smtp-Source: APiQypLc+VFiAxAEs1K2PGdxVs+K1R34vXxnuu6ThfMGtZ6XZurDpYTGPJRYDCM0c91s/2JxmZKOcQ==
X-Received: by 2002:adf:bc12:: with SMTP id s18mr20398949wrg.220.1586099936979;
        Sun, 05 Apr 2020 08:18:56 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id j31sm13577227wre.36.2020.04.05.08.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 08:18:54 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 09/15] job-runner: load repos from config by default
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <9104ae46371a08967805f6ce27586ccade37972a.1585946894.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <29e32e80-a546-6e43-8d03-bafca03681ec@gmail.com>
Date:   Sun, 5 Apr 2020 16:18:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9104ae46371a08967805f6ce27586ccade37972a.1585946894.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 03/04/2020 21:48, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The 'git job-runner' command was introduced with a '--repo=<path>'
> option so a user could start a process with an explicit list of
> repos. However, it is more likely that we will want 'git
> job-runner' to start without any arguments and discover the set of
> repos from another source.
> 
> A natural source is the Git config. The 'git job-runner' does not
> need to run in a Git repository, but the config could be located in
> the global or system config.
> 
> Create the job.repo config setting as a multi-valued config option.
> 
> Read all values for job.repo whenever triggering an iteration of
> the job loop. This allows a user to add or remove repos dynamically
> without restarting the job-runner.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   Documentation/config/job.txt |  7 +++++++
>   builtin/job-runner.c         | 20 ++++++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/config/job.txt b/Documentation/config/job.txt
> index efdb76afad3..2dfed3935fa 100644
> --- a/Documentation/config/job.txt
> +++ b/Documentation/config/job.txt
> @@ -4,3 +4,10 @@ job.pack-files.batchSize::
>   	part of `git run-job pack-files`. If not specified, then a
>   	dynamic size calculation is run. See linkgit:git-run-job[1]
>   	for more details.
> +
> +job.repo::
> +	Store an absolute path to a repository that wants background
> +	jobs run by `git job-runner`. This is a multi-valued config
> +	option, but it must be stored in a config file seen by the
> +	background runner. This may be the global or system config
> +	depending on how `git job-runner` is launched on your system.
> diff --git a/builtin/job-runner.c b/builtin/job-runner.c
> index 135288bcaae..bed401f94bf 100644
> --- a/builtin/job-runner.c
> +++ b/builtin/job-runner.c
> @@ -20,6 +20,9 @@ static int arg_repos_append(const struct option *opt,
>   
>   static int load_active_repos(struct string_list *repos)
>   {
> +	struct string_list_item *item;
> +	const struct string_list *config_repos;
> +
>   	if (arg_repos.nr) {
>   		struct string_list_item *item;
>   		for (item = arg_repos.items;
> @@ -29,6 +32,23 @@ static int load_active_repos(struct string_list *repos)
>   		return 0;
>   	}
>   
> +	config_repos = git_config_get_value_multi("job.repo");

Does this really re-read the config files as the commit message suggests 
or just return the cached values? Perhaps the runner could exec itself 
with a --run-jobs option to actually run the jobs so that it sees any 
updated config values.

Best Wishes

Phillip

> +
> +	for (item = config_repos->items;
> +	     item && item < config_repos->items + config_repos->nr;
> +	     item++) {
> +		DIR *dir = opendir(item->string);
> +
> +		if (!dir)
> +			continue;
> +
> +		closedir(dir);
> +		string_list_append(repos, item->string);
> +	}
> +
> +	string_list_sort(repos);
> +	string_list_remove_duplicates(repos, 0);
> +
>   	return 0;
>   }
>   
> 
