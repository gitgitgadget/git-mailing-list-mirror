Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671CBEB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 18:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjGEScP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEScN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 14:32:13 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D61723
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 11:32:12 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19674cab442so6186506fac.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688581931; x=1691173931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NM9/ni9GOqotELDIBmYclSEutqCWmkbeWW9b6CyHc28=;
        b=GLl9ugijnOaSMC+BPnWQFnU8bErF06HxMVxetbNN5K5HFZZJiSV37LXqlykvYCco0r
         WoIRi41/8VIAtlxWtzLM86ETK3L151U+DyMrO+JRlCZhXKDzNd1geo6+QEKIPSDHYuK1
         2AYuDTFL8jUhyC2pYVTO/51SBiBuKNVVxK7sTnb6zL7hdO1CHHmtL8OhvR/eMUT7S9ow
         13Raji9z0Ed+haaxTfB6VL4LaCh7PaMdN3rz5p1NVRUYpumuORK1c1oTM2Wk1xV49kqC
         snTRYTrMdO+VAwQxK/XQ/YdFXnnku8+3Owq7tgQgKQEQLX8JyrrkuSH1d+lDnthtwLnD
         UPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688581931; x=1691173931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NM9/ni9GOqotELDIBmYclSEutqCWmkbeWW9b6CyHc28=;
        b=XrnQZBcLcgKb7BcNzugvdbmDNKSwM7+nmbvm6QnkFWM5J1Eu01vBkBZuzXgZuj85vI
         zR4dcmAfgIsTyd487/4w+P149m5FUwJoMKhzSTztuBh2THcevWDbgnAsaSYwSJhs50od
         ig780QE8ZIbPQVZQscI1ROOey0qvpVyC1OdR2nGZ5T8IsFuSviyAgGf7h2/gSFw2SFjo
         wwgLjZD4e+ZbAdDruY1lRCK6Ifh7QBIvK5ALxTrjUm2etc33wFweA8M07aphDfHKOnd7
         Fy70EbfXgUCnAuDHpfTdl6V2hVk5Vs8T0Mx2gNQzrGv4oF8YS3++LVjiKwX+4qXmPzJc
         nejA==
X-Gm-Message-State: AC+VfDx+y4zmSl2S7uXhwiYqclwS3SegZg9B33sAg0IvkYYgGJ3HNFQm
        paaZjGi0DQGT9uaF3eLXREprfJCAfSJWCsHxkNI=
X-Google-Smtp-Source: APBJJlEEEvT7RYsBukrPKfxVA456MbtJdkoeRoY1vpljzJJVmCIAbN/ceYYFrLoQrcRjs0loXK5N7+M8vJOAQ05Ow4E=
X-Received: by 2002:a05:6870:e0cb:b0:1b0:c99:fd1e with SMTP id
 a11-20020a056870e0cb00b001b00c99fd1emr15164727oab.4.1688581931271; Wed, 05
 Jul 2023 11:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <YHYZTLl90rkWWVOr@google.com> <20230701192642.647167-1-martin.agren@gmail.com>
 <2f516828-deee-5c78-a08d-7a64e457f91a@gmail.com>
In-Reply-To: <2f516828-deee-5c78-a08d-7a64e457f91a@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 5 Jul 2023 20:31:59 +0200
Message-ID: <CAN0heSrMCnygWUC5Sh1UA9v2JGtjcxYDKPFE0xUPddGEW29c3w@mail.gmail.com>
Subject: Re: [PATCH v2] t0091-bugreport.sh: actually verify some content of report
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 3 Jul 2023 at 17:47, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> > +test_expect_success 'report contains wanted template (before first section)' '
> > +     awk "/^\[/ { exit } { print }" git-bugreport-format.txt >actual &&
>
> Personally I'd find
>
>         sed -n -e '/^\[/q;p' git-bugreport-format.txt >actual
>
> easier to understand but that's probably because I don't use awk very
> much. I'm not sure it is worth a re-roll though as I see we do use awk
> in a few of the other test scripts.

I do see we use sed quite a bit more than awk in the tests. This script
doesn't yet use awk and if most feel like you we're probably better off
introducing another sed use rather than another awk use.

I'll be happy to post a v3 with only this change. (This script uses "sed
-ne" already and I even do so elsewhere in my patch, so I'll be applying
s/-n -e/-ne/ to your suggestion.)

Thanks for reviewing!

Martin
