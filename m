Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8880EC56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 19:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18991206F7
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 19:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4w/4txw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgKYTKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 14:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKYTKA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 14:10:00 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AC9C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 11:10:00 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c12so2277477pll.12
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 11:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YDC3JWjKbLReMdgZG44WPJi99bo/sRckkEDrRvjb3vI=;
        b=l4w/4txwozKGnXI9J2HMzTAsyHwhgTlm9hX2g9uxj4k22wpHpUElCJOQl5En20ITFz
         X360XyZ+wQO0EjZ1vdigiswsjiyERXsk4izhBk5paA+++KMnmWHo9KU1uQnLwkwbp+F/
         24GpYedoIOmKFJvLLnBCGOcucWhASJ0JFwVuPifdotbgF5Zt7buLLb1vqkGOY+bw7Ftz
         qaISzzXA3Ao3DxF5oIGTVUQmPIr7/himyBMhZMGRw6VybxikjyRw68qtWg7RcIdAtAee
         G8E9Af2fmQPz8N3I7Q5l/1pk2+PkMOoftrhwPmTZHasJoKUUaE73iqXXTbjAW0MkxjYY
         G3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YDC3JWjKbLReMdgZG44WPJi99bo/sRckkEDrRvjb3vI=;
        b=om/oUQRo8UZ0U4rwHZPDGsh2klf08FttSwuNJ68sBO0DtvyYxRKWCBsMUhNixWolj0
         eIDu3iRACOcKFvd/48P1vbiHIT27rrxIBshr+X63btXYu4++/av0gxl8AWIOpbJG/VOr
         Klddhv375EbXPlXMr3ewAyWNRL5JpENPscc6vcutNd41KARP84bfmn3gVYbQ9cqsORKh
         PaQOo+jMobfJJb5wov929A13WOMTnqRcgdnqA6canSagbxiFC3tOJf0+Z79UgRhj5dK4
         O2VqLntGJVdJ56d+AUNqoSxLzidz3LTYoadygl0/ZeV5Re4AUSjYHkwoOx334Pe2uvY4
         xyPw==
X-Gm-Message-State: AOAM530GqZEs4UH+RLhCmi+iWa3D92OQnTtoqq2e7oypiCCl3vPbeFIi
        maoV+Ou8bBpqyDsIUlAN4kxJg7wMygIWLAhRxF3p
X-Google-Smtp-Source: ABdhPJxPNttT6izICj+Kl5TZL4VBIfwKzB5GUtM3XIS+ZsBJeAON8znV7ybE0GT/G9U7PwvtTJ466iuVMKpZDdaOaCPN
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:638f:: with SMTP id
 f15mr5825031pjj.200.1606331400200; Wed, 25 Nov 2020 11:10:00 -0800 (PST)
Date:   Wed, 25 Nov 2020 11:09:57 -0800
In-Reply-To: <87zh35okzy.fsf@evledraar.gmail.com>
Message-Id: <20201125190957.1113461-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87zh35okzy.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 6/9] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Jun 10 2020, Jonathan Tan wrote:
> 
> > +This is the implementation: a feature, marked experimental, that allows the
> > +server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
> > +<uri>` entries. Whenever the list of objects to be sent is assembled, all such
> > +blobs are excluded, replaced with URIs. The client will download those URIs,
> > +expecting them to each point to packfiles containing single blobs.
> 
> I was poking at this recently to see whether I could change it into the
> more dumb method I noted in
> https://public-inbox.org/git/87k1hv6eel.fsf@evledraar.gmail.com/
> 
> As an aside on a protocol level could that be supported with this
> current verb by having the client say "packfile-uris=early" or something
> like that instead of "packfile-uris"? 

Hmm...would the advantage of this be that the client can subsequently
report any OIDs it finds as "want"s?

I guess the protocol could be extended to support "packfile-uris" at any
negotiation step.

> The server advertising the same,
> and the client then just requesting packfile-uris before ls-refs or
> whatever? The server would need to be stateful about what's requested
> when and serve up something different than the current
> one-blob-per-pack. 

Statefulness will be difficult. Right now, protocol v2 is stateless,
and updating it to be stateful will be difficult, I believe - at least
for HTTP, the statelessness design has been long there and other
implementations of Git or systems that use Git might have already made
that assumption (it is stateless both for protocol v0 and v2).

As for serving more than one blob per pack, the current protocol and
implementation already allows this. You can see a demonstration by
cloning the following repository, which supports it on the server side:

  GIT_TRACE_PACKET=1 git -c fetch.uriprotocols=https clone \
    https://chromium.googlesource.com/chromium/src/base

> Any pointers to where/how to implement that would be
> welcome, I got lost in the non-linearity of the
> connect.c/fetch-pack.c/upload-pack.c code yesterday.

upload_pack_v2() in upload-pack.c and do_fetch_pack_v2() in fetch-pack.c
have the state machines of the server and client side respectively - I
think those would be the first places to look.

> But I'm mainly replying here to ask if it's intentional that clients are
> tolerant of the server sending whatever it pleases in the supposedly
> "single blob" packs. As demonstrated by the tests passing with this
> patch:

[snip test]

Yes, it has the same tolerance w.r.t. the packfile URI packs as w.r.t.
the inline packfile that gets sent.

> As you may guess from the "shattered" I was trying to find if the
> particulars around the partial fsck allowed me to exploit this somehow,
> I haven't found a way to do that, just be annoying by sending the client
> more than they asked for, but I could also do that with the normal
> dialog. Just wondering if the client should be opening the pack and
> barfing if it has more than one object, or not care.

Ah yes, as you said, it's the same as with the normal dialog.
