Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F13C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 20:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353917AbiBCUFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbiBCUFk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 15:05:40 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0A6C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 12:05:40 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v15-20020a17090a4ecf00b001b82db48754so4062947pjl.2
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 12:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5h5Q62sFxAoR5Ns8biXl7WNznL2ytPYvZm12wW+aO4w=;
        b=PErduUg7iukBve9gyhx8ttVMpSUYCqa6cIJXrx20AQpzBbNnO3MAXnuk96sz6wG17o
         06nYRCPhRpPSvla8CXufTLLGCTRtNi9z3kx6TWIlRnQftdB1qjfgidon31cVErzuV3kY
         /ghyGL67gGNPgMmHW33Ou56TAJMb0vry02DKKlppA/V0ZhlJI/LKJYLKFhHSmTTiysTk
         UkBlGNl23lrpH0DNQzmwNCQoUWzmgXUuc7uyS2ywq8jS0tfjSRaGwTHRs9nGVHZm06T0
         vfGlj4Ei6r/umgjwhBlv6xXW0p5ttadBnE0jRExZR9j4Za7/+e8hBuTgSQuFf/uFSOcj
         J/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5h5Q62sFxAoR5Ns8biXl7WNznL2ytPYvZm12wW+aO4w=;
        b=KuhffMlvBNRDtld06rYvO0T3/XCW/lAcTnxUSLTdf6o6t1PQleJq88n+xbQ5fHiiRe
         k2A/qGc9eYKxWP8LsBToJzi2qsvltmXwv8x6MVDLh9GfHPYCmdD4hmN2rrat2hVl55a4
         zxa+wSwmCsUTj3ptek/XYrZPKW9pjpZZXpVESryDJaodZDMPeBR46g5KpONefeDNiN3s
         ffcH4sLkVib+XouOQFgk5phbcUQWP0OXib9ziS4KwwNAPClxdVVc7NyfR55UUsqWF4Xo
         Pa6CNV6NomX1kbP9GkE2fgwlpprESkBKPC0kLFCiXAn3KblyZUmCgcjuCQuJImzK6zLx
         +CKg==
X-Gm-Message-State: AOAM532lKx8GXnUcEQ7ErEEqNesztRVcpI4f+z/B9AmtZ9aWpYjaW2Ws
        kR4xgvfVossGw+Z3cYjQwo4=
X-Google-Smtp-Source: ABdhPJwQ8mrUCqUA4sZjLyHj3+uu1+1zo+H4/gDal+u2K1pKBIip6pwKNswHISVKhyIm+h/GGvwf7Q==
X-Received: by 2002:a17:902:7445:: with SMTP id e5mr102814plt.35.1643918739699;
        Thu, 03 Feb 2022 12:05:39 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id t7sm28650738pfj.138.2022.02.03.12.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:05:39 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
        <xmqqy22tx8t1.fsf@gitster.g>
        <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
        <xmqqh79hvsgn.fsf@gitster.g>
        <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
        <20220203104241.yvfragan6ucecfjl@gmail.com>
Date:   Thu, 03 Feb 2022 12:05:38 -0800
In-Reply-To: <20220203104241.yvfragan6ucecfjl@gmail.com> (Johannes
        Altmanninger's message of "Thu, 3 Feb 2022 11:42:41 +0100")
Message-ID: <xmqqee4jsokt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> I wonder how the UI of a tool that does non-worktree/non-index cherry-picks
> will look like.  I'd expect it to produce the same output as merge-tree,
> except cherry-pick should probably output a commit OID, not a tree.

A tool that creates a "merge", "cherry-pick" and "revert" should all
output a resulting commit object name, not a tree object.

And "merge-tree" that creates a three-way merge to apply a change to
go from tree A to tree B on top of tree X should take three tree-ish
object names and produce a resulting one tree object name.

Using the "merge-tree" that merges two trees using the third tree as
a common ancestor, these three higher-level tools can perform
"merge", "cherry-pick", and "revert".  They would all take two
commit objects and produce one commit object.



   
