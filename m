Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32B4C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 21:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhLGVrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhLGVrz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:47:55 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5887BC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 13:44:24 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id i63so654275lji.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 13:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Ls7HkKs6+JqxDFTXkXzG54MxYkTorf5C1m+fa1Byr0=;
        b=LRyZUVKjq48nzo7U3kVnZVFKjyvMIoL3HuAr6mSFRMTh5Y0hIJSkn0Jr9U2qCovAGx
         1WQO1NimIVX/euR8H7L+CM5NRkEQK8sHWjlZfsfF8hmm8QS/xNBZrH/QutYLuK9p06mr
         TyOLtlZOZB9GawA9Hi/FMIdzNATDRgDe+GNCMZO+eUtp8YpDAAjVIBk80PTMpfIDs6AP
         zUo20MdCqa0PN9oPUHdhEc4cmpBIJ6btVYBt8Heiw4sOdvVpHw0Gjx52DE6r0lm7q1Wx
         IMYvT3oHlV9y8Zw7VoZ6oPam/aSqUgBWMlJGTLZ+XmtoM2Gwkf3kierR1NBquwbinajK
         zv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Ls7HkKs6+JqxDFTXkXzG54MxYkTorf5C1m+fa1Byr0=;
        b=c60vSRS5ffKbEgCIJb9olK4w78mncIh4edMrWQctoT+UUmclZRsS+RDkm9B9Dp9FED
         oCmimi5IwoiHZ99wwaW0PdmG5OHTwqIULFQTpnrlN+FGPgcLP21qJSrmZJ1XECH7iHux
         HYVSKX4KRcWpaoz8AUZbp877fpnbKYdZK91VLvUMdl7OpSuOULc/CyBvuImXntnwRZM/
         F1XBzbmyx/m3TG6Z+ykp3e1nzUufukvMygBzLaDtGLuIz/iyjX8ZxPdOvUP0SCOvtF6c
         rWMq5CBazaApw9C9xWksv8Tpzt7oAMsmIXl0rk4t7L3N8nVREaL69jQmVKPwFz5Sebh7
         4Cqg==
X-Gm-Message-State: AOAM5325P2MHGLqctg0FPEOMvuUfmoTALBvT+qADLOdiPABc6UE/polZ
        8XkG/ZLzMUETn6ckGishG3W/zDgLvnk4wXkgZB4=
X-Google-Smtp-Source: ABdhPJyPSMRpYNplg89VgXSL91EqJ3XfhKpBpXGMLSAWApGSXlBCcUZw/GIasJRif1A0tcTmI2U+acTE5ct/4Bd8bD8=
X-Received: by 2002:a05:651c:17a6:: with SMTP id bn38mr45589110ljb.413.1638913462372;
 Tue, 07 Dec 2021 13:44:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com> <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
 <211207.86wnkgo9fv.gmgdl@evledraar.gmail.com>
In-Reply-To: <211207.86wnkgo9fv.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 7 Dec 2021 13:44:11 -0800
Message-ID: <CANQDOdfX2KaosPwLM4hS4rp+FH9V7VUxUh_md43FfZ9NG4iroQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] core.fsync: introduce granular fsync control
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 5:01 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Tue, Dec 07 2021, Neeraj Singh via GitGitGadget wrote:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > This commit introduces the `core.fsync` configuration
> > knob which can be used to control how components of the
> > repository are made durable on disk.
> >
> > This setting allows future extensibility of the list of
> > syncable components:
> > * We issue a warning rather than an error for unrecognized
> >   components, so new configs can be used with old Git versions.
>
> Looks good!
>
> > * We support negation, so users can choose one of the default
> >   aggregate options and then remove components that they don't
> >   want. The user would then harden any new components added in
> >   a Git version update.
>
> I think this config schema makes sense, but just a (I think important)
> comment on the "how" not "what" of it. It's really much better to define
> config as:
>
>     [some]
>     key =3D value
>     key =3D value2
>
> Than:
>
>     [some]
>     key =3D value,value2
>
> The reason is that "git config" has good support for working with
> multi-valued stuff, so you can do e.g.:
>
>     git config --get-all -z some.key
>
> And you can easily (re)set such config e.g. with --replace-all etc., but
> for comma-delimited you (and users) need to do all that work themselves.
>
> Similarly instead of:
>
>     some.key =3D want-this
>     some.key =3D -not-this
>     some.key =3D but-want-this
>
> I think it's better to just have two lists, one inclusive another
> exclusive. E.g. see "log.decorate" and "log.excludeDecoration",
> "transfer.hideRefs"
>
> Which would mean:
>
>     core.fsync =3D want-this
>     core.fsyncExcludes =3D -not-this
>
> For some value of "fsyncExcludes", maybe "noFsync"? Anyway, just a
> suggestion on making this easier for users & the implementation.
>

