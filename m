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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FA1C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CE320659
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieh5cTfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgDEPl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 11:41:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42972 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgDEPl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 11:41:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so14361423wrx.9
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qzmz/JYKMzvNaTMaNtgoQqojDUFk82nMl0T+bcVHiSk=;
        b=ieh5cTfZEuCTuqDjoNS/t8UEqLP7bwPcvCO/eMiCdyzc5moLq7YT0eqKpsrY/EjnQ7
         PY1xLbuzyWLuc5LJOymW3Tcu0aL6s1V7xgHwJRGLvJfGpUoZUp3gxExGO7DcdL4Nohl8
         1go3dwHZ77Ul+UZH1QyJ9jiyG7JPRn8+gkR/DTAZfYo0uDJOrItjloHLIjLW+vvzrJ7P
         CI0f51DpBzPW7RYB6J4tR6n4yc2wbeSznjiRGtPY9aKpWMkxWM/8Eb1f9Iik4OmjN+3n
         jd3xq2w15KPL41hhX+7sa3cj2hSFN7Weq8C297MnkhydvXo8YZsAfGSuJYttdpXgXTS/
         PfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Qzmz/JYKMzvNaTMaNtgoQqojDUFk82nMl0T+bcVHiSk=;
        b=rhVqkwno/8C7C571ENthp0NQiGgqmRavewj89kqhLniGMH4zDFx70Kpw1RqyoYdSG3
         4v1x6UUMEh2XsIQ/PHZi3wy15R6R1SFGUQaUwsAuIS39hSz2M1UkI+MR05gTeIzxT2jK
         0dDFVzQTJ8v4UPIQ16nYeZcnpkoM3wSXy6y1Df383u2lVYZHev/MlAAdVlwjiIKdqJ6t
         FWPukxeUA5iQ29tCZgTr5mAzxc+8Fo2/sUWxmDp9RSPeoWAyljBNs1InAlgTElL5/XXG
         yElhecQCdRLedc00Ryr+M3Bf4PZcN3dbAWdxYlIdZXcYbxubEDU4d1Wll+Sscisu9Mgr
         g5Eg==
X-Gm-Message-State: AGi0Puax8RwMBY5+mw0h3iF8/tF0hcAtzRwH36L3fa0giwvTs+xTAzBO
        /Z4YTjVuqdjIRwdDL4Ca0vo=
X-Google-Smtp-Source: APiQypKFksyhiteiYGVh8cKhhwHXzcBBZrN3MyCUq2nS01E6/SM9tqKtaK6peh8YcWd6JwnM9wtjBg==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr19820535wro.96.1586101286572;
        Sun, 05 Apr 2020 08:41:26 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id y20sm11496714wmi.31.2020.04.05.08.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 08:41:26 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 09/15] job-runner: load repos from config by default
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <9104ae46371a08967805f6ce27586ccade37972a.1585946894.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <45ce32bc-8b47-76d6-47ed-03028df55e53@gmail.com>
Date:   Sun, 5 Apr 2020 16:41:25 +0100
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

One thought that occurred to me was that it might be convenient to put 
'git job-runner $HOME &' in my .bashrc to have it start on login and 
find all the repositories under $HOME without me having to list each one 
(and remember to update the list each time a clone a new repository). 
There are a couple of issues with this
  1 - We only want to run the jobs once per repo, not for each worktree. 
That should be easy enough to implement by checking if we're in the main 
worktree.
  2 - If I start several shells I only want one instance of 'git 
job-runner' to start. One way to handle that would be for the runner to 
hold a lock file in the directory it's given and quit if the lock is 
already taken. It should probably walk up the directory hierarchy to 
check for lock files as well in case I try to start another job-runner 
instance in a subdirectory.

Best Wishes

Phillip


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
