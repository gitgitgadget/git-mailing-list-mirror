Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6869BC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 22:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F11F61B3E
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 22:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbhKQWTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 17:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbhKQWTr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 17:19:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04FCC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 14:16:47 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l22so15402789lfg.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 14:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y1lONn38ixnwRESPwke1JM/GwlI32gvuH92YHzv5RCM=;
        b=DGxYa776JVeMvWhimexPUMPmw3aucXuhnP6xSYh1HLFjTHIWNRLLUSk4jFt+9Iy76y
         LNVH68OIVpMhqNfAa/0rTLeLK1x5zw4kkVLwimwQeXvPQBWyvT35nKQ63c+YH2d+/ZtB
         QCxN73KsJxaGmFjMRNjZaWABNi45yvX/6J8pAlrfGR/a89wa5yZPXGKfFgXiVvfBvswl
         iHc+4L6gxahc+ojB4s3TatpdWpn3roI3OrNuNVTe5GUI97be46c2M5NFqVDfvzcq3FWV
         kxQKB/kplhg/Q5iYABiRvtJ3riQ2sRB4n2cEK7sjpvx8XcGSDtOcS/PvO4dpQcpdLRwz
         eVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y1lONn38ixnwRESPwke1JM/GwlI32gvuH92YHzv5RCM=;
        b=JEgUjl+lKdnqfrnGGZUwT1WdQMGpXLoh5Jsdrgfwdr9DXLib2jCAN67061bfQv3aU/
         byi8Cez+PtvUEMhHPZ26Rj12JCnF+8VWiZzVheoFIkLCge2FEKUWxG2yYuxMagDwBpk7
         eQ3CU2J4D/WpoiyL+IKV3YGOVcLZshLmqp8iFBYTZLo78/CBtbOy7lvxa4YJJiL+6iza
         QCR29UfroPP3d3zPmRYy4yNnSESyZtkb1Qvb1U3zZCJQqOKbNOijqbzfolqHq2KxzFU+
         wYChGp6Q9kp12j75sUY3PIk51w0p/6XMPddcrvHKzvXgtdLH8MlrJTnk2nx8jUmeK55C
         7Avw==
X-Gm-Message-State: AOAM530POt6Sbx7bY8tJqfLZD5ng8UFphbH5LZJPy4oyGHZ2QynqGixC
        MjnYhYK5jh4zhIsF6hff7Pu78IHLkmSS3ekUsCc=
X-Google-Smtp-Source: ABdhPJzVkz55EIzBTieUFqblrrHyELHlVJ/ASxbQlltEDuRAf1kgOgbt7MHbmo1FkUMbM2ZY17GTrB1HWYNzgV4Gq9U=
X-Received: by 2002:a05:6512:3708:: with SMTP id z8mr19155875lfr.74.1637187406177;
 Wed, 17 Nov 2021 14:16:46 -0800 (PST)
MIME-Version: 1.0
References: <211110.86r1bogg27.gmgdl@evledraar.gmail.com> <20211111004724.GA839@neerajsi-x1.localdomain>
 <211111.86pmr7pk9o.gmgdl@evledraar.gmail.com>
In-Reply-To: <211111.86pmr7pk9o.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 17 Nov 2021 14:16:35 -0800
Message-ID: <CANQDOdcdhfGtPg0PxpXQA5gQ4x9VknKDKCCi4HEB0Z1xgnjKzg@mail.gmail.com>
Subject: Re: RFC: A configuration design for future-proofing fsync() configuration
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Wong <e@80x24.org>, Christoph Hellwig <hch@lst.de>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 5:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Nov 10 2021, Neeraj Singh wrote:
>
> > On Wed, Nov 10, 2021 at 04:09:33PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> >> I think this sort of config schema would make everyone above happy
> >>
> >> It would:
> >>
> >>  A) Be easy to extend for any future fsync behavior we'd reasonably
> >>     implement
> >>
> >>  B) Not make older git versions die. It's fine if they warn(), but not=
 die.
