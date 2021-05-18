Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93B6C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 21:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FD061209
	for <git@archiver.kernel.org>; Tue, 18 May 2021 21:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352387AbhERVL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 17:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbhERVLU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 17:11:20 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B27EC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 14:10:01 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso9903753otn.3
        for <git@vger.kernel.org>; Tue, 18 May 2021 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=VBIXMOfMYnE3wqIWvV0VtDduwiTOZjnJT4OaYQTzUBw=;
        b=dRt6Nkib0coGaj+hlnsJ2IMdfku7HtOS0ttSwmhdULR8ubaQEMtLOTgOLJxbvsWJHP
         8fW29JyjptDJGm08ufyO4dUUGH15TRTFAjleBvjREkzoMGZXWHgQTxHaE69qbvCEc1Q1
         2apnfPzFP/4CW0SiaSiTgx1RIIezZ4yCH1QLGx/FriY1ECeWZ28krS+rz/lrVjNZPK/x
         Ozs+cZplE98HfqUTFbFwFf/BryqNE3NvXx5xolU/Dg01Ir7WTvyb9PiZuj6pixH7EKdW
         DH8I3OJlYljv6/Z/KgH5jeQtlsnhB0gtlAEMBeoP9LKX8ZFbDIVt4vJ+FzHq0mYFHhGO
         WzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=VBIXMOfMYnE3wqIWvV0VtDduwiTOZjnJT4OaYQTzUBw=;
        b=exv1/lSLqtLT+2h3/vmVP+EoRse7Wy6bPttmdjvhPcwvAHKU/66uzMICxFTcYidK1Z
         typ6FOMfmi5yXmjAiqzLhsBNuiqet8AYYfdxLV+xBm3fxdEQ/yDaMB95D45wmVLDqqot
         NZ6ShQVD4IMFmjJ20NOlnnF9F6R6AVeBp1Fm+k4Q2TE8MkB7vO9WioaHGRRQthYU+JHl
         wIdN14krEVTSzBL+tn32K4AhtoyIuTD5/KTXmyNLH4s1hTBxICYwBlnXUy9td3LTUuuJ
         2QHAb2BZeqzQVJa5LFNNXra0wjtJXj9LPGgJ1a+itNFy0YDS+gMXo5h8j4bMhS5WHD1s
         Xa3Q==
X-Gm-Message-State: AOAM533l1RHjRFl/mHM0WXbW0QnAzFJAg98zeU+QVdzcGXzt5xMkPAzX
        +xOiTX31fNYUqQKiO1BBr4Q=
X-Google-Smtp-Source: ABdhPJzAqwcqqB8hCo58Ogkv1E4V5IqLCyufQfFzP5XcAScZrRCBRzuLd25D+/oPBpgJKV0vOF1VnQ==
X-Received: by 2002:a05:6830:445:: with SMTP id d5mr5802508otc.331.1621372200936;
        Tue, 18 May 2021 14:10:00 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id f30sm3967844ooh.10.2021.05.18.14.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 14:10:00 -0700 (PDT)
Date:   Tue, 18 May 2021 16:09:58 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Richard Hansen <rhansen@rhansen.org>
Message-ID: <60a42d26c91ed_2c10208e3@natae.notmuch>
In-Reply-To: <YKO3eeNPxCwvIkEw@coredump.intra.peff.net>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
 <xmqqpmxp6u13.fsf@gitster.g>
 <60a2daa57d8a6_13c370208f3@natae.notmuch>
 <YKMhqZNhamnKqWfi@coredump.intra.peff.net>
 <60a34a7616cda_14d1bc20818@natae.notmuch>
 <YKNk+5k3hKW/xPBZ@coredump.intra.peff.net>
 <60a3a808d7eeb_151987208bb@natae.notmuch>
 <YKO3eeNPxCwvIkEw@coredump.intra.peff.net>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, May 18, 2021 at 06:42:00AM -0500, Felipe Contreras wrote:
> 
> > A random github.com link doesn't show anything. The instructions I'm
> > talking about are the **first** thing the site gives to users.
> 
> I would think the first thing most users see is _somebody else's
> repository_, full of commits, that they then clone.

All the tutorials I've seen start with `git init`. If you want to learn
git starting from a monstrous repository such as Chrome OS is probably
not a good idea.

And yeah, if you assume most users are professional programmers, then
yeah, that's probably true. But that's an assumption.

Many users are students, others are amateur programmers, others might
be using git to track something other than code, like writing a book, or
their dotfiles.

Experts often forget what it is to be a beginner.

> > > People clone a lot more than they create new repositories.
> > 
> > Depends what you call "people". If you are talking about professional
> > software developers, then maybe.
> > 
> > But they are not the only users of git.
> > 
> > Do you have any stats?
> 
> On one of GitHub's servers (selected randomly), there were ~300k clones
> in the past 24 hours. In the same time period on the same server, there
> were 1780 new repos. Even that's overstating it, since some portion of
> those are just forks of existing repos (so the user probably either
> cloned their fork immediately, or was already working on a clone of the
> upstream fork, rather than having run "git init" locally).

How do you distinguish a git clone from a git init + git remote add + git
fetch?

> > > I don't think that proves anything except that your workflow is
> > > different than mine.
> > 
> > Exactly, and we cannot assume most people follow your workflow. In fact,
> > I'd say your workflow is probably one of the most atypical in the world.
> > You know tricks 99.99% of users don't know about, in fact that probably
> > 99% of git.git developers don't know.
> > 
> > It is sufficient to acknowledge that there are different workflows.
> 
> I'm not making some bizarre claim about workflows. I'm saying that
> people commonly use "git clone" to get repositories. That really doesn't
> seem controversial.

It's not controversial, but it's also not necessarily true.

On what are you basing that claim?

> But you know what, I've wasted enough time on this thread. If you want
> to believe that people don't use "git clone", go for it.

I'll parse that as an answer to my quesion:

> > Is there anything that would falsify the premise?

"No, there's absolutely nothing that would falsify my premise".

If there's no way to falsify a claim, then there is no point in even
entertaining that claim.

Cheers.

-- 
Felipe Contreras
