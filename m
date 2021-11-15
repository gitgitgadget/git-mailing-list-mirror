Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409B2C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E02361131
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351427AbhKPA0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350266AbhKOUXD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 15:23:03 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ACAC02554D
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 12:06:11 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id z5-20020a631905000000b002e79413f1caso1607015pgl.8
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 12:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TcY0BH/2XKbkoD9yLcPs5vlB94VVAYxrGywL9y+i13M=;
        b=TxFwH06wAeWJaxM+sQwn+Fs4VNNqy7EDCPQdrY8JH/LkNhBrGrCwDqntGtp3pGFneC
         bAasvI+Ac0QPaTKAOaeL0RVpU5gvryNy9TI8NfHMppZSo1yLcf+2LIyEzWhp+oIsxezh
         GlGL6VVO9J86LivjBYXP3V9nBwONu2znuthhSBmMg82E7GPnoLbX+iuainJXd8vqbkeg
         xrIQxZFdBdkWLDdIpb52TEe2/oRtO/ssIRKZUUi7Z8dwqIipOgCasNesvs9RDOaq5dg7
         W4/CTfcweMK28cxcK3qFBO2D8ShiE6DdrrDRZZPv+QnA7FPwzcZtHGLOmlbJ2sQAc7z+
         aiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TcY0BH/2XKbkoD9yLcPs5vlB94VVAYxrGywL9y+i13M=;
        b=xRL+D2L0vT1J8rBtjtC3abQ6PzWRsqjZZongyt3RYLhjE6wW7z3YAWFqOp/WJfuVzJ
         VphDktqqxHO4CkQR/QocZYxOUpqqYqKmnFoOqh5AuMaxJuX7xQpjxK3UmebsW4ekVNLJ
         1YW7ugaKp3MKuiwNZ/nwyOzJuKgl/astK6Vutyg2xqzPZcvMqJqbB/EH3uDmwzBy93M3
         ouGO1+3ihNwhqElfhIkGCqeNVQl39MLv3H2q/GEZF5pQ7Xr2+7QwmfSMykn1ZoiaAn+z
         B5tVv4Fy+1jV0JU+mYOjDVKqix083hkTS6Ag1umR09eaeirjVLEFV4j+iWuSYY9ZUF2x
         WL3A==
X-Gm-Message-State: AOAM530LZzuEJR+0MOpOdpnfpfqzEgJRFHR0fQs/OeNTQBLez5t/7lro
        sbSTBoqlKJDNiHkntGlj+peCUoYFBnQN4w==
X-Google-Smtp-Source: ABdhPJzPGtCxaGeGw+KxZJmjyA1l5NOgvgn+NCmezeL5Xl0YCys73j6h+1xnxCrj41ppP4gP58htkp3Vv8wtEw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:1a55:: with SMTP id
 21mr1529056pjl.240.1637006771265; Mon, 15 Nov 2021 12:06:11 -0800 (PST)
Date:   Mon, 15 Nov 2021 12:06:09 -0800
In-Reply-To: <20211115185029.1081720-1-jonathantanmy@google.com>
Message-Id: <kl6lo86ltc9a.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211028183101.41013-6-chooglen@google.com> <20211115185029.1081720-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 5/6] remote: die if branch is not found in repository
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> To prevent misuse, add a die_on_missing_branch() helper function that
>> dies if a given branch is not from a given repository. Speed up the
>> existence check by using a new branches_hash hashmap to remote_state,
>> and use the hashmap to remove the branch array iteration in
>> make_branch().
> This makes sense, but how often would this be called?

This affects most of remote.h branches API (branch_get(),
branch_get_upstream(), branch_get_push()). From what I can tell, I don't
think these are called very frequently.

> Couldn't we just iterate over the array (instead of making a hashmap)?
> If speed is important, I think we could just sort the array and do a
> binary search.

The primary reason I used a hashmap is to be consistent with struct
remote (which also uses a hashmap). One possible argument in your favor
is that remotes are often looked up by name often (and justify the
hashmap), whereas branches are not looked up by name as often (and don't
justify a hashmap).

I say _justify_, but I don't see significant drawbacks to using a
hashmap here. I suspect that there is an advantage to binary search that
you haven't made explicit yet? Could you share your thought process to
help inform the decision?
