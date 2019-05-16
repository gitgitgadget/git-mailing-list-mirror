Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592091F461
	for <e@80x24.org>; Thu, 16 May 2019 23:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfEPXPO (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 19:15:14 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:33973 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfEPXPO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 19:15:14 -0400
Received: by mail-qt1-f201.google.com with SMTP id o32so4799751qtf.1
        for <git@vger.kernel.org>; Thu, 16 May 2019 16:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+8W8euwtG57A2lfDAPs0o2c/Vajh1RDT7iAuXG5CETo=;
        b=PMrbp6jVYtvtw7/O+4qJgobngphgWA4aBjlJrTbGTliiKko2vzciXgocUq/Absn/sD
         wrwSbZPRaKDV4iWgJHDw1chUr6OIPu1sOhtI3NEmykdxXb7zjv222h4bdsYtJVJ5pOXc
         6WP0Ins1PFtehQ22pbQXTaqne3PgM8Yl5N/328kh8Wxc5fPqCCjJBdwFki/+8jndCTGl
         qq/yadLeduuNJ0Gqb7nP8H4mpFwNMnoEZEuWEgchncbD2bQ5MeK+iJ/P0AfE/6ty8HhK
         nnrha/PbpXQDX9Mm28mOAEdqxXDKcDW22GLWAKw8N7WBAvUESng9tCF0Heo1+XCpaWJ0
         u6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+8W8euwtG57A2lfDAPs0o2c/Vajh1RDT7iAuXG5CETo=;
        b=T1GE2qNxSXaNUEZCxpQ+QRpvH6JK1HMzAmxBftA9ak+hhiknK6ib9EOlWrJYsJs2hI
         23wpoFVA0mq0Rrel9Jrg9vT+ktyR2VNi6dtotv5Vcd4svO7hma7iBJQem2PBG8pFj1Xb
         fXgWn63C9C9X0yLbclSUCDvkDtPCcHGd+1iKuVhjdBavjiiIrv7VN4p8AxanDg025EoS
         vIFGtAGsqIAAWOTyjX5lKAXkey0h7H62mQT8KyW4FUx/JdxiSIIVILXponn4FuSJmZt4
         0+UDdLSJodFJmYyxxmn2ZCe2AvCDcAoEKjWui06RHt/RV6HqdaH3XRgsXq24CyaWhZZx
         6inQ==
X-Gm-Message-State: APjAAAWj4WFRS1/QbJxR/p55n/b7USrJeUJJP1sFgWLcFzW9Hu5Vh+4B
        hr0FDyEoHdhEc2ih/f/dPiDlacxpFjg/A0m3AZGX
X-Google-Smtp-Source: APXvYqz2Bw4AiQU4m2xqX2rGXrc/v1qbyCnzqfvfeOAmcAjenjJ4TON7vwLe4eDoEJIz/8JSGCiv+Ny+aMv9gLPO+CR9
X-Received: by 2002:aed:3501:: with SMTP id a1mr45146635qte.265.1558048513035;
 Thu, 16 May 2019 16:15:13 -0700 (PDT)
Date:   Thu, 16 May 2019 16:15:09 -0700
In-Reply-To: <20190516214257.GD10787@sigill.intra.peff.net>
Message-Id: <20190516231509.253998-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190516214257.GD10787@sigill.intra.peff.net>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > Right, REF_DELTA is definitely correctly handled currently, and I don't
> > > think that would break with your patch. It's just that your patch would
> > > introduce a bunch of extra traffic as we request bases separately that
> > > are already in the pack.
> > 
> > Ah...I see. For this problem, I think that it can be solved with the
> > "if (objects[d->obj_no].real_type != OBJ_REF_DELTA)" check that the
> > existing code uses before calling read_object(). I'll include this in
> > the next reroll if any other issue comes up.
> 
> I'm confused about this. Aren't we pre-fetching before we've actually
> resolved deltas? The base could be in the pack as a true base, and we
> might have seen it already then. But it could itself be a delta, and we
> wouldn't know we have it until we resolve it (this gets into the
> lucky/unlucky ordering thing).

resolve_deltas(), invoked before any new code introduced in this patch,
has this comment:

> /*
>  * Second pass:
>  * - for all non-delta objects, look if it is used as a base for
>  *   deltas;
>  * - if used as a base, uncompress the object and apply all deltas,
>  *   recursively checking if the resulting object is used as a base
>  *   for some more deltas.
>  */

I haven't seen any code that contradicts this comment. And looking at
the code, for each non-delta object, I think that all deltas are checked
- regardless of whether they appear before or after that non-delta
object. (find_ref_delta() does a binary search from 0 to
nr_ref_deltas, calculated in parse_pack_objects() which happens before
any resolution of deltas.)

And find_unresolved_deltas_1() (called from resolve_deltas() indirectly)
sets the real_type when it resolves a delta, as far as I can tell.

So there is more than one "resolve deltas" step - resolve_deltas() and
then fix_unresolved_deltas(). The pre-fetching happens only during the
latter.
