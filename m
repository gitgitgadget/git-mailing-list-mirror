Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E25C43217
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 04:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiKMEwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 23:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiKMEv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 23:51:58 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25FFCE1F
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 20:51:56 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id b2so6115388iof.12
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 20:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/4+EWGPhxgmyD76LxgDECsuLI9DdF5oItdBn3IB/yA=;
        b=Fk3r0oS+7kaSahXCs+axyFQtXQPk/7GWi+zCk5Iv4TlLsw4PSq8oMyG3SwBAAw2hcU
         PYdeMJhBtj8OocdRlZX1spQR86jmqvDthuy8xpBJ/lZsG+MNX8yCb4I9ydY2MwsmcjGT
         Slv380cYajwHAtY5IlG869lnFFDEmtohCRiyXitaeJ/XGn2vb8hK9EUvYqnKGLDwEgeR
         WkMdTI9h7QsjnSAxilRv1j2o/RHnHH/kQJKxWlTOIzIuUpERQiGdAUuaqTlvMYg9R1mC
         NZW39YzDVZkPVnxt/mwXhpVLQms7laxaGTY0uv4GnX0PLHyAI9QhrLQ5pPPPz2CXn9me
         ut+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/4+EWGPhxgmyD76LxgDECsuLI9DdF5oItdBn3IB/yA=;
        b=MoFFtYN3NXhKhRU87BJXbZ6s6erhMnhZfjsjdBACZ5oxySer7OBnZAgkj0noibcnLt
         EslA1vAmLJ617fKvMDUHTzAWlLUPQ9qsKv9OZfSZmb2LdKs1oWKO9RpCRcWg64YKL3TZ
         QZYBb8pZySsrLLmKZDbDBiUo3FVYIr9HEGOoOi0nWEKsT14zfGwuj45PbkIp5SmBoemg
         4kzoGDY2JeBoR5FVSxMep7J2srUwjVQHtBCAlOsZcr8lVP8FtOfJcgwWnN+J1EvjhTsd
         gDAXTxCXWcgW/ns0YSoDbpzV1dS6GTB7QVjMWUkbELRFUXaWzj7yGg2LTpZTirooyPaw
         xZTA==
X-Gm-Message-State: ANoB5pmwL2XIEKoyiqaNZkL4XHj9sjw5I2jBUy9sFk/bXupepF2qtqnk
        ghoSZnlZ+fcm4puWceuHgTwvMw==
X-Google-Smtp-Source: AA0mqf5nTkz36uz0/cF0714+wVIE+TGzn4KT+yzNS97fPxyVMA2OtRUSYpoi8nWus6kX3XDt1f1WhA==
X-Received: by 2002:a05:6638:4918:b0:376:966:e686 with SMTP id cx24-20020a056638491800b003760966e686mr1097152jab.174.1668315116121;
        Sat, 12 Nov 2022 20:51:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o16-20020a02a1d0000000b003751977da74sm2316466jah.102.2022.11.12.20.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:51:54 -0800 (PST)
Date:   Sat, 12 Nov 2022 23:51:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Message-ID: <Y3B36HjDJhIY5jNz@nand.local>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 10:07:34PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is more performant to run `git diff --no-index` than running the
> `mingw_test_cmp` code with MSYS2's Bash, i.e. the Bash that Git for
> Windows uses. And a lot more readable.

This makes sense, and motivates the changes below.

> Note: Earlier attempts at fixing this involved a test helper that avoids
> the overhead of the diff machinery, in favor of implementing a behavior
> that is more in line with what `mingw_test_cmp` does now, but that
> attempt saw a lot of backlash and distractions during review and was
> therefore abandoned.

But I do not think that this paragraph adds as much as we'd like to the
historical record.

What about the original approach did you have trouble pushing forward?
Perhaps framing that as an alternative approach, along with why it
didn't ultimately get merged would be a more useful recollection of
previous attempts here.

One thing that the commit message doesn't allude to (that is covered in
the earlier discussion) is why it is important to pass
`--ignore-cr-at-eol`. I think that is worth mentioning here.

Thanks,
Taylor
