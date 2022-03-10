Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38955C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 02:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiCJCzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 21:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiCJCy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 21:54:59 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46AC3E5C4
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 18:53:58 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id v28so5832316ljv.9
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 18:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WMUW/NmAOzoHD8sQgvW2rZxHfndrovW1Iz2WbB76IRk=;
        b=DUQJyq61LaHACwJKgXIffwY8sC6rQq/8DZ+ExEFxd8YyvyV4MI/mE/4cXbd3oarFx1
         BRdWM5J/+Nr/BFyvHpqGJXjpSbUExQ3ghYOab+TX/lQELuZ3ZuqQwqF0GouC2BoDMk2R
         CTnU1jKg9B6lqVD8Buh4M8U2ED6SFr1l4Q6zr2xJCmyl1d7sOLTCs3r0bYZ6TQhOvnQ2
         IjJ/fK7o9JUS+MLt5Jh73+iva/zqE5s78b0Mdr6ibCIy6dsgwBiOOVbvyb37oHSbdx+i
         Ed6oOxI2KqILMnLo2HAQ/cCxkXscv/+fbY5zClAFtNrg/BGh4vFi/sybZ50dgurGDaqk
         vJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WMUW/NmAOzoHD8sQgvW2rZxHfndrovW1Iz2WbB76IRk=;
        b=wtBAINgx5ox3jZfLUYi28PeyaPtrqHoyMmAZ6JL/NR7s5SDoiVx8EbNG2bpN6ooWxp
         yxnZdY1KYyzCRf6Wm9JfAgyoWGJ4nY5R522EE7/VdgBP8mVBM6Ez/U9lou2eJKs+0Jye
         crIgjCgGc3O/1pkBI4b2foJZtzFatSWbgvSxSMgdUnOei79PR6tAbgAT9FgoSNIzPAqb
         ZM6UHeU5i0SB6rf+ZQwgDRvfJ4ApVXHfZoSWLQyS9+z/chcX5bJl05bRXw1gKSumpNZN
         LiY2GFd+oroQKd5O1CNPS42Z3NpYdSAZhsN739898VhZeQ43vAJyq8gA7KIHiJhCA0F1
         PruQ==
X-Gm-Message-State: AOAM531nl8Rz5kpvXsb6ZC5pU4QN2cx1Mz4ot53HTlO58/QLoYJqErMS
        obO9AnOla1bab8VQNohQjVtwhqix/jvaXznPLyU=
X-Google-Smtp-Source: ABdhPJyezGUQsySM1gStJJzYp2/dNRNuKsTiTWPHy0Ci11zSdw3i0vLD1aLxkL6MuXUDRwUITvYB/4NSOk01G2XmEuE=
X-Received: by 2002:a05:651c:241:b0:23e:42c1:2e4 with SMTP id
 x1-20020a05651c024100b0023e42c102e4mr1609327ljn.406.1646880836955; Wed, 09
 Mar 2022 18:53:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
 <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com> <e31886717b42837f4e1538a13c8954aa07865af5.1646866998.git.gitgitgadget@gmail.com>
 <xmqqo82eirnv.fsf@gitster.g>
In-Reply-To: <xmqqo82eirnv.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 9 Mar 2022 18:53:45 -0800
Message-ID: <CANQDOddU_WXD-6ncDGBrgpsuKT-XDGC=SeaaQTNQFdODFZ7TkQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] core.fsync: introduce granular fsync control
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 9, 2022 at 4:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +/*
> > + * These values are used to help identify parts of a repository to fsy=
nc.
> > + * FSYNC_COMPONENT_NONE identifies data that will not be a persistent =
part of the
> > + * repository and so shouldn't be fsynced.
> > + */
> > +enum fsync_component {
> > +     FSYNC_COMPONENT_NONE,
> > +     FSYNC_COMPONENT_LOOSE_OBJECT            =3D 1 << 0,
> > +     FSYNC_COMPONENT_PACK                    =3D 1 << 1,
> > +     FSYNC_COMPONENT_PACK_METADATA           =3D 1 << 2,
> > +     FSYNC_COMPONENT_COMMIT_GRAPH            =3D 1 << 3,
> > +};
>
> OK, so the idea is that Patrick's "we need to fsync refs" will be
> done by adding a new component to this list, and sprinkling a call
> to fsync_component_or_die() in the code of ref-files backend?
>

