Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62B5C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 07:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348451AbiA2HFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiA2HFs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 02:05:48 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DABC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 23:05:48 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id h7so23869630ejf.1
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 23:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VkzvI1KCK6kFvvUIhbZ/M9T0+yBXK2PFmumbj1bj/Fo=;
        b=cnwvhYHmNb8wVa+3E/ubAuKLskxZFN0+WFHbM/E6ZWk5NWxoeI14W8qyfVbk4twgwE
         9/nALotA9UIMGqR1ABfJsBlfc8jL5pl5SB/7mWZN9o8Z3zprIzAhteKoQpMCrPhqHUSm
         yOtcaIH43cTCMjBO7GxVDKOVnK6qn3FybMOLoT0wt8Vwv+RKyD98qzHRhFCCQJgxMetq
         RcgbWSLG4elxcAj+jUwnkRqqMlaGJSP60oLw4kVY6mkXm/L/NVGi1r2ZVMTFt0YlOPDf
         w7FW1X0clW4Z42SJSVCq844aE9r4V3shMQgxNQSUQcOel0ehZz15O6y90lsMC4pkUfDR
         tskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VkzvI1KCK6kFvvUIhbZ/M9T0+yBXK2PFmumbj1bj/Fo=;
        b=7TmODRUry4u2OOi5FytDwGL563KU7jKeaOXu9w9xgTTuM5DY5SNn+6kfwJZyrUan3v
         9N8aKT17SbEZlF3PHTHlVH7+faZNeYwMpLhIozderuOzFM4RusUodPLjDpOKC29Z+FiJ
         pduRFu6sUEmBf5xJd/bbZT5+Ob+a2LelnbvrPFjxIOxBTePjLCCa7cSlhwvAnbtg6Ddo
         f2VW6ahEH4UE7ZbVO5wqPXChjbnAoUkbw2uHwhI713rAyYHXqJY72SAdnA5cCz72pGoG
         yxCWu5rA5H6oPWZ54vOKhpqHZRjuMlw91hp3SYyRWdFNwzTCrzgS7SEHH/4wMu2SNNPT
         bVbg==
X-Gm-Message-State: AOAM5310fklCCfhL8wFVqI2BPP7zS4FPerUvvbpWRtcZs/0E54mimX3M
        j175qJ2P56LxV2iTUfv+rrOh7GN7iCoOVOWA
X-Google-Smtp-Source: ABdhPJx2T6EgLlAl53LnImu4gmvdYg/tZgIjnbEucI1RoyczCtXlr5t5radkmoEeZwoHFTj7aoCgyg==
X-Received: by 2002:a17:907:9617:: with SMTP id gb23mr9818569ejc.462.1643439946323;
        Fri, 28 Jan 2022 23:05:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id by22sm10765825ejb.84.2022.01.28.23.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 23:05:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nDhns-003lbd-Mx;
        Sat, 29 Jan 2022 08:05:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 08/11] bisect--helper: using `--bisect-state` without an
 argument is a bug
Date:   Sat, 29 Jan 2022 08:04:17 +0100
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
 <1b14ed3d7976b8fe4149822dcbb32343e0554a38.1643328752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <1b14ed3d7976b8fe4149822dcbb32343e0554a38.1643328752.git.gitgitgadget@gmail.com>
Message-ID: <220129.86leyzaunr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 28 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `bisect--helper` command is not expected to be used directly by the
> user. Therefore, it is a bug if it receives no argument to the
> `--bisect-state` command mode, not a user error. Which means that we
> need to call `BUG()` instead of `die()`.

I found this commit message confusing with 07/11. I.e. won't this be
"git bisect" directly make this BUG() a bug then?

But no, it won't, because this being a bug has nothing to do with it
being a helper at all. after 07/11, but that it'll be called from an
implicit "if (!argc)" in cmd_bisect(), no?

I think I've either misread that, or this commit message is very
misleading.
