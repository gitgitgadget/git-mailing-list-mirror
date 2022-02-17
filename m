Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A727C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 09:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiBQJMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 04:12:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiBQJMA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 04:12:00 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE4CDF17
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:11:44 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m3so2446244eda.10
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Tu++LbZHJ5H4ShUhOp+Jfmuz/UMmH+oFKRMHh/XQtwE=;
        b=YCizIh+svsuKUTBFGOb3EY6Hr1bGmDlmou0It7ZVAi3RUgZpRk0dIC8GtEhyypBflq
         sl70ozBtjz8b/VyAdkqCjYd9rQjKtDUz+FUohX/rt/NktJokyApuro+wAzG3l9TpeaJ2
         ooV3pV57J3IoeoJSYnjo16zNWIpYk25FVDRNORc0CPeYnV9tHV45trXqnTW/oD2Y/VtR
         eGeFTw81pje8xK2gHYHldrUmaQBy4on5BbB2CdnBwIOqyd6bmR9O+qDueG7vOBDWCms5
         I6XGeveEYl1RUUwvYTIVWX0BmwXVitMEPeNjJg5FsQh6Q2RU3QDE8rAoAMxzrrFfR0Yk
         XRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Tu++LbZHJ5H4ShUhOp+Jfmuz/UMmH+oFKRMHh/XQtwE=;
        b=mwRbrM8Nvi3dmxptV9ufxXGDh/I0mF57IF9Z8+wPmLZBuscu7XkoKiefUPkNW99edB
         3r2+PgpCAfShs0zw2D04inZHeBIaQeHUbK0USO1DcDGzxS6t9MoyCFeUdUCp9PywyP58
         p+HvDXWUZcyPM3diT1UCvzmNShaC6iYh0Eh2IgfxnCzcR3ekWGfCRSB7rAHraOXfx/8H
         vm6ar8C505ww5eiOsED5rG3M/bs0reRB75c+KPEjuOX5aF+yAVkrJHJeujsYZ/sNt3nP
         leDueWsroVx8uh83gXlEBv63qqbJtDh4ImB6It0j1Si3viVqp5qgTujWTVU4VMw9wKvq
         tE0w==
X-Gm-Message-State: AOAM5319g9w4fFU2vcHep447YXodhIFsbVLP3DpzKW/iYe4tYFvB/wxJ
        XniJ7yEDw5EEGnXIpbwkeGAAHKq8i0uC9A==
X-Google-Smtp-Source: ABdhPJyLZnFPvpEmXWfkLVS43bO8N3tIk2bUYaZzded52cwMCsSsL+Xj2XpZ6qIWWxIv1YUiU1mmgw==
X-Received: by 2002:a05:6402:5186:b0:412:818a:aee0 with SMTP id q6-20020a056402518600b00412818aaee0mr1560992edd.308.1645089102905;
        Thu, 17 Feb 2022 01:11:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id eq19sm2740462edb.36.2022.02.17.01.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 01:11:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKcpC-003f5S-1M;
        Thu, 17 Feb 2022 10:11:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/6] sparse-checkout: error or warn when given
 individual files
Date:   Thu, 17 Feb 2022 10:05:57 +0100
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
 <c3bb2a3b2f18891b08e9af0145d01703818f8a18.1644913943.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <c3bb2a3b2f18891b08e9af0145d01703818f8a18.1644913943.git.gitgitgadget@gmail.com>
Message-ID: <220217.86zgmpj1rm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 15 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>

> +		if (core_sparse_checkout_cone)
> +			die(_("\"%s\" is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), argv[i]);

Almost all of our messaging quotes paths etc. with single quotes, which
also makes this nicer in the C code:

	die(_("'%s' is not a ...

> +		else
> +			warning(_("pass a leading slash before paths such as \"%s\" if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), argv[i]);

ditto.

>  	static struct option builtin_sparse_checkout_add_options[] = {
> +		OPT_BOOL_F(0, "skip-checks", &add_opts.skip_checks,
> +			   N_("skip some sanity checks on the given paths that might give false positives"),
> +			   PARSE_OPT_NONEG),

This is bikeshedding, but I dislike arguments whose long name requires
us to have a PARSE_OPT_NONEG. Or well, not requires, but
--no-skip-checks sounds odd, so it's disallowed here.

Why not simply have a --check-path, --path-checks or --sanity-check, all
of which combine more naturally with a --no than not.

I.e. set the variable to a default of 1, and let the user negate it.

I think that also makes the synopsis easier to grok at first sight,
since a:

    git x [--no-XYZ]

Makes it immediately clear what the default is. Well, I suppose
"--skip-*" does too, but we use --no-* more.

Another reason to do that is that if you do:

    git cmd --no-<TAB>

You can see all the knobs that are off by default, our completion
supports that specifically.
