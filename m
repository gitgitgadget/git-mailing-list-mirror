Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FFFC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 19:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4993B20770
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 19:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veUnDRXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgIOTJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 15:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgIOTJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 15:09:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF71C06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 12:09:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so3844705ljk.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 12:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=3DN0Nvni8GTPAdCarVUPscufaSwWN3HtM50HftKDvBg=;
        b=veUnDRXzeQiOgMV2D02cphucP+FkvmCV/5EhNfc6nbmSoP1RnEUoTI1S8NIqU5Y2sL
         BskOPcctbyrKgfiH24REr/QOQFugoKMKrZkzF3YuYGBRaCDKYes1AOhoM35aJw6DkFQi
         baHfD8iTgSdcSU7A55P4LO7ZIm2be8qDBxAN9RQOOyevyXdDPfuCOD9/3Ccz6+IEqnxN
         RzBp4yBh4pCG9knMLfYFRSJplUCEkSt1Ejk0Aa3Rg+W0L8d/6Jmvfl3N6cZi2WOE0lIn
         L7v1WpCEZQ6XaTiq98yxkAcP7xLGYH8ZjzPffa6g44zagxZ1sL59nQRSrtakbzRQbfhz
         C8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3DN0Nvni8GTPAdCarVUPscufaSwWN3HtM50HftKDvBg=;
        b=o/NAj63LgvPc6A9I8GPJcVyNf0dgquPIx7p3IINLIrM/NkkABT/NTNU17oM9nZyZ8L
         coijYqLN6OB/6Re6A85EEx0boaVPQXK+MLZx6qHIme8zOj3mRl2o/JKgXaMAS9y6SfSN
         MugXgVE5SCvLK05RXUnacdvRmRlfU3dNW3RuV+P9aUdCJgOe8z7lWvwYYr2S8M+7iZw4
         YAcO/THKdjNN4qjK1Vvttu8L/Y9uxP4cXjFK15BkcdOzln5rG+BekRkyJWfEmy6xbSUI
         ttPKd0AJbzB77sTCTzljGAOJ0ZU9eRCJzUmdavQvDKk8vx8sWnHmPFabonwq3eFh+vZK
         cj8A==
X-Gm-Message-State: AOAM532y0AvRtxLc3D11ABVfu1Sbwm7ZEiyqfD1TiMNdjAEzTzw8RXjg
        eTFOI7O5up8fiMPxnLNLSQc=
X-Google-Smtp-Source: ABdhPJx5+JwtDADnvZ7mNI0/nU22GY4EPwzIJRUlnq6psbLPIt9y5i4o5h1Fs6jvWdswM06svg23WA==
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr7755342ljm.149.1600196967191;
        Tue, 15 Sep 2020 12:09:27 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id c7sm4135600lff.116.2020.09.15.12.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:09:26 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com>
Date:   Tue, 15 Sep 2020 21:05:18 +0200
Message-ID: <85ft7ivp1t.fsf@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Junio C Hamano <gitster@pobox.com> writes:

> * ss/submodule-summary-in-c (2020-08-12) 4 commits
>   (merged to 'next' on 2020-08-17 at 9bc352cb70)
>  + submodule: port submodule subcommand 'summary' from shell to C
>  + t7421: introduce a test script for verifying 'summary' output
>  + submodule: rename helper functions to avoid ambiguity
>  + submodule: remove extra line feeds between callback struct and macro
>  (this branch is used by ss/submodule-summary-in-c-fixes.)
>
>  Yet another subcommand of "git submodule" is getting rewritten in C.
>
>
> * ss/submodule-summary-in-c-fixes (2020-08-27) 3 commits
>   (merged to 'next' on 2020-09-02 at 7f959811b8)
>  + t7421: eliminate 'grep' check in t7421.4 for mingw compatibility
>  + submodule: fix style in function definition
>  + submodule: eliminate unused parameters from print_submodule_summary()
>  (this branch uses ss/submodule-summary-in-c.)
>
>  Fixups to a topic in 'next'.

Those are patches that are part of GSoC project of Shourya Shukla:
'Convert submodule to builtin'.

> * hv/ref-filter-misc (2020-08-28) 8 commits
>   (merged to 'next' on 2020-09-02 at 9a8bb84f20)
>  + ref-filter: add `sanitize` option for 'subject' atom
>  + pretty: refactor `format_sanitized_subject()`
>  + ref-filter: add `short` modifier to 'parent' atom
>  + ref-filter: add `short` modifier to 'tree' atom
>  + ref-filter: rename `objectname` related functions and fields
>  + ref-filter: modify error messages in `grab_objectname()`
>  + ref-filter: refactor `grab_objectname()`
>  + ref-filter: support different email formats
>
>  The "--format=3D" option to the "for-each-ref" command and friends
>  learned a few more tricks, e.g. the ":short" suffix that applies to
>  "objectname" now also can be used for "parent", "tree", etc.
>

Those are patches that are part of GSoC project of Hariom Verma:
'Unify ref-filter formats with other --pretty formats'

I'd like to point out that latest series of patches by Abhishek Kumar
which are final part of 'Implement Generation Number v2' is at what I
believe is next to final iteration:

  "[PATCH v3 00/11] [GSoC] Implement Corrected Commit Date"
  https://lore.kernel.org/git/pull.676.v3.git.1597509583.gitgitgadget@gmail=
.com/T/#u

It is waiting for the decision on *how to implement storing* new
generation number in the commit-graph file: should we store corrected
commit date directly as 64 bit value, or should we store corrected
commit date offset as 32 bit value with overflow handling?

Switching from 64 bits to 32 bits halves the size of the GDAT
(Generation DATa) chunk, but decreases the size of the commit-graph file
by at most 7%.  For large repository, like MS Windows with 3M commits in
2019 it would mean decreasing the size of the commit-graph file by
11.8 MiB (if I calculated it correctly).

Because corrected commit date offsets are not monotone, that is after
value that doesn't fit in 32 bits (in parent) there can be one that does
(in child).  It is extremely unlikely that in real repositories there
would be that large corrections needed, but it can happen in theory, and
therfore we need some way to handle overflow if we choose this option.
And of course we should test that overflow handling works correctly.

So there is tradeoff between complexity and commit-graph file size.

Best,
--=20
Jakub Nar=C4=99bski
