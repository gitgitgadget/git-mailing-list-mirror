Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AEEC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 05:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKUFdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 00:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKUFdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 00:33:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766A71F9EE
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 21:33:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so2317441pjs.5
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 21:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrAkRoJWs3CU3ppstqAUQRY/ZjARkduMd66FOlTPiD8=;
        b=p6wwTCaZT3p9X0QmOY3Foqt84Nd9HpbPTiMpL78iaYlJoS0zxcCY1EI7P09wg8YkS1
         VuN4UQOmEnoQLRYiIvlFqb9BeEpC17buqw2UHxO0Jnb1pOJUaN7sk1Pq/4eNjNwdOriE
         4yvXrRXNAVVnjvXvrRDSUNulU29CJnxZQV8BKMDTNPXBtzhI/uXQI7evvpMvc1Iw4SV2
         +gfb1jwymDwU/68oP8BSLNtlGI8jQlURJ71vyXGIcTBE2rFjpb97uLi9FzTu46z30DCF
         jDvY+kj/6Ldtz73BbaekI9sNpPY3gVnbvNaMSN61TAPAj7RwaFGoAJTTb8w19npmIgx5
         IrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MrAkRoJWs3CU3ppstqAUQRY/ZjARkduMd66FOlTPiD8=;
        b=ZP0egNgu7xEci+94kbW64Y1ZDnF/7OyvCS8U8Fzbzl5HfmJ47cvyjyUCv9EhyA7mcp
         Qw//8C9BkI3Y7WSJLev+Of1FKIsGJnAJ9yaMkn1L2tk9tjX/RKF9mB8HT5KEC3si3MbC
         3+Z/7zq4goCOyWJEqPYzwwY0qja3G3tYYG9LixTvB2CiK9gjkldZ1RFKJB6G7mTY+bWw
         YHkDCeERyp3q7VzeyshiJejAwgjPZKxjA3sNKosUaVWTGDR82nRMS3PJq9/zhMIknVCj
         lWLsiiztOMMmeQUqm8fRrKWg9+9fYRgiUoiD8GrXVluzgtHK0aNt93sVqU1+pi0PN038
         g4AA==
X-Gm-Message-State: ANoB5pmU1W/X3ZXBtlk//KodaklFXSafsB1tBDI/+AGEhBfGuWYdcl/q
        50Va9GFeeY1r1rNkL6LUeqPVudsuTmaNAw==
X-Google-Smtp-Source: AA0mqf4rO7bOTbLS2XxdCjOBWS6TZ3wIl5vnNmfzL/TFTK8UMqw3tnAUuG2VGE5GAYXONuhvkBnMCA==
X-Received: by 2002:a17:90b:3c4a:b0:213:1d14:2a27 with SMTP id pm10-20020a17090b3c4a00b002131d142a27mr18952232pjb.109.1669008787754;
        Sun, 20 Nov 2022 21:33:07 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709027e4600b0017f36638010sm8469036pln.276.2022.11.20.21.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 21:33:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] am: Allow passing --no-verify flag
References: <20221119005031.3170699-1-thierry.reding@gmail.com>
Date:   Mon, 21 Nov 2022 14:33:06 +0900
In-Reply-To: <20221119005031.3170699-1-thierry.reding@gmail.com> (Thierry
        Reding's message of "Sat, 19 Nov 2022 01:50:31 +0100")
Message-ID: <xmqqilj8yir1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> writes:

> From: Thierry Reding <treding@nvidia.com>
>
> The git-am --no-verify flag is analogous to the same flag passed to
> git-commit. It bypasses the pre-applypatch and applypatch-msg hooks
> if they are enabled.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add test to verify that the new option works

> +-n::
> +--no-verify::
> +	By default, the pre-applypatch and applypatch-msg hooks are run.
> +	When any of `--no-verify` or `-n` is given, these are bypassed.
> +	See also linkgit:githooks[5].

I think the goal of this topic is to allow bypassing the checks made
by these two hooks (and possibly future ones that validate the input
to "am"), and there are at least two possible implementations to
achieve that goal.  You can still run the hook and ignore its
failure exit, or you can skip running the hook and pretend as if
hook succeeded.

As it is documented that applypatch-msg is allowed to edit the
message file to normalize the message, between the two, running the
hook (to allow the hook to automatically edit the message) but
ignoring its failure would be a more intuitive approach to "bypass"
the check.  If the option were called --no-hook or --bypass-hooks
then it would be a different story, though.

>  	assert(state->msg);
> -	ret = run_hooks_l("applypatch-msg", am_path(state, "final-commit"), NULL);
> +
> +	if (!state->no_verify)
> +		ret = run_hooks_l("applypatch-msg", am_path(state, "final-commit"), NULL);

And it seems that this took a less intuitive avenue of bypassing the
hook completely.  I am not 100% convinced that this is the better
choice (but I am not convinced it is the worse one, either).

> diff --git a/t/t4154-am-noverify.sh b/t/t4154-am-noverify.sh
> new file mode 100755
> index 000000000000..fbf45998243f
> --- /dev/null
> +++ b/t/t4154-am-noverify.sh
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +

It is surprising, and I am not enthused to see, that this needs an
entirely new script.

Don't we already have a script or two to test "am", among which the
invocation of hooks is already tested?
