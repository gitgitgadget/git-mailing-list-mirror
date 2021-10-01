Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098F1C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 07:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD7161216
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 07:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352626AbhJAHnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 03:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352521AbhJAHnM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 03:43:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318A1C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 00:41:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g7so30773041edv.1
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 00:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xfhDQclQpPVzu9fzM5udNqInzGUoxmKnQ7x2qYmETyw=;
        b=qb5uf1RZUrHG/VZ8HRSAd04ZlHBApVnk4EmJzBm1vUyexf9Hq/vTzC54c/S2fWbKkr
         Bk2m2yYSRFdnXXoZ96bEkOExHaXELPPUyN9+3G8W/cWyTf6QLpef4UmlZVmJZZYbQdhm
         tGdlE61MActuSEzIzElD+4yyFfKNYIOXaIO+IBsivC5egu/OtksxpAIWhYbNRTbOw/+i
         iCrg1HvhKoPadPKiR8LsxRQZoZYl0L27FRZ4Ker77CTczWep+iILxTw6tQgN4YZRQ1t0
         NjDsj82rAhWsQ1oUJruffeSS7mhss8uLY2J3pQILfyAEYKvAUzSPmY+VlnYOyTNS8+GI
         mAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xfhDQclQpPVzu9fzM5udNqInzGUoxmKnQ7x2qYmETyw=;
        b=l6+rlkrKiSl9h2LFgsTReNABzSIAE5ME4e+cQiQ/LRsfSHv0MWqDUpDHll/vRsBTuY
         HRo7TQhU9PlDqj7m/EFqKhaj3gGuQugNWarcuOIcKvTpFhAXlNIJ+SoM1yJsHzlUxo8c
         OSU1y81Ffe63pu4kPtR0KObU2/sh5OKfHHCC8b4ErBFgPFL5yVXtmFVa0uUzt4JbcPRV
         7FQXtID8zAyYOVipgM6xSiLWi9R7G1lXODoYp8SsytpUv1ngsgbfUa8PZT0VmcjAm2rD
         dd5CyDQXvZHsXazofE3UDX5ih194HFlzyw45ptrlrt9huaxNXpfzmDjBpNDDi4S51+AV
         buYw==
X-Gm-Message-State: AOAM533Q7vg4myagklvAZ6+VD2dULiR6DIV62qfuAnYo7JvOxVjaz8he
        EZ+bFqxkYc5Luy2zUBWcoYE=
X-Google-Smtp-Source: ABdhPJzGCYUeeg/Qf50zFOoBxno0nRsP7mNtZz5rQ/6E3ZAMzUPKOp6NWyw6jOhbEIZkT10QVKGFJw==
X-Received: by 2002:a17:906:d54f:: with SMTP id cr15mr4550600ejc.300.1633074086333;
        Fri, 01 Oct 2021 00:41:26 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c38sm2074760edf.22.2021.10.01.00.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 00:41:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Date:   Fri, 01 Oct 2021 09:30:05 +0200
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net> <xmqqsfxof2hr.fsf@gitster.g>
 <YVVoXJo3DlPQd1A3@coredump.intra.peff.net>
 <87tui2tckn.fsf@evledraar.gmail.com>
 <CABPp-BGsjq3ts4A6wKLYcopD9rknM+LXXi8qR_SLEpmU+x7KNQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BGsjq3ts4A6wKLYcopD9rknM+LXXi8qR_SLEpmU+x7KNQ@mail.gmail.com>
Message-ID: <87wnmxry3e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Elijah Newren wrote:

