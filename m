Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896E8C43214
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 16:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739556023F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbhGZQGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 12:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbhGZQFA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 12:05:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AB7C06179A
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 09:44:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a188-20020a25cac50000b029055d47682463so14797328ybg.5
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=enzXcyq1jLf0SEU+bHNA4m6fUieHRh3bsDp3iTrs78Q=;
        b=G6AfqUGKQ65K19bQBFVljQR4D1NU2IxisY0hvVkxw5ei6WyF3oT3nLPWrZBdTO2WJT
         4TPwHWs24mcJ5kcZQiXFyjp3IJPneHtcDjKMHt5XXnHmlmCo35Fzqbj+iYo201TO8p+m
         ib3DhCn/f49NZwCzXQNuSdcwLr7+qR/mplDLwM4mNs+0kUxYygHFWAXdn3TZ0A3xT3Gz
         nQLABosiC8Q6tfT0pp8WA/N9pW59IshwWYxRYTFrpub+fCk6z3MVNwpg8gmvkB8gaeYz
         fpra7tOcaQ8/b++RyiKYOCQ5/tae+2qmjm7gejHMkL3Wg9j9QwnbC+VkmDhdjYiIbXs4
         NUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=enzXcyq1jLf0SEU+bHNA4m6fUieHRh3bsDp3iTrs78Q=;
        b=D54JMDb4icBzhZyFXXFJrRe1AImFIoqvsIZGPwKeAF88XYceQHo+9GZ5koRSvfHmkl
         0Oe5+nt86hEzZrWwxvxhg9siCyK/ghwFikoZEWSS0IJs+yKiw58yQHRngRApOQRJqY9A
         SgTlMTLPTJ7zkkhW/TpjA1vtQoL7bX+ZMUd2lSD33d8IlNsweVO4iSa+chkgGI5+Gkv8
         8VRk2cEdgxl4rKK//XFcN+AVt9ifFw1IbKvUE3CL4XEinzKrBI7nbyo0PoLNxNY1K1Q2
         mfOqHY9hWm3917n6rFPtDgAG6nx68L0L5FwNfbqXGhM8x7psp3gERdcldo6wt7gZ5Iaw
         scdw==
X-Gm-Message-State: AOAM533grQYLe5V05+eIy9jzgzOYjiQzPFvVoBpNbJcYFhi4ofqjdJd7
        +va0aq1ycqtFhKfgWqAyeCkAXa3+iZ8zBM2y9lXh
X-Google-Smtp-Source: ABdhPJxTkKZ35cmxcOKbXFS9WH+0+C90ZYjGPIHP7K+Jbt6yfVLWfYBOUDap7+jpWZFs1oPMZPEOoqXcO01Y8i/Sh1bA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:b98b:: with SMTP id
 r11mr23732383ybg.189.1627317859191; Mon, 26 Jul 2021 09:44:19 -0700 (PDT)
Date:   Mon, 26 Jul 2021 09:44:14 -0700
In-Reply-To: <pMV5dJabxOBTD8kJBaPuWK0aS6OJhRQ7YFGwfhPCeSJEbPDrIFBza36nXBCgUCeUJWGmpjPI1rlOGvZJEh71Ruz4SqljndUwOCoBUDRHRDU=@eagain.st>
Message-Id: <20210726164414.2208736-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <pMV5dJabxOBTD8kJBaPuWK0aS6OJhRQ7YFGwfhPCeSJEbPDrIFBza36nXBCgUCeUJWGmpjPI1rlOGvZJEh71Ruz4SqljndUwOCoBUDRHRDU=@eagain.st>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: Re: ref-in-want does not consider namespace
From:   Jonathan Tan <jonathantanmy@google.com>
To:     kim@eagain.st
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        bwilliamseng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Running `ls-refs` with a namespace-relative
> >
> > `ref-prefix refs/heads/*`
> >
> > will work as expected
> 
> That turned out to not be entirely true: it does work as expected with a
> 2.31.1 install, but fails to select any refs with 2.20.1.

Your expectation that "want-ref refs/heads/main" should match
"refs/namespaces/foo/refs/heads/main" when you run upload-pack with
"--namespace=foo" makes sense to me. Just to clarify - does this mean
tha 2.31.1 works like you expect?

In any case, t5703 should contain a namespace test, but it doesn't seem
to. We could just use the one in my original patch [1] (thanks for
looking it up, by the way). Would you be able to contribute a patch? I
see that in [1], I had my own helpers to construct the input, but
"test-tool pkt-line" now exists (as you can see in t5703) so you can do
that instead.

[1] https://lore.kernel.org/git/d0d42b3bb4cf755f122591e191354c53848f197d.1485381677.git.jonathantanmy@google.com/
