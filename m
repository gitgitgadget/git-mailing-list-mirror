Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9DDC7EE23
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 17:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBXRar (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBXRaq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 12:30:46 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE92341B4F
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:30:45 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so3631790pjh.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5f8G+arqASIwj5hBWPyMBSUKo/mLtEZdsGjIx9+2ZYk=;
        b=kCEz+bD3YmWuQbHx+cSLFPPGugPY4pLp0VLTQJcq81sg8r3RSrYG1CBGXGneMsHPDk
         jabtCycNcuyGadK58wsUr6CTvmgJmu7ouDiINZ8rOWi3U9oV5WAbxYmU7/s7q2qQI0l0
         lETyc9vfzqT1CBJZGSU7APVz0sxG2d21QRCgl1+CzBvfswNUW1LvPJRfYaPpZRcHLvd+
         vF6Z8AufzHfVsoETchPWweUNdzltbagnXy3nzXXmWVek7s4JHMzFK1OYUlpIXYcO2yDW
         4NcY49Gqvhv5ZeeJ7xVbwrHEK2qUZ+X1UcPzGcJxLuLFrkq+ZLPwgUyq7cdqCv3x4/sb
         KkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5f8G+arqASIwj5hBWPyMBSUKo/mLtEZdsGjIx9+2ZYk=;
        b=8MvPh4uNUDrEjQg/CwFwbGmNoOhyFOa0OkKRU2sD4iymSbgfeSFhmsDbnhHKh2VOeb
         HGhfT2o4GpT71jqg12GdUodgZoYP+xnYyCZ9sqyub6XkSx6vrTRk+qOXUFr3lrACoJzI
         yfZju5bfjBRHWu4x7ZtGjL37qgYSTUvOxBkmzy7lGh0kAp1+I7SC5/9NrxyWcolitx33
         4sSh1lhBF4IYpmzv1Yn8cqX91kCgvsSO4JHFgfOPe4fHkODWDYo40b+akATos3THRJ9d
         nlc1ugHrLRTvbuX1dA1y5VjkNgkWSQYj9rkcoKT0phV66QfOM9vV8c2EjJmdqCtta7BK
         3C1w==
X-Gm-Message-State: AO0yUKX2b6ufMeg6gEq7MzFs3jg24F8RWfoi9uHJmhbuVm8jOcI8wxZd
        3IPfaM7yj+lrJeJ9BMqDld0=
X-Google-Smtp-Source: AK7set8Q3fLpDA1Ncuo7LqZU+TvR8pkOV4DBlF/9WPBhu9fTzY2O5whX6cgQmHPtoQoKdba3x1OxOA==
X-Received: by 2002:a05:6a20:7345:b0:cb:ac6c:13d3 with SMTP id v5-20020a056a20734500b000cbac6c13d3mr444277pzc.21.1677259845120;
        Fri, 24 Feb 2023 09:30:45 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id d28-20020a63735c000000b004f2c088328bsm7820439pgn.43.2023.02.24.09.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:30:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] fsck index files from all worktrees
References: <c6246ed5-bffc-7af9-1540-4e2071eff5dc@kdbg.org>
        <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
Date:   Fri, 24 Feb 2023 09:30:44 -0800
In-Reply-To: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 24 Feb 2023 03:05:36 -0500")
Message-ID: <xmqqr0uf0y4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We do fsck the resolve-undo extension, but I think fsck just doesn't
> know anything about worktrees. That should be easy enough to fix.
> Patches below.
> ...
> Thanks, it was nice to have a test case. I ended up writing a separate
> test with a missing blob, just because that's simpler to do. It looks
> like we don't test fsck_resolve_undo() or fsck_cache_tree() at all. That
> might be a nice addition, but I punted for now to stay focused on the
> worktree aspects.

So we had a separate worktree with its index pointing at an object
by its resolve-undo (or cache-tree) extension, but somehow lost that
object to gc (I agree with your assessment that it should no longer
happen since 2017).  gc these days knows about looking at the index
of all worktrees, finds the issue, and stops for safety.  fsck that
is run in the primary worktree may not have noticed but fsck run
from that worktree would notice the issue.

Sounds like a frustrating one.  

Thanks, both, for finding and fixing.

