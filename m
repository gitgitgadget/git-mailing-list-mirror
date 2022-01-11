Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82782C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 02:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346509AbiAKCJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 21:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbiAKCJB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 21:09:01 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22ECC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 18:09:00 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u21so38647257edd.5
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 18:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=M0VS0eICSV83Cu6eNQFGAXeV4NzZp6AO0E8pwCBGAoQ=;
        b=JXKqooQA75dWyrx3Cw2+IkN6w6V/nhMCJ6Gm5q8wmZ+OuYSm2n/Ucupoy5uT3pC+50
         H3Wc6P9mFMPxC+wuUVYp9XbHJbdZGwALQHBsFLk1CkAfmJyoCbjPVsFotKyHzuP7VT65
         jN/jE83Llg9T17DyiSU6CXmnRoYsA9/gSytdscXcvA8wTGBgEaf36MTf2KYVpNtWmATw
         F5RsXWw75+Dtju3Uz8dSHXHA6+KHCqKusXXp3pBOnAsESRACQAAexuVYbsRGkh7fC6PH
         gsPDnYi3igWkf/WIddmlP8yoDrvdxYkpty1sVjyebVZwmt1POJIQvnLZxhsNq+JjpEZk
         m9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=M0VS0eICSV83Cu6eNQFGAXeV4NzZp6AO0E8pwCBGAoQ=;
        b=BOt23kJ2wTwcP44yoIerbZS6vtWUsSoQ5Q7IqjDCcZmwBzRWz6et8vHu1Ih0WSr9Du
         2DlTp8rn+WrMQDTONVOY92TWtcbXUr9Z7g00I1ZgIPRoRH57PHLxIJOCPJw9IKTLvfOA
         YmEoOQ1b4FFXh9hRGfun/yq1sBz4l96mnLdQtR8QoJjbUI9VWxO/YNVB/xpOV6iYqVo5
         jdbrrlFkNbxtH9qLkK1UfA/VC0vi0rAwtETR1dHMF/kkbcyZuO8aMuGvm3JyQ+WzkOG8
         wXXiw4i1Mw60ri+96FK+VVLX/Y580qnW30Dw9yjdGCUn38G8IvTq8Zr16RmIhUiXkOpI
         FtNQ==
X-Gm-Message-State: AOAM532egagriI7AWTEscyTCm69g3QgtGr3qashVHXf4d4GjUDBbvMMb
        pIfTEPksl0fkosZH+tGLkg8q6sELwa8nwA==
X-Google-Smtp-Source: ABdhPJxyUcSK65X3lUb24P+w6DJxCweyxIwVUmIHF11FlLv1hPNz0NVZDQMCntXRM3gjWVQBrqVzGg==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr1871209ejw.70.1641866939131;
        Mon, 10 Jan 2022 18:08:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id kv11sm1898377ejc.156.2022.01.10.18.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 18:08:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n76ao-000UIn-4S;
        Tue, 11 Jan 2022 03:08:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, chooglen@google.com
Subject: incorrect 'git (checkout|branch) -h' output with new --track modes
 (was: [PATCH v8 2/3] branch: add flags and config to inherit tracking)
Date:   Tue, 11 Jan 2022 02:57:28 +0100
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1640039978.git.steadmon@google.com>
 <dcba40e2c4001611f837f612cc5ee7890c653aff.1640039978.git.steadmon@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <dcba40e2c4001611f837f612cc5ee7890c653aff.1640039978.git.steadmon@google.com>
Message-ID: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Josh Steadmon wrote:

> Since we've added an argument to "--track", also add "--track=direct" as
> another way to explicitly get the original "--track" behavior ("--track"
> without an argument still works as well).
> [...]
> -'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
> +'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname> [<start-point>]

The usage info here is correct...

> ---track::
> +--track [inherit|direct]::

...as is this...

> -		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
> -			BRANCH_TRACK_EXPLICIT),
> +		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
> +			N_("set branch tracking configuration"),
> +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
> +			parse_opt_tracking_mode),
....

>  	struct option options[] = {
>  		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
> -		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
> -			BRANCH_TRACK_EXPLICIT),
> +		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",

... but these are not. I.e. we'll emit:

    -t, --track[=direct|inherit]
                          set branch tracking configuration

I.e. implying that the valid uses are --track, --track=direct, and
--trackinherit.

It looks like the problem is (ab)use of PARSE_OPT_OPTARG, i.e. it was
never meant for an enumeration of possible values, but for something
like N_("mode"). It could be made to support that, but it would require
some light patching of the releant bits of parse-options.c.

The PARSE_OPT_LITERAL_ARGHELP should also be dropped if it's fixed to
use a string like "mode".

> +			N_("set up tracking mode (see git-pull(1))"),

Aside: In v5 the other reference was changed from using the
"git-pull(1)" manpage syntax. See
https://lore.kernel.org/git/cover.1638859949.git.steadmon@google.com/;
It looks like this one should be changed too, but was missed.

> +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
> +			parse_opt_tracking_mode),



