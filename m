Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D44C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 08:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjAaI3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 03:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaI3k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 03:29:40 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878F4AD26
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 00:29:38 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ud5so39359492ejc.4
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 00:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mBYmMkhqJdIXP2zmITEoDit0ip7+z7UX6T1egCtCChw=;
        b=nhvTYhb2+7S4Qh64jBxosjMz/u7jT+t/a/KUQ8ewazGrScU7IxtLNtb1hkSuPRpkln
         LwnwoBWIgqDFMx7067MsTDyYMe+slpKgBXg4jaszYwHdxRUNwI4kZsM418/ucVph1sIJ
         qq6LDx+9OnKzOsmE1BeMnKDKy2zcX+UTBynLjspQcZK5ZcpxX8lD2sTtdKEWj3oYsMQM
         xi5/yuoSLo9Uwnav55gOVkU8UzNIjOQkM78T7NJAErlFM3hWqRS2SjoeuS39vN1+heJu
         jmXgM27zoR9WahmoBaHd8jPnb9hO/ci055ZkeRApANWHam1HDl+H6qB2WCIPM0d7jlsg
         e8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBYmMkhqJdIXP2zmITEoDit0ip7+z7UX6T1egCtCChw=;
        b=rJ1yomEaaQhAYD0jII/Wtc1JM4t1M2JYZ9/4EdZJL6yrrhL4YjBij9rw8t1PkzJyMr
         VR9lRgqf5lc0HgVfFZBJXTH6FFXFc2l1pt4/DHKpdMEtEpA7aVAxRad28bgDFId9I+8c
         lRMSu52fvkPlxp7xDMkM/Os9PpH1y+f4MtSm2/3MhSOVkXzwIejbRku+3+Du+hzrw2t8
         spDo0oH09o/XzHm4FH+NKPfw+RcXADxXoVYleX4f7zDWcBLpyc9lbFVsRGCsx73ydrrR
         MXIk+cuueuKdeenC9oR0ZvpV26OWkonRT3IpzkRxBhbOsXVP/XYqnrYvuhqVnT+aOaSh
         swkQ==
X-Gm-Message-State: AO0yUKVR+yfTt+IWEGf2zXAeU7BGQWEWxqYzdCosHyCAafqfiJ4GGv6y
        RwBWcwZ7iWRy9JX6EIleHTs=
X-Google-Smtp-Source: AK7set8lRJ5WLMwtfCLLooUXfG3VtinqsyScj9G8uu05inC3O7g1HVR0v3N3FbS/2hO/nAFoBf65ww==
X-Received: by 2002:a17:906:9bd8:b0:883:ba98:204d with SMTP id de24-20020a1709069bd800b00883ba98204dmr11035447ejc.65.1675153776899;
        Tue, 31 Jan 2023 00:29:36 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id ss2-20020a170907c00200b0084d381d0528sm7975856ejc.180.2023.01.31.00.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 00:29:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pMm1H-001vSK-1y;
        Tue, 31 Jan 2023 09:29:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eli Schwartz <eschwartz93@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Jeff King" <peff@peff.net>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Date:   Tue, 31 Jan 2023 08:49:12 +0100
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
Message-ID: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 30 2023, Eli Schwartz wrote:

> For those that haven't seen, github changed its checksums for all
> "source code" artifacts attached to any git repository with tags. This
> change is now reverted due to widespread breakage -- and the lack of
> advance warning. The technical details of the change appear simple: they
> upgraded git.
>
> Probably the main discussion, complete with Github employees from this
> mailing list responding:
>
> https://github.com/bazel-contrib/SIG-rules-authors/issues/11#issuecomment=
-1409438954
>
> Consequences of that discussion, attempting to mitigate issues by
> warning people that it already happened:
>
> https://github.blog/changelog/2023-01-30-git-archive-checksums-may-change/
>
> And where I first saw it: https://github.com/mesonbuild/wrapdb/pull/884

Maybe I'm the only one that missed this on a first reading, but I
couldn't find what specific change in Git was being discussed.

But it's linked from the now-strikethrough portion of that github.blog
URL: 4f4be00d302 (archive-tar: use internal gzip by default,
2022-06-15), first released with v2.38.0.

