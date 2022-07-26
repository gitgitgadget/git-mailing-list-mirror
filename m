Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13671C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 15:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiGZPKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiGZPKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 11:10:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02EDDCF
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 08:10:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ez10so26575069ejc.13
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 08:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Esr7cVmUJdK5Bl4r+xcL/YXvBCxkTrfhnotMKFyCzr4=;
        b=YNs1ovpepweD2Bbxvr4xIHl1H2nq5dSTtYmCa6VKmmLA1+iDCXXYP7psT3F0Bid8Dw
         EJaDOnXHNGoz/aLM+pA8hVsnE20oXpWR+z6oBwN0UWjPh8mhal3RPaOUXqPBNZzwUCk+
         ee5sgUJJZWZwJ8W7R6JpkDNgxc8EDdzbRZaF/0W4d6RXOuYtxI3nUNw0ilXrWt6QcEfP
         75D6Y8r3oCq/KO0bn5Y5DwmBkZFwBpVBl7+KyN3+EPD/PVV8ukK2rvSZhO7DBfjFxHic
         ej4Dkeksb1yPRieYNrcKJV3PV8lyFP2V4IW8AXwYYvWErKNttwfFen7f1d9ydR0FhR0L
         49Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Esr7cVmUJdK5Bl4r+xcL/YXvBCxkTrfhnotMKFyCzr4=;
        b=I4zCiIksg0zefRKIwcYBTAdQKgpDOhUvAg+uOSGFepvu/YTVfTCOamWLqXhU8kEqRB
         yjs21dGZA1llieS8UZWqmB6LXJq3T6dzuszzVVHimxibSr2488dA6A/AsXTrmWufnChB
         mTGMar/jyubEAsmUJv82yrZddD+AjQ8sf0w/SCMhJQy3NjmWzN0Wk2qcIxj9rJzuydub
         vlzeDxv50WTEEEiiECMNptX67rY/LwvO2ElVRoMItZTXeNGzefWyFIEPSZtRmVh9xZDi
         oRgLAM6rjvUjcp0s2ntChAivHKP3jjGdWJs4hBiUNNfRyYnR2tg/yZuPXRwJT+wOpdgD
         qqsQ==
X-Gm-Message-State: AJIora9mCqIkGObpItkE3fgbxA5LEfND1jP5LgkDcgJjBuejXrKUYG0m
        8Rw2b4jSrqQMLOHHmyMqnWE=
X-Google-Smtp-Source: AGRyM1toXKfUOU9RnLrPh1T0CvvNgbPwpFFvxlkujp1i2uloRtbVtyWfu0aeIeuub3M/SPNyss0cyA==
X-Received: by 2002:a17:907:3f89:b0:72b:60ee:29cf with SMTP id hr9-20020a1709073f8900b0072b60ee29cfmr14422309ejc.316.1658848208334;
        Tue, 26 Jul 2022 08:10:08 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id m15-20020a50ef0f000000b0043a2b8ab377sm8761736eds.88.2022.07.26.08.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:10:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGMCE-006Aws-Pn;
        Tue, 26 Jul 2022 17:10:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/3] log: add default decoration filter
Date:   Tue, 26 Jul 2022 17:04:31 +0200
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <6b40b84773c70244bb13204ec566b713f1bdf865.1658844250.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6b40b84773c70244bb13204ec566b713f1bdf865.1658844250.git.gitgitgadget@gmail.com>
Message-ID: <220726.86pmhrnc4x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Derrick Stolee via GitGitGadget wrote:

> +static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
> +{
> +	const struct string_list *config_exclude =
> +		repo_config_get_value_multi(the_repository, "log.excludeDecoration");

Just use git_config_get_value_multi. It supplies the_repository.

> +	if (config_exclude) {
> +		struct string_list_item *item;
> +		for_each_string_list_item(item, config_exclude)
> +			string_list_append(decoration_filter->exclude_ref_config_pattern,
> +					   item->string);
> +	}

mm, not the first time I've wanted the equivalent of strbuf_addbuf but
for a string_list...

> +
> +	if (!decoration_filter->exclude_ref_pattern->nr &&
> +	    !decoration_filter->include_ref_pattern->nr &&
> +	    !decoration_filter->exclude_ref_config_pattern->nr) {

Could return if this isn't true, and save ourselves the subsequent
indentation...

> +		/*
> +		 * No command-line or config options were given, so
> +		 * populate with sensible defaults.
> +		 */
> +		string_list_append(decoration_filter->include_ref_pattern,
> +				   "refs/heads/");
> +		string_list_append(decoration_filter->include_ref_pattern,
> +				   "refs/notes/");
> +		string_list_append(decoration_filter->include_ref_pattern,
> +				   "refs/stash/");
> +		string_list_append(decoration_filter->include_ref_pattern,
> +				   "refs/tags/");
> +		string_list_append(decoration_filter->include_ref_pattern,
> +				   "refs/remotes/");
> +		string_list_append(decoration_filter->include_ref_pattern,
> +				   "HEAD");
> +	}
> +}

Nit: This would be much easier to read if early on there was a:

	struct string_list *list = decoration_filter->include_ref_pattern;

You'd also be able to avoid much of the line wrapping.
