Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9F6C43464
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 19:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4447C20866
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 19:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="HOaidAh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgISTPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 15:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgISTPq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 15:15:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1130C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 12:15:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b79so8697331wmb.4
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 12:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1n1AMJjvzxygsQ6a4uzsqaHHfMaf1oOIGYchTyPm7XU=;
        b=HOaidAh5Elm6yN4ApCq+av9Cx/1PQyLTG1A2rsmOsSUR8ZzDMdfQZKKchV/81ly5Fc
         zf6JUYm12vHqexl90ncQ/T+Ud8JWFUxNYYiMaEOe2/MCrDmnq/4/zKMbttTIXOKv60or
         qgbnzqzINs/gH9r37YH6rFCLQjRimYvXEUyW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1n1AMJjvzxygsQ6a4uzsqaHHfMaf1oOIGYchTyPm7XU=;
        b=RzN/qEO1xxd1qFg4WO1ixqkjKq8QnGqDVChUJm0joc8BqqDLOfPGFeY6em035bRoKe
         smUEp7OV/k61KtIC4VYKXfYeambbJ1I9An2Ucj74DcQprZkbEfffqlGiOMvETocJ2+PQ
         AZxMkrk74VSPxQSp/rEK7FT4ykIDIyqSHS/8Ri9d/ZWIQCR1TYaraQHkWTusNxliaK6r
         yxK4L1Lzs4MZNoQCU46nLdFK7J++3KyUWQXURKo/jTp63kXILeZtP+vEaQ8YxSYRbmaZ
         aC6QXhqtG9LB+FZQF7xdUMZOjbh+RD9S/bgEQjIEfFedbhCfn9BVhd74n5FmPtUEQhrR
         RTZw==
X-Gm-Message-State: AOAM5337A3nzp7uZBvRgsYRH36wvhhzYPHBL8LIGk7FB5nG7FaeS7OEb
        x1+1xoivf5cpG7WWpm9Qci2+vNCx7UW1zL7KnioB8w==
X-Google-Smtp-Source: ABdhPJzzrlM97GscAyK3AN+9gCibzuw5B6e8rBsYr7k0PBfJW/SprC1vTqwUSqmHJJF29OP4Jxoj8AehnFMbXJP6IB8=
X-Received: by 2002:a1c:2781:: with SMTP id n123mr21717119wmn.27.1600542944252;
 Sat, 19 Sep 2020 12:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <8FA765EA-D06C-4569-9921-DC333809E2F7@gmail.com>
In-Reply-To: <8FA765EA-D06C-4569-9921-DC333809E2F7@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 19 Sep 2020 20:15:33 +0100
Message-ID: <CAE5ih7-S5_+LrFpRdjSHaXcg+GUsgiymcZUXCz6AJkW1-ksSWQ@mail.gmail.com>
Subject: Re: Combine submodule and worktree with a center cache
To:     coolnavy2010@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 11 Sep 2020 at 05:25, gmail <coolnavy2010@gmail.com> wrote:
>
> Hello, It is possible to combine submodule and worktree with a center cac=
he like `$HOME/.git-modules`
> to speed up `git submodule update =E2=80=94init` and save disk space. Now=
 I managed them manually. I suppose it will
> be support by git automatically.

I'm not exactly sure what you are trying to do but if you are doing this:

    git clone --recurse-submodules git@some.server:myrepo
    cd myrepo
    git worktree add /path/to/worktree

then you can make the submodules part of the worktree go faster by
using the --reference option:

    cd /path/to/worktree
    git submodule update --reference /path/to/myrepo

That way the submodule syncs don't have to go back to the original
server to get the objects, they can get them from the local copy that
you've already got.

However, I may have misunderstood what you are trying to do.

Luke
