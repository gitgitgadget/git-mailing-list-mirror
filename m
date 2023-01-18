Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AADCC004D4
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 07:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjARHgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 02:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjARHgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 02:36:08 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F0521DF
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 22:52:37 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 127so8153166pfe.4
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 22:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYi0277Pj622FikYzkJrAFlHSDSkew8RNEsJIrR+cmE=;
        b=SggxtA9gqB/IOuR6u4/p1XcgSdacsb170PKve9oDXLd21mKe8gVJrkvv9P7hJOH9Dw
         louCS5fLRWsAlKXlh1xKRaxv3YV1ixF4BacYh+ZUeBGjTcwtjiv8h37SzMxcCfjrwEB1
         JMsxjFf2CQIn5LrBKSFiM/hCKl0TmEAiSDRNe5EAt6D4aTxstHum3UU15apvyFHu4G/C
         5uEurmGADu3zG3svTZebcwYTJIU8OeA+YW8LRfzsbtmShQJG+ONTbwepGtMv/pu4UT9/
         ZVUr4dkzFUgjIrYWTw4yWHFtG9Nwsp86j9+eO3s0OGuchUTxp+s8dPfjMWiZXl1KT8Xl
         ozyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYi0277Pj622FikYzkJrAFlHSDSkew8RNEsJIrR+cmE=;
        b=GpNUSBFtsiL94cplrjv+8xMyoPBX7BXPDoY8bDrDecdFVclAwjIlag1qNnKP2Mkqph
         HbeULpf/RSo0bVrv3JF7FM+RA0tHjO272we74igYKmsIfCEN2bB5LgHPHIv3ugWuij19
         vCTP2Fv9nNG36lJqhUjMVTJMDG8bbtdXUO8nk5LE1DcTiL4LAfYoptNo7CwrAvZ9u69z
         dSu1zZ0kWhIVcNcc9GdUmr96Gz7y9yQhEYYv35pIa4dpMbpeg0x5RgONhL1sI9Ra4Zqh
         2/N2GKIgF1yGTi+9lXjfNO9Rnz8duyUu+1xVd3DTZFa164YoyRX6UXclTsHR8RIvSxY8
         06cw==
X-Gm-Message-State: AFqh2kqQUXPuJfhtp5piSC/VqNXl3AoAaE/YPpH6GuujmrCIC0VtcXye
        WxC65+fwRvOskQ/2X3K8cQYOy4MKjro=
X-Google-Smtp-Source: AMrXdXvV1KSm3rAo7eWnhaWAQGlSFVVL9wmvR70TkfP82VkM7U3lSSnw5j+R1hMcwqrekBguRyC4tg==
X-Received: by 2002:a05:6a00:1d83:b0:589:5504:1508 with SMTP id z3-20020a056a001d8300b0058955041508mr6207297pfw.19.1674024757033;
        Tue, 17 Jan 2023 22:52:37 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w188-20020a6230c5000000b00581f76c1da1sm21122585pfw.191.2023.01.17.22.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:52:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Jinwook Jeong <vustthat@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] checkout/switch: disallow checking out same branch
 in multiple worktrees
References: <20230116172824.93218-1-carenas@gmail.com>
        <20230118061527.76218-1-carenas@gmail.com>
Date:   Tue, 17 Jan 2023 22:52:36 -0800
In-Reply-To: <20230118061527.76218-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 17 Jan 2023 22:15:27 -0800")
Message-ID: <xmqq5yd48hcb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> As reflected on the tests, this will change the behaviour of those
> commands when they are invoked in a worktree that has that requested
> branch checked out, as that matches the logic used by branch, is safer
> (assuming both commands are user facing) and can be overriden with an
> existing flag.

... meaning you can "--force", or something else?  Allowing an
existing option to be used as the safety valve does make sense,
especially if the option is something users are already familiar
with (like "--force") and naturally expected to work.

There might need an documentation update.  Back when "checkout -b"
and "branch" was written, there wasn't "multiple worktrees connected
to a single repository" hence there was no need to provide safety
against checking out the same branch in two different places.  "git
branch" might have learned th give that safety while "git checkout
-b", which _ought_ to be equivalent to "git branch" followed by "git
checkout", might have forgot to do so.  After this change, it may
still be correct to say that "checkout -b" is equivalent to "branch"
followed by "checkout", but if the documentation to "branch" talks
about this safety, it probably deserves to be mentioned in the
documentation to "checkout -b", as well, if only to give an appropriate
place to talk about how to override it "with an existing flag".

Thanks.
