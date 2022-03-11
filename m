Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B710AC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 01:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345512AbiCKB6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 20:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345510AbiCKB6l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 20:58:41 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007734F44A
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 17:57:38 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so16119396ejb.4
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 17:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5FjBjEIYTvPGRm+UwzawlzcQmQF3Biu2H5aME3phk1s=;
        b=DA07YDrjyanHR3g4Sn7x6iEaRbdfOhQCgeVNpUCQkxv8n9V7vaf28ipAOa413SQ6+5
         kGPbA3q5pOK9894Xi7BNQyNVWfRResLutiloFJPfQn+6MZBcqFeBEHJk6aGGWwbPyoZO
         bh8CA2ikveXbqT6OkcvHDoOnzp5Ce6kVkndzbilOWrKNODwTh5TT8LInHZv673g1MxU+
         3zL48ifBBUacolCSy3tuqLSCEsOnHSe1F+P6Cgqrda2l/XnUuFYpQVBQ2yFFoAFHa0WF
         JmATg85ypwoEotEKqRCk9aFx0iiYp3sUbClvtKX5lqX+pXXDtzo0TmbdGuwPGt0L0vwh
         CzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5FjBjEIYTvPGRm+UwzawlzcQmQF3Biu2H5aME3phk1s=;
        b=PwZNH4vwCwurP3LtzO9KgAO7iMxseTw0EZzp9j9Ya2ezLQ9ajYQ1EyBbfRe2DYwLRU
         DRKsXZUeLmj95XOU4Gvy+ZkfDv1ozI9knx5QU6IwRxyk6BQBY5/RKTGB7gL/OChM35UZ
         k1jKYWKdyQ93gUpaH23nt/OGyRd61JIaRmJFrIuqSZL3yh14MOnZZPUzvpo8n1j3px0M
         nHRKoqIE5+FaeozFQcj8nJ6zFu9Wwdg+xY6H0e/7VRgqfGYIBuo1GH1HoC+r1pmICSX2
         Mf8hrLVboeEgFl0Kwp3/5zsM4dlPfLytu9qyiJv4UHfo9lDW/v44AWnFj8Arf9/w/eFB
         wuJg==
X-Gm-Message-State: AOAM532EvS5x9GN7UoshNmvZb9XFZcDi73FkHAX2mxeRwhZIYaOHEsHM
        q18CP6z8YJukTxxoMB/7Cq9+wyqtk4d/Cg==
X-Google-Smtp-Source: ABdhPJz3GNBF/7HppXgDozOTO7UfhWUecNNYbI5XUKhoNjEu1zRhtwH5spVZnwi+AI05vJAsQWIiaA==
X-Received: by 2002:a17:906:74c3:b0:6da:be6d:d64b with SMTP id z3-20020a17090674c300b006dabe6dd64bmr6795356ejl.695.1646963856248;
        Thu, 10 Mar 2022 17:57:36 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm2384595ejb.220.2022.03.10.17.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 17:57:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSUX8-000r76-SC;
        Fri, 11 Mar 2022 02:57:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 03/30] fsmonitor: config settings are
 repository-specific
Date:   Fri, 11 Mar 2022 02:47:09 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <ae622a517cf500d5b068871434e33f98e9cf586b.1646160212.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <ae622a517cf500d5b068871434e33f98e9cf586b.1646160212.git.gitgitgadget@gmail.com>
Message-ID: <220311.86fsnpi73l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>

I know this is in "next", just looking over this code again...

> +static void lookup_fsmonitor_settings(struct repository *r)

Here we'll start loading the settings...

> +{
> +	struct fsmonitor_settings *s;
> +	const char *const_str;
> +	int bool_value;
> +
> +	if (r->settings.fsmonitor)
> +		return;

MARK

> +	CALLOC_ARRAY(s, 1);
> +
> +	r->settings.fsmonitor = s;

And right after we alloc the r->settings.fsmonitor we'll ...

> +	fsm_settings__set_disabled(r);

...call this method...
> +
> +	/*
> +	 * Overload the existing "core.fsmonitor" config setting (which
> +	 * has historically been either unset or a hook pathname) to
> +	 * now allow a boolean value to enable the builtin FSMonitor
> +	 * or to turn everything off.  (This does imply that you can't
> +	 * use a hook script named "true" or "false", but that's OK.)
> +	 */
> +	switch (repo_config_get_maybe_bool(r, "core.fsmonitor", &bool_value)) {
> +
> +	case 0: /* config value was set to <bool> */
> +		if (bool_value)
> +			fsm_settings__set_ipc(r);
> +		return;
> +
> +	case 1: /* config value was unset */
> +		const_str = getenv("GIT_TEST_FSMONITOR");
> +		break;
> +
> +	case -1: /* config value set to an arbitrary string */
> +		if (repo_config_get_pathname(r, "core.fsmonitor", &const_str))
> +			return; /* should not happen */
> +		break;
> +
> +	default: /* should not happen */
> +		return;
> +	}
> +
> +	if (!const_str || !*const_str)
> +		return;
> +
> +	fsm_settings__set_hook(r, const_str);
> +}
> [...]
> +void fsm_settings__set_disabled(struct repository *r)
> +{
> +	if (!r)
> +		r = the_repository;
> +
> +	lookup_fsmonitor_settings(r);

...which here will recurse into lookup_fsmonitor_settings and hit
"MARK".

So isn't that fsm_settings__set_disabled() within that method pointless?

> +	r->settings.fsmonitor->mode = FSMONITOR_MODE_DISABLED;
> +	FREE_AND_NULL(r->settings.fsmonitor->hook_path);

It seems as though the intent was to reach this, but these all happen to
be the same thing you'd get with CALLOC_ARRAY(), so I think this just
happened to work out...

> +enum fsmonitor_mode {
> +	FSMONITOR_MODE_DISABLED = 0,

...I.e. this is luckily zero.
