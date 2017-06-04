Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31BF3209FD
	for <e@80x24.org>; Sun,  4 Jun 2017 02:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbdFDCEx (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 22:04:53 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34349 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFDCEw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 22:04:52 -0400
Received: by mail-pg0-f65.google.com with SMTP id v14so2242799pgn.1
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 19:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OLyB6+yRbi2njj57a7eqIHg+UQL6AjdhdMaEO6IYVvo=;
        b=WSFg2R0thQXYSos/S6hnix+sZp4qOJJXe0tgEqWmNHD0GjDkGhwYzJUuYuO/KuhmZ2
         xPb/RBsWX1HZ/jSwnAARhjkj87As7sDy/Gzm6RIqgQ3M4RyaoKDdswz5Pj3XQBiBfGgf
         I64aMpysEW7iSZK5e+mShfrz2uQCLPMqMPkleRhpNDy4nRIdyldXs2AcMEOfL6Tdo8kj
         f2dxdw1LWI7iIf6ttqXe7l0DoiAshfwHmroXwfAPaimQx7BrMuhTE0cv7Z+FuMuQin48
         w1sEjiTTbCXxgLTwnKzXl8upmvKkCoB4ki6kPNAjYFRxCrSQlZP9n13aWvC0fzJ66jRH
         VStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OLyB6+yRbi2njj57a7eqIHg+UQL6AjdhdMaEO6IYVvo=;
        b=VmYoCyJWQcuj5NfZe3OqYNhlzROnK3RP6kPUS4pQGA6rK5zPuGfRe5DgT72DEy6N29
         3yUrFsXb/KmD+bF9S5OLLL6nkPuSgXywz7s2o0AvJQG8Xzpw1WxrcWyNRu+J2ulkKDIW
         84IUloFZ7OQQRdPoupP2a6fREM26UUYrMbadMIHU1e4y3uGnNrrhXiEy70zmlwpozI+2
         ET2j/zZnuwwFZUpMgwDsk2ZLuq4Y4FLm6mM/CI+dgjKhKeZjVmancoVSGs1wn3BOhrqz
         OAkSJYfmlQTzb0nahNWGYzctoFed7mZaEV//4tZeOLEiY+mIMp7LrBS2XWj1cGvjx2xY
         l0pA==
X-Gm-Message-State: AODbwcBLauu8yRVt5FI9LFMN3eJAV/HVjjtG3LwpkG0wdv7iEL/hQJOR
        r43XRlsY6ZSrZA==
X-Received: by 10.99.184.25 with SMTP id p25mr9977262pge.22.1496541891474;
        Sat, 03 Jun 2017 19:04:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:e94b:f1cf:5772:ec43])
        by smtp.gmail.com with ESMTPSA id b72sm51418324pfj.36.2017.06.03.19.04.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 03 Jun 2017 19:04:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
References: <20170602103330.25663-1-avarab@gmail.com>
        <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
Date:   Sun, 04 Jun 2017 11:04:50 +0900
In-Reply-To: <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 2 Jun 2017 14:45:07 -0400")
Message-ID: <xmqqwp8sv77h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But I think a more compelling case is that there may be an ongoing
> operation in the original repo (e.g., say you are in the middle of
> writing a commit message) when we do a blind copy of the filesystem
> contents. You might racily pick up a lockfile.
>
> Should we find and delete all *.lock files in the copied directory? That
> would get ref locks, etc. Half-formed object files are OK. Technically
> if you want to get an uncorrupted repository you'd also want to copy
> refs before objects (in case somebody makes a new object and updates a
> ref while you're copying).

Or "git branch -m A B" is in progress.

I think it all depends on what your "threat" model is ;-).  Do we
assume that many users are "time-sharing" a box and a repository?
If not, i.e. if you are the sole user of a box and a repository on
it, such a concurrent access to make the result of git-unaware copy
problematic will not be in index.lock (after all you are now doing
the perf thing, not editing a commit log message in the repository
used for testing Git), but will be in ref locks (somebody else
pushing into the repository you are *not* currently using from
sideways).
