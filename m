Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B222047F
	for <e@80x24.org>; Tue,  1 Aug 2017 15:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbdHAP1t (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 11:27:49 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36917 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdHAP1s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 11:27:48 -0400
Received: by mail-vk0-f54.google.com with SMTP id r199so7523934vke.4
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7TSVpvjP99a4bvERMu3+5g2mxktmpLHK212e0jox828=;
        b=Bjn2S9MK1+B95R9HbMXZDkejvwz9z7WrSmAv1M142KGmKkb+bo0rGnjuLhuqOuH573
         GAnFBLy7OAbTmKFpHfnRWNLufVOpVIm1D2WMMW0zmHk8CfAjXmg+kAOAvMbz5vBCOCpU
         Wh0BvGbwfeQ9X2kmM7q61hLxB8DWVXo4+ewFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7TSVpvjP99a4bvERMu3+5g2mxktmpLHK212e0jox828=;
        b=EKgSGofMhk8fOE1RpTdAMnheDYLCBV6E4gZXjSYS70+r2fLkqU7fhknUmFym3JSv3K
         OdgmXP+o1jC4gnFpeeBd7F2U2nFjTGsaU+FJvY03fyxQjUXIwx9eMq2jZLaL7OLzqrJ/
         V8fM+iSWjcYpeV40F+qzRDdxyjalztNeRBWM8wh1mtdubj4Le1b1en3VPq2ggvsKM1lx
         RlXLis6FaLAJ6OW5wpKLoiRN0j4YRfvPnZKo3SJ8GkfBZsoP/Q2uOoFWghr92+EDuiKI
         eA4+LURbBgCx7rGqSJkkkvsbPNmRLJeHDhRBCjI2U5TWl4N+0gNX9mTivHBtBS4HYwFf
         Acnw==
X-Gm-Message-State: AIVw112P4TbqW5pedkefIYpRkuQaMU9Ldm+ptNUKOkOzxG5bcIgWZtoD
        mrB/9oHXKsSCozFZqbMNI+S0fL/CY5DG
X-Received: by 10.31.98.65 with SMTP id w62mr12565919vkb.160.1501601267444;
 Tue, 01 Aug 2017 08:27:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Tue, 1 Aug 2017 08:27:26 -0700 (PDT)
In-Reply-To: <CAD0k6qTFV2AAbWiKvi4=OoodoXEgxswLEbraC3xP1LzvtRRaGg@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAD0k6qTFV2AAbWiKvi4=OoodoXEgxswLEbraC3xP1LzvtRRaGg@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 1 Aug 2017 08:27:26 -0700
Message-ID: <CAJo=hJvsBTDO-8OxrxwfV-=4XWW1w-616DGu31aVb5EU7DWcDA@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Dave Borowitz <dborowitz@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 6:54 AM, Dave Borowitz <dborowitz@google.com> wrote:
> On Sun, Jul 30, 2017 at 11:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> - Ref-like files (FETCH_HEAD, MERGE_HEAD) also use type 0x3.
>
>> - Combine reflog storage with ref storage for small transactions.
>> - Separate reflog storage for base refs and historical logs.
>
> How is the stash implemented in reftable? In particular, "git stash
> drop" needs to be able to remove an arbitrary single entry from a
> reflog.
>
> I don't think the current proposal supports writing tombstones for
> reflog entries, so this maybe implies that "stash drop" would have to
> be implemented by rewriting the whole reflog for the stash ref during
> compaction. Can the current compaction algorithm support this?

Yes, the reftable holding the stash would have to be completely
rewritten for a "stash drop" command to be able to remove a reflog
entry.

> I suppose there are more exotic alternatives:
> * Go back to the normal ref(log) format for refs/stash. I figure you
> probably don't want to do this, given that you already moved other
> ref-like files into the reftable in a later revision of this proposal.
> * Implement the whole stash storage/command in some other way that
> doesn't depend on reflog.

I think the simplest is just put refs/stash in its own reftable, and
put that reftable in the stack somewhere. Editing refs/stash reflog
requires rewriting and replacing that reftable in the stack, but
otherwise doesn't impact any other (possibly much larger) reflog.

Pushing things onto refs/stash would be creating new small transaction
reftables on the top of the stack, which should be compacted with the
lower refs/stash table. I guess that means refs/stash needs special
handling in some of the compaction code to keep it isolated.
