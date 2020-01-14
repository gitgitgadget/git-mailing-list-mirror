Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84381C33CA9
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 06:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A243207E0
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 06:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpu3DKoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgANGz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 01:55:26 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39738 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgANGzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 01:55:25 -0500
Received: by mail-oi1-f196.google.com with SMTP id a67so10856090oib.6
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 22:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qo4jd4h+05kOM30/9AIaEqWdY7bOWs2J825+cHy0Hp4=;
        b=Mpu3DKoUG4cekdSMKhBkj05A9VrctKnZyeqN5dke0MHjgyO3d9dWmIkLek6wFBipLw
         L/L5kI5hGiPqQCbBHXIOcJ0ELLtGPnk1UEUZ85nlb3eNSTobaY7+U9Emm6wntssVDxPR
         8BwSSFdAB+bwPcAUGoMn/ZfzLLJp36DTXsnkrROPt7bicU21xr7gYHAhx/P8GjlbQlhx
         AaDAKaa9q9siIyhusnusU0LCLyu1Q+MdAVL7vdNArlegpAeNoq9Gr9X8MfF/Di8Iz0li
         u5ZydG0OwV1ixtrzwrvs6ER99BJa7/lCQU4sHnX8l1iHSGPJze1Y45sdF+war8sLD6Jb
         zCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qo4jd4h+05kOM30/9AIaEqWdY7bOWs2J825+cHy0Hp4=;
        b=cpXs69jFI6Wngkr1zNAXqgbE3G1hAT7SSAuURNi6tgfTxSULRV3Th1xNnd1LHl5VaB
         bFjCJGLZN3mRpoQmB6krZMFf6AN/nuCsrOrrz/hV1PbfXM5vlCozBQSkMysGA65t5IGV
         oFFxYtcIekZW0R7ysSbOluyBIc9aLHoUQ1M+6rES3nRl4z3bFk59O3BiOBnFwqTJ4eOI
         gWsDbMWDcYS/vQr+skZ3bIIbHV2irl2PxAwzol2LbE1P96fM6WobckCu/ysYAD6M4PYV
         oSVugkqce4lSIxI3vmUMeAP3ZAdsvl/1/aZ03UwWtAg+HJlJheYJ7T1EJzbx1KXOxscu
         VMIQ==
X-Gm-Message-State: APjAAAVrzX0947qgG/qmyMvyi17VY2DTCcJpSOaUYYZ1KFR3jFvK6Hkz
        D1IbVrGJ5BJ68oe6AbO+g3D8R7gFVW8rW5T8IfM=
X-Google-Smtp-Source: APXvYqwNyw/PnF4zAVHHUb231MuqIWoSspL+mrtoXvOv+LL+5pXuHv8Cg+scqi/UfPv6JQT3BQDzbDfyPYfKNOy445M=
X-Received: by 2002:aca:5588:: with SMTP id j130mr15027187oib.122.1578984924616;
 Mon, 13 Jan 2020 22:55:24 -0800 (PST)
MIME-Version: 1.0
References: <CAN_uzpK1m42J19Xi8oc3Dwmhk9qF1n4hFrBVqD+0RHZuZ_15Jw@mail.gmail.com>
In-Reply-To: <CAN_uzpK1m42J19Xi8oc3Dwmhk9qF1n4hFrBVqD+0RHZuZ_15Jw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Jan 2020 22:55:15 -0800
Message-ID: <CABPp-BGy3qu_Rd4epore0wLyoh1fg0UH5EAV27shKJ=kLWX4FA@mail.gmail.com>
Subject: Re: [RFC] Extending git-replace
To:     Kaushik Srenevasan <kaushik@twitter.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaushik,

On Mon, Jan 13, 2020 at 9:39 PM Kaushik Srenevasan <kaushik@twitter.com> wr=
ote:
>
> We=E2=80=99ve been trying to get rid of objects larger than a certain siz=
e
> from one of our repositories that contains tens of thousands of
> branches and hundreds of thousands of commits. While we=E2=80=99re able t=
o
> accomplish this using BFG[0] , it results in ~ 90% of the repository=E2=
=80=99s
> history being rewritten. This presents the following problems
> 1. There are various systems (Phabricator for one) that use the commit
> hash as a key in various databases. Rewriting history will require
> that we update all of these systems.

Not necessarily...

> 2. We=E2=80=99ll have to force everyone to reclone a copy of this reposit=
ory.

True.

