Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C494C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbiBOWCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:02:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiBOWCB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:02:01 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0946B13D08
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:01:50 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a23so195765eju.3
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=A1UmAbCMb1FQR5yf8tSyloMra8jvFuLfR/hDFmpZkpY=;
        b=detxXlpD1YD/xERbl5cP2prm7aXa7T7hEYpOCiJAB1+sR/nCgrxgB5/GV4XWaMHF12
         mgkV1Gxlk3gOEm0TyrloaenDrYX2O5SpoVW8VI8f7fVpJem+e8UOfua2IXIRANYYnHfj
         U7yg/P3rBpjZkvXs6s2UVnZVWy31I/t6ly7ROMqvYsAZI8D1Y7/EYFJrqw1OKyV4p++G
         MYchQP5v3Tse+J/QS4D1wMbKrIZ8AD+aTFxo3dFs2cx9ju6++7EJkj5wsKJD0VwSVbfN
         UwSS4P0j2ClbSAg70oXuwxXiGJxH25NNjtWc+SjS/l30w6xOHwmS+U+AxvtkwKk+Ai/u
         7Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=A1UmAbCMb1FQR5yf8tSyloMra8jvFuLfR/hDFmpZkpY=;
        b=0wopnjOWtOulaODOp8eWmnhkhMGSH3iI/srBEATt9aUPOwD9KODmucNr+FeNP2daw+
         v/VHxVUW08rLGXkdrF/VfoZFlQ2XduLNFVaCO+xxcr8+iaRdRGp8e5IcqmIDJhX2GPUv
         YtiOC67UbdpAhkbkWEIl3nvKrVQYOWOQLx4nZnXq2jtFnz/N5hLkyuEWm7weetIvG7cX
         jrn+UJkYuN6p3qTgCTqxyQ5EPz2fxFirtWdebqEdt+19HIb1w8wGm5GO08a7eOVc31v4
         RbX9vF7LVs0/U4QfBTrKwkCOrD76zvrnhPa6Sz80k5Qn18JUtZM/E9wajuZACAX2UgVY
         EpVA==
X-Gm-Message-State: AOAM531ChDGkwPX/FjXk63iYoDuRTaJAMW2utEn9Zfkd7IPxvfcXBWkg
        Razvz3hm5WNc9Ws9cZdsXGquvrPy8TI=
X-Google-Smtp-Source: ABdhPJxgZEvVib5SezzvIDhFdxYGHAkk3/XLaejLUN+zTUWp0OsydzTEICmkSJ0HlgKpPqLlHbEE1w==
X-Received: by 2002:a17:906:94c:b0:6b8:d0d8:68f5 with SMTP id j12-20020a170906094c00b006b8d0d868f5mr18242ejd.249.1644962508173;
        Tue, 15 Feb 2022 14:01:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v2sm12380080ejb.114.2022.02.15.14.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:01:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nK5tL-002tJj-5Y;
        Tue, 15 Feb 2022 23:01:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/9] submodule: make static functions read submodules
 from commits
Date:   Tue, 15 Feb 2022 23:00:24 +0100
References: <20220210044152.78352-1-chooglen@google.com>
 <20220215172318.73533-1-chooglen@google.com>
 <20220215172318.73533-4-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220215172318.73533-4-chooglen@google.com>
Message-ID: <220215.86mtirwzzo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Glen Choo wrote:

> diff --git a/submodule.c b/submodule.c
> index 5ace18a7d9..7032dcabb8 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -932,6 +932,7 @@ struct has_commit_data {
>  	struct repository *repo;
>  	int result;
>  	const char *path;
> +	const struct object_id *super_oid;
>  };

...

> -	struct has_commit_data has_commit = { r, 1, path };
> +	struct has_commit_data has_commit = { r, 1, path, super_oid };

FWIW I wouldn't at all mind the tiny detour of just turning this into
designated initializers while we're at it, instead of having to keep
track of the positionals. I.e.:

	[...] = {
		.repo = r,
		.result = 1,
                .path = path,
                ,super_oid = super_oid
	};

