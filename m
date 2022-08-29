Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C9FECAAA7
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 18:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiH2SB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 14:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiH2SBT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 14:01:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E53785A97
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 11:01:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m2so8760857pls.4
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=4oUNQkH8wboOVY7X/EWCmmpZL5Le6cf/Bg7M/NJ7Ax0=;
        b=QtlMz5Sn90hPB2rNdwpAXzO48nqGVyCqii3w4GAa4Hpj6Qpb0I79b5zMzpF0Epbb1K
         dzmKW93jCx2j1EcD+0BWIA7cjjbgMWW4jYbt4soa7sDTJ0NU+tg7toqQztoo+ndkA7Cx
         1R5hA6ZBZvgcU4FJ5aBmYflvHzENil/+vv0sytVafP+0E31zEl7SKJj8lQqi52iyBSew
         bs3fxKhYsEYxZ12iMSgW703ibNHRjdQFwX7G9D77h7z6Gpl/KCzW19DlEKOFdEcSwxc+
         KonR+QAynXWJ7ReOjHQvL5INc8gnPJPjyvJ84N+ggfwkoRb9JyD18T5b69JPfsutcrNW
         ZKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=4oUNQkH8wboOVY7X/EWCmmpZL5Le6cf/Bg7M/NJ7Ax0=;
        b=DuyOIxe/CmJzEY+WzENxggyC65Jpg0rbGrsQWDYGKq6mDiWgJNxXwcUjU7AQ9QrJZ0
         nDLBf4foeuXkwIw0QKEUzOLjEN84BoKsAAT+5RWck6zGHKBJsqMSkmEA+dHE+xyIK4nl
         qgr/fRZUWbFQ4wRRSMsJTtT9ETp80p69KmYfoKrLfSRhoYTmoe/kYb0BTFOH/W6be8xV
         BEbsj6EUVo0WehOX0WNPKna12MEWYWvYz0qbiZT3iikbUJh7WCTelPLN1nGhBHzSlNLT
         NDrnnJwFWV7xPkAQEpAQRbINKPzEr/FULlKwUhSGELbCqPLy5AYTCNTQ9TxcudbFhz4v
         k3Pw==
X-Gm-Message-State: ACgBeo2k4Cte5PszkwDPz44mWZBljqsqhNPF8+ez317pPS/UPDar7QUv
        b8lJzf8/2geK7e7DyQ02b48=
X-Google-Smtp-Source: AA6agR5Y7NDWgb/rDWNJNE9OQK6h6kPM1UJoZxRZXswao3TdldN4vBS+AC6YKxcQEB7x+1O6yOC3Rg==
X-Received: by 2002:a17:902:aa03:b0:172:9b18:ebb1 with SMTP id be3-20020a170902aa0300b001729b18ebb1mr16693783plb.24.1661796074426;
        Mon, 29 Aug 2022 11:01:14 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 80-20020a621453000000b00535c4b7f1eesm7512252pfu.87.2022.08.29.11.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 11:01:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/5] built-in add -p: support diff-so-fancy better
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
        <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 11:01:13 -0700
In-Reply-To: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 29 Aug 2022 15:11:51
        +0000")
Message-ID: <xmqq5yibnd3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  * That logic was now corrected to see whether that space is really needed.
>  * To verify that the logic does what we need it to do, the added regression
>    test now specifically tests for that (single) extra space that we want to
>    be inserted.


>  * Rebased to the current tip of the main branch to avoid a merge conflict
>    with 716c1f649e3 (pipe_command(): mark stdin descriptor as non-blocking,
>    2022-08-17).

I'd prefer you (or any other contributor) not to pick a more recent
base only to work around a merge conflict, especially when it is
something simple (like this case, where both sides added a new test
piece each in a way that semantically do not conflict).  I'll ask
the author to rebase if the conflicts becomes unmanageable.

We promoted the built-in one as the primary implementation in
2.37.0; I think we want to keep this fix mergeable down to the
2.37.x maintenance track (either by me, or by distro LTS folks who
are motivated enough).

This time, as you can guess by my above description on the exact way
how conflict happens, I've rebased the series back for 2.37.x and
will resolve the conflict myself (and make sure the result matches
the application of these patches directly on top of 'master').

It appears that this round is good to go down to 'next' soonish, but
let's see what others find.

Thanks.
