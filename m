Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA99C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 18:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbiCGSTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbiCGSTm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 13:19:42 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69EB3818A
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 10:18:47 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id d3so12182933ilr.10
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 10:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dwe1Sxi+ZF15k1c9CKCzp4IsvP7Pwa0t5dWgMu6f0go=;
        b=QbZq0Lkdvb5TKeWE77shtYMtXPCadLmWfBxA8b++TGAQ9yH/nwdFsyqddr4dVzgyus
         IJ8PGzwxozf6LYOiHIMX4A2rMw3Ltr6xjCvMUh2/CPgGbW4ne+ca7V+sb2hIDJ57Vtyy
         +tJUij8L24MBcXqUPkYcleUJZE9EHKGkpZ+jvGyqcTfJpmnHjUZJY0sp90ABuTPQ9WYO
         RJFdb4v+JCSrH5oS3GKw/6SYb1rzgNBY3Otqbrb5dy4whheTsLczJYUM/wh7tYB6hYe3
         QWMwUzXAqj3aZQm9u05c6faHFcZpBEgRzCpVJWrzMmRspjeZawVjASVm5hUCxHK02All
         /hrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dwe1Sxi+ZF15k1c9CKCzp4IsvP7Pwa0t5dWgMu6f0go=;
        b=6IpgH+PY4SyofhSpuuqdjhtPq8Dqw2vhQr1zNkcD171gV0BuKtvDvYeo7WXs3g5Ntu
         FffaP9rYYZsHVQxvpoQXnKFPdIHko1q9UEq20bcFBu4rrOM2NbtvRsq6qFgVd9F4MMsC
         0cUYBp0pEBiFW74QYvJSmq3zvWU0tkN0+sRdzB4RRatu4PQBx/b+Ie85LEmkfeozEvhQ
         rYYc3kq4CppSIh8pWC9dWgBeVokBmPDOIwOM+ApvuP7uTu3o8oGqbF76z1CoTWlIEaHK
         Ie04U+WK1UuQY/9ib+GktuYSOJozsMO1XZEaM3zfoxg23u45BqB9q08bZI2yTuCZ0uK5
         2YeA==
X-Gm-Message-State: AOAM531pUoFg3l8S1X1zAtkWtC03PEJw9BaKqkyEIdJAWb++7297IxRg
        hm9IwgP95+nq/gF1r3PEgrECmg==
X-Google-Smtp-Source: ABdhPJzYU1NYf9R+LP4t/QmIP94IP/HgxiqKoHpo/1+7YYM/+E6CIFp88BWeqfSiJFyeAAEL10xVNw==
X-Received: by 2002:a92:d0c3:0:b0:2c6:381e:1701 with SMTP id y3-20020a92d0c3000000b002c6381e1701mr8085932ila.51.1646677127195;
        Mon, 07 Mar 2022 10:18:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a18-20020a6b6c12000000b005ece5a4f2dfsm8614944ioh.54.2022.03.07.10.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:18:46 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:18:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: tb/cruft-packs (was Re: What's cooking in git.git (Mar 2022,
 #01; Thu, 3))
Message-ID: <YiZMhuI/DdpvQ/ED@nand.local>
References: <xmqqv8wu2vag.fsf@gitster.g>
 <0870b8f0-976a-cf2f-f34f-7e966b9c426f@github.com>
 <YiZJiPVMZwPXbfrK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YiZJiPVMZwPXbfrK@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 07, 2022 at 10:06:00AM -0800, Jonathan Nieder wrote:
> I'm excited about this work!  I just sent a quick review to the
> design doc.

Thanks! I haven't had a chance to look at the design doc, but let me
respond quickly to this message:

> Before merging to 'next', I'd be interested in two things:
>
>  1. Marking the feature as experimental so we can learn from experience.
>     Clarifying what aspects we consider to be stable / set in stone and
>     what are subject to modification.

I'm not sure there is much practical benefit to marking this feature as
experimental. The only new file format here is the .mtimes one, which
should make it easy for us to modify the format in a
backwards-compatible way.

If there are other benefits you had in mind, I'm curious to hear them.
But I think we should be fine to "lock in" the first version of the
.mtimes format since we have an easy-ish mechanism to change it in the
future.

>  2. Marking this as a repository format extension so it doesn't interact
>     poorly with Git implementations (including older versions of Git
>     itself) that are not aware of the new feature

The design of cruft packs was done intentionally to avoid needing a
format extension. The cruft pack is "just a pack" to any older version
of Git. The only thing an older version of Git wouldn't understand is
how to interpret the .mtimes file. But that's no different than the
current behavior without cruft packs, where any unreachable object
inherits the mtime of its containing pack.

So an older version of Git might prune a different set of objects than a
version that understands cruft packs depending on the contents of the
.mtimes file, the mtime of the cruft pack, and the width of the grace
period. But I think by downgrading you are more or less buying into the
existing behavior. So I don't think there is a compelling reason to
introduce a format extension here.

Thanks,
Taylor
