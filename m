Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042E41F404
	for <e@80x24.org>; Fri, 10 Aug 2018 20:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeHJWg5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:36:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35404 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeHJWg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:36:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so3068856wmc.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ebtWP/iE4WUIWDSpujbxiU+npSbMoVtbmrBWZFXeeGQ=;
        b=jAXBkoePKn0LbrLSdWMDqIQKo4UX71Lz+0eKWjQop5qPFcfxtXg8t+GW3427LpVQEF
         0nL5iPVdRhcnUVkiwazhjQjNCUye8Lxhqmh1PIjfpkuwILWeo7pDG26iezXBsCbdFMQB
         UzFxsD0mxD1yG8qtIRmaIGj9nsWmfd00cSGXnWUdcWFr2zHY2qX0s6sfBHKpxrwYitLq
         oA0/pOC2KnUFBg5H7YviOMU1aI7EOeDf/pLBGkRtZEk99j8Obb0mGPKyV8aM5aChZNjb
         5uv4yhZoSjEktB3Hze4i8Acfegf3ZJ9HoSgUStIYrrMeYvS9+rYfoI6m+2Ve3hjYYlc7
         UGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ebtWP/iE4WUIWDSpujbxiU+npSbMoVtbmrBWZFXeeGQ=;
        b=UoZEghx26y5X6EdLvjj0oWu8a30y1B4sP5iMdLazqSqIuJ5Cmn2yFFqbMc5UN1HH4e
         QyNPuCTME4su1jpfgm3lkJXkt0RwsD378wNzHABFLPkzhMb+AaxpT9K1qsGBGBRsqJn1
         G8PSh+BHS0d9xkCurgYZKm1URhbDjIbDcndLcxvBPggH4fgk+wJVd7ZjJg2ZgvUoIXSC
         Nj7ljL50NQsrjzdC4NDQuqhx8n/Vaqmo+tWK0st+HyNqTay90I5Fu3i55IChYS0T1cN1
         phz/uPgUZFWuSmCSTrmDkftrJh7ilZoIAQsxkvU5lMA7MjmKa4DeW3B22gIAfZKcfcsJ
         fdnA==
X-Gm-Message-State: AOUpUlGsM6esmTjKl2d41k1cdd6MwY65aA6FDuM0xWJtq56567X9THhA
        meUh+YP9zIJ146wD+5ktApmAVrti
X-Google-Smtp-Source: AA+uWPwn2ijgCnSS3BqIvI06fip+ishpH6w3ZALfpi5ivYSrNh00QDWbTDsVjAAyNWRgehxO3AjkhQ==
X-Received: by 2002:a1c:3f45:: with SMTP id m66-v6mr2274451wma.37.1533931536008;
        Fri, 10 Aug 2018 13:05:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r16-v6sm14943408wru.59.2018.08.10.13.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 13:05:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/4] Introduce a function to lock/unlock file descriptors when appending
References: <pull.17.git.gitgitgadget@gmail.com>
        <pull.17.v2.git.gitgitgadget@gmail.com>
        <a19904682f6984de21fbf77240ff5fb6eed1b744.1533930437.git.gitgitgadget@gmail.com>
Date:   Fri, 10 Aug 2018 13:05:34 -0700
In-Reply-To: <a19904682f6984de21fbf77240ff5fb6eed1b744.1533930437.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 10 Aug 2018
        12:47:20 -0700 (PDT)")
Message-ID: <xmqqzhxu6l81.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +
> +#ifndef GIT_WINDOWS_NATIVE
> +int lock_or_unlock_fd_for_appending(int fd, int lock_it)
> +{
> +	struct flock flock;
> +
> +	flock.l_type = lock_it ? F_WRLCK : F_UNLCK;
> +
> +	/* (un-)lock the whole file */
> +	flock.l_whence = SEEK_SET;
> +	flock.l_start = 0;
> +	flock.l_len = 0;
> +
> +	return fcntl(fd, F_SETLKW, &flock);
> +}
> +#endif

I think people already told you that this is not needed on systems
with properly working O_APPEND [*1*]

	Side note #1: and with network filesystems where O_APPEND
        may not work reliably, fcntl based range locking would not
        work either, so having this would not help.

I saw other Johannes and other Jeff peeking into fixing O_APPEND;
I do not know how well that effort goes, but it would be preferrable
if we can successfully go that route.  

As I said in my review of the first patch in v1 series, I am not
fundamentally opposed to a few "lock here to work around lack of
O_APPEND" and "unlock here for the same reason" calls to limited
codepaths as a workaround, as the damage is limited (that is why I
earlier looked at our use of O_APPEND), but that would be the last
resort if O_APPEND cannot be made to work reliably on Windows.

But even if we end up doing so, on systems with POSIX O_APPEND
working, I think that function should be

    #define lock_or_unlock_for_appending(fd, lock) 0 /* nothing to do */



