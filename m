Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6D0C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 20:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCDE20735
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 20:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNvvhyU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCVUFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 16:05:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45886 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgCVUFc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 16:05:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id t17so1535627ljc.12
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LAqKxGLbyv5Oe6HCnL7hkde+T3TayBSFPU1gGFci3eg=;
        b=mNvvhyU0jKPVJU2FMObMDVQM5jVeeTS+ysJM0oFoAKJXtNe3CFFRC/4WiGe/p3JfhP
         WDuxhg86Y4rpWZBsQLXFDSonPTaRdYeQAYo7cXFo/r9hNRVFpHqz2+ka4baxOiUO4ztd
         Rl+RImKRog3rift1oY92r0HRmj7YY1UZ/ViGiqf5flYWFabc+HCNgIsNO9ZOqqiTe588
         P+9EQaaqJfe/VBGsPPKEpS6wMTYpCi/U1uo4pxLzDYwoQFWQm/BPxAQVPomtyYHg4EVQ
         MzVAfuW5Fp9izsmrzyXB1SK5u9v95r0MTpBqYI4Lf1jQ58B2MS+ami8XqY6QeML2VpsN
         G++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=LAqKxGLbyv5Oe6HCnL7hkde+T3TayBSFPU1gGFci3eg=;
        b=pQJAQf1gtLP5dcReB36gF0ir8kipOYAqsutEIFoHB5kSmugpIPQHoQ0JY+WfunQ0tJ
         kvbbQGpupJ2wl/fFZbHNa3VS2l/qYDbHCaRt19mH0WSHgWYwIrV1jJzMmSSCP5du8iaJ
         TGc55iwu3MTtZ+NWH2QB4ScR3vqTQJjfikyyDp1QFu6+HWZGzaHxlfaDGURbeIJo/w7v
         78v2uyu5rGU7uCX3XBM0q4khvysuyw3w0IW3N+M1LsqWosAReEEJ5nS9ua/RFi1ZLteN
         eoQft4cjSQz9itjD1HIG9rjj5HQYWFA3hZbjhP16dS4P2GBhDPWhyKRiG+XpoYy2T8iE
         TpLw==
X-Gm-Message-State: ANhLgQ2BeD1Kji7I6HilZTHlqVU07UMAsRmF0dKRRZqXRPnvQ1sPoBIB
        KNvM0rm8D4OIB9NJqTtIu7M=
X-Google-Smtp-Source: ADFU+vurO+D/NxDp/njSOfYHHeURqETjRe672hWJ1Xv+IMIvnw1ZJG0JT/QPv2HjOlT70a6AY7xSbQ==
X-Received: by 2002:a2e:a554:: with SMTP id e20mr11225746ljn.88.1584907530203;
        Sun, 22 Mar 2020 13:05:30 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id f2sm5621503lfp.30.2020.03.22.13.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 13:05:29 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC][GSoC] Implement Generation Number v2
References: <20200322093526.GA4718@Abhishek-Arch>
Date:   Sun, 22 Mar 2020 21:05:26 +0100
In-Reply-To: <20200322093526.GA4718@Abhishek-Arch> (Abhishek Kumar's message
        of "Sun, 22 Mar 2020 15:05:26 +0530")
Message-ID: <86eetkrw8p.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few comments.

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Hello everyone,
>
> Following the discussions between Jakub and Stolee [16], it was decided t=
hat
> implementing "Corrected Commit Date With Strictly Monotonic Offset" [17] =
was
> more appropriate for a GSoC project.
>
> I would like to work on it. The proposal could still use some work but I
> thought it would be best to get early feedback.

Thank you for your interest in this idea.

[...]
> ### Corrected Commit Date With Strictly Monotonic Offset
>
> Jakub later proposed a modification to corrected commit date, _Corrected =
Commit
> Date with Strictly Monotonic Offset_ defined as follows [7]:

I don't remember who originally proposed this idea, but it was not me.
I have only given it the name you use.

> For a commit C, let its _offset commit date_ (denoted by odate(C))
> be a commit date plus some offset, i.e. odate(C) =3D date(C) + offset(C),
> such that:
>
> 1. Offset commit date is greater than the maximum of the commit date of
>    C and the offset commit dates of its parents.
>
>     If odate(A) < odate(B), then A cannot reach B.
>
> 2. The offset of a commit is one more than the maximum offset of a parent=
, or
>    more.
>
>     If offset(A) < offset(B), then A cannot reach B.
>
> Since the offset are strictly greater than the offset of a parent, the old
> clients give correct values for the odate as well. `git commit-graph veri=
fy`
> would fail since the offsets are not generation numbers in all cases.
>
> This is an acceptable trade off because users can re-write the commit gra=
ph
> after verify fails.

One thing to solve is find and implement a way to distinguish between
commit-graph with generation number v1 (legacy), and commit-graph with
generation number v2.

Unfortunately for the time being we cannot use commit-graph format
version; the idea that was proposed on the mailing list (when we found
about the bug in handling commit-graph versioning, during incremental
commit-graph implementation), was to create and use metadata chunk or
versioning chunk (the final version of incremental format do not use
this mechanism).  This could be used by gen2 compatibile Git to
distinguish between situation where old commit-graph file to be updated
uses generation number v1, and when it uses v2.

If you have a better idea, please say so.

[...]
> ## Contributions
>
> [Microproject] Consolidate test_cmp_graph logic
> -----
> Log graph comparison logic is duplicated many times. This patch consolida=
tes
> comparison and sanitation logic in lib-log-graph.
>
> Status: Merged
>
> Patch: https://lore.kernel.org/git/20200216134750.18947-1-abhishekkumar82=
22@gmail.com/
>
> Commit: https://github.com/git/git/commit/46703057c1a0f85e24c0144b38c226c=
6a9ccb737

Nice, this is related work.

Best,
--=20
Jakub Nar=C4=99bski
