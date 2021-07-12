Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10685C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0C6610E6
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhGLLN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhGLLNz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:13:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929E8C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:11:07 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a18so42516388lfs.10
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VUWIBI9ozjzX7OIk5YgnPw0+YOmEOZyTSoNzPxTrznI=;
        b=uQdMr13Q3aka27+t9vHpnj/AGkHyj33s9nVevlsZIh8Wo5ysThev33a0Jp7GbIQDHG
         KxkCiJsNq4iD6lajFWi+9Gry7tkbPjtmO0ZmbXYKAIzvb52R/utvyb7D/iOBkyzDUW03
         Jd6BTebE2iIIX7gCxjaAMsaIZ4MSgpFb52A6xulTWmK1M4au0WGCW+2eADu9VmUnGsM+
         TJA5y7xx4Cxy0S7TsSvfhMAXuP+9PaG/xhbbL427PBfPzMpAtrdSDkYLH3v58i1g8qUQ
         OWSIZlC0SlqwKGN90cqPmTvxeewwk333SKi1xRi6yDUnfM+pbMUjh8m/rlvyngDzv5Fz
         x66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=VUWIBI9ozjzX7OIk5YgnPw0+YOmEOZyTSoNzPxTrznI=;
        b=pnYoI5UUz4AmUxnxibGrKb+JIJ7KaJHH6IvhpDi0REnLA6zfQXfMLsd0c2DQZyvNx5
         VoH2iFXraeXBi5j+7KuCgdzsecm1t358l80k04Crq5TGjNXoD8JdnRnYcwMRQuw5ZZ3+
         Tk+VPp5fgLZPUCV+yfE5k16e6nuqGwbO9BY/vva14D17btnJlCPgvIHmssGrr8mKZVLw
         SVg04JrB9MYEHJMrlT7En+k/TqFyknVCLcjsbC3Whm1UTioYUUO741DmjgSRILDVIlh+
         Ga1sqKUR7kO6Zm0dc1GMRBNbWwFG5/x2Fuazt6qECFhwYfrh0cwuLZn9VHUim7Px8qKh
         ethA==
X-Gm-Message-State: AOAM531zpez8x7TX+tUzzJG1pUDxvKn6WYz7qQLi/KpaMJ3cuh5OqDQa
        v0uTztisBbe5HEUPC6cXR1K6fNm4XfY=
X-Google-Smtp-Source: ABdhPJwIxXzmb7u/S8cvt7iRJfcem0Qszps/BB4nooWpWhN8T7RmVJkIuod0PKwMVqFzw3APdSrJYg==
X-Received: by 2002:a05:6512:3d21:: with SMTP id d33mr9065324lfv.352.1626088265451;
        Mon, 12 Jul 2021 04:11:05 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a16sm1183894lfs.281.2021.07.12.04.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:11:04 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <60e67389a4adc_306ac1208fd@natae.notmuch>
        <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
        <60e736e72da68_30939020850@natae.notmuch>
        <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
        <60e762243aab1_30a7b02089@natae.notmuch>
        <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
        <60e79c31aaa72_30b8a4208c1@natae.notmuch>
        <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
        <60e874e1c6845_215320861@natae.notmuch>
        <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
        <87im1ieaba.fsf@osv.gnss.ru>
        <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
        <87a6mudt9b.fsf@osv.gnss.ru> <60e9ff4430c57_7ef20815@natae.notmuch>
        <874kd1gr0q.fsf@osv.gnss.ru>
        <6ffd7f1c-97be-a57c-b738-31deae26e8fc@mfriebe.de>
        <871r85f39n.fsf@osv.gnss.ru>
        <33af677c-8fec-5b49-0e00-878918c4ea1d@mfriebe.de>
        <87bl78eqv3.fsf@osv.gnss.ru>
        <AS8PR02MB730258D0643373CB476A18D39C159@AS8PR02MB7302.eurprd02.prod.outlook.com>
Date:   Mon, 12 Jul 2021 14:11:04 +0300
In-Reply-To: <AS8PR02MB730258D0643373CB476A18D39C159@AS8PR02MB7302.eurprd02.prod.outlook.com>
        (Richard Kerry's message of "Mon, 12 Jul 2021 10:31:41 +0000")
Message-ID: <87r1g3n5x3.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kerry, Richard" <richard.kerry@atos.net> writes:

>> >    git branch switch
>> >    git tag switch   // detach
>> >    git commit switch   // detach
>> 
>> Why? You don't switch tags or commits. You switch only branches, 
>
> Yes you do.

No, you don't. You probably didn't read my sentence carefully. Please
try to read what is written there, and see below for more explanations.

> You can switch to branches, tags or commits.

1. Switch branch /to a tag/ is not the same as switching /tag/. You can
reset tag to point to another commit, yes, but that was outside of the
scope of the discussion. Switching *commit* doesn't make sense at all.
Overall, you don't switch tags or commits when you switch branches, --
that's the meaning of my original sentence.

2. Event when you switch /to/ tags or commits, you actually still switch
to a branch, as you can still create new commits that will grow that
branch. This "detached HEAD" thingy that has been adopted to support
switching to commits is just a misnomer that obscures understanding, and
should be eventually replaced, probably by means of introducing the
notion of "unnamed" or "automatic" branch.

>
> If I remember correctly, "branch" is used in Subversion and CVS only
> for the creation of a branch. Likewise "tag" for creating a tag.
> And I think they both use "update" to load the required
> branch/tag/commit into the current working area.
>
> If git were to do that then I think we might get around some of this
> confusion.
>
> In that case:
> git branch = create a branch

Sorry, it's too late. I don't think we can actually do it.

> git tag = create a tag

Ditto. Too late.

>
> And then a new "update", so:
> git update <branchname> = make the current working area contain a copy
> of the given branch, and similarly "git update <tagname>" or "git
> update <commit-id>"

It's already called "git restore", no?

>
> In all these cases the keyword after "git" is definitely a verb, even
> where the actual word used could be either, and you need to look at
> all the definitions in the dictionary to check.

In the current "git branch" command "branch" is a noun, and then a verb
defining exact operation follows as an option, or is assumed. You may
well think about it as being "namespace":

  "git" -- enter "git" namespace
  "branch" -- enter "git:branch" namespace

and everything that follows is about Git branches with more or less
random syntax for particular functions to be performed.

Thanks,
-- 
Sergey Organov
