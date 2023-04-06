Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC71C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjDFIEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjDFIEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:04:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A707EF4
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:03:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w9so147310908edc.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680768212;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y/IbtJuSdOMiF1+kTSLuBcZ2+gFaaX22sREy0k1NY5o=;
        b=mJQ/0ML03rdx6W/N8f26hqE0JDduUaQ6VxSiTBh9mbK4HAPC0lLDfC9CAOBMOW/zuj
         v496oHE5cvswPlBOtV0TiXxJzG0XpZ2YoSoZ7fXFpp+g+9JQG1VW3kLk6tJm6sQuQdZx
         yliiMlRzukJG/Gx5g96bnglRJ4jVQJs1WfFSMhDPrwOQbBgTqIDxEG8HQz4C0dGCP8cZ
         5wATAZNS1Q9Bw4jOgjMrdV7fIXCjEOORUyWLvsSyNlDrVCML+Vk9jia4nPc6x04snHgQ
         LSoTzo3Z/DaZyWXlOeeESmE/vQ0ayU4+h+lItIxa3pgSVlruOYklHraYoYmTm7fWBKvH
         pp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680768212;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/IbtJuSdOMiF1+kTSLuBcZ2+gFaaX22sREy0k1NY5o=;
        b=FRb9Gaa8JfZdPKxyLMRU88PODY/RhM4wbiKo51vgRhANhC7bR0DbrmNvy2h/9tVN78
         8BLpJNToW/GgDgZdAzcMiYeWklssDBYgQ63tVaOJLh6uVk4rcSG2tZ11s2UaNiEvu8TA
         IDvqslD96KSyYGBqemotRXfoZ4l3jI+/+VUSHK+zSg1A5uZUWs3q2fsnrsQdmzCsuAVq
         MS4VsaedEIui/b0fNvyuQ7okFI6jc4ASSAnqZyjxEV8u9Sts3KRwhNwF4vzOodPXmkqo
         COkhQ/ZDXNZ+e5lh1wzR5Vm99zZE7JkCUgVcRI3b3nxpDX5vbjP0cCacA3fegLJWRl9c
         SprQ==
X-Gm-Message-State: AAQBX9fRwgoBpc2CgEMKWXMmu6oqzynYF/7jJi+HATfUTbiZecgvaGrA
        iJxz+im/dG5GA/JlklP8viNPwuzLPhM=
X-Google-Smtp-Source: AKy350aS98doCGhXHNUOIVgVVUcHdsDgcywSiF4T7BssoaA2pbc1WLGVN9G0L6xD0UqmEk9Q4WJM0A==
X-Received: by 2002:a17:906:eca8:b0:947:3d04:61dc with SMTP id qh8-20020a170906eca800b009473d0461dcmr5098221ejb.77.1680768211715;
        Thu, 06 Apr 2023 01:03:31 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b16-20020a50b410000000b004c5d1a15bd5sm378065edh.69.2023.04.06.01.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:03:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pkKag-005Ngz-1o;
        Thu, 06 Apr 2023 10:03:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Daniel =?utf-8?Q?Mart?= =?utf-8?Q?=C3=AD?= <mvdan@mvdan.cc>
Subject: Re: [PATCH 1/2] Add fetch.updateHead option
Date:   Thu, 06 Apr 2023 09:33:55 +0200
References: <20230405012742.2452208-1-felipe.contreras@gmail.com>
 <20230405012742.2452208-2-felipe.contreras@gmail.com>
 <230405.86fs9evfte.gmgdl@evledraar.gmail.com>
 <CAMP44s0oBKfp6bXbg_+vp4CuRj_nh8uDBTCeT65z7UCUzj4K0Q@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CAMP44s0oBKfp6bXbg_+vp4CuRj_nh8uDBTCeT65z7UCUzj4K0Q@mail.gmail.com>
Message-ID: <230406.867cupv3n1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 05 2023, Felipe Contreras wrote:

