Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0139C25B0C
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 09:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiHKJqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 05:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiHKJqt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 05:46:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7B87C1AD
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 02:46:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a7so32594516ejp.2
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 02:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=ilymepadQd99aqCHaYOTzO/+IUm9CWU2sGYOLBSmITY=;
        b=iguyrWAuNhOC9L3Afko4xCrgcQSTivm7wGI5DGS6qGLjCbzp3tgKUoYd5IeEH4z+kx
         O6QN26HKP3yLfMNprfywfk+B3dqDryBlictpSuSPNHAwMy1h3XeM0GHgVf8rp0MraOX4
         KM9KsRIAjRK31nBBPBr25uxXuyyjwFAADtLn2MU6eedFm4YE2YxD96nLeHt+t4INcuFl
         rqAoCNtHE2OiuS6PF6B2j7EX+//qK+5B03ParDfL1ueWZLcKx2zNwALMaAUCvOfkcy5V
         LLTVJ7iICXnsyiYKcfkRo0Omne5l22/UirwcEutNH+B8wGxri+MCRR1m1Hw3E4pKWLP+
         IaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ilymepadQd99aqCHaYOTzO/+IUm9CWU2sGYOLBSmITY=;
        b=DQWH6xvFpyg2q7/D3vMAzWxdJNF1NeUL79IiRaSf5b4/35oKmUI4ORhQGIfYX0KLdF
         2BdJJk9PsmEm1PRhDQLG947ctJkzpyWge/Fkd7AgvZ/XYSzR17tKfgoRi8hQzm/s7j8Z
         Enu67LKWYXf1M0EDn7LluA3UUoJPUj1sRCUlHJ7AM8sKMAP8cY1ZF83Anxie/5mTaLuR
         MnJFbYXO/ykTIrPXvGtaKkD/O92zKRWqbnhnTeJ0X56C9NQNbcjmLb0j7uBlOY9msDcf
         x9wJ4+Iu3mM6MRAo7LIfzkuhmSkCk3TILJV2fLvghD8iD67qYhsP+khfJ7RXSRUCeDem
         bS7g==
X-Gm-Message-State: ACgBeo2wKiiHgfdVxLoNhBEYVE/Z2jNwcC5nFJAdVNXvGLygcjywycBB
        vamaDuqHNDATkexS9YQg8tT1Ck0K8fE=
X-Google-Smtp-Source: AA6agR4xG0dIR4yBepSRkj2f8PM7VwThT82XSy2f/dhrJYsC0di7V4ugfi774+mnCGPL+67o6U+TNA==
X-Received: by 2002:a17:907:72d0:b0:734:b451:c8d9 with SMTP id du16-20020a17090772d000b00734b451c8d9mr1272075ejc.272.1660211206574;
        Thu, 11 Aug 2022 02:46:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b0043a554818afsm8834005eds.42.2022.08.11.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 02:46:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oM4m5-0018F5-0r;
        Thu, 11 Aug 2022 11:46:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Xavier Morel <xavier.morel@masklinn.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] actually detect bad file modes in fsck
Date:   Thu, 11 Aug 2022 11:39:42 +0200
References: <B3488A12-BCE3-48C8-915C-E2AC4E71ECD2@masklinn.net>
 <YvLkU3X9lBsG8wXp@coredump.intra.peff.net>
 <YvLttyyaZWm4pitu@coredump.intra.peff.net>
 <6688857F-B899-4253-933B-0DFE25155D13@masklinn.net>
 <YvQPQUuC+IxO0uo4@coredump.intra.peff.net>
 <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
Message-ID: <220811.86r11nqfi2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 10 2022, Jeff King wrote:

> On Wed, Aug 10, 2022 at 04:04:17PM -0400, Jeff King wrote:
>
>> > Maybe downgrade to info or ignore by default then? It might still be
>> > an issue for people who wilfully upgraded the diagnostic to error
>> > hoping to catch the, but hopefully if they did that they'd rather get
>> > the notice later than never?
>> 
>> Yeah, that may be a sensible resolution. All things being equal I think
>> "warning" is the right level, but out of caution and the historical
>> precedent, maybe downgrading it to "info" is justified.
>> 
>> It should be easy to work that into the patch I showed earlier.
>
> OK, so here are cleaned-up patches to do that.
>
>   [1/3]: tree-walk: add a mechanism for getting non-canonicalized modes
>   [2/3]: fsck: actually detect bad file modes in trees
>   [3/3]: fsck: downgrade tree badFilemode to "info"

This LGTM.

I noticed/reported this issue more than a year ago, but the series I had
for fixing it ended up being dropped, here's the report/analysis at the
time:
https://lore.kernel.org/git/20210308150650.18626-31-avarab@gmail.com/

Basically I was taking a much longer way around to avoid...

>  	/* counts the number of bytes left in the `buffer`. */
>  	unsigned int size;
> +
> +	/* option flags passed via init_tree_desc_gently() */
> +	enum tree_desc_flags {
> +		TREE_DESC_RAW_MODES = (1 << 0),
> +	} flags;
>  };

...this from 1/3 here, i.e. now we're paying the cost of an extra entry
in every "struct tree_desc" user (which includes some hot codepaths),
and just for this one fsck caller.

I wonder if we couldn't introduce a init_tree_desc_gently_flags() for
this instead. You note in 1/3 that you're (rightly) avoiding the churn
of existing callers, but they could just use a "static inline" wrapper
function that would set those flags to 0, we'd pass the flags down, and
not put them into the "tree_desc" struct.

Arguably it doesn't belong there at all, since this new thing is really
an "opts" struct, but "tree_desc" is for "the state of the walk".

It might/would make sense as a "raw_mode" in "struct name_entry"
perhaps, but then we're gettin closer to the larger scope of my initial
larger series, oh well ... :)

