Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA2FC4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 14:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6FA20719
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 14:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCoJlhkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIVOEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgIVOEX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 10:04:23 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58162C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 07:04:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t138so19112140qka.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eCYFPVlKktNsPj5kF5KU7UJcAb2haNGCP54Sl75dDQ0=;
        b=aCoJlhkK/548ysHWengCH38drQcYISvncG8wFm0d54/s2wBUUcB10kcC80jkWpGzT0
         CAaw9raRwgZnYeXYBMoZsilCYdsTj5MBEUw5MoCFyjqzurWY+fKzQdKxcqMf+2LO6KBo
         S7RMnG4Ofk+mx86pCRImyoJZMEo+SiqF+vIWexg2/fxhQGBOXqUaXlcH6TOkuG1TTl8h
         gVJbxcNcshvazLdyk7sw9qLd5cH/G8y3afIqltJ4ra+nqMJ1uO6xQWCwRwK6tqhkgz/0
         fL7HW4ndeGB1TjgrhypY8rJ9rwW7KlcTezyedKSEcIabzcW3irQg4wUvXimME7fxzvWf
         yO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eCYFPVlKktNsPj5kF5KU7UJcAb2haNGCP54Sl75dDQ0=;
        b=UWm/aCmNpBryN9cJVG+PMWU1c6knC74hGSknwfJMJa0DCn3qVkgE4X9NOs2br9UjVt
         xi4spDpuHEZKmP1MMEUDcI7ogcNcC0mepcL1JB5d/4xsQMgP+6xeiGMxQ4gWcijEXZ8G
         iBFmonGQqzZxHWQCwWq/YzFnW9iVYC9j3e7fyRMaPcUZ6cc9dCYsM1Ge6FsQjp2fhK0u
         ggwCsHcBCumICle92gPqY2f++n0QOg/K0H/VNRYb1D1w0lNMoX9YbgSDMjGnmMmt8uk+
         YV1NL+X10zjcgIZWssHULHZsXP5LbuPmxvX8jgLECPQrxbPFaGupBTGSjAOPYnmR647w
         3Tcg==
X-Gm-Message-State: AOAM530fu0VLqW/NFxA63V2bJXYX40AfA/3HOuqVF/FsSuKOUIdZscM/
        miw5qQf3L68A1u2bQW92dJzMiQkVjlw=
X-Google-Smtp-Source: ABdhPJwrAtKK1Q7mkKy7nyI7eVL2HVDGpfTC4f4NN5qUrZ0WBMCVIPMJdVZ5RQwqa/+0Kaq9NsYqzg==
X-Received: by 2002:ae9:e84c:: with SMTP id a73mr4751037qkg.432.1600783460329;
        Tue, 22 Sep 2020 07:04:20 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id w94sm12696838qte.93.2020.09.22.07.04.18
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 22 Sep 2020 07:04:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/1] Test case for checkout of added/deleted submodules in clones
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200921081537.15300-2-luke@diamand.org>
Date:   Tue, 22 Sep 2020 10:04:16 -0400
Cc:     Git mailing list <git@vger.kernel.org>,
        kartic Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F8BD84C-ADBB-4A58-B3D0-87F9A428E5B4@gmail.com>
References: <20200921081537.15300-1-luke@diamand.org> <20200921081537.15300-2-luke@diamand.org>
To:     Luke Diamand <luke@diamand.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

> Le 21 sept. 2020 =C3=A0 04:15, Luke Diamand <luke@diamand.org> a =
=C3=A9crit :
>=20
> Test case for various cases of deleted submodules:
>=20
> 1. Clone a repo where an `old` submodule has been removed in HEAD.
> Try to checkout a revision from before `old` was deleted.
>=20
> This can fail in a rather ugly way depending on how the `git checkout`
> and `git submodule` commands are used.

As I wrote in my previous email [1], this fails if =
'--recurse-submodules'=20
was passed to 'git clone', which writes 'submodule.active=3D.' to the =
config.
So I would phrase it as:

This fails if the 'checkout' uses '--recurse-submodules' and=20
a pathspec in the configuration variable 'submodule.active' matches
the name of the submodule, which is the case for the match-all value '.' =
written to=20
this variable by 'git clone --recurse-submodules'.

