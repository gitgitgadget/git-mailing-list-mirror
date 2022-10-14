Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E9C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJNIEh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 14 Oct 2022 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJNIEf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:04:35 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082AE1BB979
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:04:34 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id d26so8793967ejc.8
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMBcjMehFKgEN5zDmsRA6RwCO9s4vMG3PUURf2gx0ZU=;
        b=6wUao/hAsO5UutvFhsqkPoVLhbXv2wyftbbXrf1aZu0z7KK/9AHgnKFMZ/T+82o9Bv
         RH1iilKZHuVA6VF9jxlUhcvwRo2g13yvCGoGpHkVG51qmy/jSAwf2lLeuu/pvNha+pSj
         b9RqOnyL8mKJ1YuE3NMnEiJ16Nuqf90Wkou4N8gwCz/XIsCHGnsa7POyh2km437OI4gs
         BpFfE/kciLw3N2Wzrqh3QESytHbmZa41gRmNmE287Ed+JiAkOui3xV4X7GgLu4kESsor
         FDLe6tIMBwq468doDZAXxoS78389I7RhnxEvDIW0+QSEpIGU5apWTrAp0DEgm1j0Q8zI
         Yf3g==
X-Gm-Message-State: ACrzQf0yQAx94648Rqw58CGXV7h4B/ruU0shtUjRZ8zLMbi20BcgTHXo
        kciScSnomxcfgAmB7Dti72LSPW5DpHJHXrN2/Z/7dznSyAw=
X-Google-Smtp-Source: AMsMyM7U8eMD/CfNvSYSAORmtgQL9oY+sfvUwh17BwGZxH2U2DZJl78POA8tJ5olK9KGBDhFpIRBn0QOawDH0TvSc18=
X-Received: by 2002:a17:906:9756:b0:78b:8c9b:3b1d with SMTP id
 o22-20020a170906975600b0078b8c9b3b1dmr2625508ejy.256.1665734672210; Fri, 14
 Oct 2022 01:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com> <CABPp-BHaMCcLjdx2m4CALZQiTRQy_LovWfbdrga6XWhQJhoxWQ@mail.gmail.com>
In-Reply-To: <CABPp-BHaMCcLjdx2m4CALZQiTRQy_LovWfbdrga6XWhQJhoxWQ@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 14 Oct 2022 10:03:56 +0200
Message-ID: <CA+JQ7M8s1W68+mzfe__+T5bJ821wYJqfgLBqA1=dSVH9Tx9fHA@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     Elijah Newren <newren@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I don't imagine I can make a perfectly correct and universal fix to
> this, but with case-insensitive matching on ls-tree in an update hook
> I believe I could reduce the frequency of this already-infrequent
> issue by at least 1000X, which would suit my purposes just fine. In my
> case filenames are mostly ansi-based, and I don't expect we've ever
> had Turkish filenames (turkish "i" being the most famous case-folding
> gotcha I think?).

How about doing it in something that's not ls-tree? Sounds like you
already have a script, it just takes a bit too long?

Something similar to

On Fri, Oct 14, 2022 at 6:59 AM Torsten Bögershausen <tboegi@web.de> wrote:
>
> For example, we can use Linux:
>  git ls-files | tr 'A-Z' 'a-z' | sort | uniq -d ; echo $?

In a repo with many files, maybe use git diff --name-only and just run
it periodically as a part of a check-in hook or something?

  git diff --name-only HEAD~100..HEAD | tr 'A-Z' 'a-z' | sort | uniq -d


On Fri, Oct 14, 2022 at 9:59 AM Elijah Newren <newren@gmail.com> wrote:
>
> git diff --diff-filter=A --no-renames --name-only $OLDHASH $NEWHASH |
> sed -e s%/[^/]*$%/% | uniq | xargs git ls-tree --name-only $NEWHASH |
> \
>    sort | uniq -i -d

Or what Elijah just wrote

> Coming at this from another angle, I guess we could teach git on
> case-insensitive filesystems to detect this situation (where two files
> in the index, with different contents, are pointing to the exact same
> filesystem file) and more explicitly warn the user of what's wrong,
> giving them clear help on how to fix it? And temporarily exclude those
> two files from its change reconciliation processes altogether to avoid
> ghost changes interfering with recovery actions like "pull"? Certainly
> that would be better than the current "ghost changes" behavior... but
> it would still be far less convenient than preventing (the vast
> majority of) these issues altogether, be that with a custom hook or a
> core option prohibiting clearly case-insensitive-duplicate files from
> being pushed.

That's not to say this isn't a good idea but for now I'd advice an
automated scripted route.
