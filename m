Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CEEC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 14:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbjDEOzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbjDEOzc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 10:55:32 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC176A74
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 07:55:30 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id f188so24395073ybb.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680706529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2J2TzrmvBNFE3ebXSSkS8NyG5MKe9axDCMpHT59yBoY=;
        b=MS7lGPkvUxR8ZNq0QU5YR8kgeimnF5Od7WFBAJJXAyLcxxzVtsJqjlPo7RsohS/GSs
         x4N37j2kDUvtC4wfVfjX6/n7MiDo6zEi9qr/TvZ59jPxULuvfoTgeNYB742cbpUfFYin
         J093PX+Rtu+3Up/MzO3JUTT413/iHVMU6ZUwrTcluSHITyFgeO/X/JAysmdQaQRfeLHH
         oTBdOyu8s5L/7Diyp/9fyKKwVadzJ60OsOWmiX2QhzQKk2efLT64HMRM3pZWfXBBiR7t
         +KzbQKWJ96Hi6jAPnDxrRcD3Pi66GLr6lCV/G8JKt0IVrady+UotlpzV/jBBzEZZgSg7
         Irfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680706529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J2TzrmvBNFE3ebXSSkS8NyG5MKe9axDCMpHT59yBoY=;
        b=GC1mQcdRpWoK8zDPW2z1oLwsZkIwMoqqEB4C/h+6VmTmzkTtMkQyPlGc0dmaO9okbv
         JMhC3Fx7SvYqZeYAS8kCE6o3C3XI4U1FM/sw4xF7GRxmZR3Wdh5uZxK4jTZGn00KP273
         SrEszRqoRPDrL8qoJh7RlcGD/+mcImBNdloe5FAdZz38l6WYCNc6MBGHq4fpG0HSaZ+S
         kx6mVsYCjsRZRPkIEyz7X7dVGKDJGV96XOTdYwMIZxMYRg4kT1Mxfut8mOag4pTDv6Ie
         OKRA5tcPIJPKbgoZqetAqyAb4ArV0Iy30OT5yRU6z0ec4BVa9KstHk+4QiMgocGpwwfz
         NbLQ==
X-Gm-Message-State: AAQBX9efe1sATLzBw2OVWmnSijmKIKwsfUuF5eP8pTgoclHcgdFdMk1d
        X4s8hG3tp+5P0ofQJCH66RyNlfa7tlNDDgtfur0=
X-Google-Smtp-Source: AKy350ZT7Ymp5p0Bdl3zDrMa1WWH3uBWI22sMhL9Sfn+EKia+QDdlnfiRNaFGePm54rz6lPH31T5lhsNxf3LExdx1Cw=
X-Received: by 2002:a25:d890:0:b0:b45:5cbe:48b3 with SMTP id
 p138-20020a25d890000000b00b455cbe48b3mr4346523ybg.0.1680706529216; Wed, 05
 Apr 2023 07:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230405012742.2452208-1-felipe.contreras@gmail.com>
 <20230405012742.2452208-2-felipe.contreras@gmail.com> <230405.86fs9evfte.gmgdl@evledraar.gmail.com>
