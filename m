Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67DAC433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 09:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344156AbiF1JXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344339AbiF1JW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 05:22:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BA61D314
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:22:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ge10so24445671ejb.7
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=y3hnjQVqwxRZqWqlGSOx4xzVORQQFLum1+4btdraRQ0=;
        b=b5TX0Hk3ri2LdaJvggjXp9ysXCkN3z7etNcpE90G28sEtTOnoS6ai8Nn5boBNHfhJt
         OF7Lcrvh0QAPXyFwQYW8T/qtMsFM5/xLOr+SU2sGtzUSv0p7xH/yxS3itXuqasxc7QUS
         fOAUWXmLDvM7X7F97bZWy/66V2LWFSGaoV17aQGKYwfca2zWFKpKkuDqKujzxWPLHiqx
         puIX217Sms+RyJxPCdsevlFY/W2MJPu5KCWSoGKbADtZ9/IZTHwhDGh4p+5enkOtskLF
         rxlAGitz1IR1ddTekkCpfM2vFEsoPoypGxbEkwvbhKSr8hUbzeb7scoKKXJ3aqJ9rr3e
         kQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=y3hnjQVqwxRZqWqlGSOx4xzVORQQFLum1+4btdraRQ0=;
        b=L9PbYI0/W7jREY2IQGIrWq+JJC+ExS8zrwfny51evxYlse9rZWpbo8VqXsOEWTgyLY
         NSHDloDMKF5IzrY0AJcBEdZgbO3wqSnKAZme3q8rZ/tqLhiXExSgA9/tP9QQ8DGniuHO
         b2sncVfzPobSNJf/TrXW7YxQ6RybyAh7F8cb8x2FImEaRKcBki1+IDki5tC49OlRJdAL
         7b+Z+z026hO5ebA8gTMYr2KPo/MUE4o8TngRQBsJETpLb5WVR0A+8p3QHECo8CnGtDVy
         PIhQ9sdPy9et05U35swuruorqOQBFNqs8cA/1cXL9faFAiVgfHS60k1JKigO0bRA61Ni
         5r5Q==
X-Gm-Message-State: AJIora8qnw2N03WzO8MVfqLm49Az0W8o+9BheOnUfjMlCDWeiu75B7ne
        Bpv3Og6TE/Fma87luwzoItQ=
X-Google-Smtp-Source: AGRyM1sVUUeZUdUjv+McgrX024EpUdW2jnX6O8k//uf/ghU9vvbd+d6kgDgwISI8SulQf1KhGGtyng==
X-Received: by 2002:a17:906:9b86:b0:6f8:24e7:af7d with SMTP id dd6-20020a1709069b8600b006f824e7af7dmr17178745ejc.295.1656408174605;
        Tue, 28 Jun 2022 02:22:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f15-20020a170906084f00b00718d18a1860sm6119222ejd.61.2022.06.28.02.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:22:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o67Qr-001mm9-AQ;
        Tue, 28 Jun 2022 11:22:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com, git@jeffhostetler.com
Subject: Re: [PATCH v5 5/5] tr2: avoid to print "interesting" config repeatedly
Date:   Tue, 28 Jun 2022 11:13:21 +0200
References: <cover.1656403084.git.dyroneteng@gmail.com>
 <f3b87a33da2a9bd2cd5148fcfe1d55a6281d8b99.1656403084.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <f3b87a33da2a9bd2cd5148fcfe1d55a6281d8b99.1656403084.git.dyroneteng@gmail.com>
Message-ID: <220628.86o7ydf8gi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 28 2022, Teng Long wrote:

> We can use GIT_TRACE2_CONFIG_PARAMS and trace2.configparams to
> dump the config which we are inteseted in to the tr2 log. If
> an "interesting" config exists in multiple scopes, it will be
> dumped multiple times. So, let's fix it to only print the
> final value instead.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
> ---
>  trace2/tr2_cfg.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
> index ec9ac1a6ef..632bb6feec 100644
> --- a/trace2/tr2_cfg.c
> +++ b/trace2/tr2_cfg.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "config.h"
> +#include "strmap.h"
>  #include "trace2/tr2_cfg.h"
>  #include "trace2/tr2_sysenv.h"
>  
> @@ -10,6 +11,7 @@ static int tr2_cfg_loaded;
>  static struct strbuf **tr2_cfg_env_vars;
>  static int tr2_cfg_env_vars_count;
>  static int tr2_cfg_env_vars_loaded;
> +static struct strset tr_cfg_set = STRSET_INIT;
>  
>  /*
>   * Parse a string containing a comma-delimited list of config keys
> @@ -101,12 +103,17 @@ static int tr2_cfg_cb(const char *key, const char *value, void *d)
>  {
>  	struct strbuf **s;
>  	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
> +	const char *prior_value;
>  
>  	for (s = tr2_cfg_patterns; *s; s++) {
>  		struct strbuf *buf = *s;
>  		int wm = wildmatch(buf->buf, key, WM_CASEFOLD);
>  		if (wm == WM_MATCH) {
> -			trace2_def_param_fl(data->file, data->line, key, value);
> +			if (strset_contains(&tr_cfg_set, key)
> +			    || git_config_get_value(key, &prior_value))
> +				continue;
> +			trace2_def_param_fl(data->file, data->line, key, prior_value);
> +			strset_add(&tr_cfg_set, key);
>  			return 0;
>  		}
>  	}


Is tr2_cfg_load_patterns() run at early startup, but this perhaps at
runtime? I wonder if this is OK under threading, i.e. concurrent access
to your strset.

The assumption you're making here doesn't hold in general, some config
is "last vaule wins", but for some other config all configured values
are important.

Do we care in this case? I really don't know, but perhaps we can declare
"dedup" using the same facility we're using to wildcard-match keys, and
either make that optional or the default, e.g.:

	GIT_TRACE2_CONFIG_PARAMS='*:dedup,core.*:'

I.e. to make it a list of <glob>[:<options>].

Maybe not worth the effort...
