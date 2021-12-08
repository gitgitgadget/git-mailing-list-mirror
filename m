Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821C4C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 10:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhLHKUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 05:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhLHKUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 05:20:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B411C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 02:17:10 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so6713756edd.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 02:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=D9QxZMP8e6ePxR9P5Hf42bBxPpmA06J/n97pVNHTTDs=;
        b=eXPG281b54h/qONQSfrKEbA8RJMHw+4g/Z9wCwcyObfJ+V0ZV39ABxhfzp6IQ+xlRR
         vqTRpZTFRHQoCm2zEIb4eLYY77EOT4iVyLlcp0x0Cb5Q/zMtbKOoczrYoadsLWGExqFX
         XGyjSFu4AqS0li9xAFRTkoIS7nQlF/UCEwseIt/rW0BcExIWwe0AuLKlVVgsdhF5BXpc
         5cWvaZtppDJ+TFqc9MZZv5V52Uc0c9SxsDLz+1wstb0j1EF85APrhf9woJNOQ5bbjVn6
         tybtsA13XmYloVDSH7zGILElwAOgM4kS/hwag18LtKMCLSRmnWgpcv1cc9rL6aZdTmWu
         A2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=D9QxZMP8e6ePxR9P5Hf42bBxPpmA06J/n97pVNHTTDs=;
        b=oSnevWbptA8uAWa4oNe+4CCOrzajJ+JFhZEBpVvGnSiW4JF8qCz+W5s8SDjgusl0zq
         1nYg8QKqSj+Fa/6ssgrDYL64bUvAJN8hQRcWNOIH+Kt2YsTaZkjKPho4N7+KHURNb/fD
         Y/JM2Bicl3jMzUD7nHlTVzvVxyyeHjqBubZRa32a1dGU67I7qyifI0OXLTJj+HfP5cov
         FA5mowDX8cMsDcs6lKI13I7VUINVLSfP0peDlWOCCIL4HuQ8Pqblo9MjyjnddQs47pjn
         Lhr7bGEmNnv3/o83Z5Er/EzgiIl65VeGIhc52xfZChpC1F7AnnyitjHRWiU+jNXSIEF4
         AB8Q==
X-Gm-Message-State: AOAM53023VALk0mQJZ3zUHDmjqUL0L2Y8vQfiRnRMcRiLffzEp4r7OjZ
        Ogyp9/Rwnh0Z2t4/c6zINidAnvmxZtVEEw==
X-Google-Smtp-Source: ABdhPJx3GD24tJGNy/3JwpdIQPGuwh8bQ5AX8mNG69ElnT7m57HEq1Mu//DOvK88buzWIRg902+QTA==
X-Received: by 2002:a17:906:af1a:: with SMTP id lx26mr6517103ejb.44.1638958628015;
        Wed, 08 Dec 2021 02:17:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id mp9sm1206412ejc.106.2021.12.08.02.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 02:17:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muu0Y-001MlQ-3W;
        Wed, 08 Dec 2021 11:17:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/3] core.fsync: introduce granular fsync control
Date:   Wed, 08 Dec 2021 11:05:30 +0100
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
 <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
 <211207.86wnkgo9fv.gmgdl@evledraar.gmail.com>
 <CANQDOdfX2KaosPwLM4hS4rp+FH9V7VUxUh_md43FfZ9NG4iroQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CANQDOdfX2KaosPwLM4hS4rp+FH9V7VUxUh_md43FfZ9NG4iroQ@mail.gmail.com>
Message-ID: <211208.86ee6nmme5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 07 2021, Neeraj Singh wrote:

> On Tue, Dec 7, 2021 at 5:01 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>>
>> On Tue, Dec 07 2021, Neeraj Singh via GitGitGadget wrote:
>>
>> > From: Neeraj Singh <neerajsi@microsoft.com>
>> >
>> > This commit introduces the `core.fsync` configuration
>> > knob which can be used to control how components of the
>> > repository are made durable on disk.
>> >
>> > This setting allows future extensibility of the list of
>> > syncable components:
>> > * We issue a warning rather than an error for unrecognized
>> >   components, so new configs can be used with old Git versions.
>>
>> Looks good!
>>
>> > * We support negation, so users can choose one of the default
>> >   aggregate options and then remove components that they don't
>> >   want. The user would then harden any new components added in
>> >   a Git version update.
>>
>> I think this config schema makes sense, but just a (I think important)
>> comment on the "how" not "what" of it. It's really much better to define
>> config as:
>>
>>     [some]
>>     key =3D value
>>     key =3D value2
>>
>> Than:
>>
>>     [some]
>>     key =3D value,value2
>>
>> The reason is that "git config" has good support for working with
>> multi-valued stuff, so you can do e.g.:
>>
>>     git config --get-all -z some.key
>>
>> And you can easily (re)set such config e.g. with --replace-all etc., but
>> for comma-delimited you (and users) need to do all that work themselves.
>>
>> Similarly instead of:
>>
>>     some.key =3D want-this
>>     some.key =3D -not-this
>>     some.key =3D but-want-this
>>
>> I think it's better to just have two lists, one inclusive another
>> exclusive. E.g. see "log.decorate" and "log.excludeDecoration",
>> "transfer.hideRefs"
>>
>> Which would mean:
>>
>>     core.fsync =3D want-this
>>     core.fsyncExcludes =3D -not-this
>>
>> For some value of "fsyncExcludes", maybe "noFsync"? Anyway, just a
>> suggestion on making this easier for users & the implementation.
>>
>
> Maybe there's some way to handle this I'm unaware of, but a
> disadvantage of your multi-valued config proposal is that it's harder,
> for example, for a per-repo config store to reasonably override a
> per-user config store.  With the configuration scheme as-is, I can
> have a per-user setting like `core.fsync=3Dall` which covers my typical
> repos, but then have a maintainer repo with a private setting of
> `core.fsync=3Dnone` to speed up cases where I'm mostly working with
> other people's changes that are backed up in email or server-side
> repos.  The latter setting conveniently overrides the former setting
> in all aspects.

Even if you turn just your comma-delimited proposal into a list proposal
can't we just say that the last one wins? Then it won't matter what cmae
before, you'd specify "core.fsync=3Dnone" in your local .git/config.

But this is also a general issue with a bunch of things in git's config
space. I'd rather see us use the list-based values and just come up with
some general way to reset them that works for all keys, rather than
regretting having comma-delimited values that'll be harder to work with
& parse, which will be a legacy wart if/when we come up with a way to
say "reset all previous settings".

> Also, with the core.fsync and core.fsyncExcludes, how would you spell
> "don't sync anything"? Would you still have the aggregate options.?

    core.fsyncExcludes =3D *

I.e. the same as the core.fsync=3Dnone above, anyway I still like the
wildcard thing below a bit more...

>> > This also supports the common request of doing absolutely no
>> > fysncing with the `core.fsync=3Dnone` value, which is expected
>> > to make the test suite faster.
>>
>> Let's just use the git_parse_maybe_bool() or git_parse_maybe_bool_text()
>> so we'll accept "false", "off", "no" like most other such config?
>
> Junio's previous feedback when discussing batch mode [1] was to offer
> less flexibility when parsing new values of these configuration
> options. I agree with his statement that "making machine-readable
> tokens be spelled in different ways is a 'disease'."  I'd like to
> leave this as-is so that the documentation can clearly state the exact
> set of allowable values.
>
> [1] https://lore.kernel.org/git/xmqqr1dqzyl7.fsf@gitster.g/

I think he's talking about batch, Batch, BATCH, bAtCh etc. there. But
the "maybe bool" is a stanard pattern we use.

I don't think we'd call one of these 0, off, no or false etc. to avoid
confusion, so then you can use git_parse_maybe_...()