In-Reply-To: <230405.86fs9evfte.gmgdl@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 5 Apr 2023 09:55:17 -0500
Message-ID: <CAMP44s0oBKfp6bXbg_+vp4CuRj_nh8uDBTCeT65z7UCUzj4K0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add fetch.updateHead option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Daniel_Mart=C3=AD?= <mvdan@mvdan.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 4:28=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avarab@gmail.com> wrote:
>
>
> On Tue, Apr 04 2023, Felipe Contreras wrote:
>
> > Users might change the behavior when running "git fetch" so that the
> > remote's HEAD symbolic ref is updated at certain point.
> >
> > For example after running "git remote add" the remote HEAD is not
> > set like it is with "git clone".
> >
> > Setting "fetch.updatehead =3D missing" would probably be a sensible
> > default that everyone would want, but for now the default behavior is t=
o
> > never update HEAD, so there shouldn't be any functional changes.
> >
> > For the next major version of Git, we might want to change this default=
.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/config/fetch.txt  |  4 +++
> >  Documentation/config/remote.txt |  3 ++
> >  builtin/fetch.c                 | 64 ++++++++++++++++++++++++++++++++-
> >  remote.c                        | 21 +++++++++++
> >  remote.h                        | 11 ++++++
> >  t/t5510-fetch.sh                | 31 ++++++++++++++++
> >  6 files changed, 133 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetc=
h.txt
> > index 568f0f75b3..dc147ffb35 100644
> > --- a/Documentation/config/fetch.txt
> > +++ b/Documentation/config/fetch.txt
> > @@ -120,3 +120,7 @@ fetch.bundleCreationToken::
> >  The creation token values are chosen by the provider serving the speci=
fic
> >  bundle URI. If you modify the URI at `fetch.bundleURI`, then be sure t=
o
> >  remove the value for the `fetch.bundleCreationToken` value before fetc=
hing.
> > +
> > +fetch.updateHead::
> > +     Defines when to update the remote HEAD symbolic ref. Values are '=
never',
> > +     'missing' (update only when HEAD is missing), and 'always'.
> > diff --git a/Documentation/config/remote.txt b/Documentation/config/rem=
ote.txt
> > index 0678b4bcfe..9d739d2ed4 100644
> > --- a/Documentation/config/remote.txt
> > +++ b/Documentation/config/remote.txt
> > @@ -86,3 +86,6 @@ remote.<name>.partialclonefilter::
> >       Changing or clearing this value will only affect fetches for new =
commits.
> >       To fetch associated objects for commits already present in the lo=
cal object
> >       database, use the `--refetch` option of linkgit:git-fetch[1].
> > +
> > +remote.<name>.updateHead::
> > +     Defines when to update the remote HEAD symbolic ref. See `fetch.u=
pdateHead`.
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 7221e57f35..7e93a1aa46 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -59,6 +59,8 @@ static int fetch_prune_tags_config =3D -1; /* unspeci=
fied */
> >  static int prune_tags =3D -1; /* unspecified */
> >  #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
> >
> > +static int fetch_update_head =3D FETCH_UPDATE_HEAD_DEFAULT;
> > +
> >  static int all, append, dry_run, force, keep, multiple, update_head_ok=
;
> >  static int write_fetch_head =3D 1;
> >  static int verbosity, deepen_relative, set_upstream, refetch;
> > @@ -129,6 +131,9 @@ static int git_fetch_config(const char *k, const ch=
ar *v, void *cb)
> >               return 0;
> >       }
> >
> > +     if (!strcmp(k, "fetch.updatehead"))
> > +             return parse_update_head(&fetch_update_head, k, v);
> > +
> >       return git_default_config(k, v, cb);
> >  }
> >
> > @@ -1579,6 +1584,47 @@ static int backfill_tags(struct transport *trans=
port,
> >       return retcode;
> >  }
> >
> > +static void update_head(int config, const struct ref *head, const stru=
ct remote *remote)
>
> Here you pass a "const struct remote".
>
> > +{
> > +     char *ref, *target;
> > +     const char *r;
> > +     int flags;
> > +
> > +     if (!head || !head->symref || !remote)
> > +             return;
> > +
> > +     ref =3D apply_refspecs((struct refspec *)&remote->fetch, "refs/he=
ads/HEAD");
> > +     target =3D apply_refspecs((struct refspec *)&remote->fetch, head-=
>symref);
>
> But here we end up with this cast, as it's not const after all, we're
> modifying it.

It is a const, and we are not modifying it. `apply_refspecs()` is not
saying what it should say: the refspec remains constant.

As Patrick explained: `apply_refspecs()` should probably be fixed.

> > +
> > +     if (!ref || !target) {
> > +             warning(_("could not update remote head"));
> > +             return;
> > +     }
> > +
> > +     r =3D resolve_ref_unsafe(ref, 0, NULL, &flags);
> > +
> > +     if (r) {
> > +             if (config =3D=3D FETCH_UPDATE_HEAD_MISSING) {
> > +                     if (flags & REF_ISSYMREF)
> > +                             /* already present */
> > +                             return;
> > +             } else if (config =3D=3D FETCH_UPDATE_HEAD_ALWAYS) {
> > +                     if (!strcmp(r, target))
> > +                             /* already up-to-date */
> > +                             return;
>
> I think you should name the "enum" you're adding below, the one that
> contains the new "FETCH_UPDATE_HEAD_DEFAULT".
>
> Then this could be a "switch", and the compiler could check the
> arguments, i.e. you could pass an enum type instead of an "int".

Sure, it can be an `enum fetch_update_mode` instead of `int`, but I
don't see what value it provides, other than more verbosity. The enum
right above is also unnamed, and 'remote->origin' is an int. And it's
not the only enum of that kind in the source code.

Using a switch is better, but that doesn't require an enum type. The
multiple ifs are just a remnant of a previous version of the code.

> > +             } else
>
> {} missing, if you keep this, but...
>
> > +                     /* should never happen */
> > +                     return;
>
> ...so, here we're not checking some enum values, but presumably other
> things check this, I haven't checked.

Yes, the function cannot be called otherwise.

> But for a "should never happen", should we make this a "BUG()", or is it
> user-controlled?

Sure, it can be a `BUG()`. It truly should not happen.

> > +     }
> > +
> > +     if (!create_symref(ref, target, "remote update head")) {
> > +             if (verbosity >=3D 0)
> > +                     printf(_("Updated remote '%s' HEAD\n"), remote->n=
ame);
> > +     } else {
> > +             warning(_("could not update remote head"));
> > +     }
> > +}
> > +
> >  static int do_fetch(struct transport *transport,
> >                   struct refspec *rs)
> >  {
> > @@ -1592,6 +1638,7 @@ static int do_fetch(struct transport *transport,
> >       int must_list_refs =3D 1;
> >       struct fetch_head fetch_head =3D { 0 };
> >       struct strbuf err =3D STRBUF_INIT;
> > +     int need_update_head =3D 0, update_head_config =3D 0;
> >
> >       if (tags =3D=3D TAGS_DEFAULT) {
> >               if (transport->remote->fetch_tags =3D=3D 2)
> > @@ -1626,9 +1673,21 @@ static int do_fetch(struct transport *transport,
> >       } else {
> >               struct branch *branch =3D branch_get(NULL);
> >
> > -             if (transport->remote->fetch.nr)
> > +             if (transport->remote->fetch.nr) {
> > +
> > +                     if (transport->remote->update_head)
> > +                             update_head_config =3D transport->remote-=
>update_head;
> > +                     else
> > +                             update_head_config =3D fetch_update_head;
> > +
> > +                     need_update_head =3D update_head_config && update=
_head_config !=3D FETCH_UPDATE_HEAD_NEVER;
> > +
> > +                     if (need_update_head)
> > +                             strvec_push(&transport_ls_refs_options.re=
f_prefixes, "HEAD");
> >                       refspec_ref_prefixes(&transport->remote->fetch,
> >                                            &transport_ls_refs_options.r=
ef_prefixes);
> > +             }
> > +
> >               if (branch_has_merge_config(branch) &&
> >                   !strcmp(branch->remote_name, transport->remote->name)=
) {
> >                       int i;
> > @@ -1737,6 +1796,9 @@ static int do_fetch(struct transport *transport,
> >
> >       commit_fetch_head(&fetch_head);
> >
> > +     if (need_update_head)
> > +             update_head(update_head_config, find_ref_by_name(remote_r=
efs, "HEAD"), transport->remote);
>
> Some overly long lines here...

Not unique in this document:

117:                                         warning(_("rejected %s
because shallow roots are not allowed to be updated"),
115:                                         warning(_("multiple
branches detected, incompatible with --set-upstream"));
112:         OPT_STRING_LIST('o', "server-option", &server_options,
N_("server-specific"), N_("option to transmit")),
111:                         need_update_head =3D update_head_config &&
update_head_config !=3D FETCH_UPDATE_HEAD_NEVER;
108:                                   "you need to specify exactly
one branch with the --set-upstream option"));
106:                         die(_("options '%s' and '%s' cannot be
used together"), "--depth", "--unshallow");
106:                 update_head(update_head_config,
find_ref_by_name(remote_refs, "HEAD"), transport->remote);
103:                                 die(_("fetching a group and
specifying refspecs does not make sense"));
103:                         die(_("options '%s' and '%s' cannot be
used together"), "--deepen", "--depth");
103:                                 warning(_("not setting upstream
for a remote remote-tracking branch"));

But I seem to recall previous discussions (perhaps in LKML) where
people accepted that lines 120-characters long are OK. We don't live
in the 80's anymore, terminals have more than 80 columns.

> > +
> >       if (set_upstream) {
> >               struct branch *branch =3D branch_get("HEAD");
> >               struct ref *rm;
> > diff --git a/remote.c b/remote.c
> > index 641b083d90..5f3a9aa53e 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -344,6 +344,25 @@ static void read_branches_file(struct remote_state=
 *remote_state,
> >       remote->fetch_tags =3D 1; /* always auto-follow */
> >  }
> >
> > +int parse_update_head(int *r, const char *var, const char *value)
> > +{
> > +     if (!r)
> > +             return -1;
> > +     else if (!value)
> > +             return config_error_nonbool(var);
> > +     else if (!strcmp(value, "never"))
> > +             *r =3D FETCH_UPDATE_HEAD_NEVER;
> > +     else if (!strcmp(value, "missing"))
> > +             *r =3D FETCH_UPDATE_HEAD_MISSING;
> > +     else if (!strcmp(value, "always"))
> > +             *r =3D FETCH_UPDATE_HEAD_ALWAYS;
>
> Ditto, this could really benefit from an enum type, instead of the bare
> "int".

What would change other than `int *r` -> `enum name *r`?

> > +     else {
> > +             error(_("malformed value for %s: %s"), var, value);
> > +             return error(_("must be one of never, missing, or always"=
));
>
> Shouldn't we use git_die_config() or similar here, to get the line
> number etc., or do we get that somehow (I can't recall).

There's plenty of `error()` in config.c, including
`git_default_push_config`, which this was based on.

> > +     }
> > +     return 0;
> > +}
> > +
> >  static int handle_config(const char *key, const char *value, void *cb)
> >  {
> >       const char *name;
> > @@ -473,6 +492,8 @@ static int handle_config(const char *key, const cha=
r *value, void *cb)
> >                                        key, value);
> >       } else if (!strcmp(subkey, "vcs")) {
> >               return git_config_string(&remote->foreign_vcs, key, value=
);
> > +     } else if (!strcmp(subkey, "updatehead")) {
> > +             return parse_update_head(&remote->update_head, key, value=
);
> >       }
> >       return 0;
> >  }
> > diff --git a/remote.h b/remote.h
> > index 73638cefeb..9dce42d65d 100644
> > --- a/remote.h
> > +++ b/remote.h
> > @@ -22,6 +22,13 @@ enum {
> >       REMOTE_BRANCHES
> >  };
> >
> > +enum {
> > +     FETCH_UPDATE_HEAD_DEFAULT =3D 0,
>
> We tend to only init these to 0 when the default being 0 matters,
> i.e. we use it as a boolean, but is that the case here?

In the current version of the code it doesn't matter, but the default
could be different later on.

For example if the default is not specified `!fetch_update_head` the
code could do some guessing, like doing "always" if the remote is a
mirror.

I learned this lesson reorganizing the options of `builtin/pull.c` in
a patch that was never merged. [1]

> > +
> >  #endif
> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > index dc44da9c79..dbeb2928ae 100755
> > --- a/t/t5510-fetch.sh
> > +++ b/t/t5510-fetch.sh
> > @@ -814,6 +814,37 @@ test_expect_success 'fetch from multiple configure=
d URLs in single remote' '
> >       git fetch multipleurls
> >  '
> >
> > +test_cmp_symbolic_ref () {
> > +     git symbolic-ref "$1" >actual &&
> > +     echo "$2" >expected &&
> > +     test_cmp expected actual
> > +}
>
> Sort of an aside, but this seems to be the Nth use of this pattern in
> the test suite, e.g. t1401-symbolic-ref.sh repeatedly hardcodes the
> same.
>
> I wonder if a prep commit to stick this in test-lib-functions.sh would
> be in order, or maybe a "--symbolic" argument to "test_cmp_rev"?

Sure. If I had incline that such a patch would be merged (or this one)
I would do it, but I have a plethora of cleanup patches just gathering
dust, so I'd rather not.

Cheers.

[1] https://lore.kernel.org/git/20210705123209.1808663-24-felipe.contreras@=
gmail.com/

--=20
Felipe Contreras
