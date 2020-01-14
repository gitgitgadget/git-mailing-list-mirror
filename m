Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE8EC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047D3222C4
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwE2HDxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgANTMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:12:00 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:52902 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgANTMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:12:00 -0500
Received: by mail-pj1-f74.google.com with SMTP id u10so8618248pjy.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vThUlqBhaGIOdQUZt1ADVBkL0IsCNijoV+PH4Hb+h1Q=;
        b=SwE2HDxmRTgsla0t0wtUVNhnuCyJtLZEBoetTp/etlXoAU368dSDNKjK5VoSZTwFiZ
         OT0bCeMBrqkFWAU1ucNEdzb5x4syKNhx+Eb9YuSa+lD0wxJZ6ppU9jfdYBqqGYrkm7Q6
         B+/QLM+DG1KIPzPEJz9bxM+x6reYCGoJ1sLUfxdO90PhDoWWHsfkqdOoqSrmKVTRObAw
         eBbct2ZyRsySZYsBEvY3jQKKykbSJVhi2AJiDVIlP9/BCbjf53Wvdp0nIIztw//6QGqH
         UOP/wTDhGOG3tTgMN0di33MjKq0VKu4N2MEfxQL8pD8/TlQ7O40Eyd42x55uMeDY49PW
         Q/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vThUlqBhaGIOdQUZt1ADVBkL0IsCNijoV+PH4Hb+h1Q=;
        b=knwnCTNhFdJ/C8xEmpBELJWX/rPAYiHpyfYXL3VgeVXcHwi4MZIV4KKvm7zGk2AIg1
         7LOdQHNV//kcIVwiMqC7mrC3godXDNCWhOigAe/bIW6gh54T5I9aISUEjQr96hiVV0Wt
         nAP8G+FTIIC5uDVN6DarKp9rK2MYrHEuvNbJoM4hZhRvDmJDVLSf8qBjU9+uGhVpCu1H
         nAeWrzHpMmmtxrAzjWuJOKUKNkN6RFYgm46ZZ8oDrYaQaHB9ER5CBAozTm0bNOs+OU2+
         w4U+4Hb5WKVP1G5U1gKc78Q5pfRFYSpkuAcffuhRdPQLRpmd2h8xBS0n9UmVqWnPZTJy
         jDfw==
X-Gm-Message-State: APjAAAUgaOMbdVlqIMx5Am0frFy0bpJg6XyQwRC7BxFU6AaOCpUzbb25
        42xYlyBBuBL/J735c58y9NDZg9nGenRgCBoGhcbD
X-Google-Smtp-Source: APXvYqyzBkSLtOrAZBYf9PYqPybV/Jnl4PXHqXn7IWqJZZIsD/HEWdLrFiM/lqghvyJgz5omzzS6jRhaFqYMjME6mQUH
X-Received: by 2002:a63:6787:: with SMTP id b129mr28616314pgc.103.1579029119686;
 Tue, 14 Jan 2020 11:11:59 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:11:56 -0800
In-Reply-To: <CABPp-BGy3qu_Rd4epore0wLyoh1fg0UH5EAV27shKJ=kLWX4FA@mail.gmail.com>
Message-Id: <20200114191156.122421-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BGy3qu_Rd4epore0wLyoh1fg0UH5EAV27shKJ=kLWX4FA@mail.gmail.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: Re: [RFC] Extending git-replace
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     kaushik@twitter.com, git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 2) Some folks might be okay with a clone that won't pass fsck or
> prune, at least in special circumstances.  We're actually doing that
> on purpose to deal with one of our large repositories.  We don't
> provide that to normal developers, but we do use "cheap, fake clones"
> in our CI systems.  These slim clones have 99% of all objects, but
> happen to be missing the really big ones, resulting in only needing
> 1/7 of the time to download.  (And no, don't try to point out shallow
> clones to me.  I hate those things, they're an awful hack, *and* they
> don't work for us.  It's nice getting all commit history, all trees,
> and most blobs including all for at least the last two years while
> still saving lots of space.)
> 
> [For the curious, I did make a simple script to create these "cheap,
> fake clones" for repositories of interest.  See
> https://github.com/newren/sequester-old-big-blobs.  But they are
> definitely a hack with some sharp corners, with failing fsck and
> prunes only being part of the story.]

If you want to reduce the sharpness of the corners, it might be possible
to designate the pack with missing blobs as a promisor pack (add a
.promisor file - which is just like the .keep file except
s/keep/promisor/) and a fake promisor remote. That will make fsck and
repack (GC) work.

> 3) Back to your idea...
> 
> What you're proposing actually sounds very similar to partial clones,
> whose idea is to make it okay to download a subset of history.  The
> primary problems with partial clones are (a) they are still under
> development and are just experimental, (b) they are currently
> implemented with a "promisor" mode, meaning that if a command tries to
> run over any piece of missing data then the command pauses while the
> objects are downloaded from the server.  I want an offline mode (even
> if I'm online) where only explicit downloading from the server (clone,
> fetch, etc.) occurs.

David Turner had an idea of what could be done (instead of fetching) in
such an offline mode [1], so I replied there.

[1] https://lore.kernel.org/git/d4361b6d34513a3fdefa564d10269f60d4732208.camel@novalis.org/

> Instead of inventing yet another partial-clone-like thing, it'd be
> nice if your new mechanism could just be implemented in terms of
> partial clones, extending them as you need.  I don't like the idea of
> supporting multiple competing implementations of partial clones
> withing git.git, but if it's just some extensions of the existing
> capability then it sounds great.  But you may want to talk with
> Jonathan Tan if you want to go this route (cc'd), since he's the
> partial clone expert.

Ah, thanks for your kind words.