> On Wed, Apr 5, 2023 at 4:28=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason <avarab@gmail.com> wrote:
>>
>>
>> On Tue, Apr 04 2023, Felipe Contreras wrote:
>>
>> > Users might change the behavior when running "git fetch" so that the
>> > remote's HEAD symbolic ref is updated at certain point.
>> >
>> > For example after running "git remote add" the remote HEAD is not
>> > set like it is with "git clone".
>> >
>> > Setting "fetch.updatehead =3D missing" would probably be a sensible
>> > default that everyone would want, but for now the default behavior is =
to
>> > never update HEAD, so there shouldn't be any functional changes.
>> >
>> > For the next major version of Git, we might want to change this defaul=
t.
>> >
>> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> > ---
>> >  Documentation/config/fetch.txt  |  4 +++
>> >  Documentation/config/remote.txt |  3 ++
>> >  builtin/fetch.c                 | 64 ++++++++++++++++++++++++++++++++-
>> >  remote.c                        | 21 +++++++++++
>> >  remote.h                        | 11 ++++++
>> >  t/t5510-fetch.sh                | 31 ++++++++++++++++
>> >  6 files changed, 133 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/config/fetch.txt b/Documentation/config/fet=
ch.txt
>> > index 568f0f75b3..dc147ffb35 100644
>> > --- a/Documentation/config/fetch.txt
>> > +++ b/Documentation/config/fetch.txt
>> > @@ -120,3 +120,7 @@ fetch.bundleCreationToken::
>> >  The creation token values are chosen by the provider serving the spec=
ific
>> >  bundle URI. If you modify the URI at `fetch.bundleURI`, then be sure =
to
>> >  remove the value for the `fetch.bundleCreationToken` value before fet=
ching.
>> > +
>> > +fetch.updateHead::
>> > +     Defines when to update the remote HEAD symbolic ref. Values are =
'never',
>> > +     'missing' (update only when HEAD is missing), and 'always'.
>> > diff --git a/Documentation/config/remote.txt b/Documentation/config/re=
mote.txt
>> > index 0678b4bcfe..9d739d2ed4 100644
>> > --- a/Documentation/config/remote.txt
>> > +++ b/Documentation/config/remote.txt
>> > @@ -86,3 +86,6 @@ remote.<name>.partialclonefilter::
>> >       Changing or clearing this value will only affect fetches for new=
 commits.