Maybe there's some way to handle this I'm unaware of, but a
disadvantage of your multi-valued config proposal is that it's harder,
for example, for a per-repo config store to reasonably override a
per-user config store.  With the configuration scheme as-is, I can
have a per-user setting like `core.fsync=3Dall` which covers my typical
repos, but then have a maintainer repo with a private setting of
`core.fsync=3Dnone` to speed up cases where I'm mostly working with
other people's changes that are backed up in email or server-side
repos.  The latter setting conveniently overrides the former setting
in all aspects.

Also, with the core.fsync and core.fsyncExcludes, how would you spell
"don't sync anything"? Would you still have the aggregate options.?

> > This also supports the common request of doing absolutely no
> > fysncing with the `core.fsync=3Dnone` value, which is expected
> > to make the test suite faster.
>
> Let's just use the git_parse_maybe_bool() or git_parse_maybe_bool_text()
> so we'll accept "false", "off", "no" like most other such config?

Junio's previous feedback when discussing batch mode [1] was to offer
less flexibility when parsing new values of these configuration
options. I agree with his statement that "making machine-readable
tokens be spelled in different ways is a 'disease'."  I'd like to
leave this as-is so that the documentation can clearly state the exact
set of allowable values.

[1] https://lore.kernel.org/git/xmqqr1dqzyl7.fsf@gitster.g/

>
> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> > ---
> >  Documentation/config/core.txt | 27 +++++++++----
> >  builtin/fast-import.c         |  2 +-
> >  builtin/index-pack.c          |  4 +-
> >  builtin/pack-objects.c        |  8 ++--
> >  bulk-checkin.c                |  5 ++-
> >  cache.h                       | 39 +++++++++++++++++-
> >  commit-graph.c                |  3 +-
> >  config.c                      | 76 ++++++++++++++++++++++++++++++++++-
> >  csum-file.c                   |  5 ++-
> >  csum-file.h                   |  3 +-
> >  environment.c                 |  1 +
> >  midx.c                        |  3 +-
> >  object-file.c                 |  3 +-
> >  pack-bitmap-write.c           |  3 +-
> >  pack-write.c                  | 13 +++---
> >  read-cache.c                  |  2 +-
> >  16 files changed, 164 insertions(+), 33 deletions(-)
> >
> > diff --git a/Documentation/config/core.txt b/Documentation/config/core.=
txt
> > index dbb134f7136..4f1747ec871 100644
> > --- a/Documentation/config/core.txt
> > +++ b/Documentation/config/core.txt
> > @@ -547,6 +547,25 @@ core.whitespace::
> >    is relevant for `indent-with-non-tab` and when Git fixes `tab-in-ind=
ent`
> >    errors. The default tab width is 8. Allowed values are 1 to 63.
> >
> > +core.fsync::
> > +     A comma-separated list of parts of the repository which should be
> > +     hardened via the core.fsyncMethod when created or modified. You c=
an
> > +     disable hardening of any component by prefixing it with a '-'. La=
ter
> > +     items take precedence over earlier ones in the list. For example,
> > +     `core.fsync=3Dall,-pack-metadata` means "harden everything except=
 pack