>>
>> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
>> > ---
>> >  Documentation/config/core.txt | 27 +++++++++----
>> >  builtin/fast-import.c         |  2 +-
>> >  builtin/index-pack.c          |  4 +-
>> >  builtin/pack-objects.c        |  8 ++--
>> >  bulk-checkin.c                |  5 ++-
>> >  cache.h                       | 39 +++++++++++++++++-
>> >  commit-graph.c                |  3 +-
>> >  config.c                      | 76 ++++++++++++++++++++++++++++++++++-
>> >  csum-file.c                   |  5 ++-
>> >  csum-file.h                   |  3 +-
>> >  environment.c                 |  1 +
>> >  midx.c                        |  3 +-
>> >  object-file.c                 |  3 +-
>> >  pack-bitmap-write.c           |  3 +-
>> >  pack-write.c                  | 13 +++---
>> >  read-cache.c                  |  2 +-
>> >  16 files changed, 164 insertions(+), 33 deletions(-)
>> >
>> > diff --git a/Documentation/config/core.txt b/Documentation/config/core=
.txt
>> > index dbb134f7136..4f1747ec871 100644
>> > --- a/Documentation/config/core.txt
>> > +++ b/Documentation/config/core.txt
>> > @@ -547,6 +547,25 @@ core.whitespace::
>> >    is relevant for `indent-with-non-tab` and when Git fixes `tab-in-in=
dent`
>> >    errors. The default tab width is 8. Allowed values are 1 to 63.
>> >
>> > +core.fsync::
>> > +     A comma-separated list of parts of the repository which should be
>> > +     hardened via the core.fsyncMethod when created or modified. You =
can
>> > +     disable hardening of any component by prefixing it with a '-'. L=
ater
>> > +     items take precedence over earlier ones in the list. For example,
>> > +     `core.fsync=3Dall,-pack-metadata` means "harden everything excep=
t pack
>> > +     metadata." Items that are not hardened may be lost in the event =
of an
>> > +     unclean system shutdown.
>> > ++
>> > +* `none` disables fsync completely. This must be specified alone.
>> > +* `loose-object` hardens objects added to the repo in loose-object fo=
rm.
>> > +* `pack` hardens objects added to the repo in packfile form.
>> > +* `pack-metadata` hardens packfile bitmaps and indexes.
>> > +* `commit-graph` hardens the commit graph file.
>> > +* `objects` is an aggregate option that includes `loose-objects`, `pa=
ck`,
>> > +  `pack-metadata`, and `commit-graph`.
>> > +* `default` is an aggregate option that is equivalent to `objects,-lo=
ose-object`
>> > +* `all` is an aggregate option that syncs all individual components a=
bove.
>> > +
>>
>> It's probably a *bit* more work to set up, but I wonder if this wouldn't
>> be simpler if we just said (and this is partially going against what I
>> noted above):
>>
>> =3D=3D BEGIN DOC
>>
>> core.fsync is a multi-value config variable where each item is a
>> pathspec that'll get matched the same way as 'git-ls-files' et al.
>>
>> When we sync pretend that a path like .git/objects/de/adbeef... is
>> relative to the top-level of the git
>> directory. E.g. "objects/de/adbeaf.." or "objects/pack/...".
>>
>> You can then supply a list of wildcards and exclusions to configure
>> syncing.  or "false", "off" etc. to turn it off. These are synonymous
>> with:
>>
>>     ; same as "false"
>>     core.fsync =3D ":!*"
>>
>> Or:
>>
>>     ; same as "true"
>>     core.fsync =3D "*"
>>
>> Or, to selectively sync some things and not others:
>>
>>     ;; Sync objects, but not "info"
>>     core.fsync =3D ":!objects/info/**"
>>     core.fsync =3D "objects/**"
>>
>> See gitrepository-layout(5) for details about what sort of paths you
>> might be expected to match. Not all paths listed there will go through
>> this mechanism (e.g. currently objects do, but nothing to do with config
>> does).
>>
>> We can and will match this against "fake paths", e.g. when writing out
>> packs we may match against just the string "objects/pack", we're not
>> going to re-check if every packfile we're writing matches your globs,
>> ditto for loose objects. Be reasonable!
>>
>> This metharism is intended as a shorthand that provides some flexibility
>> when fsyncing, while not forcing git to come up with labels for all
>> paths the git dir, or to support crazyness like "objects/de/adbeef*"
>>
>> More paths may be added or removed in the future, and we make no
>> promises that we won't move things around, so if in doubt use
>> e.g. "true" or a wide pattern match like "objects/**". When in doubt
>> stick to the golden path of examples provided in this documentation.
>>
>> =3D=3D END DOC
>>
>>
>> It's a tad more complex to set up, but I wonder if that isn't worth
>> it. It nicely gets around any current and future issues of deciding what
>> labels such as "loose-object" etc. to pick, as well as slotting into an
>> existing method of doing exclude/include lists.
>>
>
> I think this proposal is a lot of complexity to avoid coming up with a
> new name for syncable things as they are added to Git.  A path based
> mechanism makes it hard to document for the (advanced) user what the
> full set of things is and how it might change from release to release.
> I think the current core.fsync scheme is a bit easier to understand,
> query, and extend.

