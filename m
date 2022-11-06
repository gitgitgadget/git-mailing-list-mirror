Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F5CC4332F
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 00:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKFAmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 20:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKFAmN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 20:42:13 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD11007F
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 17:42:12 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r2so4320393ilg.8
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01nmPuKQIpkS3UCthvMvXzI0Syhx9yH2G/WCwxuR/Mk=;
        b=iJhisjFBhvpbLGG2/q+A6btf/09fTLY9RSfeNC/qCOk3TLgx9YfC7yRgL2Y4Ej0mUR
         2YFUfkgAbTE1VbOgHBOSVmpSE3zQzJAN7qw7LG66frntGrma/gttadHASsXN8EdSX5z0
         b1PuvxCt6U1WlCdMmfpmqZY7QaeaddlbNHsabkl5DufiXmX2Q0/X6qbnR55lb/h0hxUF
         b+BdRLT5WG1e1TkubuW2Zl8CFbS04qSGM91u7PCwI7dWFdxwzk3KP2z8WhuYMvmMRJoV
         jVoM7yI816oJg8SdUqInTWpi3mPnT5fAIfOUUkucnUJabU/N4erEvDV2S8WihnQ9fhyq
         srHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01nmPuKQIpkS3UCthvMvXzI0Syhx9yH2G/WCwxuR/Mk=;
        b=aoZERd5DMtAcX69X9EepNZOFmb+Z167WurIqd/WCgkwlUn9LuhSp3RcxICyeVuDMBM
         4dw3c7vxr4VAqNK4hWEcckN/F91BluopgH3fRF+dUxnPYVvRVLvKh4CpaFCvp8W5EOyi
         mIy72SBeXG6ek2FL/4tj4mt/lu2OXhs7HiihBBpA69XnFswNPFEJSV8TyZ7EpQmncXnu
         g/wM7vfI49X+LoURdKwuXjiC6lmepGSvbQqGK6LOC7NSPmCnCE4nlz2+2gXONGia/RTN
         r/sWX6WbMSW+XMwUyMisAmGgeKyFrIo4Plj64CtId0RxgCsZlXfEIVufZedc+L80aRb6
         Bdfg==
X-Gm-Message-State: ACrzQf0AW45iWnDsOs42NyeDRtIxNayEkYYiEOt7xHQYQfl67LFs6w98
        aQ6leub8//07NpfxsELX2vjFdBIb3aV63P7XrQ0=
X-Google-Smtp-Source: AMsMyM6YwjB2/KLLE/OY/y3tsP0BEjSqeeCTvPnksx8UjUgc7NHd6UXlyCt5rI2JFGF9v7efMaA1Yg==
X-Received: by 2002:a92:cb88:0:b0:2fc:1695:df02 with SMTP id z8-20020a92cb88000000b002fc1695df02mr25747491ilo.92.1667695331426;
        Sat, 05 Nov 2022 17:42:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q6-20020a5e9406000000b006d890aabf93sm1328615ioj.55.2022.11.05.17.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 17:42:10 -0700 (PDT)
Date:   Sat, 5 Nov 2022 20:42:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Clement Moyroud <clement.moyroud@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH 2/2] maintenance: add option to register in a specific
 config
Message-ID: <Y2cC4QCz5IhRZLqP@nand.local>
References: <20221105184532.457043-1-ronan@rjp.ie>
 <20221105184532.457043-3-ronan@rjp.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221105184532.457043-3-ronan@rjp.ie>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 05, 2022 at 11:45:32AM -0700, Ronan Pigott wrote:
> maintenance register currently records the maintenance repo exclusively
> within the user's global configuration, but other configuration files
> may be relevant when running maintenance if they are included from the
> global config. This option allows the user to choose where maintenance
> repos are recorded.

I see. So we don't change the location of the config that 'maintenance
run/start' are reading from, but we can change the location of the
config we use to record which repositories are maintenance candidates.

I guess it makes sense if you are including arbitrary configuration
files in your global config, so this seems reasonable to me.

