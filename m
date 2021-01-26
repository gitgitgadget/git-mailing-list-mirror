Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7D2C433E9
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD3023127
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 12:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390949AbhAZMfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391900AbhAZKar (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 05:30:47 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67964C06174A
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 02:30:07 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t17so11845369qtq.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 02:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ki29L8rxNMS9JdH8Uh2KhyR8o0M41JMEBGR/6mzJ0nQ=;
        b=aPGIgQ6kojROr2mDyvEWhx6aznhyqqz2zPw9WV/IyzZGOxaOLzKSvbnc8TDzTm48LF
         E3rvMjD09MtrRd5g7Xz6832m5p9DF1qtgnlu6sKFnmybh79RHer5Q3FqdEWqMRJfIJjh
         ylPqfzCt3ixoj27ck7ozOKJ9zw971lkObg5OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ki29L8rxNMS9JdH8Uh2KhyR8o0M41JMEBGR/6mzJ0nQ=;
        b=ENKAuMyt4PzbrAh6vBYa3j4X7Z1FrE14G4Qvcs1kzqadEtCPR/2MRLndavdsUXnYwH
         FMSp/MzqsTGjsPjkJblkYORoP1BClKs9RhiXi9cQFXztsowxD99R79Gm8BrKQr6TXBwD
         70W/27kE+2hjxB12PqGM76DrVtSAIuA8RldZXnt18NU0nQcA388Ix6kSuNsLzPCErkbw
         LZPLZ5YOKzvQMkvBvmyNuyk3gPhq8qs0Z5ODlLt5SU3J2Hd7tJ2CrnHuqu8jzsWKETck
         BjIcli2MwlD34Drvivz75bcAhkKK4VsPwSyowEkG4Bm0Kd6cJ/rGMxwHKvhlGXlcj2MP
         DGvQ==
X-Gm-Message-State: AOAM53042NX7daExbhcr4X8Cu3OuVhRAY2pcNP4dOixJdNLe9YwrjCHY
        Js6cXeBkf++nSAHM5PVFbCFwRZIyRSRUrAinHWOnKA==
X-Google-Smtp-Source: ABdhPJyiLN+DBiqyz5mHZNi+DXDEg5KkCLonuOGclgvT7gnuckV6kuyPTNqyNdgDDzF0FDmXshmffR2gayT30N9nQM0=
X-Received: by 2002:ac8:4711:: with SMTP id f17mr4474059qtp.256.1611657006553;
 Tue, 26 Jan 2021 02:30:06 -0800 (PST)
MIME-Version: 1.0
References: <YA81LEon1RPzT0T9@coredump.intra.peff.net> <20210125230952.15468-1-jacob@gitlab.com>
 <20210125230952.15468-2-jacob@gitlab.com> <874kj46mwf.fsf@evledraar.gmail.com>
In-Reply-To: <874kj46mwf.fsf@evledraar.gmail.com>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Tue, 26 Jan 2021 11:29:55 +0100
Message-ID: <CADMWQoP+hgPiSHJ5D-3G0+-bZOYm1hr=ojBeSmUJhiS7bp0zPg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] upload-pack.c: fix filter spec quoting bug
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, gitster@pobox.com,
        Git Mailing List <git@vger.kernel.org>,
        jeffhost@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback =C3=86var. I am not sure if I am still supposed to
make changes to the patch now that it is in "seen" as
7c6e2ea381d9aafe0a1eff0616013f81d957c0fd. Am I?

Best regards,

Jacob Vosmaer
GitLab, Inc.

