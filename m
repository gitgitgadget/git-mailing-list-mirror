Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F93C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D9861052
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbhHYP3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 11:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbhHYP3B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 11:29:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DD6C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 08:28:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d6so37600779edt.7
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zBABxjWwM4pbF4Yj0PZXpYbsP9eOgDdOafNXWOdBPEY=;
        b=PP2Ds1Tj8MNPdsjlsuzRg3KePj5K5M7Y3tvYmbxRKvYrnsNZtT2zxFJ0kaNWOeJbgw
         badpoZrD2anUvpBT+/9offIsiGuM0IlNR0669dQw9eDHFFQkmJG1JLfBrhHYnNSHbs97
         ZvAtWIKaqIxBJkmofgGZvo9oqHg0cEBnAyiiOeb4Gy1U/jKcDcwBiTBoEANAnXJdUrXp
         0xl3P9rtqet+fP/r7XORqEjAeczDvUHN9NMPTnRNXDebyDlHJYB+XmysTX13HAtnkPHx
         j2leyB2p/SjKjHYSjRSIwrzUZag38d7XtzwTi9fTdJTKv3SgkUhqtkrpVjjMSfGccdt2
         aeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zBABxjWwM4pbF4Yj0PZXpYbsP9eOgDdOafNXWOdBPEY=;
        b=EJmjkN/iUmeq/JKhc46Fas4ZaN9W12OlbOVyChsbh55O7Wo8xmHSYE6lFveQYk7sgR
         O7cMdp4Gfvd1x/p833aUhLqEPBbF5BkVSmgqQMpMOGTLUOjtHD3i/kgqSenrtpsZcA9t
         GC9EtqgYR+Ge6ceVYZz7TOoTfZ5CcQvDkqRa2tohhD4v+YE2XEl5ziu6qBTJ3sh6XuGm
         R2Bkf5f0qGyuYMeu8ln9dpHP5Dj82m3HvgK2s2cT5C/MGXCsqkeFKQWv0X6bvuYnOCsf
         1yBtx4N6ybfnF69P2R4+YPF3XNU2LKeORVS/7QPv6Fz8IOM0zPivEGU+WKzg6V/RGoIc
         tzmQ==
X-Gm-Message-State: AOAM532YZdqAULYPt8sqWfScyH0twLqrooMQp7Y14hE4cXAqkBDcwEnZ
        k9NIOl8pKPGTvN8XMSVpLAU=
X-Google-Smtp-Source: ABdhPJyD+SaaJEu/ahf7hjeNIVHuPcRDCQFcnJT+viC1V3QsoPiwzXdjw2eps5S4upLSjvcBoX+nFg==
X-Received: by 2002:aa7:c903:: with SMTP id b3mr17804409edt.23.1629905293317;
        Wed, 25 Aug 2021 08:28:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h8sm12988ejj.22.2021.08.25.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 08:28:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     git@vger.kernel.org
Subject: Re: How to interactively rebase-and-reword nth commit?
Date:   Wed, 25 Aug 2021 17:01:18 +0200
References: <eda317b080a2e75a170c051c339a76115cce5ad7.camel@yandex.ru>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <eda317b080a2e75a170c051c339a76115cce5ad7.camel@yandex.ru>
Message-ID: <87pmu1czn7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 25 2021, Konstantin Kharlamov wrote:

> I think, one of the most frequent git features used is `rebase -i`. There=
's a common
> workflow I think everyone knows: you have commits 1, 2, 3, then you decid=
e "Nah, 2nd
> commit needs a change", so you do `git rebase -i HEAD~2`, then in popped =
up editor
> you modify the `pick` on the first line to become `edit`, then you do the=
 change,
> then `git rebase --continue`.
>
> The boilerplate part here: even though you know that you want to edit HEA=
D~2, there
> is no way to tell git that right away. Every time you have to launch edit=
or, edit the
> line manually, then save it, close it.
>
> I have seen here some discussions about improving that, someone even post=
ed patches,
> but I'm not aware if it went anywhere. So I created 2 years ago a shell w=
rapper
> `rebase-at`=C2=B9, which upon called as `rebase-at e HEAD~2`, does the th=
ing described
> above automatically. Under the hood I simply substitute EDITOR with `sed`=
 command
> that replaces `pick` on the first line (the HEAD~2 commit) with `e`. If u=
sed with
> shell autocompletion, it is now practically instantaneous.
>
> I'm almost happy with `rebase-at`, except I don't know of any way to make=
 it work
> with `reword` git action. You see, "rewording a commit" requires to run E=
DITOR twice:
> first to substitute `pick` with `reword`, and then to actually edit the c=
ommit
> message. But since EDITOR was substituted with sed, the 2nd run won't giv=
e you an
> actual editor to change the commit message.
>
> Any ideas, how can I tell `git` that I want to "reword" nth commit right =
away? Sure,
> I am not the first one to stumble upon it, am I? Any ideas?
>
> 1: https://github.com/Hi-Angel/dotfiles/blob/0b9418224e4ce7c9783dbc2d9473=
fd1991b9b0b2/.zshrc#L148-L160

Have your GIT_EDITOR do one thing or the other depending on whether it's
asked to edit git-rebase-todo. This works for me:
=20=20=20=20
    # rebase-at <action> <comit-ids-and-co>
    function rebase-at() {
        local action=3D$1
        shift 1
        GIT_EDITOR=3D'perl -MFile::Basename=3Dbasename -wE '"'"'
            my $f =3D shift;
    	exec qw[sed -i -E], q[1s/\\w+/'$action'/], $f
    	    if basename($f) eq q[git-rebase-todo];
            exec "$ENV{EDITOR} $f";
        '"'" git rebase -i "$@"
    }
