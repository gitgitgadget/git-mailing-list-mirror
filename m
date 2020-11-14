Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BB2C63697
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0484322261
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCyxfkXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKNAcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKNAcW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 19:32:22 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09573C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:32:22 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id ek7so5767834qvb.6
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jqpTIsGXIN09XXhxmSLnsh8AS0Hr3l5IxIu4XKmAgxU=;
        b=QCyxfkXrqFWo8B5wg7lKRFLK4ave6gfgapNAr3gfWXEgiLzQtH2azIuEmom+UKLP+X
         2KNZPqevZbGODwkLZS2qY7mGQBApANwEuvTNAQq5qHpVWni2H+BNETDFHORy4GAyzAOn
         m2SXWgsykkbLhviz3cqN8OAnl8XHbOJ4u2vzyg/Kr0nhYPYDuRhxzsIfoyCrFAaCRNNU
         cKmvfjqm2fh4hJIROmphrHJ4w19N6Wh5Oko8HvWwJuZKfgAncjFH2gzIQ74SUH2CTSOv
         baWpJwjxU9CWu+lF0bvkvfiW3Os/mOAk3umPGEMFkHp20AJ7VnTIk7btd/9aSNxEn58c
         Ca8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jqpTIsGXIN09XXhxmSLnsh8AS0Hr3l5IxIu4XKmAgxU=;
        b=ZNlTxvfyEv7bpCGl6yWIGerv8D8T4HsynpNtoIaxd6ImMJ9aMD3zyU948JBo5s6Iud
         27MwK4t9i3QB0Pd9JuMvymMK90+5zsglPDSHccevJcChYMBoBM/NnrDUAFaHNVFyduwb
         XptJC5Ug2BHLghTtAwimWRHJi+iDCddmGCw57qReHNITshXlkPrZfbCoQIl6/rEZuEGu
         jdmFDOosklS2DmQP11qz7AubYEHAWkalcJb4JkpSiPy0lKaP0iA7ss1Tt/3XkK03jADF
         ZmL7V4lKm/LAjnVWX80nh4+agKvpmLv1h9Z2bG8VBlXZO3jC4rHnDr1Gv8ijmjIAr3UZ
         01Qw==
X-Gm-Message-State: AOAM533Db0qNwesABu1dMPNKX1KTQPHRk/NLQFdlEvoMDwS0dFeMnMpz
        NIL3MdOXWBKdTBrOOkqOstu+ln2WI2TTUw==
X-Google-Smtp-Source: ABdhPJwqc/CrY1vmUx+XZmP1L2tngu7TrB/TDh/UeGxMjDvhqqWi5s86qLdam4FBF/bft7Ws/PgXZw==
X-Received: by 2002:ad4:4943:: with SMTP id o3mr5331631qvy.9.1605313941159;
        Fri, 13 Nov 2020 16:32:21 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id x71sm2233171qka.71.2020.11.13.16.32.20
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2020 16:32:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: fatal: cannot rebase with locally recorded submodule modifications
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200207220403.28961-1-shouryashukla.oo@gmail.com>
Date:   Fri, 13 Nov 2020 19:32:17 -0500
Cc:     Brice Goglin <bgoglin@free.fr>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D5F0B08-A4A1-4891-895F-54A4A437BDB2@gmail.com>
References: <660c39af-d0f2-5e4c-66a0-5c78b646b023@free.fr> <20200207220403.28961-1-shouryashukla.oo@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

> Le 7 f=C3=A9vr. 2020 =C3=A0 17:04, Shourya Shukla =
<shouryashukla.oo@gmail.com> a =C3=A9crit :
>=20
> Hello Brice,
>=20
> The error you are facing here is actually a bug in the
> 'git pull' command[1]. When one tries to use the
> '--recurse-submodules' tag with the command, it tends to fail.

Let's not discourage our users ;) It is untrue that it tends to fail.

>> Why is failing here?
>=20
> Going into a bit detail of 'git pull', the command actually
> is a combination of 'git fetch' and 'git merge'(unless any
> other tag is specified i.e. 'rebase' here which would mean
> a fetch followed by a rebase). Quoting from the documentation:
>=20
>> Using --recurse-submodules can only fetch new commits in already
> checked out submodules right now
>=20
> Using the '--recurse-submodules' tag will try merging/rebasing any
> changes(updations, additions, deletions, etc.) made to the fetched
> submodule(s) from upstream, i.e. the _un-checked out_ submodules into
> our local repository which will cause the error to be thrown as it is
> not supported right now.

That part of the doc talks about the fact that when using =
'--recurse-submodules', only commits
in already checked out submodules ("populated submodules" is the wording =
used in the docs=20
for that option) will be *fetched*. If you take a look at, for example,

    git blame -L 240,+10 Documentation/git-pull.txt

you'll see that this section was added in 794a3592ad (fetch/pull: =
Describe=20
--recurse-submodule restrictions in the BUGS section, 2011-03-06), when =
'git fetch'
learned the '--recurse-submodules' flag. At the time 'git pull =
--recurse-submodules'=20
did *not* update the working tree of the submodules, it just passed =
'--recurse-submodules'=20
to the underlying 'git fetch'. 'git pull' learned to update the working =
tree of the submodules
(and also rebase the submodules themselves under very specific =
circumstances) in=20
a6d7eb2c7a (pull: optionally rebase submodules (remote submodule changes =
only),=20
2017-06-23).=20

So this "bug" you mention is not what is happening here. Since Brice =
clone with=20
'--recurse-submodules', all submodules will be cloned, initialized and =
populated as=20
part of the superproject clone, so they are all already checked out when =
'git pull' is invoked.

Also, the "Bugs" section in the docs that you refer to does not talk =
about the command
erroring; it just describes a limitation of 'git fetch =
--recurse-submodules'. And as a side note,
there is no test in the test suite that checks this behaviour (looking =
at t5526-fetch-submodules.sh
and t5572-pull-submodule.sh). It would be good to fix that by adding a =
couple 'test_expect_failure'=20
tests, or even to fix the behaviour itself.=20

Note also that when this "Bugs" section was added, the submodule =
repositories=20
were cloned directly in the superproject working tree instead of being =
cloned to=20
.git/modules/<submodule-name>. This explains why this limitation existed =
at the time:
you can't fetch the submodules if there is no filesystem location to put =
their Git repository!
A few months later, 501770e1bb (Move git-dir for submodules, =
2011-08-15), implemented=20
the "new-style" submodule setup, i.e. cloning the submodules =
repositories inside the Git repository
of the superproject, as is standard these days. So there is no good =
reason today to not fix this=20
bug, in my opinion.

Going back to Brice's bug:

> The "workaround" is to do a 'git fetch' and then merge again after the
> 'git pull <tag> --recurse-submodules'.

I don't think there is a workaround until my fixes get merged, apart =
from
not using '--recurse-submodules' with 'git pull --rebase'. Of course =
then you=20
have to remember to *always* do 'git submodule update --recursive' after=20=

each pull if you want your submodule checkouts to stay in sync with the =
commits
recorded in the superproject.

> The presence/absence of 'git reset --hard' before the pull  won't =
create
> any difference to this error in my opinion.

On the contrary: as I wrote in my answer to Brice, it is exactly because =
'git reset --hard' is used=20
here that the code wrongly errors.

Cheers, and thank you for all the work you put in the rewrite of the =
submodule code
from shell to C this summer.

Philippe.=
