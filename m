Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B18C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 09:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiCVJLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 05:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiCVJLh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 05:11:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126817DE32
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 02:10:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w25so20816098edi.11
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eQNCSCQyO+FbKAx2FL8xzTCLMUOzD/Mr7ZkuVq2vGGE=;
        b=NylAnG+foDnHN2rMce7oAfEYBt+/hHK9iFCBKRnyuYDM+dT+ngtzHDLR0jh7gDDFTx
         FmRpqV0eoBXj6dGlcTHua3bTnBnEilwN84Ua9FZ7Ms3uIp4CeRw7MbnhyGo5WyUq0Lhs
         Ifdxet4qwq9fq5nyUboBqVaQNywPnXxIPnx3WCAmmjx107/XD0wRQq0dP2RkXrtyLgyi
         rBJtIw9fsSw5ShT+y7PL7UxdVTM8Z1FlJJghZRLv+wtg6a3xkoje0MTQSSv2QbftR4Xa
         FSh5vl1VG9cG4Qrnex1EGlW7ZUaAwYFUFsYf0IfKjd3fS9SVH0swmPP/4Wn1N9KIBG4T
         h2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eQNCSCQyO+FbKAx2FL8xzTCLMUOzD/Mr7ZkuVq2vGGE=;
        b=OVjLyG8ipe+fwLFXUw+5o2Q1XGFPpVm97dBAtTs3HgkGLoPx/+uexFBqxfvT22yybZ
         jYJQxk8AUNq6Dnr07rcgYI3BwjJR25gQa6X6STWdB24AFaZXyh0NXu6VeG27mUs74qN2
         E9FB27UJ7lvPTfLV9vziq7QRGcOOU706ex6T8w18cfVbFAaFdY7o6xngSPtLwXhP4hFt
         ZPUlISZoFvHgGuzOQxPv4DR8x7COOZOTRT91dSFV7sv+7g9tlAj7W+Jsela7A5IR8eey
         7HkWtY8QfsaVPsnY5P6MfHbO5osOhO/Rj4Cq9sVyjVoNsjmHMjgyx6rul6tc7Nc3W0v5
         V3CA==
X-Gm-Message-State: AOAM531hh1n1PTLEATKEeuXyZYXCaSk7ldlO7I/U+6tWSX6t9bI1pyOi
        C090LWdG0jBbSXuG6JxJ6L9W+MnUU9fwmh3PTXM0xvhFR+a5rbMW
X-Google-Smtp-Source: ABdhPJx4nRDdts6qtaD7cZdBh8JJ1KvBIa6igJyHq9k655YAavUgDxISzwF33ACwXEH1MbXr7MKgpyChyNrcpbjVtJI=
X-Received: by 2002:a05:6402:2750:b0:416:29dd:1d17 with SMTP id
 z16-20020a056402275000b0041629dd1d17mr27545629edd.387.1647940208473; Tue, 22
 Mar 2022 02:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1183.git.1647858238144.gitgitgadget@gmail.com> <220321.86ee2v9xzd.gmgdl@evledraar.gmail.com>
In-Reply-To: <220321.86ee2v9xzd.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 22 Mar 2022 10:09:56 +0100
Message-ID: <CAPMMpohn59X5CWOrhGD8gGiMumUCVcTWL=4dXE92AUsHJaRvoQ@mail.gmail.com>
Subject: Re: [PATCH] tracking branches: add advice to ambiguous refspec error
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 3:33 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Mar 21 2022, Tao Klerks via GitGitGadget wrote:
>
> Re $subject (and you've got another outstanding patch on list that's the
> same), please add "RFC PATCH" to the subject for RFC patches, doesn't
> GGG have some way to do that?
>

Not as far as I can tell, not exactly. What I *could* have done, and
will do next time, is add the "RFC: " prefix to the commit subject,
after the "[PATCH]" prefix. The email subject lines are a bit
surprising (to me): When it is a single commit, the email gets the
subject line of that commit, and the subject of the "pull request"
gets buried under the triple dash, whereas a series of several commits
has the leading 0/N email with the pull request subject as email
subject.

> >      1. In this proposed patch the advice is emitted before the existin=
g
> >         die(), in order to avoid changing the exact error behavior and =
only
> >         add extra/new hint lines, but in other advise() calls I see the
> >         error being emitted before the advise() hint. Given that error(=
) and
> >         die() display different message prefixes, I'm not sure whether =
it's
> >         possible to follow the existing pattern and avoid changing the =
error
> >         itself. Should I just accept that with the new advice, the erro=
r
> >         message can and should change?
>
> You can and should use die_message() in this case, it's exactly what
> it's intended for:
>
>     int code =3D die_message(...);
>     /* maybe advice */
>     return code;
>

