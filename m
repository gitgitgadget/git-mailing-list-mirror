Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCF0C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 10:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347929AbiA1Kzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 05:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244101AbiA1Kzu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 05:55:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF80C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 02:55:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u15so10127276wrt.3
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 02:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=y3wmnrZ9/kcI3s478FOZrtqaehOHhKQpBBEu/jXw7J4=;
        b=DW5ksRpcF9Dem5vIH1LM1qo6hTRqsyiq8EjrnRt02eF1mLLAlOapdZkJwW9/NL1+AF
         YZ4xJQLA2JGRDiq46TC1u/SraSuyyHSBkYz+voVjEPc/95epL8s8zcw6L/dquvxXQPmY
         XWIgJjBkYWe7qWA3BkOXhMBq+nJhi5N7Db2LZHeExS5HMt6iZv1IFtCxzG79uxYCgdk9
         LvUboyX4yvq56uEVn6Dm+YD3SogJwOGnrphIT4XKW/rmHXuNB6KMM/jOQJ7dvTvQowPC
         YGgHuxCH5VE6lvEVS0Cu+6MiZyoAfV6nJ+U6bkpBEc2+/CkpWIG57FTXzJcA5Ezgny0I
         vmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=y3wmnrZ9/kcI3s478FOZrtqaehOHhKQpBBEu/jXw7J4=;
        b=CA0OGwPh3vLYPNJQkVWiRa38huto7tpFyZgr7dsH8IvbNShSKvGG2RXHKLahWG+i+b
         Sp9PQynyQrm+MVTNXH5m2bKYacCfty1dvZ1uwy9plR6jesNyzLocHtVQFzVs4K9TaTOQ
         oWf/28zFmrJn6qWLqYZ4NfQZ4+wTMav7Xl1eMvrJPJ3QGVXCxlJMP8eEW4wRLq1Nm2J1
         ITdmrntOqOJ7dc/q1czzPj3YFns+kwv7K/50bN/VKzBCJeV18wSu8/pUk6fwTm8pLON+
         QDOhfQTB6fDpu0sMZ4DOySrvB1oAgTjh2fCWv4IjWbktSOi4YZL1j11aHBa7iWIcang5
         33hg==
X-Gm-Message-State: AOAM532BxlDAaZ8/CbD8InRvJ40N16lyphrs/aFkIeNzPjVF170DxRIk
        45CvHxbIQwUPvWztSodGjoQdPM6Ru3U=
X-Google-Smtp-Source: ABdhPJzmJuhKjozlrUZ0mIP5H9d+sS9XGgBUcc9QkjOYwXOxcLmquoFJlfmaUb8PKdp+ZsT5pUIw5g==
X-Received: by 2002:a5d:624f:: with SMTP id m15mr6624409wrv.353.1643367348187;
        Fri, 28 Jan 2022 02:55:48 -0800 (PST)
Received: from localhost ([77.75.179.5])
        by smtp.gmail.com with ESMTPSA id z3sm1906983wmp.42.2022.01.28.02.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 02:55:47 -0800 (PST)
References: <20220127153714.1190894-1-t.gummerer@gmail.com>
 <xmqqmtjh0x5f.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2201281110050.347@tvgsbejvaqbjf.bet>
User-agent: mu4e 1.4.15; emacs 27.2
From:   "Thomas Gummerer" <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] fetch --prune: exit with error if pruning fails
In-reply-to: <nycvar.QRO.7.76.6.2201281110050.347@tvgsbejvaqbjf.bet>
Date:   Fri, 28 Jan 2022 10:55:41 +0000
Message-ID: <87pmocp1si.fsf@coati.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Johannes Schindelin writes:

> Hi Junio,
>
> On Thu, 27 Jan 2022, Junio C Hamano wrote:
>
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>>
>> > +		if (retcode) {
>> > +			free_refs(ref_map);
>> > +			goto cleanup;
>> >  		}
>>
>> This part is iffy.  We tried to prune refs, we may have removed some
>> of the refs missing from the other side but we may still have some
>> other refs that are missing from the other side due to the failure
>> we noticed.
>>
>> Is it sensible to abort the fetching?  I am undecided, but without
>> further input, my gut reaction is that it is safe and may even be
>> better to treat this as a soft error and try to go closer to where
>> the user wanted to go as much as possible by continuing to fetch
>> from the other side, given that we have already paid for the cost of
>> discovering the refs from the other side.

> I am not so sure. When pruning failed, there may very well be directories
> or files in the way of fetching the refs as desired. And it might be even
> worse if pruning failed _without_ the fetch failing afterwards: the user
> specifically asked for stale refs to be cleaned up, the command succeeded,
> but did not do what the user asked for.

I was thinking along similar lines here.  I was going back and forth
between letting the fetch continue, and then exiting with a non-zero
exit code, and just erroring out directly.  I ended up with the latter
because it felt like the right thing to do for the user.  The command
failed, so I'd think it's more confusing that it does more work after
that (even if we already did part of that work).

But I don't care too much one way or another, as long as we end up with
a non-zero exit code when the fetch fails.

> Maybe Thomas has an even stronger argument in favor of erroring out. In
> any case, I don't think that `--prune` should be a "best effort, otherwise
> just shrug" option. If we wanted that, we could introduce
> `--prune-best-effort` or some such...

I don't have a strong argument on whether we should error out
immediately after failing to prune the refs, or just erroring out after
doing the rest of the work, other than exiting early feels right to me.

From the comments upthread it seems to me that the argument is more
whether we should continue after failing to prune, and exit with a
non-zero exit code, or if we should just fail early.

Though I'm happy to introduce a '--prune-best-effort' option or
something like that if we still want to preserve that option for users.
I don't really see people wanting to use that though, and it should be
very rare that '--prune' fails, but the rest of the fetch succeeds.