Yes. Patrick will need to add fsync_component_or_die wherever his
patch series has already added fsync_or_die.

If he follows =C3=86var's suggestion of treating remote refs differently
from local refs, he might want to define multiple components.

> I am wondering if fsync_or_die() interface is abstracted well
> enough, or we need things like "the fd is inside this directory; in
> addition to doing the fsync of the fd, please sync the parent
> directory as well" support before we start adding more components
> (if there is such a need, perhaps it comes before this step).
>

I think syncing the parent directory is a separate fsyncMethod that
would require changes across the codebase to obtain an appropriate
directory fd. I'd prefer to treat that as a separable concern.

> > +#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
> > +                               FSYNC_COMPONENT_PACK_METADATA | \
> > +                               FSYNC_COMPONENT_COMMIT_GRAPH)
>
> IOW, everything other than loose object, which already has a
> separate core.fsyncObjectFiles knob to loosen.  Everything else we
> currently sync unconditionally and the default keeps that
> arrangement?
>

Yes, trying to keep default behavior identical on non-Windows
platforms.  Windows will be expected to adopt batch mode, and have
loose objects in this set.

> > +static inline void fsync_component_or_die(enum fsync_component compone=
nt, int fd, const char *msg)
> > +{
> > +     if (fsync_components & component)
> > +             fsync_or_die(fd, msg);
> > +}
>
> Do we have a compelling reason to have this as a static inline
> function?  We are talking about concluding an I/O operation and
> I doubt there is a good performance argument for it.
>

Yeah, this is meant to optimize the case where the component isn't
being fsynced. I'll move this function to write-or-die.c below
fsync_or_die.

