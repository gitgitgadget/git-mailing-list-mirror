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
	by dcvr.yhbt.net (Postfix) with ESMTP id C2FFF1F461
	for <e@80x24.org>; Thu, 16 May 2019 21:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfEPVbB (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 17:31:01 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:43263 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfEPVbB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 17:31:01 -0400
Received: by mail-qt1-f201.google.com with SMTP id q32so4530243qtk.10
        for <git@vger.kernel.org>; Thu, 16 May 2019 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kZERLI4d1FngmMNjONkpxf6fCkcV0+s3WEFYDi3ChwU=;
        b=X2Iq6CDSXOZOfug14Ts7YgSB/PhM0Ujir2K41ByjPVk1RGPgOdWN099AOWgge4pqt2
         PSb25kYzAp7GGNW2WFNnfEqHwqS6DpwlkfNzTYyzRK7YSu5rCtUNSQlqfRG1cERJsgzm
         BPJWB90DheQ6AJrYpQHhT7pb1r3XDd3nA6eu+R3VP54MHchZhqRur/aTK3g3/tDqlbb1
         2e8UkMKV590SyXNftZxw6Vovp+5UsyIGNxmxrbCyGMAZ/Ban/bMNUkn67b1iQc5SLUv+
         kB+t+ybCIHn2JS1uD8oSGhtKruFZv3eVY0k0EF8RnBy8LUFMZsIVRmKzV7B3uONvYwOa
         Uh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kZERLI4d1FngmMNjONkpxf6fCkcV0+s3WEFYDi3ChwU=;
        b=Ee+LIJ5n1h6EC6kYNP2Z/KeNdt8mDNH9X+ZFBEJKc8ByjBrlmOXlqiGoFp2HEt5DAL
         i/1qfh361cL2rBT2tRjHXfjwQIVZVGeq0+Vp8sDFFbS8HQE8ncXlnWo+FsuErC2aPjrV
         W0Ml0VDr78qww+vTs+IqE8TkKuBOsvwzEJ20AZKROcN5E3+mDL2r1v5SH1FdJRNzHBXg
         XkwYITSlxuk+AdHmUTGDhCq8as6tuJeLNRl32zTh/CzFnPYMlGSipG6LCPDp2mdPBPbm
         dBs1VbwzWq5Yrl/Er4vU31GV1TiOmLdeuvDIPMo7CmS9irPz+9HfmfEsBsij355+/JCX
         ASww==
X-Gm-Message-State: APjAAAX2amPU8ySK3Fy7bL77XwDdaR0feV0CVM6HZldfVNfGaafuP04W
        uE0CCcbUWFZSOZG/pIgSUGneKQsFdd2xhF8mDNu9
X-Google-Smtp-Source: APXvYqzYSUrfVQySdzgPnzWtwqcXMSY43DBBafpfb4F7jeXKgr8ICDY/ulqKScKjfC1+N9Snn2FCVMBKJfwcdQhrG5UO
X-Received: by 2002:a05:620a:1670:: with SMTP id d16mr39559639qko.288.1558042260462;
 Thu, 16 May 2019 14:31:00 -0700 (PDT)
Date:   Thu, 16 May 2019 14:30:56 -0700
In-Reply-To: <20190516211226.GE9816@sigill.intra.peff.net>
Message-Id: <20190516213056.221406-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190516211226.GE9816@sigill.intra.peff.net>
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

> On Thu, May 16, 2019 at 11:26:46AM -0700, Jonathan Tan wrote:
> 
> > > Pretty unlikely, but should we put some kind of circuit-breaker into the
> > > client to ensure this?
> > 
> > I thought of this - such a server could, but it seems to me that it
> > would be similar to a server streaming random bytes to us without
> > stopping (which is already possible).
> 
> True. I was thinking mainly of the infinite-redirection protections we
> put in place for https. But I agree that in general, since we don't have
> inherent limits on the size of workloads, that servers can already troll
> clients pretty hard in a variety of ways.
> 
> So I could go either way, though I do think it makes sense for on-demand
> fetches for partial clones to avoid asking for thin packs as a general
> principle.

This should not be a problem since fetch-pack can already know that
we're doing an on-demand fetch (args->no_dependents), so we should be
able to either plumb a "no-thin-pack" arg in the same way or rename
args->no_dependents to also encompass the no-thin-pack option. But this
can be done separately from this patch set, I think.

> As a matter of fact, should partial clones _always_ avoid
> asking for thin packs?  That would make this issue go away entirely.
> 
> Sometimes it would be more efficient (we do not have to get an extra
> base object just to resolve the delta we needed) but sometimes worse (if
> we did actually have the base, it's a win). Whether it's a win would
> depend on the "hit" rate, and I suspect that is heavily dependent on
> workload characteristics (what kind of filtering is in use, are we
> topping up in a non-partial way, etc).

I think it's best if we still allow servers to serve thin packs. For
example, if we're excluding only large blobs, clients would still want
servers to be able to delta against blobs that they have.

> Right, REF_DELTA is definitely correctly handled currently, and I don't
> think that would break with your patch. It's just that your patch would
> introduce a bunch of extra traffic as we request bases separately that
> are already in the pack.

Ah...I see. For this problem, I think that it can be solved with the
"if (objects[d->obj_no].real_type != OBJ_REF_DELTA)" check that the
existing code uses before calling read_object(). I'll include this in
the next reroll if any other issue comes up.
