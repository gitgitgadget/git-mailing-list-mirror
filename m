Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84575C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 22:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbiKQWFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbiKQWEu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 17:04:50 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281A2729B5
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 14:03:09 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id bp12so1634864ilb.9
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 14:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl/CZ8Lkku3nyekoSgPolwqtJ9pNVhjhaduMWEu126k=;
        b=yTT6T7aJKrg99IQvMYlgFzvTe32iWpygtpAeZ1KRuJUL7402o1rA8JMgEYbxzptajO
         /L1B/yhh7xIJ7KiOiIxqPdoVxzuF9HIiSnWNUIHtQs6jtjfekmXGcOFjvGEhMpsJgxtr
         WknQoRPGMIjZK2CVcaJNL2xckw0p8eL0H5RdJMjHH6AtXbtdXOIaaFkj66xY+nqX3ybw
         s+xEQ5QULl+uQNtju4Lb4HsQVVbtEEEhqd6f97/c1UCiwGM4P7fABDWSFPyYwPfpvSjC
         0+LfeLenK3J7AygBPiAD4Xj+ej8M9EeWVY1SwZ2M18bCbr/N3C5OW4BhBxd1vHfywaXV
         pS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl/CZ8Lkku3nyekoSgPolwqtJ9pNVhjhaduMWEu126k=;
        b=woSuBrWNAwYWkKoR3CDaC1KcrqviwFycvLCSgCVc9WA9mn3UdMjmbvun1xtu1o4JUN
         gsK8I23uGQeW33E3tAXLVk+KSf8BV74Jw8h0HYwg8gYsatoKigF0TtVupGiY0PqSLOZb
         39cFDu8CujzjKoWlI1eDPPfB/JbcjlY9UPnKfhoMe5stciP9LUUDP98Y/PER57sOzHUy
         sm2x4BdUjWr1eOPk2dtoU11d4B81rgSuRJEpLaNy8LHxWvboRauyC780tyNCumvwdkf4
         p3+5N/3Ew0sBFnO7yOhcTNLbBBYQ3Y8MyK7nOmZCn72kgr1/prIzM7UPIY3OBaLF35vg
         RGuA==
X-Gm-Message-State: ANoB5pmrsYUtTl4yxpr9Xrn4UH420deyKincDJBgyy8Ua2c6G7KipmlN
        8pf8t2cvqZfDBVIg9U3XzfC+1A==
X-Google-Smtp-Source: AA0mqf6/dBlpdeSJwXUpWBAm0Cuo9xjhOUKjAjr5RjQ9u+R005bvYF7UUmcdeMKJDOV8SsYA2+TzJg==
X-Received: by 2002:a92:d345:0:b0:2f9:b594:970 with SMTP id a5-20020a92d345000000b002f9b5940970mr1460761ilh.56.1668722588527;
        Thu, 17 Nov 2022 14:03:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i4-20020a05663815c400b003755a721e98sm634690jat.107.2022.11.17.14.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:03:08 -0800 (PST)
Date:   Thu, 17 Nov 2022 17:03:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] object-file: use real paths when adding alternates
Message-ID: <Y3avm0ZgkVWr2qX7@nand.local>
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
 <Y3aBzbzub7flQyca@coredump.intra.peff.net>
 <221117.86h6yxgy7b.gmgdl@evledraar.gmail.com>
 <Y3auRnJqHq3pMKAe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3auRnJqHq3pMKAe@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 04:57:26PM -0500, Jeff King wrote:
> That said, both of these are orthogonal to what Glen's patches are
> doing. If you want to submit a series later to deal with them, OK, but
> let's try not to hijack the conversation for patches that are fixing a
> real bug.

Thanks for keeping us on track.

Thanks,
Taylor