> > +     metadata." Items that are not hardened may be lost in the event o=
f an
> > +     unclean system shutdown.
> > ++
> > +* `none` disables fsync completely. This must be specified alone.
> > +* `loose-object` hardens objects added to the repo in loose-object for=
m.
> > +* `pack` hardens objects added to the repo in packfile form.
> > +* `pack-metadata` hardens packfile bitmaps and indexes.
> > +* `commit-graph` hardens the commit graph file.
> > +* `objects` is an aggregate option that includes `loose-objects`, `pac=
k`,
> > +  `pack-metadata`, and `commit-graph`.
> > +* `default` is an aggregate option that is equivalent to `objects,-loo=
se-object`
> > +* `all` is an aggregate option that syncs all individual components ab=
ove.
> > +
>
> It's probably a *bit* more work to set up, but I wonder if this wouldn't
> be simpler if we just said (and this is partially going against what I
> noted above):
>
> =3D=3D BEGIN DOC
>
> core.fsync is a multi-value config variable where each item is a
> pathspec that'll get matched the same way as 'git-ls-files' et al.
>
> When we sync pretend that a path like .git/objects/de/adbeef... is
> relative to the top-level of the git
> directory. E.g. "objects/de/adbeaf.." or "objects/pack/...".
>
> You can then supply a list of wildcards and exclusions to configure
> syncing.  or "false", "off" etc. to turn it off. These are synonymous
> with:
>
>     ; same as "false"
>     core.fsync =3D ":!*"
>
> Or:
>
>     ; same as "true"
>     core.fsync =3D "*"
>
> Or, to selectively sync some things and not others:
>
>     ;; Sync objects, but not "info"
>     core.fsync =3D ":!objects/info/**"
>     core.fsync =3D "objects/**"
>
> See gitrepository-layout(5) for details about what sort of paths you
> might be expected to match. Not all paths listed there will go through
> this mechanism (e.g. currently objects do, but nothing to do with config
> does).
>
> We can and will match this against "fake paths", e.g. when writing out
> packs we may match against just the string "objects/pack", we're not
> going to re-check if every packfile we're writing matches your globs,
> ditto for loose objects. Be reasonable!
>
> This metharism is intended as a shorthand that provides some flexibility
> when fsyncing, while not forcing git to come up with labels for all
> paths the git dir, or to support crazyness like "objects/de/adbeef*"
>
> More paths may be added or removed in the future, and we make no
> promises that we won't move things around, so if in doubt use
> e.g. "true" or a wide pattern match like "objects/**". When in doubt
> stick to the golden path of examples provided in this documentation.
>
> =3D=3D END DOC
>
>
> It's a tad more complex to set up, but I wonder if that isn't worth
> it. It nicely gets around any current and future issues of deciding what
> labels such as "loose-object" etc. to pick, as well as slotting into an
> existing method of doing exclude/include lists.
>

I think this proposal is a lot of complexity to avoid coming up with a
new name for syncable things as they are added to Git.  A path based
mechanism makes it hard to document for the (advanced) user what the
full set of things is and how it might change from release to release.
I think the current core.fsync scheme is a bit easier to understand,
query, and extend.

> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 857be7826f3..916c55d6ce9 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -1204,11 +1204,13 @@ static void write_pack_file(void)
> >                * If so, rewrite it like in fast-import
> >                */
> >               if (pack_to_stdout) {
> > -                     finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | =
CSUM_CLOSE);
> > +                     finalize_hashfile(f, hash, FSYNC_COMPONENT_NONE,
> > +                                       CSUM_HASH_IN_STREAM | CSUM_CLOS=
E);
>
> Not really related to this per-se, but since you're touching the API
> everything goes through I wonder if callers should just always try to
> fsync, and we can just catch EROFS and EINVAL in the wrapper if someone
> tries to flush stdout, or catch the fd at that lower level.
>
> Or maybe there's a good reason for this...

It's platform dependent, but I'd expect fsync would do something for
pipes or stdout redirected to a file.  In these cases we really don't
want to fsync since we have no idea what we're talking to and we're
potentially worsening performance for probably no benefit.

> > [...]
> > +/*
> > + * These values are used to help identify parts of a repository to fsy=
nc.
> > + * FSYNC_COMPONENT_NONE identifies data that will not be a persistent =
part of the
> > + * repository and so shouldn't be fsynced.
> > + */
> > +enum fsync_component {
> > +     FSYNC_COMPONENT_NONE                    =3D 0,
>
> I haven't read ahead much but in most other such cases we don't define
> the "=3D 0", just start at 1<<0, then check the flags elsewhere...
>
> > +static const struct fsync_component_entry {
> > +     const char *name;
> > +     enum fsync_component component_bits;
> > +} fsync_component_table[] =3D {
> > +     { "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
> > +     { "pack", FSYNC_COMPONENT_PACK },
> > +     { "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
> > +     { "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
> > +     { "objects", FSYNC_COMPONENTS_OBJECTS },
> > +     { "default", FSYNC_COMPONENTS_DEFAULT },
> > +     { "all", FSYNC_COMPONENTS_ALL },
> > +};
> > +
> > +static enum fsync_component parse_fsync_components(const char *var, co=
nst char *string)
> > +{
> > +     enum fsync_component output =3D 0;
> > +
> > +     if (!strcmp(string, "none"))
> > +             return output;
> > +
> > +     while (string) {
> > +             int i;
> > +             size_t len;
> > +             const char *ep;
> > +             int negated =3D 0;
> > +             int found =3D 0;
> > +
> > +             string =3D string + strspn(string, ", \t\n\r");
>
> Aside from the "use a list" isn't this hardcoding some windows-specific
> assumptions with \n\r? Maybe not...

I shamelessly stole this code from parse_whitespace_rule. I thought
about making a helper to be called by both functions, but the amount
of state going into and out of the wrapper via arguments was
substantial and seemed to negate the benefit of deduplication.

Thanks for the review,
Neeraj
