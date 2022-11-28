Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F3C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 12:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiK1MkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 07:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiK1MkF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 07:40:05 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE1313CF0
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:40:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id td2so11321794ejc.5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5tabSOqSwH6/5Eznyfa0+OKwo1W9bE7PftZRtCzcrc=;
        b=KuZiyiCYA3gjjzxYVJdTEAsBZtmls3crci+8yGuVFXqw6d5hCD0ANztWWhwMcK1bet
         HFdDcfttd8dwDSH0lJalYDuml+y/U4NNB/UzgK4TziHVX7TMpd2blAUgHlymNCrXmwo6
         3gHROJmDyS8ZoHSRcLmktGRp2kUiSpY4nMUdxjm2tuldZqFmJMm5RFcZnjK/aBtODsY/
         nbnw2gQNO1EICPvkJzCqxAZLv73CqVyXK1OGoCui2AI5b7i1GFXBaAJf3aqJUMdntKng
         Jfhs4y1mHyDiLPCEV/MLblhDH16NeIj7L+5MwrO25BJK8w6KzcYugKXG7IuO7s8uJl7d
         FnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5tabSOqSwH6/5Eznyfa0+OKwo1W9bE7PftZRtCzcrc=;
        b=xKZrdZwjo7Grj2unH4grAIDS/8bX6PgKOGbWvfjlHgsiAdR8RLvLac9Y3d+WNAnBRD
         z5QAjl7n9cDXZ3W1tUsuzxh1/tkeEMtBe9s9pZEKuB7Ua9F6r0fyTVby3zg3KLhAKkvX
         Eqc8XVsp+gw7tKayeLb7OFpsiBpi64gi+cVFxuYbhk9u/UiSgJlzAdQ87FetVhl3s6Tn
         NTFYi+5GwqW9qHrSimyYqitPpgMuP2zayNPyXBwnEdCcnH2V6a0HM6RRhTTcXC6LPgrj
         2p22dMdfi19ZIX72aLU/Bw4djuUMqjxx8z9pWBYixbkPW10Abwh/RNOhH5EjCAwkW2Ob
         hFMA==
X-Gm-Message-State: ANoB5pmhID4M/8Ph6IpIMwy9KvPiZ2LWVZw4Tnqi+grEJS1r16eAM371
        +b37SDHG8x/EGTP70bQWdHM=
X-Google-Smtp-Source: AA0mqf5hSVPGeHkqI9tUXP33iihE4lTEjH000gFOxuHlkGA5qOhqTyFhkr9WJn6/IlvpWSnyfhAWIg==
X-Received: by 2002:a17:906:6403:b0:7b2:9667:241e with SMTP id d3-20020a170906640300b007b29667241emr44045166ejm.115.1669639203339;
        Mon, 28 Nov 2022 04:40:03 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id gc34-20020a1709072b2200b00772061034dbsm4907475ejc.182.2022.11.28.04.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:40:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozdQY-0012A3-1d;
        Mon, 28 Nov 2022 13:40:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: relay '-v N' to format-patch
Date:   Mon, 28 Nov 2022 13:34:32 +0100
References: <87edtp5uws.fsf@kyleam.com> <xmqqzgcd9ok2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqzgcd9ok2.fsf@gitster.g>
Message-ID: <221128.86v8mzl0bh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 27 2022, Junio C Hamano wrote:

> Kyle Meyer <kyle@kyleam.com> writes:
>
>> Here's a patch handling the -v case.  I don't plan on working on a more
>> complete fix for the other cases (as I mentioned before, I don't use
>> send-email to drive format-patch), but in my opinion the -v fix by
>> itself is still valuable.
>
> Yup, I think it is a good place to stop for the first patch.  Other
> people can add more when they discover the need, and anything more
> complex [*] is probably not worth the effort, I would think.
>
>     Side note: [*] we could imagine running "git format-patch -h"
>     (or a new variant of it), parse its output and populate the
>     %options dynamically, for example.
>
> Will queue.  Thanks.

This is just a comment on the #leftoverbits: I've looked at this option
parsing in "git-send-email" before, and IMO the right long-term fix is
to split out the *.perl code into a "git send-email--helper", and do the
option parsing in C using our parse_options().

Some of it will be a bit of a hassle, but it should be much easier after
8de2e2e41b2 (Merge branch 'ab/send-email-optim', 2021-07-22) (and the
subsquent regression fix).


