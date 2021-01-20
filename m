Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68300C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A2E23440
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392088AbhATTbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392646AbhATTbi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:31:38 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90107C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:30:56 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id f27so24656496qkh.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wDrBFgwvo6fgONb8T6Er4ulcrZAhtlFod7atc6mpP6g=;
        b=W+RuZ4VWmhWvSkpztORoWb5rWJ6Rfup9JcCy3MV19f0hoQhtLswpHW74ZyenbABJIZ
         3Qfj1F9KaYiacdboUA3SMFEYjFgL5ZLt0BvWjEN5b9l63VCp7WBdvL7DD7hgsqCbT50q
         xVOwhOQLZ/+0Bs/DEIWd9f5OPSJVm1Z8uNUQaeGrXvHPFSAasSfgdVtnW+xIXqX9r7Mg
         It1FclKbQvWdT9nr0PvdLoO3n5jdO7vHo/OQfR8stMBfqw+jP/QEX/In+8CJf4/xdMFq
         wv9SYWPenBsIzeU6nT1ZTASHDRU3su7cO8qI9pHC+lGBVoHhPFwCRI/CedWcsousrJZS
         LJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wDrBFgwvo6fgONb8T6Er4ulcrZAhtlFod7atc6mpP6g=;
        b=nu3Op5/52DIxq2qtqaOuI6Daz++KxNqspoTkB4ors1f6Um7PmRQVPUqhktc+cqkIPY
         +YcxARgwttMOYFoBpOkH+AK4wTfzBSCssQw/IkgKGvUwEykvk218ItlNH5Kthybc1ye/
         m2+6Dt2EKRiRY9w32B0llZ6oe6JsxJnveXywWSSUI63D6wEusLAl9b+qmmCY1NhZbzus
         iCXOsFXUeKdl58FxsVSFJyCDV/298FkY3FPY16o6yD//oPb1J0WgIjpbVYtkM8jZPuML
         1CxW9cli6HRVztiv7DIGPtBEBY+Ce+lUdpuiCA7fnqN3tAQSery/PruVc4VPlcrfKvNb
         0wIg==
X-Gm-Message-State: AOAM531xeY6HrRBTujEbh/dll38gkE+Ll0PUMHOB+8h3oxyIJPT5PM/Z
        J6gc4flVd1mOAn1xgYTnrZnWGZTvI4obewa9yKTn
X-Google-Smtp-Source: ABdhPJylW8aETvWfeqBsvyOkI+vq99r5GGYtwRlgdDSDXO5SZ23NJgYlg+m+437gT9lhqCpCXXV0wzoCWD7vtXvnF78R
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:fe91:: with SMTP id
 d17mr10905233qvs.50.1611171055679; Wed, 20 Jan 2021 11:30:55 -0800 (PST)
Date:   Wed, 20 Jan 2021 11:30:53 -0800
In-Reply-To: <87o8hk820f.fsf@evledraar.gmail.com>
Message-Id: <20210120193053.1804670-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87o8hk820f.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: Re: RFC on packfile URIs and .gitmodules check
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        stolee@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Would this still behave if the $DAYJOB's packfile-uri server support was
> behaving as documented in packfile-uri.txt, or just because it has
> outside-spec behavior?
> 
> I.e. the spec[1] says this:
> 
>     This is the implementation: a feature, marked experimental, that
>     allows the server to be configured by one or more
>     `uploadpack.blobPackfileUri=<sha1> <uri>` entries. Whenever the list
>     of objects to be sent is assembled, all such blobs are excluded,
>     replaced with URIs. The client will download those URIs, expecting
>     them to each point to packfiles containing single blobs.
> 
> Which I can't see leaving an opening for more than packfile-uri being to
> serve up packfiles which each contain a single blob.

I meant to leave an opening by referring to this just as a Minimum
Viable Product and by explaining in Future Work that the protocol allows
evolution of (among other things) which objects the server sends through
a URI without any protocol changes.

But in any case, this will also happen even if we constrain ourselves to
excluding single blobs and sending them via other packfiles instead -
see below.

> In that case it seems to me we'd be OK (but I haven't tested), because
> fsck_finish() will call read_object_file() which'll try to read that
> "blob from the object store when it encounters the ".gitmodules" tree,
> and because we'd have already downloaded the packfile with the blob
> before moving onto the main dialog.

We wouldn't be OK, actually. Suppose we have a separate packfile
containing only the ".gitmodules" blob - when we call fsck_finish(), we
would not have downloaded the other packfile yet. Git processes the
entire fetch response by piping the inline packfile (after demux) into
index-pack (which is the one that calls fsck_finish()) before it
downloads any of the other packfile(s).

> But as we discussed on-list before[2] this isn't the way packfile-uri
> actually works in the wild. It's really just sending some arbitrary data
> in a pack in that URI, with a server that knows what's in that pack and
> will send the rest in such a way that everything ends up being
> connected.
> 
> As far as I can tell the only reason this is called "packfile URI" and
> behaves this way in git.git is because of the convenience of
> intrumenting pack-objects.c with an "oidset excluded_by_config" to not
> stream those blobs in a pack, but it isn't how the only (I'm pretty
> sure) production server implementation in the wild behaves at all.

I don't know if this is the only production server implementation, but
yes, this particular one (googlesource.com) can put objects of multiple
types in the other packfile, not only a single blob. There is some JGit
code here [1] that can send a URI corresponding to a "CachedPack" (which
may contain all objects, not only blobs) if that pack is also available
through a URI.

[1] https://gerrit.googlesource.com/jgit/+/a004820858b54d18c6f72fc94dc33bce8b606d66

> So *poke* about the reply I had in [3] late last year. I think the first
> thing worth doing here is fixing the docs so they describe how this
> works. You didn't get back on that (and I also forgot about it until
> this thread), but it would be nice to know what you think about the
> suggested prose there.

Rereading that, the issue is that uploadpack.blobPackfileUri is indeed
how the current Git server handles it - it excludes a blob and sends a
URI instead. The client is not supposed to see how the server has
configured it, and should not be constrained by the fact that the server
that is being shipped with it only excludes single blobs.

> Re-reading it I'd add something like this to the spec:
> 
>  A. That the config is called "uploadpack.blobPackfileUri" in git.git
>     has nothing to do with how this is expected to behave on the
>     wire. It's just to serve the narrow support pack-objects.c has for
>     crafting such a pack.

Yes, that's true.

>  B. It's then called "packfile-uris" on the wire, nothing to do with
>     blobs. Just packs with a checksum that we'll validate. An older
>     versions of this spec said "[a] packfiles containing single blobs"
>     but it can be any combination of blob/tree/commit data.

Yes, we can delete that line.

>  C. A client is then expected to deal with any combination of data
>     ordered/sliced/split up etc. in any possible way from such a
>     combination of "packfile-uris" and PACK dialog, as long as the end
>     result is valid.
> 
> Except that the result of this discussion will perhaps be a more narrow
> definition for "C".

Yes. I think all these can be done just by changing the last sentence in
"Server design" - I'll send a patch.

> 1. https://github.com/git/git/blob/cd8402e0fd8cfc0ec9fb10e22ffb6aabd992eae1/Documentation/technical/packfile-uri.txt#L37-L41
> 2. https://lore.kernel.org/git/20201125190957.1113461-1-jonathantanmy@google.com/
> 3. https://lore.kernel.org/git/87tut5vghw.fsf@evledraar.gmail.com/
