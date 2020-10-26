Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44312C388F9
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E910621655
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCahIb+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgJZTql (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:46:41 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55389 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgJZTqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:46:40 -0400
Received: by mail-qk1-f202.google.com with SMTP id u16so6982149qkm.22
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zTLuEp7BUq9sAVIOf0tz1A9XLjm1BBXSkdzAsylBOzk=;
        b=uCahIb+0cyfFLhWUdqJO+lPhhr9p+YjX+EddGTRBf5pQOjC1D5dbMlgEo7B+FEIgCH
         YKCv69h65eVCNT0fHu5L3/hgskOHPxgx13Zl70w7ukwTouXb9AJRCzff+SwELZFaACcl
         9/Y+FN2dAyrOyMOaoz33yH8onMqUYkd18zZZ4rQoYbn4zceVCfKieTYIYJ0Kj98Slgf5
         /uzqaBEB2VeFZaQTEhoTpzN+62FjX0bgaMb4aH6yfCvTY0gGfo5JXTyBMPNqNEedQ4ug
         JkhLoDOpb9F82DBG/sXrz8U6Z7xT/u0iMREQo4RAfkK3c1o1nh2dL5osWRFmRfsLNYBL
         w1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zTLuEp7BUq9sAVIOf0tz1A9XLjm1BBXSkdzAsylBOzk=;
        b=jtrGtZGcD5ENOb0mwrnu6wwCwrdC9S0UIxsRLAgz9DaRt+Kyx5pxr2zWc5rxqTy3r+
         4EA3RXpQhXnZdbRW8d6MeeTrrKKcyqztqI2RgUVFY3RpLCmQC6RZilCdcf6a1ltM2kLB
         1dgwJNIz7NtEs++b0/tvcIj8EXdn8pQCkXG2ZAU/bt2YKSUTcsONWcdg2bI5DMC8OQZz
         LcGhpgEYAGA2cQJ8Qaj/i14GvSwFvt4PpLKcRxDngPQF/MPbuOMr/vJE8IsAbimucsPX
         k3dCP7v/UbYrS6VV0E6Dug5X690doT2bgFe6q0WM8kmVZLDvHS2GuliDib9J8vgPnmDC
         CrKw==
X-Gm-Message-State: AOAM532/8NtjwkI4WGNC4X/8NVejPuz6EzBFON5tOnAhnRXsaU981Ntr
        H2i/CfdbsYUKC3Ya+PQLhDby82G9XtnN2o5imNcb
X-Google-Smtp-Source: ABdhPJz74Dmk9TmxMGJpHCla+KolBi0wEZB/vuajG71U2mzvvjHNTL8ZNKQ8650YK0+qD9ZOZLd6CGJf46ISe94b/4OF
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:85e3:: with SMTP id
 o90mr13257349qva.46.1603741597526; Mon, 26 Oct 2020 12:46:37 -0700 (PDT)
Date:   Mon, 26 Oct 2020 12:46:35 -0700
In-Reply-To: <2f04c074-3eee-766c-bedb-2e3cc0a91528@syntevo.com>
Message-Id: <20201026194635.2119420-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <2f04c074-3eee-766c-bedb-2e3cc0a91528@syntevo.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: Re: Questions about partial clone with '--filter=tree:0'
From:   Jonathan Tan <jonathantanmy@google.com>
To:     alexandr.miloslavskiy@syntevo.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        christian.couder@gmail.com, marc.strapetz@syntevo.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Having such an option (and teaching "blame" to use it to prefetch) would
> > indeed speed up "blame". But if we implement this, what would happen if
> > the user ran "blame" on the same file twice? I can't think of a way of
> > preventing the same fetch from happening twice except by checking the
> > existence of, say, the last 10 OIDs corresponding to that path. But if
> > we have the list of those 10 OIDs, we could just prefetch those 10 OIDs
> > without needing a new filter.
> 
> I must admit that I didn't notice this problem. Still, it seems easy 
> enough to solve with this approach:
> 
> 1) Estimate number of missing things
> 2) If "many", just download everything for <path> as described before
>     and consider it done.
> 3) If "not so many", assemble a list of OIDs on the boundary of unknown
>     (for example, all root tree OIDs for commits that are missing any
>     trees) and use the usual fetch to download all OIDs in one go.
> 4) Repeat step 3 multiple times. Only N=<maximum tree depth> requests
>     are needed, regardless of the number of commits.

My point was that if you can estimate it ("have the list of those 10
OIDs"), then you can just fetch it. This does send "quite a bit of
OIDs", as you said below - I'll address it below.

> > Another possible solution that has been discussed before (but a much
> > more involved one) is to teach Git to be able to serve results of
> > computations, and then have "blame" be able to stitch that with local
> > data. (For example, "blame" could check the history of a certain path to
> > find the commit(s) that the remote has information of, query the remote
> > for those commits, and then stitch the results together with local
> > history.) This scheme would work not only for "blame" but for things
> > like "grep" (with history) and "log -S", whereas
> > "--filter=sparse:parthlist" would only work with "blame". But
> > admittedly, this solution is more involved.
> 
> I understand that you're basically talking about implementing 
> prefetching in git itself?

No - I did talk about prefetching earlier, but here I mean having Git on
the server perform the "blame" computation itself.

For example, let's say I want to run "blame" on foo.txt at HEAD. HEAD
and HEAD^ are commits that only the local client has, whereas HEAD^^ was
fetched from the remote. By comparing HEAD, HEAD^, and HEAD^^, Git knows
which lines come from HEAD and HEAD^. For the rest, Git would make a
request to the server, passing the commit ID and the path, and would get
back a list of line numbers and commits.

> To my understanding, this will still need 
> either the command I suggested, or implement graph walking with massive 
> OID requests as described above in 1)2)3)4). The latter will not require 
> protocol changes, but will involve sending quite a bit of OIDs around.

Yes, prefetching will require graph walking with large OID requests but
will not require protocol changes, as you say. I'm not too worried about
the large numbers of OIDs - Git servers already have to support
relatively large numbers of OIDs to support the bulk prefetch we do
during things like checkout and diff.
