Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A288720248
	for <e@80x24.org>; Mon, 15 Apr 2019 04:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbfDOERE (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 00:17:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36628 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOERE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 00:17:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so18393139wml.1
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 21:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JI8/ax6KE2sbRPYuxKDRRV5ufdu5LherGt3ohzg62W0=;
        b=pRKmYdx1CTY4cnUIrzH+8/mGzrhuri4cRRRxMSXtdBOv3uuTjwtqxny/TSdC4+icI3
         73h3yrejSOzjB/RJBCk1DA0xl+q6zVI32R0lSqfXbzC/PBQUqjq+jIpvtyjpBapJYz4t
         0sat6GUE6WvY6s47LOqC8Z/20cpSkpq51/CPqP+d4uWE2cTRXUedxftunqrrIb8i7yd3
         uXTTmsLqm5lG4fe3G5FAhpjEl74hGm45FaZkszR4B+FI4JaeGWS/MM0AHS+MYg88uG8h
         2pdvoG6UqnpmkGvErGxtHShg8etxUsTzfPg6OZb8UuQSKhsp9mWqk9VTp3kK9eYgH205
         +WUQ==
X-Gm-Message-State: APjAAAVmqHbre3/jpGBtDmPftg/ycz4s7JVKju79QrVXJ2ZxJGuQvy71
        7ftg8SV/aHKzBJ1m4TcZQit2GowABLZBMpvEqLo=
X-Google-Smtp-Source: APXvYqxx3jpVZMsK7HJQVEoA258+ri/DOGbvI2SU61CWDtIt7ODJEhVEkul0FWMwWnU6/APWOpFeNfzx32+dICHO8i4=
X-Received: by 2002:a1c:c8:: with SMTP id 191mr19570080wma.44.1555301822324;
 Sun, 14 Apr 2019 21:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.168.git.gitgitgadget@gmail.com> <31d8e43cbfaec36f662006a711b64bca47009e59.1555070430.git.gitgitgadget@gmail.com>
 <CAPig+cTiF-9+pXnx19y0PUs3Nwek7N2cEg2r2jAPzEXPTvpxpA@mail.gmail.com> <xmqqpnpoufp5.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnpoufp5.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Apr 2019 00:16:51 -0400
Message-ID: <CAPig+cQ3drZ+iE=SkSXTdHVfTxLkPTi=VTJCMJn7LKLxcpC-pQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] docs: exclude documentation for commands that have
 been excluded
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 14, 2019 at 11:10 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> +Documentation/GIT-EXCLUDED-PROGRAMS: Makefile config.mak.uname
> >> +       $(QUIET_GEN)echo "EXCLUDED_PROGRAMS := $(EXCLUDED_PROGRAMS)" >$@
> >
> > Should this rule also have a dependency upon "config.mak.autogen"?
>
> That is probably a good point.
>
> > Perhaps like this:
> >
> > Documentation/GIT-EXCLUDED-PROGRAMS: Makefile $(wildcard config.mak*)
>
> I'd rather not let changes to "config.mak-", which I keep in my
> working tree (untracked and disabled copy of config.mak, that can be
> readily activated by renaming), be part of dependency rules.
>
> If we know 'autogen' is the only dependency that optionally can
> exist, then depending explicitly on $(wildcard config.mak.autogen)
> would be a better alternative.

When composing that email, I originally wrote $(wildcard
config.mak.autogen) as the suggestion but changed it to the looser
$(wildcard config.mak*) when I realized that the developer's own
config.mak probably ought to be a dependency, as well. Taking your
objection into consideration, we could mention both explicitly:

    Documentation/GIT-EXCLUDED-PROGRAMS: Makefile \
        $(wildcard config.mak) $(wildcard config.mak.autogen)