> >>
> >>  C) Has some pretty contrived key names, but I'm trying to maintain th=
e
> >>     constraint that you can set both fsck.X=3DY and
> >>     e.g. fetch.fsck.X=3DY. I.e. we should be able to configure things
> >>     globally *and* per-command, like color.*, fsck.* etc.
> >>
> >> Proposal:
> >>
> >>   ; Turns on/off all fsync, whatever the method is. I.e. allows you to
> >>   ; never make any fsync() calls whatsoever (which we have another
> >>   ; in-flight topic for).
> >>
> >>   ; The "false" was controversial, and we could just leave it
> >>   ; unimplemented
> >>   core.fsync =3D <bool>
> >>
> >>   ; Optional, by default we'd use the most pedantic (I'd call our
> >>   ; current "loose", whether we want to forward-support it is another
> >>   ; matter.
> >>   ;
> >>   ; Whatever names we pick an option like this should ignore (or at mo=
st
> >>   ; warn about) values it doesn't know about, not hard die on it.
> >>   ;
> >>   ; Here "bach" is what Neeraj and Patrick are pursuing, a hypothetica=
l
> >>   ; POSIX would be a pedantic way of exhaustively fsyncing everything.
> >>   ;
> >>   ; We'd leave door open to e.g. setting it to "linux:ext4" or whateve=
r,
> >>   ; to do only the work needed on some specific popular FS
> >>   core.fsyncMethod =3D loose | POSIX | batch | linux:ext4 | NTFS | ...
> >>
> >>   ; Turn on or off entire categories of files we'd like to sync. This
> >>   ; way Neeraj's and Patrick's approach would be to set
> >>   ; core.fsyncMethod=3Dbatch, and then core.fsyncGroup=3Dfiles &
> >>   ; core.fsyncGroup=3Drefs.
> >>
> >>   ; If we learn about a new core.fsyncGroup =3D xyz in the future a <b=
ool>
> >>   ; in "core.fsyncGroupDefault" will prevail. I.e. if true it's
> >>   ; included, if false not.
> >>   ;
> >>   ; Whether "false" or "true" is the default depends on
> >>   ; core.fsyncMethod. For POSIX it would be true, for "loose" it's
> >>   ; false.
> >>   core.fsyncGroup =3D files
> >>   core.fsyncGroup =3D refs
> >>   core.fsyncGroup =3D objects
> >>
> >> I'm not sure I like calling it "group". Maybe "class", "category"? Doi=
ng
> >> it with this structure is extensible to the two-level keys, as noted
> >> above.
> >>
> >>   ; Our existing config knob. When "false" synonymous with:
> >>   ;
> >>   ;     core.fsync =3D true
> >>   ;     core.fsyncMethod =3D loose
> >>   ;     core.fsyncGroup =3D pack
> >>   ;
> >>   ; When "true" synonymous with the same as the above, plus:
> >>   ;     core.fsyncGroup =3D loose
> >>   ;
> >>   : Or something like that. I.e. we'll fsync *.pack, *.bitmap etc, and=
 ;
> >>   ; probably some other stuff, but not loose objects etc.
> >>   ;
> >>   ; Whatever we fsync now exactly this schema should be generic enough
> >>   ; to support it.
> >>   core.fsyncObjectFiles =3D <bool>
> >>
> >>   ; A namespace for core.fsyncMethod =3D <X>. Specific methods will
> >>   ; own this namespace and can configure whatever they want.
> >>   fsyncMethod.<x>.<a> =3D <b>
> >>
> >> E.g. we might have:
> >>
> >>   fsyncMethod.POSIX.content =3D true
> >>   fsyncMethod.POSIX.metadata =3D false
> >>
> >> If we know we'd like to (depending on other config) to fsync things
> >> exhaustively or not, but do different things depending on file content
> >> or metadata. I.e. maybe your FS's fsync() on a file fd always implies =
a
> >> sync of the metadata, and maybe not.
> >>
> >>   ; Change whatever fsync configuration you want per-command, similar =
to
> >>   ; fsck.* and fetch.fsck.*
> >>   transfer.fsyncGroup=3D*
> >>   fetch.fsyncGroup=3D*
> >>   ...
> >>
> >> 1. https://lore.kernel.org/git/211110.86v910gi9a.gmgdl@evledraar.gmail=
.com/
> >> 2. https://lore.kernel.org/git/20211028002102.19384-1-e@80x24.org/
> >> 3. https://lore.kernel.org/git/cover.1636544377.git.ps@pks.im/
> > Hi =C3=86var,
> >
> > Thanks for noticing the backwards compatibility issue with the 'batch' =
flag. I
> > agree that we need to fix that before committing my changes to master.
> >
> > I'm hoping that we can agree to a version of what you're proposing, but=
 my
