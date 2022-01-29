Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E3EC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 01:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352036AbiA2Bke (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 20:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352026AbiA2Bkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 20:40:31 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CAFC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 17:40:31 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m4so21830760ejb.9
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 17:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cqa2vxGpfLNGkjtTVi7OI2bMZR0uzHFIq495slAv5K0=;
        b=ff6/DTAttwDhenKgvsyyQkXSxg8dliTCXKhNbYViVdbQ3jfEXyE7RN/GNSRf/F/a6A
         fOLndfq7/smNNSKH36G4sFvNyEPXsD7ananxCJKP9Uwfh7iCvABw+W92mCaNeS/+p+P7
         98wnOTN562hU0Q3buKrQdq4w52lUapLveAqq8j19REhlFMp8E1bYAlzQzJjBg7KRDBLk
         5AsIi45nJ/dhlRlKAEqjhAInzqsqzRxvbafVc2xWji+axJ2zjcBS7CRFUpNwvNdooiMx
         5nsl5iPr+Toljg6KKy2SJ/xzyzJ2l7DAKGdfwWqpbxveQOZA+HD0Pw0AHhBlqNay53UX
         RuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cqa2vxGpfLNGkjtTVi7OI2bMZR0uzHFIq495slAv5K0=;
        b=Ihoi0tddgT0ODZotJv/vGu5NK5GjYpPbCrKSWzdeXRJUe7DnQIckZ6LmiaAxEX3Giy
         OlyFPZmn6j59vEvs8Y4SYEnJjKM2ahYXvnapjjfTIcaKm6lHZBkvOneY+uCTQ/LHu6ID
         NW8qvgsxm3LT8V7A2Vkto4PXqhr7xBDSGs1pCYDLOpbZOYhPvEZWkfVL7GvUGtDSXg32
         xEnDL+tSj5SGxkB+A+Q940WOjXE265d6IEl4nyNd9D1gPkQcheq5mr5grk4g+wgZKLjd
         BGb5H0Hk9c7gtlM9Mwq6JUHcgaBVpIn5OWTtjsDzliQ7toRlflQrAXoNad3Q79iSk/RU
         MopQ==
X-Gm-Message-State: AOAM531A8ncdNmhpMqYeXUZzQGu535K4SN7KPfxBaH6q37GWlvXBLK2v
        KqJV6XJtMuUl+DiGJNJdcLNT475Q6UjIPpOCY7Q=
X-Google-Smtp-Source: ABdhPJyffeLSSgT+MU43N5s+LUb18Hf86EMqChVMPQ+xgaDFLhGG9U9wUcYnEcAKIeAjJU4+qqKvTK+qgrala7LQ1Fw=
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr3421244ejc.100.1643420429506;
 Fri, 28 Jan 2022 17:40:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.1131.git.1643334969216.gitgitgadget@gmail.com> <220128.86ee4scn2s.gmgdl@evledraar.gmail.com>
In-Reply-To: <220128.86ee4scn2s.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Jan 2022 17:40:18 -0800
Message-ID: <CABPp-BEehHHbDi_muWHCaT1GvRmPbPiMmvB-2O9+0w2A+yEM0Q@mail.gmail.com>
Subject: Re: [PATCH] repo-settings: fix checking for fetch.negotiationAlgorithm=default
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Thu, Jan 27, 2022 at 11:54 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Jan 28 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > In commit 3050b6dfc75d (repo-settings.c: simplify the setup,
> > 2021-09-21), the branch for handling fetch.negotiationAlgorithm=3Ddefau=
lt
> > was deleted.  Since this value is documented in
> > Documentation/config/fetch.txt, restore the check for this value.
> >
> > Note that this change caused an observable bug: if someone sets
> > feature.experimental=3Dtrue in config, and then passes "-c
> > fetch.negotiationAlgorithm=3Ddefault" on the command line in an attempt=
 to
> > override the config, then the override is ignored.  Fix the bug by not
> > ignoring the value of "default".
>
> This fix looks good, thanks for fixing my mess.

No worries, it was a pretty tiny mess.  It was actually caught by
testing rather than by an end user.  (I hadn't updated our internal
Git distribution since before v2.34 due to various other priorities.
Since that distribution includes some patches that turn on
feature.experimental, along with one testsuite change to explicitly
request "default" handling in a test that was intended to check the
"default" behavior, when I updated the distribution, that testcase
failed.)

And you made the code in repo-settings.c *so* much nicer to read.  I
think that's more important than this little issue.

>> > Technically, before commit 3050b6dfc75d, repo-settings would treat any
> > fetch.negotiationAlgorithm value other than "skipping" or "noop" as a
> > request for "default", but I think it probably makes more sense to
> > ignore such broken requests and leave fetch.negotiationAlgorithm with
> > the default value rather than the value of "default".  (If that sounds
> > confusing, note that "default" is usually the default value, but when
> > feature.experimental=3Dtrue, "skipping" is the default value.)
> >
> > [...]
> >     A long sidenote about naming things "default":
> >
> >     Many years ago, in the Gnome community, there was a huge fight that
> >     erupted, in part due to confusion over "default". There was a journ=
alist
> >     who had been a designer in a past life, who had a little friction w=
ith
> >     the rest of the community, but intended well and generally improved
> >     things. At some point, they suggested some changes to improve the
> >     "default" theme (and they were a nice improvement), but not being a
> >     developer the changes weren't communicated in the form of a patch. =
And
> >     the changes accidentally got applied to the wrong theme: the defaul=
t one
> >     (yes, there was a theme named "default" which was not the default
> >     theme). Now, basically no one used the default theme because it was=
 so
> >     hideously ugly. I think we suffered from a case of not being able t=
o
> >     change the default (again?) because no one could get an agreement o=
n
> >     what the default should be. Who did actually use the default theme,
> >     though? The person writing the release notes (though they only used=
 it
> >     for taking screenshots to include in the release notes, and otherwi=
se
> >     used some other theme). So, with people under pressure for an immin=
ent
> >     release, there were screenshots that looked like garbage, and
> >     investigation eventually uncovered that it was due to changes that =
were
> >     meant for the "default" theme having accidentally been applied to t=
he
> >     default theme. It could have just been an amusing story if not for =
the
> >     other unfortunate factors happening around the same time and the he=
ated
> >     and protracted flamewars that erupted.
> >
> >     Don't name settings/themes/things "default" if it describes somethi=
ng
> >     specific, since someone may come along and decide that something el=
se
> >     should be the default, and then you're stuck with a non-default
> >     "default". Sadly, the name was already picked and documented so for
> >     backward compatibility we need to support it...
>
> Funny story, I think this is only going to bite us if we don't switch
> the default over along with promoting this out of feature.experimental.
>
> I.e. =3Ddefault should always be equivalent to not declaring that config
> at all anywhere, and not drift to being a reference to some name that
> happens to be "default", as in the GNOME case.

No, we have the same problem as the Gnome case.  See this part of the
documentation for fetch.negotiationAlgorithm:

"""
    The default is "default" which instructs Git to use the
    default algorithm that never skips commits (unless the server has
    acknowledged it or one of its descendants).
"""

features.experimental turns on "skipping" as the default behavior, and
that text clearly rules out the possibility that "default" could be
used to mean "skipping".  So, if that experimental feature graduates,
then the default behavior of fetch.negotiationAlgorithm will NOT be
the "default" behavior of fetch.negotationAlgorithm.

> In our case it's more of a story about the inconsistencies in our config
> space, i.e. some values you can't reset at all, some take empty values
> to do so, others "default" etc.
>
> > diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> > index f0dc4e69686..37958a376ca 100755
> > --- a/t/t5500-fetch-pack.sh
> > +++ b/t/t5500-fetch-pack.sh
> > @@ -928,6 +928,7 @@ test_expect_success 'fetching deepen' '
> >  '
> >
> >  test_expect_success 'use ref advertisement to prune "have" lines sent'=
 '
> > +     test_when_finished rm -rf clientv0 clientv2 &&
> >       rm -rf server client &&
> >       git init server &&
> >       test_commit -C server both_have_1 &&
> > @@ -960,6 +961,45 @@ test_expect_success 'use ref advertisement to prun=
e "have" lines sent' '
> >       ! grep "have $(git -C client rev-parse both_have_2^)" trace
> >  '
> >
> > +test_expect_success 'same as last but with config overrides' '
>
> Since it's the same as the preceding test, maybe we can squash this in
> to avoid the duplication? This works for me.
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 37958a376ca..3fb20eeec7e 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -927,7 +927,7 @@ test_expect_success 'fetching deepen' '
>         )
>  '
>
> -test_expect_success 'use ref advertisement to prune "have" lines sent' '
> +test_negotiation_algorithm_default () {
>         test_when_finished rm -rf clientv0 clientv2 &&
>         rm -rf server client &&
>         git init server &&
> @@ -946,7 +946,7 @@ test_expect_success 'use ref advertisement to prune "=
have" lines sent' '
>
>         rm -f trace &&
>         cp -r client clientv0 &&
> -       GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C clientv0 \
> +       GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C clientv0 $@ \
>                 fetch origin server_has both_have_2 &&
>         grep "have $(git -C client rev-parse client_has)" trace &&
>         grep "have $(git -C client rev-parse both_have_2)" trace &&
> @@ -954,50 +954,17 @@ test_expect_success 'use ref advertisement to prune=
 "have" lines sent' '
>
>         rm -f trace &&
>         cp -r client clientv2 &&
> -       GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C clientv2 -c protocol.ver=
sion=3D2 \
> +       GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C clientv2 -c protocol.ver=
sion=3D2 $@ \
>                 fetch origin server_has both_have_2 &&
>         grep "have $(git -C client rev-parse client_has)" trace &&
>         grep "have $(git -C client rev-parse both_have_2)" trace &&
>         ! grep "have $(git -C client rev-parse both_have_2^)" trace
> -'
> -
> -test_expect_success 'same as last but with config overrides' '
> -       test_when_finished rm -rf clientv0 clientv2 &&
> -       rm -rf server client &&
> -       git init server &&
> -       test_commit -C server both_have_1 &&
> -       git -C server tag -d both_have_1 &&
> -       test_commit -C server both_have_2 &&
> -
> -       git clone server client &&
> -       test_commit -C server server_has &&
> -       test_commit -C client client_has &&
> -
> -       # In both protocol v0 and v2, ensure that the parent of both_have=
_2 is
> -       # not sent as a "have" line. The client should know that the serv=
er has
> -       # both_have_2, so it only needs to inform the server that it has
> -       # both_have_2, and the server can infer the rest.
> -
> -       rm -f trace &&
> -       rm -rf clientv0 &&
> -       cp -r client clientv0 &&
> -       GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C clientv0 \
> -               -c feature.experimental=3Dtrue \
> -               -c fetch.negotiationAlgorithm=3Ddefault \
> -               fetch origin server_has both_have_2 &&
> -       grep "have $(git -C client rev-parse client_has)" trace &&
> -       grep "have $(git -C client rev-parse both_have_2)" trace &&
> -       ! grep "have $(git -C client rev-parse both_have_2^)" trace &&
> +}
>
> -       rm -f trace &&
> -       cp -r client clientv2 &&
> -       GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C clientv2 -c protocol.ver=
sion=3D2 \
> +test_expect_success 'use ref advertisement to prune "have" lines sent' '
> +       test_negotiation_algorithm_default \
>                 -c feature.experimental=3Dtrue \
> -               -c fetch.negotiationAlgorithm=3Ddefault \
> -               fetch origin server_has both_have_2 &&
> -       grep "have $(git -C client rev-parse client_has)" trace &&
> -       grep "have $(git -C client rev-parse both_have_2)" trace &&
> -       ! grep "have $(git -C client rev-parse both_have_2^)" trace
> +               -c fetch.negotiationAlgorithm=3Ddefault

I think you accidentally dropped one of the two tests by turning it
into a function and then only calling it for the latter usage and not
the former, but I get your idea.  It makes sense; I'll make the
change.