>> >       To fetch associated objects for commits already present in the l=
ocal object
>> >       database, use the `--refetch` option of linkgit:git-fetch[1].
>> > +
>> > +remote.<name>.updateHead::
>> > +     Defines when to update the remote HEAD symbolic ref. See `fetch.=
updateHead`.
>> > diff --git a/builtin/fetch.c b/builtin/fetch.c
>> > index 7221e57f35..7e93a1aa46 100644
>> > --- a/builtin/fetch.c
>> > +++ b/builtin/fetch.c
>> > @@ -59,6 +59,8 @@ static int fetch_prune_tags_config =3D -1; /* unspec=
ified */
>> >  static int prune_tags =3D -1; /* unspecified */
>> >  #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
>> >
>> > +static int fetch_update_head =3D FETCH_UPDATE_HEAD_DEFAULT;
>> > +
>> >  static int all, append, dry_run, force, keep, multiple, update_head_o=
k;
>> >  static int write_fetch_head =3D 1;
>> >  static int verbosity, deepen_relative, set_upstream, refetch;
>> > @@ -129,6 +131,9 @@ static int git_fetch_config(const char *k, const c=
har *v, void *cb)
>> >               return 0;
>> >       }
>> >
>> > +     if (!strcmp(k, "fetch.updatehead"))
>> > +             return parse_update_head(&fetch_update_head, k, v);
>> > +
>> >       return git_default_config(k, v, cb);
>> >  }
>> >
>> > @@ -1579,6 +1584,47 @@ static int backfill_tags(struct transport *tran=
sport,
>> >       return retcode;
>> >  }
>> >
>> > +static void update_head(int config, const struct ref *head, const str=
uct remote *remote)
>>
>> Here you pass a "const struct remote".
>>
>> > +{
>> > +     char *ref, *target;
>> > +     const char *r;
>> > +     int flags;
>> > +
>> > +     if (!head || !head->symref || !remote)
>> > +             return;
>> > +
>> > +     ref =3D apply_refspecs((struct refspec *)&remote->fetch, "refs/h=
eads/HEAD");
>> > +     target =3D apply_refspecs((struct refspec *)&remote->fetch, head=
->symref);
>>
>> But here we end up with this cast, as it's not const after all, we're
>> modifying it.
>
> It is a const, and we are not modifying it. `apply_refspecs()` is not
> saying what it should say: the refspec remains constant.
>
> As Patrick explained: `apply_refspecs()` should probably be fixed.

Yes, that's a much better fix. I'd assumed that we were altering it, but
a prep change like that to give it "const" would be much better, then we
can avoid the cast.

>> > +
>> > +     if (!ref || !target) {
>> > +             warning(_("could not update remote head"));
>> > +             return;
>> > +     }
>> > +
>> > +     r =3D resolve_ref_unsafe(ref, 0, NULL, &flags);
>> > +
>> > +     if (r) {
>> > +             if (config =3D=3D FETCH_UPDATE_HEAD_MISSING) {
>> > +                     if (flags & REF_ISSYMREF)
>> > +                             /* already present */
>> > +                             return;
>> > +             } else if (config =3D=3D FETCH_UPDATE_HEAD_ALWAYS) {
>> > +                     if (!strcmp(r, target))
>> > +                             /* already up-to-date */
>> > +                             return;
>>
>> I think you should name the "enum" you're adding below, the one that
>> contains the new "FETCH_UPDATE_HEAD_DEFAULT".
>>
>> Then this could be a "switch", and the compiler could check the
>> arguments, i.e. you could pass an enum type instead of an "int".
>
> Sure, it can be an `enum fetch_update_mode` instead of `int`, but I
> don't see what value it provides, other than more verbosity. The enum
> right above is also unnamed, and 'remote->origin' is an int. And it's
> not the only enum of that kind in the source code.
>
> Using a switch is better, but that doesn't require an enum type. The
> multiple ifs are just a remnant of a previous version of the code.

More on this below, but it's for self-documentation (makes the code
easier to follow), and the compiler can notice missing "case" arms,
which isn't the case with an "int".

>> > +             } else
>>
>> {} missing, if you keep this, but...
>>
>> > +                     /* should never happen */
>> > +                     return;
>>
>> ...so, here we're not checking some enum values, but presumably other
>> things check this, I haven't checked.
>
> Yes, the function cannot be called otherwise.

...more on this below...
>
>> But for a "should never happen", should we make this a "BUG()", or is it
>> user-controlled?
>
> Sure, it can be a `BUG()`. It truly should not happen.

...more on this below...

>> > +     }
>> > +
>> > +     if (!create_symref(ref, target, "remote update head")) {
>> > +             if (verbosity >=3D 0)
>> > +                     printf(_("Updated remote '%s' HEAD\n"), remote->=
name);
>> > +     } else {
>> > +             warning(_("could not update remote head"));
>> > +     }
>> > +}
>> > +
>> >  static int do_fetch(struct transport *transport,
>> >                   struct refspec *rs)
>> >  {
>> > @@ -1592,6 +1638,7 @@ static int do_fetch(struct transport *transport,
>> >       int must_list_refs =3D 1;
>> >       struct fetch_head fetch_head =3D { 0 };
>> >       struct strbuf err =3D STRBUF_INIT;
>> > +     int need_update_head =3D 0, update_head_config =3D 0;
>> >
>> >       if (tags =3D=3D TAGS_DEFAULT) {
>> >               if (transport->remote->fetch_tags =3D=3D 2)
>> > @@ -1626,9 +1673,21 @@ static int do_fetch(struct transport *transport,
>> >       } else {
>> >               struct branch *branch =3D branch_get(NULL);
>> >
>> > -             if (transport->remote->fetch.nr)
>> > +             if (transport->remote->fetch.nr) {
>> > +
>> > +                     if (transport->remote->update_head)
>> > +                             update_head_config =3D transport->remote=
->update_head;
>> > +                     else
>> > +                             update_head_config =3D fetch_update_head;
>> > +
>> > +                     need_update_head =3D update_head_config && updat=
e_head_config !=3D FETCH_UPDATE_HEAD_NEVER;
>> > +
>> > +                     if (need_update_head)
>> > +                             strvec_push(&transport_ls_refs_options.r=
ef_prefixes, "HEAD");
>> >                       refspec_ref_prefixes(&transport->remote->fetch,
>> >                                            &transport_ls_refs_options.=
ref_prefixes);
>> > +             }
>> > +
>> >               if (branch_has_merge_config(branch) &&
>> >                   !strcmp(branch->remote_name, transport->remote->name=
)) {
>> >                       int i;
>> > @@ -1737,6 +1796,9 @@ static int do_fetch(struct transport *transport,
>> >
>> >       commit_fetch_head(&fetch_head);
>> >
>> > +     if (need_update_head)
>> > +             update_head(update_head_config, find_ref_by_name(remote_=
refs, "HEAD"), transport->remote);
>>
>> Some overly long lines here...
>
> Not unique in this document:

Yes...

> 117:                                         warning(_("rejected %s
> because shallow roots are not allowed to be updated"),
> 115:                                         warning(_("multiple
> branches detected, incompatible with --set-upstream"));
> 112:         OPT_STRING_LIST('o', "server-option", &server_options,
> N_("server-specific"), N_("option to transmit")),

...I think we have an informal exception for longer strings more often than=
 not...

> 111:                         need_update_head =3D update_head_config &&
> update_head_config !=3D FETCH_UPDATE_HEAD_NEVER;

...here's another thing you're adding in these proposed patches, so that do=
esn't really count...

> 108:                                   "you need to specify exactly
> one branch with the --set-upstream option"));
> 106:                         die(_("options '%s' and '%s' cannot be
> used together"), "--depth", "--unshallow");

..more strings...

> 106:                 update_head(update_head_config,
> find_ref_by_name(remote_refs, "HEAD"), transport->remote);

...ditto stuff you're adding...

> 103:                                 die(_("fetching a group and
> specifying refspecs does not make sense"));
> 103:                         die(_("options '%s' and '%s' cannot be
> used together"), "--deepen", "--depth");
> 103:                                 warning(_("not setting upstream
> for a remote remote-tracking branch"));

...some strings...

> But I seem to recall previous discussions (perhaps in LKML) where
> people accepted that lines 120-characters long are OK. We don't live
> in the 80's anymore, terminals have more than 80 columns.

I don't know what the kernel does, but we try to conform to our
CodingGuidelines, which sets a limit of 80.

But whatever else we do, we don't generally say that a newly added
function to a given file should be exempted from the preferred coding
style because the file isn't consistently using it.

>> > +
>> >       if (set_upstream) {
>> >               struct branch *branch =3D branch_get("HEAD");
>> >               struct ref *rm;
>> > diff --git a/remote.c b/remote.c
>> > index 641b083d90..5f3a9aa53e 100644
>> > --- a/remote.c
>> > +++ b/remote.c
>> > @@ -344,6 +344,25 @@ static void read_branches_file(struct remote_stat=
e *remote_state,
>> >       remote->fetch_tags =3D 1; /* always auto-follow */
>> >  }
>> >
>> > +int parse_update_head(int *r, const char *var, const char *value)
>> > +{
>> > +     if (!r)
>> > +             return -1;
>> > +     else if (!value)
>> > +             return config_error_nonbool(var);
>> > +     else if (!strcmp(value, "never"))
>> > +             *r =3D FETCH_UPDATE_HEAD_NEVER;
>> > +     else if (!strcmp(value, "missing"))
>> > +             *r =3D FETCH_UPDATE_HEAD_MISSING;
>> > +     else if (!strcmp(value, "always"))
>> > +             *r =3D FETCH_UPDATE_HEAD_ALWAYS;
>>
>> Ditto, this could really benefit from an enum type, instead of the bare
>> "int".
>
> What would change other than `int *r` -> `enum name *r`?

More on that below...

>> > +     else {
>> > +             error(_("malformed value for %s: %s"), var, value);
>> > +             return error(_("must be one of never, missing, or always=
"));
>>
>> Shouldn't we use git_die_config() or similar here, to get the line
>> number etc., or do we get that somehow (I can't recall).
>
> There's plenty of `error()` in config.c, including
> `git_default_push_config`, which this was based on.

Ah, I see in these cases the config API handles emitting the bad line
number, nevermind.

As an aside, I think we could avoid some of these "malformed value" if
we just made git_die_config_linenr() slighly smarter, and had it print
the bad value in cases where there's only one value, but that's
unrelated.

>> > +     }
>> > +     return 0;
>> > +}
>> > +
>> >  static int handle_config(const char *key, const char *value, void *cb)
>> >  {
>> >       const char *name;
>> > @@ -473,6 +492,8 @@ static int handle_config(const char *key, const ch=
ar *value, void *cb)
>> >                                        key, value);
>> >       } else if (!strcmp(subkey, "vcs")) {
>> >               return git_config_string(&remote->foreign_vcs, key, valu=
e);
>> > +     } else if (!strcmp(subkey, "updatehead")) {
>> > +             return parse_update_head(&remote->update_head, key, valu=
e);
>> >       }
>> >       return 0;
>> >  }
>> > diff --git a/remote.h b/remote.h
>> > index 73638cefeb..9dce42d65d 100644
>> > --- a/remote.h
>> > +++ b/remote.h
>> > @@ -22,6 +22,13 @@ enum {
>> >       REMOTE_BRANCHES
>> >  };
>> >
>> > +enum {
>> > +     FETCH_UPDATE_HEAD_DEFAULT =3D 0,
>>
>> We tend to only init these to 0 when the default being 0 matters,
>> i.e. we use it as a boolean, but is that the case here?
>
> In the current version of the code it doesn't matter, but the default
> could be different later on.
>
> For example if the default is not specified `!fetch_update_head` the
> code could do some guessing, like doing "always" if the remote is a
> mirror.
>
> I learned this lesson reorganizing the options of `builtin/pull.c` in
> a patch that was never merged. [1]
>
>> > +
>> >  #endif
>> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> > index dc44da9c79..dbeb2928ae 100755
>> > --- a/t/t5510-fetch.sh
>> > +++ b/t/t5510-fetch.sh
>> > @@ -814,6 +814,37 @@ test_expect_success 'fetch from multiple configur=
ed URLs in single remote' '
>> >       git fetch multipleurls
>> >  '
>> >
>> > +test_cmp_symbolic_ref () {
>> > +     git symbolic-ref "$1" >actual &&
>> > +     echo "$2" >expected &&
>> > +     test_cmp expected actual
>> > +}
>>
>> Sort of an aside, but this seems to be the Nth use of this pattern in
>> the test suite, e.g. t1401-symbolic-ref.sh repeatedly hardcodes the
>> same.
>>
>> I wonder if a prep commit to stick this in test-lib-functions.sh would
>> be in order, or maybe a "--symbolic" argument to "test_cmp_rev"?
>
> Sure. If I had incline that such a patch would be merged (or this one)
> I would do it, but I have a plethora of cleanup patches just gathering
> dust, so I'd rather not.

Fair enough, thanks.

Re the "more below" above, I tried hacking some of what I suggested
upthread on top of your patches, here's the result of
that. Changes/commentary:

 * Switched the "int" to "enum"

 * You've prepared the parse_update_head() to accept a NULL "r", but as
   this & your other code shows, we never pass it NULL. I don't get why
   we'd have it handle that case, as surely all plausible users are
   "populate this config variable for me", no?

 * I think better than a BUG() call in the new update_head() we should
   just drop "need_update_head" entirely. It ends up just being a
   variable that states "is missing or always", so for update_head() we
   can just pass a boolean "missing?".

   The two added "switch" statements are a bit verbose, I mainly
   included them to show what the pre-image is implicitly assuming with
   the "update_head_config && ...", and that you init the
   "update_head_config" to "0", instead of using
   "FETCH_UPDATE_HEAD_DEFAULT".

 * I renamed "update_head" to "fetch_update_head" just to have the
   compiler catch cases where we were using the old "int", but if you
   find some of this useful we could keep the old name.

Hope some of that helps.

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6bf147b0123..6492e88d779 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -59,7 +59,7 @@ static int fetch_prune_tags_config =3D -1; /* unspecified=
 */
 static int prune_tags =3D -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
=20
-static int fetch_update_head =3D FETCH_UPDATE_HEAD_DEFAULT;
+static enum fetch_update_head fetch_update_head =3D FETCH_UPDATE_HEAD_DEFA=
ULT;
=20
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
 static int write_fetch_head =3D 1;
@@ -1584,7 +1584,8 @@ static int backfill_tags(struct transport *transport,
 	return retcode;
 }
=20
-static void update_head(int config, const struct ref *head, const struct r=
emote *remote)
+static void update_head(int fetch_missing, const struct ref *head,
+			struct remote *remote)
 {
 	char *ref, *target;
 	const char *r;
@@ -1594,7 +1595,7 @@ static void update_head(int config, const struct ref =
*head, const struct remote
 		return;
=20
 	if (!remote->mirror) {
-		ref =3D apply_refspecs((struct refspec *)&remote->fetch, "refs/heads/HEA=
D");
+		ref =3D apply_refspecs(&remote->fetch, "refs/heads/HEAD");
 		target =3D apply_refspecs((struct refspec *)&remote->fetch, head->symref=
);
=20
 		if (!ref || !target) {
@@ -1609,17 +1610,14 @@ static void update_head(int config, const struct re=
f *head, const struct remote
 	r =3D resolve_ref_unsafe(ref, 0, NULL, &flags);
=20
 	if (r) {
-		if (config =3D=3D FETCH_UPDATE_HEAD_MISSING) {
+		if (fetch_missing) {
 			if (flags & REF_ISSYMREF)
 				/* already present */
 				return;
-		} else if (config =3D=3D FETCH_UPDATE_HEAD_ALWAYS) {
-			if (!strcmp(r, target))
-				/* already up-to-date */
-				return;
-		} else
-			/* should never happen */
+		} else if (!strcmp(r, target)) {
+			/* already up-to-date */
 			return;
+		}
 	}
=20
 	if (!create_symref(ref, target, "remote update head")) {
@@ -1643,7 +1641,7 @@ static int do_fetch(struct transport *transport,
 	int must_list_refs =3D 1;
 	struct fetch_head fetch_head =3D { 0 };
 	struct strbuf err =3D STRBUF_INIT;
-	int need_update_head =3D 0, update_head_config =3D 0;
+	enum fetch_update_head update_head_config =3D FETCH_UPDATE_HEAD_DEFAULT;
=20
 	if (tags =3D=3D TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags =3D=3D 2)
@@ -1680,15 +1678,19 @@ static int do_fetch(struct transport *transport,
=20
 		if (transport->remote->fetch.nr) {
=20
-			if (transport->remote->update_head)
-				update_head_config =3D transport->remote->update_head;
+			if (transport->remote->fetch_update_head !=3D FETCH_UPDATE_HEAD_DEFAULT)
+				update_head_config =3D transport->remote->fetch_update_head;
 			else
 				update_head_config =3D fetch_update_head;
=20
-			need_update_head =3D update_head_config && update_head_config !=3D FETC=
H_UPDATE_HEAD_NEVER;
-
-			if (need_update_head)
+			switch (update_head_config) {
+			case FETCH_UPDATE_HEAD_MISSING:
+			case FETCH_UPDATE_HEAD_ALWAYS:
 				strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+			case FETCH_UPDATE_HEAD_DEFAULT:
+			case FETCH_UPDATE_HEAD_NEVER:
+				break;
+			}
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
 		}
@@ -1801,8 +1803,16 @@ static int do_fetch(struct transport *transport,
=20
 	commit_fetch_head(&fetch_head);
=20
-	if (need_update_head)
-		update_head(update_head_config, find_ref_by_name(remote_refs, "HEAD"), t=
ransport->remote);
+	switch (update_head_config) {
+	case FETCH_UPDATE_HEAD_MISSING:
+	case FETCH_UPDATE_HEAD_ALWAYS:
+		update_head(update_head_config =3D=3D FETCH_UPDATE_HEAD_MISSING,
+			    find_ref_by_name(remote_refs, "HEAD"),
+			    transport->remote);
+	case FETCH_UPDATE_HEAD_DEFAULT:
+	case FETCH_UPDATE_HEAD_NEVER:
+		break;
+	}
=20
 	if (set_upstream) {
 		struct branch *branch =3D branch_get("HEAD");
diff --git a/remote.c b/remote.c
index 5f3a9aa53ec..c05c344d806 100644
--- a/remote.c
+++ b/remote.c
@@ -344,11 +344,10 @@ static void read_branches_file(struct remote_state *r=
emote_state,
 	remote->fetch_tags =3D 1; /* always auto-follow */
 }
=20
-int parse_update_head(int *r, const char *var, const char *value)
+int parse_update_head(enum fetch_update_head *r, const char *var,
+		      const char *value)
 {
-	if (!r)
-		return -1;
-	else if (!value)
+	if (!value)
 		return config_error_nonbool(var);
 	else if (!strcmp(value, "never"))
 		*r =3D FETCH_UPDATE_HEAD_NEVER;
@@ -493,7 +492,8 @@ static int handle_config(const char *key, const char *v=
alue, void *cb)
 	} else if (!strcmp(subkey, "vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
 	} else if (!strcmp(subkey, "updatehead")) {
-		return parse_update_head(&remote->update_head, key, value);
+		return parse_update_head(&remote->fetch_update_head, key,
+					 value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 9dce42d65d0..80b8cc24b6b 100644
--- a/remote.h
+++ b/remote.h
@@ -22,8 +22,8 @@ enum {
 	REMOTE_BRANCHES
 };
=20
-enum {
-	FETCH_UPDATE_HEAD_DEFAULT =3D 0,
+enum fetch_update_head {
+	FETCH_UPDATE_HEAD_DEFAULT,
 	FETCH_UPDATE_HEAD_NEVER,
 	FETCH_UPDATE_HEAD_MISSING,
 	FETCH_UPDATE_HEAD_ALWAYS,
@@ -104,7 +104,7 @@ struct remote {
 	int prune;
 	int prune_tags;
=20
-	int update_head;
+	enum fetch_update_head fetch_update_head;
=20
 	/**
 	 * The configured helper programs to run on the remote side, for
@@ -458,6 +458,7 @@ void apply_push_cas(struct push_cas_option *, struct re=
mote *, struct ref *);
 char *relative_url(const char *remote_url, const char *url,
 		   const char *up_path);
=20
-int parse_update_head(int *r, const char *var, const char *value);
+int parse_update_head(enum fetch_update_head *r, const char *var,
+		      const char *value);
=20
 #endif
