Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985FEC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiB1QoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiB1QoF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:44:05 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06EE12A82
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:43:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id p4so3350400edi.1
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3eDev/4KOvEgdjmLxzzrN275XlzobfdRmKueNOL7W5A=;
        b=ZeBQ7kHQqKSc6b9YMjRTwOcKuRF1/U+HY1g2/NZL8C428G8ZrU1x9Wz06oxS8cBhZK
         hutRHgFrBUDDNPQTeMkznqRgJq6QLM40g0fFyMjKTxlOiIz/1ORdcJh/ho2m7egCn3QT
         xwGwriTgixEXfv+SNZxV/xHXUbmHxNbdIisvxrdWL4FC+cch/895Ac4XWWtKiHXAuqUd
         e8h1m9RhDM6O6KUWYgFGjZndqpGMyaciJUiNi2oiH7gK+Fb/LkSKO2uqt58mIK2EZSC5
         fLYjymX/m4J3K9PvLX52g+0Zj6oJ1KWAwxvyftxbKuqn7ZLFBerUQ7PKgyaXnvQtlV7j
         Rd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3eDev/4KOvEgdjmLxzzrN275XlzobfdRmKueNOL7W5A=;
        b=ztpGAlWfxHog/I6fakqgquvLjHV4c3G6MX1fmxHEzPDPsOTeNU2xkBZtO9BgxIP7WW
         hzk3a8b+MXXkvNNC22ZfLo6o47myRtc5HDOBLJ99paLJpPeqU8rXUV+tGQ6EiOYw6C3n
         d3MRj1rlxtvoU6YD4oiwVjVV/rVvNwB5Uv2JOhnroaIZ+mIVdLVb4mjUqhg5e6A7C1Im
         mkV6LQchNhWjW9ghRU5j5WKS7woicPNmOZl8eglJppzMIfxmEflisyMH1EbMWaXj+rjN
         POp1lB4nQg1oPQcSS6geyGZmj9ZKZ9zteGKMIKMb4bVNWD9werJQ39s6n3jlVEyuRG/D
         le6g==
X-Gm-Message-State: AOAM530sKlHajzCxBIyb1dBiXGAHAo1QXR1dqu+EfbLjnyvELjkUuSRL
        gMi/kGmJwRTx2DWB+WefOCWFd4YThEw=
X-Google-Smtp-Source: ABdhPJxJyZ+ePrtsjaBSIx0Epi5CI2E5hOAC14BCI8qjPutbFMwwCUTXGW7XeDYSM1WOMFacNwQdYQ==
X-Received: by 2002:a50:fa93:0:b0:40f:d482:ef63 with SMTP id w19-20020a50fa93000000b0040fd482ef63mr20342915edr.348.1646066604031;
        Mon, 28 Feb 2022 08:43:24 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l13-20020a170907914d00b006ab49aedf48sm4477251ejs.157.2022.02.28.08.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:43:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOj7K-001TYZ-IU;
        Mon, 28 Feb 2022 17:43:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 7/8] fetch: after repair, encourage auto gc repacking
Date:   Mon, 28 Feb 2022 17:40:30 +0100
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
 <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
 <2338c15249a3a58032bc1f8b0cd029f3897b4e88.1645719219.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <2338c15249a3a58032bc1f8b0cd029f3897b4e88.1645719219.git.gitgitgadget@gmail.com>
Message-ID: <220228.86v8wz2b85.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 24 2022, Robert Coup via GitGitGadget wrote:

