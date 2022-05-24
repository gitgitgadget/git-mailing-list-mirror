Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6958C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbiEXUo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiEXUoy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:44:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD49719CE
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:44:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j28so24498702eda.13
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aeY3gv363qF4x2gL9wtaa50MbSlUco+Jcb6hMlhi+FM=;
        b=PRPTKQM1FQdsDx9ZEIc+0IxlEcnsIpeN4LZ2cG55z+WZ87xW/8FUL8/Iy/UtoxK5Js
         x11T2IllHOmRLs27BvoPpgAyuZHKdwwc2AcTaC4UzmrxyFNHb8P8O1j5vvtTqONwdD4z
         HQHVAwFChMBy66F1Pf3iCDweF4PGsgNy8qcl0NhDelWDyO6K7UD1+fDolf5qYfOvzRYw
         HVZwROhN+aGTtubpjXdkEN02GTOaT7a1LCucRT5kCUi3eIo6EjLs5sT3/uVmj93wf7nj
         pzl3OScfqSfvdzAmCtIWx9nmAcPZ4oq/mpxHaZdaM+Mf2u9MgTEnMG73BOk+0Fj3cgoC
         SZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aeY3gv363qF4x2gL9wtaa50MbSlUco+Jcb6hMlhi+FM=;
        b=2mOe59lh39LaiV4K7yiAt3W96yfNJMbT2atszRK0mVGjVK0iUtzCgF79MV2uI4MJiB
         dqbFVZ1/bzBH5ciYMCoBfLx3VdCDi51Xihr7Dzh857oi1D+h4gzqtIShMxli4L7zes69
         5XtHnxVFxO0ntXgWJtJJTXFqPInqzjexlNj/aCO8/9P1tbYCGq3BAmcfvP/yev3iK9fg
         bmSX6/5NsxVG3GgsoisVWgsVjgFkKtGPOMsu7x3GJK45cbNAnc9a2dDhtm23tfM+F8v5
         JIQiDfqCF1b2uXpjP6kP+ag69OuKVR084OuDVU5dVFiofuFPTZ3F+chBEONcIu5o+Ndn
         H51A==
X-Gm-Message-State: AOAM532IAzCfjzfGclssEumzESY8qt4vUd6QVGIlshouU+xNHcHRgNSb
        FPLmLvi5LZKoRFjZEGijqsiFN39YfyM=
X-Google-Smtp-Source: ABdhPJwG3DGDFt6RuqfipTvF9xmPEmxW6pbYdE2w03fk5cmwvJs5yohpCbS2nzxJNkKXIONCr0HHbg==
X-Received: by 2002:a05:6402:3593:b0:42b:550e:ddb with SMTP id y19-20020a056402359300b0042b550e0ddbmr16622517edc.403.1653425092199;
        Tue, 24 May 2022 13:44:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7c995000000b0042aaacd4edasm9973821edt.26.2022.05.24.13.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 13:44:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntbOc-003ZX2-Us;
        Tue, 24 May 2022 22:44:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
Date:   Tue, 24 May 2022 22:38:30 +0200
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
        <xmqqa6b7lrw6.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet>
        <xmqqleuqj1gy.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqleuqj1gy.fsf@gitster.g>
Message-ID: <220524.86r14ivewt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Junio C Hamano wrote:

> [...]
> This incidentally is a good illustration why the thread-starter
> patch that did
>
> 	if (&finished == slot->finished)
> 		slot->finished = NULL;
>
> would be sufficient, and the "clear only ours" guard is not
> necessary, I think.  If the inner run_active_slot() did not trigger
> a callback that adds more reuse of the slot, it will clear
> slot->finished to NULL itself, with or without the guard.  And the
> outer run_active_slot() may fail to clear if the guard is there, but
> slot->finished is NULL in that case, so there is no point in clearing
> it again.
>
> And if the inner run_active_slot() did trigger a callback that ended
> up reusing the slot, then eventually the innermost one would have
> cleared slot->finished to NULL, with or without the guard, before it
> returned the control to inner run_active_slot().  The inference goes
> the same way to show that the guard is not necessary but is not
> hurting.
>
> I _think_ we can even get away by not doing anything to
> slot->finished at the end of run_active_slot(), as we are not
> multi-threaded and the callee only returns to the caller, but if it
> helps pleasing the warning compiler, I'd prefer the simplest
> workaround, perhaps with an unconditional clearing there?

I'll admit I haven't fully looked into this again, but does anything in
the subsequent analysis suggest that my original patch wouldn't be a
working solution to this, still:
https://lore.kernel.org/git/patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com/ ?

The advantage of it over any small and narrow fix like your hunk quoted
above is that it doesn't make the end result look as though we care
about e.g. thread races, which evidently is something more than one
person looking at this has (needlessly) ended up worrying about.

> What did I miss?  I must be missing something, as I can explain how
> the current "(*slot->finished) = 1" with "while (finished)"
> correctly works, but I cannot quite explain why the original "while
> (slot->in_use)" would not, which is annoying.

Perhaps that change was also worried about thread safety? I only briefly
re-looked at this again, but I don't think I ever found exactly what
that 2006-era fix was meant to fix, specifically.

> In other words, why we needed baa7b67d (HTTP slot reuse fixes,
> 2006-03-10) in the first place?  It is possible that we had some
> code paths that forgot to drop in_use before the inner run_active
> returned that have been fixed in the 16 years and this fix was
> hiding that bug, but I dunno.

I haven't found that out either, either back in January or just now.
