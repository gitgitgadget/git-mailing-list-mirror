Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55354ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiHaUEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHaUEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:04:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3565C0B60
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:04:35 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 73so6063171pga.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date;
        bh=kuyDPYBr0SIhdnxeSNNNNOFgaa1J/1wty3JmgS1HeFc=;
        b=AXCLbmUs2Jl5wm1gaiCQfs3ik3UDSkuxgI7nSN7VjFZYim8U62EUSZf1C5aTxLZRok
         fjmQ+buY4vBoiE6rQAQmvg8KirwicuxOF5ohTl6dQhDASd0UAKr89TogZMolY1rQkAjb
         8SMkCxDOz/Nkcx80w0zShScNWY1nplv5IJ7dki7nwsfSMHUtxfgnr0EvMRQupgJMWIdh
         57nApa5Lo4oLBu2x7qtUMcPyGFrbt6t8YHwgWvxn2BxIdVZvSre4vej8uQo9ETTQJ1sa
         hZITxmA2+qichaSQl8ftFpsfBbyLEWAaz9YkQZAOStTFWlBQ8+ZSRSaZrd3Oo4SupB05
         q0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=kuyDPYBr0SIhdnxeSNNNNOFgaa1J/1wty3JmgS1HeFc=;
        b=MJTCBMEP2PrqQcVi922ubaUNLnCEWU6s2yOEW11wA3Met9+3wJT/AnppKFP1xFLjJI
         0JYtqaUY6VUG/i9kNiVWL/fcoW+2rEvM/9th30kDgt5HM3Pl7SBZRFILBoGJA3OPdSCm
         GcnFzsr++d5IArcqnNUd1t8ykflhqwkP+OtFu2Waal6K1mZ3VEsEK0LhE4cGJsytLapS
         27UgGkiKUqYjhhng/vXgYh9ujoaiVZEdzma4lkV9WVzt/cNK5USDM49J/dchZhDoUd76
         t+9KpCK19QJcRrw2j1Du0HEkLa69KgWJ/GP5jHfA8O6khdRm8SiY+/DdaXNQWkaYNIaT
         HsKg==
X-Gm-Message-State: ACgBeo1dp7z76m8gkYweCJZ+OsBn1+SHeZxTRBOsjohHi/7xAcv6WDKx
        +Yo38mcC0XsSOxg1QNE74fc=
X-Google-Smtp-Source: AA6agR7dkG2Mz3waDJzShX6U15dz1GHAhjdQG/F4GW9Zfjm/547Mox/mgoidaKQ02EzGAGm+i5EQkg==
X-Received: by 2002:a63:8bc9:0:b0:42b:2375:79b3 with SMTP id j192-20020a638bc9000000b0042b237579b3mr22768478pge.207.1661976275188;
        Wed, 31 Aug 2022 13:04:35 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b0016eede528b4sm12132958plh.61.2022.08.31.13.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:04:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v4 1/4] fsmonitor: add two new config options,
 allowRemote and socketDir
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
        <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
        <836a791e6b7fd4490674254ce03105a8ca2175cb.1661962145.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 13:04:34 -0700
Message-ID: <xmqq7d2ofact.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Introduce two new configuration options
>
>    fsmonitor.allowRemote - setting this to true overrides fsmonitor's
>    default behavior of erroring out when enountering network file
>    systems. Additionly, when true, the Unix domain socket (UDS) file
>    used for IPC is located in $HOME rather than in the .git directory.
>
>    fsmonitor.socketDir - allows for the UDS file to be located
>    anywhere the user chooses rather $HOME.

Before describing "what they do", please justify why we need to add
them.  The usual way to do so is to start with some observation of
the status quo, and describe the "gap" between what can be done with
the current system and what the users would want to do.  It might
further be necessary to justify why "would want to do" is worthwhile
to support.  I suspect that you can do all of the above in a couple
of paragraphs, and you'd succeed if the solution you chose would
fall out as a natural consequence in the mind of readers who follow
your line of thought by reading these introductory paragraphs.  And
then after the stage is set like so, the above description of what
you chose to implement as a solution should come.

