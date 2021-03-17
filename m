Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FC7C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 08:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805C164F8F
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 08:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCQIIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 04:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCQII3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 04:08:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAB8C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 01:08:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w18so1158060edc.0
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NQdFP3m5vIbSh+WaVPrV2PsmxucDtDYntCR/ZLOfeZY=;
        b=ioupAf5ku/x4N4Cldcjf0ylXTqqvEB89C7pBCvxJ2DeHHjYoIIUSGpOHHkwd9vwqfs
         TvdhCeI3W0zg89LLlSqpXNduhupKf81LCQN7BhfHDUp5BcMMHoioFG/CIL68+Ngn2gaj
         oOb+ZUTcXiERuQbV25iUQ6t+MO2N+/0RFjd6sEWhMuPnYbN1RGzILK9380mtVDW7qJq3
         mgWELFFq64W/ZMDzq+7wHT7VBdEuDG8Tz5Rt2aV2XW/258uLDLtpquM67IL2XxPiTbjZ
         pfZKRFWh2h2wG4Ff50AodB6vlKULGtJubVwfpniuKkORdxJbfyI91oc+9SLStyLeMJBJ
         BIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=NQdFP3m5vIbSh+WaVPrV2PsmxucDtDYntCR/ZLOfeZY=;
        b=i6wB3XzmHXpTnPQniP3ZvytiJaSznwB178JF10OOXZUeO+d5/2t7zImwKD648IQS4G
         PQpMZObnafMfQIICNy2tCMb7cRf2RURi7ac7+UxjQb/mfs2C9UoJCsHKpbMuPGNhx97n
         rPTINgHHZHvty/IdbwI4+RPbUEK0TByn5bqVFxoDDsKF4J+PrM4NJroln6HSvC54VKxc
         flqU+OF1rv3B2eKjmFr+4Y1dvz5y8FvjDco2QUyJKRvvRgKG4+du4d91C8ZH8k3lYV4h
         8CKGGhRau/Xd8MiIBpgGIz5p+T/t/ePcTdjZ0l/ZzXrmTJ29C/MsibfJ7VKx5c3Y6/Nn
         /Iuw==
X-Gm-Message-State: AOAM532OpUEYYAI3j9UkserSFc9xZS2ZOFf8NN2OduKN2equZbC/ftCF
        ZVigGLnAu6cVsFls6bBj2dNwzGRX23d1Kg==
X-Google-Smtp-Source: ABdhPJz5zjnxcEm3f9lSmL1YmeYIa/48XsGqu4KCNgNDxEaSnCnKItTAuzZG8ZjLfEnNogb5E8bs2g==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr40289920edr.263.1615968507540;
        Wed, 17 Mar 2021 01:08:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j14sm11708512edr.97.2021.03.17.01.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:08:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH v8 1/2] [GSOC] commit: add --trailer option
References: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
 <pull.901.v8.git.1615813658.gitgitgadget@gmail.com>
 <f81b6e66a6ba6b2fc8e6307dbc5fba9cddcff181.1615813658.git.gitgitgadget@gmail.com>
 <87zgz3dzvl.fsf@evledraar.gmail.com>
 <CAOLTT8RyCvs8bbedPaRSo44o566Tk1MK9BeLx=-APnFsHJtejw@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAOLTT8RyCvs8bbedPaRSo44o566Tk1MK9BeLx=-APnFsHJtejw@mail.gmail.com>
Date:   Wed, 17 Mar 2021 09:08:26 +0100
Message-ID: <87wnu6dwxx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 17 2021, ZheNing Hu wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=
=E5=B9=B43=E6=9C=8816=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=888:52=E5=
=86=99=E9=81=93=EF=BC=9A
>> > +             if (run_command(&run_trailer))
>> > +                     strvec_clear(&run_trailer.args);
>>
>> This is git-commit, shouldn't we die() here instead of ignoring errors
>> in sub-processes?
>
> After thinking about it carefully, your opinion is more
> reasonable, because if the user uses the wrong `--trailer`
> and does not get the information he needs, I think he will
> have to use `--amend` to modify, and `die()` can exit
> this commit directly.

Yeah, we don't want to silently lose data.