> 2. Clone a repo where a `new` submodule has been added. Try to
> checkout a revision from before `new` was added.
>=20
> This can leave `new` lying around in some circumstances, and not in
> others, in a way which is confusing (at least to me).
>=20
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> t/t5619-submodules-missing.sh | 104 ++++++++++++++++++++++++++++++++++

I'm a little torn about where to put this test case. The heart of the =
matter
is that clone should not write '.' to 'submodule.active' if it does not =
clone all submodules,
even deleted ones, since 'checkout' cant (yet?) cope with an active =
submodule for which
it does not find the Git repository. So the "bug" is indeed in clone, =
thus t56** is a good place.
However, I would say that from a user experience perspective,
this test case should be in t2013-checkout-submodules, because if =
someone clones
with '--recurse-submodules', and then checks out the old revision with =
'--recurse-submodules',
then clearly their expectation is that the checkout should work.

In any case, if we leave it in t56** I think the name of the test file =
should maybe contain "clone",=20
since that seems to be the case for almost all test files in this =
series.

> 1 file changed, 104 insertions(+)
> create mode 100755 t/t5619-submodules-missing.sh
>=20
> diff --git a/t/t5619-submodules-missing.sh =
b/t/t5619-submodules-missing.sh
> new file mode 100755
> index 0000000000..d7878c52fc
> --- /dev/null
> +++ b/t/t5619-submodules-missing.sh
> @@ -0,0 +1,104 @@
> +#!/bin/sh
> +
> +test_description=3D'Clone a repo containing submodules. Sync to a =
revision where the submodule is missing or added'

"Sync" is confusing here ('git submodule sync" exists and does something =
completely different).=20
What this test is doing is a (recursive) *checkout* of a revision where =
the submodule exists,
starting from a revision where it's absent, with 'submodule.active' set =
to a pathspec that matches
that submodule.

> +
> +. ./test-lib.sh
> +
> +pwd=3D$(pwd)
> +
> +# Setup a super project with a submodule called `old`, which gets =
deleted, and
> +# a submodule `new` which is added later on.

As I showed in [1], we don't need the 'new' submodule to demonstrate the =
faulty
behaviour, so I would not include it in this test case,=20
it's adding unnecessary noise in my opinion.

