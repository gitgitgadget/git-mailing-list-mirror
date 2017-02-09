Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A674B1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbdBIVex (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:34:53 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35921 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753107AbdBIVew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 16:34:52 -0500
Received: by mail-pf0-f194.google.com with SMTP id 19so957387pfo.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 13:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QKzNQcAFS7EQXaqQCdBJ7A/KrxbdG540CBl9J6AGULA=;
        b=Y4h4Y/bMLEoxvdp9ut0R1DDAVJfq9pT0G6lV8nHyg1UN/KlL2UrQqMBX6Mb3XaFfPV
         wbhiOq3rxPwniIFAE1anOIXNvsFMucX5IxuTMWB6W/AC/G/spph9GElJz67/e3eOf1cG
         izGcUSZeIafCiBTPPAlemshDE78ju8ioRGY3enrd4Ykp7tkstWa71t70CHdumH8CBmzx
         Yz9BRtxlt1rq6Lhihlyxi1xPSQ2iDVZbMcN3LzEJ0mbRKm47JRSjCi3qr2s2OLA8RkvM
         Am6lKh1RO7K51d+vBAoX3middnIDc2vNHL24yha9V2/R5uJpPlzQDD+9iZMRZFbgySKM
         Sd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QKzNQcAFS7EQXaqQCdBJ7A/KrxbdG540CBl9J6AGULA=;
        b=N2HFVzTbj+lJihMWuN0Ugyow3eTjhDibCcvfgV4pI+SpOMJQG4ZmcfzfJhmbplWOnz
         R/ZRbGEwJTA4zPaegIH1Unqt9CzX5YHX+/FI2Yol2j/vT5sVY8bIq7ZGiOZLy///jsT1
         Cc4VT41bI4rgegbdrCvsVbwbrK8J8nnAup8NL1FYjKiuYCIOq5M0HhTcDWWFCIEdOyct
         mv/DARuGVLz6DBIeKuR38shFlvrn4ka8H/rgEhFRPJJ6uxVeDuh5zYQPD+Z4/ePsADih
         PpxdUZsYExTa5bZgQNFfmTI96RwY4m+vONAlDawjN8UVlgQorhpkvQGolV7XBCnrFMOE
         VqjA==
X-Gm-Message-State: AMke39lmAPH/INfhrTSzpF5SliYk4jpUninG83mKxPouWWKbDeHLJ/e4tifurL8iP0XO9A==
X-Received: by 10.99.175.87 with SMTP id s23mr6459718pgo.184.1486675999013;
        Thu, 09 Feb 2017 13:33:19 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id 21sm3206145pfy.4.2017.02.09.13.33.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 13:33:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a subdirectory
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
        <CACsJy8CigsWjAq5cmJ=cbBmj=DdJtHdMKxmoifftuz9+9kqJiQ@mail.gmail.com>
Date:   Thu, 09 Feb 2017 13:33:17 -0800
In-Reply-To: <CACsJy8CigsWjAq5cmJ=cbBmj=DdJtHdMKxmoifftuz9+9kqJiQ@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 9 Feb 2017 16:48:20 +0700")
Message-ID: <xmqqshnnnj6q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Relevant thread in the past [1] which fixes both --git-path and
> --git-common-dir. I think the author dropped it somehow (or forgot
> about it, I know I did). Sorry can't comment on that thread, or this
> patch, yet.
>
> [1] http://public-inbox.org/git/1464261556-89722-1-git-send-email-rappazzo@gmail.com/

Thanks for a pointer.  I see Mike responded to this message (I
haven't had a chance to read and think about it yet), so I trust
that you three can figure out if these are the same issues and what
the final solution in the longer term should be.  

I have no strong opinion for or against a "longer term" solution
that makes "rev-parse --git-path" behave differently from how it
behaves today, but I am not yet convinced that we can reach that
longer term goal without a transition period, as I suspect there are
existing users that know and came to expect how it behaves, based on
its today's behaviour.  Other than that I do not have suggestion on
this topic at the moment.

Thanks.