> I was looking through the git code base to see if there is a way
> around it when I chanced upon `git-replace`. While the basic idea of
> `git-replace` is what I am looking for, it doesn=E2=80=99t quite fit the =
bill
> due to the `--no-replace-objects` switch, the `GIT_NO_REPLACE_OBJECTS`
> environment variable, and `--no-replace-objects` being the default for
> certain git commands. Namely fsck, upload-pack, pack/unpack-objects,
> prune and index-pack. That Git may still try to load a replaced object
> when a git command is run with the `--no-replace-objects` option
> prevents me from removing it from the ODB permanently. Not being able
> to run prune and fsck on a repository where we=E2=80=99ve deleted the obj=
ect
> that=E2=80=99s been replaced with git-replace effectively rules this opti=
on
> out for us.
>
> A feature that allowed such permanent replacement (say a
> `git-blacklist` or a `git-replace --blacklist`) might work as follows:
> 1. Blacklisted objects are stored as references under a new namespace
> -- `refs/blacklist`.
> 2. The object loader unconditionally translates a blacklisted OID into
> the OID it=E2=80=99s been replaced with.
> 3. The `+refs/blacklist/*:refs/blacklist/*` refspec is implicitly
> always a part of fetch and push transactions.
>
> This essentially turns the blacklist references namespace into an
> additional piece of metadata that gets transmitted to a client when a
> repository is cloned and is kept updated automatically.
>
> I=E2=80=99ve been playing around with a prototype I wrote and haven=E2=80=
=99t observed
> any breakage yet. I=E2=80=99m writing to seek advice on this approach and=
 to
> understand if this is something (if not in its current form, some
> version of it) that has a chance of making it into the product if we
> were to implement it. Happy to write up a more detailed design and
> share my prototype as a starting point for discussion.

I'll get back to this in a minute, but wanted to point out a couple
other ideas for consideration:

1) You can rewrite history, and then use replace references to map old
commit IDs to new commit IDs.  This allows anyone to continue using
old commit IDs (which aren't even part of the new repository anymore)
in git commands and git automatically uses and shows the new commit
IDs.  No problems with fsck or prune or fetch either.  Creating these
replace refs is fairly simple if your repository rewriting program
(e.g. git-filter-repo or BFG Repo Cleaner) provides a mapping of old
IDs to new IDs, and if you are using git-filter-repo it even creates
the replace refs for you.  (The one downside is that you can't use
abbreviated refs to refer to replace refs, thus you can't use
abbreviated old commit IDs in this scheme.)

The downside is that various repository hosting tools ignore replace
refs.  Thus if you try to browse to a commit in the web UI of Gerrit
or GitHub using the old commit IDs, it'll just show you a commit not
found page.  Phabricator and GitLab may well be the same (haven't
tried yet).  However, teaching these tools to pay attention to replace
refs would make this simple mechanism for rewriting feel close to
seamless other than asking people to reclone.  It's possible that
teaching the Webby tools to pay attention to replace refs might not be
too difficult, at least for the open source systems, though I admit I
haven't dug into it myself.

2) Some folks might be okay with a clone that won't pass fsck or
prune, at least in special circumstances.  We're actually doing that
on purpose to deal with one of our large repositories.  We don't
provide that to normal developers, but we do use "cheap, fake clones"
in our CI systems.  These slim clones have 99% of all objects, but
happen to be missing the really big ones, resulting in only needing
1/7 of the time to download.  (And no, don't try to point out shallow
clones to me.  I hate those things, they're an awful hack, *and* they
don't work for us.  It's nice getting all commit history, all trees,
and most blobs including all for at least the last two years while
still saving lots of space.)

[For the curious, I did make a simple script to create these "cheap,
fake clones" for repositories of interest.  See
https://github.com/newren/sequester-old-big-blobs.  But they are
definitely a hack with some sharp corners, with failing fsck and
prunes only being part of the story.]


3) Back to your idea...

What you're proposing actually sounds very similar to partial clones,
whose idea is to make it okay to download a subset of history.  The
primary problems with partial clones are (a) they are still under
development and are just experimental, (b) they are currently
implemented with a "promisor" mode, meaning that if a command tries to
run over any piece of missing data then the command pauses while the
objects are downloaded from the server.  I want an offline mode (even
if I'm online) where only explicit downloading from the server (clone,
fetch, etc.) occurs.

Instead of inventing yet another partial-clone-like thing, it'd be
nice if your new mechanism could just be implemented in terms of
partial clones, extending them as you need.  I don't like the idea of
supporting multiple competing implementations of partial clones
withing git.git, but if it's just some extensions of the existing
capability then it sounds great.  But you may want to talk with
Jonathan Tan if you want to go this route (cc'd), since he's the
partial clone expert.
