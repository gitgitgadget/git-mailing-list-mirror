Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6761C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 09:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiDSKAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 06:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiDSKAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 06:00:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E632250D
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 02:58:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 11so15524073edw.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=tT6JfIm4PYLifPCm0xvCZFyhP2/r4ZB8piPW/F0KIUc=;
        b=iKJUht9HmldX2yZVlgPEZM9ugN0KnqMlWTyj9M46KOPa2xen6it1gFeXo3ey7+VjaD
         cWgIgFsH4XTUPJS0MoHSoZMdenmTylgkqzAp/g3nekbY+1otLdtC0anNdErKEkq/oGT5
         fAO1hJSp4r85cVcUOlWzIOVu2rgGZzxRsGAtrt2oNCY16X9NRixM7uqHLTnZ4syEZ+s9
         BmxWbcSp/FekTk4St2RFUuA2a0DzJKE5xpPibXp4PEijrlD4AERLMktu9LQnQR0wjjJw
         F2P20Yskb4rL9ecDg6ssvUp6ZNkGF0iONSXe+ry0s/nHjH2YFSxKi+CXTFWDIq2NFSKm
         3SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=tT6JfIm4PYLifPCm0xvCZFyhP2/r4ZB8piPW/F0KIUc=;
        b=sVjE7mc4Rf8tvsyrEFSfQudhAb4qd03orfzZhVmx3MrtBmtEVYBthTTqYLDupdwXzP
         bfK64I04HN9L9ZMJMmW4PBBA9rsSrcSbBNsxyHSk4hsDzPc7CYjYzwZhh9hqwn37qvpk
         D/uLpXSIBFJjz6VGX1S8lGtDx5dOj9KTDt1BWLTja1JSiXA66x79rsTEVsYRwoLkrmV2
         rQnlzSXJryhATkchISPHb7NAzIDgi+j6C2CzkUjaYIqoLG7i3qPeit01xMGrZvKPqaiE
         B5sfct1ga7sQVtfd95qNkT880skVBFKERiD7vxp71xN4wkIlW9ulxbuTUyVaFe+Dsd8i
         FB6Q==
X-Gm-Message-State: AOAM532tz6SRYY3gpvoWjBw/St2P+UW4C2x56lQt8R78qYdQvpgDrHW1
        sWIxOhbqIpsHKCRAhVt1m2o=
X-Google-Smtp-Source: ABdhPJz4W39Rz2grick1A4BDJfmyyz1KdL+XNgUOwMxYns3LkwJdH1H5Lb22J+S6kA8Z1Jt3onjgKg==
X-Received: by 2002:a05:6402:198:b0:410:83e3:21d7 with SMTP id r24-20020a056402019800b0041083e321d7mr16411922edv.159.1650362288249;
        Tue, 19 Apr 2022 02:58:08 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x12-20020a170906710c00b006ef8f9ee226sm2783563ejj.115.2022.04.19.02.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 02:58:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ngkcY-006mBM-Lr;
        Tue, 19 Apr 2022 11:58:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 04/27] fsmonitor-settings: bare repos are
 incompatible with FSMonitor
Date:   Tue, 19 Apr 2022 11:44:19 +0200
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
 <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
 <f2c0569c9012a86f252562a9a906f6de37d0a236.1648140680.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <f2c0569c9012a86f252562a9a906f6de37d0a236.1648140680.git.gitgitgadget@gmail.com>
Message-ID: <220419.86mtgh8kep.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 24 2022, Jeff Hostetler via GitGitGadget wrote:

> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 46be55a4618..50ae3cca575 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -1449,6 +1449,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
>  		die(_("invalid 'ipc-threads' value (%d)"),
>  		    fsmonitor__ipc_threads);

I think that structurally the way things are done in
fsmonitor-settings.c make its use really hard to follow. E.g. here:

> +	prepare_repo_settings(the_repository);

We prep the repo, OK.

> +	fsm_settings__set_ipc(the_repository);

Set IPC.

> +	if (fsm_settings__error_if_incompatible(the_repository))

And here we'll error out if we're incompatible, and this is in the
top-level cmd_fsmonitor__daemon() function. All OK, except why didn't we
check this before "set IPC?".

Anyway, re-arranging some of the diff below:

> @@ -86,6 +111,9 @@ void fsm_settings__set_ipc(struct repository *r)
>  
>  	lookup_fsmonitor_settings(r);
>  
> +	if (check_for_incompatible(r))
> +		return;
> +
>  	r->settings.fsmonitor->mode = FSMONITOR_MODE_IPC;
>  	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
>  }

Here in fsm_settings__set_ipc we return with a NOOP if we're not
compatible.

Then:

> +int fsm_settings__error_if_incompatible(struct repository *r)
> +{
> +	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
> +
> +	switch (reason) {
> +	case FSMONITOR_REASON_OK:
> +		return 0;
> +
> +	case FSMONITOR_REASON_BARE:
> +		error(_("bare repository '%s' is incompatible with fsmonitor"),
> +		      xgetcwd());
> +		return 1;
> +	}
> +
> +	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
> +	    reason);
> +}

Here we'll call fsm_settings__get_reason() which does the same.

> +enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
> +{
> +	if (!r)
> +		r = the_repository;
> +
> +	lookup_fsmonitor_settings(r);
> +
> +	return r->settings.fsmonitor->reason;
> +}

Is there a reason we can't skip this indirection when using the API like
this and e.g. do:

	enum fsmonitor_reason reason;
	prepare_repo_settings(the_repository);
	reason = fsmonitor_check_for_incompatible(the_repository)
        if (reason != FSMONITOR_REASON_OK)
        	die("%s", fsm_settings__get_reason_string(reason));

There's just two callers of this API in "seen", and neither need/want
this pattern where every method needs to lazy load itself, or the
indirection where fsmonitor-settings.c needs to be used as a
clearing-house for state management.

Maybe I'm missing something, but why not make check_for_incompatible()
non-static and have the callers use that (and then it would return
"fsmonitor_reason", not "int", the int return value being redundant to
the enum)>

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 876112abb21..d29048f16f2 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1237,6 +1237,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  
>  	if (fsmonitor > 0) {
>  		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
> +
> +		if (fsm_settings__error_if_incompatible(the_repository))
> +			return 1;
> +
>  		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
>  			warning(_("core.fsmonitor is unset; "
>  				"set it if you really want to "

This looks like a bug, we knew before aquiring the lockfile that we
weren't compatible, so why wait until here to error out? This seems to
skip the rollback_lock_file(), so won't we leave a stale lock?
