Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747981F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 16:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbeGKQlK (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 12:41:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44403 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387960AbeGKQlK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 12:41:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so18824755wrt.11
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Y445brOr0DpxtEK79Txqah/HL0+Q+vgtCBupyBnF0yc=;
        b=KilvBTo0MmTypvy/2l9pDolFktabSbKjHnTz2cQR6g4RFA+AQcNg3csYqMwSXSRP7n
         ntsH6vwGLQLJ8TzDoXEdbcx3RCZHRcu9eorUTuOa8ONxrIXQbNXHbvocUyqgIiY/Z5Kl
         wOMptjn9XdWLjvbpoWyuHxePmvB0GPkRcLXSVVY2i8wAD0UTkUUkAlx/ZKdWY53NQRBE
         BRC5DpSPVoyy5HbezPfT0XsSK0l1HWDP9WviILO9vbHHhyAgkRxOz4nl+biH0QzfeGSl
         PLunG2yGTyyGrVTkDCEv7U5vHovb1IXM35k+86AZjBePdu3oA+83t1vD9ieTR9N/JwVF
         y3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Y445brOr0DpxtEK79Txqah/HL0+Q+vgtCBupyBnF0yc=;
        b=rf473+yq8rVlA2UdbqmyKHon+sYI2VdWLnHgFjuMQv86shwxwF+1TDcSwjguC2mUR+
         b5wqVF6xv5NCsn7woHtsYMhTSE9CQsZeF2UQotjk2Q2xuiWZTPvFeTOfjhR9rmHNDWl4
         mQ9O3zu0UGkBmubvxRFkE0anFKGiqWR01S7hd4uGP0/b/I5l1b5cLZ72PoKnacXWjMg0
         08gH/F7kL2r0SQBQ5RDRzVK4QgAsFMgIAMEdzjPmrc24rCiUNbXbj47GRoIJ26IoUPiN
         Ldhi25JwqusMfBRjnQo1kVTZ7fKPsCeZRBrfM1/4WVLW9K20LknukKTUQ8Y9bK0QN/X5
         +S0A==
X-Gm-Message-State: AOUpUlH4K7FdhJWcp27XWdZW+Kqc+ciDX634Rlfe4UXBJeZO0TCc/542
        0aPvKiQxojW6DIp6vUkyqf4=
X-Google-Smtp-Source: AAOMgpdxYsoh3oymw1ltN29sg+8Ia9CCxsY+iaH/n7SFkZlSOnWSUxPvsMHLgbm6T34OJW8F95/6Mg==
X-Received: by 2002:adf:aeea:: with SMTP id y97-v6mr12359934wrc.140.1531326961120;
        Wed, 11 Jul 2018 09:36:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m144-v6sm2999203wma.36.2018.07.11.09.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:36:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Max Kirillov <max@max630.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] unpack-trees: do not fail reset because of unmerged skipped entry
References: <20180615044251.10597-1-max@max630.net>
        <20180616051444.GA29754@duynguyen.home>
        <20180710192153.GA2050@jessie.local>
        <CACsJy8BVadBd1T2yoUhnxd21=c8SVaFqPXT8kk4NfnzGyBNOCw@mail.gmail.com>
Date:   Wed, 11 Jul 2018 09:35:59 -0700
In-Reply-To: <CACsJy8BVadBd1T2yoUhnxd21=c8SVaFqPXT8kk4NfnzGyBNOCw@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 11 Jul 2018 17:25:46 +0200")
Message-ID: <xmqq1sc94tn4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jul 10, 2018 at 9:22 PM Max Kirillov <max@max630.net> wrote:
>>
>> On Sat, Jun 16, 2018 at 07:14:44AM +0200, Duy Nguyen wrote:
>> > -- 8< --
>> > diff --git a/unpack-trees.c b/unpack-trees.c
>> > index 3a85a02a77..eb544ee1b3 100644
>> > --- a/unpack-trees.c
>> > +++ b/unpack-trees.c
>> > @@ -1246,7 +1246,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
>> >               if (select_flag && !(ce->ce_flags & select_flag))
>> >                       continue;
>> >
>> > -             if (!ce_stage(ce))
>> > +             if (!ce_stage(ce) && !(ce->ce_flags & CE_CONFLICTED))
>> >                       ce->ce_flags |= skip_wt_flag;
>> >               else
>> >                       ce->ce_flags &= ~skip_wt_flag;
>> > -- 8< --
>>
>> I tried your fix and it is working. I put it instead of my original fix. Would you sign it off?
>
> Signed-off-by: Duy Nguyen <pclouds@gmail.com>

Thanks, both.
