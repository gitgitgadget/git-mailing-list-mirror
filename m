Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD8BEB64DA
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 10:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjGNK6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 06:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGNK6t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 06:58:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED893585
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 03:58:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-521650a7603so441908a12.3
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 03:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=akorzy-net.20221208.gappssmtp.com; s=20221208; t=1689332224; x=1691924224;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jqqkKne+IzuewpeXsU0EFsQlyVOuZktb77+ZkW0IURo=;
        b=r6kfWfVcBZb4VMDlNhq0G1moWRl/XbLwQPtixOOzdruTFFHcxYq9m2H65hwQ0MVHmu
         hJSvlg0CiZ1YOQW1AmFzuV2gbKRL0005Q6H2z7Lc63YW/jZeaI1tfA8dFowWMAXLj3XZ
         951v0iuTLE7a2DXAJkiPDkc0LmOMQgDJJo6xhVck98d1FBtJbG+3Pu8vMelHmkPcj7l7
         Lp4uiN0kYNAacl/pmPcPL1zIYqtC9ZI0qQgYkVIqQ+ukgh+tkhsogcLnA9WFOKZjlYWd
         olrrgOBtj/dCWbx98OyXgOeKwqH3Z7q4C4wOnxJtzUJV5D5EoBzlXHPclvOfbsxngLIR
         x+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689332224; x=1691924224;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqqkKne+IzuewpeXsU0EFsQlyVOuZktb77+ZkW0IURo=;
        b=NNMXv4rzSyY8GurhrkrnXlrX8ir3DDTPhQ4rpuLfE3p3D8oAD8pHOUqWh+4TKehAFi
         /wS1djvkvMKDWfkheoBKcY9wQv3vVtJ1ZolYqhOTnRPnBWN6SLL9YZ4sPhe0KjLDBtEl
         XikxIdAbe1cNcj6M4c6F271wAogYH5SlVbVz7hb137v5rgKKuu/TkulkvOGGxwvp97O3
         woC69/s8SiYOrGp0i6356LISvL65S2vGbpUOXYhuk7M3g/NT2vEYlTmwTyTGhPx7axKR
         Do3ZJZzjXNFzWjFm80dSY4lcBtEIS+g47qsGm9munI8cbwKBBJyyGwoTldCYhWhBEESV
         fZkw==
X-Gm-Message-State: ABy/qLYrJry+gx18801MRQxu+mLXj6IEE3GMtDCjw56imVMYI8gv6bXX
        //1JwzJzyhqgvzBo3Xz0/UMlOKzwgEGDSXztkqE=
X-Google-Smtp-Source: APBJJlEvfvSWd/XqZXEj/oPah942g5bnVwc5r5hd4GYjrzOv951N80sKxIGZ6NUcjJ6wTK9aOoA37g==
X-Received: by 2002:a17:906:28c:b0:991:e17c:f8fa with SMTP id 12-20020a170906028c00b00991e17cf8famr4080417ejf.61.1689332224228;
        Fri, 14 Jul 2023 03:57:04 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id r11-20020a1709067fcb00b009929d998abcsm5208035ejs.209.2023.07.14.03.57.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 03:57:03 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-991c786369cso231327566b.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 03:57:03 -0700 (PDT)
X-Received: by 2002:a17:906:c205:b0:986:d833:3cf9 with SMTP id
 d5-20020a170906c20500b00986d8333cf9mr3296325ejz.39.1689332222576; Fri, 14 Jul
 2023 03:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <CADWu+UnThMq2M+kCMADP9rZ5c6nL+Hz+z0-OqRnuG2oYVzbvWw@mail.gmail.com>
 <71f7d816-b139-03ab-88fc-7552d65e4498@gmx.de> <xmqq7cr5uonp.fsf@gitster.g> <xmqqpm4wswny.fsf@gitster.g>
In-Reply-To: <xmqqpm4wswny.fsf@gitster.g>
Reply-To: ak@akorzy.net
From:   =?UTF-8?Q?Aleksander_Korzy=C5=84ski?= <ak@akorzy.net>
Date:   Fri, 14 Jul 2023 12:56:51 +0200
X-Gmail-Original-Message-ID: <CADWu+UnvastFbWsjfHvJhvS1RBgD8M1LXuA2VMBMSkTqpiLS5w@mail.gmail.com>
Message-ID: <CADWu+UnvastFbWsjfHvJhvS1RBgD8M1LXuA2VMBMSkTqpiLS5w@mail.gmail.com>
Subject: Re: Beyond Merge and Rebase: The Upstream Import Approach in Git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> it is more effective to have the original authors of these changes to
> update them to your most recent tree, than you dealing with them
> yourself, for two reasons.  There are more ICs than you alone, and
> they are more familiar with their work.
>
> In other words, isn't the real cause of the above that the workflow
> is not taking advantage of the distributed development?  "This PR
> seems to solve the right problem, but it is based on an old version
> of the code, please update?"

That's a valid point. Let me describe how it used to work.

We tracked a busy project (OpenStack Nova), which used to have as many
as 50 commits per day. At night we used to run an automated job that
would attempt to import the latest upstream (rebase and cauterize),
deploy to a test environment and test it with our configuration. It
would have been impractically slow to require the developer of every
internal patch to manually update to the latest version of the code,
before deploying and testing. Also, it wouldn't be acceptable to an
enterprise to always require the original author to rebase their
patch, because the author may be on holiday or may have left the
company, but the business has to move on.

In the morning, we used to check if the automated job returned green
or red. In practice, however, most of the time our patches would
cleanly rebase automatically without manual intervention. That was
because of the way we used to write the patches - changing as few
lines as possible. Also, patches were typically only temporary in
nature, as they were eventually contributed to the open-source
upstream project.

If the automated job returned red, there was a designated engineer who
would investigate the issue on a given day. They would try to rebase
the patches themselves and fix any issues. If they had any questions
or concerns they would contact the original author, as long as the
original author was at work. Most of the time contacting the original
author wasn't necessary.

> In Git, any commit, be it a single parent commit or a merge, makes
> this statement:
>
>     I considered all the parents of this commit, and it is my belief
>     that it suits the purpose of the branch I am growing better than
>     all of them.
> (...)
> M in the "merging rebase", however, claims that M, i.e. the recent
> upstream, fits the purpose of the branch better than the earlier
> three commits did, which is not quite right.  In contrast, rebasing
> merge does not have such a problem, i.e.
>
>     o---o---o---o---o  upstream/main
>          \           \
>           \           a'---b'---c'
>            \                     \
>             a---b---c-------------M main

I second that observation.

Any other comments? :-)

--
Best regards,
Aleksander Korzynski
