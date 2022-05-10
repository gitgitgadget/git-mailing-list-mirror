Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F3AC433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 18:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349035AbiEJSnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 14:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243632AbiEJSny (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 14:43:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988A32A7C0B
        for <git@vger.kernel.org>; Tue, 10 May 2022 11:43:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f825f8c944so155210827b3.15
        for <git@vger.kernel.org>; Tue, 10 May 2022 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=iaF7Xx0ccAjDr8CFNPhr5QC6v24OxtvI7lwMXjF10+8=;
        b=SMkZ24IEu8seCrZWb/OsYLx/pWjsF5HgTVY1VjSa2RA7KEKb7aLlJ0nuUARpOIBuP7
         CZxCjw47Kp42cmRoMl7gYHfAAVvLFRDnNUPgWW2giUerGQ44YCTQ+xSf+JSe4nnyGwfj
         75LfmTpN2ltywGndjfLd47PexR3v8o34RAAuzUrrJglOG1ZLSscNw9qEEzub8VzuwXE/
         fmYziQYjIApErmri1dQt9m0BXsQ4lL2JkB4TBuk9oo+R+fL2jPYDNn8ctP0rls6ULWVt
         /R/Wm34t0+CR21OVsgLQ+5sZCMrQ7x2x8AEQ31GBikmyxu0sFCULQva6J59UmvjI33+6
         UG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=iaF7Xx0ccAjDr8CFNPhr5QC6v24OxtvI7lwMXjF10+8=;
        b=fgcrGQxvogApjLIA1uMW6o+rkZjj0ITvOvlU10HWA/7psbZsjZxKtipBukp9XU8Rs7
         3jMgpJ390qVJxIqhogf3/eb/PvYxcJ1pwk9eeXQf+D0uqY4eB6fMA6hyeyqouhZ90onb
         jZ2qXhfs6sFSvjpaUbr1Iw+JtPWI4xE/52kJJ/Ni7qU796brJs8qzEgJBiHfTtpgC9Nq
         4V/Be66HcXtpGyV3Jm+vJ/NviBofMWEeXvDd0MK3xXRtQBfwekIIYnXlMfNXGwFI+rXf
         E1PY7XmoKeqEwZsQjBUIiCPcTavVxRPxtUwUWXOKh5YgulADKBwbkYjIzpoYte09bCH9
         R8SQ==
X-Gm-Message-State: AOAM531WCB8aeM9C0PP/XfEJSSafvn4V00lcekq/sZyQRTR1x2meb8w+
        4XZky+8BhgVZoITbOwC3h2Qm8gHOZ72FpQ==
X-Google-Smtp-Source: ABdhPJwJc9PW0tMi2Dy+ExxaxXMEo+mHnlh3F3u/sE8WyqV+NvPRUp/iu+eFBk6lzVlOX/DPAUCF51sdmoDkXw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6902:114d:b0:644:ba0d:e95c with SMTP
 id p13-20020a056902114d00b00644ba0de95cmr20040583ybu.516.1652208232836; Tue,
 10 May 2022 11:43:52 -0700 (PDT)
Date:   Tue, 10 May 2022 11:43:51 -0700
In-Reply-To: <3234941c-5190-819f-fe3a-f528942c6b44@gmail.com>
Message-Id: <kl6lzgjp6xeg.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com> <3234941c-5190-819f-fe3a-f528942c6b44@gmail.com>
Subject: Re: [PATCH] pull: only pass '--recurse-submodules' to subcommands
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Glen,
>
> Le 2022-05-09 =C3=A0 19:27, Glen Choo via GitGitGadget a =C3=A9crit=C2=A0=
:
>> From: Glen Choo <chooglen@google.com>
>
> First, regarding the commit message title (I never know where to comment
> on that since I can't quote it :P)
>
>> Re: [PATCH] pull: only pass '--recurse-submodules' to subcommands
>
> I understand the intent, i.e. "only pass the CLI flag, not any config, to=
 subcommands"
> but only because I already know what the patch is about. It could be
> read to mean "pass --recurse-submodules only to subcommands, and not to=
=20
> something else". Since this is really a bug that affects the underlying=
=20
> 'git fetch', maybe something like this ?
>
>     pull: pass '--recurse-submodules' to 'fetch' from CLI, not config
>
>>=20
>> Fix a bug in "git pull" where `submodule.recurse` is preferred over
>> `fetch.recurseSubmodules`=20
>
> here I would add "for the underlying 'git fetch'"
>
> (Documentation/config/fetch.txt says that
>> `fetch.recurseSubmodules` should be preferred.). Do this by passing the
>> value of the "--recurse-submodules" CLI option to the underlying fetch,
>> instead of passing a value that combines the CLI option and config
>> variables.
>>=20
>> In other words, this bug occurred because builtin/pull.c is conflating
>> two similar-sounding, but different concepts:
>>=20
>> - Whether "git pull" itself should care about submodules e.g. whether it
>>   should update the submodule worktrees after performing a merge.
>
> nit: "or rebase".
>
>> - The value of "--recurse-submodules" to pass to the underlying "git
>>   fetch".
>>=20
>> Thus, when `submodule.recurse` is set, the underlying "git fetch" gets
>> invoked with "--recurse-submodules", overriding the value of
>> `fetch.recurseSubmodules`.
>
> the wording is a litlle bit misleading here, as submodule.recurse could
> be set to 'false', and then 'git fetch' will be invoked with '--recurse-s=
ubmodules=3Dfalse'.

Thanks for the wording suggestions :) I'll see what I can incorporate.
=20
>> An alternative (and more obvious) approach to fix the bug would be to
>> teach "git pull" to understand `fetch.recurseSubmodules`, but the
>> proposed solution works better because:
>>=20
>> - We don't maintain two identical config-parsing implementions in "git
>>   pull" and "git fetch".
>> - It works better with other commands invoked by "git pull" e.g. "git
>>   merge" won't accidentally respect `fetch.recurseSubmodules`.
>
> I'm not sure of the meaning of the second bullet, since "git merge" shoul=
d
> never perform a fetch ?...=20

Ah, I'm describing a hypothetical issue with the 'obvious' (aka a
literal reading of the docs) approach of teaching "git pull" to handle
`fetch.recurseSubmodules`.

