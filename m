Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBABC433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E86961528
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349240AbhI3NdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhI3Nc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:32:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC41AC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:31:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v10so22416005edj.10
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=R+Eze6SkgqIMPiLX44tkrTbfKWPF6vd54LvoiyJcntc=;
        b=bjl0cgUbddT3U51fmsC8dAAa9veD12kBGFNqxsJAGIBARG/SUneONBNMPXssvL2fo2
         2zdMv1JA8aU7EA/dyaW5O7UaphjC/OwjfqwQvvxxHnLjsNP1+qSLiogWnH/KgSL7ZGCr
         5jcgZXintsrQ43TX+JJHzjqPN9aY4cY15a//ySUSWjxYRU+24XIbcQfNDwng4gbE258R
         os6WrNoY9RJh7YzDuLdp5ucLMoGLNNe6afmOawMgchOGp67ThmmxlpAPkh8AOmkb/4na
         k6ZMAx7w/7YtOIVkKxpvo2mg2KOQ+TgW0219dP3LSotgxRczBwXXy/BbJqYEkOqJX4jW
         YkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=R+Eze6SkgqIMPiLX44tkrTbfKWPF6vd54LvoiyJcntc=;
        b=OkxF0N6o5y0rmqDIX7E+u/HGH8UukqqM0sNOg751+SgYdpDPvRBVUrSfjPsnvSjdwp
         KwHDAJjgbeaRqR27nrS73NmpHoKXe8GTjvqgVTKezOVTZIEYKH23tNESM1FTwgxSzlWY
         0smcMLMmkHKLH/ljSgaiDDtoV2o8c/X4x477T+EyTzpP1UyShuqd8vXW+OZS2I6Xf50Y
         l1YkwzY4v6Z+jz7TKTMCso+S8ZoS24BgbrnPvSbBJMzSaca5CwLoPghE7//tprSBlLGM
         qmARsYxRxnpdyH0c3VbIBYheICvic/S3EcYeqKizVZPyGQ+0EpNU5qzC3vqKB1gDiFuX
         S4Uw==
X-Gm-Message-State: AOAM530RwQTl1dKueRQY3TolL+DdTv4uIvqGUx/pe+b6ftDF0y6s5VYV
        hcAGW1BpC1pM6q7Ccjl7s6A=
X-Google-Smtp-Source: ABdhPJzLnhWWVct2vBKC08wFwOI0GGhB7iq7DJVKEQ0uYN3F0bSawcuK7hTLYSDnbmDM+80wVhITwA==
X-Received: by 2002:a05:6402:1011:: with SMTP id c17mr7384974edu.144.1633008665572;
        Thu, 30 Sep 2021 06:31:05 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cw4sm1426027ejb.116.2021.09.30.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:31:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Date:   Thu, 30 Sep 2021 15:16:19 +0200
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net> <xmqqsfxof2hr.fsf@gitster.g>
 <YVVoXJo3DlPQd1A3@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVVoXJo3DlPQd1A3@coredump.intra.peff.net>
Message-ID: <87tui2tckn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Jeff King wrote:

> On Tue, Sep 28, 2021 at 09:08:00PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >   Side note: The pretend_object_file() approach is actually even better,
>> >   because we know the object is fake. So it does not confuse
>> >   write_object_file()'s "do we already have this object" freshening
>> >   check.
>> >
>> >   I suspect it could even be made faster than the tmp_objdir approach.
>> >   From our perspective, these objects really are tempfiles. So we could
>> >   write them as such, not worrying about things like fsyncing them,
>> >   naming them into place, etc. We could just write them out, then mmap
>> >   the results, and put the pointers into cached_objects (currently it
>> >   insists on malloc-ing a copy of the input buffer, but that seems like
>> >   an easy extension to add).
>> >
>> >   In fact, I think you could get away with just _one_ tempfile per
>> >   merge. Open up one tempfile. Write out all of the objects you want to
>> >   "store" into it in sequence, and record the lseek() offsets before and
>> >   after for each object. Then mmap the whole result, and stuff the
>> >   appropriate pointers (based on arithmetic with the offsets) into the
>> >   cached_objects list.
>> 
>> Cute.  The remerge diff code path creates a full tree that records
>> the mechanical merge result.  By hooking into the lowest layer of
>> write_object() interface, we'd serialize all objects in such a tree
>> in the order they are computed (bottom up from the leaf level, I'd
>> presume) into a single flat file ;-)
>
> I do still like this approach, but just two possible gotchas I was
> thinking of:
>
>  - This side-steps all of our usual code for getting object data into
>    memory. In general, I'd expect this content to not be too enormous,
>    but it _could_ be if there are many / large blobs in the result. So
>    we may end up with large maps. Probably not a big deal on modern
>    64-bit systems. Maybe an issue on 32-bit systems, just because of
>    virtual address space.
>
>    Likewise, we do support systems with NO_MMAP. They'd work here, but
>    it would probably mean putting all that object data into the heap. I
>    could live with that, given how rare such systems are these days, and
>    that it only matters if you're using --remerge-diff with big blobs.
>
>  - I wonder to what degree --remerge-diff benefits from omitting writes
>    for objects we already have. I.e., if you are writing out a whole
>    tree representing the conflicted state, then you don't want to write
>    all of the trees that aren't interesting. Hopefully the code is
>    already figuring out which paths the merge even touched, and ignoring
>    the rest. It probably benefits performance-wise from
>    write_object_file() deciding to skip some object writes, as well
>    (e.g., for resolutions which the final tree already took, as they'd
>    be in the merge commit). The whole pretend-we-have-this-object thing
>    may want to likewise make sure we don't write out objects that we
>    already have in the real odb.

I haven't benchmarked since my core.checkCollisions RFC patch[1]
resulted in the somewhat related loose object cache patch from you, and
not with something like the midx, but just a note that on some setups
just writing things out is faster than exhaustively checking if we
absolutely need to write things out.

I also wonder how much if anything writing out the one file v.s. lots of
loose objects is worthwhile on systems where we could write out those
loose objects on a ramdisk, which is commonly available on e.g. Linux
distros these days out of the box. If you care about performance but not
about your transitory data using a ramdisk is generally much better than
any other potential I/O optimization.

Finally, and I don't mean to throw a monkey wrench into this whole
discussion, so take this as a random musing: I wonder how much faster
this thing could be on its second run if instead of avoiding writing to
the store & cleaning up, it just wrote to the store, and then wrote
another object keyed on the git version and any revision paramaters
etc., and then pretty much just had to do a "git cat-file -p <that-obj>"
to present the result to the user :)

I suppose that would be throwing a lot more work at an eventual "git gc"
than we ever do now, so maybe it's a bit crazy, but I think it might be
an interesting direction in general to (ab)use either the primary or
some secondary store in the .git dir as a semi-permanent cache of
resolved queries from the likes of "git log".

1. https://lore.kernel.org/git/20181028225023.26427-5-avarab@gmail.com/
