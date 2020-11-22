Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA51C388F9
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 02:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2E3207F7
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 02:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tdoHv5RL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKVCby (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 21:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKVCbx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 21:31:53 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5813C0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 18:31:52 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 11so150392oty.9
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 18:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VHBpB6AyVMT+YjNeLGr9wRlMiw/6+4ajqf9hsALcg3o=;
        b=tdoHv5RLuo/41dzLB/qTVtxVK+ZE70o9CjRiVZbmFrmb9SIufHjQQ781V1GSTHzRBq
         wljiMPhzAVgTG+6SjDOHOogKJ3COsgrUmP4Hj5bPV85X2YShSIauCtxf7/fe9b2a2Vkl
         Pf1KC8owj2O9WJpn2H3+a0pEpVndLNxJuObT00jj37Kuo+NxsoA1uXwLAJiERGetFpKG
         x/tGXKNlon5vEuE7GE1d/dvpjhcpL2JwnT5PyRWIjMc5UooT8a4z7wFbWEo3Ze99tzWV
         rJqeOEAdx9EIzrrlAEOdXboR9cDTYmHuKqYAxo7026M3WMPCKwDuF1m58ba/XzreZiO7
         NKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VHBpB6AyVMT+YjNeLGr9wRlMiw/6+4ajqf9hsALcg3o=;
        b=NK6qHUIkby+mFT5YyNpt2jcTrtIc5T0YYnrmu9+UpDsgS2zxpHT2+pApAiSaf86YUm
         2t/vddxqdvR51Aepy1Rz1wKcfRglsyx6jXT+rQjwEialGtij/m0J0UvyqJWleIjoMN2u
         AgBVVR3HMuScxVBA9tmDiCuKNI9V9vCce3j+bdHHvPnTEKkTHunwU4PT1OBpWZtDRuDi
         O+EOivUoKmE6ZLHEQvxYGC5Y0LmBUpqfiKlBZU+37mvWUMIGHrjkj6PFY5VmtVpvv82r
         fTDunrcVCBG3QHidSg8IBZE0pO5B6j6dCawWEfSVGy9HV7kHLl78KxsE5ULoUWtVupT4
         M02A==
X-Gm-Message-State: AOAM532uiK2GjPJ/o4fquhzClme1WRfYi9Z3DKF8u9AvwzIYgH6aOWI4
        EY/iCU5mJmyUEmgqNK+YBMeFHQ==
X-Google-Smtp-Source: ABdhPJz5xhj4trUxdn5DfeY/nfvXpSBE4d5IHFEHZR3FBbgo4/bWaNtGGd90m5dszZ6W8qJ/nF1Raw==
X-Received: by 2002:a9d:3d3:: with SMTP id f77mr18715300otf.125.1606012312180;
        Sat, 21 Nov 2020 18:31:52 -0800 (PST)
Received: from localhost ([198.184.28.250])
        by smtp.gmail.com with ESMTPSA id q10sm4478469oih.56.2020.11.21.18.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 18:31:51 -0800 (PST)
Date:   Sat, 21 Nov 2020 21:31:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <X7nNlu8wBZw3xFjX@xnor.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
 <CAN0heSq59uX=4pqkhc904oLfeiwF5ctiEb_9cQXYY7T1t=Mt1g@mail.gmail.com>
 <xmqqy2iusdpy.fsf@gitster.c.googlers.com>
 <CAN0heSpVnzyE5S5ReKQ0Q_UU48jQ77NVF1x1NTGx29+5KZsyRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpVnzyE5S5ReKQ0Q_UU48jQ77NVF1x1NTGx29+5KZsyRA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 21, 2020 at 09:11:21PM +0100, Martin Ågren wrote:
> On Sat, 21 Nov 2020 at 20:37, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Martin Ågren <martin.agren@gmail.com> writes:
> >
> > > On Tue, 17 Nov 2020 at 22:46, Taylor Blau <me@ttaylorr.com> wrote:
> > >> Not very much has changed since last time, but a range-diff is below
> > >> nonetheless. The major changes are:
> > >>
> > >>   - Avoid an overflow when bounds checking in the second and third
> > >>     patches (thanks, Martin, for noticing).
> > >
> > > FWIW, the updates to patches 2 and 3 look exactly like what I was
> > > expecting after the discussion on v1. I have nothing to add.
> >
> > Thanks, both.  Shall we move the topic down to 'next'?
>
> I really only dug into those patches 2 and 3. I read the rest of the
> patches of v1 and went "that makes sense", but that's about it. I
> started looking at "pack-bitmap-write: build fewer intermediate bitmaps"
> and went "this looks really cool -- I should try to understand this". :-)
>
> There was SZEDER's comment on that last patch in v2, where future
> readers of that patch will have to wonder why it does s/256/270/ in a
> test. I agree with SZEDER that the change should be mentioned in the
> commit message, even if it's just "unfortunately, we have some magicness
> here, plus we want to pass both with SHA-1 and SHA-256; turns out 270
> hits the problem we want to test for".

Thanks for reviewing it, and noticing a couple of problems in the
earlier patches, too. If folks are happy with the replacement that I
sent [1], then I am too :-).

I don't think that the "big" patch generated a ton of review on the
list, but maybe that's OK. Peff, Stolee, and I all reviewed that patch
extensively when deploying it at GitHub (where it has been running since
late Summer).

> Martin

Thanks,
Taylor

[1]: https://lore.kernel.org/git/X7nMzzMfjm%2Fp9qfj@xnor.local/
