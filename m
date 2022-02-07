Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B762C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 08:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbiBGIIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 03:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbiBGH5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 02:57:53 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CCDC0401C6
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 23:57:52 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id om8so4012414pjb.5
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 23:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IcrrRlIlgC5rSv0b6Sx/nVbOv3JB9OZ2jlWZm2WUFMs=;
        b=e8df0SDc/5KVtBEJ9xNP1EeKJ22t21oA0ORHTNTMH8Cg1DPnk63vtFAu9AuxSh8loH
         epM/a7Me9FaYk5GFsTup4O2lq13Be7upMDKyHnozDATtNtFuTsM+mimqUijfC5MCzT9C
         iDUd9nBXGizI1mKMccqooUaPtKwmClmB+B/7TokjveW3leXeJKulWvu+Ihz/ELIzHwmj
         bNkLNSFxIW9qaLQ1o8P/MUrfq34eZPRap1F4seAkHndxLQoApbz75s9b+XgbKxgYVFx5
         IRF+/2LoYqPh3wthf/Qaq3u97F6TUlw2dY3n0lt3A2s3k71LPGbkS3UKKwD2ev0MnwVK
         6XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IcrrRlIlgC5rSv0b6Sx/nVbOv3JB9OZ2jlWZm2WUFMs=;
        b=vfsaRe/aS1jFideuB+yW3vIKDPmIQNZ2EPefw6DmYlxdcKjYQ5bornzVv7CEYp8Qxq
         5WHCTIBGfYE4lYE8Ht0yzASDF1I53BjQo+i7YTngTezt1YLlXCQrKIAJZAU7ZnsAFNcp
         1qereZxQ7tKyUutn88JGe0kVqtcW59pODP9BUU1fIrxX2wsUcwhvipDi3fH1ue1aPN71
         FMhi3f1MUo2Mx35rgWCgdke25wc7r8ApmfEocqWoAHnZ7BuOE+9G63OWkWcskoqba1io
         Eu+zuPLTcPd42AqWzZEyuDxmkcnSFgSvPQJP0NDgybv2WxQAgrqnWbn2UIJYKiJjNarZ
         nreA==
X-Gm-Message-State: AOAM530wmb0fry7nAOPuFSQSfY3r2+Ha6P68zVI/F4Yhf/A/z0L7xfHh
        KjDnr/Z4Vx5H8fFkSxRGyJ0GOfa9nXM3SE2Y
X-Google-Smtp-Source: ABdhPJwo0hI6TRqhYeuEgmLEUnRjc3vj14U9vr9oaQWLNGFJwJJhYdPFSFICZj40/uo8KFMr6nXWuQ==
X-Received: by 2002:a17:90b:2281:: with SMTP id kx1mr17016451pjb.37.1644220671735;
        Sun, 06 Feb 2022 23:57:51 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id q11sm11863195pfk.149.2022.02.06.23.57.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Feb 2022 23:57:51 -0800 (PST)
From:   Chen BoJun <bojun.cbj@gmail.com>
To:     git@vger.kernel.org
Cc:     Bojun Chen <bojun.cbj@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 0/1] purge temporary data if no command is ready to run
Date:   Mon,  7 Feb 2022 15:57:20 +0800
Message-Id: <cover.1644219248.git.bojun.cbj@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Bojun Chen <bojun.cbj@alibaba-inc.com>

Rewrite log messages to more clearly describe the problem.

Chen Bojun (1):
  receive-pack: purge temporary data if no command is ready to run

 builtin/receive-pack.c | 9 +++++++++
 t/t5516-fetch-push.sh  | 8 ++++++++
 2 files changed, 17 insertions(+)

Range-diff against v2:
1:  72f49f1792 ! 1:  0b5793d1ea receive-pack: purge temporary data if no command is ready to run
    @@ Metadata
      ## Commit message ##
         receive-pack: purge temporary data if no command is ready to run
     
    -    When pushing a hidden ref, e.g.:
    +    When pushing to "receive-pack", commands may have already been marked
    +    with error_string or skip_update before being fed to the "pre-receive"
    +    hook. E.g.:
     
    -        $ git push origin HEAD:refs/hidden/foo
    +     * inconsistent push-options for signed push.
    +     * not permited shallow updates.
    +     * encounter connectivity issues.
    +     * push to hidden references.
     
    -    "receive-pack" will reject our request with an error message like this:
    +    Take pushing to hidden references as an example.
     
    -        ! [remote rejected] HEAD -> refs/hidden/foo (deny updating a hidden ref)
    +    In order to reduce the size of reference advertisement for git-push from
    +    a client which does not support protocol v2 and push negotiation, the
    +    administrator may set certain config variables to hide some references
    +    like:
    +
    +        $ git config --system --add receive.hideRefs refs/merge-requests
    +
    +    Then, if a user made a push like this:
    +
    +        $ git push origin HEAD:refs/merge-requests/123/head
    +
    +    "receive-pack" would reject the request with an error message like this:
    +
    +        ! [remote rejected] HEAD -> refs/merge-requests/123/head
    +                                    (deny updating a hidden ref)
     
         The remote side ("git-receive-pack") will not create the hidden ref as
         expected, but the pack file sent by "git-send-pack" is left inside the
-- 
2.32.0 (Apple Git-132)

