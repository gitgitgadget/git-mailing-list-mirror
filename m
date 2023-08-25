Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D66C3DA6F
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 03:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjHYDoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 23:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjHYDn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 23:43:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4341BD4
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 20:43:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so6733961fa.3
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 20:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692935034; x=1693539834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ownFcJ636FsvxfMwDscJfnRcFiER8ortkj61KDh5mOo=;
        b=HO/eXn52HsTDdG//MCpwWV8gW8J3zedAoV7WRr2arvv9jFcq9t1/nreYMX5yCId9Nq
         k5WgRaO3yRQxae7jg6dEu6R5iTAviUEZHixbAdyXyfrjqyt0soBBbvD1hC489sNSYBNJ
         vHCA5SqAZDFoyjkL1JKExy6O25kEVexZPmFV3V0xdJX+PIYNuP1bSamw479jCsl5ZVL7
         0HwX01TFbSMKvRntJPa2RrjTnizqHgRUiA9ABXvTmOx1GzGVm1z6KhiVx0oBN9VcBnsb
         Rgl6bLtqpx0eVl9WTYLAoEXichosjgv36RJm5dbvoNzdRjJAgNdwx89/JrluKJmoaOw/
         YQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692935034; x=1693539834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ownFcJ636FsvxfMwDscJfnRcFiER8ortkj61KDh5mOo=;
        b=giyWy28+W6PzYzukNFHYnLqcf2FgdN4WI91t08rZxh+NCJk82J1ek8oSRYP09pAbty
         YM2y4cvqXGq92anSPkflKKvNrvzx1Fi/mcS4EGSRaSChUMtE+cxZf2WJwGfSfemZvKpR
         gitTr/A9YHiN/6D8bN1lzwByxG11w7//pvSNMykfmE7WmWMNN+Nfppk4ycZov8O1J2j/
         L85YjNnmo+Fk0wB3YQsWVuCPQ8RhP3/NUliL23P/STCMzO3KCLeA1TPVGEzXmAlU4BAz
         mN109YvXNJTdLq8EtcH85T46uecyIWs/qaZdft0fnrTyVVtJVt4JTNhFLR6sFKPgsoM4
         lCow==
X-Gm-Message-State: AOJu0YwtRvOOVEQBo+WmppkZP7/5lzJDDtvscT/cSOBQ5kGR4huPp+21
        oc3zCccVtqOwXCM2NqJQjlRmRl0mk8NcuTfGOdFhQ2Bq
X-Google-Smtp-Source: AGHT+IERT9ebilaD2JSxXuSc/KC8RgnlG1MXwj8Qi+uTqb60w8IBbTXAkCaI8OAX4RRbLt2TZZ+CELyKyyaIkyr6Ifo=
X-Received: by 2002:a2e:9b4e:0:b0:2b9:ecc5:d1de with SMTP id
 o14-20020a2e9b4e000000b002b9ecc5d1demr12698616ljj.37.1692935033916; Thu, 24
 Aug 2023 20:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJU=AjWatV6A5Vx-yqRfG=yeUWxMvKocc4nTsdq58WHjaYFEzw@mail.gmail.com>
 <ZOfgKQfqvef9FXZ6@nand.local> <CAJU=AjU6cggm+P3d_Ke4uyks79j7uYipbp0xPq7jJ+nCgNSUZg@mail.gmail.com>
In-Reply-To: <CAJU=AjU6cggm+P3d_Ke4uyks79j7uYipbp0xPq7jJ+nCgNSUZg@mail.gmail.com>
From:   Alexei Podtelezhnikov <apodtele@gmail.com>
Date:   Thu, 24 Aug 2023 23:43:43 -0400
Message-ID: <CAJU=AjW24gHCv-K97z=9KZJ4eqOEPvOR_6egFWZtnrZ21c3n8w@mail.gmail.com>
Subject: Re: confused git diff -G
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > given to `-G`, like so:
> >
> >     $ git -C repo diff --stat HEAD^
> >      a | 1 +
> >      b | 1 +
> >      2 files changed, 2 insertions(+)
> >     $ git -C repo diff --stat HEAD^ -G a
> >      a | 1 +
> >      1 file changed, 1 insertion(+)
> >     $ git -C repo diff --stat HEAD^ -G b
> >      b | 1 +
> >      1 file changed, 1 insertion(+)

Never mind my last blurp, thank you for the explanation.

This is how I thought it works but the docs *^^$@%&$ for either
git-log or git-diff: the example from diff but the text is from log.
It could not be more confusing than this, not just might. If you want
to share the text, it should be generic.