> On Thu, Sep 30, 2021 at 6:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Thu, Sep 30 2021, Jeff King wrote:
>>
>> > On Tue, Sep 28, 2021 at 09:08:00PM -0700, Junio C Hamano wrote:
>> >
>> >> Jeff King <peff@peff.net> writes:
>> >>
>> >> >   Side note: The pretend_object_file() approach is actually even be=
tter,
>> >> >   because we know the object is fake. So it does not confuse
>> >> >   write_object_file()'s "do we already have this object" freshening
>> >> >   check.
>> >> >
>> >> >   I suspect it could even be made faster than the tmp_objdir approa=
ch.
>> >> >   From our perspective, these objects really are tempfiles. So we c=
ould
>> >> >   write them as such, not worrying about things like fsyncing them,
>> >> >   naming them into place, etc. We could just write them out, then m=
map
>> >> >   the results, and put the pointers into cached_objects (currently =
it
>> >> >   insists on malloc-ing a copy of the input buffer, but that seems =
like
>> >> >   an easy extension to add).
>> >> >
>> >> >   In fact, I think you could get away with just _one_ tempfile per
>> >> >   merge. Open up one tempfile. Write out all of the objects you wan=
t to
>> >> >   "store" into it in sequence, and record the lseek() offsets befor=
e and
>> >> >   after for each object. Then mmap the whole result, and stuff the
>> >> >   appropriate pointers (based on arithmetic with the offsets) into =
the
>> >> >   cached_objects list.
>> >>
>> >> Cute.  The remerge diff code path creates a full tree that records
>> >> the mechanical merge result.  By hooking into the lowest layer of
>> >> write_object() interface, we'd serialize all objects in such a tree
>> >> in the order they are computed (bottom up from the leaf level, I'd
>> >> presume) into a single flat file ;-)
>> >
>> > I do still like this approach, but just two possible gotchas I was
>> > thinking of:
>> >
>> >  - This side-steps all of our usual code for getting object data into
>> >    memory. In general, I'd expect this content to not be too enormous,
>> >    but it _could_ be if there are many / large blobs in the result. So
>> >    we may end up with large maps. Probably not a big deal on modern
>> >    64-bit systems. Maybe an issue on 32-bit systems, just because of
>> >    virtual address space.
>> >
>> >    Likewise, we do support systems with NO_MMAP. They'd work here, but
>> >    it would probably mean putting all that object data into the heap. I
>> >    could live with that, given how rare such systems are these days, a=
nd
>> >    that it only matters if you're using --remerge-diff with big blobs.
>> >
>> >  - I wonder to what degree --remerge-diff benefits from omitting writes
>> >    for objects we already have. I.e., if you are writing out a whole
>> >    tree representing the conflicted state, then you don't want to write
>> >    all of the trees that aren't interesting. Hopefully the code is
>> >    already figuring out which paths the merge even touched, and ignori=
ng
>> >    the rest. It probably benefits performance-wise from
>> >    write_object_file() deciding to skip some object writes, as well
>> >    (e.g., for resolutions which the final tree already took, as they'd
>> >    be in the merge commit). The whole pretend-we-have-this-object thing
>> >    may want to likewise make sure we don't write out objects that we
>> >    already have in the real odb.
>>
>> I haven't benchmarked since my core.checkCollisions RFC patch[1]
>> resulted in the somewhat related loose object cache patch from you, and
>> not with something like the midx, but just a note that on some setups
>> just writing things out is faster than exhaustively checking if we
>> absolutely need to write things out.
>>
>> I also wonder how much if anything writing out the one file v.s. lots of
>> loose objects is worthwhile on systems where we could write out those
>> loose objects on a ramdisk, which is commonly available on e.g. Linux
>> distros these days out of the box. If you care about performance but not
>> about your transitory data using a ramdisk is generally much better than
>> any other potential I/O optimization.
>>
>> Finally, and I don't mean to throw a monkey wrench into this whole
>> discussion, so take this as a random musing: I wonder how much faster
>> this thing could be on its second run if instead of avoiding writing to
>> the store & cleaning up, it just wrote to the store, and then wrote
>
> It'd be _much_ slower.  My first implementation in fact did that; it
> just wrote objects to the store, left them there, and didn't bother to
> do any auto-gcs.  It slowed down quite a bit as it ran.  Adding
> auto-gc's during the run were really slow too. But stepping back,
> gc'ing objects that I already knew were garbage seemed like a waste;
> why not just prune them pre-emptively?  To do so, though, I'd have to
> track all the individual objects I added to make sure I didn't prune
> something else.  Following that idea and a few different attempts
> eventually led me to the discovery of tmp_objdir.
>
> In case it's not clear to you why just writing all the objects to the
> normal store and leaving them there slows things down so much...
>
> Let's say 1 in 10 merges had originally needed some kind of conflict
> resolution (either in the outer merge or in the inner merge for the
> virtual merge bases), meaning that 9 out of 10 merges traversed by
> --remerge-diff don't write any objects.  Now for each merge for which
> --remerge-diff does need to create conflicted blobs and new trees,
> let's say it writes on average 3 blobs and 7 trees.  (I don't know the
> real average numbers, it could well be ~5 total, but ~10 seems a
> realistic first order approximation and it makes the math easy.)
> Then, if we keep all objects we write, then `git log --remerge-diff`
> on a history with 100,000 merge commits, will have added 100,000 loose
> objects by the time it finishes.  That means that all diff and merge
> operations slow down considerably as it runs due to all the extra
> loose objects.

...

>> another object keyed on the git version and any revision paramaters
>> etc., and then pretty much just had to do a "git cat-file -p <that-obj>"
>> to present the result to the user :)
>
> So caching the full `git log ...` output, based on a hash of the
> command line flags, and then merely re-showing it later?  And having
> that output be invalidated as soon as any head advances?  Or are you
> thinking of caching the output per-commit based on a hash of the other
> command line flags...potentially slowing non-log operations down with
> the huge number of loose objects?

Yeah I meant caching the full 'git log' output. Anyway, I think what you
said above about number of loose objects clearly makes that a stupid
suggestion on my part.

FWIW I meant that more as a "maybe in the future we can ..." musing than
anything for this series. I.e. in general I've often wanted say the
second run of a 'git log -G<rx>"' to be faster than it is, which could
use such on-the-fly caching.

But if we had such caching then something like --remerge-diff would need
to (from my understanding of what you're saying) need both this
temporary staging area for objects and perhaps to cache the output in
the main (or some cache) store. I.e. they're orthagonal.

>> I suppose that would be throwing a lot more work at an eventual "git gc"
>> than we ever do now, so maybe it's a bit crazy, but I think it might be
>> an interesting direction in general to (ab)use either the primary or
>> some secondary store in the .git dir as a semi-permanent cache of
>> resolved queries from the likes of "git log".
>
> If you do per-commit caching, and the user scrolls through enough
> output (not hard to do, just searching the output for some string
> often is enough), that "eventual" git-gc will be the very next git
> operation.  If you cache the entire output, it'll be invalidated
> pretty quickly.  So I don't see how this works.  Or am I
> misunderstanding something you're suggesting here?

With the caveat above that I think this is all a pretty stupid
suggestion on my part:

Just on the narrow aspect of how "git gc" behaves in that scenario: We'd
keep those objects around for 2 weeks by default, or whatever you have
gc.pruneExpire set to.

So such a setup would certainly cause lots of pathological issues (see
my [1] for one), but I don't think over-eager expiry of loose objects
would be one.

I'm not sure but are you referring to "invalidated pretty quickly"
because it would go over the gc.auto limit? If so that's now how it
works in this scenario, see [2]. I.e. it's moderated by the
gc.pruneExpire setting.

1. https://lore.kernel.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87inc89j38.fsf@evledraar.gmail.com/