> From: Robert Coup <robert@coup.net.nz>
>
> After invoking `fetch --repair`, the object db will likely contain many
> duplicate objects. If auto-maintenance is enabled, invoke it with
> appropriate settings to encourage repacking/consolidation.
>
> * gc.autoPackLimit: unless this is set to 0 (disabled), override the
>   value to 1 to force pack consolidation.
> * maintenance.incremental-repack.auto: unless this is set to 0, override
>   the value to -1 to force incremental repacking.
>
> Signed-off-by: Robert Coup <robert@coup.net.nz>
> ---
>  Documentation/fetch-options.txt |  3 ++-
>  builtin/fetch.c                 | 23 +++++++++++++++++++++--
>  t/t5616-partial-clone.sh        |  6 ++++--
>  3 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 1131aaad252..73abafdfc41 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -169,7 +169,8 @@ ifndef::git-pull[]
>  	associated objects that are already present locally, this option fetches
>  	all objects as a fresh clone would. Use this to reapply a partial clone
>  	filter from configuration or using `--filter=` when the filter
> -	definition has changed.
> +	definition has changed. Automatic post-fetch maintenance will perform
> +	object database pack consolidation to remove any duplicate objects.
>  endif::git-pull[]
>  
>  --refmap=<refspec>::
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index f32b24d182b..7d023341ac0 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2020,6 +2020,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	struct remote *remote = NULL;
>  	int result = 0;
>  	int prune_tags_ok = 1;
> +	struct strvec auto_maint_opts = STRVEC_INIT;

[Nits, but aside from earlier comments about config options v.s. config[]

this variable...

> +	int opt_val;

...and this...
>  
>  	packet_trace_identity("fetch");
>  
> @@ -2226,10 +2228,27 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  					     NULL);
>  	}
>  
> -	if (enable_auto_gc)
> -		run_auto_maintenance(verbosity < 0, NULL);
> +	if (enable_auto_gc) {

...can just be declared in this scope.

> +		if (repair) {

I think having:

    if (enable_auto_gc && repair)

Might make this more readable without the extra indentation, but of
course then the variables need to be at the top-level... :)

> +			/*
> +			 * Hint auto-maintenance strongly to encourage repacking,
> +			 * but respect config settings disabling it.
> +			 */
> +			if (git_config_get_int("gc.autopacklimit", &opt_val))
> +				opt_val = -1;
> +			if (opt_val != 0)
> +				strvec_push(&auto_maint_opts, "gc.autoPackLimit=1");
> +
> +			if (git_config_get_int("maintenance.incremental-repack.auto", &opt_val))
> +				opt_val = -1;
> +			if (opt_val != 0)
> +				strvec_push(&auto_maint_opts, "maintenance.incremental-repack.auto=-1");
> +		}
> +		run_auto_maintenance(verbosity < 0, &auto_maint_opts);
> +	}
>  
>   cleanup:
>  	string_list_clear(&list, 0);
> +	strvec_clear(&auto_maint_opts);
>  	return result;
>  }
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 230b2dcbc94..60f1817cda6 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -187,7 +187,7 @@ test_expect_success 'push new commits to server for file.4.txt' '
>  # Do partial fetch to fetch smaller files; then verify that without --repair
>  # applying a new filter does not refetch missing large objects. Then use
>  # --repair to apply the new filter on existing commits. Test it under both
> -# protocol v2 & v0.
> +# protocol v2 & v0. Check repacking auto-maintenance is kicked off.
>  test_expect_success 'apply a different filter using --repair' '
>  	git -C pc1 fetch --filter=blob:limit=999 origin &&
>  	git -C pc1 rev-list --quiet --objects --missing=print \
> @@ -199,11 +199,13 @@ test_expect_success 'apply a different filter using --repair' '
>  		main..origin/main >observed &&
>  	test_line_count = 2 observed &&
>  
> +	GIT_TRACE2_EVENT="$(pwd)/trace.log" \

Nit: Better to use $PWD instead of $(pwd), works here, but won't be
compatible with -x if we ever want to test stderr.

>  	git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 \
>  		--repair origin &&
>  	git -C pc1 rev-list --quiet --objects --missing=print \
>  		main..origin/main >observed &&
> -	test_line_count = 0 observed
> +	test_line_count = 0 observed &&
> +	test_subcommand git -c gc.autoPackLimit=1 -c maintenance.incremental-repack.auto=-1 maintenance run --auto --no-quiet <trace.log
>  '
>  
>  test_expect_success 'fetch --repair works with a shallow clone' '

