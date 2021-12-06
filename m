Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C896C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 18:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346774AbhLFSRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 13:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243979AbhLFSRF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 13:17:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD65C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 10:13:36 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p18so7581867plf.13
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 10:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eMj5GOXWIqTdgALgsOWgjRGyZfhcpfUmBinWw4Z7Rtk=;
        b=LFdYgmmiC+Q6ek/QfvlgfRnp/NX4/ZKC+K9zqvHJ2C90dP2HoqtqImSqUVXwry/zpS
         eGQDeg2Dn2fp1rvIAY/iqi8+WE9QGCQ2tBBsfIuXNNMk0R5hVUfR4q27YQgiWPbiQeRz
         od8itpXSEdeMBSJcLgon+s5TsfpExa7pBrfdMMkpQ230vfSdl6oGdDLxeNS/yAPPx9LO
         p0TDpEl7srhVVsU589o0ub99MKLUOwMw23HknNXbJH2eG2p4zDM0PsjBMht1uEsbSKM4
         PILPwfJEx1NIK5qUxOtovtEEMYR/xDhXcnwJQa/QZqTlY0hgFxFwolSLZRHS9ehwG8WN
         /Mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eMj5GOXWIqTdgALgsOWgjRGyZfhcpfUmBinWw4Z7Rtk=;
        b=celMIS0unGo/6pUOV/H5b63GEGF4GV1bVp2Bo40KiFf+rwsJsauQHadFk9DLaMdSya
         7rpYHeEa5u3O7htjxENS97sMdsRusvyoUro5kW+tYiAwZ35jgTMzb5BCAdPBYQQPu0hq
         dCV901qtZB9/LB+2jSiYXarFwM4uw0/laZVGTapDuQ6FbK9pPNkT+Pp7FsJRQtOkXLSx
         gcHmS504FcYAFIEEd0bH9X+oJLiqVK5BdRG6xvV8yCsn0xNTgbP57sJjzqGQBC+Q6yHi
         lgq+CiQVy1Hi1K3BzWx4vY19tFsiRge/w/bTy3N4G6jgRj5EESf3f+gjxS20CxBLii7X
         rOtQ==
X-Gm-Message-State: AOAM532WjE7aSM4DifAwGVxjSnZ7rS5UdoLB9ZlmExPGdq4eXplajyLp
        2hFtaVDhOideUHkPYAnoSjE=
X-Google-Smtp-Source: ABdhPJwfGA4EhrK7t1k8WKfzll2tDFSNyxkeHYirCsxkoXdlmwFaxMGjt58o27PqWRq+WyszCTrY4A==
X-Received: by 2002:a17:90b:38c9:: with SMTP id nn9mr167587pjb.192.1638814416141;
        Mon, 06 Dec 2021 10:13:36 -0800 (PST)
Received: from localhost ([2620:15c:289:200:9206:9546:da97:4e9c])
        by smtp.gmail.com with ESMTPSA id x18sm13019699pfh.210.2021.12.06.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:13:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     git@vger.kernel.org
Subject: Re: Potential bug with octopus merges and symlinks
References: <20211202030458.GA48278@newk>
Date:   Mon, 06 Dec 2021 10:13:34 -0800
In-Reply-To: <20211202030458.GA48278@newk> (Michael McClimon's message of
        "Wed, 1 Dec 2021 22:04:58 -0500")
Message-ID: <xmqqa6hdha9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael McClimon <michael@mcclimon.org> writes:

> The order here matters! Here is every permutation (1 here is the symlink
> change) to git merge; only the first two fail, all the others work.

I am not an active Octopus contributor, but was the original
inventor.  And it is not surprising that the order matters, because
I designed it that way ;-)

In the original design, octopus was to be used only to create the
simplest forms of merges without any conflicts, because octopus
merges make it almost impossible to examine the result of the merge
with comparison between one of the parent and the result (you have
to remember that there was no "diff --cc" invented yet, let alone
"diff --remerge-diff", back then to help us).  Aborting the merge at
the first conflict when merging the remote heads one by one is a way
to make sure that the result is a simple "combine unrelated work
into one" merge.  This does make the order matter somewhat.  When
more than one remote heads touch the same path, the order in which
they are merged into base does make a difference.

To be more strict for the goal of limiting octopus to the simplest
forms of merges without any conflicts, we should have insisted that
the set of paths these remote heads want to modify should not
overlap and that would have made the order totally not to matter,
but "abort at the first conflict" was easier to implement and
practical.

And later, before the command got part of the git suite, the rule
was further loosened to allow a conflicting merge when merging the
last remote head and let the user hand-resolve.  This makes the
order matter even more.

