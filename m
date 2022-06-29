Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B887BCCA47C
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiF2Ukz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiF2Ukx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:40:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B6718E39
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id z16so8125054qkj.7
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6yMvRdqJyvgBc/d30jp1bat2czQu0kPYcPRqYamF+80=;
        b=GesQYsaK7kjLxVsJZYrblswcB2dh9J9lAqquDCwBIyBwFKqmW5og6QFqduhQvNYQQd
         c3JO3GYxW6m/VO9tZo8i/Vw+PSi6XTYbyILm2YVujayAmLMqdD05EihOKSx/36rmGRXa
         MPOzkJDBUCf1g/26N1ozT/g/Sj84TfJBQPle0JAU9V+vMEvEqjPDDUWZpHdGGMN5CfVf
         E+r/fVzNhZha07gASFVqjYOYJYNq5iVzVxNcbFbENPdJLBXZfO56EIxnGlW5hsrx7RTQ
         EkfI7HSLZF5G2KMIL2niL0YCwCzQH1MR1EcJWejXCY9y9K08f/UpMTQZXQjSwg7HFyKG
         xyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6yMvRdqJyvgBc/d30jp1bat2czQu0kPYcPRqYamF+80=;
        b=5Wy9tXgsqE0Re/0dzUoGIx7/mVeSueU9djPex6V/1giSmWqewNK87rhePdcYUd97Cw
         9bTeALA9UuiARFBOovZGyTmePt0D5NQ/z+u6RqTczM26LyrXO90TLMAjFnOUyRe0MlMc
         3pYK02LtwP32gIkQr0bD8CVnTwyL7gj/kvSHzuu7vJ7G882ivx67Pc+4/IoyXOYADT+/
         QbXEARe3V3GQfVcjrHud2q95YZgGaH6sXgzqS431Dxr93prANGm6IwhUJ5DaMEytwPVO
         xWefAcW9k719x1NnefVauf/tavIHp09bsLLSW7tfEj6WjBJhjj4Kh4b+9uRVMkoZQ/3p
         PSXg==
X-Gm-Message-State: AJIora8lruFdAPQvQZJyybHXCPKmZAjwzaA/ZA8DWBeG35sq+DaVvVlI
        uX83XTCDF5q9UV2iOmO7UDASlA==
X-Google-Smtp-Source: AGRyM1sPji2SWhCu0MhwYoSpjOxOAbyA4OKK800g4wpF7Dg/6Y8Cy0tLiUNXUlbeMIGMXnMzLwCcnw==
X-Received: by 2002:a05:620a:2014:b0:6af:5eb:dff3 with SMTP id c20-20020a05620a201400b006af05ebdff3mr3682588qka.459.1656535250931;
        Wed, 29 Jun 2022 13:40:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l13-20020a05620a28cd00b006a6bbc2725esm14634105qkp.118.2022.06.29.13.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:40:50 -0700 (PDT)
Date:   Wed, 29 Jun 2022 16:40:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 5/6] bitmap-lookup-table: add performance tests for
 lookup table
Message-ID: <Yry40c0lqOoU8p4G@nand.local>
References: <Yrom04Go0tCAZWT8@nand.local>
 <20220628075843.19170-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220628075843.19170-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 01:28:43PM +0530, Abhradeep Chakraborty wrote:
> Taylor Blau <me@ttaylorr.com> wrote:
>
> > I think this "create tags" step can happen outside of the test_bitmap()
> > function, since it should only need to be done once, right?
>
> Yeah, I also think the same. That's why I tried to not include in the
> Function but for some reason, one test is failing -
>
>   perf 24 - rev-list with tag negated via --not --all (objects):
>   running:
>   		git rev-list perf-tag --not --all --use-bitmap-index --objects >/dev/null
>
>   fatal: ambiguous argument 'perf-tag': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>   not ok 24 - rev-list with tag negated via --not --all (objects)
>
> One thing to note here is that the first `test_bitmap` call always
> Passes. But the second `test_bitmap` call fails due to above error.
> It throws error irrespective of any parameters for second `test_bitmap`.
>
> If I put it inside the function it doesn't throw any error!
>
> For this reason, I put it into the function. Do you have any idea
> why this happend?

I think that it's because we delete all of the refs in the test that
creates a partial bitmap state. So anything that relies on perf-tag
existing after that test runs will definitely not work :).

My original suggestion was misguided there, unless we wanted to make the
aforementioned test (the one that creates the partial bitmap state)
restore the ref state after it finishes running, but I don't think
that's worthwhile.

Thanks,
Taylor
