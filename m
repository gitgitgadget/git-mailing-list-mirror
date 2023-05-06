Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A4BC77B7D
	for <git@archiver.kernel.org>; Sat,  6 May 2023 00:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjEFAQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 20:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjEFAOn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 20:14:43 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F865AF
        for <git@vger.kernel.org>; Fri,  5 May 2023 17:14:31 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so16689522276.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683332070; x=1685924070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XU1fKxrzwtdkgVyzp0fkCk9Xf+Qm0MfoO/C3cQq2fMM=;
        b=2+Cw/nO1HY/w7qEApG0zCrHoCZZL2td2YZXQ+8TsvpzwwqfHJCUYgWMqaf+Nr0Z+Wu
         EFw8zJ537jGAqxlOUJAhVc2rgfnzOzpuo/zQoHneZKjxRbMAkNJb8SckjtBJtOlSm3wI
         8YiGfAjDeDzRapVbk0aVlTeKAJN0v65qlG2V9eD+2yWY4T00v6R/10WMCgrp9ln7cOtW
         R4+QJI9+0vScVA4Oka3EyDiF0yrc7fRoPZ1hoFs1eK3PfmLBU8lhcNTP1JR92sKJbqmh
         L7Q48wq1fkiGzamhevR0WgMYt4SzcF6GEDRpzpybEtpRezcqjYzclqZVTg/2xfx1bGIl
         08sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683332070; x=1685924070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XU1fKxrzwtdkgVyzp0fkCk9Xf+Qm0MfoO/C3cQq2fMM=;
        b=D/0b9U5Tq9CLpu76dVvQjXJdOqxrSroTz/gfJ+F1D38cF8/MsN3mUs6pDWjGqHU9iT
         bLrXJSqiD4xXb6rEy1aVTGkFJJGMylR9vHjWvQtBUlX6uWf+nqk6hshveRYtXh61lgSn
         6+NC2J0Z1tW3l5zp89Xp3MI2IzIvW0Q7cxk+AwAVEMlQ3EYlzoEaIuVRYPlkmG87miLB
         LfjilkgjubVPCc1U8oAYEeh8vgMeW9XGpV6F+Hl+wLYt2Q949CV1oWBOi2Lfi1l3niXX
         bkSgqSFzulHnPirbTiaY6omzwoWHYqhVshn6/PJVOSoaRCV6ZrnPOdEJK8Y06ldganQd
         Pwvw==
X-Gm-Message-State: AC+VfDzlyy4CRst9RJRkdk4m2rwx8Pp83G2r4XuIig1yHPypLtzdBRos
        pzEvyMaAIxrZyExEMM86aHSWZA==
X-Google-Smtp-Source: ACHHUZ5A0OG/eK+ih+gr4n0FXLffxxiRS9WFGc7JWJox2MAR0aCC92v089C6fTmdETwBJ9QJOke40w==
X-Received: by 2002:a81:a0ce:0:b0:559:f7d4:8d40 with SMTP id x197-20020a81a0ce000000b00559f7d48d40mr4087801ywg.4.1683332070493;
        Fri, 05 May 2023 17:14:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d202-20020a814fd3000000b00545a08184bbsm803127ywb.75.2023.05.05.17.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 17:14:30 -0700 (PDT)
Date:   Fri, 5 May 2023 20:14:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <ZFWb5V2sBYVrOEdF@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
 <20230503195906.GA1796816@coredump.intra.peff.net>
 <ZFLQfMtIGcZHNERE@nand.local>
 <20230505212322.GA3321533@coredump.intra.peff.net>
 <ZFWZ9gQ4c0dLzoss@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFWZ9gQ4c0dLzoss@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2023 at 08:06:14PM -0400, Taylor Blau wrote:
> On Fri, May 05, 2023 at 05:23:22PM -0400, Jeff King wrote:
> > On Wed, May 03, 2023 at 05:22:04PM -0400, Taylor Blau wrote:
> >
> > > So it gets tricky when you have a pack.extraCruftTips program and want
> > > to invoke it in a non-pruning case. You could do something like:
> > >
> > >   - call enumerate_and_traverse_cruft_objects() *always*, either because
> > >     we were doing a pruning GC, or calling it after
> > >     `enumerate_cruft_objects()` (in the non-pruning case)
> > >
> > >   - ensure that enumerate_and_traverse_cruft_objects() is a noop when
> > >     (a) cruft_expiration is set to zero, and (b) there are no
> > >     pack.extraCruftTips programs specified
> >
> > I'm not sure why you'd need to traverse, though. If we are in "-k" mode,
> > we are keeping everything anyway (so I don't even see the point of
> > asking the helper about extra tips). And all of those objects that are
> > not reachable from the regular traversal are by definition "cruft" and
> > go into the cruft pack.
> >
> > Maybe I don't understand what you mean by "non-pruning" here.
>
> By non-pruning, I meant something like "git gc --prune=never", which
> would run the equivalent of `git repack -A` to generate the pack
> containing just reachable objects, and then invoke `git pack-objects
> --cruft` to generate the cruft pack.

Oops, my misunderstanding. I see what you're saying: in a `git gc
--prune=never`, it does not matter whether we ask for extra cruft tips,
since we're keeping all of those objects anyway. Duh.

Thanks,
Taylor
