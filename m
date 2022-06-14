Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3265EC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 06:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiFNGQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 02:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiFNGQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 02:16:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E663377E8
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 23:16:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id s12so15160797ejx.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 23:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meSllCvayloV4olif8FN/nL+6NOnx5QGYHCJevuLOxo=;
        b=W/ezLS72LhZ/5lM9EOAo9s1x6iDtQ2KhOgKmawk/UYYEf0PTFfuX5tychKGTXmlo6v
         +7gFkykm/0Bg29i0PQ/l6cwlDFugJ8zU7KhrhfZY1XW3e4pfJgw3SZplp3Tc4EX2c9lp
         UMOBD1Jy/qGEfKrg6I3WoBJCDAvHGdGCjZL9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meSllCvayloV4olif8FN/nL+6NOnx5QGYHCJevuLOxo=;
        b=F85tiugMevJX3TN+0DhFP4Ynv1xHZ1pFu5W9lt0oeBVSSXoIk2YxJd9Sj7FmEi5hnf
         Cky1yECHKczrFelaNQD6yoGds4k/T9bRk3deMvmRMPkEblostVA/88/IgH8ClJNu5Nhg
         48luIQ836VGCfdi9Hd6EKzqrqF2up9yz6KjEmttIuzKooSGRgbmAzf+JW3Tmks60PUMq
         +o8KTg8WyR25b+5t2AIqOfsizUxrLdNsoh3M0/hRJTtpterAKjXn/Q5Z0iC44jn/PonP
         f1DH/jTj9LMIMkz0K0caFjgXUt+YqxyL4PkzBj6rbEtRktPZ9y3mBLHoKcViF6kCYvm+
         8biA==
X-Gm-Message-State: AOAM532W791DJZWl8nLdoYIxftIxv6RBt1Q+XxRIgesrmiISADcowK3z
        auiRHmu1xPYyJobIVP3H+yuDlIGS/98kEYsMyQFuuSyDDfmvEq7ytKM=
X-Google-Smtp-Source: ABdhPJwRdv4qLO2EiHMJw/mDXR/khs33NJDMv0gO0qIRgZs9M0vMLN46/9ncp+Qpv00yZWzLqkLWJx8+QgtfYeTiPmg=
X-Received: by 2002:a17:907:7256:b0:711:dd35:61eb with SMTP id
 ds22-20020a170907725600b00711dd3561ebmr2751055ejc.445.1655187416035; Mon, 13
 Jun 2022 23:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com> <xmqqr13t8np7.fsf@gitster.g>
In-Reply-To: <xmqqr13t8np7.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 14 Jun 2022 08:16:44 +0200
Message-ID: <CAPMMpogTcKqw6SHon9soj_CqPf-E8SmHpJ1FRRBKaCcOVnyHRg@mail.gmail.com>
Subject: Re: [PATCH] apply: support case-only renames in case-insensitive filesystems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 1:30 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +if ! test_have_prereq CASE_INSENSITIVE_FS
> > +then
> > +     test_set_prereq CASE_SENSITIVE_FS
> > +     echo nuts
> > +fi
>
> You can easily say !CASE_INSENSITIVE_FS as the prerequiste, so I do
> not see the point of this.  I do not see the point of "nuts", either.

I was not aware of negated prerequisite support (I did not see it in
the README nor in any examples I scanned), but I agree this is much
cleaner of course!

"nuts" was a debugging leak, my apologies.

>
> But it probably is a moot point as I do not think you should do the
> prerequisite at all.
>
> Instead, you can explicitly set the core.ignorecase configuration,
> i.e. "git -c core.ignorecase=yes/no", and possibly "apply --cached"
> so that you do not have to worry about the case sensitivity of the
> filesystem at all.

Sure, I can see how we can test most of the case-sensitive logic, even
on a case-insensitive filesystem, with "--cached" and "-c
core.ignorecase=no". I'm not sure whether there's a need to test the
same things against the actual file system or not (certainly in the
case-insensitive path there is, as this is where the errors/conflicts
actually occur).

>
> > +test_expect_success setup '
> > +     echo "This is some content in the file." > file1 &&
>
> Style.  Redirection operator ">" sticks to its operand, i.e.
>
>         echo "This is some content in the file." >file1 &&
>

Thx.

