Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB2E920248
	for <e@80x24.org>; Fri, 22 Mar 2019 05:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfCVFhu (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 01:37:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35336 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfCVFhs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 01:37:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so950606wrp.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 22:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vk2FjwdZOQpH2km+/0HsSTTdFctqv6cjh6FuCmIu+W8=;
        b=lzHwcv3QfiJThh3cTVioVjUjDQHxJYq+ldW9ZW3HXi04WU7xJX3vVUNKRGq/UL0hcM
         gwk9dJJ/WaGzZP62k8j5X7yWZdwojdgHIli5JvBQCmao0u/BcIEN6XfspvzL1C/oDZv9
         VnRrSebKL7UEsHOcN9MQZL5Q9+NRSWU2jPiknUXrPYDP/p/wC6tMlwaNnoi15YACQX1m
         btD4dgqlO8VPVKTGz2Ly7QB9ZDP+bQd/CBScQpJweaWRb/lJHSbR5laI85pQxUvTZZLD
         VxbBZ+gJCKClu6HUP+IBpk/G4+utU/CkuNNhemJPtHYf1gLPb3wZXdrbdd0XQOhWxpxi
         pYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vk2FjwdZOQpH2km+/0HsSTTdFctqv6cjh6FuCmIu+W8=;
        b=mr1aUPsPX0PKAHOgRkyqbqABRlfqr/V1XXU0/yeBySlIEBFkxVyB/2hBNEdGvQAdry
         2USKQauaTDI/f+TnLUFpurYiflJnpbzNZEOIPjJ0Mdw8SUJJ6fYaZB+LzbH5sPASyKcZ
         jEv/OCutxLqiaAkphdWsn2FlLGTEtcVTyr/LISbmaLzDkonUgC/ahU+XMbycdIW9lxZm
         N5ORCjHq89yFwGYLsVRSXAtLocgnKSzWoYXTAhgjJUaQsaxs7r17BMHAw7TUrvw/eQFF
         rJOofUycR1OW9yiVbeoIvgcm6uSogfGFW1XDNKUc1p0/qRHrXy1sKwZn6kRjndOmgAAq
         neCQ==
X-Gm-Message-State: APjAAAV03C4yWQOOSHzNDJUIaKCOH4qZvjdhkrzUSkoQHjOXw3zwoPmt
        bWoYQa/Bsez6vsI+S9CgwK4GToSH3tw=
X-Google-Smtp-Source: APXvYqylOVSyCLRxXEbJlaK3Hul87PJNavEEZ+NxO3ioP4EPV3heRXzNQZ6YlqR5+bn4k5hviYKrgg==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr5197105wrl.262.1553233066066;
        Thu, 21 Mar 2019 22:37:46 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id q16sm7806327wmc.39.2019.03.21.22.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 22:37:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v3 0/4] multi-pack-index: fix verify on large repos
References: <pull.166.v2.git.gitgitgadget@gmail.com>
        <pull.166.v3.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Mar 2019 14:37:44 +0900
In-Reply-To: <pull.166.v3.git.gitgitgadget@gmail.com> (Jeff Hostetler via
        GitGitGadget's message of "Thu, 21 Mar 2019 12:36:11 -0700 (PDT)")
Message-ID: <xmqqy357pizb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Teach "multi-pack-index verify" to handle cases where the number of
> packfiles exceeds the open file handle limit.
>
> The first commit fixes a problem that prevented the LRU-style
> close_one_pack() mechanism from working which caused midx verify to run out
> of file descriptors.
>
> The second commit teaches midx verify to sort the set of objects to verify
> by packfile rather than verifying them in OID order. This eliminates the
> need to have more than one packfile/idx open at the same time.
>
> With the second commit, runtime on 3600 packfiles went from 12 minutes to 25
> seconds.

These reference to the first and second commit might have become
stale across interations, but logically it makes sense---the first
point is about correctness (i.e. do not die by running out of fds)
and the second one is about usable-performance.

But in this round (possibly in the previous one, too?) the "group
objects by packfile" one addresses both points?
