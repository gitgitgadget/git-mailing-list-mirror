Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D769C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385566147D
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhD3Jy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 05:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhD3Jy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 05:54:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A76C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 02:54:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e7so81820188edu.10
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vkjcL2hqCP1vXz2lB7TK/CV6tQQBhwdBML5qdzoTfhE=;
        b=MKWBq8KjvnPWSAkZVwIfz/2fyWpFue2L63hDvkZT4KVkPLgsN3/If7MXRHHwYkNQhN
         WD5Tls1iQidm4WCVVOBPQnMKrmZ5Tbcaq7h8iED/x1dHmlnQSDGDxQWJiIsmumZwufO9
         QVjJL/4ZHhXrTUn7WslgReKsMclEXKjOjBlwsxlD7VcXkH8BjlbnIWp5cawXpSxIFBhB
         0oJtQpm/usB9P58RYofyKThJkLuuriKhZ+EL7u2FzXtL9bSm+33jMBgCItLPb3SFw45D
         JN4NFIJ/MJ1ZxbbAgrQ77KyQRp7x9fRKNjpqf2Us9A5hKjt8kMqjjsiJjwEvNdYrTQ7e
         e5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vkjcL2hqCP1vXz2lB7TK/CV6tQQBhwdBML5qdzoTfhE=;
        b=Qv5yuc4Jq1mrFNlDfA9mz4yVmDYCfpz96DjVRIM1tDPornoQVXjxFkqDHBt+tZnwNu
         3NlGWa5FpkaRmNh+Dp4udVrNY5g+2xqFPnPSGuicpfIBhApLQBVC8ferzzcXatLefubp
         SmodxiWNxfoitnZBvUB5hXt6ET+jY1ej25mhDXfYq3ZZiGxGjPSQd60OS55e4Y0G0PHP
         929oNQiVp9cmn7wnWs7jbwcgWscsSlFyK9PB6gLVmgLH3smiNeYef8NmOBIuCM9Gi431
         RXjrK3ll/Szhy5zEAcl+k+P/eJi44nEyc27YxarXwdBFJr+C/d02ZfphX6d9/8l431tQ
         /7Og==
X-Gm-Message-State: AOAM532ioh5ESMSJi29lR0lKCf7JAILRrDidKXaS5PVu4TcLbWCGYJTy
        Cn8YVLn9e8T2jSzwFUb4vN8=
X-Google-Smtp-Source: ABdhPJz6sz7a85p/bKz/RWnMlQnDLQGx3lrpvS/t5wYYgUHDiBffonilYJZdm0Uxm/3+FXt/cspp6A==
X-Received: by 2002:a50:c004:: with SMTP id r4mr4692738edb.192.1619776448428;
        Fri, 30 Apr 2021 02:54:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d23sm874102edq.19.2021.04.30.02.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 02:54:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v3 05/30] subtree: t7900: comment subtree_test_create_repo
Date:   Fri, 30 Apr 2021 11:48:36 +0200
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-6-lukeshu@lukeshu.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210427211748.2607474-6-lukeshu@lukeshu.com>
Message-ID: <87tunoxfls.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Luke Shumaker wrote:

> It's unclear what the purpose of t7900-subtree.sh's
> `subtree_test_create_repo` helper function is.  It wraps test-lib.sh's,
> `test_create_repo` but follows that up by setting log.date=relative.  Why
> does it set log.date=relative?
>
> My first guess was that at one point the tests required that, but no
> longer do, and that the function is now vestigial.  I even wrote a patch
> to get rid of it and was moments away from `git send-email`ing it.
>
> However, by chance when looking for something else in the history, I
> discovered the true reason, from e7aac44ed2 (contrib/subtree: ignore
> log.date configuration, 2015-07-21).  It's testing that setting
> log.date=relative doesn't break `git subtree`, as at one point in the past
> that did break `git subtree`.

This commit message is too much about describing the journey IMO. We
could just get straight to the point, e.g. something like:

    Add a comment about why the git-subtree.sh tests set
    log.relative. It's to test that we don't have a regression of the
    bug fixed in e7aac44ed2 [...].

FWIW I think just having an isolated test for this would be better, but
since you're just refactoring existing code I think this is fine.

I.e. we'd use "git init" in the rest, and just have a test that stresses
this specifically. Or is the entry into git-subtree.sh so varied that we
need to "fuzz" all the tests like this to fully test it? I haven't
checked.
