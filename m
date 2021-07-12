Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D582C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C85D61221
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhGLR6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhGLR6F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:05 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44264C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:55:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w15-20020a056830144fb02904af2a0d96f3so19733963otp.6
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4E7FAdGVlTroxu1sP0Lpy8O0CveGia5bECpWOoeHN88=;
        b=sYKgdN7RJKA2m3pdkEjYYbilzqFU+Xn504edOIeE9waGFBzk5WsoaYstIZXV8PYZZ/
         aR5GhGt2x8mILqndkKsx15S/oEmAr5qD8DPZHGSmwrXK6EuF+Gro5X1RWhf10QT2qKuZ
         ndHwJEEVPKpaYL0ILoa7694S2skO8NdvYH48jjTFv9X8gEfduFk4z8LRPl9yMwVq9jUq
         +mEQmPQaHl0BcSxPGU6441p5oV7U2/3X7g/i1rE25IUcbcSMDAYHdBxUllrZMOjDnUMH
         dkKYMw6zY/d8aq1p2okQgISSY3ALhyUN/Dbs7INadgqTefZWYtItDTs6RmJz5f1/hiM8
         F/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4E7FAdGVlTroxu1sP0Lpy8O0CveGia5bECpWOoeHN88=;
        b=lMSRUwGeoTQISjsoFw/MafOPOrN+56tTx1aza929pWXrEc8F+jc6oTFn0Djjemp8Hz
         J7FeR5cAo2N7VC55bLWZgA2KWVIRJDCKOwxbHkBLmLg+oHpQMlVii6bJ76QRf2Ac/8kN
         iR/l9MKEuBckgMDyTgdaQrwfgjzdfG0JZmOtut1KQK4lJuLCrsBODZGdiXHAUchOvNoT
         wfY9Txzz6Pc7+opP/qc0BNdINcl7h0Nwfl6Q6HNB80ApsHVdctjwyq7qchtFeVfnjcyL
         KPjNNzeqNw82qPg2n3BuZ3Z2jT9XKXYrHH/RatfQNUKUJakUceAfY0GYiJdEnu2TLvfV
         Rzrw==
X-Gm-Message-State: AOAM531FQr8I92yJCJxdbXKTrZjZ1M4Gk1qwHyYZJvlitX35vhAM1OII
        dPTzMaeCZgGNVkmYGoUNn7E=
X-Google-Smtp-Source: ABdhPJxHTScVsJKMJw8bodjehgP3mIGik13QTMQ+7JurO+i/e23h4uBClanPNa1FxL5sabzGONDg5Q==
X-Received: by 2002:a9d:630f:: with SMTP id q15mr163706otk.155.1626112515711;
        Mon, 12 Jul 2021 10:55:15 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id t207sm787567oif.27.2021.07.12.10.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:55:15 -0700 (PDT)
Date:   Mon, 12 Jul 2021 12:55:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60ec8202213a1_a231f20891@natae.notmuch>
In-Reply-To: <c530dedb-8cad-2a73-5b56-a32173046382@gmail.com>
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
 <c530dedb-8cad-2a73-5b56-a32173046382@gmail.com>
Subject: Re: [PATCH v2 0/2] extra: new concept of extra components
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain wrote:
> Le 2021-07-10 =C3=A0 19:46, Felipe Contreras a =C3=A9crit=C2=A0:

> > We might want to move more components from contrib to extra once thei=
r
> > tests are being run reliably.
> > =

> > And we might move some components from the core which aren't really p=
art
> > of the core to extra, like gitk, git-gui, git-p4, and git-svn.
> > =

> > For now only contrib/completion and contrib/workdir are graduated to =
the
> > new area.
> =

> ... when I read this I went "what is this workdir thing, it must date f=
rom before
> 'git worktree' was added". And combing through the history, it does. Th=
e latest
> commit to the script is e32afab7b0 (git-new-workdir: don't fail if the =
target
> directory is empty, 2014-11-26), which describes as v2.3.0-rc0~60^2. An=
d
> 'git worktree' was shipped in Git 2.5, 2015-07-27.
> =

> Looking at the tests, I see two uses of 'git-new-workdir':
> $ git grep  -p 'new-workdir'
> t1021-rerere-in-workdir.sh=3D28=3Dtest_expect_success SYMLINKS 'rerere =
in workdir' '
> t1021-rerere-in-workdir.sh:30:56:       "$SHELL_PATH" "$TEST_DIRECTORY/=
../contrib/workdir/git-new-workdir" . work &&
> t1021-rerere-in-workdir.sh:41:50:# For the purpose of helping contrib/w=
orkdir/git-new-workdir users, we do not
> t1021-rerere-in-workdir.sh=3D44=3Dtest_expect_failure SYMLINKS 'rerere =
in workdir (relative)' '
> t1021-rerere-in-workdir.sh:46:56:       "$SHELL_PATH" "$TEST_DIRECTORY/=
../contrib/workdir/git-new-workdir" . krow &&
> t3000-ls-files-others.sh=3D75=3Dtest_expect_success SYMLINKS 'ls-files =
--others with symlinked submodule' '
> t3000-ls-files-others.sh:87:57:         "$SHELL_PATH" "$TEST_DIRECTORY/=
../contrib/workdir/git-new-workdir" ../sub sub &&
> =

> So they are not really testing this script per se, more like testing re=
rere and ls-files
> in a worktree created by 'git-new-workdir'. I do not think this enough =
justification
> to include 'git new-workdir' in 'extra/', since 'git worktree add' does=
 the same thing
> and is a builtin command. Even if its "BUGS" section in the doc says it=
's "in general [...]
> still experimental", an experimental builtin is better than a 'contrib'=
 script, no ?

I agree.

However, that points out to another problem: the tests should not be usin=
g `git new-workdir`.

I'm fine with dropping the last patch from the series.

-- =

Felipe Contreras=
