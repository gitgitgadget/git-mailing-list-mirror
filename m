Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B379C636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D9E60E0C
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhGTVIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 17:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhGTVHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 17:07:35 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E915C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:48:13 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id s32-20020a056a0017a0b0290336a8d53a3aso455639pfg.6
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QuKBqBUVTLZ+kkxIc4WL+qzRIKfpaWXLRhs8Za2bEeg=;
        b=XK6GO2RMiHI7xFFV5WHZc/h9CEDMYEnpScWl8exffhOEm6r9vSpieeLCc1xDymi8YR
         YP2INfkysTtVC+07OAvtL6C2ND4w2MwomsVpvuQQlU07gxch6cyKXBJgLI9H8TEWgjhO
         iQNH6rOg7J8YX21NmfyrzVgryoA+a+DRrFmPZSdDuUwqMLBurRIzcqpHAA/MgwXioon/
         Qh8hXB1YBn3/VzvnCXaO24J19L6ItdaAhrvM0bza648TZ2y5jMyp7lVA6mT1BNRNpPp4
         wQOQdtTJN7ZS47c18dJGMIrebSlDCuZxoXYqRyAOwbhcEWL6qpCROAoFtr5v3F2oMW7K
         9lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QuKBqBUVTLZ+kkxIc4WL+qzRIKfpaWXLRhs8Za2bEeg=;
        b=fsqz/qRgVonSxW6Lub1c3RCD8KCeNUKXik8v9R0CkqRckBtR4V4Uxo/QWQBtrhFwX7
         6WXWClzdbXiERRE04KpZDvAj7tsfkIOhaAiJCU5pCyeXRcX4IIEiyx3CNCb1ioauopdj
         bV1a++pdAv/oI3A4ChSLBIDV6+9TRhhY2RighI5hlTcKLYEXk0QmX/MnhLFfXl/TRQQM
         JmsHZns/VFVSsDJm1KJHxCFJ52lLxgB3V087FHjme1nk31FWzmIjIAdwL2JPtm1TFken
         lfTSVc7z9WeObw0VcQEiGmjfbJqGctlPgeML8Hk0P+Q7Hjd79mcuWMQoLRo8/BS8tAVm
         Zi9g==
X-Gm-Message-State: AOAM531K82dZDk7vfKsL/Ri0XotYNpVcx8VKChaW5JPaCB1c2L65wfVt
        n2aw2ZTelAxVfS7+McpcBsfvGw5D9ywfEK5XE16u
X-Google-Smtp-Source: ABdhPJxa397IijGgKLQLqguq3Ozr473LXBB+fHovv96CHx46r4PJjcSSvzLLTl7xsB5OkMGltstX/XwrQfTzvlRC/n5k
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:7442:: with SMTP id
 o2mr466391pjk.47.1626817692750; Tue, 20 Jul 2021 14:48:12 -0700 (PDT)
Date:   Tue, 20 Jul 2021 14:48:09 -0700
In-Reply-To: <87o8awvglr.fsf@evledraar.gmail.com>
Message-Id: <20210720214809.3596513-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87o8awvglr.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: Re: [RFC PATCH v2 2/2] hook: remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, iankaz@google.com,
        sandals@crustytoothpaste.net, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This is a bit orthagonal to what you're going for I guess, so sorry in
> advance about the "but what about" bikeshedding you must be getting
> tired of by now...

No - thanks for taking a look. More ideas are always welcome.

> ...but this part makes me think that if this is all we're aiming for as
> far as server-client interaction is concerned we'd be much better off
> with some general "server message-of-the-day" feature. I.e. server says
> while advertising:
> 
>     version 2
>     agent=...
>     # does protocol v2 have a nicer way to encode this in the capabilities? I think not...
>     motd=tellmeaboutref:suggested-hooks;master

Right now we don't have a way in capabilities to include arbitrary
strings, although we can extend it if needed.

> Client does, while handshake() etc.:
> 
>     # other stuff
>     command=ls-refs
>     ....
>     0000
>     # Get motd from server
>     command=motd
>     0001
>     refat suggested-hooks $SUGGESTED_HOOKS_AT_OID
>     refat master $MASTER_AT_OID
>     0000
> 
> And server says, after just invoking a "motd" hook or whatever, which
> would be passed the git version, the state of any refs we asked politely
> about and the client was willing to tell us about etc.

Ah...so the main difference is that it is the server that computes
whether a message is shown, based on information provided by the client
(different from my patches wherein the client computes whether a message
is shown).

I'm not sure how this is better, though. We don't need to build another
mechanism to print server messages (since it can already do so - the
same way it sends progress messages), but then we lose things like
translatability, and we have to build another endpoint for the server
("command=motd").

Also, one thing to think about is that we want to be able to prompt
users when they run hook-using commands (e.g. "commit"). With my
patches, the necessary information is stored in a ref but with your
idea, we need to figure out where to store it (and I think that it is
not straightforward - I'd rather not use config or extra files in the
.git directory to store remote state, although if the Git project is OK
with doing this, we could do that).

> FWIW I think there's lots of use-cases for it, and this specific hook
> case is just one, so if we could make it slightly more general & just
> make this a special-case of a generally useful facility.
> 
> Even for your use-case it would be useful, e.g. the whole discussion
> we've been having about should the hooks by in a magic ref or your
> current branch or not.
> 
> With a motd hook it doesn't matter, you just make "git hook install"
> support installing hooks from whatever rev/tree, and a combination of
> the "tellmeaboutref" and that feature means you can pick one or the
> other, or tell users they need to install <some custom dependency> first
> or whatever.

True - we avoid the discussion by having essentially a new namespace of
name-to-OID mappings. I still think it's simpler to use refs of some
sort for this, though. (Also, even if we use a new sort of name-to-OID
mapping, we need to make a ref for this OID so that it will be fetched,
so we might as well use a ref for this.)