>  struct fsmonitor_settings {
>  	enum fsmonitor_mode mode;
>  	enum fsmonitor_reason reason;
> +	int allow_remote;

I am debating myuself if a comment like

	int allow_remote; /* -1: undecided, 0: unallowed, 1: allowed */

is necessary (I know it would help if we had one; I am just
wondering if it is too obvious).

>  	char *hook_path;
> +	char *sock_dir;
>  };
>  
>  static enum fsmonitor_reason check_for_incompatible(struct repository *r)
> @@ -43,6 +45,7 @@ static struct fsmonitor_settings *alloc_settings(void)
>  	CALLOC_ARRAY(s, 1);
>  	s->mode = FSMONITOR_MODE_DISABLED;
>  	s->reason = FSMONITOR_REASON_UNTESTED;
> +	s->allow_remote = -1;
>  
>  	return s;
>  }

OK.  socket_dir is naturally NULL at the start.

> @@ -100,6 +123,7 @@ enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
>  	return r->settings.fsmonitor->mode;
>  }
>  
> +
>  const char *fsm_settings__get_hook_path(struct repository *r)
>  {
>  	if (!r)

A noise hunk?

> @@ -110,9 +134,44 @@ const char *fsm_settings__get_hook_path(struct repository *r)
> ...
> +void fsm_settings__set_socket_dir(struct repository *r)
> +{
> +	const char *path;
> +
> +	if (!r)
> +		r = the_repository;
> +	if (!r->settings.fsmonitor)
> +		r->settings.fsmonitor = alloc_settings();
> +
> +	if (!repo_config_get_pathname(r, "fsmonitor.socketdir", &path)) {
> +		FREE_AND_NULL(r->settings.fsmonitor->sock_dir);
> +		r->settings.fsmonitor->sock_dir = strdup(path);

As we are overwriting it immediately, just calling free(), not
FREE_AND_NULL(), is more appropriate, isn't it?

> @@ -135,7 +194,11 @@ void fsm_settings__set_ipc(struct repository *r)
>  
>  void fsm_settings__set_hook(struct repository *r, const char *path)
>  {
> -	enum fsmonitor_reason reason = check_for_incompatible(r);
> +	enum fsmonitor_reason reason;
> +
> +	fsm_settings__set_allow_remote(r);
> +	fsm_settings__set_socket_dir(r);
> +	reason = check_for_incompatible(r);
>  
>  	if (reason != FSMONITOR_REASON_OK) {
>  		fsm_settings__set_incompatible(r, reason);
> diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
> index d9c2605197f..2de54c85e94 100644
> --- a/fsmonitor-settings.h
> +++ b/fsmonitor-settings.h
> @@ -23,12 +23,16 @@ enum fsmonitor_reason {
>  	FSMONITOR_REASON_NOSOCKETS, /* NTFS,FAT32 do not support Unix sockets */
>  };
>  
> +void fsm_settings__set_allow_remote(struct repository *r);
> +void fsm_settings__set_socket_dir(struct repository *r);

Do these two need to be extern?

I would imagine that implementations in compat/fsmonitor/* would
just call fsm_settings__set_hook() or __set_ipc() and that causes
these two to be called as part of the set-up sequence.  Do they need
to call these two directly?

If not, we probably should make them static.  I suspect that some
existing declarations in this header file fall into the same
category and may need to become static for the same reason, which
you can do as a preliminary clean-up patch, or post-clean-up after
the dust settles.  Regardless of which approach to take for existing
ones, we do not want to make it worse by adding new externally
visible names that do not have to be visible.

>  void fsm_settings__set_ipc(struct repository *r);
>  void fsm_settings__set_hook(struct repository *r, const char *path);
>  void fsm_settings__set_disabled(struct repository *r);
>  void fsm_settings__set_incompatible(struct repository *r,
>  				    enum fsmonitor_reason reason);
>  
> +int fsm_settings__get_allow_remote(struct repository *r);
> +const char *fsm_settings__get_socket_dir(struct repository *r);

On the other hand, these may need to be query-able by the
implementations.

>  enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
>  const char *fsm_settings__get_hook_path(struct repository *r);