>>
>> > +             strvec_clear(&trailer_args);
>> > +     }
>> > +
>> >       /*
>> >        * Reject an attempt to record a non-merge empty commit without
>> >        * explicit --allow-empty. In the cherry-pick case, it may be
>> > @@ -1507,6 +1529,7 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
>> >               OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_(=
"use autosquash formatted message to fixup specified commit")),
>> >               OPT_STRING(0, "squash", &squash_message, N_("commit"), N=
_("use autosquash formatted message to squash specified commit")),
>> >               OPT_BOOL(0, "reset-author", &renew_authorship, N_("the c=
ommit is authored by me now (used with -C/-c/--amend)")),
>> > +             OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("tr=
ailer(s) to add"), PARSE_OPT_NONEG, opt_pass_trailer),
>> >               OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-=
by trailer")),
>>
>> Not required for this change, but perhaps a change here to N_() (if we
>> can get it to fit) + doc update saying that we prefer
>> --trailer=3D"Signed-Off-By: to --signoff"? More on that later.
>>
>> >               OPT_FILENAME('t', "template", &template_file, N_("use sp=
ecified template file")),
>> >               OPT_BOOL('e', "edit", &edit_flag, N_("force edit of comm=
it")),
>> > diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
>> > index 6396897cc818..0acf23799931 100755
>> > --- a/t/t7502-commit-porcelain.sh
>> > +++ b/t/t7502-commit-porcelain.sh
>> > @@ -154,6 +154,26 @@ test_expect_success 'sign off' '
>> >
>> >  '
>> >
>> > +test_expect_success 'trailer' '
>> > +     >file1 &&
>> > +     git add file1 &&
>> > +     git commit -s --trailer "Signed-off-by:C O Mitter1 <committer1@e=
xample.com>" \
>> > +             --trailer "Helped-by:C O Mitter2 <committer2@example.com=
>"  \
>> > +             --trailer "Reported-by:C O Mitter3 <committer3@example.c=
om>" \
>> > +             --trailer "Mentored-by:C O Mitter4 <committer4@example.c=
om>" \
>> > +             -m "hello" &&
>> > +     git cat-file commit HEAD >commit.msg &&
>> > +     sed -e "1,7d" commit.msg >actual &&
>> > +     cat >expected <<-\EOF &&
>> > +     Signed-off-by: C O Mitter <committer@example.com>
>> > +     Signed-off-by: C O Mitter1 <committer1@example.com>
>> > +     Helped-by: C O Mitter2 <committer2@example.com>
>> > +     Reported-by: C O Mitter3 <committer3@example.com>
>> > +     Mentored-by: C O Mitter4 <committer4@example.com>
>> > +     EOF
>> > +     test_cmp expected actual
>> > +'
>> > +
>>
>> How does this interact with cases where the user has configured
>> "trailer.separators" to have a value that doesn't contain ":"?  I
>> haven't tested, but my reading of git-interpret-trailers(1) is that if
>> you supplied "=3D" instead that case would just work:
>>
>>     By default only : is recognized as a trailer separator, except that
>>     =3D is always accepted on the command line for compatibility with
>>     other git commands.
>>
> But interpret_trailers interface allow us use "=3D" instead of other sepa=
rators.
>
> I did a simple test and modified the configuration "trailer.separators"
> and it still works. Now things are good here:
>
> $ git -c trailer.separators=3D"@" commit --trailer=3D"Signed-off-by=3DC O=
 <email>"
>
> or
>
> $ git -c trailer.separators=3D"@" commit --trailer=3D"Signed-off-by@C O <=
email>"
>
> Both can work normally,
>
> --trailer=3D"Signed-off-by@ C O <email>"
>
> will output in the commit message.
>
>> I don't know if that does the right thing in the presence of
>> --if-exists=3Dadd.
>>
>
> Yesterday, Christian Couder and I had already discussed this issue:
> Your idea is correct, I should not add "--if-exists =3D add",  this will =
destroy
> the user's rights to configure by using `git -c trailer.if-exist`.
>
>> So it would be good to update these tests so you test:
>>
>>  * For the --if-exists=3Dadd case at all, there's no tests for it
>>    now. I.e. add some trailers manually to the commit (via -F or
>>    whatever) and then see if they get added to, replacet etc.
>>
>>  * Ditto but for the user having configured trailer.separators (see the
>>    test_config helper for how to set config in a test). I.e. if it's "=
=3D"
>>    does adding trailers work, how about if it's "=3D" on the CLI but the
>>    config/commit message has ";" instead of ":" or something?
>>
>
> As mentioned above, it works normally.
>
>>  * Hrm, actually I think tweaking "-c trailer.ifexists" won't work at
>>    all, since the CLI switch would override it. I honestly don't know,
>>    but why not not supply it and keep the addIfDifferentNeighbor
>>    default?
>>
>>    If it's essential that seems like a good test / documentation
>>    addition...
>>
>>  * For the above -c ... case I can't think of a good way to deal with it
>>    that doesn't involve pulling in git_trailer_config() into
>>    git_commit_config(), but perhaps the least nasty way is to just set a
>>    flag in git_commit_config() if we see a "trailer.ifexists" flag, and
>>    if so don't provide "--if-exists=3Dadd", if there's no config (this
>>    will include "git -c ... commit" we set provide "--if-exists=3Dadd" )
>>    or as noted above, maybe we can skip the whole thing and use the
>>    addIfDifferentNeighbor default.
>>
>
> Has been restored to the default settings.

To clarify: What I really mean is for all these things you've tested:
let's add those to the tests as part of the patch.

>> And, not needed for this patch but worth thinking about:
>>
>>  * We pass through --trailer to git-interpret-trailers, what should we
>>    do about the other options? Should git-commit eventually support
>>    --trailer-where and pass it along as --where to
>>    git-interpret-trailers, or is "git -c trailer.where=3D... commit" good
>>    enough?
>>
> Logically speaking, `interpret_trailers` should be dedicated to `commit`
> or other sub-commands that require trailers.
>
> But I think that in the later stage, the parse_options of the `cmd_commit`
> can keep the unrecognized options, and then these choices can be directly
> passed to the `interpret_trailers` backend.

We have this interaction with e.g. range-diff and "log", it's often
surprising. You add an option to one command and it appears in the
other.

>>  * It would be good to test for and document if that "-c trailer.*"
>>    trick works (no reason it shouldn't). I.e. to add something like this
>>    after what you have (along with tests, and check if it's even true):
>>
>
> I haven't tested them for the time being, but I will do it.
>
>>        Only the `--trailer` argument to
>>        linkgit:git-interpret-trailers[1] is supported. Other
>>        pass-through switches may be added in the future, but currently
>>        you'll need to pass arguments to
>>        linkgit:git-interpret-trailers[1] along as config, e.g. `git -c
>>        trailer.where=3Dstart commit [...] --trailer=3D[...]`.
>>
>
> I think this is worth writing in the documentation.
>
>>  * We have a longer-term goal of having the .mailmap apply to trailers,
>>    it would be nice if git-interpret-trailers had some fuzzy-matching to
>>    check if the RHS of a trailer is a name/E-Mail pair, and if so did
>>    stricter validation on it with the ident functions we use for fsck
>>    etc. (that's copied & subtly different in several different places in
>>    the codebase, unfortunately[1]).
>>
>
> I may not know much about fuzzy-matching, which may be worth studying lat=
er.
>
>> More thoughts:
>>
>>  * Having written all the above I checked how --signoff is implemented.
>>
>>    It seems to me to be a good idea to (at least for testing) convert
>>    the --signoff trailer to your implementation. We have plenty of tests
>>    for it, does migrating it over pass or fail those?
>>
> I don=E2=80=99t know how to migrating yet, it may take a long time.
> Even I think I can leave it as #leftoverbit later.

Sure, I mean (having looked at it) that at least for your own local
testing it would make sense to change it (even if just search-replacing
the --signoff in the test suite) to see if it behaves as you
expect. I.e. does the --trailer behavior mirror --signoff?

>>  * I also agree with Junio that we shouldn't have a --fixed-by or
>>    whatever and wouldn't add --signoff today, but it seems very useful
>>    to me to have a shortcut like:
>>
>>        --trailer "Signed-off-by"
>>
>>    I.e. omitting the value, or:
>>
>>       --trailer "Signed-off-by=3D"
>>
>>    Or some other thing we deem sufficiently useful/sane
>>    syntax/unambiguous.n
>>
>>    Then the value would be provided by fmt_name(WANT_COMMITTER_IDENT)
>>    just as we do in append_signoff() now. I think a *very common* case
>>    for this would be something like:
>>
>>        git commit --amend -v --trailer "Reviewed-by"
>>
>>    And it would be useful to help that along and not have to do:
>>
>>        git commit --amend -v --trailer "Reviewed-by=3D$(git config user.=
name) <$(git config user.email)>"
>>
>>    Or worse yet, manually typo your name/e-mail address, as I'm sure I
>>    and many others will inevitably do when using this option...
>>
> I think this idea is very good and easy to implement.
> We only need to do a simple string match when we get the "trailer" string,
> If it can be completed, it can indeed bring great convenience to users.
>
>> 1. https://lore.kernel.org/git/87bld8ov9q.fsf@evledraar.gmail.com/
>
> Thanks, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason!

And thanks for working on this.
