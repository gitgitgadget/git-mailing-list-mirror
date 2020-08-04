Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C025BC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40862086A
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIJk8osN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHDU43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgHDU43 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 16:56:29 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942FC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 13:56:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 140so23099852lfi.5
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=138gbplS8keupUniylV++NZKsm63t8c1QVbcG/IumoM=;
        b=NIJk8osNFFpo+xoV2M29xhzxDfC0Mzd0ayWxhFJXh23kOIX8b5/srd6t8gQdCsR7Xy
         1zOu/owsrVB/Z5x7YGSlCH8z5JCAWXmMZmRB+JvmIGoLjc7e8++NsBfEDyM99w/1lMWl
         SV+8th41CSRRyQviUaVGDJirE0HoMM4uAmmqL/jsZX4ea9u2Jz3fvc6iAYhQVxkGbsYM
         XjnqjUwsKZ1Ltu7mLgvsdpaHKeg9ooWf40lnl0JMbK16yN+yI8Wghk90eDC5PnF7jZQk
         /kHlqdkLWHGq+4EqycLKMQZxuys6rnQFNpbXl+FGJz4tS5qtg02Ut3mmIGZiSBnBodyc
         cnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=138gbplS8keupUniylV++NZKsm63t8c1QVbcG/IumoM=;
        b=ox2dRarWouotRvIUvqOI0d3PoNzdz6zEyLJtIa66ceb/WlQPEgvFvGYWFnPiPmNJcK
         NF7rFppzKkd7VoB0iJv1pnL0sgfn8HNOqlSKagYfeSwgMmueyA+YJT0SRlB+zKIbQos1
         dwI59bpPv0QT/r4JwoZ4MOcNxzHQ6Vhzc/0rmBoKPsc+fSqz8UbyYgEbUhUQqf+sv7dE
         ZKUNE9kd1fkiuZnKZf3U3/OsJet/1OrVZ6Rgcvch2LEUPBJaUNvuPDa/qISzASx2hTsx
         arR5PUvps9R9PzIC4jGUKjCrXwaFIoXgFVNx8yQlq5BmCwpxVD7ExcVmg6RirvR+tw56
         ylfg==
X-Gm-Message-State: AOAM5320pb1CDIT1tv20NMoqGUOFGnPLu1M7dbfasc3n8Gn3VVFsqAov
        znNzhGhOS49tAW8p2Vzray4=
X-Google-Smtp-Source: ABdhPJxKLhND21p+OuKNuLE4C3EafT0iw6oLObAgKTLlis2ViCpnhX6boUBngFqbETZAY+fL8a3mZw==
X-Received: by 2002:a19:644:: with SMTP id 65mr10217lfg.203.1596574587099;
        Tue, 04 Aug 2020 13:56:27 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y13sm5936708ljd.19.2020.08.04.13.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:56:26 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
Date:   Tue, 04 Aug 2020 23:56:25 +0300
In-Reply-To: <20200804195830.GA2014743@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 15:58:30 -0400")
Message-ID: <873652166e.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 04, 2020 at 08:50:16PM +0300, Sergey Organov wrote:
>
>> Attached is rather minimal incompatible change to --diff-merges that'd
>> allow extensions in the future, to get out of urge for the discussed
>> changes. I'm going to follow-up with actual improvements and I'm aware
>> it lacks documentation changes.
>
> Thanks, I like the direction here. Definitely it would need
> documentation, but also tests (probably in t4013 alongside the ones my
> series added; in fact you'd probably need to adjust my tests for the
> non-optional argument).
>
>> diff --git a/revision.c b/revision.c
>> index 669bc856694f..dcdff59bc36a 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2323,10 +2323,31 @@ static int handle_revision_opt(struct
>> rev_info *revs, int argc, const char **arg
>>  		revs->diff = 1;
>>  		revs->diffopt.flags.recursive = 1;
>>  		revs->diffopt.flags.tree_in_recursive = 1;
>> -	} else if (!strcmp(arg, "-m") || !strcmp(arg, "--diff-merges")) {
>> +	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
>>  		revs->ignore_merges = 0;
>> +		if (!strcmp(optarg, "off")) {
>> +			revs->ignore_merges = 1;
>> +		} else if (!strcmp(optarg, "all")) {
>> +			revs->diff = 0;
>
> Should this be revs->ignore_merges = 0?

It's 4 lines above, as it's in fact common for all the cases but the
first one.

-- Sergey
