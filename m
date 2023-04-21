Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FB4C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjDUTB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjDUTB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:01:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB9A3
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:01:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a66888cb89so21663455ad.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682103684; x=1684695684;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMG6HE3M5B0NL47I1r0AFvJEw0au4HDE8s+6po8mn30=;
        b=rhQA9dTOJqlr9qgYPdsXk8TxG+KLyHW20bjUFiqypH6zMNgIXDO4QuzvjUCNEZfZLz
         mrI+VvQzMUVBkJVjs9/KqHO0yxyxd6TE9QL1kj2NF2RD7hikaPVQB1uCiXDdiFfO+MNH
         e6aKhw8LsaKC1DqU8n1IeM1jbpd9U5ScF/sDm7MvRRFiydqGt4/S5/trIYvkdCudDrEp
         z+SzsTMWwCVEiABmhaoPSvv3enRkW595oG4GpYyZAJBazyG2anYVcNZpkW6RdpzYovl/
         5b6k7rCnENvvttca8gPnP4ZgRICkfBqjSYEBDfehK7a6vPLiTVNLLroCwoTBL3e6M3DP
         NJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682103684; x=1684695684;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mMG6HE3M5B0NL47I1r0AFvJEw0au4HDE8s+6po8mn30=;
        b=JLE3Mgt4iXNkdHZVkXW7yyfxfttrW7arOt7DToB5npOQ/BGPJHvf11+eqyR/viPaVf
         PDEasJx+3tdPi66YdCwlo0biSSzhpgeApzW6G1KcqYXMpzexO5eTFJ/GfAhmW9TSkw/d
         8PTm9kYfNGrwoBxNOmq1JOv3rHkCrvfNJ3raN5whLFBKiOzqriS0KhpxfR/d+JqsNv69
         Dgq4t+SUZn2s94edVsNrT1ZnJ7r8kSwjnuv+heBwJ6dgCf61uLJCUcfbcRJO3Cv2N6ON
         yFuVcgxusP/zq2f+mLr1mavatxbHU4SubPb2nMyV2k/bbvggz2przgTAxbMXLVZqiNAf
         nPMQ==
X-Gm-Message-State: AAQBX9c7eXGxXhqRLeuZ9bxkP+P3tRDpevYLD5I9qn4XPZhWP+pxWxO9
        P4uD5cZprm3RglxPxAL6+hQ=
X-Google-Smtp-Source: AKy350YSOj34QDHX2jqwFdjDu6zfPPZlAHsihQe8eaV056aldwB5z7EoDtetp0HGr4KqXlBRoo0srg==
X-Received: by 2002:a17:903:2281:b0:1a1:b174:836c with SMTP id b1-20020a170903228100b001a1b174836cmr8108772plh.16.1682103684502;
        Fri, 21 Apr 2023 12:01:24 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902700100b0019a7ef5e9a8sm3049634plk.82.2023.04.21.12.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:01:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/6] rebase -i: remove patch file after conflict
 resolution
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <227aea031b588977f22f3f97faee981d79ade05c.1682089074.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 12:01:23 -0700
In-Reply-To: <227aea031b588977f22f3f97faee981d79ade05c.1682089074.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Apr 2023 14:57:50
        +0000")
Message-ID: <xmqqwn25jbzw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When rebase stops for the user to resolve conflicts it writes a patch
> for the conflicting commit to .git/rebase-merge/patch. This file
> should be deleted when the rebase continues.

Could you describe the reason why this file "should" be deleted a
bit better?  Once the user edits the files in the working tree and
tell "git rebase" with the "--continue" option that they finished
helping the command, and the command creates a commit out of the
resolution left by the user in the working tree and in the index,
the patch may no longer is needed, so I can understand if this were
"this file can be deleted"---in other words, again, this explains
why such a change would not be a wrong change that hurts the users,
but it does not explain why we want such a change very well.  Is
there a reason why a left-over patch file is a bad thing (perhaps
causing end-user confusion upon seeing such a patch that apparently
is for a much earlier step in the rebase in progress?  If so, that
might be a good justification to say we "should").

> As the path is now used
> in two different places rebase_path_patch() is added and used to
> obtain the path for the patch.

OK.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

The patch text itself looks good in the sense that it correctly
implements what the proposed log message claims it "should".

Thanks.
