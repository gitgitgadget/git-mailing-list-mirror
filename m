Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2480C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiBXJaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiBXJaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:30:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B55C2649AF
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:29:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id h15so1922385edv.7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gEmDTM92rSmKerd3knxGpDKIY15c3THq6+xlWkdDAbA=;
        b=kmThLkGSeLl7VWUXMa2LNAwIQxPEkAyTFwFTtvWm84vTQ823MrsF6EC1Z/GAqk5Fsh
         7XHYMAhnxeyoewQfmDenJzrVhhy1qnHfLy4PwHCV3eZtwx4r5Nq5v6l9eBkMBxEAjE/t
         LrmL5jt3DlN/4xjm9cW1sRrpV9/APRnfaarjnu6Nen9YGqnAz/MdKPtP8rVJ6XXsSDFr
         sDAmkehFGNHrxnPKRRwH3LLTiBR939nZTqEqWfWj/LNetrYh1m/8/nfUdgFlKyN1KTMY
         JWbgSqcF8WsNO0dP22ve7oyijfsoOk41ykn0anGSEs8BmJyRC224tIntbEMjVArtbqlc
         Z9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gEmDTM92rSmKerd3knxGpDKIY15c3THq6+xlWkdDAbA=;
        b=bkB9gyDpECLl4gAS/UYZo0ozIukoRuvvVagOR7P2KJOJvWXZ88ro/tdByDQfvD/u5x
         4t9LpSXQzmFDHPLn74bCyJUJ2+HaROCDLESW6oub9JvsFzTuWiF2rOc4FVVKJceMmnDj
         v1V0+f5yqOqSXbkkp5Eg6K9eQ1w2PRIOyeTl76DEmOkPs2ZLLmQIqKrHwXdIfTGa0iMc
         5chH3oONnmJLZkQVi8r8a+KddXsd+6xIGafmrPs+yf253p19F7h7Jgaj+AOlRUsdx2zl
         4RfVIQ9e9EyL2fvIbCZCUsZnxBJCe5UY01778rU+oFVXdgWQUbE7cjoeSvy76C6umRqo
         BFsg==
X-Gm-Message-State: AOAM5302V7eo72Sj4mJZ9gAD59Ysxec2wAl5yJrUHHBxkHt4sjtNg457
        zBiLdNaJP4L36g8K2z3oRVhiCpG0gC+FzT9UITXyJZBf2pM=
X-Google-Smtp-Source: ABdhPJwod5NKgyiEGYZ7GZ4g5yc+Tteu0GPV7IdgoQgaTy8zw9GHMwo+ksSx/YGT8oh7KhVG5lb2keOyTXo3IsMCGRA=
X-Received: by 2002:a50:ee14:0:b0:403:c81d:c3dd with SMTP id
 g20-20020a50ee14000000b00403c81dc3ddmr1443495eds.195.1645694977986; Thu, 24
 Feb 2022 01:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <CAP8UFD2wNSJmiohfAGrihm5sO_q4a6UpLMsVNAF5uWyuWt7R9Q@mail.gmail.com> <CAC316V5x54Ah566haa5wZ8zE=gkhYtziC+FVjXoBXn7xY_-WsQ@mail.gmail.com>
In-Reply-To: <CAC316V5x54Ah566haa5wZ8zE=gkhYtziC+FVjXoBXn7xY_-WsQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Feb 2022 10:29:26 +0100
Message-ID: <CAP8UFD1dfXHYudpT=0e_2DZdmZMKyqKO13EbPozwpZkEYewxNw@mail.gmail.com>
Subject: Re: [PATCH 0/2] microproject: avoid using pipes in test
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 6:22 AM Shubham Mishra <shivam828787@gmail.com> wro=
te:

> > > This is my first contribution that's why I am keeping diff short with=
 an intention to understand the process instead of making impactful change =
in first attempt. Later, I will send more patches to fix the issue for othe=
r files.
> >
> > Please read the "Only ONE quality focused microproject per student"
> > section of the above mentioned page.
>
> here I mean in next patches, I will be fixing the same "Git on LHS of
> pipe" for other tests. I think that will be considered as the same
> microproject and I am still eligible to fix the same thing for other
> files?

In the "Only ONE quality focused microproject per student" section, there i=
s:

=3D> This means that for a microproject that consist in refactoring or
rewriting a small amount of code, your patch should change only ONE
file, or perhaps 2 files if they are closely related, like =E2=80=9Cfoo.c=
=E2=80=9D and
=E2=80=9Cfoo.h=E2=80=9D.

So, no, we really prefer you to focus on 1 file (or 2 files when they
are strongly related) and then move on to your application or regular
patches, reviews, discussions, etc.
