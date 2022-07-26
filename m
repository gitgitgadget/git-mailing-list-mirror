Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EEFC00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 15:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiGZPMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiGZPMd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 11:12:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04982F00F
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 08:12:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j22so26757223ejs.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=g20Ydqa3mn0HI6Tkfi6FY9FhZ7QuDEW9po1GUacKPGI=;
        b=Xm2esbdZ2tGXgctPL0AaP2fUPQ5rGXZ2VL8BxK5wPBQjVjeudBq6vb7airSypx959/
         nFrbEqqallggH/moSLFl2LQ1jEOiQPeUo707+6rliyK0OemqRgeAN9nrV+7eH8vQ/Z5o
         8QwFERusm6FGecAnn6cxYmAc1DrFTyyWCKCoofRSnK7+PWM0TUClxybGFsLj/hOekP5F
         1aXvTU8eoqNWM9hB1UtMeisSuRvb2RfzplALRCkQQ1DK4V6sdoE/l7L1zmVIqHHRDCva
         gqntAf5UJ5rWoHbD71pFX3RVBc7HDFkn/26UgLEzmHC5wW5UwCBKFC9nsaBFYWS8Ta/n
         okYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=g20Ydqa3mn0HI6Tkfi6FY9FhZ7QuDEW9po1GUacKPGI=;
        b=ot1OJhfUWCDyiCYadphBPqqeKs/jsaU1qHENzpF+MOcII93FflYYoehi0ar44oPFeR
         Fc2/tfWiwO1XF70WRNEsMZqjZQs3sNespzfgmt0IXSrqP2vA/2bwVYx0HKlleWIFKskb
         Lf+UapV3uZLzUkz/fSKEhyxRV3+cuztDLdBQu59tQzCyhltYVoXCUA8lm8FEtvQuYnVS
         n3SzhkGKRXw2E+bHPC08ZSmT7r33GMevNONE/JTOqC+bwMyZV9+csbQ2QwVEtWB7BdCk
         KeVpqer+MsLp2XS/lLtYGuqdRl6/dWZVft78WEerjVJbd1YXRS3obbvm1MvJpjY13zkq
         YgYw==
X-Gm-Message-State: AJIora9YTnYpiZddoXNTJKcQcPpXBTjqCWmdmr7fGBwL2rwaR7hM+8x/
        9GUL2QObZbemMVMJ0xnAE8U=
X-Google-Smtp-Source: AGRyM1uYw09TP80L7H94QJ9GfcPm4J7bu9rpujlLNiWm34lC4cOyhkrPDBij2+wCHlt6MM7A0MRf4Q==
X-Received: by 2002:a17:907:2888:b0:72b:9449:fa8b with SMTP id em8-20020a170907288800b0072b9449fa8bmr13794740ejc.334.1658848351192;
        Tue, 26 Jul 2022 08:12:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kz22-20020a17090777d600b0072b16a57cdcsm6543979ejc.118.2022.07.26.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:12:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGMEX-006B2P-Oh;
        Tue, 26 Jul 2022 17:12:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] refs: allow "HEAD" as decoration filter
Date:   Tue, 26 Jul 2022 17:10:28 +0200
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <c2e5a0b3a50237f3b7f5ceb5d05faa83fd41de68.1658844250.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <c2e5a0b3a50237f3b7f5ceb5d05faa83fd41de68.1658844250.git.gitgitgadget@gmail.com>
Message-ID: <220726.86lesfnc0y.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The normalize_glob_ref() method was introduced in 65516f586b693 (log:
> add option to choose which refs to decorate, 2017-11-21) to help with
> decoration filters such as --decorate-refs=<filter> and
> --decorate-refs-exclude=<filter>. The method has not been used anywhere
> else.
>
> At the moment, it is impossible to specify HEAD as a decoration filter
> since normalize_glob_ref() prepends "refs/" to the filter if it isn't
> already there.
>
> Allow adding HEAD as a decoration filter by allowing the exact string
> "HEAD" to not be prepended with "refs/". Add a test in t4202-log.sh that
> would previously fail since the HEAD decoration would exist in the
> output.
>
> It is sufficient to only cover "HEAD" here and not include other special
> refs like REBASE_HEAD. This is because HEAD is the only ref outside of
> refs/* that is added to the list of decorations.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  refs.c         | 4 ++--
>  t/t4202-log.sh | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 90bcb271687..ec3134e4842 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -457,8 +457,8 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
>  
>  	if (prefix) {
>  		strbuf_addstr(&normalized_pattern, prefix);
> -	}
> -	else if (!starts_with(pattern, "refs/"))
> +	} else if (!starts_with(pattern, "refs/") &&
> +		   strcmp(pattern, "HEAD"))
>  		strbuf_addstr(&normalized_pattern, "refs/");

Arguably a digression for this series, but I think it would be very nice
to have a pre-step where we'd create some pre-step to centrally declare
these magical refs in some struct whose flags would cover these various
cases.

E.g. we have this hardcoded in should_autocreate_reflog(), in log-tree.c
(which AFAICT is the reference to "HEAD" here), refs.c etc. etc.

