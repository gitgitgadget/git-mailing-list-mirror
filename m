Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD8C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 22:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiAaWxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiAaWxP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 17:53:15 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A1C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:53:15 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id y84so19049303iof.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CnGSwgQgbsrE27SJg7hsJs6QH2N8ZpHGRGcIKmT12Pc=;
        b=U1nArA7LceBbgsQYZlD9SXQ8Q1fCGhE45dpK3/UekQq/7y2lZJaKcvAW1pKI+wzdme
         T8F0YxehxeiIwOrxHwBa1NqKPXhQG3xbb7tTQL8GqYde4X40kAR7qbHFpQ9n1FbHmNj2
         RCczSMjc/UTr8lHhqmwxspzTEPJGGLZey2cjMsqS8bOOt9kiG+XC/Vx38BIslzO1E5Vp
         3SuBqZcf70T1CTrsbFOnEjnEEfLGWbnwoPIYkta6AqoamnJVq8vYgoz5RQ+FUbl7hpey
         zcqOKCBnuuZvaOHDNsyN9IlBe1jd7Y1B41iIMCro2mbfHLK9UeG1jMLOtrum747GJH3U
         NvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CnGSwgQgbsrE27SJg7hsJs6QH2N8ZpHGRGcIKmT12Pc=;
        b=MesUorHZ6Dh7TAKpXv0TSEgIQvlPvFcDVq6muMOcc0fBA7MfTofjxnR7mWhCURLB63
         evoa/8B7tsjDmwhJFfhc2E+Vydcjdlp51NUTv3O9kpmaLOfp508SVazVQdmTV3EolqAj
         A+5cg8FfumpS6QsuZL7+g9+Q5Vp2VlFIPatFBisaWKWmNl2VZJR+S4IVFrw6Qh9wkRQ9
         FUfPBQudttDhA5BgnI07qihFUapLUM+HrqmZqDehd29DteU0t1D4BemPxJm16LJ4l4O/
         5mqo4Oe3QZyfCl/Bdh392uvh5l8kU/tTUISHtiW28/VsFNzrGNDBAKpkty+7c/OQBExH
         A9wA==
X-Gm-Message-State: AOAM532kMBf6K7k3xgnYnLV42Tnl9QXT/p8fyorh8AK+RDCjBs2ypiyF
        UxdqcKy0lLIgbNAocFuwdESN8VWsKMr0CQ==
X-Google-Smtp-Source: ABdhPJxNZ8lAziqpuzpr4LbDfk6T1HaOd1Frt8cZ4uyx/VMtirF7qZGQiLvcmDL4nqkBdTE6Byth9Q==
X-Received: by 2002:a05:6602:27d1:: with SMTP id l17mr12434916ios.180.1643669595302;
        Mon, 31 Jan 2022 14:53:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8sm19669472ilq.14.2022.01.31.14.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:53:15 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:53:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] fetch-pack: use commit-graph when computing cutoff
Message-ID: <YfhoWk1LFnzbFaQf@nand.local>
References: <cover.1643364888.git.ps@pks.im>
 <31cf8f87a149c0fc8013b869e0e30364f3c60e01.1643364888.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31cf8f87a149c0fc8013b869e0e30364f3c60e01.1643364888.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc Stolee, in case anything I'm saying here is wrong)

On Fri, Jan 28, 2022 at 11:17:03AM +0100, Patrick Steinhardt wrote:
> One thing to keep in mind though is that the commit-graph corrects
> committer dates:
>
>     * A commit with at least one parent has corrected committer date
>       equal to the maximum of its commiter date and one more than the
>       largest corrected committer date among its parents.

This snippet refers to how correct committer dates are computed, not how
the commit dates themselves are stored.

Indeed, the corrected committer date is used to compute the corrected
commit date offset, which is the "v2" generation number scheme (as
opposed to topological levels, which make up "v1").

But that is entirely separate from the committer dates stored by the
commit-graph file, which are faithful representations of the exact
committer date attached to each commit.

Looking at the very last few lines of the main loop in
write_graph_chunk_data() (where the committer dates are stored):

    if (sizeof((*list)->date) > 4)
      packedDate[0] = htonl(((*list)->date >> 32) & 0x3);
    else
      packedDate[0] = 0;

    packedDate[0] |= htonl(*topo_level_slab_at(ctx->topo_levels, *list) << 2);
    packedDate[1] = htonl((*list)->date);
    hashwrite(f, packedDate, 8);

the low-order 34 bits are used to store the commit's `->date` field, and
the remaining high-order 30 bits are used to store the generation
number. (You can look in `fill_commit_graph_info()` to see that we only
use those 34 bits to write back the date field).

So I think this paragraph (and the ones related to it) about this being
an approximation and that being OK since this is a heuristic can all go
away.

Thanks,
Taylor
