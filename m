Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B336ECAAA6
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 16:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbiHZQez (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242482AbiHZQex (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 12:34:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73104BE6
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:34:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jm11so1990901plb.13
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=cx53K8emKMtW6A18K7gAnZksdScDL4hFWHJRWpfRRJk=;
        b=p4FX01jdXoTsKQ4RXZQDNJfZ2p35ynMRz7KaYWjYFwKBqZIjnoEJWHSmCZzoivWQro
         I9Ba2Xxj5WWbXV3bHKdfUw1WrqyjsQUDa2yXkddZntOUn0pMjYZiuyUju+lM21vdTCU6
         0Z+QgaqVWWmm3v5emDJjfNObiT5O1zbDqh4QIXyB2iyZRzW+pdDKtdK78hZEbiXToTL/
         mfa/yPKDB2GrncvmrY2T+i/Zznqn4coYykTNzEQMTdy+auDcDr014np2J8ioswDQjt1L
         vXY1d2tVxDPzyQ3sIcbQkXrzrX8/2ZPIp/9pAZ1t4yLZyseyomzGPmaoT7vanzVz0n3N
         uiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=cx53K8emKMtW6A18K7gAnZksdScDL4hFWHJRWpfRRJk=;
        b=gMp61F7zLzLhmEKymSfR+w0N0KTctkx8Sl0QCd0+tZ/2yH7bRLbXkXwkQp7ckkKnup
         MP15zxWtIbRbnyufcSFUOi3Fp0m3QoMyFBgZtPUBxP5CFLf6qbb3GhZ87yCwWcmbvCfS
         5kRbnPzqx9/CQni/yjEx43ovGjfW2Xt3OHiPMJjQN5AYdd9Rks9CCM9+d1+MRPGw9EAP
         jIebtxmEQP6uurJT6zCyNgAq3OULXZ4XNkOXkCMPmG4mZudod9iTDHYMCH3t+o/QIiAa
         eO2f4QfYSyQyKXLomWyjQDwhtmrMbX8lPz1Kj72LzobLtcvqi4VgE+13WNe6FbitE3+d
         P9ew==
X-Gm-Message-State: ACgBeo3P8ouISq8LvT4W3w9RfWFyhVAlskZHtQ6b9hKeYju+0eZFh1xx
        b8fDVHEK8YIaZMZgPW5nMhSooFVqLrU=
X-Google-Smtp-Source: AA6agR47au+hTfG0sTnpyr4IOGasFUiUo7ch5JRAfxW+x5Nbw9ufa2FNORgvpNlx7TNwVZHaI/szpg==
X-Received: by 2002:a17:90b:3805:b0:1fb:75d4:59d4 with SMTP id mq5-20020a17090b380500b001fb75d459d4mr5085281pjb.209.1661531687827;
        Fri, 26 Aug 2022 09:34:47 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 78-20020a621651000000b0052e6d6f3cb7sm1947057pfw.189.2022.08.26.09.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:34:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
References: <20220826070912.70274-1-dyroneteng@gmail.com>
Date:   Fri, 26 Aug 2022 09:34:47 -0700
In-Reply-To: <20220826070912.70274-1-dyroneteng@gmail.com> (Teng Long's
        message of "Fri, 26 Aug 2022 15:09:11 +0800")
Message-ID: <xmqqtu5zyndk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> This patch tries to avoid the problem of leaking sensitive information that
> could output the absolute path of the repository when try to open multiple
> bitmaps. For example, in "alternates" scenario, where the repository
> "alternate_repo" serves as alternate object stores for repository
> "want_to_borrow" , and each of both has it's own bitmap file, then we run
> `git rev-list --use-bitmap-index HEAD`, the output might be:

>   $ cd want_to_borrow.git
>   $ git rev-list --test-bitmap HEAD
>   warning: ignoring extra bitmap file: /Users/tenglong.tl/Downloads/alternate_repo.git/.git/objects/pack/pack-bff67e2a7a154e6933afe61b3681726cf9bd8e8b.pack
>   Bitmap v1 test (1 entries loaded)
>   Found bitmap for 30f146d41a7a86930fae3f4a5e1f1c1f2bfacbba. 64 bits / 11030517 checksum
>   Verifying bitmap entries: 100% (3/3), done.
>   OK!
>
> After apply this patch:
>
>   $ git rev-list --test-bitmap HEAD
>   warning: ignoring extra bitmap files
>   Bitmap v1 test (1 entries loaded)
>   Found bitmap for 30f146d41a7a86930fae3f4a5e1f1c1f2bfacbba. 64 bits / 11030517 checksum
>   Verifying bitmap entries: 100% (3/3), done.
>   OK!

I am not sure why it is an improvement though.

Doesn't it make it harder to diagnose where the extra bitmap file
you do not need exists (so that you can check if you can/want
to/need to remove it)?

If the "ignoring extra" is a totally expected situation (e.g. it is
not suprising if we always ignore the bitmapfile in the alternate
when we have our own), perhaps we should squelch the warning in such
expected cases altogether (while warning other cases where we see
more bitmap files than we expect to see, which may be an anomaly
worth warning about), and that may be an improvement worth spending
development cycles on, but I am not sure about this one.

