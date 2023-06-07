Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F8C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 22:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjFGW5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 18:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjFGW4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 18:56:40 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8039A26AF
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 15:56:37 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565de553de1so924737b3.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 15:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686178596; x=1688770596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfWWnB5iPu+frlarXs00f0lEZpWWRJqDsQCazL4bSqA=;
        b=xsQmB34v0/5vCRWOtthoPkOnTY1t6phAIXtuF31SksLIFJxQAxD55SyUvISaZB5Mse
         L0RDPbw1t+QvXBWNIECI5pbDpLOOlFpRtB2+rLtByC5BWW8TAnpLD8GjsFZL4NejHCby
         tUTWLYvKoMiyifct6+726EMUH8UsulYqJzu2pMLObwFoc/IY+1k3CjQTMukoj0T6zfE5
         2uCd07hXwKJsNzWFdqQEb4RIBpc/ENLxM/xkyIXF9BSi63SsFy/dWLr32Y8JlhGrtV/K
         LZp7iw1EAX33WiUUcJxVeYhEn2Qc53fbrr1gAGNp2MxELiydX7cNBZSGS96xoI2RAkIW
         Z4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178596; x=1688770596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfWWnB5iPu+frlarXs00f0lEZpWWRJqDsQCazL4bSqA=;
        b=kny3IqsHbFMprJXCuhuNkV5sPLBL5AHuzC5fqhCNWLYx3I0tBr3ALt5AqqSxFaTEbR
         XzSP/fnnHeHKWrgeGT0BKIUV5kISqK5KxKVmJSaXeWVcX0pgOeXpVOO4hRP071ZJkYzh
         LyCV+m2KNRROfUZvuhFrL2Sx5ItxiGccE6In2oJW6UpEAnQ5HPwVP0Jo+LGaNwrSLAIn
         xMnCTCJ12+5tz8uVfJctc8wx8og1MmlQtOa9XGJkbGRv2zLH7+1NZiFvZVTIgTp1V7x6
         R8ROCh0yAIqGzXh742kukwDn0n7x0NI9KBE7vO34pw8NhP1FFjvNoGwZ/PvWCb7nLDsq
         NF+Q==
X-Gm-Message-State: AC+VfDwwB2V+XHRnDktxw7eseOpFaBg0AnL2VGUxEs5XUK4UPWjn59nh
        OgGrJCjVFuies+Q8pk+sTBR/rky/EXjre+u4124bSZIl
X-Google-Smtp-Source: ACHHUZ71pw6TaQq+DWm07FC/Z95K7jN1N/Lqp4J/4aZVppkbaHBZKpxnP0c9vpX+1A8cuaYvUu+Qdw==
X-Received: by 2002:a81:5e46:0:b0:552:ae41:50a2 with SMTP id s67-20020a815e46000000b00552ae4150a2mr542526ywb.21.1686178596478;
        Wed, 07 Jun 2023 15:56:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y188-20020a0dd6c5000000b005619cfb1b88sm1154ywd.52.2023.06.07.15.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:56:35 -0700 (PDT)
Date:   Wed, 7 Jun 2023 18:56:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>, me@waleedkhan.name,
        martinvonz@google.com
Subject: Re: [PATCH v4 2/2] gc: introduce `gc.recentObjectsHook`
Message-ID: <ZIELIAQmW9qWyUdM@nand.local>
References: <cover.1683847221.git.me@ttaylorr.com>
 <cover.1684196634.git.me@ttaylorr.com>
 <18e50d2517ba4cc81d4bafb0b029ca7a770f23a7.1684196634.git.me@ttaylorr.com>
 <kl6l1qj5z56p.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6l1qj5z56p.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Apologies for my delayed response. Now that we are on the other side of
2.41 I think that it's the right time to pick this back up again.

On Wed, May 24, 2023 at 04:21:34PM -0700, Glen Choo wrote:
> Hi Taylor! It was great seeing you at Review Club today :)

It was fun :-).

> It would be useful to flesh out why keeping these extra refs are
> either "undesirable" or "infeasible". Presumably, you already have
> some idea of why this is the case for the GitHub 'audit log'.

Yes, thanks for suggesting it. I think the gap in my explanation is
"[...] if there are many such objects". Hopefully that clarifies it.

> Another potential use case I can think of is client-side third party Git
> tools that implement custom workflows on top of a Git repo, e.g.
> git-branchless (https://github.com/arxanas/git-branchless) and jj
> (https://github.com/martinvonz/jj/, btw I contribute a little to jj
> too).

I thought that this was an interesting part of the discussion. I hadn't
thought of it when writing up these patches, but I think that it could
be potentially useful for those tools if they want to keep around some
precious set of metadata objects without having to point refs at them.

It also introduces a little bit of a higher barrier between the tool and
user to destroy those objects. Without pinning them with this hook, all
a user has to do to remove them is drop the reference(s) which points at
them, and then GC. Now they'd have to modify the hook, etc.

> > +gc.recentObjectsHook::
>
> I have a small preference to use "command" instead of "hook" to avoid
> confusion with Git hooks (I've already observed some of this confusion
> in off-list conversations). There's some precedent for "hook" in
> `uploadpack.packObjectsHook`, but that's a one-off (and it used to
> confuse me a lot too :P).

Unless you feel strongly, let's leave it as-is. "gc.recentObjectsHook"
is the third iteration of this name, and I'd like to avoid spending much
more time on naming if we can help it.

> > +	When considering the recency of an object (e.g., when generating
> > +	a cruft pack or storing unreachable objects as loose), use the
> > +	shell to execute the specified command(s). Interpret their
> > +	output as object IDs which Git will consider as "recent",
> > +	regardless of their age.
>
> >From a potential user's POV, two things seem unclear:
>
> - What does "recenct" mean in this context? Does it just mean
>   "precious"?
> - What objects do I need to list? Is it every object I want to keep or
>   just the reachable tips?

To answer your questions: recency is referring to the "mtime" of an
object [^1], not whether or not it is precious. I clarified this by
removing the term "recent" from this sentence altogether, to instead
read:

    "When considering whether or not to remove an object [...]"

You only need to list the tips, since Git will treat the output of the
hook as input to a traversal which allows for missing objects. Any
object visited along that traversal will be kept in the repository and
rescued from deletion. I tried to clarify this by adding a final
sentence (emphasis mine):

    "By treating their mtimes as "now", any objects **(and their
    descendants)** mentioned in the output will be kept regardless of
    their true age."

> In the code changes, I noticed a few out-of-date references to "cruft
> tips", but everything else looked reasonable to me.

Thanks, I'll clean those up and resubmit it with the above fixes
squashed in.

Thanks,
Taylor

[^1]: an object's mtime is the most recent of (1) the st_mtime of a its
  loose object file, if it exists, (2) the st_mtime of any non-cruft
  pack(s) that contain that object, or (3) the value listed in the .mtimes
  file of the cruft pack corresponding to that object's entry.
