Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7403DC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 19:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiBVTju (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBVTjt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 14:39:49 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C5862CE
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 11:39:23 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id j5so10780786ila.2
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 11:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2+QTrdP2KadlOQNlhJ9AZZbK7Z0f1OaX2oAHMGdPnqk=;
        b=EcGP/g/7CneTx08AN+99HO0f4wOGFygM6/9zmPYziU+Dps8p2UBfTkj8eTOFhjDatB
         98tOV1LfFXQsqndcLxQg/BSMO5Fj3x2RE1GrBYI9L0jEsQI3XKWyzeUVgH8BjQBhmlqx
         YF+hVRL8D/1W9wR6MbLB40k0IxesF8DSnOhmWTFacmMPScGe8QMSM1eYLVz3vfEgzRd2
         L5EpypewgG9CUp2ESTBJfUTugPjSrw2bE9xk3IHrqiGmOAtjojnNFRh59ZQV4XpReJEW
         f1B/poNc62wjCpj6b7IP7Rywg3BvaPx6GwRIufAJhRhkLpxGt/jie+W3y+igPxBY8vUV
         WOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2+QTrdP2KadlOQNlhJ9AZZbK7Z0f1OaX2oAHMGdPnqk=;
        b=eOTp3NVDbGePzmuuZ5lDdTVx1rArQQfts7S+R//zHAZfPjUxtWd4kPzvz200DbCbe/
         UcYFhSWz0OYTx30JmfJiv/YpKxXVygNdtOxnEz+qvubUDSDGVUeuWuILcqzgeIXkNefv
         pVas0o/hjqjQBabZSS9qS/7bVKbiZ6+mc/y1wnsWJEECArr2b9rgE9nPSCWhxx6Kpjbj
         TsSNSF0CLIseietD3GeFWcOawxQAh4xXL8Eo63w9g1iZJtmrqJjW8DllOvhbUNGJ0tno
         Lt98+WAJRE4KcsrQZmBmQ82lo0sxES4/R1Jqr86zGozS3vl7Akms4iuBjk0veOOGnlQY
         XVaw==
X-Gm-Message-State: AOAM530ifVkFQhGvbg+YUXyWPD1bvq1Ion0PHeGJK2w+jq3OEbmoLpCB
        3RSMKDLZGFsD0puyT4Ilc0viNw==
X-Google-Smtp-Source: ABdhPJzjoJxiwxzabb3PljodI/DIylGNPjc4RC2bjukEA08hc4cRtMOHvC83FpXzkPklRTzmR6qfUg==
X-Received: by 2002:a92:ca06:0:b0:2be:85f:7d04 with SMTP id j6-20020a92ca06000000b002be085f7d04mr22396766ils.216.1645558762399;
        Tue, 22 Feb 2022 11:39:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p8sm253732iln.0.2022.02.22.11.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 11:39:22 -0800 (PST)
Date:   Tue, 22 Feb 2022 14:39:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Shubham Mishra <shivam828787@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/2] microproject: avoid using pipes in test
Message-ID: <YhU76TpyP6p56/oV@nand.local>
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <220222.86pmnf6ket.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220222.86pmnf6ket.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 03:24:31PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, Feb 22 2022, Shubham Mishra wrote:
>
> > pipes doesn't care about error codes and ignore them thus we should not use them in tests.
>
> Aside from what Derrick Stolee mentioned in his feedback, all of which I
> agree with.
>
> I think these changes are good, but it's not the case that we try to
> avoid using pipes at all in our tests.
>
> It's often a hassle, and just not worth it, e.g.:
>
>     oid=$(echo foo | git hash-object --stdin -w) &&
>
> Sure, we can make that:
>
>     echo foo >in &&
>     oid=$(git hash-object --stdin -w <in) &&
>
> But in the general case it's not worth worrying about.

Agreed, and I would add that we don't necessarily need to worry about
non-Git commands on the left-hand side of a pipe. So something like:

    find ... | sort >actual

isn't a problem for us, because our test suite assumes that something
like find will not fail. So leaving instances of those alone is OK,
but...

> What we *do* try to avoid, and what's actually important is to never
> invoke "git" or other programs we invoke on the LHS of a pipe, or to
> otherwise do so in a way that hides potential errors.
>
> That's not isolated to just pipes, but e.g. calling it within helper
> functions that don't &&-chain, but pipes are probably the most common
> offender.
>
> The reason we do that is because in hacking git we may make it error,
> segfault etc. If it's on the LHS of a pipe that failure becomes
> indistinguishable from success.
>
> And if the test is really checking e.g. "when I run git like this, it
> produces no output" printing nothing with an exit of 0 will become the
> same as a segafault for the purposes of test.

...yes, we do care about Git failures. So something like:

    git ls-files | grep "want"

would be no-good, since any failures running 'git ls-files' would be
quashed by the pipe.

Thanks,
Taylor
