Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C08C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJNI5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJNI5c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:57:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17A91C7118
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:57:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s2so5980854edd.2
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWlFoSJOq0mRpKValMpXVkbjZK6ZZzvt6IKz+lH2a+I=;
        b=OuGKOIBL+tuB8XjQfVkcHG3SsPB20jre0wTNHMJIveXhd0SgliECZp9ZQG5uonzo0q
         Mr/paPEoZZvYPLkM70mZwOdlHzEuPjPw6ILLMWxLGsebqwNT7s710VVCEY3IJ4DQjM/O
         ZUkW1N9Ge3NNd4OeGU0DcslhearDRibyi0Ufw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWlFoSJOq0mRpKValMpXVkbjZK6ZZzvt6IKz+lH2a+I=;
        b=a08l7a48tNhpZmX/ZBCFYjdqaiK64BlXZ0sTHPJTj0NV3c6vkivS+o+dqgyOvZ73Jy
         MKpaNPNjzbAD1JbaR5vJrDV+feXR/xtZOzGpAjrUC2REWuVIpxHIJCGQVPlbwoKXS/ju
         Q7toxEDuezvxsUXch+1CBwX4XJ3Kxcy+EYCxobSsxRsxI/578kLUyRKFWpI4ZdceJ+Ln
         ivK7jWFQWwl9AKmDDi26y4tAZAof1d70GXvOEoD1E0gg5rJVRNHKzGnTcH5dra9/X6e9
         3rnexyVU9Wc2qJujk+GCjtZcV10wT+kT+c/3L2ybalKl2nqOQHr1CNF5c/Bx/wITKlvj
         UoAQ==
X-Gm-Message-State: ACrzQf0Y6avkL/Vy74lKYplsqWeJLoQ+IfbXsyNFiIklxUiMdcCq39jo
        bEu4ZrEY3pifItgTtlYM7EnfhhIPMEQOa65btyJZMOnlt+ORTsGe
X-Google-Smtp-Source: AMsMyM4sEZihpKYJvRfw3V77KgYJvjMs6djLDcrxHY510We7i+hhF5zYlufPN3TAZ3aKl8TfNJLDK6nZUWO0L5oYam4=
X-Received: by 2002:a05:6402:3454:b0:45c:a8b0:52d2 with SMTP id
 l20-20020a056402345400b0045ca8b052d2mr3478179edc.307.1665737843726; Fri, 14
 Oct 2022 01:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
 <CABPp-BHaMCcLjdx2m4CALZQiTRQy_LovWfbdrga6XWhQJhoxWQ@mail.gmail.com> <CA+JQ7M8s1W68+mzfe__+T5bJ821wYJqfgLBqA1=dSVH9Tx9fHA@mail.gmail.com>
In-Reply-To: <CA+JQ7M8s1W68+mzfe__+T5bJ821wYJqfgLBqA1=dSVH9Tx9fHA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 14 Oct 2022 10:57:11 +0200
Message-ID: <CAPMMpoiPvWc9fNnzDRqPHtf1BdNsSd0ef9nzd6jcVOkvM3-LEw@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 10:04 AM Erik Cervin Edin <erik@cervined.in> wrote:
>
>
> On Fri, Oct 14, 2022 at 6:59 AM Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
> >
> > For example, we can use Linux:
> >  git ls-files | tr 'A-Z' 'a-z' | sort | uniq -d ; echo $?
>
> In a repo with many files, maybe use git diff --name-only and just run
> it periodically as a part of a check-in hook or something?
>
>   git diff --name-only HEAD~100..HEAD | tr 'A-Z' 'a-z' | sort | uniq -d
>
>
[... next email...]
> I believe
>  git diff --name-only
> doesn't need a working tree

I don't understand this suggestion; doesn't it only catch duplicates
where both instances were introduced in the same 100-commit range?

That has often or typically not been the case, in my experience. Often
one version of the file or folder will have existed for some time
(days, months, years), and then a "duplicate" will be introduced.

As far as I can tell this "diff large range" approach is quite
expensive (37 seconds in a trivial test on this repo), and
non-comprehensive.
