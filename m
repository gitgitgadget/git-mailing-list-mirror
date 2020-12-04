Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DA7C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D37120866
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgLDXP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDXP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:15:27 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09384C061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:14:41 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id v143so7152688qkb.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=q+JSjERdfbIl3qANgJjtUelArlR4Yivb6fc22bY5/W4=;
        b=ItgwHmODZHDOAFPk42yx9+2DOlqfTKzALfHFZXwAhHXp9CtmQcWS//EGvU5LT8N24Q
         mpN9PwjxOcl4hHcEfuEr1aEW3pnQFlLrlbt+ZeA9SWdsWrn7DkGNKzD+LH/Ymz09xJYw
         R5B9Z/4tM02Iu66ArsbqCm731RlZ5IaPvwYevPeIbstbHk/VHvIP0tdEia5a0jXPVsAT
         wS3HBtJFiKeaE/cwquO4oZPB76u+cf/9vsZIsHjmfDznUSFGOOnfU2X6WCOydjvNNI5D
         pzUopc8dz9JM4fwBlqOHcEkIaA8hmm5xK/u0t8uGi7GW3eMtUoVYyG9G/cKKIVwNN0+y
         3iHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=q+JSjERdfbIl3qANgJjtUelArlR4Yivb6fc22bY5/W4=;
        b=ijgPt3etPJEbxdq0P3vg40XwwA+2oGpNdboAbxTV83a3PaqZpBPPkzL2fWskJ7t7kV
         061oMjowIthpPt1dbAcRmNzRVOWB3RPKCst3wzQHEjfgsX3/Bq7qXYdL8H9d5CUBBxDx
         dQrTzQXZ6O0MH9Orf0uzt+bn6ANYhW5qOEaQFJngRVbSV4xemYJIb2RXmOpHtEWbpf9Y
         aQQvmeL2oaMKthhkKT5xzlBPF2rEbyuaLKKRn4HYOnmQ9CPKXiU7wBmYqsfHSvD5QVCg
         CixDfkKcv2YLyrKLT7Dda88gRDRQ5gAkf6wthZHxivHmhnJTPonG/8fBMowFkyJfi1OE
         wyKA==
X-Gm-Message-State: AOAM532n/tV5vZPKWudnUkEvftyg4hpMeGgNav642gia4T6ykG/DaJDt
        9bXkxx2VsSALOw8HO8gVpW4L/6WTtOIrcQ==
X-Google-Smtp-Source: ABdhPJz4ZkucdW5Aag1O/QoWtn7c5Iggml/EYdFfJgTeSnZkckzEzsx56AXyy3ZKPdRuRTh3q9nUQA==
X-Received: by 2002:a05:620a:1f3:: with SMTP id x19mr7967093qkn.17.1607123679936;
        Fri, 04 Dec 2020 15:14:39 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 72sm7015741qkn.44.2020.12.04.15.14.38
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 04 Dec 2020 15:14:39 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: 'git worktree repair' can't repair when main and linked worktrees are moved
Date:   Fri, 4 Dec 2020 18:14:37 -0500
Message-Id: <63AC7AC2-5D32-479B-BF9E-0E5C31351A1B@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
To:     Git mailing list <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've had to move all my Git clones to a new filesystem.
Several of them use secondary worktrees, and all are 
at the same level ex:

$ ls code
git git2 git3 other other2 other3 ...

I had hoped to use the new 'git worktree repair' command
but it seems it does not work for this use case. 

I tried several things:

( cd git && git repair )
( cd git && git repair ../git2 )
( cd git && git repair /old/path/to/old/filesystem/git2 )
( cd git2 && git repair /old/path/to/old/filesystem/git2 )
( cd git2 && git repair ../git )

None of them work. Note that /old/path/to/old/filesystem/
does not exist anymore.

Is this supposed to work ? Or it's not something that 
'git worktree repair' can currently cope with ?

P.S. I know how to repair the worktrees manuallly, I just
wanted to test if 'repair' could help me.

Cheers,

Philippe.