> > +     echo "A completely different file." > file2 &&
> > +     git update-index --add file1 &&
> > +     git update-index --add file2 &&
> > +     cat >case_only_rename_patch <<-\EOF
> > +     diff --git a/file1 b/File1
> > +     similarity index 100%
> > +     rename from file1
> > +     rename to File1
> > +     EOF
>
> You are better off not writing the diff output manually.  Instead,
> you can let the test write it for you, e.g.
>
>         echo "This is some content in the file." >file1 &&
>         git update-index --add file1 &&
>         file1blob=$(git rev-parse :file1) &&
>         git commit -m "Initial - file1" &&
>         git update-index --add --cacheinfo 100644,$file1blob,File1 &&
>         git rm --cached file1 &&
>         git diff --cached -M HEAD >case-only-rename-patch
>

Makes sense, thx.

> If you want to be extra careful not to rely on your filesystem
> corrupting the pathnames you feed (e.g. the redireciton to "file1"
> might create file FILE1 on MS-DOS ;-), you could even do:
>
>         file1blob=$(echo "This is some content in the file." |
>                     git hash-object -w --stdin) &&
>         file2blob=$(echo "A completeloy different contents." |
>                     git hash-object -w --stdin) &&
>         git update-index --add --cacheinfo 100644,$file1blob,file1 &&
>
>         git commit -m "Initial - file1" &&
>         git update-index --add --cacheinfo 100644,$file1blob,File1 &&
>         git rm --cached file1 &&
>         git diff --cached -M HEAD >rename-file1-to-File2 &&
>
>         git reset --hard HEAD &&
>         git update-index --add --cacheinfo 100644,$file1blob,file2 &&
>         git rm --cached file1 &&
>         git diff --cached -M HEAD >rename-file1-to-file2 &&
>
>         # from here on, HEAD has file1 and file2
>         git reset --hard HEAD &&
>         git update-index --add --cacheinfo 100644,$file2blob,file2 &&
>         git commit -m 'file1 and file2'
>

Cool, but probably excessive? (do we support MS-DOS??)

> > +'
> > +
> > +test_expect_success 'refuse to apply rename patch with conflict' '
> > +     cat >conflict_patch <<-\EOF &&
> > +     diff --git a/file1 b/file2
> > +     similarity index 100%
> > +     rename from file1
> > +     rename to file2
> > +     EOF
> > +     test_must_fail git apply --index conflict_patch
>
> And then, you could use --cached (not --index) to bypass the working
> tree altogether, which is a good way to test the feature without
> getting affected by the underlying filesystem.  Check both case
> sensitive and case insensitive cases:
>
>         # Start from a known state
>         git reset --hard HEAD &&
>         test_must_fail git -c core.ignorecase=no apply --cached rename-file1-to-file2 &&
>
>         # Start from a known state
>         git reset --hard HEAD &&
>         test_must_fail git -c core.ignorecase=yes apply --cached rename-file1-to-file2 &&
>

Makes sense, understanding that this tests "happy paths" - it doesn't
fail even if talking to the (case-insensitive) filesystem actually
would (which here it wouldn't of course).

> > +'
> > +
> > +test_expect_success CASE_SENSITIVE_FS 'refuse to apply case-only rename patch with conflict, in case-sensitive FS' '
>
> Lose the prerequisite, replace --index with --cached, and force core.ignorecase
> to both case insensitive and sensitive to check the behaviour.
>

Sure, makes sense - you can test case-sensitive behaviors in git
without needing a case-sensitive FS.

> > +     test_when_finished "git mv File1 file2" &&
> > +     git mv file2 File1 &&
> > +     test_must_fail git apply --index case_only_rename_patch
> > +'
> > +
> > +test_expect_success 'apply case-only rename patch without conflict' '
>
> Likewise, try both sensitive and insensitive one.
>

This one will fail on a case-insensitive filesystem if you disable
core.ignorecase, so explicitly trying with both settings in a single
test, without prerequisites, presumably isn't the right thing. I
assume the right thing is to have 2 versions of the same test, one
which expects success in all cases on a case-sensitive filesystem, and
one which expects failure when case-insensitivity is disabled on a
case-insensitive filesystem?

> > +     git apply --index case_only_rename_patch
> > +'
> > +
> > +test_done
> >
> > base-commit: 1e59178e3f65880188caedb965e70db5ceeb2d64
>
> Thanks.
>

Thank you!
