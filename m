Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59ECC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 20:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831D0610A7
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 20:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhFQUw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 16:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhFQUw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 16:52:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF8FC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 13:50:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r7so5545550edv.12
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=95rTHj+nwa9ssSurxRcuCkpLynbyTa4qXY7SsKaC3o0=;
        b=kFOQUHY4jgMDWaGopdIxPf4imwiRsjdTA0+IsEeA9RUig09WH1c1rrM/TkyQNr6yxr
         GQeZs7h85jtY6ZIKaxOoYVESyb6tdvEAPnCZMCSWEA7m9tv0pOLerYLGBbU2zLrPFdtV
         65T04ECMP8DjsMZs2sPWboQHtcl7ujAmRYebZDawFcgH+zUrT8tUjmKz7sl9nk0yrbYr
         l+bPSDHiHSZP2YpFWSkq1u7J7Zwcuc9dMWRrmA72FsBaAmvpaCPQAiVDqGY0c69AcCLz
         56/bKTf8avl/W9MmrPfLJRJgXAU9ve4o9eTO8b2XAH8i8wIyX7V92eEHpNxf985h0TpJ
         ZLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=95rTHj+nwa9ssSurxRcuCkpLynbyTa4qXY7SsKaC3o0=;
        b=gzuvmBJIfdM6ZTgC3uM7RpGgoesPpFJNb/cru2pN3oE2S3gN8mX33JxOipa7H82KTN
         dI5Jh+ffSeCNsY9I+Xt6UDO8YOviowlqJ2bE7IL12wTwAND6oKmqOcSeOx51LBxh2aRi
         24XRjo7QMCZiSwb4DqnbRgUepTjH7/japbHNj9lb4cR9zAFqRYQ0/ikcgkK0LbCMZsI1
         lKCvTLA/vMV47JOUqgX11R14R0VjNoKVeYfk5xOugQ4lVCeTUQz9uIhKqtcnRPV1dvkd
         zLEsLfFwLezuiiYinxZD3FCPjAb8dHt2hMeFGINQ4tPQlWaqf3NR5azaA5QGXRDG3cC4
         c7fg==
X-Gm-Message-State: AOAM530YeCCocNDH5F090iBdpTD7CZQt4zDRmWT/jscKTqi4b/eW5hAk
        VMcnrEHUS20HOjccrbpH9cBDQ8KSuOM3OA==
X-Google-Smtp-Source: ABdhPJzGB+DP+fraWdIaRoCrxlOJG1kEY5RFgk5f4qsCG5c18g5+vVSOTgB2cRm8Y6LvRwAcoOr66g==
X-Received: by 2002:a05:6402:1e8b:: with SMTP id f11mr291473edf.86.1623963047964;
        Thu, 17 Jun 2021 13:50:47 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e28sm2750931edc.24.2021.06.17.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 13:50:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/6] gittutorial doc: replace "alice" and "bob" with
 "you" and "www-data"
Date:   Thu, 17 Jun 2021 22:38:24 +0200
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 <patch-1.6-abbb5b9ba13-20210615T161330Z-avarab@gmail.com>
 <8250d8af-2d52-321c-36a7-d71c29fc1ef1@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <8250d8af-2d52-321c-36a7-d71c29fc1ef1@gmail.com>
Message-ID: <875yyc5i6x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 16 2021, Bagas Sanjaya wrote:

> On 15/06/21 23.17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> -Suppose that Alice has started a new project with a Git repository in
>> -/home/alice/project, and that Bob, who has a home directory on the
>> -same machine, wants to contribute.
>> +Suppose that you've started a new project with a Git repository in
>> +/home/you/project, and you'd like another user on the same local
>> +machine to be able to contribute to it. E.g. a www-data user to serve
>> +the content up with a webserver.
>>   -Bob begins with:
>> +As the `www-data` user do:
>>    >   ------------------------------------------------
>> -bob$ git clone /home/alice/project myrepo
>> +www-data$ git clone /home/you/project /var/www-data/deployment
>>   ------------------------------------------------
>>=20
>
> This assumes that we're on Debian or its derivatives, however many
> users run Git on other distributions (Fedora, Arch, Gentoo, openSUSE,
> etc.), so `www-data` user may not be present there. Also, `www-data`
> is system account, as opposed to normal user account, so you can't log
> in to it; you need as root `chown -R www-data:www-data /somewhere/`.
>
> This also assumes that we use Apache HTTPD. The setup for other
> webservers may be different. For example, if NGINX is used (installed=20
> from upstream packages rather than from Debian package repository),
> you need to make site root (the path specified in `root` directive)
> readable by `nginx` user.

I meant www-data merely as an example, the user is expected to fill in
the blanks as Junio noted downthread. Not all *nix systems even have
$HOME in /home.

But clearly it's confusing to some, do you think calling it
s/www-data/website/g and otherwise making it non-distro specific would
be better?

>> -This creates a new directory "myrepo" containing a clone of Alice's
>> +This creates a new directory "deployment" containing a clone of your
>>   repository.  The clone is on an equal footing with the original
>>   project, possessing its own copy of the original project's history.
>>=20=20
>
> But the scenario is we're cloning from local repo, so `git clone` here
> implies --local (and bypasses normal Git transport mechanism), so to
> get clone experience similar to when using remote repo, we can use=20
> --no-local instead.

Well spotted, I believe that was the behavior when this was writen at
927a503cd0 (New tutorial, 2006-01-22), so this bug has probably always
been there...

>> -Bob then makes some changes and commits them:
>> +As `www-data` you then makes some changes and commit them:
>>     ------------------------------------------------
>>   (edit files)
>> -bob$ git commit -a
>> +www-data$ git commit -a
>>   (repeat as necessary)
>>   ------------------------------------------------
>>   -When he's ready, he tells Alice to pull changes from the
>> repository
>> -at /home/bob/myrepo.  She does this with:
>> +You can then pull those changes to the checkout in your home directory
>> +at /home/you/project:
>>     ------------------------------------------------
>> -alice$ cd /home/alice/project
>> -alice$ git pull /home/bob/myrepo master
>> +you$ cd /home/you/project
>> +you$ git pull /var/www-data/deployment master
>>   ------------------------------------------------
>>=20=20=20
>
> The resulting rewrite until this point makes no sense for
> me. Previously we have Alice and Bob working the project, but now you
> do the same, one as normal user account and one as system user
> `www-data`. Honestly I would like keeping the status quo.

Collectively we're a sample size of two, so it doesn't say much either
way, but FWIW I've worked at two companies in the past that had some
version of the pattern discussed in this article. I.e. you'd login to
some machine, have a repo in $HOME, and used that as your staging area
to another repo on the same machine also under your control (either
permanently or exclusively, or you'd "lock" it for the duration).

I don't think I've once in all my time using git been in the position to
be logged into a machine, and pulling/pushing to another repo in someone
else's $HOME or equivalent.

In any case, I do think for the purposes of the example in the guide
replacing Alice & Bob with You & another version of you removes a lot of
potential confusion, we don't need to cover permissions, the other user
doing unexpected things like non-ff updates, pruning branches you may
have relied on through the --local clone etc.

It's implicit that both "users" are you, so we only have to discuss the
point of the actual example, how to pull and push between two different
repos, the "different users" in this case was always a distraction.
