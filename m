Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD18C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 21:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbiKQVyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbiKQVyj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 16:54:39 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF896E56B
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 13:54:39 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n188so2481035iof.8
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 13:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQGrOsDZ/CcBDnjKCsls9lXjqTXvZBObj3HaF77zPAA=;
        b=4sGKluBT3DJlUO4D3ZoJ8+3buyMXndVPilmdw66pcv8MDiAfzkLHUKQKAc7TvL37y5
         BMFL7kyFRFBPxEhkB1IoCrJSlpSyymqd9KnulcCdRb74ywlJzmaATl45P46igvUNVpVZ
         odJMheSLUw4BR4XF6L3UtwjwYJtjdkcM2QrAQq8vBnFqMAoA3j7LBMPw/vS8fmmkLqNL
         L1Dx8zFHXh+FwEdNSAmeohhX46nyU//9+F2wefN6xuOGFIXk63MLIfkYYdVkd5DXj/T9
         g+As7aADH8B1b+w2mNd/AMFCKzfEu9VxzOn1AFUoIbU/zpwwOj5OjsxpQe/dK/yZOoFq
         G6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQGrOsDZ/CcBDnjKCsls9lXjqTXvZBObj3HaF77zPAA=;
        b=Kt+EGYBGVTySmpmnwWCR9gMTH5CfUF8qjXvkjlnkbuF6HFv+Nq4gsdU4UkvYfkb89X
         1TS7H3mKOdoUJkYOySqDEdl+cwQyFO/u+6vSgbRWBzaBsw0uP/oKqxukcUn3wIneGyE1
         Zjj0YnvwmHyU7EYGn5i2Kbs1Eg9K2jWyRvP9TA9Q4zFCmGuWQhtAMB/Yu6M7flUOpL9O
         svZUGIkLhZb3ZIUn7W+/9P0CLw+frAlLeLmoRkIAfvDi8Zm9p1plpy/lStSC3ChltdF8
         3qMwX5QFJTbb0eOXYPU8QhsHkZq5HPB+lbjpDlPeTrrOZZ/ve3ixxBFkx0bK2e5p378o
         vySg==
X-Gm-Message-State: ANoB5plFgXm61F3sTLV1YQUNSc9UdSiBV6ZGywViX0fFcInvRjaIZaFG
        m995xNe6DzK0fz0dbtvFxln9FIDK2m66oA==
X-Google-Smtp-Source: AA0mqf7YH7jIZ22630ha3/QqqFShjHN7ZXjMflTDKSnl8ol+9EY1Rvgky+JHcmwb/0M5l7XxYoDrsA==
X-Received: by 2002:a02:9589:0:b0:375:2ff:b633 with SMTP id b9-20020a029589000000b0037502ffb633mr2008012jai.100.1668722078567;
        Thu, 17 Nov 2022 13:54:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bi3-20020a056602358300b006c0aa1ff1a8sm744420iob.6.2022.11.17.13.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:54:38 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:54:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] object-file: use real paths when adding alternates
Message-ID: <Y3atneCCAA4fMFKL@nand.local>
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 05:31:13PM +0000, Glen Choo via GitGitGadget wrote:
> From: Glen Choo <chooglen@google.com>
>
> When adding an alternate ODB, we check if the alternate has the same
> path as the object dir, and if so, we do nothing. However, that
> comparison does not resolve symlinks. This makes it possible to add the
> object dir as an alternate, which may result in bad behavior. For
> example, it can trick "git repack -a -l -d" (possibly run by "git gc")
> into thinking that all packs come from an alternate and delete all
> objects.

Nice find and fix. Looks like Peff had a couple of good suggestions
which I'd like to see incorporated into another version before we pick
this up.

Otherwise, looking at the patch myself, it seems obviously good. Thanks
for working on it.


Thanks,
Taylor