On Tue, Jan 26, 2021 at 10:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Jan 26 2021, Jacob Vosmaer wrote:
>
> > This fixes a bug that occurs when you combine partial clone and
> > uploadpack.packobjectshook. You can reproduce it as follows:
>
> Let's:
>
>  * Refer to the commit we're fixing a bug in, i.e. Junio's mention of
>    10ac85c7 (upload-pack: add object filtering for partial clone,
>    2017-12-08) upthread.
>
>  * See also "imperative-mood" in SubmittingPatches. I.e. say "Fix a bug
>    in ..." not "This fixes ... can be reproduced as"
>
>  * uploadpack.packObjectsHook not uploadpack.packobjectshook except in C
>    code.
>
> > git clone -u 'git -c uploadpack.allowfilter '\
> > '-c uploadpack.packobjectshook=3Denv '\
> > 'upload-pack' --filter=3Dblob:none --no-local \
> > src.git dst.git
>
> This and the output below would be more readable indented.
>
> > Be careful with the line endings because this has a long quoted string
> > as the -u argument.
> >
> > The error I get when I run this is:
> >
> > Cloning into '/tmp/broken'...
> > remote: fatal: invalid filter-spec ''blob:none''
> > error: git upload-pack: git-pack-objects died with error.
> > fatal: git upload-pack: aborting due to possible repository corruption =
on the remote side.
> > remote: aborting due to possible repository corruption on the remote si=
de.
> > fatal: early EOF
> > fatal: index-pack failed
>
> [...]
>
> > The problem is an unnecessary and harmful layer of quoting. I tried
> > digging through the history of this function and I think this quoting
> > was there from the start.
>
>
> ...So looked at "git log" but didn't try to check out 10ac85c7 and see
> if it had the same issue? If we're going to leave a note about this at
> all probably better to help future source spelunkers by being able to
> say the issue was there from the start.
>
>
> > My best guess is that it stems from a
> > misunderstanding what use_shell=3D1 means. The code seems to assume it
> > means "arguments get joined into one big string, then fed to /bin/sh".
> > But that is not what it means: use_shell=3D1 means that the first
> > argument in the arguments array may be a shell script and if so should
> > be passed to /bin/sh. All other arguments are passed as normal
> > arguments.
> >
> > The solution is simple: never quote the filter spec.
> >
> > This commit removes the conditional quoting and adds a test for
> > partial clone in t5544.
> >
>
> Thanks for hacking this up! Hopefully the above is helpful and not too
> nitpicky. Mainly wanted to help you get future patches through more
> easily...
>
> > Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> > ---
> >  t/t5544-pack-objects-hook.sh | 9 +++++++++
> >  upload-pack.c                | 9 +--------
> >  2 files changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.s=
h
> > index 4357af1525..f5ba663d64 100755
> > --- a/t/t5544-pack-objects-hook.sh
> > +++ b/t/t5544-pack-objects-hook.sh
> > @@ -59,4 +59,13 @@ test_expect_success 'hook does not run from repo con=
fig' '
> >       test_path_is_missing .git/hook.stdout
> >  '
> >
> > +test_expect_success 'hook works with partial clone' '
> > +     clear_hook_results &&
> > +     test_config_global uploadpack.packObjectsHook ./hook &&
> > +     test_config_global uploadpack.allowFilter true &&
> > +     git clone --bare --no-local --filter=3Dblob:none . dst.git &&
> > +     git -C dst.git rev-list --objects --missing=3Dprint HEAD >objects=
 &&
> > +     grep "^?" objects
> > +'
> > +
> >  test_done
> > diff --git a/upload-pack.c b/upload-pack.c
> > index 3b66bf92ba..eae1fdbc55 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -305,14 +305,7 @@ static void create_pack_file(struct upload_pack_da=
ta *pack_data,
> >       if (pack_data->filter_options.choice) {
> >               const char *spec =3D
> >                       expand_list_objects_filter_spec(&pack_data->filte=
r_options);
> > -             if (pack_objects.use_shell) {
> > -                     struct strbuf buf =3D STRBUF_INIT;
> > -                     sq_quote_buf(&buf, spec);
> > -                     strvec_pushf(&pack_objects.args, "--filter=3D%s",=
 buf.buf);
> > -                     strbuf_release(&buf);
> > -             } else {
> > -                     strvec_pushf(&pack_objects.args, "--filter=3D%s",=
 spec);
> > -             }
> > +             strvec_pushf(&pack_objects.args, "--filter=3D%s", spec);
> >       }
> >       if (uri_protocols) {
> >               for (i =3D 0; i < uri_protocols->nr; i++)
>
