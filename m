Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159CDC678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 18:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjCGSnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjCGSmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 13:42:45 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FAC74DF3
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 10:33:12 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q189so8152612pga.9
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678213930;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieV/uJdpf2w5yt3h0VSVqi/2h5V/i3r+vv2QzPiwVWg=;
        b=NOi2H0T006x5ZmgD8xJysrIuCC1dYd73uk94FKnhSeBr7dzguri0uoO3W3oXqIXdLW
         9MqFRG5SJnz7mVzvml3GDukwUyNpwG6c7y7gH+oOIpwQELX28A5QRUVatsRZG682Q3vZ
         pA0ip3D5yP5zg0rMrgTt39pRrqp7sWsO9Roi12hlck5lG6DIrNXGS+BhdQU8q+lWA5Q3
         HpnWMu6Rej6G6rYVdal6Q0sgFRcWWBRnn7xFGUaYdjV3sr+hc2xRsNknj9Nm44j8s9xP
         2Ohp1CuH064V9xnez1HAS4+cbJLi8tInTT1rtlmstgUiD1Z0AZiZ/9wZPZg5nlXAEmug
         Ljrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213930;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ieV/uJdpf2w5yt3h0VSVqi/2h5V/i3r+vv2QzPiwVWg=;
        b=EUCngjKeq0yIh3ZZgh2SpM3aDa7MhlQ++zHvbC8Gdt3ojK36hQChdwfznFhlk5PRwm
         Q3DA72aNh9xkfXg/CFoYI4cXOvAhMFOoF/QKioHUsepvFo45+EWgQxRleSqI+rE9lJh9
         tMYd7Q76Ou34QVujIIw0e/GifIQEoGC+VakbB3tib3kvAmr9JclJBlHW0gTUKWmz+0It
         5BBXTkKAssi+l+s7Ezs7YG0UFgFUdaq+9VKLsVK0rF3QU2JZaUWrIE6Wa9VrTEjAVGVX
         NYylVZZQ/DjHrxbFc1fwvqHYAq/kB5YmGoB32OgDouNdL+yZyeZpJbicGIRuRKZD3qb0
         ODyw==
X-Gm-Message-State: AO0yUKVAUO/HHkWTajCgi9gII6kJvqIvQ9y0Ili/kzRlqN/FBOpPrbff
        cg3jVypFGFieWZBjVMOgDCk=
X-Google-Smtp-Source: AK7set9V9YqWAt388X9PdQt4svvWW0Y2BbRSxWFolOilV0S8U+0InW98NmGCDvK/63+NAvohN3gpUg==
X-Received: by 2002:aa7:990e:0:b0:5a8:4de2:e94e with SMTP id z14-20020aa7990e000000b005a84de2e94emr13557191pff.33.1678213929634;
        Tue, 07 Mar 2023 10:32:09 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id y22-20020a62b516000000b005a8a9950363sm8217719pfe.105.2023.03.07.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:32:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
        <20230305050709.68736-1-alexhenrie24@gmail.com>
        <20230305050709.68736-4-alexhenrie24@gmail.com>
        <7cf19017-518b-245e-aea2-5dee55f88276@dunelm.org.uk>
Date:   Tue, 07 Mar 2023 10:32:08 -0800
In-Reply-To: <7cf19017-518b-245e-aea2-5dee55f88276@dunelm.org.uk> (Phillip
        Wood's message of "Tue, 7 Mar 2023 14:56:53 +0000")
Message-ID: <xmqqcz5kza3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +rebase.rebaseMerges::
>> +	Whether and how to set the `--rebase-merges` option by default. Can
>> +	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
>> +	true is equivalent to `--rebase-merges` without an argument,
>
> This is a bit picky but how can rebase.rebaseMerges=true be equivalent
> to --rebase-merges without an argument when the behavior of
> --rebase-merges without an argument depends on the value of
> rebase.rebaseMerges?

True.  I think the configuration is meant to give (when set to
something other than Boolean) the default value to the option
"--rebase-merges" that is given without value, so setting to false
should be a no-op (a command line option would override it if given,
and if there is no command line option, --rebase-merges is not used
by default), setting it to a specific value between cousin choices
would give --rebase-merges=<value> unless --no-rebase-merges is
given, but setting it to true here makes the result undefined,
unless the built-in default between cousin choices is described
here.

"Setting to true is equivalent to setting to no-rebase-cousins" and
"Setting to false is a no-op but accepted only for completeness",
perhaps?

>> setting to
>> +	`rebase-cousins` or `no-rebase-cousins` is equivalent to
>> +	`--rebase-merges` with that value as its argument, and setting to false
>> +	is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
>> +	command line without an argument overrides a `rebase.rebaseMerges=false`
>> +	configuration, but the absence of a specific rebase-merges mode on the
>> +	command line does not counteract a specific mode set in the configuration.
>
> I may not agree the with the design choice but the documentation here
> and below is very clear about the behavior of --rebase-merges without
> an argument which is good.

Is it?  rebase.rebaseMerges=true does not give "a specific mode set
in the configuration", so it still is unclear what --rebase-merges
should do in that case.  Unless what it means to set it to true is
described, as you pointed out above, that is.

>> +`no-rebase-cousins`. If the mode is not specified on the command line or in
>> +the `rebase.rebaseMerges` config option, it defaults to `no-rebase-cousins`.

This side could describe what setting it to "true" means, but it is
a separate page so it would be more friendly to readers to cover it
on both pages.

> I think we need
>
> 	} else {
> 		opts->rebase_cousins = 0;
> 	}
>
> here. Otherwise if rebase.rebaseMerges is set twice we wont follow the
> usual "last config wins" convention. For example
>
> 	[rebase]
> 		rebaseMerges=rebase-cousins
> 		rebaseMerges=true
>
> will result in us unexpectedly rebasing cousins

Thanks for a careful review.