We document it in gitrepository-layout(5). Yeah it has some
disadvantages, but one advantage is that you could make the
composability easy. I.e. if last exclude wins then a setting of:

    core.fsync =3D ":!*"
    core.fsync =3D "objects/**"

Would reset all previous matches & only match objects/**.

>> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> > index 857be7826f3..916c55d6ce9 100644
>> > --- a/builtin/pack-objects.c
>> > +++ b/builtin/pack-objects.c
>> > @@ -1204,11 +1204,13 @@ static void write_pack_file(void)
>> >                * If so, rewrite it like in fast-import
>> >                */
>> >               if (pack_to_stdout) {
>> > -                     finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM |=
 CSUM_CLOSE);
>> > +                     finalize_hashfile(f, hash, FSYNC_COMPONENT_NONE,
>> > +                                       CSUM_HASH_IN_STREAM | CSUM_CLO=
SE);
>>
>> Not really related to this per-se, but since you're touching the API
>> everything goes through I wonder if callers should just always try to
>> fsync, and we can just catch EROFS and EINVAL in the wrapper if someone
>> tries to flush stdout, or catch the fd at that lower level.
>>
>> Or maybe there's a good reason for this...
>
> It's platform dependent, but I'd expect fsync would do something for
> pipes or stdout redirected to a file.  In these cases we really don't
> want to fsync since we have no idea what we're talking to and we're
> potentially worsening performance for probably no benefit.

Yeah maybe we should just leave it be.

I'd think the C library returning EINVAL would be a trivial performance
cost though.

It just seemed odd to hardcode assumptions about what can and can't be
synced when the POSIX defined function will also tell us that.

Anyway...

>> > [...]
>> > +/*
>> > + * These values are used to help identify parts of a repository to fs=
ync.
>> > + * FSYNC_COMPONENT_NONE identifies data that will not be a persistent=
 part of the
>> > + * repository and so shouldn't be fsynced.
>> > + */
>> > +enum fsync_component {
>> > +     FSYNC_COMPONENT_NONE                    =3D 0,
>>
>> I haven't read ahead much but in most other such cases we don't define
>> the "=3D 0", just start at 1<<0, then check the flags elsewhere...
>>
>> > +static const struct fsync_component_entry {
>> > +     const char *name;
>> > +     enum fsync_component component_bits;
>> > +} fsync_component_table[] =3D {
>> > +     { "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
>> > +     { "pack", FSYNC_COMPONENT_PACK },
>> > +     { "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
>> > +     { "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
>> > +     { "objects", FSYNC_COMPONENTS_OBJECTS },
>> > +     { "default", FSYNC_COMPONENTS_DEFAULT },
>> > +     { "all", FSYNC_COMPONENTS_ALL },
>> > +};
>> > +
>> > +static enum fsync_component parse_fsync_components(const char *var, c=
onst char *string)
>> > +{
>> > +     enum fsync_component output =3D 0;
>> > +
>> > +     if (!strcmp(string, "none"))
>> > +             return output;
>> > +
>> > +     while (string) {
>> > +             int i;
>> > +             size_t len;
>> > +             const char *ep;
>> > +             int negated =3D 0;
>> > +             int found =3D 0;
>> > +
>> > +             string =3D string + strspn(string, ", \t\n\r");
>>
>> Aside from the "use a list" isn't this hardcoding some windows-specific
>> assumptions with \n\r? Maybe not...
>
> I shamelessly stole this code from parse_whitespace_rule. I thought
> about making a helper to be called by both functions, but the amount
> of state going into and out of the wrapper via arguments was
> substantial and seemed to negate the benefit of deduplication.

FWIW string_list_split() is easier to work with in those cases, or at
least I think so...
