Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEB0C10F26
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 04:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1D120719
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 04:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2Lcvryh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgCWE00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 00:26:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40051 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgCWE00 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 00:26:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so6547276pgj.7
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 21:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gplqngyRdNaK1HQOpc29f9UM3jfD7OeZQBtuocJA3LE=;
        b=s2Lcvryh3Ts3je5BLijqxMfa0p+psBgwY73SBVwOln1Pi0BclMTj9hqp55g4bOCeSw
         b06WhPAFRxme4lKVXd2I9HUXg3r00+vQFigGrD0wXGJ+SkPVa5l7VqfDjx3UwvPq8ERy
         z9RKVmuOhIOrzg7ZjsqkECn40D5ykerc7jMyqi7hbch1rb9gVWxc8WH6X75KkwgOhDy+
         n5mpJ41faMEjW8PZhkqeHR25CHKc7nx8Caul30gVLKRqrHNbuzYNwumH1VQc3PlgkRA0
         IeaW7ZT11SJRTSm36DNO4mk/LBTEVE6LMzaLM8UzU3edW4WDL/UbSXxsOQc/6DEus3f1
         xDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=gplqngyRdNaK1HQOpc29f9UM3jfD7OeZQBtuocJA3LE=;
        b=KvSFRs/PrEwgOIM3OG13M1ituq9s4PciLYiDPiTQ5xadE9BfgQG4s65/H7rOBnI+Iu
         bZtBQ2dBv9FRpqj4RwpsLlLMDk6iWutNMTWYzz72sJXN35wzwRMKRwqwR5cfU3HRRrjV
         57MfpfRsA7+qn+sOp0yBnoWAa6GBXxo+Yk5EU4eSu1DCIzer4nK5oUq0LSpz7nq8Xmo1
         x58QPFBeUg7t+vYHZCHEuMk3lkjvYPHbuL690AO2aCVj6n+qUEcbyXbNryM9IFp9MOzn
         wGvxrG+vhyW82vM0Z6Pp+Dr48g7RVvV4Od11VKrO1J/D7TsPpDTnuU/Ku9gcx37MGuUN
         YxGg==
X-Gm-Message-State: ANhLgQ2rBdOiieMarPl5yWl2D2AfWOTgnb+Z+oyMAr44r+Pkwr6I30j3
        UxOmi9EPHd/NcE8u6k8KRkY=
X-Google-Smtp-Source: ADFU+vvE/9K9QqoLdmSqGooByEXB/OGV6/I3mpwruOYJWClk088L9cJ/9l+zjk4yd1j14vGzBNkWtg==
X-Received: by 2002:aa7:991c:: with SMTP id z28mr22218357pff.294.1584937584769;
        Sun, 22 Mar 2020 21:26:24 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:299:434d:74e4:610e:e237:91fc])
        by smtp.gmail.com with ESMTPSA id a2sm10828928pjq.20.2020.03.22.21.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 21:26:23 -0700 (PDT)
Date:   Mon, 23 Mar 2020 09:55:17 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [RFC][GSoC] Implement Generation Number v2
Message-ID: <20200323042517.GA1258@Abhishek-Arch>
Reply-To: 86eetkrw8p.fsf@gmail.com
References: <20200322093526.GA4718@Abhishek-Arch>
 <86eetkrw8p.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86eetkrw8p.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 09:05:26PM +0100, Jakub Narebski wrote:
> A few comments.
> 
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> 
> > Hello everyone,
> >
> > Following the discussions between Jakub and Stolee [16], it was decided that
> > implementing "Corrected Commit Date With Strictly Monotonic Offset" [17] was
> > more appropriate for a GSoC project.
> >
> > I would like to work on it. The proposal could still use some work but I
> > thought it would be best to get early feedback.
> 
> Thank you for your interest in this idea.
> 
> [...]
> > ### Corrected Commit Date With Strictly Monotonic Offset
> >
> > Jakub later proposed a modification to corrected commit date, _Corrected Commit
> > Date with Strictly Monotonic Offset_ defined as follows [7]:
> 
> I don't remember who originally proposed this idea, but it was not me.
> I have only given it the name you use.
> 

Thanks, noted. Will update it.

> > For a commit C, let its _offset commit date_ (denoted by odate(C))
> > be a commit date plus some offset, i.e. odate(C) = date(C) + offset(C),
> > such that:
> >
> > 1. Offset commit date is greater than the maximum of the commit date of
> >    C and the offset commit dates of its parents.
> >
> >     If odate(A) < odate(B), then A cannot reach B.
> >
> > 2. The offset of a commit is one more than the maximum offset of a parent, or
> >    more.
> >
> >     If offset(A) < offset(B), then A cannot reach B.
> >
> > Since the offset are strictly greater than the offset of a parent, the old
> > clients give correct values for the odate as well. `git commit-graph verify`
> > would fail since the offsets are not generation numbers in all cases.
> >
> > This is an acceptable trade off because users can re-write the commit graph
> > after verify fails.
> 
> One thing to solve is find and implement a way to distinguish between
> commit-graph with generation number v1 (legacy), and commit-graph with
> generation number v2.
> 
> Unfortunately for the time being we cannot use commit-graph format
> version; the idea that was proposed on the mailing list (when we found
> about the bug in handling commit-graph versioning, during incremental
> commit-graph implementation), was to create and use metadata chunk or
> versioning chunk (the final version of incremental format do not use
> this mechanism).  This could be used by gen2 compatibile Git to
> distinguish between situation where old commit-graph file to be updated
> uses generation number v1, and when it uses v2.
> 
> If you have a better idea, please say so.
> 

We could also use a flag file. Here's how it works:

If the file `.git/info/generation-number-v2` exists, use gen2.
Otherwise use gen1.

We can, of course generalize this to `<dir>/info/generation-number-v2`
if needed.

1. It is independent of commit-graph format. 

2. Switching between versions requires creating/deleting a file, which
is simpler than reading commit-graph file and modifying (or removing) a
metadata chunk.

Johannes used a similar flag file during the conversion of difftool [1].

[1]: https://lore.kernel.org/git/598dcfdbeef4e15d2d439053a0423589182e5f30.1479834051.git.johannes.schindelin@gmx.de/

> [...]
> > ## Contributions
> >
> > [Microproject] Consolidate test_cmp_graph logic
> > -----
> > Log graph comparison logic is duplicated many times. This patch consolidates
> > comparison and sanitation logic in lib-log-graph.
> >
> > Status: Merged
> >
> > Patch: https://lore.kernel.org/git/20200216134750.18947-1-abhishekkumar8222@gmail.com/
> >
> > Commit: https://github.com/git/git/commit/46703057c1a0f85e24c0144b38c226c6a9ccb737
> 
> Nice, this is related work.
> 
> Best,
> -- 
> Jakub Narębski

Regards
Abhishek
