Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A1DC2BA2B
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 02:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09ACB2075E
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 02:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="eNYfYz5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403929AbgDNCEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 22:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727867AbgDNCEO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 22:04:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428ECC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 19:04:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r20so3719724pfh.9
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 19:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pHoAw4OZcBCfYtdcEuvdQbVUYn5HY6ZFd8d2JOD9aLk=;
        b=eNYfYz5H8AWpRxKfFDVw7UloZ9OPpo97fIVPKyWnG9G0dulrobsW8LDdDM5zdIV/eh
         UKGjAP344aYdcb2OBOVY2PKtIQ1wnPv0hMqxAteF1HnVvX8XNfDQn568jqUFDWjcbTqQ
         ts3TyStSIRB1MpYMWAQGLBxXmOB8kuma3sz1jdh20K8m6fim+jJkhHheX/OinwHv6frZ
         hSd5hOktcttmUzYP7+cbGuXKu7qUwWExd3Z/MlcG3+Q1VD7qZNGjXtdedX0k/3izwpph
         SINpt1Q8vZ/HdOBA/UnfTxo1wVtEsDntSEG8N0P99kABtYR7W8siGkmonFCdXlk5+faG
         Ii7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pHoAw4OZcBCfYtdcEuvdQbVUYn5HY6ZFd8d2JOD9aLk=;
        b=G8WxRsxAb5MEB473JaeHF+bBjZVhYfvCqLmTIv4gvpOtcLM4fb2UCEgInXBnd8qmXe
         DnvmXwWsPl0y1oK9ZV8S8T16TOWFoBksorvHQ4c/T1TqzkBIyxQK6FMn8XT9SrTra/FX
         V5T39ojVHKl5xnQimKRtDiHe6e1lG+kzhtAxfkDagFEuVfAH7b6jQ4WBmgNVLVUBUKF5
         BvMpPLmvO4+n3MGxoxmYTas+lzD6mdD8Lut7uKMN5JRiv0RE6/X//y1ksZx6a1WRMCzY
         obdRLCbhpSO7XfM4M2TuS3WG95lyd4oW+mQXFtMms5PxcH7rvJtrWnGkfwMK6qDmT7nP
         oZDw==
X-Gm-Message-State: AGi0PuYNBvS6/v1I3ZLLEu7s+oTgQFWvCv9K3IhOl4CcltzCi37ScNWg
        gOi/sUKYcbjj2rROYNmS7YcHEA==
X-Google-Smtp-Source: APiQypJz2tKha4+GGKve+FSrSNn6qM5b7DU3ioEfiK5gP89WdI4EREySYWNdQv3PHkt7o2r9B/YCaQ==
X-Received: by 2002:a63:d801:: with SMTP id b1mr20006748pgh.49.1586829852477;
        Mon, 13 Apr 2020 19:04:12 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id ep21sm8113480pjb.24.2020.04.13.19.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 19:04:11 -0700 (PDT)
Date:   Mon, 13 Apr 2020 20:04:10 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20200414020410.GC71440@syl.local>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
 <20200403183057.GA659224@coredump.intra.peff.net>
 <20200403184933.GA57202@syl.local>
 <20200403193842.GA7859@szeder.dev>
 <20200403195103.GA663412@coredump.intra.peff.net>
 <20200403204013.GC7859@szeder.dev>
 <20200403231021.GA672258@coredump.intra.peff.net>
 <20200413193934.GC63249@syl.local>
 <20200413212506.GA28407@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413212506.GA28407@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 13, 2020 at 05:25:06PM -0400, Jeff King wrote:
> On Mon, Apr 13, 2020 at 01:39:34PM -0600, Taylor Blau wrote:
>
> > > > Hm, are you trying to go in the direction where '--stdin-commits'
> > > > would keep erroring out on any non-full-hex-oid, but would accept and
> > > > silently ignore any hex oids that are not commits (perhaps even when
> > > > there is no such object, dunno)?  I think that would support the use
> > > > cases you mentioned, while it would still save me when I do the 'echo
> > > > <ref>' thing (somehow I regularly do that, remember doing it the day
> > > > before yesterday!).
> > >
> > > Yes, exactly. The case you care about and the case I care about are
> > > different ones, so there's no inherent conflict between them.
> >
> > I was looking back again at this today, and I think we need something
> > more or less like the following on top. I'll send it out later today or
> > early tomorrow...
>
> Yes, the behavior there looks fine to me. Though you may want to catch
> the parse_oid_hex() separately and return its own error message. Telling
> the user "I don't understand non-hex object names" instead of just
> "invalid commit object" may be useful. I think it would also make the
> flow of the function easier to follow.
>
> If we were writing from scratch, I'd actually suggest that
> builtin/commit-graph.c do parse_oid_hex() call as we read lines, and
> then commit-graph could just be working with an oid_array or oidset,
> which would reduce overall memory usage. I don't know if that would
> cause other complications, but it could be worth looking into.

It actually improved the situation quite a bit, so thanks for the
suggestion. In addition refactoring it was quite a lot of fun. The
second-order benefit was that it moves these two failure modes into
separate parts of the code.

Converting the user input to an OID (and thus dealing with input like
"HEAD", "refs/tags/foo", and etc.) is a separate part from turning those
OIDs into 'struct commit *'s. So the "non-OID input" and "this OID
doesn't refer to a commit" checks can be moved into the builtin and
library machinery separately, which is quite handy.

The patch is too large to send here inline (there's a lot of noise from
renaming 'commit_hex' to 'commits'), but I'll include it in my
commit-graphs backlog series shortly.

> > +               if (ret || (ctx->check_oids && !result)) {
> >                         error(_("invalid commit object id: %s"),
> >                             commit_hex->items[i].string);
> >                         return -1;
>
> We could also take this a step further and just ditch check_oids
> entirely (under the assumption that nobody really wants it; they just
> wanted to catch bad names in the first place).

I'd rather let this shake out in a discussion of the patch once I send
it, since I'm not sure how people feel in general.

> -Peff

Thanks,
Taylor
