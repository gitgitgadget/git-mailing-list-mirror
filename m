Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5BF1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 15:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbeGZQWH (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 12:22:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55384 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729894AbeGZQWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 12:22:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so2308068wmc.5
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4njJZnsS4m2IPi0BJq8atUHsbmmVeyyIM5h0SjVq4C0=;
        b=dUfc0vqZ6NCSREJZm/6jlZLkHKebuWDxPxI/Cjb0OIX6Faj69xkN9iE4Prm7d/rC9M
         +/Jt26ZhxAWzT0uRx9FWcM/EQFk7Z7VZpKJKdyfZcSKxp4A6J8PP/h3g7tWqv0Hv4EE4
         9x2xoxnRhBBtGh4WcZdBjYkJ+51cy/FEjP1hmZ11Z3GYj7dbQKcszwYglfFis+h0AF+B
         VjdwuNltc1DlgQcqQ7WlJ6PQCJXhul+9wxFFRoK5q1qDvf8+Eaw2GNdn7Cgkw57GwId5
         N4Z+gBWPQ/tcA779XSA2q2Vz4TEj4tpJTIZItrNbhIAjSmnVLdGcXRizDPaAnfRbXYtI
         +VEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4njJZnsS4m2IPi0BJq8atUHsbmmVeyyIM5h0SjVq4C0=;
        b=Em1Oq9kEnS7VXhwRUjxZ9fkmhMXWmMbhiQ3IgmD16aoBeFvOf14jQG5fKQgoi3+PXH
         J0RSUXPn5c5pTyrd1RYo19joek8M9g0Y8MowxR9PZE1DkZgXumqwCkM0Vf8xpWihc9sZ
         hvndLzHkhpHP9GhdP2giCJ1ERSFCf2u/iTffN35TRu3M85dwnNbRISw4Mga03n55canF
         GFzw88gh79wJh051wrNqeKbnVEFGmYiOeDDKj0oKhiDlWS0llQsotledKuRKDUTJo0ef
         9epiPbV2dSHpSxotxTmw3eUKs6Wc5KFbYqgDAfGSXEETf4cSPcSxvOqXCN1PsWRjafkO
         Dinw==
X-Gm-Message-State: AOUpUlFno7BGGIwpbADZarRUvxkmUmY99bUN8G0s+DiJAZQr4zi4z0Er
        TkP5xBf/4hjBkTcZQ7s37OenfN0G
X-Google-Smtp-Source: AAOMgpcTa4zDrodiR0D+nBsA3VIZmwvQzibX+ALSG2ecApyj8KZsUvcZOGfBvhcbIF+AWcaRv+YolQ==
X-Received: by 2002:a1c:4143:: with SMTP id o64-v6mr1919480wma.123.1532617489623;
        Thu, 26 Jul 2018 08:04:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e141-v6sm2881739wmd.32.2018.07.26.08.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 08:04:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v1] checkout: optionally speed up "git checkout -b foo"
References: <20180724180122.29212-1-benpeart@microsoft.com>
        <CAPig+cQZ4g-6uT3zB0n2XWb-68DUUBZdaimTb6_Y4DNZrLUdyQ@mail.gmail.com>
        <960c32c0-5b10-6854-73c9-392814dddbb3@gmail.com>
Date:   Thu, 26 Jul 2018 08:04:48 -0700
In-Reply-To: <960c32c0-5b10-6854-73c9-392814dddbb3@gmail.com> (Ben Peart's
        message of "Tue, 24 Jul 2018 15:45:19 -0400")
Message-ID: <xmqqeffqrqb3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

[jc: it was a bit surprising that Eric covered all the bits I
covered while we were writing without peeking each other's ;-)]

>> This long list of special-case checks doesn't leave me too enthused,
>> however, that aside, this approach seems backward. Rather than erring
>> on the side of safety by falling back to the merging behavior, it errs
>> in the other direction, ...
>
> I'm not thrilled with the long list either (the plethora of comments
> probably makes it appear worse than it is) but I don't see how...

If there were a simple and futureproof way to tell the option
parsing loop to notice any feature other than "-b newbranch" was
used, then such a whitelisting may be a viable way, but there is
not, and the whitelist condition can become (over time---we are
talking about futureproofing and not "a filter that happens to match
today's feature set") just as complex as this blacklisting function
is (e.g. feature A and feature B when used alone may be compatible
with the optimization but not when used both), so if we were to use
this optimization, I think this long list of special-case checks is
the best we could do.

>>      if (!skip_worktree_merge(...))
>>          ret = merge_working_tree(...);
>>
>
> I personally agree, it was moved to its current location per feedback
> the first time around.  Perhaps with the addition of the config
> setting it will be better received moved out to the caller.

Sounds sensible.  I am still not enthused by the configuration
variable that is underdocumented.  You already said that we know
that this optimization does a wrong thing when sparse checkout is
used---any other cases?  I do not think of any myself, and if that
is true, I am wondering if it makes more sense to "do we have sparse
configuration?" as part of the blacklist condition.  That way, the
users do not have to set anything and they will get an optimization
benefit from an obvious change to skip "read-tree -m HEAD HEAD" that
ought to be a no-op.

Thanks.
