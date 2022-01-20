Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A3C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 08:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359319AbiATInC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 03:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359228AbiATIm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 03:42:57 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5B3C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 00:42:57 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id p12so25443614edq.9
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 00:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=y2TkXOWKUurr+zw9b635RaAkgO9O3BOsmdqZ5cRKnAU=;
        b=DgEv7nwelRYgeiFo4UkbfsVNHjAxnncJ4AMGO6093BZrgPA+6A//RTjHQjelnNLfob
         pS2h34bHunKJnKXXAZBCfoVRZO18CMgFn7peJ2jGIG4d6GhIfFpvFWHKSZ32fRbtv+BS
         a+pOw1yfD3jaSmj/PRCQ3p81UQA4KyeHfZ6NWUsrVZ0jyX8ToxgvwYLe18wKiAH6TAia
         tD3a8NVQEtBuzrXXZW9Ylle1jhwfqkxoFmjKidqphTP+d5Ivga6/m9fvVl+lUL6+9Trc
         U3kclPM0Ig76YdVZ6E2mBLHnR+0gsBBU/p+rGPiqtvb4zmec9TPsFhJy4M1gph7jEH9h
         eXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=y2TkXOWKUurr+zw9b635RaAkgO9O3BOsmdqZ5cRKnAU=;
        b=B7XDussjYiA/3wrnTZl6071VvMseKJuG3KWcFwXg51yEaJXB6uaftZSF96WU3I8yxB
         dT1JSjlkSgdWfw6HQsALf569EjifOZbJhUbxvJSUxxPDuVbHVCdTiTGRv0YqkG3hATMB
         lI5oiqY50S1S6h7b04CAVbdDm6ElBw7B/hLowMe7Xm6ivAUwOQ+sPL9diOohPpCOUrs/
         tb6lay388eMp8JfHFtKTSqMjVX/xQEBnLe1sjSkfNnU5Y/psBXOcrnB/gdPi4eKnMtwn
         YH5tUeObzavGM8rvScc6TFAxYqif9ZoLgp7HBH7QhP4crwnnRzFk8dtI3TIRBXbrsqEG
         9ltg==
X-Gm-Message-State: AOAM5323SCdOymu71Y2D7XZoza7ElPocAKayyiFitQTKi01YpQakkRcd
        gqrgRFsFWk3KKP61q4CDJGg=
X-Google-Smtp-Source: ABdhPJysqXJULpK9i9yWz8L4d88CTuMTM99LizogLyi2MoLnGKw/mYB9HKje1BABnlbQSgEfwIhH0Q==
X-Received: by 2002:a17:907:3e82:: with SMTP id hs2mr29206461ejc.30.1642668175570;
        Thu, 20 Jan 2022 00:42:55 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f4sm698712ejh.93.2022.01.20.00.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 00:42:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAT1x-001s6u-0o;
        Thu, 20 Jan 2022 09:42:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/2] builtin add -p: fix hunk splitting
Date:   Thu, 20 Jan 2022 09:42:27 +0100
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
 <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
 <220111.861r1ezcxn.gmgdl@evledraar.gmail.com>
 <348d37a3-f01b-cda6-8ce4-1536e0bd3b06@gmail.com>
 <xmqqv8yovlc2.fsf@gitster.g>
 <47e7b23a-56a3-b533-63ed-a854503b59ed@gmail.com>
 <xmqqr193j8y4.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr193j8y4.fsf@gitster.g>
Message-ID: <220120.86czkmn6gj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 19 2022, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Even if the helper is finalizing the current hunk then I think that
>> "nonsense" hunk would still wrong as it would be calling
>> finalize_hunk() on _every_ context line in the hunk rather than just
>> being called once to finalize the hunk.
>
> True; this triggers every time we finish reading the common context
> lines and not at the end of hunk.  In any case, I think what we
> queued looks good for 'next'.

For what it's worth (and as the person who started this side-thread) I
agree. This looks good as-is, thanks both!

>>>   -		if ((marker == '-' || marker == '+') && *p == ' ')
>>> -			hunk->splittable_into++;
>>> +		if (*p == ' ')
>>> +			complete_file(marker, &hunk->splittable_into);