> +
> +test_expect_success 'setup' '
> +	mkdir super old new &&
> +	git -C old init &&
> +	test_commit -C old commit_old &&
> +	(cd super &&
> +		git init . &&
> +		git submodule add ../old old &&
> +		git commit -m "adding submodule old" &&
> +		test_commit commit2 &&
> +		git tag OLD &&
> +		test_path_is_file old/commit_old.t &&
> +		git rm old &&
> +		git commit -m "Remove old submodule" &&
> +		test_commit commit3
> +	) &&
> +	git -C new init &&
> +	test_commit -C new commit_new &&
> +	(cd super &&
> +		git tag BEFORE_NEW &&
> +		git submodule add ../new new &&
> +		git commit -m "adding submodule new" &&
> +		test_commit commit4
> +	)
> +'
> +
> +# Checkout the OLD tag inside the original repo. This works fine =
since all of
> +# the submodules are present in .git/modules.
> +test_expect_success 'checkout old inside original repo' '
> +	(cd super &&
> +		git config advice.detachedHead false &&
> +		git tag LATEST &&

minor point: this 'tag' command should be in the "setup" test above.

> +		git checkout --recurse-submodules OLD &&
> +		git submodule update --checkout --remote --force &&

This invocation of 'git submodule update' does nothing here (the=20
submodule is already correctly checked out at the revision
registered in the superproject as a result of `git checkout =
--recurse-submodules OLD`)
so I would remove it.

> +
> +# Clone the repo, and then checkout the OLD tag inside the clone.
> +# The `old` submodule does not get updated

Minor point, but I would write "checked out" instead of "updated".

> . Instead we get:
> +#
> +# fatal: not a git repository: ../.git/modules/old
> +# fatal: could not reset submodule index
> +#
> +# That's because `old` is missing from .git/modules since it
> +# was not cloned originally

I would add a little bit of info here:

...since it was not clone originally, 'checkout' wants to recurse=20
into it because 'submodule.active' was set to '.' by 'clone =
--recurse-submodules',
and 'checkout' does not know how to....

> and `checkout` does not know how to
> +# fetch the remote submodules,

I think "clone" would be more appropriate then 'fetch" here.=20

> whereas `submodule update --remote` does.

I don't think you want to add '--remote' here.
What we want is to checkout the submodule at the revision
specified by the superproject at tag OLD, which is what a=20
plain 'git submodule update' should do. Adding '--remote'
would fetch the *submodule's remote* and checkout=20
the submodule at the commit at the tip of the HEAD branch of that
remote [2] (which in this specific case would be the same commit,=20
since no commit were done in the 'old' repo after it was added=20
as a submodule to 'super', but in general this does not have to=20
be the case).

> +
> +test_expect_failure 'checkout old with --recurse-submodules' '
> +	test_when_finished "rm -fr super-clone" &&
> +	git clone --recurse-submodules super super-clone &&
> +	(cd super-clone &&
> +		git config advice.detachedHead false &&
> +		test_path_is_file commit3.t &&
> +		test_path_is_file commit2.t &&
> +		test_path_is_missing old &&
> +		test_path_is_file new/commit_new.t &&
> +		git checkout --recurse-submodules OLD &&

The test case will fail here as the exit code of 'checkout' is 128,
so any further command don't affect the outcome of the test.
I think it's a good reflex to try 'git submodule update' next at this =
point,=20
and I agree that in an ideal world it should be able to help and clone
the missing submodule, but I think it should be tested in a new test,
 following this one.

> +		git submodule update --checkout --remote --force &&

As I wrote above '--remote' is not what we want here, and '--checkout'
is the default behaviour so unnecessary. Also, '--force' should not be =
necessary=20
to clone the submodule here since there is no revision checked out in it =
yet (see [3], [4]).

As I detailed in [5], "git submodule update" can't clone the submodule
until the whole .git/modules/old directory, which is written by the =
failing
'checkout --recurse-submodules', is manually deleted, so this would be=20=

an additional 'test_expect_failure' case.

> +# As above, but this time, instead of using "checkout =
--recurse-submodules" we just
> +# use "checkout" to avoid the missing submodule error.
> +#
> +# The checkout of `old` now works fine, but instead `new` is left =
lying
> +# around with seemingly no way to clean it up.

`git clean -dff` cleans it up.

> Even a later invocation of
> +# `git checkout --recurse-submodules` does not get rid of it.
> +
> +test_expect_failure 'checkout old without --recurse-submodules' '
> +	test_when_finished "rm -fr super-clone" &&
> +	git clone --recurse-submodules super super-clone &&
> +	(cd super-clone &&
> +		git config advice.detachedHead false &&
> +		test_path_is_file new/commit_new.t &&
> +		git checkout OLD &&
> +		git submodule update --checkout --remote --force &&
> +		git checkout --recurse-submodules OLD &&
> +		test_path_is_file commit2.t &&
> +		test_path_is_missing commit3.t &&
> +		test_path_is_dir old &&
> +		test_path_is_file old/commit_old.t &&
> +		test_path_is_missing new/commit_new.t
> +	)

I would simply remove this test case, it does not add new information.
After 'git checkout OLD', since '--recurse-submodules was not used,
the "new" submodules appears as "untracked",
so the command to remove it is "git clean", and since it contains a =
'.git'
gitfile, two '-f' are needed [6]. Since it is untracked, it makes sense =
that no
further Git command should touch it.

Thanks for working on this!

Philippe.

[1] =
https://lore.kernel.org/git/0B191753-C1AD-499C-B8B2-122F49CF6F14@gmail.com=
/T/#m85fe0b90231033c96d3d75bac6e8ea9b2ae6d467
[2] =
https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt---r=
emote
[3] =
https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt--f
[4] =
https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-upd=
ate--init--remote-N--no-fetch--no-recommend-shallow-f--force--checkout--re=
base--merge--referenceltrepositorygt--depthltdepthgt--recursive--jobsltngt=
--no-single-branch--ltpathgt82308203
[5] =
https://lore.kernel.org/git/20200501005432.h62dnpkx7feb7rto@glandium.org/T=
/#u
[6] https://git-scm.com/docs/git-clean#Documentation/git-clean.txt--f=
