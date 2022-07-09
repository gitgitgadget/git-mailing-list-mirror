Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68773C433EF
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 06:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiGIGj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 02:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGIGj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 02:39:56 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F86419A0
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 23:39:55 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id f68so528742vsc.11
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 23:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tl3FJ0FRqctbwXf1MM18fXOtKMVsAfNGqQgTgWskXV4=;
        b=SN1rzDjw86wFWIAFVcRw5DKf01aRGBdIE7c4aWuNmG0G0sL9gRkgASjXHT9sRBjgrd
         SmdK9M/bYwI9DNJS51TMEI0LC3AsBvuKJe2iRsjkDulMXZyozmSTJONYzrB8MvN7u/Cz
         D0DWxJ3UY8ohfiHaWpJ3y1aLKv93/zQcuXNI+6LofxDBL/B2NQPhqr+ip2SwRYbFAIZN
         Vb6mpqvR0ZcgrDVwiXYftahFplODKCdSY9/miSVTW/bCZW7IGX5+vNgx/Z3mSTkG53uM
         MQd5NKGTd6lqr3rjpZW8Mmn8/g8txoMo9z2KIKKXu/GYt1E6pafeN2pfDuhgPWKWbCLw
         /rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tl3FJ0FRqctbwXf1MM18fXOtKMVsAfNGqQgTgWskXV4=;
        b=yy1tyC26ZrTvnrEp5dhU5Z6W23ufuQ17M5vm3+5CMD8IMivn2+qAjX+x76gTM8R7ZX
         76chNODDdpk7X82uko1tl+QHNbwuiYtQN7sv8bvo1EBLo5nua64ILAQvOD2dFrOWiLv3
         FbdQq2OIuLTt6IGvybc3sPPEJ+IMNWG/A93H0XMTeu8942tbPBA0rGi8fIsMDAlQ0W0n
         3g8esfbwk5elVsnnxcM4/DmrmhdHV9buHMCQcMWoHL0qh9aqX0cahN/7BUnt6nw4rKuV
         r8QVEbW1spT78SFw9SnsNvamUQ8LJDkb5iqy/DzqQz8o1caLGOk9VNIzTQvsJ8OS49AC
         EjDw==
X-Gm-Message-State: AJIora81iiqGjNP0eqqF/finXswZHQ8Wagx4A7r1fcu+POqwdZDnv5UR
        33HjCFvrvCyycF7Ex54vldm4GGE0w7iph1//gvI=
X-Google-Smtp-Source: AGRyM1uFsNrk2ZuiNbKRYrxnHNkJx9V/WS+ZQWeNg/9Q/m/X3rEVci+YK5vSkVtzb8JUVCg6vlbOUo14TQXqjvUqNsQ=
X-Received: by 2002:a67:ce09:0:b0:357:31ce:8872 with SMTP id
 s9-20020a67ce09000000b0035731ce8872mr3003576vsl.5.1657348794630; Fri, 08 Jul
 2022 23:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220709002658.vt34nnzhxefg72d3@Carlos-MacBook-Pro-2.local> <20220709005227.82423-1-hanxin.hx@bytedance.com>
In-Reply-To: <20220709005227.82423-1-hanxin.hx@bytedance.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 8 Jul 2022 23:39:43 -0700
Message-ID: <CAPUEspiP=U+pBYm3tx1wPc46He=5WKkdFYCr-58a-UfhAD+PUg@mail.gmail.com>
Subject: Re: possible bug with commit-graph causing git to fork bomb (was Re:
 [External Mail]Re: Git fork process infinitely and never stop)
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     bagasdotme@gmail.com, chengyang@xiaomi.com,
        derrickstolee@github.com, fanjunhui@xiaomi.com,
        git@vger.kernel.org, hehao@xiaomi.com, lilinchao@oschina.cn,
        maxin7@xiaomi.com, shifengbing@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 8, 2022 at 5:52 PM Han Xin <hanxin.hx@bytedance.com> wrote:
>
> > > To be a supplement.
> > > If I delete .git/objects/info/commit-graph,  everything works well As=
 well as fetch with `-c core.commitGraph=3Dfalse`
> >
> > This would seem to indicate that something in the repository might be
> > triggered by the commit-graph code.
> >
> > > if I execute `git fetch --filter=3Dblob:none --quiet --progress miui =
--prune --tags +refs/heads/*:refs/remotes/miui/* +refs/heads/miui13-s-thor-=
vendor-stable:refs/remotes/miui/miui13-s-thor-vendor-stable`  on version 2.=
25.1. It just throw error rather than infinite loop, like this youtube vide=
o "https://www.youtube.com/watch?v=3DqvYTvVRE0FU&feature=3Dyoutu.be"
> >
> > maybe a regression?
> >
> > Carlo
>
> I looks like the same issue I reported in [1], and we can see the fixup
> in [2].
>
> 1. https://lore.kernel.org/git/20220612161707.21807-1-chiyutianyi@gmail.c=
om/
> 2. https://lore.kernel.org/git/cover.1656593279.git.hanxin.hx@bytedance.c=
om/

Indeed; and it is already integrated through
hx/lookup-commit-in-graph-fix and merged all the way to "next", which
would likely become 2.38 sometime soon.

=E7=A8=8B=E6=B4=8B,

if you could build a new git version based on next and confirm it
solves your problem, it would help us all.

Alternative can get that single "one line" patch[1] and integrate it
on top of the git version you are using.

Carlo

[1] https://lore.kernel.org/git/96d4bb71505d87ed501c058bbd89bfc13d08b24a.16=
56593279.git.hanxin.hx@bytedance.com/