> Signed-off-by: Ronan Pigott <ronan@rjp.ie>
> ---
>
> I track my global config in a bare gitrepo, and include host-specific
> configuration from an auxiliary path. Since on each host I may work on
> different repos, at different paths, and have different preferences for
> prefetch or gc frequency, I record maintenance repos in this
> host-specific config. This option will facilitate this use case.
>
>  Documentation/git-maintenance.txt | 14 +++++++-------
>  builtin/gc.c                      | 28 +++++++++++++++++-----------
>  t/t7900-maintenance.sh            | 15 +++++++++++++++
>  3 files changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index bb888690e4..eb3ae9fbd5 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -50,13 +50,13 @@ stop::
>  	the background maintenance is restarted later.
>
>  register::
> -	Initialize Git config values so any scheduled maintenance will
> -	start running on this repository. This adds the repository to the
> -	`maintenance.repo` config variable in the current user's global
> -	config and enables some recommended configuration values for
> -	`maintenance.<task>.schedule`. The tasks that are enabled are safe
> -	for running in the background without disrupting foreground
> -	processes.
> +	Initialize Git config values so any scheduled maintenance will start
> +	running on this repository. This adds the repository to the
> +	`maintenance.repo` config variable in the current user's global config,
> +	or the config specified by --config option, and enables some
> +	recommended configuration values for `maintenance.<task>.schedule`. The
> +	tasks that are enabled are safe for running in the background without
> +	disrupting foreground processes.

The new text looks good, but there is some unnecessary line re-wrapping
that occurred around it.

>  The `register` subcommand will also set the `maintenance.strategy` config
>  value to `incremental`, if this value is not previously set. The
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 24ea85c7af..5da6905033 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1454,13 +1454,15 @@ static char *get_maintpath(void)
>  }
>
>  static char const * const builtin_maintenance_register_usage[] = {
> -	"git maintenance register",
> +	"git maintenance register [--config <file>]",

"<path>" (instead of "<file>") is slightly more common these days.

>  	NULL
>  };
>
>  static int maintenance_register(int argc, const char **argv, const char *prefix)
>  {
> +	const char *config_file = NULL;
>  	struct option options[] = {
> +		OPT_STRING('c', "config", &config_file, N_("file"), N_("use given config file")),
>  		OPT_END(),
>  	};
>  	int found = 0;
> @@ -1502,7 +1504,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
>  		if (!user_config)
>  			die(_("$HOME not set"));

Hmm. I wonder if we want to avoid calling git_global_config() when we
don't need to. Maybe something like this:

--- >8 ---
diff --git a/builtin/gc.c b/builtin/gc.c
index 5da6905033..13a2633912 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1460,7 +1460,7 @@ static char const * const builtin_maintenance_register_usage[] = {

 static int maintenance_register(int argc, const char **argv, const char *prefix)
 {
-	const char *config_file = NULL;
+	char *config_file = NULL;
 	struct option options[] = {
 		OPT_STRING('c', "config", &config_file, N_("file"), N_("use given config file")),
 		OPT_END(),
@@ -1499,14 +1499,21 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)

 	if (!found) {
 		int rc;
-		char *user_config, *xdg_config;
-		git_global_config(&user_config, &xdg_config);
-		if (!user_config)
-			die(_("$HOME not set"));
+		char *user_config = NULL, *xdg_config = NULL;
+		char *to_free = NULL;
+
+		if (config_file) {
+			user_config = config_file;
+		} else {
+			git_global_config(&user_config, &xdg_config);
+			to_free = user_config;
+			if (!user_config)
+				die(_("$HOME not set"));
+		}
 		rc = git_config_set_multivar_in_file_gently(
-			config_file ?: user_config, "maintenance.repo", maintpath,
+			user_config, "maintenance.repo", maintpath,
 			CONFIG_REGEX_NONE, 0);
-		free(user_config);
+		free(to_free);
 		free(xdg_config);

 		if (rc)
--- 8< ---

> -			user_config, key, NULL, maintpath,
> +			config_file ?: user_config, key, NULL, maintpath,

Same note(s) here, too.

> @@ -500,6 +500,21 @@ test_expect_success 'register and unregister' '
>  	git config --global --get-all maintenance.repo >actual &&
>  	test_cmp before actual &&
>
> +	git config --file ./other --add maintenance.repo /existing1 &&
> +	git config --file ./other --add maintenance.repo /existing2 &&
> +	git config --file ./other --get-all maintenance.repo >before &&

I was wondering why you didn't bother writing all of this into "expect",
and then appending "pwd" onto the end of it.

> +	git maintenance register --config ./other &&
> +	test_cmp_config false maintenance.auto &&
> +	git config --file ./other --get-all maintenance.repo >between &&
> +	cp before expect &&
> +	pwd >>expect &&
> +	test_cmp expect between &&

...since it would have simplified the setup here.

> +	git maintenance unregister --config ./other &&
> +	git config --file ./other --get-all maintenance.repo >actual &&
> +	test_cmp before actual &&

...but here you want to compare the output you got above with everything
that was configured before, i.e., just what came out of the first three
lines. Makes sense.

Thanks,
Taylor