Got it, thx.

> >      2. In order to include the names of the conflicting remotes I am
> >         calling advise() multiple times - this is not a pattern I see
> >         elsewhere - should I be building a single message and calling
> >         advise() only once?
>
> That would make me very happy, yes :)
>
> I have some not-yet-sent patches to make a lot of this advice API less
> sucky, mainly to ensure that we always have a 1=3D1=3D1 mapping between
> config=3Ddocs=3Dcode, and to have the API itself emit the "and you can tu=
rn
> this off with XYZ config".
>
> I recently fixed the only in-tree message where we incrementally
> constructed advice() because of that, so not having another one sneak in
> would be good :)
>

This is more or less sorted, although the result (the bit I did!) is
still a bit ugly, I suspect there is a cleaner way.

> > diff --git a/advice.c b/advice.c
> > index 1dfc91d1767..686612590ec 100644
> > --- a/advice.c
> > +++ b/advice.c
> > @@ -39,6 +39,7 @@ static struct {
> >       [ADVICE_ADD_EMPTY_PATHSPEC]                     =3D { "addEmptyPa=
thspec", 1 },
> >       [ADVICE_ADD_IGNORED_FILE]                       =3D { "addIgnored=
File", 1 },
> >       [ADVICE_AM_WORK_DIR]                            =3D { "amWorkDir"=
, 1 },
> > +     [ADVICE_AMBIGUOUS_FETCH_REFSPEC]                =3D { "ambiguousF=
etchRefspec", 1 },
> >       [ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]  =3D { "checkoutAm=
biguousRemoteBranchName", 1 },
> >       [ADVICE_COMMIT_BEFORE_MERGE]                    =3D { "commitBefo=
reMerge", 1 },
> >       [ADVICE_DETACHED_HEAD]                          =3D { "detachedHe=
ad", 1 },
>
> This is missing the relevant Documentation/config/advice.txt update
>

Argh, thx.

> > diff --git a/advice.h b/advice.h
> > index 601265fd107..3d68c1a6cb4 100644
> > --- a/advice.h
> > +++ b/advice.h
> > @@ -17,6 +17,7 @@ struct string_list;
> >       ADVICE_ADD_EMPTY_PATHSPEC,
> >       ADVICE_ADD_IGNORED_FILE,
> >       ADVICE_AM_WORK_DIR,
> > +     ADVICE_AMBIGUOUS_FETCH_REFSPEC,
> >       ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
> >       ADVICE_COMMIT_BEFORE_MERGE,
> >       ADVICE_DETACHED_HEAD,
> > diff --git a/branch.c b/branch.c
> > index 5d20a2e8484..243f6d8b362 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -12,6 +12,7 @@
> >  struct tracking {
> >       struct refspec_item spec;
> >       struct string_list *srcs;
> > +     struct string_list *remotes;
> >
> > +"There are multiple remotes with fetch refspecs mapping to\n"
> > +"the tracking ref %s:\n";)
>
> "with" and "mapping to" is a bit confusing, should this say:
>
>     There are multiple remotes whole fetch refspecs map to the remote
>     tracking ref '%s'?

Works for me.

>
> (Should also have '' quotes for that in any case)
>
> >  /*
> >   * This is called when new_ref is branched off of orig_ref, and tries
> >   * to infer the settings for branch.<new_ref>.{remote,merge} from the
> > @@ -227,11 +241,14 @@ static void setup_tracking(const char *new_ref, c=
onst char *orig_ref,
> >  {
> >       struct tracking tracking;
> >       struct string_list tracking_srcs =3D STRING_LIST_INIT_DUP;
> > +     struct string_list tracking_remotes =3D STRING_LIST_INIT_DUP;
> >       int config_flags =3D quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> > +     struct string_list_item *item;
> >
> >       memset(&tracking, 0, sizeof(tracking));
> >       tracking.spec.dst =3D (char *)orig_ref;
> >       tracking.srcs =3D &tracking_srcs;
> > +     tracking.remotes =3D &tracking_remotes;
> >       if (track !=3D BRANCH_TRACK_INHERIT)
> >               for_each_remote(find_tracked_branch, &tracking);
> >       else if (inherit_tracking(&tracking, orig_ref))
>
> FWIW I find the flow with something like this a lot clearer, i.e. not
> adding the new thing to a widely-used struct, just have a CB struct for
> the one thing that needs it:
>
>         diff --git a/branch.c b/branch.c
>         index 7958a2cb08f..55520eec6bd 100644
>         --- a/branch.c
>         +++ b/branch.c
>         @@ -14,14 +14,19 @@
>          struct tracking {
>                 struct refspec_item spec;
>                 struct string_list *srcs;
>         -       struct string_list *remotes;
>                 const char *remote;
>                 int matches;
>          };
>
>         +struct find_tracked_branch_cb {
>         +       struct tracking *tracking;
>         +       struct string_list remotes;
>         +};
>         +
>          static int find_tracked_branch(struct remote *remote, void *priv=
)
>          {
>         -       struct tracking *tracking =3D priv;
>         +       struct find_tracked_branch_cb *ftb =3D priv;
>         +       struct tracking *tracking =3D ftb->tracking;
>
>                 if (!remote_find_tracking(remote, &tracking->spec)) {
>                         if (++tracking->matches =3D=3D 1) {
>         @@ -31,7 +36,7 @@ static int find_tracked_branch(struct remote *r=
emote, void *priv)
>                                 free(tracking->spec.src);
>                                 string_list_clear(tracking->srcs, 0);
>                         }
>         -               string_list_append(tracking->remotes, remote->nam=
e);
>         +               string_list_append(&ftb->remotes, remote->name);
>                         tracking->spec.src =3D NULL;
>                 }
>
>         @@ -245,16 +250,18 @@ static void setup_tracking(const char *new_=
ref, const char *orig_ref,
>          {
>                 struct tracking tracking;
>                 struct string_list tracking_srcs =3D STRING_LIST_INIT_DUP=
;
>         -       struct string_list tracking_remotes =3D STRING_LIST_INIT_=
DUP;
>                 int config_flags =3D quiet ? 0 : BRANCH_CONFIG_VERBOSE;
>                 struct string_list_item *item;
>         +       struct find_tracked_branch_cb ftb_cb =3D {
>         +               .tracking =3D &tracking,
>         +               .remotes =3D STRING_LIST_INIT_DUP,
>         +       };
>
>                 memset(&tracking, 0, sizeof(tracking));
>                 tracking.spec.dst =3D (char *)orig_ref;
>                 tracking.srcs =3D &tracking_srcs;
>         -       tracking.remotes =3D &tracking_remotes;
>                 if (track !=3D BRANCH_TRACK_INHERIT)
>         -               for_each_remote(find_tracked_branch, &tracking);
>         +               for_each_remote(find_tracked_branch, &ftb_cb);
>                 else if (inherit_tracking(&tracking, orig_ref))
>                         goto cleanup;
>
>         @@ -272,7 +279,7 @@ static void setup_tracking(const char *new_re=
f, const char *orig_ref,
>                 if (tracking.matches > 1) {
>                         if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC=
)) {
>                                 advise(_(ambiguous_refspec_advice_pre), o=
rig_ref);
>         -                       for_each_string_list_item(item, &tracking=
_remotes) {
>         +                       for_each_string_list_item(item, &ftb_cb.r=
emotes) {
>                                         advise("  %s", item->string);
>                                 }
>                                 advise(_(ambiguous_refspec_advice_post));

Lovely, applied, thx.

>
> Also missing a string_list_clear() before/after this...

Yes, sorry, I looked for "tracking_srcs" because I suspected some
cleanup was needed, but did not think to look for "tracking.srcs", or
even just scroll to the end. C takes some getting used to, for me at
least.

>
> > @@ -248,9 +265,17 @@ static void setup_tracking(const char *new_ref, co=
nst char *orig_ref,
> >                       return;
> >               }
> >
> > -     if (tracking.matches > 1)
> > +     if (tracking.matches > 1) {
> > +             if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
> > +                     advise(_(ambiguous_refspec_advice_pre), orig_ref)=
;
> > +                     for_each_string_list_item(item, &tracking_remotes=
) {
> > +                             advise("  %s", item->string);
> > +                     }
>
> See:
>
>      git show --first-parent 268e6b8d4d9
>
> For how you can avoid incrementally constructing the message. I.e. we
> could just add a strbuf to the callback struct, have the callback add to
> it.
>
> Then on second thought we get rid of the string_list entirely don't we?
> Since we just need the \n-delimited list of remotes te inject into the
> message.

Yep, applied (with some icky argument awkwardness in the final advise() cal=
l)

Reroll on the way.
