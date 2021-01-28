Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D00C433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 01:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0078464DDA
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 01:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhA1BGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 20:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhA1BEv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 20:04:51 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFABC061574
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 17:03:22 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id q13so2709689pgs.6
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 17:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aTaE3+DFqIfDQAnDY4CHOa9WNXk8BFBufILO/a0oY5s=;
        b=f/wZImR+wuuDpxgyFrQHpcHL11FUkfD3GPemrpZYgmvI/nXF3RIgeYo13ZSFuCMsz1
         A2mlo1Hv99Tji42shRB9SJjbF1SnOAEd8uUmvAXqd0Cf3kekBvYtRlvyI3yuRUGrjjUP
         jRWHtL3jNmLZ0dFItAAs/HAHJ2vpDoAK2+ZbNz4f3/ajflIt1oj95Le566f3U/syh9dd
         RjLEj6OaBdPjT4IukAsaS6bIDA0LF4uaLgRIKNdPGCm15qaGghgMGaRz0jnpcUo1mmGC
         T1fnR5cdM1ccuog8I2xFcsuRFfm4c4TloAB4i2KXUBZcpcyntP2zpSyf5A1ZabBermEC
         3yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aTaE3+DFqIfDQAnDY4CHOa9WNXk8BFBufILO/a0oY5s=;
        b=JzMmIbM0PZc9l79l5d+pjzzJOs0JLz4i1bde1f5VDiIdBzJnI3seT4K11DnQMKjzJi
         rgwZcPYPLM9q81bsy++zaTl0k1A0QY28E5K+Uh1W9kII57zvNl3nbFHlsZBS2+QD7EEU
         RtOha1UW+AkpEHISCzZF6Ith2BAMmjcOTIxkN67o7LD10N/ohRoI+hgUiVyypS8bYXzF
         gxq6MSlCxbmML/z1GO2pBu87vuX2PLU7Cwr+OODlZDMWM+K88yGJIgDFnaOnWiOFdxr3
         mjW+nkI/xLDTw3Nj9apxoGh5d0bFFswLG1/RADM+lQ/UP+VzaHYT4NGmSjUzE1H1habx
         4Enw==
X-Gm-Message-State: AOAM532L6g0fxsmzyAVIrr/46hDR6envyY3A3CbVeAeT0iOsv29cm8hE
        sk2raPBqGequ8AQM/RzrOYuMoB16bthnFSTOlzz5
X-Google-Smtp-Source: ABdhPJz9DHWb78WsQ94c3QBouasy02iuvr2VLd3ee6DgSh4TgP755uypnTJjR0xl0xjFm7HrxneY8xIwcP22l+ZDrLqI
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:80d3:0:b029:1c0:c5de:ff68 with
 SMTP id j202-20020a6280d30000b02901c0c5deff68mr13411899pfd.79.1611795802247;
 Wed, 27 Jan 2021 17:03:22 -0800 (PST)
Date:   Wed, 27 Jan 2021 17:03:20 -0800
In-Reply-To: <87ft2q7ck4.fsf@evledraar.gmail.com>
Message-Id: <20210128010320.3880242-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87ft2q7ck4.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Sun, Jan 24 2021, Jonathan Tan wrote:
> 
> > +void register_found_gitmodules(const struct object_id *oid)
> > +{
> > +	oidset_insert(&gitmodules_found, oid);
> > +}
> > +
> 
> In fsck.c we only use this variable to insert into it, or in fsck_blob()
> to do the actual check, but then we either abort early if we've found
> it, or right after that:

By "this variable", do you mean gitmodules_found? fsck_finish() consumes
it.

>         if (object_on_skiplist(options, oid))
>                 return 0;
> 
> So (along with comments I have below...) you could just use the existing
> "skiplist" option instead, no?

I don't understand this part (in particular, the part you quoted). About
"skiplist", I'll reply to your other email [1] which has more details.

[1] https://lore.kernel.org/git/87czxu7c15.fsf@evledraar.gmail.com/

> This whole thing seems just like the bad path I took in earlier rounds
> of my in-flight mktag series. You don't need this new custom API. You
> just setup an error handler for your fsck which ignores / prints / logs
> / whatever the OIDs you want if you get a FSCK_MSG_GITMODULES_MISSING
> error, which you then "return 0" on.
> 
> If you don't have FSCK_MSG_GITMODULES_MISSING punt and call
> fsck_error_function().

I tried that first, and the issue is that IDs like
FSCK_MSG_GITMODULES_MISSING are internal to fsck.c. As for whether we
should start exposing the IDs publicly, I think we should wait until a
few new cases like this come up, so that we more fully understand the
requirements first.
