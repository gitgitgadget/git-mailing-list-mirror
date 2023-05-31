Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB14C77B73
	for <git@archiver.kernel.org>; Wed, 31 May 2023 22:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjEaWfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEaWfu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 18:35:50 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC139F
        for <git@vger.kernel.org>; Wed, 31 May 2023 15:35:48 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-565eb83efe4so1666887b3.0
        for <git@vger.kernel.org>; Wed, 31 May 2023 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1685572547; x=1688164547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M446xzsuTtJ0N/z5MYZWCsm+9DkjmCYhcbaG1CWdOws=;
        b=XD+JvG51C4WYEJCbximUmjjhrSRRe04XlIU6DxX2kJ+UEIz3NSpNKURMzUTkp3Fw7z
         uugMmYYnnCBpOaFVjpBpfiv0OqfWbk6HPaaZac17Q0AkhhUuIClnQ3ocKMzX8OuwcfTY
         1B4zDko2ed90Tsmei/rCLe9bLmdNUrYTG5e4K0TVbUtBxj44AnwW2waSp/njBthrNxii
         UyHmSYvaDh9EUhVqIkSESeh4Ub1rX3qSi7wfhsl/Ch/QSpS0f7yV5SCMd/wSBvRjmV1O
         DbgK6W4OmV2gajS61QuyOe5tLbSDmR2VUNWGgwizXZQfviXkfYaaSB4XLnWcoYSiz1rl
         xVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685572547; x=1688164547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M446xzsuTtJ0N/z5MYZWCsm+9DkjmCYhcbaG1CWdOws=;
        b=AOScrWiO3IQIsR54ftJpOTmEQ7B2vu7GqgBBT0LGhc4AgAFg3AWFE3pJHdHqtSkt35
         DOqzqnz0VM5xgOJgqha8ORuQktICusCyQJQywPPH6Lm/lcbCrKB569dX4VlEMGsxqnm6
         3Fgh3S7l/zVSMsrsK/XnKa6eNkxnGe/SzKwfZljcUwreXpIO/LrNLTmS0yTNRi6mIl03
         6hZNMv034rOD14yYuddLKS5YQvwC6goyJ+E566qT/xSTeS/o2AVJyC5Y8NrvvOWTxYw7
         oAw/v4pLtAxA1yku0lF6M36ODhg9fLHhF4bwPlGhKFQrMTAVJGte7g1aUconPIgaQO06
         OzLg==
X-Gm-Message-State: AC+VfDy3Br7uiS2k7EDTdGH6e5ixDifmIBicMVjz1TZkgEDp0na7pr88
        G272zo+sPCYwgIaUTjTpDaaRLg==
X-Google-Smtp-Source: ACHHUZ4biEOWem7jPtss7RJL7XbETk2uszL+tdQNNVqjvkrtIboCCJ2earFMAPxBsigcV+UjfNMBqg==
X-Received: by 2002:a0d:d64e:0:b0:565:c966:60dd with SMTP id y75-20020a0dd64e000000b00565c96660ddmr7517336ywd.48.1685572547423;
        Wed, 31 May 2023 15:35:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t62-20020a814641000000b0054f8b201c70sm5704226ywa.108.2023.05.31.15.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:35:47 -0700 (PDT)
Date:   Wed, 31 May 2023 18:35:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Siddharth Singh <siddhartth@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Unit tests for khash.h
Message-ID: <ZHfLwpX7nNVjBvE5@nand.local>
References: <20230531155142.3359886-1-siddhartth@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230531155142.3359886-1-siddhartth@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Siddharth,

On Wed, May 31, 2023 at 05:51:41PM +0200, Siddharth Singh wrote:
> This RFC patch adds unit tests for khash.h. It uses the C TAP harness
> to illustrate the test cases [1]. This is not intended to be a
> complete implementation. The purpose of this patch to get your
> thoughts on the unit test content, not the test framework itself.

Thanks for working on this, and for opening the discussion up. I took
only a brief look through the actual changes. But I think the much more
interesting discussion is on the approach, so I'll refrain from
commenting on the tests themselves.

I am somewhat skeptical of this as a productive direction, primarily
because khash already has tests [1] that exercise its functionality. I'm
not necessarily opposed to (light) testing of oid_set, oid_map, and
oid_pos, which are khash structures, but declared by Git.

Even still, I don't think that we are testing much in that case, since
the boundary between Git and khash is limited to the KHASH_INIT macro.

So... I dunno. I'm not strongly opposed here, but I think this is
probably not the most productive place to start adding tests.

Thanks,
Taylor

[1]: https://github.com/attractivechaos/klib/blob/master/test/khash_test.c
