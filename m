Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3811F597
	for <e@80x24.org>; Fri, 20 Jul 2018 22:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeGTW4M (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:56:12 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43234 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbeGTW4M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:56:12 -0400
Received: by mail-wr1-f46.google.com with SMTP id b15-v6so12504299wrv.10
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 15:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SHkijcODI/R0o+hEFZZu6B+Rt/Uswhw4JC+ossoStAE=;
        b=n7KqNBxfGiJjSLVIbAzgDdmTipiUh1brafN2mqbEEnP3Z3CFdCwGFZIr97E8UfN7Ma
         jUtjbqc7j/iSwK+AYJGldTMPKA92RIcUcF4lWEGbaP04iv1xrOogtaEGvtTSyB4X712R
         YyRBiW6DuKSbWMGx14V8Z/9OCx0m2C/U103FK7qnqokVL9a5XPLYImqXIriTaA7aYyNH
         jumrFBxAQ8u2waxggs6IcH+VI+D0c8lEzkkoP8jF+81qm8twR2m972TqeDuHse17QvgE
         g+X1QzoQxKjU8AHpgKkN308K53gaZrx9ldl5kjzm7boNilGxZKyEOfA7hvA+EzfIg64G
         yH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SHkijcODI/R0o+hEFZZu6B+Rt/Uswhw4JC+ossoStAE=;
        b=JvYHYnPAwei6d/ObgpBIZa8IwepoJO1vYPIYOfSL5zlmc1qJ/oyK30UDbSrX2TWRcm
         7Le+0kyHwfikxOXHfMWq3cdN/Taf9eGQUghs5zHEPEXdgfUiDebSRiZqsMODOR+nJ8XN
         DSWUmWZwNut704HCq/RcuIm4lyHEheXhYvS8PRlB6SPGtt2+CdSdN0jyBgt1FbFnQ/Or
         yuf0rmA8dfq/rJTPiTZahpksKv3ldtJjTJpoJ946Wiuk8feV/BzcmcNLDG0fb3JvGfGm
         pGq8wNxXP4C2p3gRtrxXSkm3SN0sfJnmodzXC9plXEZ1JRd2Acc+7GUeGtq0KXFZp+xR
         Yqsg==
X-Gm-Message-State: AOUpUlGwJZ1pusIuxtantqvLCDDS+JV9RZuRPATZ3vuSsahA7D+dsWDQ
        QCC+dmlMJD7gidpOo4G2y5k=
X-Google-Smtp-Source: AAOMgpfgk+3sPW+lKiuhMSmiT6p0cWApQXfHc5p5ACzWONi8QDOXf2Vn3IbqvkAUlwtvifF6MAfOZA==
X-Received: by 2002:adf:a211:: with SMTP id p17-v6mr2587667wra.196.1532124359176;
        Fri, 20 Jul 2018 15:05:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 185-v6sm3742312wmh.22.2018.07.20.15.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 15:05:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [BUG] merge-recursive overly aggressive when skipping updating the working tree
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
        <CABPp-BF+Vx8YT2KAJQ+szbkYExv-_o5E-ZkywgvzsHWR0QvVEg@mail.gmail.com>
        <xmqqsh4da9wd.fsf@gitster-ct.c.googlers.com>
        <CABPp-BE_OHxMqmhJ8BisG6HFpGQjsPJ1AE4G9m5bpJWznkq-1Q@mail.gmail.com>
Date:   Fri, 20 Jul 2018 15:05:57 -0700
In-Reply-To: <CABPp-BE_OHxMqmhJ8BisG6HFpGQjsPJ1AE4G9m5bpJWznkq-1Q@mail.gmail.com>
        (Elijah Newren's message of "Fri, 20 Jul 2018 14:42:35 -0700")
Message-ID: <xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Ah, okay, that's helpful.  So, if there are conflicts, it should be
> free to clear the skip_worktree flag.  Since merge-recursive calls
> add_cacheinfo() for all entries it needs to update, which deletes the
> old cache entry and just makes new ones, we get that for free.

Correct.

> And conversely, if a file-level merge succeeds without conflicts then
> it clearly doesn't "need to materialize a working tree file", so it
> should NOT clear the skip_worktree flag for that path.

That is not at all implied by what I wrote, though.

If it can be done without too much effort, then it certainly is
nicer to keep the sparseness when we do not have to materialize the
working tree file.  But at least in my mind, if it needs too many
special cases, hacks, and conditionals, then it is not worth the
complexity---if it is easier to write a correct code by allowing Git
to populate working tree files, it is perfectly fine to do so.  

In a sense, the sparse checkout "feature" itself is a hack by
itself, and that is why I think this part should be "best effort" as
well.
