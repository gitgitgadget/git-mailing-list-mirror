Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E0C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 17:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05D161465
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 17:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbhKPRsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 12:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhKPRsy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 12:48:54 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8977CC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 09:45:57 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id e14-20020a0562140d8e00b003bace92a1feso89490qve.5
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 09:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bkjSgROit3fTBZwrghYItgbc6u9l1ruNnOYCJXmUsmI=;
        b=n4FLto2APsVSt7ZXqBZd+292pgEb7fvSwsTFJbCnCKB6Gas7RdXgCeWW1AloUAX15o
         414AVniDM/5i8uBhu+K/mniPY7n2ZGn3XQl1OuCcRMY/aTzesW9e5l3lN1lRmjgEDBMt
         32QYFQsD9GjL2DCpIqvQizoQD4omYuGZ93B/AEtGXBCSuKZanJydLpIyNx9tOpOJZ7LA
         I1sdiCKGowVneCzmtGckSnf8Oy2mrntFH4neyQz36P7mirRkqubLCg5GsgpkLL1UDpDI
         OIj85IszQtst2JXXSPHY9WNa+newP7odEJdMd9vyYFxFa/F6JC3MROMyeGN5FmzgIN9U
         d+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bkjSgROit3fTBZwrghYItgbc6u9l1ruNnOYCJXmUsmI=;
        b=rwyKAruSoB1fU+xLMlXoPGQzCOurGw/03FveQvJXFimANgjmXsC48ODpsYAdQZGtP9
         /CrLacD3PGxZCtj8EWqJWkeZWqfAA79LjHVb3nLe6ZAe2cs2wGvEKtUn7D8KITy85N4K
         0XN2sL82qo4sSyH6Ji++IyODekXMHEnlYmLk0fd/XWyO2QdXu//rEf9M8z0XXaXvA4B5
         /rGIwXI3iMzM8VPbvdvXQ4yi8w5xN7dlOqhdeZ2Y8asde6a27VOKx2H8UvXs5gf8vzaj
         Qrm4LH2l9QCAEk4s54GHEeXPZm7uU0APEbbJpv3fzqqlVA9Zgz4aJrATXQmGcv1yIfBP
         zqJA==
X-Gm-Message-State: AOAM530acmjPAtC9BKJOKlnQQkBtF14zTPKAIQUwOBkMO83ACJPhkkCT
        ujJrccsdAX9ScezPH1lcOh+R2vzIp/YLMDdL+n8M
X-Google-Smtp-Source: ABdhPJwRiqDW8CBzMLrAYgsx69zrJpe+6MJShu3k9VfabNOZxma8BFvgcB+5x1BSxVZL1z5DgbRjFhW/lqMg8jJHHx2C
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ac8:5dc9:: with SMTP id
 e9mr9518723qtx.12.1637084756681; Tue, 16 Nov 2021 09:45:56 -0800 (PST)
Date:   Tue, 16 Nov 2021 09:45:53 -0800
In-Reply-To: <kl6lo86ltc9a.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20211116174553.2300029-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6lo86ltc9a.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: Re: [PATCH v4 5/6] remote: die if branch is not found in repository
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> > Couldn't we just iterate over the array (instead of making a hashmap)?
> > If speed is important, I think we could just sort the array and do a
> > binary search.
> 
> The primary reason I used a hashmap is to be consistent with struct
> remote (which also uses a hashmap). One possible argument in your favor
> is that remotes are often looked up by name often (and justify the
> hashmap), whereas branches are not looked up by name as often (and don't
> justify a hashmap).
> 
> I say _justify_, but I don't see significant drawbacks to using a
> hashmap here. I suspect that there is an advantage to binary search that
> you haven't made explicit yet? Could you share your thought process to
> help inform the decision?

The main drawback is that branches are now stored in 2 ways - as the
"branches" array in struct remote_state and as this new "branches_hash".
I think we should avoid storing the same data twice unless we really
need to, and I don't think there is a need here.

As for hashmap vs array (say, if we were thinking of removing the array
and putting in a hashmap instead), I would still prefer the array
(sorted if needed) just for the simplicity, but I wouldn't feel as
strongly about this since there is no duplication here.