> > preference would be to cut out the more granular controls. I'd prefer t=
o see
> > just:
> >       core.fsync =3D [bool]             - Turn fsyncing on or off.
> >       core.fsyncMethod =3D [string]     - Controls how it's done (with =
a non-fatal warn on unrecognized values).
> >       core.fsyncObjectFiles =3D [bool]  - Sets core.fsync if that setti=
ng doesn't already have a value. For back-compat.
>
> I'm fine with something simpler as long as we don't think we'll
> plausibly start painting ourselves into a corner.
>
> But core.fsyncObjectFiles is *not* a setting of a "core.fsync" in the
> sense that Eric suggested we have.
>
> I.e. it's effectively a sort of early and partial Linux-only version of
> what your "batch" mode is. I.e. to skip fsyncing the loose object files,
> and only fsync() the eventual refs we write.
>
> "Sort of" because we'd e.g. fsync packs unconditionally etc, but if we
> make core.fsyncObjectFiles=3Dfalse be core.fsync=3Dfalse then we can't ha=
ve
> a "real" core.fsync=3Dfalse, i.e. one that guarantees no fsync() calls at
> all.
>
> We could also simply decide that it's a bad setting and we're going to
> deprecate it, but another way is having a generic config layout that can
> express what it's doing and more.
>
> > I don't think either we or the users should have to reason about what i=
t means
> > for some parts of the repo to be fsynced and others not to be. If core.=
fsync is
> > 'false' and someone gets a weird state after a system crash, no one sho=
uld be
> > surprised.
>
> Yes. I'm fine with leaving this on the table. I should have be more
> explicit that I'm not suggesting we implement all this exhaustive config
> support, but if we imagine a sensible config schema that is extensible
> (my proposal may or may not be that) then we can implement just 1-2
> variables in it and know that we have room to grow in the future.
>
> > If core.fsync is 'true', and people are running on a reasonable
> > common filesystem, we should be trying to give decent performance and g=
ood
> > durability.
>
> Yeah, I just wonder if we can easily provide config to have people
> decide that trade-off themselves.
>
> E.g. from the performance numbers in [1] I might turn off fsyncing when
> we write anything in the working tree.
>
> We don't do that particular thing now, but if we're being pulled in one
> direction of always being fsync-safe by default...
>
> I can also see it being useful to e.g. do:
>
>     gc.fsync =3D false
>
> Or blacklist other similar batch operations, although with a global knob
> that can also rather easily be:
>
>     git -c core.fsync gc
>
> So maybe the whole "fsck" rationale doesn't apply here.
>
> > It would be nice to loop in some Linux fs developers to find out what c=
an be
> > done on current implementations to get the durability without terrible
> > performance. From reading the docs and mailing threads it looks like th=
e
> > sync_file_range + bulk fsync approach should actually work on the curre=
nt XFS
> > implementation.
>

After sleeping on it for a while, I'm willing to consolidate the
configuration along the lines that you've specified, but I'd like to
reduce the number of degrees of freedom.

My proposal in Documentation form:

core.fsync::
A comma-separated list of parts of the repository which should be hardened =
by
calling fsync when created or modified. When an aggregate option is
specified, a subcomponent can be overriden by prefixing it with a '-'. For
example, `core.fsync=3Dall,-index` means "fsync everything except the index=
".
Items which are not fsync'ed may be lost in the even of an unclean system
shutdown. This setting defaults to `objects,-loose-objects`
+
* `loose-objects` hardens objects added to the repo in loose-object form.
* `packs` hardens objects added to the repo in packfile form and the relate=
d
  bitmap and index files.
* `commit-graph` hardens the commit graph file.
* `refs` (future) hardens references when they are modified.
* `index` (future) hardens the index when it is modified.
* `objects` is an aggregate option that includes `loose-objects`, `packs`, =
and
  `commit-graph`.
* `all` is an aggregate option that syncs all individual components above.
* `none` is an aggregate option that disables fsync completely.

core.fsyncMethod::
A value indicating the strategy Git will use to harden repository data usin=
g
fsync and related primitives.
+
* 'default' uses the fsync(2) system call or platform equivalents.
* 'batch' uses APIs such as sync_file_range or equivalent to reduce the num=
ber
  of hardware FLUSH CACHE requests sent to the storage hardware.
* 'writeout-only' (future) issues requests to send the writes to the storag=
e
* hardware, but does not send any FLUSH CACHE request.
* 'syncfs' (future) uses the syncfs API, where available, to sync all of th=
e
  files on the same filesystem as the Git repo.

core.fsyncObjectFiles::
If `true`, this legacy setting is equivalent to `core.fsync=3Dobjects`. If
`core.fsync` is explicitly specified, then this setting is ignored.

Thanks,
Neeraj
