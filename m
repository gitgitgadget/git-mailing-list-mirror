Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C6C352A4
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 01:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165C42070A
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 01:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1E9WhVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgBKB6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 20:58:17 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51163 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgBKB6R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 20:58:17 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so589597pjb.0
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 17:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RUMmYjYOIYkS4u5Z3dK4TyO6Wm8YQ56MqJXSOlZ2Bfg=;
        b=g1E9WhVO3cavnEIzgkykpOelVeuaVi8a0jjuPMmlN2o/lZJakLgqhZ4H3N0DTlNf10
         R+P5MAPOkbJrDo3dVoZVin32vv8JFFjJLhLt7h9CPeErREe5URq0bf22eOr17Qw+1XIL
         qZ25cbM6/du9vpIAoQh/JbQuYd7FhVYctZUHCx4BVn5efbjnMbkQjzZTxgsSTs/RM4tM
         KtF+o/EYBQdK/Vx4DvlGjcUePI8lW0/c4deRfohPY3t//iyJsKHmp1WlrdjtTRY2ys00
         DqrDKLJt6gEl1FfqpHwjrBm2wxYTsnBhBf3AOFINOfpR3LQ+r++RIT0CkI6F/QYTEi9n
         l1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RUMmYjYOIYkS4u5Z3dK4TyO6Wm8YQ56MqJXSOlZ2Bfg=;
        b=pin+c9Jf8y54/VsHNzxrHT7lpi61dJVD06G2lYnAGmk2TZt1HrlqCtsPgLWtSGiPy0
         ESGVVzrr21ormnxzhMtkOTTYbkGjN41XJ9t6Wfi3lFE2QmtAFZC1QVTKrYzhFjIKY6hl
         4n+0H+kaOepfMUnx8fzEl0RPMi8QdVca+VKwKrXE7LmhZvywbE88iNLeQSv4sjwZ4IZz
         n1aLSFXHsTKnjUtzhOMxPSafbdfylvmHX3/guu+Y4YD7eQPk2JZtXvdJbE4hBQcEiNfV
         6bvJK304E11GVoRsReZhN5jKy9eYvmMh7n4G83cGAC6UiDe5GliKKkTxghthV1IdH6AX
         jANg==
X-Gm-Message-State: APjAAAUG7k5DpUNY3b2sAga2znpEuOSOhDwUdas3PL0QBHQGGftjBj5I
        stZe+EYYIpNIysJDCbzplKwhE34Ibec=
X-Google-Smtp-Source: APXvYqyl/fQxCqOFOwAKVhldU3CxK2bo8yy+Zn3iqF7xTmLEdkrts3KDYfOsg74cEfx52mSw22TGtQ==
X-Received: by 2002:a17:90a:cb83:: with SMTP id a3mr916830pju.80.1581386296016;
        Mon, 10 Feb 2020 17:58:16 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 10sm1686326pfu.132.2020.02.10.17.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 17:58:15 -0800 (PST)
Date:   Mon, 10 Feb 2020 17:58:11 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v7 04/10] config: make scope_name non-static and rename it
Message-ID: <20200211015811.GE190927@google.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
 <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
 <14b0f278196ab9ab130402c2ef79adb0543655ef.1581294660.git.gitgitgadget@gmail.com>
 <xmqqd0am1fsc.fsf@gitster-ct.c.googlers.com>
 <CAOjrSZvm-3qVw4880MeDVk59ToCwp9vMC1zFp-SYaDsFd3Y=8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOjrSZvm-3qVw4880MeDVk59ToCwp9vMC1zFp-SYaDsFd3Y=8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 10, 2020 at 07:30:22PM -0500, Matt Rogers wrote:
> >
> > How are you reviewing the patches in your own series before sending
> > them out?  This round is better than the previous rounds where we
> > didn't have a matching change to the tests so "make test" may not
> > have passed in the middle of the series, though...
> >
> 
> I went through each patch individually using rebase -i and built/tested it.
> Although just to save time I only did t1300 and t1308 since I believe those were
> the only ones that should be affected.  I can write a script that
> would run the whole
> test suite overnight for me and make sure the series shakes out okay,
> if you'd like.

Not sure whether you intend to do this or not, but to maybe save you
some scripting, I do this like so:

  git rebase -x \
    "make -j16 && (cd t && prove -j16 -v --shuffle t[0-9]*.sh)" master

If the tests fail, the rebase is paused, which can be understandably
disappointing if you walk away from it overnight only to have it fail
after 10 minutes, though. :)

 - Emily
