Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D7AC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD4B2072B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+NcoznA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390154AbgAPW46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:56:58 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50294 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbgAPW46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 17:56:58 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so2266988pjb.0
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 14:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jGyPBvzifQYQTJjvaD/9FqJPYFOq+dFXJR44EZ5Wf90=;
        b=f+NcoznApd9UYFsPt2U8ZVe+VMKYzghOkLFZSXhr2M250eM0qqfYpVLn/MWRtKzY7e
         +0W+srKpAQL+KxwE7Syx4Gq7TpPn96NVAr3cpfnUlf7FsC0UAaQ4pb30RU8Wt22/nykF
         DI2D96kUnwhsO50zt+BdOfD+hK7RP0I4ALIdwQoYvMhrdLlgHJtKCuf1iOGBsmdZxtT4
         Gzt4Os9m4XieGxdrEU6zWJGHAyV3DeyYR58izjk5zriOVBSdiwACCofjdFD//izZlQYW
         Da1nOndolnbzi0veVXBUiFrGTXpPy87InMuAKzpJAlACMXN2TxAZqTixQ0lRH2lyLQSC
         D8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jGyPBvzifQYQTJjvaD/9FqJPYFOq+dFXJR44EZ5Wf90=;
        b=dpE1NyCk4G8WRpo+ZgqwlxhNDcCiKzSP+ZZ4RJgmri9mWyufQ2MAKQiNUYD4ru/ze6
         90JGZqI4rVfbTqt4ht0qxE9q/SleEgzePROwhq9O1KCyW1fXrhtXRtbMkR0x0fUumcIZ
         ik9RbjCVUVw87f+HhfsoMy7cRkEeUqDlBdjX9KKkxRA3SQysDudqeFEDoqrycRg8By56
         vxM7/8dNxpO0A/3HgNBU2mAowVnyVDrZIKFZXXqHUOJYr+P8tphk3p0IlL1RI1m/LNCg
         KbE0QlZeOGa67ivXkg75KRxOMe2EciIF+sF2d025Zvp8IKcZX9QfS2YGOcI1uRjZIFH1
         xqwQ==
X-Gm-Message-State: APjAAAX84/HZpjxTpFq2wGH7V19+GOBsdWf5CyJmn7G/uJsjj6gYVNPf
        81oBEZHzZmZLGQnIxl3q/XdLB7E+
X-Google-Smtp-Source: APXvYqxZYdT9JtWWvWZ18wqWgh/AisBTcXn8EidjujnBhvAGga/0RdU4Y6IobDRWdifXRNWni3XQsA==
X-Received: by 2002:a17:90b:3004:: with SMTP id hg4mr2023195pjb.52.1579215417387;
        Thu, 16 Jan 2020 14:56:57 -0800 (PST)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id b4sm27379879pfd.18.2020.01.16.14.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 14:56:56 -0800 (PST)
Date:   Thu, 16 Jan 2020 22:56:55 +0000
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4018: drop "debugging" cat from hunk-header tests
Message-ID: <20200116225655.GD71299@google.com>
References: <20200116175138.GA691238@coredump.intra.peff.net>
 <20200116183423.GA3011203@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116183423.GA3011203@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> We run a series of hunk-header tests in a loop, and each one does this:
>
>   test_when_finished 'cat actual' &&      # for debugging only
>
> This is pretty pointless. When the test succeeds, we waste time running
> a useless cat process. If you're debugging a failure with "-i", then we
> won't run the when-finished part at all. So it helps only if you're
> running with something like "--verbose-log".
>
> Since we expect the tests to succeed most of the time, a better way to
> do this would be a helper that checks the output and dumps "actual" only
> when it fails. But it's probably not even worth the effort, as anyone
> debugging a failure could just run with "-i" and investigate the
> "actual" file themselves.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just noticed this when working with t4018 on an unrelated problem.
>
> I could be convinced otherwise on the final paragraph, but I think it
> would only be worth it if we added a general test_grep() helper and used
> it in more places.
>
>  t/t4018-diff-funcname.sh | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

Sure, a test_grep would be nice for CI cases (especially for
Heisenbugs), but in its absence I agree that this patch is the right
thing to do.
