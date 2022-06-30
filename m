Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD5C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 02:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiF3Cr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiF3Cr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 22:47:27 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBA324F01
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:47:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cs6so27794464qvb.6
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eo+dPaHaZ107fuQx//iov1fSi7D3vnlr5YT2TfhtxfQ=;
        b=27x59WDZ+6g/FJTZjxIv2fiL6ihpAGwOQ8KQfY4Vs6TZ4l77o2OyyWC30mob+k9nnh
         RxMemvENgd4NaULzsboybei+I/c0LV6eN25DbKogEbimSFb3XwTE5Cs0NYIlfOcH4eHh
         CcZYfrLaOqC78Vhl22tFa6p0frexvhwdSNSrpHZ3Pz7jrPXk6VVxVVqMhxZsfZyy/Jq4
         7P6LhN7Ds//6XUYvQXwWbluBuu007v35d2F77I2o/s/GRRmdE4qMGIGMJXAeabQlpca9
         5qNHwZtTcGEwZQhZp8nM2BhmekG6zAUjRELVm8hZY9trPKJrCtG8De8R2oBD4AfcA8Q0
         NCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eo+dPaHaZ107fuQx//iov1fSi7D3vnlr5YT2TfhtxfQ=;
        b=ykeL+iTexAs0oHBY8+L9Fcrrx27kAoyZqM6CkodelboccgnGYxmYvbbFr9tTKKgB/g
         t5trJSiSI7gVuT59ZEDHQzABpVmR1n4vAqq07taa7I+5gJGBFu1iM5P1wE9e345WKIuj
         fHj8ZoUN5SsjYy9oRjAMTbd7f1DzYLFlPr9AuyFArn5g98IRv4TsxL/EgO/V27pwZ5rO
         nni/7LLWnJJNk+kHMzoZj+AMCo8jZH8kg0XfNKeieDgjae0E9rvDJB5yUr/+h1oY7vLV
         75+ecd8Lt4IYNyiP2iS80qipHohD2jyPnZW0n2KdYx2mnsTnzcTCvKj2Yw1aMmi+g6FS
         uszw==
X-Gm-Message-State: AJIora/sAOLACrNT1M9ScraF2KRVm/icqT16NwXoC3F2kXWRZ5Rp1A9B
        JOsXgxYeMFVufJixvlGkjsv8l/5DIfYx7A==
X-Google-Smtp-Source: AGRyM1sY79atf1RkKuxxlIR56wB8gc92Giq2noTAUdLUInDx8foIL6pahxjAWsIVQR5VlvmcDvTwmA==
X-Received: by 2002:a0c:b247:0:b0:470:5c08:eea5 with SMTP id k7-20020a0cb247000000b004705c08eea5mr10565049qve.102.1656557244835;
        Wed, 29 Jun 2022 19:47:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8-20020ac84e88000000b003117ee89a51sm7154510qtp.70.2022.06.29.19.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 19:47:24 -0700 (PDT)
Date:   Wed, 29 Jun 2022 22:47:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com, gitster@pobox.com
Subject: Re: [RFC PATCH 0/4] move pruned objects to a separate repository
Message-ID: <Yr0OuwCyDot0wJjs@nand.local>
References: <cover.1656528343.git.me@ttaylorr.com>
 <20220629225405.1864460-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220629225405.1864460-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 03:54:04PM -0700, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > This series is an RFC for now since I'm interested in discussing whether
> > or not this is a feature that people would actually want to use or not.
> > But if it is, I'm happy to polish this up and turn it into a
> > non-RFC-quality series ;-).
> >
> > In the meantime, thanks for your review!
>
> Thanks for this patch set. I can see this being used by, say, someone
> who wants to preserve a repo that rewinds branches all the time (the
> refs would need to be backed-up separately, but at least this provides a
> way for objects to be stored efficiently, in that reachable objects are
> still stored in the main repo and unreachable objects are stored in the
> backup with no overlap between them).

Yes, definitely.

If it helps, I can share a little bit about the motivating use-case
within GitHub. All objects from a fork network are stored together in a
repository that we call the network.git, with individual forks keeping
track of their own references.

The network.git repository can often grow quite large, and/or contain
data that the owner of an individual fork would like removed (e.g., they
accidentally pushed sensitive credentials, force-pushed over it, but
would like the now-unreachable objects to be removed).

We don't usually do pruning GC's except during manual intervention or
upon request through a support ticket. But when we do it is often
infeasible to lock the entire network's push traffic and reference
updates. So it is not an unheard of event to encounter the race that I
described above.

The idea is that, at least for non-sensitive pruning, we would move the
pruned objects to a separate repository and hold them there until we
could run `git fsck` on the repository after pruning and verify that the
repository is intact. If it is, then the expired.git repository can be
emptied, too, permanently removing the pruned objects. If not, the
expired.git repository then becomes a donor for the missing objects,
which are used to heal the corrupt main repository. Once *that* is done,
and fsck comes back clean, then the expired.git repository can be
removed.

> I think there is at least one more alternative that should be
> considered, though: since the cruft pack is unlikely to have its objects
> "resurrected" (since the reason why they're there is because they are
> unreachable), it is likely that the objects that are pruned are exactly
> the same as those in the craft pack. So it would be more efficient to
> just unconditionally rename the cruft pack to the backup destination.

This isn't quite right. The contents that are written into the
expired.git repository is everything that *didn't* end up in the cruft
pack.

Suppose your cruft expiration is 1.hour.ago, and your doing a repack on
repository foo.git, expiring objects into expired.git. There are three
disjoint sets of objects:

  - reachable objects, which will stay in foo.git
  - unreachable objects which were written within the last hour (and are
    thus too new to prune) which will stay in foo.git
  - unreachable objects which *weren't* written within the last hour
    (and thus will be pruned) which are moved to a new pack in
    expired.git (and removed from foo.git)

So the cruft pack in foo.git and the one written to expired.git are a
disjoint cut of the unreachable objects in foo.git based on their mtime,
with the recent objects staying in the source repository and the stale
ones moving to the expired.git repository.

The original implementation of this feature was to move the entire cruft
pack out of the way like you describe. This is sub-optimal because you
are forced to generate that cruft pack with `--cruft-expiration=never`,
since you can't actually prune any objects when generating the cruft
pack, or they would be gone forever. But since you have to move the
entire cruft pack out of the way, the visible effect looks like you
actually pruned *all* unreachable objects, as if you had supplied
`--cruft-expiration=now`.

Being able to expire just the objects which have aged out of the grace
period should cause this race to happen less frequently in practice.

> Having said that, if there is a compelling use case for repacking even
> when we're moving from cruft pack to backup, the design of this patch
> set looks good overall. There are some minor points (e.g. the naming of
> the parameter "out" in patch 1), but I understand that this is an RFC
> and I'll wait for a non-RFC patch set before looking more closely at
> these things.

Thanks,
Taylor
