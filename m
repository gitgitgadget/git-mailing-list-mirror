Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B793F20248
	for <e@80x24.org>; Tue,  5 Mar 2019 13:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfCENdQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 08:33:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38450 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfCENdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 08:33:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id g12so9472745wrm.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 05:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y2c1gBnd5+t14rxE0P162m+g4Xv5Nlj3cNmnWbehYfw=;
        b=UZ5TJTiKsj3H8/R0RVy612Ji2vUj1xVuGE7FR/uEw6kUI3DlyzB3wXL2l9lO7pokpR
         NsNbdfyVRMMCdS3XPBQIm8zSkUflYeaPQWUT+jMfLn2xXpS9x/OWIhDbaCtG+GefpJ5X
         ShvNTTEQIbiAKLQU31tRxEXhbL+1gYg2isndNNkvqikJj7oLTEXga3vvBwTYL+rgsGG3
         maNwWjQwLDo5YYrjakVxnwNCHWQ9oGh3KCH5dwivM7DOQYEey++MLBo0NC9ttcgjFS0Q
         2jCfbO8xfSixIWwhcK6jtxBx2M2CCOaJIEdBmPImUjhPMFniE2jv3vgteG5AAEkqQbq7
         aBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y2c1gBnd5+t14rxE0P162m+g4Xv5Nlj3cNmnWbehYfw=;
        b=ExElsl/GePqJuxiemTkPKMBYI3/Eggv5V93HsecwMf8bfHZ1IF2uSpvpCfYcdXzPyQ
         ZcYVgfrl8kUQrQ6NcPuJ5v1JUHcdGSvoHRKHaVRZpgRVHCcCLBNDc4Hp+IaMD+VKMHCT
         b6qdl7kcGrUiD5/+H29UZHmZJfDnb6S4TNhHaYBCHG1lvlMJGW8qKGXWcW2hgJbe8a+R
         dAYbsWQpqFjmbQRrrGFaaV9egPIZHUfBiANxHET2H20gNKsfC5+VP7mfbv8LHzsWaUYp
         l2Sp5OmZjdpjfCGLl+PAnts1pSVEyxIFNlfsfNi/9+LvofbyLm9+OXv/aCHVzZT3hvJY
         endA==
X-Gm-Message-State: APjAAAXAAU5VIwt5a0gF97ZnEo5DbPASUMWlr1AomykfgIw4izt0HbIZ
        R6j/7APBvDFdW9zJHomGLcs=
X-Google-Smtp-Source: APXvYqw/z2dfYEYVTIxCcSTkfLk9ykNuHabG8VjfRlRYuz34U5CJZuBzG/YlCqcCkdKuFI8IaOO+nw==
X-Received: by 2002:adf:e487:: with SMTP id i7mr15909052wrm.202.1551792794168;
        Tue, 05 Mar 2019 05:33:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o5sm7443202wmh.12.2019.03.05.05.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 05:33:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, matvore@google.com,
        git@vger.kernel.org
Subject: Re: [PATCH] rev-list: allow cached objects in existence check
References: <20190304174053.GA27497@sigill.intra.peff.net>
        <20190304191932.105204-1-jonathantanmy@google.com>
        <20190304211749.GA3020@sigill.intra.peff.net>
Date:   Tue, 05 Mar 2019 22:33:13 +0900
In-Reply-To: <20190304211749.GA3020@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Mar 2019 16:17:49 -0500")
Message-ID: <xmqqzhq9tpie.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Or teach git-blame to have its own pretend mechanism, and remove the
>> pretend mechanism from sha1-file.c.
>
> I think that would be ideal, but I'm not sure if it's feasible due to
> the layering of the various modules.

Sorry, but I do not get why we want command-line specific pretend
mechanism.  When one part of the system wants to behave as if object
X exists, doesn't that part want other parts of the system to share
that same world view to be consistent?

I am mostly reacting to "would be _ideal_"; if it were "if we have
per-system ad-hoc pretend mechanism, things like this and that would
become easier to implement, even though that is an ugly hack", I may
agree when I see examples of things that get easier, though.
