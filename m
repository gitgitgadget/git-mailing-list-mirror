Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB396C46467
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 01:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAEBjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 20:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAEBjX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 20:39:23 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E672018
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 17:39:22 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 78so23556230pgb.8
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 17:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pIhhHrEopZ+CCCEo2ntc60HbYxLTdWXakdHDw3vUHI=;
        b=iiuIBKSjoo0fwf2HVG9x6qzpT9qLn7XtFFAsuG2hyiS9ox/2uWwoYrwb3mxn+4x5tT
         zXbl/8EVz7nCm2/xG8jHo/e/0t5csZen9NZBMzINpaaFY99I8XYit9U7mZAWHQW/Tz5s
         ExVFLUJBC2SIl1rRMFSl5smscMUxUFLNiwMSF+6gaoEZ7GmnxWHssxe7XH8H5XcrORvS
         D3XnFcShWzoWfUyeZgH8kYUxBWNe8/Zx0/+WZA6+Fy9F+9w+g2XSVZupxoP2mys5/Z/r
         llojVtRD9X3/UOY5wyMyCCn3layBiKTRHfreqHuqS2E2z8PiBs4PEIUk5TlxL2oxIJOm
         QIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6pIhhHrEopZ+CCCEo2ntc60HbYxLTdWXakdHDw3vUHI=;
        b=EfOOIal4tPv/Nqm6y/IuW4oOu+SXWDRV+BQdY1UsJYMIvHzXP3lMLIlvztPU1VSn8l
         os6pdstJRORb11UU37UvSKwHUun1a+2n46o5OOGdV8dAYeUm+X9aythtLIA+XpgdsSfC
         QBRR6HTQY2UjwqICdfg2cz2LThuA9+9QOM9+rcg7iRMltrgd1xmmaHggMB6OnKtM6IqY
         8aJ7kszTNoo/3fgMIKewxecI0jeOBsFNezMl0VQaR+N8gbMYf5iQYq8y5lpEDUan7dDm
         EECD5GHoxAB9/5CbjofNTgKChcyj86rsvb6CQPEwQ6tY/SyKSxxH1heegQ2glIQx+pYf
         316w==
X-Gm-Message-State: AFqh2kq8tvZYgEFulX9Xn7SfRG5RAtYJqdAb1C5hmpqezQPl6iMAMFy9
        /LBt9kApAdleUgCIMest1lE=
X-Google-Smtp-Source: AMrXdXtzu23a223+YJ5n52IaTgiRfSVdod+yl39C71zUvEpD5KwyK/LdbI4Zojpiw/hdz03fO1Gcow==
X-Received: by 2002:a05:6a00:4c82:b0:582:8d34:7253 with SMTP id eb2-20020a056a004c8200b005828d347253mr11442561pfb.20.1672882761670;
        Wed, 04 Jan 2023 17:39:21 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k201-20020a6284d2000000b005822ce3b2acsm8952874pfd.115.2023.01.04.17.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 17:39:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 2/3] repack: add --filter=<filter-spec> option
References: <20221122175150.366828-1-christian.couder@gmail.com>
        <20221221040446.2860985-1-christian.couder@gmail.com>
        <20221221040446.2860985-3-christian.couder@gmail.com>
        <Y7WTuQvoHEWRlEA4@ncase>
Date:   Thu, 05 Jan 2023 10:39:20 +0900
In-Reply-To: <Y7WTuQvoHEWRlEA4@ncase> (Patrick Steinhardt's message of "Wed, 4
        Jan 2023 15:56:57 +0100")
Message-ID: <xmqqa62xu5dj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> While this is a nice safeguard, I wonder whether it is sufficient.
> Suppose you for example have a non-bare repository that already has
> blobs checked out that would become removed by the filtering repack --
> does Git handle this situation gracefully?
>
> A quick check seems to indicate that it does. But not quite as well as
> I'd have hoped: when I switch to a detached HEAD with an arbitrary
> commit and then execute `git repack --filter=blob:none` then it also
> removes blobs that are referenced by the currently checked-out commit.
> This may or may not be what the user is asking for, but I'd rather lean
> towards this behaviour being surprising.

Hmph, the user asked not to have blobs that came from remote locally
and instead refetch them from the promisor on-demand, so I would
expect some pruning to happen (I am not a lazy-clone user, though).

As long as we do the pruning sensibly, that is.

Unless you are always following somebody else without doing any work
on your own, you are likely to have objects that exist only locally
and nowhere else.  It would be unexpected and surprising, if we lost
them only because they are of type 'blob' and because there is a
promisor remote configured.

Even if that is documented, that would be an unacceptable foot-gun
misfeature.  It is not just a local repository corruption that can
be recovered by cloning from elsewhere.  We are looking at lost
work that cannot be recovered.

I wonder if this topic can be salvaged by making it less aggressive
in pruning, perhaps by traversing from the tips of remote-tracking
branches of the promisor remote to identify which blobs can safely
be pruned (by definition, promisor remote cannot lose objects that
it once published, or its cloners will immediately have corrupt
repositories).  That may turn this from a misfeature into a feature.

Thanks.
