Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333EEC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 10:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjEAK5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 06:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjEAK5t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 06:57:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99EB19D
        for <git@vger.kernel.org>; Mon,  1 May 2023 03:57:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so2728160a12.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682938665; x=1685530665;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ux3yGhumXTx8tAtkBYmwMYccU5IZ5acsfDYzKClHY9Y=;
        b=JdDGlBEvk4VWRsL5uu5DsvuwlfISaWyO2SqoBGvJvOwI7jvIxvUDDc7fKBTjxBW/3S
         /lSmIvZIQYSRzy6HPvMqs+uWnfFg6OCW0MHZaByfWmYUgmSagjbSz/4YhNvlSf4b+0jS
         QkSEaIAlyOYnvmxbmoJdfxyFNoAG1/bFcWeLBJlqgnDMsktWdH+EZBFkfC7fYtq6py+0
         mqmEcQX97oCbvum1EHmkRwTMvwfPtX9dOWFIKJFxBh1c5SYqt9DSRD8TII7BXcAQXZJH
         t7uxLQY3si5/OtUm8jdM+fptMPx8ZKYFT5NeQcEbd3OrIma53ABi7QOogNE4X+wNWVLA
         524Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682938665; x=1685530665;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux3yGhumXTx8tAtkBYmwMYccU5IZ5acsfDYzKClHY9Y=;
        b=aFUBUkPpOSy93Yi3APD0FCIgB33o06y+C1oZIduJ6QQZsQ3drwgNAXhzBKPtG93CyD
         VxHrl6iWHKndz66AEzmYtuO0OTHHB4N/So8JEECBslAnYre2ntWYgrWZKOfJtlyysPf5
         JAI2LcF59ziQKES6sYFV71skxmHRQig5Ri3qSxJdxZaTahrwjV3EPc0O9ffBJLAbUa+u
         HGtcOSWzUZuocOqGxYTpiWSYuWQeEBhec7zjZsCbkUM5p/At12owgmdneo2UyjsRpv0t
         FlMJMxnftS5fFnmWNU5RCiz6Yxz7XYI1wGHsgonydeAnT3k3c91xjX9aVsTN/j8npn3T
         DOAQ==
X-Gm-Message-State: AC+VfDzm8njaYDZQHHUuXds5f2hgrD2yQeOQqBmr75nFIxGC2MfPAEwr
        378pzQvzt2HzSAFsR31axcqoy0nZXbs=
X-Google-Smtp-Source: ACHHUZ6q43vAZjj2zLYecy5EbfSF4r5STp4UMiWF9YPE2VVkKTxUgFg+oQBTrPlxgLRTqrfAhQwLdQ==
X-Received: by 2002:a17:907:988:b0:94f:17b7:c4b8 with SMTP id bf8-20020a170907098800b0094f17b7c4b8mr13962376ejc.19.1682938665298;
        Mon, 01 May 2023 03:57:45 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906854600b0094e84314762sm14572614ejy.187.2023.05.01.03.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 03:57:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptRE0-0002td-0p;
        Mon, 01 May 2023 12:57:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 1/2] cocci: add headings to and reword README
Date:   Mon, 01 May 2023 12:53:19 +0200
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
 <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com>
 <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1682634143.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1682634143.git.gitgitgadget@gmail.com>
Message-ID: <230501.86h6swjp3r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 27 2023, Glen Choo via GitGitGadget wrote:

Re subject: I don't per-se mind the "add headings" formatting change,
but doesn't it have headings already? I.e.:

> -Git-specific tips & things to know about how we run "spatch":
> +== Git-specific tips & things to know about how we run "spatch":
>  
>   * The "make coccicheck" will piggy-back on
>     "COMPUTE_HEADER_DEPENDENCIES". If you've built a given object file

I think it was clear before that that was a "heading", at least in the
sense that it summarized what the indented part that followed was
discussing.

I think what this is really doing is converting this part of the doc to
asciidoc, but is anything actually rendering it as asciidoc?

If we are converting it to asciidoc shouldn't the bullet-points be
un-indented too? (I'm not sure, but couldn't find a part of our build
that actually feeds this through asciidoc, so spot-checking that wasn't
trivial...)

