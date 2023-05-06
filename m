Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE8C77B75
	for <git@archiver.kernel.org>; Sat,  6 May 2023 00:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjEFAGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 20:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjEFAGS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 20:06:18 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C7F65AB
        for <git@vger.kernel.org>; Fri,  5 May 2023 17:06:16 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55a5a830238so22382137b3.3
        for <git@vger.kernel.org>; Fri, 05 May 2023 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683331576; x=1685923576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CvSyytO6tra6GtwWM+Figp91qGSOx3uOZmL2a4PHI60=;
        b=OzCjGQrsPp1n2AM/g5+TwMqmf8BogmatIDmT6gNviBtjlKD1krXDX67JSoa5hX8Zs7
         G35GV0iaaMT01xJMZ0N+qfYwVs807W72fxYadF+cTqV17WPtyEYxwwEkn+D3OkLL3P7/
         JpaKwNw9n80TaAxChdI2jGegOD36KTE6dOlCoTcnmMhr5U3QM/ffEie30A8vO7qRUKXj
         g0lB4mhKWtdi3TtsIXlKbNBLFvlfK8TT7fCZ50mDQc4wH1E7N8QFpJb68P25brRirGjo
         6fYOVyZt0BAtx3rciVotBeWYktBde8puqXrreQE8okuLwwltLawFpf4/O7e8rEl6j8+M
         KiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683331576; x=1685923576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvSyytO6tra6GtwWM+Figp91qGSOx3uOZmL2a4PHI60=;
        b=f2Ig4xAC5mr4ejJxT8A6mmJ7AAgQ3Oja6yvPgoKnSEid/7IsPpGvl90coeYUMOzKus
         H25JGbibBwWLAwMzFQK3lODss/H9vYuFWBEQw19cnEcpmJFJXG/TGzdrfcRvBLSwLhoz
         38B+70reC84LuG2kwASAHB4vl/OAYl8YRa4+ZgyMWHBuPT9Bo3UUXQiCMgaqie1Aqq5Q
         CIizelLwJPbOvEIfX8k7Qtr54NpFNE54TNxoah7bxl9Dir5V0B6tWVFQgJENip9qEd1K
         Fv/nbG6ynAiDmD7Uv8VNZnEm3kgMjFNG2U6C1X7ZmBHQoynEZZ2t/Vt/V3dBfixPOFj2
         1wag==
X-Gm-Message-State: AC+VfDxqSwT/rY1ONRPy9O3tSNdyaxl7JOtAfQKBhgC/GqykGDuuwrFI
        GqnclnZWw2kWwzryfIvSuqN51Q==
X-Google-Smtp-Source: ACHHUZ7UVr+/ylZ/nEYYXHLYgM/K80scleWwVrVADlS5+XX8hUcBmHLSXLb8EnWGIndXH3j3XpsOqA==
X-Received: by 2002:a0d:e242:0:b0:52e:f109:ba7a with SMTP id l63-20020a0de242000000b0052ef109ba7amr3356022ywe.51.1683331575681;
        Fri, 05 May 2023 17:06:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t204-20020a0dead5000000b0055a1069886fsm790015ywe.129.2023.05.05.17.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 17:06:15 -0700 (PDT)
Date:   Fri, 5 May 2023 20:06:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <ZFWZ9gQ4c0dLzoss@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
 <20230503195906.GA1796816@coredump.intra.peff.net>
 <ZFLQfMtIGcZHNERE@nand.local>
 <20230505212322.GA3321533@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505212322.GA3321533@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2023 at 05:23:22PM -0400, Jeff King wrote:
> On Wed, May 03, 2023 at 05:22:04PM -0400, Taylor Blau wrote:
>
> > So it gets tricky when you have a pack.extraCruftTips program and want
> > to invoke it in a non-pruning case. You could do something like:
> >
> >   - call enumerate_and_traverse_cruft_objects() *always*, either because
> >     we were doing a pruning GC, or calling it after
> >     `enumerate_cruft_objects()` (in the non-pruning case)
> >
> >   - ensure that enumerate_and_traverse_cruft_objects() is a noop when
> >     (a) cruft_expiration is set to zero, and (b) there are no
> >     pack.extraCruftTips programs specified
>
> I'm not sure why you'd need to traverse, though. If we are in "-k" mode,
> we are keeping everything anyway (so I don't even see the point of
> asking the helper about extra tips). And all of those objects that are
> not reachable from the regular traversal are by definition "cruft" and
> go into the cruft pack.
>
> Maybe I don't understand what you mean by "non-pruning" here.

By non-pruning, I meant something like "git gc --prune=never", which
would run the equivalent of `git repack -A` to generate the pack
containing just reachable objects, and then invoke `git pack-objects
--cruft` to generate the cruft pack.

Thanks,
Taylor
