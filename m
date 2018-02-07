Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93C051F404
	for <e@80x24.org>; Wed,  7 Feb 2018 22:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbeBGWl2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 17:41:28 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34766 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbeBGWl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 17:41:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id j21-v6so24676091wmh.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 14:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UsNqg/MlM7VbXhQuWARwXjJ+s+ZvBmytBvDJrlF9TXQ=;
        b=iu7aTPyk4eDHYNo/Pe+/Dm2nciGBt3DXtr0t0nawxP5+SPbVnXtob72KxFRoAayrZF
         LDZtRzS2sRvpKXEIPIDnrJcDwwqghyezTmX9gQ/N/uyGa4u7gWfmMcrhGmbfhzD1Aw2e
         kz0VWHgyODV/vGkhmpJmm+ADi+pVP0Uh4WQA+JeOisLsGMqc9xq0Jk/LV/W1HrRA4apU
         g/sMeiqduntc8/mArvlClNTuGmY+1+8J1Z5gGahWOv7uR8bKEl03Tx18L81o3aIa8jX7
         wIKP3r91aXm86eH3FEj5FIW4XY+OUXJDM06W2D6UeUTeF0pViZGbyIKAsErrDB1dbMKa
         GNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UsNqg/MlM7VbXhQuWARwXjJ+s+ZvBmytBvDJrlF9TXQ=;
        b=X7kW8WM9lw1Z8b5Te7uRVgEvQHy77qwJNUa3ENjigzPLc4O3sEtKyYGzkpzr5rJB8R
         Mgjq1mlACuHgRvjntWdjaumMukLtsg2i+obNW9Ck5VnPEgJ6Vi5BLlN5SVSPj8hjNISn
         2XE+RFHdhcuCqHVSLVIFuajPtIwmphk60VU+dgyV9ShANjbdQz/hV0+x2iJNAjuI+smr
         7Qg1VDNl0SpwiU7E7mkcOPI5p9Agbd554Zz4syI/dkN83LY5BLT1FEorAS0RXasaIqA9
         qaTRCA5xHpfWuCaX+JY1t4LcJ1QhKux1YV8Z4WycLvdR2mJ8c6Cg31kh+I1qHYMo47vy
         DRkg==
X-Gm-Message-State: APf1xPBCxgQ1azNTTQeausKtOsFwAN8LqVOvD/Sklx27k+s069qf4TgW
        cEUTiY8RzhHfFaHH60h1CBo=
X-Google-Smtp-Source: AH8x224bMKJBjOAPUHv2WUtpNFu84R8BzBiRoLRbZe5GMdRkEDlL07sbGxQxZ70g3gyfPgKqhudFhQ==
X-Received: by 10.28.32.5 with SMTP id g5mr5390151wmg.62.1518043285609;
        Wed, 07 Feb 2018 14:41:25 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e15sm3335237wmd.26.2018.02.07.14.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 14:41:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for other repos
References: <20171217225122.28941-1-t.gummerer@gmail.com>
        <20180107223015.17720-1-t.gummerer@gmail.com>
        <20180107223015.17720-2-t.gummerer@gmail.com>
        <xmqq1silpl4g.fsf@gitster.mtv.corp.google.com>
        <20180120115819.GR2641@hank>
        <xmqqpo62mncc.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 07 Feb 2018 14:41:24 -0800
In-Reply-To: <xmqqpo62mncc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 21 Jan 2018 22:14:43 -0800")
Message-ID: <xmqqy3k45sob.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> This was a bit painful change, given that some changes in flight do
>>> add new callsites to read_index_from() and they got the function
>>> changed under their feet.
>>
>> Sorry about that.  Is there any way to make such a change less painful
>> in the future?
>
> One way is to do for read_index_from() what you did for the existing
> users of read_cache_from().  Introduce a _new_ helper that will not
> be known for any existing topics in flight, and use that to make the
> existing API a thin wrapper around it.

This continues to cause pain simply because read_index_from() is
something new topics want to stay stable X-<.  

I'll be merging this to 'next' hopefully as part of today's
integration run, so will need to endure the pain only until it (and
other topics that conflict with it) all graduate to 'master'.

Next time a patch with an internal API change like this appears,
please remind me to push it back a lot stronger.  I was too lenient
and ended up slowing down the progress of other topics this time.
Thanks.


