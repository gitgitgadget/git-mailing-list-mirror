Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A59C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiEJXML (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiEJXMI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:12:08 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D60527E3
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:12:07 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id m203so298037vke.13
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I0TFJ/rZduv+NGcxqO8qoCpziQjNhBf7b80casM9meA=;
        b=UfKog1mzWYZx5qFXz4wfCr+C9ZWyrxL8rRhnYT/FwaT6e3Awg+WaEy7w0XcwwLN2Ak
         ZyueT2mwiOhLTOdGRorl9hEiCILQpZ90oO325BQW7mTOFf15RuRIaC19RD8gvZuCfpJo
         O/H2S/pGLD3p8WB2HBsHgBzRzMgMaCwQ5NZv1Bu8Pkfuu7b8srLTxCdGOW/HZkB6egGp
         UgAxh7rrT9GcAqXidufO2HiqISmzuBIG2iLNrHaGYG7uFDTUJDpNwqGGwDJit2a0PBF7
         HJLO8j9MqqEbWFMxW3fwaMxn5VXNnKUpjhzzT2PH6b6BUCibrCfan20Wb+oz0gqmjsbr
         3dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I0TFJ/rZduv+NGcxqO8qoCpziQjNhBf7b80casM9meA=;
        b=J9AQHnTyrkzUrL2o86vsaGft9DVexiyygTDRcsGrthYLcE3ztDQ+On9yeZkcVzhJkm
         laKfjwZpfL9GKCKwXNOfQVnwjYrCciRdUTECeXmOahLi4Qx1yKXV/yiJb+rQAlqjqeV+
         DQk8Xh6YThWx6uBPNH335zh4K8UKrj7zvXg5v6adDKySeXl60cv47/Im0snOa5naXUjP
         ZcJwxoh/X0tMkaPqan5L7uuqwQwhZDaM/XV8nRAfQRt/LEfL3LGTYIVdSyCRED1pKwr7
         Hzarce7jrcoxS1Ig52M9PBh5QuYV0YO8s4cKVv1toFfgBle8qNxt3evdQ3HbOYOyMwNv
         tvqQ==
X-Gm-Message-State: AOAM5310EZUa/GGU1skL0NyZp0OY7ufQ8vO6c65oVta4K1Bte4EA4V0Z
        X0RM+dVw7TV5X3Sa4uYKfQBTdgh1u1bOfMNZ6wo=
X-Google-Smtp-Source: ABdhPJzJxPsiNApBQg96e3oBRHrCsBmQyy5ZTjTlQ0LVLe/ivVsq2BumUFoKBapiAr7/b32qoLieFRNOIVM6qn9BN10=
X-Received: by 2002:a05:6122:d09:b0:351:f87b:b27a with SMTP id
 az9-20020a0561220d0900b00351f87bb27amr13265274vkb.23.1652224326539; Tue, 10
 May 2022 16:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220507163508.78459-1-carenas@gmail.com> <20220510174616.18629-1-carenas@gmail.com>
 <20220510174616.18629-2-carenas@gmail.com> <xmqqczgl6nua.fsf@gitster.g>
In-Reply-To: <xmqqczgl6nua.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 10 May 2022 16:11:55 -0700
Message-ID: <CAPUEspgGZeF8LA5PZNF87=+zZLKvWLqWtpD5YUBUON4gq_TaDg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] t: regression git needs safe.directory when using sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2022 at 3:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > +test_lazy_prereq SUDO '
> > +     sudo -n id -u >u &&
> > +     id -u root >r &&
> > +     test_cmp u r &&
> > +     command -v git >u &&
> > +     sudo command -v git >r &&
> > +     test_cmp u r
> > +'
>
> I vaguely recall mentions of older dash that lack "command -v" made
> earlier, but implementations of dash I have handy seem to know it.
> I am personally fine with this as this script has a very narrow and
> limited audience in mind.

I did check that, but think the report was mistaken.
Debian, Ubuntu, NetBSD and OpenBSD would fail the same way here, but
it is not because of the use of dash, as much as sudo NOT being
configured to default to `-s` mode.

dscho was right to point out that I should had usen type instead, but
that wouldn't work because of the mismatch of shells and therefore the
mismatch of outputs, so I went with command instead as an extra clever
way to make sure both the shell inside and outside were most likely
the same, even if some sudo somewhere decides in the name of security
not to respect its own "-s mode" and force a "safer" shell.

I have a real fix for this which will be released later as part of
that "better integration with the framework", which basically makes
sure all invocations through sudo are done through the test shell
(just like that ugly function that gets added in patch 3), but it
requires changing write_shell and therefore not something that is
worth doing now.

> +test_expect_success SUDO 'setup' '
> > +     sudo rm -rf root &&
> > +     mkdir -p root/r &&
> > +     sudo chown root root &&
> > +     (
> > +             cd root/r &&
> > +             git init
> > +     )
> > +'
>
> So, "root/" is owned by root, "root/r" is owned by the tester.

It doesn't need to be root, but needs to be different than "tester",
and since I know root is different and I validated in the prerequisite
that I can sudo to it, that is what is used here.

> > +test_expect_failure SUDO 'sudo git status as original owner' '
> > +     (
> > +             cd root/r &&
> > +             git status &&
>
> The tester runs "git status" in "root/r" owned by the tester and it
> should succeed.
>
> > +             sudo git status
>
> We want the tester to be able to do the same while temporarily
> becoming 'root' with "sudo", but we know it fails right now.
>
> > +     )
> > +'
>
> Mental note.  We do not need root to be owned by 'root' with the
> tests we see here.  Perhaps we would add some that requires it in
> later patches.  We'll see.

I am not good with subtle messages in a foreign language, but is this
a way to imply that I shouldn't need to chown and instead use the
GIT_TEST_PRETEND feature more?

frankly I might had overused sudo, but it is because every extra
invocation refreshes the cache, and all tests depend on SUDO anyway,
so I wanted to make sure they were also more easily reconizable for
the real thing.

Carlo
