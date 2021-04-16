Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6E7C43461
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 13:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4A7611AC
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 13:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhDPNzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 09:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDPNzF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 09:55:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3A2C061756
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 06:54:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mh2so20723987ejb.8
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=uRl4ak9DMb78lIMp8tw3abNfqjpaEE+o9HtP4kPesyc=;
        b=c5pvztZsho0LDmWlPsu9TJncm82EroOlJTQ/N+ialYeSV8lEfX2yRMDV0GLwUgYiLl
         60HuVUgwTvFjVXxuvQhGgFIv/eVmD0cjvQPBMMF1WuY38t90ssvE5pl4PG3xIQ6cl1+G
         wQyklJqn/+k8GP8tJO9cBmSb4Wen7Id/sQX+n/6MzozfuurJND66B4rhniaBkXfjbm7x
         Yq+aR7v14pAAPMmP86T8l/f80JvNNduT6RaJCuKhsjswE7VJPnfseANZcolxom4AUptj
         J+jYhyPFIa7MKHAVqW8iHd9u88BF6MCBbWZl7s4detFcQPTbslf6jr0YAhHnRkruW1aO
         c6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=uRl4ak9DMb78lIMp8tw3abNfqjpaEE+o9HtP4kPesyc=;
        b=qO2M7EzJyxbkukJcoKGaK0t/KUzEbWFNqDcuajzlfOT7sQl+HGaBdqB/JbjRv+nyQg
         jSosGvo7sojHGmJpGS3XFsn0ZpophZ+1/r9yCENOpjVlj+DMpfSk2J1o22IoNkU5mnt/
         Y1R5Dl7JYAE+SaDKdOlc8IcK+u3T0DpGbWL40Nicp3Q2b7dGfD6m+fXDGD/r2Mr8kJEB
         gA52vwebBTpmCl5lDNdNOtGAKvwHcQaHJayYgUPncdK1sJHJ/jdJuWm/IivM8ZcO3qWL
         TT5Tn9xk16h39tZPvyUXwImHZr5uAB1FHIIND7qgZQjPtd3rtAwjalAvBChAIFw951PV
         itow==
X-Gm-Message-State: AOAM533Fv0MV11EVqrgp5xtK9qyJweHjyeF9dOjqU69zbjpZyE2S987a
        03w8BmJORY/bAcLuYB0gaVw44AyePdQ=
X-Google-Smtp-Source: ABdhPJzJ8xMJkvmgIUDoRHkn2SVg+fzaoCfoST6hlZj9RlCHlfduK1JuVmzx+f2hljeAulUP4CRbjg==
X-Received: by 2002:a17:907:e87:: with SMTP id ho7mr8394441ejc.2.1618581279636;
        Fri, 16 Apr 2021 06:54:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y16sm5399443edc.62.2021.04.16.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 06:54:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 4/4] maintenance: respect remote.*.skipFetchAll
References: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <pull.924.v4.git.1618577399.gitgitgadget@gmail.com>
 <92652fd9e6e17654abdb30625c85937b6b56c38e.1618577399.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <92652fd9e6e17654abdb30625c85937b6b56c38e.1618577399.git.gitgitgadget@gmail.com>
Date:   Fri, 16 Apr 2021 15:54:13 +0200
Message-ID: <87zgxytjwa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 16 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> If a remote has the skipFetchAll setting enabled, then that remote is
> not intended for frequent fetching. It makes sense to not fetch that
> data during the 'prefetch' maintenance task. Skip that remote in the
> iteration without error. The skip_default_update member is initialized
> in remote.c:handle_config() as part of initializing the 'struct remote'.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/gc.c           | 3 +++
>  t/t7900-maintenance.sh | 8 +++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 9d35f7da50d8..98a803196b88 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -878,6 +878,9 @@ static int fetch_remote(struct remote *remote, void *cbdata)
>  	struct maintenance_run_opts *opts = cbdata;
>  	struct child_process child = CHILD_PROCESS_INIT;
>  
> +	if (remote->skip_default_update)
> +		return 0;
> +
>  	child.git_cmd = 1;
>  	strvec_pushl(&child.args, "fetch", remote->name,
>  		     "--prefetch", "--prune", "--no-tags",
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index eadb800c08cc..b93ae014ee58 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -153,7 +153,13 @@ test_expect_success 'prefetch multiple remotes' '
>  
>  	test_cmp_config refs/prefetch/ log.excludedecoration &&
>  	git log --oneline --decorate --all >log &&
> -	! grep "prefetch" log
> +	! grep "prefetch" log &&
> +
> +	test_when_finished git config --unset remote.remote1.skipFetchAll &&
> +	git config remote.remote1.skipFetchAll true &&
> +	GIT_TRACE2_EVENT="$(pwd)/skip-remote1.txt" git maintenance run --task=prefetch 2>/dev/null &&
> +	test_subcommand ! git fetch remote1 $fetchargs <skip-remote1.txt &&
> +	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
>  '
>  
>  test_expect_success 'prefetch and existing log.excludeDecoration values' '

Without having read the code I'd have very much expected a
"remote.*.skipFetchAll" to impact:

    git fetch --all

Or:

    git remote update --all # --all does not exist yet

As e.g. remote.<name>.skipDefaultUpdate would do (i.e. impact "git
remote update" ...).

I suspect naming it like this started as a hack around the lack of
4-level .ini config keys, i.e. so we could do:

    maintenance.remote.<name>.skipFetchAll = true

But I wonder if we couldn't give this a less confusing name still, even
the pseudo-command form of:

    maintenanceRemote.<name>.skipFetchAll = true

Or something...