You are correct, "git merge" should never perform a fetch, so it
shouldn't care about `fetch.recurseSubmodules`. But a careless 'fix'
might be to copy what "git fetch" does with its config, e.g.


	if (!strcmp(k, "submodule.recurse")) {
		int r =3D git_config_bool(k, v) ?
			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
		recurse_submodules =3D r;
	} else if (!strcmp(k, "fetch.recursesubmodules")) {
		recurse_submodules =3D parse_fetch_recurse_submodules_arg(k, v);
		return 0;
	}

which might make the internal "git merge" suddenly recurse into
submodules. Of course, this can be fixed by using a fetch-specific
variable, like:

	if (!strcmp(k, "submodule.recurse")) {
		int r =3D git_config_bool(k, v) ?
			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
		recurse_submodules =3D r;
	}
  if (!strcmp(k, "fetch.recursesubmodules")) {
		fetch_recurse_submodules =3D parse_fetch_recurse_submodules_arg(k, v);
		return 0;
	}

  static int run_fetch(const char *repo, const char **refspecs)
  {
    /* ... */
    if (fetch_recurse_submodules !=3D RECURSE_SUBMODULES_DEFAULT)
       /* This is actually wrong wrt the docs, but assume that we could
       combine the two values here correctly. */
       recurse_submodules =3D fetch_recurse_submodules;
    if (recurse_submodules !=3D RECURSE_SUBMODULES_DEFAULT)
      switch (recurse_submodules) {
  }

but then we'd have to add more variables if we have
`merge.recurseSubmodules`, or `rebase.recurseSubmodules` etc.

So the easiest way is to just tell "git pull" to stop assuming that it
knows what the subcommands want :)
