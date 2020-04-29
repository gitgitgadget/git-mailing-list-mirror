Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3FBC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362EF208FE
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="OBa47jFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgD2QzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726580AbgD2QzE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 12:55:04 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC33BC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:55:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so1346913pfn.5
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kXwaEnlnP1bZ4gUV6r/WKeT0Q+Sti3CqTo8SzsS+t70=;
        b=OBa47jFYuKvLy3pPwMXQNvHoVlgWDgY9TjIfJuzSEAFKPXqT5hiOaNiaMYDOytUa0+
         oOsEsUdTxrdPOOLgITnDZu7QtBxwlIIGZlfrSDT5QtzZq1AGfHqWYy2W2qLo7R7irnCR
         mh0KA+BFxfM5n6cVNgM0SzM59hkaQjVeNMw+kJJRn7vk4ftmX2dtBoWNV77MaTBADw6I
         0r+sJk3aVfnzJAMTmWew/X1+NmSX1qrax1slqpnxNOj8E1t39lYE1F1E5yilArGIvE95
         aaHYUgACj+1X9sjT5jIJM3eiIluF6MHdTdobfolSEahIiacrhOhiftUG+Vx1q5KHaveu
         8EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kXwaEnlnP1bZ4gUV6r/WKeT0Q+Sti3CqTo8SzsS+t70=;
        b=JQCRY4Ebd611sOu55XE5aS4xzxzagT8GDnXeBGWrS6aS6buc4bZqyk9URZJ/ePnqr+
         /NU7Cp5bdQXckmU8gJ6eNuJYcg634ZLshOVf7iWTpmVPyN6BjZGO3Oo7hZ6OB38y5nQA
         Ew859dc7jYiosBOannwAW0Q6PtU0rXeuKd2XA5P2txuzpfGjPBCJLyZgp5vHXBlb0O+I
         GpE5YNRDo5YY6HUqPeMyfu1Ad9F6g48hLO+EcTARwC4scGDzAKMElkdw402PaO5myvA6
         kpimAPxhur9jR+AajXaH82PBavZj1sSs8LKgy0YpRUaQ8da54J5DvNl157e1pmaO3zEB
         Bh+A==
X-Gm-Message-State: AGi0PuZi+sGGFpxDWTQLSM2MYE2IYrD4fkv6MQbmla6Ny2zQdG4k3CET
        uRUTLJ9f/CdXFsoItzcOwyLd4A==
X-Google-Smtp-Source: APiQypKqb7k2tExsNRG4AXY8n9YTS5pt05mi5ZCVhfnXYr0o8i1/QaV1lbFJr1bB0stk7Y7vSsr6Kg==
X-Received: by 2002:a63:dd0e:: with SMTP id t14mr33219015pgg.226.1588179304143;
        Wed, 29 Apr 2020 09:55:04 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id u24sm1404006pgo.65.2020.04.29.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 09:55:03 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:55:01 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2020, #03; Tue, 28)
Message-ID: <20200429165501.GC83442@syl.local>
References: <xmqqimhjyy9c.fsf@gitster.c.googlers.com>
 <20200429155701.GA83442@syl.local>
 <xmqqr1w6xmtf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1w6xmtf.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 09:45:48AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> * tb/commit-graph-split-strategy (2020-04-15) 7 commits
> >>  + commit-graph.c: introduce '--[no-]check-oids'
> >>  + commit-graph.h: replace 'commit_hex' with 'commits'
> >>  + oidset: introduce 'oidset_size'
> >>  + builtin/commit-graph.c: introduce split strategy 'replace'
> >>  + builtin/commit-graph.c: introduce split strategy 'no-merge'
> >>  + builtin/commit-graph.c: support for '--split[=<strategy>]'
> >>  + t/helper/test-read-graph.c: support commit-graph chains
> >>  (this branch is used by tb/commit-graph-fd-exhaustion-fix.)
> >>
> >>  "git commit-graph write" learned different ways to write out split
> >>  files.
> >>
> >>  Will merge to 'master'.
> > ...
> > In either case, the rest of the series is ready to merge, and other
> > topics depend on it, so I figure that we can merge the first 6 patches
> > and hold off on the last one for now.
> >
> > Sound good?
>
> If other topics that depend on it build on the whole series, merging
> only the first 6 does not make much sense.  These other ones are
> blocked forever.

Right... but I'm not sure that I agree that this other topic "builds" on
the whole series. There is nothing in the last commit that the other
series is dependent on. So, I was suggesting something like:

  $ git checkout tb/commit-graph-split-strategy
  $ git revert HEAD
  $ git checkout tb/commit-graph-fd-exhaustion-fix
  $ git rebase tb/commit-graph-split-strategy # making sure to drop the final patch
  $ git checkout master
  $ git merge tb/commit-graph-split-strategy
  $ git branch -d tb/commit-graph-fd-exhaustion-fix tb/commit-graph-split-strategy

> Applying a single patch to revert the no-check-oids patch on top of
> this series, and merging the resulting 8-commit series to 'master',
> may be a workable solution, though.  We need to keep an eye on the
> merge possibly reintroducing the no-check-oids stuff when the
> dependent topics are merged to 'master' (that is why we do not want
> to see people build new things on another topic that is slushy), but
> I think there is only one topic, so it should be manageable.
>
> Why don't we do this:
>
>  $ git checkout tb/commit-graph-fd-exhaustion-fix
>  $ git revert tb/commit-graph-split-strategy
>  $ git checkout master
>  $ git merge tb/commit-graph-fd-exhaustion-fix
>  $ git branch -d tb/commit-graph-fd-exhaustion-fix tb/commit-graph-split-strategy

That's fine with me, too.

> That's the simplest solution and we'll have two fewer topics we need
> to worry about when we are done.

Thanks,
Taylor
