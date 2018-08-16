Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10A8A1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeHPVw3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:52:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43228 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeHPVw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:52:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so5019903wrv.10
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=meXYWeH4LguImPLQGc9yIvX8yEm0dyFBWG6IOMLxlVo=;
        b=RAGxzEmqUjfeUhToh0ypstKzTG+8LAmKpDXnG/9it84d0A6iakQWNMzr+8wt66PEIA
         agvGOKkP/bSL062q4VUh6bhWWSSy2R74uzP+TUaacx5DONT3pZZTWT9HMgUCz2AtSfRT
         o2Cs6c7dOZ7/ssA5UmFOQZgzPDrhXatU7Kutw8i6M+An6eMnM4N9p7i4JARemWBoPyGd
         6Lzu5Pf55mvp6lbI68oa25hKIFvksUbG2uTen33lpDYK8/QDDq5vYJ1fazSAYLkmkJ5n
         Wax3gXV0wA4czAX5cjfgTNaYs4IW8YY8IBmPv57bkScaali9E8NOLN1QdTCEJykKhpw5
         1PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=meXYWeH4LguImPLQGc9yIvX8yEm0dyFBWG6IOMLxlVo=;
        b=bpm3804xwqf3jUxp6oG9CDt7sQiibVYreV/kIZnrjTfrfy68xktTHNc4Kvpx63Fimk
         Mu9wQ0Kchpss+FuBbp5rVs6fbaN76cdaQasx6WuGn/rQuEHwnzcY0G727ieV8XP5rna1
         r1dphn2tGF3t5yEP2WQifGFXu146L0b5tC6s/lOR3Q5CYnoubzNoA0JDnYucUe61uSQ5
         Yz2MAQWB/Ccf3HznVQcRpdIcB//7/Wk+6oNXNuaxD6T6WW9zc3mGy51iZAU4bEM9+L5c
         Bjxu1a/ATvEQLMOIQEULrx3KItTtG79VpKtaHSHQmCEkkdsotIYcs2cOXMjsHi4OHlAr
         vetw==
X-Gm-Message-State: AOUpUlHdYh2zR27I0jZB974r0labs+l1bkLH5w++BDtLQsYE+bmAgvXX
        wB+p6JS3SpdasWRI4GqP50I=
X-Google-Smtp-Source: AA+uWPwyaKuObk6o5cAf0x3EsUs5z5T+OUK6raVORv1mnjkB4qKT5/78OxVxh12nuZkgcxUrksgbeg==
X-Received: by 2002:adf:e78d:: with SMTP id n13-v6mr20311542wrm.136.1534445534758;
        Thu, 16 Aug 2018 11:52:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j133-v6sm3379094wmd.12.2018.08.16.11.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 11:52:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/7] speeding up cat-file by reordering object access
References: <20180810230729.GA19090@sigill.intra.peff.net>
        <fc30f98e-0aa0-89d3-ee32-3d86cc5b342a@gmail.com>
        <20180816173934.GC882@sigill.intra.peff.net>
Date:   Thu, 16 Aug 2018 11:52:13 -0700
In-Reply-To: <20180816173934.GC882@sigill.intra.peff.net> (Jeff King's message
        of "Thu, 16 Aug 2018 13:39:34 -0400")
Message-ID: <xmqqmutmdu02.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think that makes sense. We already see duplicates from
> for_each_packed_object() when they're in multiple packs, and callers
> just need to be ready to deal with it (and depending on what you're
> doing, you may actually _want_ the duplicates).

You of course would also see dups between loose and packed until
prune-packed is run.  

I also was thinking about the same thing after Derrick's response,
but unless you are very specialized caller, it does not allow you do
very much to learn that object X exists as a loose object locally,
also as a loose object in our alternate, and also in pack A, but not
in other packs.  You need a way to say "Read the contents of object
X from that place, not from any other place", "Remove that copy of
object X at that place, but not at any other place" etc. to make
effective use of that kind of information.

The codepath that implements runtime access has "I found a copy
here, but it is unusable, so let's go on to look for another usable
copy" fallback.  This is a tangent but it is something we should not
lose in the midx-enabled world.
