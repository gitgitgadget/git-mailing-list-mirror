Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9321C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 03:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiLTDm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 22:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiLTDm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 22:42:27 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A9C6314
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 19:42:26 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so10822530pjd.5
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 19:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQBhac6d/TbjPAYw2j8oCMLKlNQtODmjm7Q8ujTHytc=;
        b=W51wr/htQhHMYkNeIYxXBcfB+WvWDDvf7q6yeErbp2AoSNa5ruDdqIStT0HLtBrJr4
         VuCqLnyQtQ+WqFqHGCzXxjMRTpSLeyN/nBv8HPryiyzH9IpxyTuTU2vew0cVdmFVHtcE
         umDDFy2dXTZ/ur187sZo/rLIXSs6kYXOtOSZRajxDvjHp+5dHkayYKGqXyYNAty7M2sA
         rV8lhnnSOP1GQclfQdfYqUS40/cKkeWvoZxabNSda/QzMfSNavv9Mj96QdT8BSsxhCB6
         IstRfji5vo0VpYK+R3lhM+kQlyot+wNOk52H+LTVCMjV4zijx9vnb61zQwg9Nv22Q/3K
         SIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rQBhac6d/TbjPAYw2j8oCMLKlNQtODmjm7Q8ujTHytc=;
        b=v5NPDkubp5RLHfetHvtbTojP3V10r5SLxK8HGFdE9ycBi8+2Hq88Ml2BVNMTaxlUw1
         r7xvcIyMMZ0kP9CZW1kjGDcy8yOZL7BkQQNLEn8aDRwmxGrUm28rx6p7/shJ6B9VN20c
         H2OzhBAFAKEcKuEVyqHRNH09ShNIikx8D5OdwFE/Skbg5SYnPfI/YozoHxX39SzmjOIb
         qPCnATVhaCjwIxvE4fBAL8+TGLyiSWcyTSSYB+RTUPnR4RNAuNnhw6/NMsHORTdibTMQ
         rsyNIvUCHebyvvzckpeP0+LI5Qck/RoPqsz88j7zAd3yAxXAKT9URtKTE9Evzzn+vKO0
         QdHA==
X-Gm-Message-State: AFqh2krcZLROJ8rnFsiq0QGaGcMe/Yw7EYyoRux6kCLk1zr8LscxYFAS
        aFzDIH2gd0TdFP1fhfNmJE0=
X-Google-Smtp-Source: AMrXdXsnDtYOWiYp8V3grtlfZaT1MxDMHoDwlrq1ILNZd6J89u/wXK7DkAORxlOZe4ruPhWKsqK5Xw==
X-Received: by 2002:a17:902:e812:b0:189:f8d0:7b8f with SMTP id u18-20020a170902e81200b00189f8d07b8fmr15939388plg.63.1671507745791;
        Mon, 19 Dec 2022 19:42:25 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b00189d4c666c8sm7973271plx.153.2022.12.19.19.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 19:42:25 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v5 1/4] worktree add: Include -B in usage docs
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221220023637.29042-2-jacobabel@nullpo.dev>
Date:   Tue, 20 Dec 2022 12:42:24 +0900
In-Reply-To: <20221220023637.29042-2-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Tue, 20 Dec 2022 02:37:31 +0000")
Message-ID: <xmqqo7ryyc4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> Subject: Re: [PATCH v5 1/4] worktree add: Include -B in usage docs

s/Include/include/;

> While -B behavior is already documented, it was not included in the
> usage docs for either the man page or the help text.

Good.

> This change fixes
> that and brings the usage docs in line with how the flags are documented
> in other commands such as git checkout.

We often just give an order to the codebase to "be like so", before
describing the effect of following such an order.  I.e.

	Document "-B" next to where "-b" is already documented, to
	bring the usage docs in line with ...

>  'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]]
> -		   [-b <new-branch>] <path> [<commit-ish>]
> +		   [[-b | -B] <new-branch>] <path> [<commit-ish>]

This is wrong, I think.  We want

		   [(-b | -B) <new-branch>] <path> [<commit-ish>]

instead.

[ a-thing ] means "a-thing can exist here, and it does not have to".
[ a-thing | another-thing ] means "a-thing or another-thing can
exist here, but neither has to be here".  [[-b | -B] <new-branch>]
would allow <new-branch> without either -b or -B, which is not what
we want.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 4a24d53be1..fccb17f070 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -17,7 +17,7 @@
>
>  #define BUILTIN_WORKTREE_ADD_USAGE \
>  	N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]\n" \
> -	   "                 [-b <new-branch>] <path> [<commit-ish>]")
> +	   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]")

Likewise.
