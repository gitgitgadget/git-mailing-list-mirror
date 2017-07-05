Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32EA8202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 18:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbdGESHk (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 14:07:40 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33108 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbdGESHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 14:07:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id e199so36981333pfh.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7Iyu2CvQB49U/3vJjckrvQCvYl7A4Djoep2wY8KPy9U=;
        b=nX3FnXvoaqhUibJvWj75m7NlGzuEN26L/kb3JWIbt593sZ9d5QLdU1/0nlH/maRhxT
         vbDoxs2yRk2jFrN49Tm9CHI52jMY4ZnQuT4ZgbGjVQSG7QqfsQSep1MWVpDEhMWy4yRm
         BCNfEzlh1m4S56YGPExrVQJ+NFX8Y4zIppoQquuqZZEpbuSRgO6J6K1zbhTtQvlyC2pA
         sPUsylijzTdjmbp2N7d1t1OTuTaxLWsJUeod9kduiLW5EiOLOfdgg5MJLlqsNyCxq5Dl
         pbIrjP0jsLfUmVkjcwUNidC4AQeM5MbSMT0gu+t0ngOCIA/CXXp9pdcplW4Q6wiZsi4j
         /8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7Iyu2CvQB49U/3vJjckrvQCvYl7A4Djoep2wY8KPy9U=;
        b=Wxbsk1kATTeGEhlAgHBoDJv1uOT3ySf/jPGCiWKzHffAiXCRCKgT8jHz9B4NQzm0eN
         2x2IMc/iOmbVdsSxFRfrIWeL2QjSAurpQDWJ1WcM4q1SPHswenxJppGb1JOpWnrUYc6F
         Bnn+WuMX/WKyVkMGFjocjjLR5ZlXzEvcAgHi8x1CzibyTFtXISx56ksSyR/PFgklWjc8
         1QEUhshZN+NXDn+a/8BYWvyPMovVv7piwZRevpQRaxChahET7QO2TuDcXDEOv11zklDm
         nBZoS3xceybaO02c0b4e4h9kW84WAnv80gelw4L1NZx62UlkdUzJ7zN+eoBNybWKBTno
         GwWw==
X-Gm-Message-State: AIVw1136v/RxotcvVRS8a3pL0TJ3oUP3RSfRSZC83+eOep7Sk9GBx6IG
        MijGBc0Kvakfag==
X-Received: by 10.84.217.15 with SMTP id o15mr23836457pli.31.1499278057353;
        Wed, 05 Jul 2017 11:07:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id q67sm55275977pfi.81.2017.07.05.11.07.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 11:07:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 5/6] rev-list: check reflog_info before showing usage
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
        <20170705080655.giw6wjsblepcf5aw@sigill.intra.peff.net>
Date:   Wed, 05 Jul 2017 11:07:35 -0700
In-Reply-To: <20170705080655.giw6wjsblepcf5aw@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 5 Jul 2017 04:06:56 -0400")
Message-ID: <xmqqd19eiwpk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When git-rev-list sees no pending commits, it shows a usage
> message. This works even when reflog-walking is requested,
> because the reflog-walk code currently puts the reflog tips
> into the pending queue.
>
> In preparation for refactoring the reflog-walk code, let's
> explicitly check whether we have any reflogs to walk. For
> now this is a noop, but the existing reflog tests will make
> sure that it kicks in after the refactoring. Likewise, we'll
> add a test that "rev-list -g" without specifying any reflogs
> continues to fail (so that we know our check does not kick
> in too aggressively).
>
> Note that the implementation needs to go into its own
> sub-function, as the walk code does not expose its innards
> outside of reflog-walk.c.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is actually the main "gotcha" I'm worried about with this series.
> I'm not sure if any other code would care about seeing the pending items
> in revs->commits. I still think the series is the right direction; if
> there is such a place, we'd want to teach it to handle reflog walking in
> a similar way, too.

Ah, very good thinking---when I was following along your drafts to
bypass the revs.commits queue for reflog walking, I didn't think of
this one.  

Perhaps "!revs.commits && reflog_walk_empty(revs.reflog_info)" may
want to become a macro "walk_finished(&revs)" or something to
replace existing !revs.commits that is not accompanied by the check
on .reflog_info field?

