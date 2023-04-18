Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AE6C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjDRQ74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 12:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjDRQ7w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 12:59:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3115B94
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 09:59:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-244a5ccf13eso1909246a91.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681837178; x=1684429178;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tte9X10czVpq3y1etK6RLxvERIP4PryUaClXNLUjsBo=;
        b=hsmYO1HmQJNGCuFd9Zl3/IMAG34mHZOVf/tJhI7Emq1rYwztnIc9c4WOXr4gulFvaS
         PE4FyS9EJKPsidXpqg84W2tqB/ERZ+9n1m8ghhSlIhgjXzD7t18tNeuN67HH7UUUfCV2
         mKYWHP9w1Zil8cQPeov1yQGwTIGFn6pkL6E4IMN4+8rOZXuBkg3IIihKmQstU5o52Q+2
         i2zMcJHgxmJKQph9iFIRcSBHpJhu+oF4aFYRKbbNKuLOtWUYzOfa/zq9O+QTHPa9a491
         snblznuMEUanyT8z0vqHNxuJWWFUEJuPExvoilrhWyePpcZ4mMhFtot1QDwOp+5BF0dn
         /6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837178; x=1684429178;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tte9X10czVpq3y1etK6RLxvERIP4PryUaClXNLUjsBo=;
        b=Kg3/BmlW7AB1h7kNRJqSfYF8+mFUEghCXwy3hvEWSxd0BXhL75p6rIDkTr+SQAbnVW
         /0U4tRC3hnfTexRG5TyDiVro14KePFwT3DJ5xURPd9RvLcVQX4cmJsyYdmuMSrrBg6x6
         AVTTrZZZXfCqvxXtZBno1qmWxRe3qrbXgh1LqtTD1aZN/77M8quH1HB4ZAulGyEQBtcy
         rD6hchlNpRFlkD+9qhyXot7rRJwMwgKbTv7VAen5xZCiQS7+M5bIiBCml5GdEdMn04Lv
         njCmHi8edjk9hpowUYYqLwf08028L43IiSXpIAD3TczH89A+Ai8leWXpx6oo/LaOIbI6
         fHJA==
X-Gm-Message-State: AAQBX9evKf1GfLE1izTFw8jFpezWT5MZO9esa3P+aA24iMVyfHz5n0FU
        WxLnqJVF1giUnJXJkIvXD9c=
X-Google-Smtp-Source: AKy350b1ZU1UmtCD0M74mvgHvTQNpstni5eRbbye9W9gX6rmCn60xAScaq9iOxco5UfYu45gZTJkFg==
X-Received: by 2002:a17:90b:104:b0:247:e4c:d168 with SMTP id p4-20020a17090b010400b002470e4cd168mr400482pjz.10.1681837178383;
        Tue, 18 Apr 2023 09:59:38 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id ev7-20020a17090aeac700b00246b1b4a3ffsm8903621pjb.0.2023.04.18.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:59:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] git fsck: check pack rev-index files
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
        <ZD615MLzKVwk1jVT@nand.local>
Date:   Tue, 18 Apr 2023 09:59:37 -0700
In-Reply-To: <ZD615MLzKVwk1jVT@nand.local> (Taylor Blau's message of "Tue, 18
        Apr 2023 11:23:16 -0400")
Message-ID: <xmqqjzy9dt3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Apr 17, 2023 at 04:21:37PM +0000, Derrick Stolee via GitGitGadget wrote:
>>  builtin/fsck.c           | 36 +++++++++++++++++++
>>  pack-bitmap.c            |  4 +--
>>  pack-revindex.c          | 43 +++++++++++++++++++++--
>>  pack-revindex.h          | 16 +++++++++
>>  t/t5325-reverse-index.sh | 74 ++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 169 insertions(+), 4 deletions(-)
>
> I gave this a thorough look and it all looks good to me.

This looked good to me, too.  I was planning to wait for a few days
to see what others find.

Thanks.
