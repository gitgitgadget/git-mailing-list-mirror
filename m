Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214C1C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 18:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCFS06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 13:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCFS0y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 13:26:54 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ACE74323
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 10:26:29 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z10so6128302pgr.8
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 10:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678127188;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XS5kieMOAg6txzOLrRpfb+c3qO8F3Bb4aOaL3fCzrdQ=;
        b=B0na/7WR9IX9HynIUL7td9ztuDGLEbBkTauevBvW2C4+MPKNyE04qDRMEaaSKSlqyY
         JvPPEJhZVscQkj9jd3E9T3/0S91RWVgWWKSJtHtAxjiwI//g16XPTvJmywHvPKJMh0qE
         zmwpkZJ1SQVL7FE2NyOVXkIxzI5akq2AJC3csbAd4sV+EexWG6YF24nXYhSuuCgj4aLP
         lTVmlD1Uon2Uh1F/Fuhl2oCfGZB1XtldHF9M5FwlJuwRrAtg0WbVB3g3AmzBsbrEvoe3
         Z2m3R4Kxm0BHDXysAHOTI5NaLEa6XT3ajccGAyGIxj0gWtfkKgxPl4ckv30HkRtggbb3
         t8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678127188;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XS5kieMOAg6txzOLrRpfb+c3qO8F3Bb4aOaL3fCzrdQ=;
        b=0RPY1zvGGtvvR4bUtowfviNbw0irOACK/6GXShVqezSDGOnumF4QevNkms+kZ/pnzA
         qmL7aqFAzxGL3YHYOmW+VEPSJIoFuT3BMzkrD6l7hPUL5BTd/UUirhoJG5YsBhL4Fwmc
         udFOghHratVnHWTJE6eotVX+BJ+6WsQqOPW2nWX3cItWdGsIhkpy6SAoaMVxQboMcxPr
         eU4TU9CiqZ1ibP7P4hquFYTYP2MQiWx9Pt/6fwN8S6XKV2i1YSwvhkw+nvIlMgwbXLfR
         i96AET+tOmeVKRZlwklX0QcUTHIAI79aAV3XHJjQ4t+KlIVoaFImdWfFf8k8Z3Hic5Z5
         YzHA==
X-Gm-Message-State: AO0yUKWBX8y5SsWrMtZjCcc+PoIxy5Y7yUB/tXCqNQtmNDaL8iFFjTwg
        /2ZUuktbzL7nA7qXIbKwYRk=
X-Google-Smtp-Source: AK7set8il9NVRpRlKwbRqI+ztiQSaxXxoiFDNDsV5FSa45pNB3OrqyQJrYFQ1lCJMtKvCIwfq3JMtg==
X-Received: by 2002:aa7:9af5:0:b0:5aa:4df7:7eef with SMTP id y21-20020aa79af5000000b005aa4df77eefmr11816834pfp.6.1678127188066;
        Mon, 06 Mar 2023 10:26:28 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id k17-20020aa790d1000000b005907716bf8bsm6628889pfk.60.2023.03.06.10.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 10:26:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/8] ahead-behind: new builtin for counting multiple
 commit ranges
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 10:26:26 -0800
In-Reply-To: <pull.1489.git.1678111598.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Mon, 06 Mar 2023 14:06:30 +0000")
Message-ID: <xmqqedq1ag8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> These numbers can be computed by 'git rev-list --count B..C' and 'git
> rev-list --count C..B', but there are common needs that benefit from having
> the checks being done in the same process:

This makes readers wonder if "git rev-list --count B...C" should be
the end-user facing UI for this new feature, perhaps?

Of course if you are checking how C0, C1, C2,... relate to a single
B, the existing rev-list syntax would not work, and makes a totally
new subcommand a possibilty.

>  2. When a branch is updated, a background job checks if any pull requests
>     that target that branch should be closed because their branches were
>     merged implicitly by that update. These queries can e batched into 'git
>     ahead-behind' calls.
>
> In that second example, we don't need the full ahead/behind counts (although
> it is sufficient to look for branches that are "zero commits ahead", meaning
> they are reachable from the base), so this builtin has an extra '--contains'
> mode that only checks reachability from the base to each of the tips. 'git
> ahead-behind --contains' is sort of the reverse of 'git branch --contains'.

I thought that the reverse of "git branch --contains" was "git
branch --merged".  "git branch --merged maint ??/\*" is how I cull
topic branches that have already served their purpose.  

Isn't closing pull requests because they have been already merged
the same idea?  "git for-each-ref --merged main refs/pull/\*" or
something, perhaps?

All of the above are from only reading the cover letter.  I'm sure
I'll have more thoughts or even change my mind after reading the
patches.

Thanks.