> > +static const struct fsync_component_entry {
> > +     const char *name;
> > +     enum fsync_component component_bits;
> > +} fsync_component_table[] =3D {
>
> thing[] is an array of "thing" (and thing[4] is the "fourth" such
> thing), but this is not an array of a table (it is a name-to-bit
> mapping).
>
> I wonder if this array works without "_table" suffix in its name.

This is modeled after whitespace_rule_names.  What if I change this to
the following?
static const struct fsync_component_name {
...
} fsync_component_names[]

>
> > +     { "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
> > +     { "pack", FSYNC_COMPONENT_PACK },
> > +     { "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
> > +     { "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
> > +};
> > +
> > +static enum fsync_component parse_fsync_components(const char *var, co=
nst char *string)
> > +{
> > +     enum fsync_component output =3D 0;
> > +
> > +     if (!strcmp(string, "none"))
> > +             return FSYNC_COMPONENT_NONE;
> > +
> > +     while (string) {
> > +             int i;
> > +             size_t len;
> > +             const char *ep;
> > +             int negated =3D 0;
> > +             int found =3D 0;
> > +
> > +             string =3D string + strspn(string, ", \t\n\r");
> > +             ep =3D strchrnul(string, ',');
> > +             len =3D ep - string;
> > +
> > +             if (*string =3D=3D '-') {
> > +                     negated =3D 1;
> > +                     string++;
> > +                     len--;
> > +                     if (!len)
> > +                             warning(_("invalid value for variable %s"=
), var);
> > +             }
> > +
> > +             if (!len)
> > +                     break;
> > +
> > +             for (i =3D 0; i < ARRAY_SIZE(fsync_component_table); ++i)=
 {
> > +                     const struct fsync_component_entry *entry =3D &fs=
ync_component_table[i];
> > +
> > +                     if (strncmp(entry->name, string, len))
> > +                             continue;
> > +
> > +                     found =3D 1;
> > +                     if (negated)
> > +                             output &=3D ~entry->component_bits;
> > +                     else
> > +                             output |=3D entry->component_bits;
> > +             }
> > +
> > +             if (!found) {
> > +                     char *component =3D xstrndup(string, len);
> > +                     warning(_("ignoring unknown core.fsync component =
'%s'"), component);
> > +                     free(component);
> > +             }
> > +
> > +             string =3D ep;
> > +     }
> > +
> > +     return output;
> > +}
>
> Hmph.  I would have expected, with built-in default of
> pack,pack-metadata,commit-graph,
>

At the conclusion of this series, I defined 'default' as an aggregate
option that includes
the platform default.  I'd prefer not to have any statefulness of the
core.fsync setting so
that there is less confusion about the final fsync configuration. My
colleagues had a fair
amount of confusion internally when testing Git performance internally
with regards to
the core.fsyncObjectFiles setting.  Inline this is how your configs
would be written:

>  - "none,pack" would choose only "pack" by first clearing the
>    built-in default (or whatever was set in configuration files that
>    are lower precedence than what we are reading) and then OR'ing
>    the "pack" bit in.
>

"pack" would choose only "pack"

>  - "-pack" would choose "pack-metadata,commit-graph" by first
>    starting from the built-in default and then CLR'ing the "pack"
>    bit out.  If there were already changes made by the lower
>    precedence configuration files like /etc/gitconfig, the result
>    might be different and the only definite thing we can say is that
>    the pack bit is cleared.
>

"default,-pack" would be the platform default, but not packfiles.

>  - "loose-object" would choose all of the bits by first starting
>    from the built-in default and then OR'ing the "loose-object" bit
>    in.
>

"default,loose-object" would add loose objects to the platform config.

> Otherwise, parsing "none" is more or less pointless, as the above
> parser always start from 0 and OR's in or CLR's out the named bit.
> Whoever writes "none" can just write an empty string, no?

I think the empty string would be disallowed since "core.fsync=3D" would
be entirely
missing a value. But on testing this doesn't seem to be the case. I'll chan=
ge
this to be more strict in that the user has to pass an explicit value,
such as 'none'.

>
> I wonder you'd rather want to do it this way?
>
> parse_fsync_components(var, value, current) {
>         enum fsync_component positive =3D 0, negative =3D 0;
>
>         while (string) {
>                 int negated =3D 0;
>                 enum fsync_component bits;
>
>                 parse out a single component into <negated, bits>;
>
>                 if (bits =3D=3D 0) { /* "none" given */
>                         current =3D 0;
>                 } else if (negated) {
>                         negative |=3D bits;
>                 } else {
>                         positive |=3D bits;
>                 }
>                 advance <string> pointer;
>         }
>
>         return (current | positive) & ~negative;
> }
>
> And then ...
>
> > +     if (!strcmp(var, "core.fsync")) {
> > +             if (!value)
> > +                     return config_error_nonbool(var);
> > +             fsync_components =3D parse_fsync_components(var, value);
> > +             return 0;
> > +     }
> > +
>
> ... this part would pass the current value of fsync_components as
> the third parameter to the parse_fsync_components().  The variable
> would be initialized to the FSYNC_COMPONENTS_DEFAULT we saw earlier.
>

I'm afraid that this method would lead to statefulness between
different levels configuring
core.fsync.  I'd prefer that the user could know what will happen by
just inspecting the value
returned by `git config core.fsync`.

>
> > @@ -1613,7 +1684,7 @@ static int git_default_core_config(const char *va=
r, const char *value, void *cb)
> >       }
> >
> >       if (!strcmp(var, "core.fsyncobjectfiles")) {
> > -             fsync_object_files =3D git_config_bool(var, value);
> > +             warning(_("core.fsyncobjectfiles is deprecated; use core.=
fsync instead"));
>
> This is not deprecating but removing the support, which I am not
> sure is a sensible thing to do.  Rather we should pretend that
> core.fsync =3D "loose-object" (or "-loose-object") were found in the
> configuration, shouldn't we?
>

The problem I anticipate is that figuring out the final configuration
becomes pretty
complex in the face of conflicting configurations of fsyncObjectFiles
and core.fsync.
The user won't know what will happen without reading the Git code or
doing performance
experiments.  I thought we can avoid all of this complexity by just
having a simple warning
that pushes users toward the new configuration value.  Aside from
seeing a warning, a
user's actual usage of Git functionality shouldn't be affected.

Alternatively, what if we just silently ignore the old
core.fsyncObjectFiles setting?
If neither of these is an option, I'll put back some support for the
old setting.

Thanks,
Neeraj
