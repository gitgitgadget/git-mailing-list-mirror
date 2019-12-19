Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F349AC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 23:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70772467E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 23:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHI+q1UV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfLSXSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 18:18:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37619 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSXSD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 18:18:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so4141008pfn.4
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 15:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cUz246jH7pKU81wldxu/TXXgTWgh72JHib7V6pHxwRs=;
        b=gHI+q1UVy+wImB9gQYZt9DbvRoGKScoRyf6iGl1qyRdbJ5LUD6vHZisZd4nfHVB76o
         iNQgcu6NUJvHMRIGGd3GOV/GzKOE07E43Yn5XUPGbk5d09T3dKYub0spYakk4nZCfwET
         FgNSUiTifRFi3QwsmFk4/fGpouLGHShuCiYoLBJyO+EJ7weJ0IxpsfkgnTNWdgnUeXui
         8iEISksLPN/0jttWmvVngndmf6QBOdgtD1u8tvH4/5LxngrnBffYt6aWvbr0kFKihu2p
         pmtTKlU7A3EG939re1LOoS1uzcjDHvdOW8lgB76iGp6zwj2VbLG25KBWGlZUDq8Qgm/d
         2Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cUz246jH7pKU81wldxu/TXXgTWgh72JHib7V6pHxwRs=;
        b=nHkBRo/l899rcw9WxjDEH5uVm01UsNt5d6/2zSEes0MtAMcoYMr/S1m5STWDiWrBgD
         ljnF6FBVS0MQb1ROLI1mEmlpQO5dp/nK9HSmkq8iiBot6Ji+cMcDF441P2ibVqQ/Cvk/
         snCTOj6Y9onsCuWBl9dfxpOUpEkWIeP/gL/vL3uVfm4z22NoWARcucWpEVMPowE4+7kW
         3lDVnwpKtmtfYrMkUicdZqDvtwta47ojqD4Y+IDCObqwIvB+aRJ8ytij7XL7gfeiQaGh
         Q2mjTSO6B2xYrXqvb4zxJXfF5K6aiMpOX2PVZufe3W7FRpNONYTUmPXsNGItimD+nzeu
         WWQw==
X-Gm-Message-State: APjAAAU0n0fFSzh3F5kv63tgiYp7rLQ7ZdUKO/F8Q3EJoPy//irt1760
        wJs+4827SvDo84uYd3blB6I=
X-Google-Smtp-Source: APXvYqyT7iESAAiLVOnGRCxg+BcRrDL/ZofRr/nyR6zbHWSxfpaz45BlHL5sEhB1o/gXOyUS7bpSfQ==
X-Received: by 2002:a63:e30a:: with SMTP id f10mr11395230pgh.331.1576797482986;
        Thu, 19 Dec 2019 15:18:02 -0800 (PST)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id f81sm9926521pfa.118.2019.12.19.15.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 15:18:02 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:19:40 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/16] t1501: remove use of `test_might_fail cp`
Message-ID: <20191219231940.GA67903@generichostname>
References: <cover.1576583819.git.liu.denton@gmail.com>
 <cover.1576794144.git.liu.denton@gmail.com>
 <83e47748bc9c541c725f6c42c553b1a69fd717ac.1576794144.git.liu.denton@gmail.com>
 <CAPig+cQuPDDun3NxnTwvmjo9zvPzSq+5f2utkHkS0f1c1Nwbvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQuPDDun3NxnTwvmjo9zvPzSq+5f2utkHkS0f1c1Nwbvg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, Dec 19, 2019 at 05:52:56PM -0500, Eric Sunshine wrote:
> > diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
> > @@ -350,7 +350,7 @@ test_expect_success 'Multi-worktree setup' '
> >         cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
> > -       test_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
> > +       test_non_git_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
> 
> I can't say I'm a fan of patch 1 introducing the function
> test_non_git_might_fail() for this one particular case. I'd rather see
> this case follow existing precedence by being written this way:
> 
>     { cp repo.git/sharedindex.* repo.git/repos/foo || :; } &&
> 
> which is the idiomatic way this sort of thing is handled in existing tests.
> 
> While it's true that it may look a bit cryptic to people new to shell
> scripting, as with any idiom, it's understood at a glance by people
> familiar with it. That bit about "at a glance" is important: it's much
> easier to comprehend idiomatic code than code which you have to spend
> a lot of time _reading_ (and "test_non_git_might_fail" is quite a
> mouthful, or eyeful, or something, which takes a lot more effort to
> read and understand).

The reason why I chose to do this was because I found myself writing the
above many times in (currently unsent) later test cases that I cleaned
up. As a result, I felt like it could be wrapped up more nicely with a
helper function. That being said, if you think that open coding the
idiom looks nicer, I can reroll to inline it.
