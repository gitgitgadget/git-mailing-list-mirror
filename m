Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADB6C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 10:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A022054F
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 10:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjFW9DGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgHKKKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgHKKKs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 06:10:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3063BC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 03:10:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v9so12874727ljk.6
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XeQi6uNn31Vh0pugqPxAX2XTvdtSYYzEo8LPYen5TUU=;
        b=bjFW9DGqCPswp8wR8ILjoMa8lpUbfsbb2lefGKdB8bPV3OFhfoyqqs5zGCjm3Eldl3
         XWTbflbEpe5uvVmJIiUECU+Hc724oCmtXo2uUJoNDSzfz0phU5DRbn5pmad7asnJz1Cl
         l5vTU7VNptgKZJv4YBOt1kBNo2YpRYMu2iyTy6QojvgaP004z6UOzZnBWuQJV4C+7qZ2
         LWI1W1suYZQPdpA4wQsj1zIKrazvQuqSdO0li7DPxKRw+UP68PagnXhpBBdm1q5xAIRK
         03AkCdH6PYYOzasyOerp7PoGDq7MqZaWOYJRj4KcuyTm801Qa2g5dmtAWFJifwJ66/Bj
         m6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=XeQi6uNn31Vh0pugqPxAX2XTvdtSYYzEo8LPYen5TUU=;
        b=lY/xU9mCBfVRZWjeDxU7S6ItIeoG/mnlMoXA+zFLfq7Y9PwuoJtTZK6KKDdUsQjp2l
         VVzZW6FwZ0Mq2rf84QIW/D2al4pvpQEKDlwKmD8tONGCODoCURuY3ZcP5fNvvcu7bzUy
         QYzKbriLLbqE4WHc3k+cGIh3UBxhV0d/G43kHwO7sPHdJbZnKqCfCjjjozHek9fmrNUB
         WhjMXFgRvCQvAREAqE+UyVb/k69AtPL/rAyzykuS+SXwsbkkzdCmaXAxPJXN12/ukbfy
         c3B8GGuZBsr/wlAxo3+xzRbssLcMyiK1wKt+S+0gYZB2CUwtu1PxMEDS/vUN6idNLmro
         18rQ==
X-Gm-Message-State: AOAM532LzSlyZYc3nXuJey9MQPvrdll0MQNVmfDD0BdkEWqCi3SwkYzB
        h0J00kR+vZgLvBJ2YQdxsz42o6ob
X-Google-Smtp-Source: ABdhPJyO7Z2KXaosV2s42R2ZlgmDIt6bD4hjI77Wj/qY5RS1x0aGPh0Vy1T39v1clvu6EtFEGJIsyw==
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr2575944ljj.188.1597140644984;
        Tue, 11 Aug 2020 03:10:44 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u9sm11530437lfl.75.2020.08.11.03.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 03:10:44 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
Date:   Tue, 11 Aug 2020 13:10:43 +0300
In-Reply-To: <xmqqsgcub811.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 10 Aug 2020 12:44:26 -0700")
Message-ID: <874kp9biho.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

[...]

> * jk/log-fp-implies-m (2020-07-29) 7 commits
>   (merged to 'next' on 2020-08-03 at 39fefa6b82)
>  + doc/git-log: clarify handling of merge commit diffs
>  + doc/git-log: move "-t" into diff-options list
>  + doc/git-log: drop "-r" diff option
>  + doc/git-log: move "Diff Formatting" from rev-list-options
>  + log: enable "-m" automatically with "--first-parent"
>  + revision: add "--no-diff-merges" option to counteract "-m"
>  + log: drop "--cc implies -m" logic
>
>  Originally merged to 'next' on 2020-08-01
>
>  "git log --first-parent -p" showed patches only for single-parent
>  commits on the first-parent chain; the "--first-parent" option has
>  been made to imply "-m".  Use "--no-diff-merges" to restore the
>  previous behaviour to omit patches for merge commits.
>
>  On hold a bit.
>  cf. <20200804200018.GB2014743@coredump.intra.peff.net>

I believe I've submitted resolution for that.

<20200805220832.3800-1-sorganov@gmail.com>

Do you expect anything from me to push all this further?

Thanks,
-- Sergey
