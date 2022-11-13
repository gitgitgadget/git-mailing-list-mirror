Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42002C433FE
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 04:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiKMExn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 23:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiKMExk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 23:53:40 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5423E2BFA
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 20:53:37 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p141so6137488iod.6
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 20:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AJmyp1t9qklCe7nuhvoYw2ynXIkbrPp6eh6MBpGY6Y=;
        b=jCLEjUsdXNKUWvsoZXryI5QvX1hvwzVPgXhlWDkGvLSp0i3gJfMm0YwQVHH61i4Ez8
         W11qBRrs/jFkessgIqL9tpEdr4APl+q1nmKXu56GwVl08i7sP3x5h71gSJiGVUs+WMdy
         Wb4LmI1qPlEZIzyaEeuDO+NNw9cgeO+IX74K+vKlAJfmu8SB5XeRsIa6AQCkmsgSp6R3
         vpvHgTEu3ym++Ab+0u7Gz2r8Hgo/aHzENs75edbg7uvXHp1d1fhWeqA3bu9BzNC+2UU3
         LclKtQhtYhZ56F7s5+AAlOzItgI+2HcrpsSir9BrdjPtxtrnMLfVSJFUd5odZ70fVQ0p
         3tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AJmyp1t9qklCe7nuhvoYw2ynXIkbrPp6eh6MBpGY6Y=;
        b=8MA+9DmuTVsS0LumJSD6Gp6eO+JaqJFgipYngfmRHJrhNO5K0e+bqEpvFG6keTsksU
         +cpBC8fHvz91sKq7vkPqOy2xDUb9iBBmGcYKIm3Xb2wpH+qY1129vGZGqRG3Z2rya3gV
         YagHcFG0TAijoKomJW7V1wCrzllzK2ffSjt5yQzMsD+7YKOHSP5dodvrn2Z/AMiGZ5sU
         Km+UK5Kc4ZSJetQwJp9zwA88RWgpZ5BHI/UUGij92R9/C6KoC2bTShCB8WW7EPsbjBI3
         /TZxpimUlFc7yzEi/C2AbSz3jcfZ8B+MEp05ZzZ11kCD9Ds3n7aM4DudTdTZn4GN5Q++
         LWcQ==
X-Gm-Message-State: ANoB5plDGWamxtd1C7H44dCd4udhDVfhWFyXXybEG/CTMhhZe541yMun
        b/aBxBKQFf3+jr0ISd37QYbtPQ==
X-Google-Smtp-Source: AA0mqf4x9SoPBSIh3gZUqmb+lcAB3JYOtf8hf3M+slpuAaYnL+83J/su92So/DoXvOn7nhKXAZ7D5A==
X-Received: by 2002:a02:ccab:0:b0:363:b993:96ba with SMTP id t11-20020a02ccab000000b00363b99396bamr3461702jap.246.1668315216520;
        Sat, 12 Nov 2022 20:53:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 20-20020a056e0211b400b002f1d7850037sm2549669ilj.44.2022.11.12.20.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:53:35 -0800 (PST)
Date:   Sat, 12 Nov 2022 23:53:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        kylezhao <kylezhao@tencent.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 0/2] merge-tree: allow specifying a base commit when
 --write-tree is passed
Message-ID: <Y3B4Tl+luEPJgVJP@nand.local>
References: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
 <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 11:45:12PM +0000, Kyle Zhao via GitGitGadget wrote:
> Thanks for everyone's careful reviews.
>
> In this patch, I introduce a new --merge-base=<commit> option to allow
> callers to specify a merge-base for the merge and extend the input accepted
> by --stdin to also allow a specified merge-base with each merge requested.

Thanks for the updated round. I applied it locally, now let's see what
reviewers think of it...

Thanks,
Taylor