That's the change to use gzip as a library instead of gzip(1), I've
added the author to the CC list, as well as well as others in the
initial ML dicsussion.

The ML discussion about that series starts at:
https://lore.kernel.org/git/pull.145.git.gitgitgadget@gmail.com/

For that change specifically I had this comment at the time:
https://lore.kernel.org/git/220615.86wndhwt9a.gmgdl@evledraar.gmail.com/

The response from Ren=C3=A9
(https://lore.kernel.org/git/3ed80afd-34b3-afd8-5ffb-0187a4475ee1@web.de/)
fills in the "why" missing from the commit message itself:

	"It's to avoid a run dependency [on gzip(1)] [...] and you can
	set tar.tgz.command=3D'gzip -cn' to get the old behavior.  Saving
	energy is a better default, though.

We can discuss how worthwhile that trade-off is, especially in the face
of this behavior change GitHub encounterd, but I don't think it was the
intent with this change to change the output (but maybe Ren=C3=A9 was aware
of that, but didn't note it).

Which brings me to...

> Historically speaking, git-archive has been stable minus... a bug fix or
> two in rare cases, specifically relating to an inability to transcribe
> the contents of the git repo at all, I think? And the other factor is
> the compression algorithm used, which is generally GNU gzip, and
> historically whatever the system `gzip` command is.
>
> And gzip is a stable format. It's a worn-out, battle-weary format, even
> -- it's not the best at compressing, and it's not the best at
> decompressing, and "all the cool kids" are working on cooler formats,
> such as zstd which does indeed regularly change its byte output between
> versions. But the advantage of gzip is that it's good *enough*, and it's
> probably *everywhere*, and it's *reliable*.
>
> GNU gzip is reproducible. busybox gzip was fixed to agree with GNU gzip
> (this is relevant to the handful of people running software forges on,
> say, Alpine Linux):
>
> https://reproducible-builds.org/reports/2019-08/#upstream-news
>
> ...
>
> Nevertheless, I've seen the sentiment a few times that git doesn't like
> committing to output stability of git-archive, because it isn't
> officially documented (but it's not entirely clear what the benefits of
> changing are). And yet, git endeavors to do so, in order to prevent
> unnecessary breakage of people who embody Hyrum's Law and need that
> stability.

...Yes, this has been discussed many times on-list.

My recollection of those discussions in general is that we were mostly
talking about the "tar" format itself, moreso than "gzip", although in
this case it's a change in the gzip component that changed the output.

It's not clear to me (and I'm asking instead of digging myself, as I
assume someone at GitHub has dug already) whether our change to the
"internal gzip" is necessarily going to result in a different hash, or
did we just forget to provide some option to the library to get the same
result as gzip(1).

A major thing you're eliding here is that even if "tar" or "gzip" is a
"a worn-out, battle-weary format" that does *not* translate to it being
a trivial matter to maintain byte-for-byte compatibility in the archives
(or compression stream) you produce, even though the resulting output
once un-archived or un-compressed is guaranteed to be the same.

We ship our own "tar" for the purposes of this discussion (the archive.c
code etc.), but offload the "gzip" part to either an external library
(which is new in v2.38.0, and the subject of this discussion), or to
GNU's gzip command.

I have no idea if the "gzip" part of this would be as easy as saying
"we'll default to gzip(1)", you note "GNU gzip is reproducible. busybox
gzip was fixed to agree with GNU gzip", but does the same apply to other
"gzip(1)"? I know of at least the BSD gzip.

Even then, has even GNU gzip promised that it will forever maintain
byte-for-byte compatibility in its output?

> Even with the new change to the compressor, git-archive is still
> reproducible, it's the internal gzip compressor that isn't. (This may be
> fixable, possibly by embedding an implementation from busybox or from
> GNU gzip? I'm not going to discuss that right now, though I think it's
> an interesting avenue of exploration.)

So first, aside from whatever the git project does about the default,
have you tried running the newer git version with a
tar.tgz.command=3D'gzip -cn' and seeing if it's compatible with the old
version?

It's unclear from the blog post's "we are reverting this change for now"
whether that meant a revert of the git version (probably), or a revert
back to using gzip(1).

> I've thought about this now and then over the last couple of years,
> because I think I have a reasonable compromise that might make everyone
> (or at least most people) happy, and now seems like a good idea to
> mention it.
>
> What does everyone think about offering versioned git-archive outputs?
> This could be user-selectable as an option to `git archive`, but the
> main goal would be to select a good versioned output format depending on
> what is being archived. So:
>
> - first things first, un-default the internal compressor again
> - implement a v2 archive format, where the internal compressor is the
>   default -- no other changes
> - teach git to select an archive format based on the date of the object
>   being archived
>   - when given a commit/tag ID to archive, check which support frame the
>     committer date falls inside
>   - for tree IDs, always use the latest format (it always uses the
>     current date anyway)
> - schedule a date, for the sake of argument, 6 months after the next
>   scheduled release date of git version X.Y in which this change goes
>   live; bake this into the git sources as a transition date, all commits
>   or tags generated after this date fall into the next format support
>   frame
>
> The end result is that for all historic commits or tags, `git archive`
> will always produce the same output. This can be documented in the
> git-archive manpage: "the produced archive is guaranteed to be
> reproducible, unless you override the `tar.<format>.command` or your
> system compressor is not reproducible".
>
> For *new* commits or tags, everyone gets the benefit of fascinating,
> cool new archive formats with useful improvements at the tar container
> level, which is apparently a very desirable feature. The git project no
> longer has to worry, at all, about whether users will come to complain
> about how their build pipelines suddenly fail with checksum issues. The
> git project can simply, fearlessly, go implement innovative new changes
> without giving any thought to backwards compatibility.
>
> It is, simply, that those new changes only apply to projects which are
> still under active development, and which push new commits or tag new
> releases after the transition date.
>
> Old states of existing projects (regardless of whether they are still
> actively updating) can go have their old and apparently inefficient
> archives and don't get cool new stuff. That's fine. They're also
> increasingly rarely used, because they are, after all, old -- and most
> likely only used for historic archival purposes. If the worst comes to
> worst, well, they managed to produce a somehow useful archive with an
> older version of git -- nothing will *break* if they don't get the cool
> new stuff.
>
> And for the vast majority of new downloads for new stuff, the in-process
> compressor saves one fork+exec and is a bit more efficient, I guess?
>
> A note on the transition date: I suggested 6 months after the scheduled
> release date, because this gives everyone running a software forge time
> to update git itself, and have everything ready, in time to handle the
> first wave of commits and tags that naturally occur after the transition
> date. And you don't want it to be immediate, because then people will
> take days or weeks to deploy and the most recent archives will change
>
> For the purposes of this thought experiment, we assume that people don't
> routinely set the system time to a year in the future. This will only be
> done in situations such as, say, testing a git upgrade deployment for a
> software forge.

This sounds like a workable transition plan, but it assumes that we had
a really good reason to change to the "internal gzip" by default, and
that we must move forward with that change in some way.

I don't think that's the case per the linked-to on-list discussion, the
aim was just to provide output if gzip(1) wasn't available, so all we'd
need is the pseudocode of:

	- Prepare our tar stream
        - Try to strem it to gzip(1)
        - If that fails with "command does not exist" fall back to the
          internal one (possibly with a warning about possibly-different
          output)

Then systems without a gzip(1) could produce output (which Ren=C3=A9 was
aiming for), but those with a system gzip(1) (e.g. GitHub's production
installation) could just continue to use it.

That's still a band-aid on the larger questions I raised above,
i.e. whether we'd want to forever guarantee the output of "git archive"
itself, and of the "tar.tgz.command".

My off-the-cuff response to that is that we should probably:

 - Guarantee the "git archive" output itself (without compression),
   leaving the out that it *may* change in the future with notice (or
   we'd just version it)

 - Switch back to using gzip(1) by default, whatever gzip(1) that
   happens to be.

But:

 - Promise that the total end result will be byte-for-byte the same, as
   that would imply a promise about the external gzip(1).

 - Just prominently note in our docs that if you want the
   archive->compression to be byte-for-byte with the past it's up to you
   to ensure that your compressor gives you that guarantee.
