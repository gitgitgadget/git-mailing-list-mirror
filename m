Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0223C61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 22:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCMWlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 18:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCMWlq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 18:41:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A04132DF
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 15:41:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so13259835pjp.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678747305;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dH7VkbkX5kOVkfI1QSl7+3ndTI4EzaWU3G84UGdxWfU=;
        b=U5jD081lzuiG5Wath9KdFa5tz1bZDfREs19ITWGCSJedZQznYNF+zNSUXUibF7GiSI
         eSKxlrJ+aswDkuqiYj+RxEMiy2VzR5I9ke7G+nJCq4/lhPaSXDqrSHe2iMWEouDz5z54
         dri/rgqwhBfyRLs4VEmtwqwNV+iTq+F7BAS0SpJuZClS29CRKFjk8x2RmKjyb7UFTRHg
         fRCkwFBGcUA13T0Xn9uYms8x3FwRytYsdEO0sDk9jNTe4vrTmPmjf+bYmo7vi7BMCiqZ
         VD5UxdfBsQBwPcxWNb4G+aF1G8GxTahX4/AWwQZmLLaPqTgjEREhdMqZm77D3ZMZgLWI
         3Hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678747305;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dH7VkbkX5kOVkfI1QSl7+3ndTI4EzaWU3G84UGdxWfU=;
        b=eWKBfYD5q6cFrn+iYdFrQNmj8vKYU8IGBZxMmfzdTxXIeFauHPtYNbZlg+JTxoz9KW
         mRAueAGF8UobuPiUqglEdx4f7ErqBDlfpc6pxb8rFJ6ahSR3l6irthfXNWS9PX1y/DKP
         mCvsTq5c8vqT8brzpOMgy2K9PRTGYBTrPPDJDMJVuhkNhuP1Ev21qpYmm7TmtrQ8e9uH
         /uKlNkBk91cT/nv9BfdVYtTdC3yS6OsfqpHFYOx9j98YdUJAshbPJQBZG8q0G+vAEy7a
         IMcpPEyitPIBJEKs0po4R4Hg/k7EFPvVREZSb9St9Va/xUCDxC6+C3TlNbm7zOuVa1Eu
         6GBQ==
X-Gm-Message-State: AO0yUKVxL6cEVjze0EmXh5AR3BjvctY+GSvFAZhPD+fkx1XAFwdkLa/Y
        1b3EPjjxHLAzew7hs/v1tOI=
X-Google-Smtp-Source: AK7set9yzT9/ehrpn0XmYQf6dp85YM+bqzjqkWx9VUmu2YviMPljUzI5ii/gwx917v1AvQ1M2loKlw==
X-Received: by 2002:a17:902:c94c:b0:19d:20a:a219 with SMTP id i12-20020a170902c94c00b0019d020aa219mr43857750pla.66.1678747305361;
        Mon, 13 Mar 2023 15:41:45 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902d4cb00b0019f9fd5c24asm328911plg.207.2023.03.13.15.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:41:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael J Gruber <git@grubix.eu>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v1 0/7] t: fix unused files, part 1
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
Date:   Mon, 13 Mar 2023 15:41:44 -0700
Message-ID: <xmqq7cvks28n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Here are the fixes for the issues I've found so far -- I've gone through t0???
> and t1???.

I think it is better not to insist that a failing 'mktree' is
silent, and I think the filename "unchanged" is understandable and
is unfair to call it "misleading" (but the patch itself to remove
the line that creates the unused file makes perfect sense).  Other
than these two small nits, I found everything else in the series
good changes.

Thanks for a pleasant read.

>
> Andrei Rybak (7):
>   t1005: assert output of ls-files
>   t1006: assert error output of cat-file
>   t1010: assert empty output of mktree
>   t1302: don't create unused file
>   t1400: assert output of update-ref
>   t1404: don't create unused file
>   t1507: assert output of rev-parse
>
>  t/t1005-read-tree-reset.sh    | 15 ++++++++++-----
>  t/t1006-cat-file.sh           |  3 ++-
>  t/t1010-mktree.sh             |  6 ++++--
>  t/t1302-repo-version.sh       |  2 +-
>  t/t1400-update-ref.sh         |  3 +++
>  t/t1404-update-ref-errors.sh  |  1 -
>  t/t1507-rev-parse-upstream.sh |  6 ++++--
>  7 files changed, 24 insertions(+), 12 deletions(-)
