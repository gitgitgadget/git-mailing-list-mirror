Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7729CC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2201C2389F
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgLGSmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgLGSmw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:42:52 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9106CC061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 10:42:12 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h20so13505487qkk.4
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 10:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lSH3UrpWckoy8GU8mgiytLp558YYgwnjmXOG6fo4yIc=;
        b=L79HBOuMZZX2rGUFqWCfrrGFu69Zyes2ti/9lDIcZcoqGt85IKEFKotrQg5ekmkNSj
         gTmaDNmemE5Nc0P1+Qa7TFW5eij75gZdMj/fv+OPaofqwnijFw3kut15TeRtTCTwlB3C
         GW5BgkDFrLDo6tGRnbheS2mqWnXv7dnac8CQSUyC640mjOdMil4kWcUUqzC4+WhhB4P/
         J9XiwgIJqe09fGGlrLCCBMaAKXQnFbxicXTO7KM+uPbuyFr/3In3bki9rhkC4T+JpRG2
         xXUQkUR/BMw+XERhipdTiPsqF74wltcNIoBJ91EC3o40JGnxrj6+Fg03/U/yprNxftEj
         +j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lSH3UrpWckoy8GU8mgiytLp558YYgwnjmXOG6fo4yIc=;
        b=Vom2HPGCl+UiRcYrf95IedCsTe2NaPAcZRAtPgrKOy/Y6mcl8qEIeyDfI0Y6CZNZx2
         1lLnuhzLqiQW36yAn5UDYU1M4uQd/Cj69g4L341Jk6B65/7m1I08wqS1T2IkZKOZwARn
         nGSFytmF7Uji2Q7ko4WMLkZEJpN+NrBJKdrDnIEsYNNrKvX2RhD45q1tWbEY1gL/7LmH
         u8OqNZyPgReVKVmh4qc3ql4wZJ8X3NCY2dJpO48SMVylN3UF4y+W3YlTwncMm6SoX7uP
         ry1Lwd7NJ/OS6Fj40F4HphRKjRh+2qlysfZq7meB6w1epr+HQ4fgspGk8yvDX1s0dgyw
         vIqA==
X-Gm-Message-State: AOAM533GUBm2dio9WEajml9xPA29wB0fVY5xFycRzNebTNzTYevzppTT
        tEm8fsMk30j6Dlzl9Kw+9Xg=
X-Google-Smtp-Source: ABdhPJzxWTK+TxAZS/pLz61xYD+htJm6nmpri5Ewv+xvuxi9L/J4ndGA+ETnbSC0AOJTVlQLvVwcTw==
X-Received: by 2002:a05:620a:55b:: with SMTP id o27mr25039484qko.226.1607366531796;
        Mon, 07 Dec 2020 10:42:11 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id c65sm12332874qkf.47.2020.12.07.10.42.10
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 07 Dec 2020 10:42:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] submodules: fix of regression on fetching of non-init subsub-repo
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
Date:   Mon, 7 Dec 2020 13:42:08 -0500
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <613FAD04-0D5A-4DE0-8FE8-0C5C5619B7BC@gmail.com>
References: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com> <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
To:     Peter Kaestle <peter.kaestle@nokia.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

> Le 7 d=C3=A9c. 2020 =C3=A0 08:46, Peter Kaestle =
<peter.kaestle@nokia.com> a =C3=A9crit :
>=20
> A regression has been introduced by a62387b (submodule.c: fetch in
> submodules git directory instead of in worktree, 2018-11-28).
>=20
> The scenario in which it triggers is when one has a remote repository
> with a subrepository inside a subrepository like this:
> superproject/middle_repo/inner_repo

The correct terminology is "submodule", not "subrepository".=20

Also, (minor point) I would just write "when one has a repository",=20
as its simpler (the repository by itself is not "remote", it is only =
"remote"=20
in relation the repositories that are cloned from it).

> Person A and B have both a clone of it, while Person B is not working
> with the inner_repo and thus does not have it initialized in his =
working
> copy.
>=20
> Now person A introduces a change to the inner_repo and propagates it
> through the middle_repo and the superproject.
>=20
> Once person A pushed the changes and person B wants to fetch them =
using
> "git fetch" on superproject level,

s/on/at the/

> B's git call will return with error
> saying:
>=20
> Could not access submodule 'inner_repo'
> Errors during submodule fetch:
>         middle_repo
>=20
> Expectation is that in this case the inner submodule will be =
recognized
> as uninitialized subrepository and skipped by the git fetch command.

here again, terminology: "as an uninitialized submodule"=20

> This used to work correctly before 'a62387b (submodule.c: fetch in
> submodules git directory instead of in worktree, 2018-11-28)'.
>=20
> Starting with a62387b the code wants to evaluate "is_empty_dir()" =
inside
> .git/modules for a directory only existing in the worktree, delivering
> then of course wrong return value.
>=20
> This patch ensures is_empty_dir() is getting the correct path of the
> uninitialized submodule by concatenation of the actual worktree and =
the
> name of the uninitialized submodule.
>=20
> Furthermore a regression test case is added, which tests for recursive
> fetches on a superproject with uninitialized sub repositories.
>  This
> issue was leading to an infinite loop when doing a revert of a62387b.

I would maybe add more details here, something like the following=20
(we can cite your previous attempt, because it was merged to 'master'):

The first attempt to fix this regression, in 1b7ac4e6d4 (submodules:=20
fix of regression on fetching of non-init subsub-repo, 2020-11-12), by =
simply
reverting a62387b, resulted in
an infinite loop of submodule fetches in the simpler case of a recursive =
fetch of a superproject with
uninitialized submodules, and so this commit was reverted in 7091499bc0 =
(Revert=20
"submodules: fix of regression on fetching of non-init subsub-repo", =
2020-12-02).
To prevent future breakages, also add a regression test for this =
scenario.

>=20
> Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
> CC: Junio C Hamano <gitster@pobox.com>
> CC: Philippe Blain <levraiphilippeblain@gmail.com>
> CC: Ralf Thielow <ralf.thielow@gmail.com>
> CC: Eric Sunshine <sunshine@sunshineco.com>
> ---
> submodule.c                 |   7 ++-
> t/t5526-fetch-submodules.sh | 104 ++++++++++++++++++++++++++++++++++++
> 2 files changed, 110 insertions(+), 1 deletion(-)
>=20
> diff --git a/submodule.c b/submodule.c
> index b3bb59f066..b561445329 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1477,6 +1477,7 @@ static int get_next_submodule(struct =
child_process *cp,
> 			strbuf_release(&submodule_prefix);
> 			return 1;
> 		} else {
> +			struct strbuf empty_submodule_path =3D =
STRBUF_INIT;
>=20
> 			fetch_task_release(task);
> 			free(task);
> @@ -1485,13 +1486,17 @@ static int get_next_submodule(struct =
child_process *cp,
> 			 * An empty directory is normal,
> 			 * the submodule is not initialized
> 			 */
> +			strbuf_addf(&empty_submodule_path, "%s/%s/",
> +							=
spf->r->worktree,
> +							ce->name);
> 			if (S_ISGITLINK(ce->ce_mode) &&
> -			    !is_empty_dir(ce->name)) {
> +			    !is_empty_dir(empty_submodule_path.buf)) {
> 				spf->result =3D 1;
> 				strbuf_addf(err,
> 					    _("Could not access =
submodule '%s'\n"),
> 					    ce->name);
> 			}
> +			strbuf_release(&empty_submodule_path);
> 		}
> 	}


Maybe a personal preference, but I would have gone for something a =
little simpler, like the following:


diff --git a/submodule.c b/submodule.c
index b3bb59f066..4200865174 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1486,7 +1486,7 @@ static int get_next_submodule(struct child_process =
*cp,
                         * the submodule is not initialized
                         */
                        if (S_ISGITLINK(ce->ce_mode) &&
-                           !is_empty_dir(ce->name)) {
+                           !is_empty_dir(repo_worktree_path(spf->r, =
"%s", ce->name))) {
                                spf->result =3D 1;
                                strbuf_addf(err,
                                            _("Could not access =
submodule '%s'\n"),

> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index dd8e423d25..666dd1e2b7 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -719,4 +719,108 @@ test_expect_success 'fetch new submodule commit =
intermittently referenced by sup
> 	)
> '
>=20
> +add_commit_push () {
> +	dir=3D"$1" &&
> +	msg=3D"$2" &&
> +	shift 2 &&
> +	git -C "$dir" add "$@" &&
> +	git -C "$dir" commit -a -m "$msg" &&
> +	git -C "$dir" push
> +}
> +
> +compare_refs_in_dir () {
> +	fail=3D &&
> +	if test "x$1" =3D 'x!'
> +	then
> +		fail=3D'!' &&
> +		shift
> +	fi &&
> +	git -C "$1" rev-parse --verify "$2" >expect &&
> +	git -C "$3" rev-parse --verify "$4" >actual &&
> +	eval $fail test_cmp expect actual
> +}
> +
> +
> +test_expect_success 'setup nested submodule fetch test' '
> +	# does not depend on any previous test setups
> +
> +	for repo in outer middle inner
> +	do
> +		git init --bare $repo &&
> +		git clone $repo ${repo}_content &&
> +		echo "$repo" >"${repo}_content/file" &&
> +		add_commit_push ${repo}_content "initial" file ||
> +		return 1
> +	done &&
> +
> +	git clone outer A &&
> +	git -C A submodule add "$pwd/middle" &&
> +	git -C A/middle/ submodule add "$pwd/inner" &&
> +	add_commit_push A/middle/ "adding inner sub" .gitmodules inner =
&&
> +	add_commit_push A/ "adding middle sub" .gitmodules middle &&
> +
> +	git clone outer B &&
> +	git -C B/ submodule update --init middle &&
> +
> +	compare_refs_in_dir A HEAD B HEAD &&
> +	compare_refs_in_dir A/middle HEAD B/middle HEAD &&
> +	test_path_is_file B/file &&
> +	test_path_is_file B/middle/file &&
> +	test_path_is_missing B/middle/inner/file &&
> +
> +	echo "change on inner repo of A" >"A/middle/inner/file" &&
> +	add_commit_push A/middle/inner "change on inner" file &&
> +	add_commit_push A/middle "change on inner" inner &&
> +	add_commit_push A "change on inner" middle
> +'
> +
> +test_expect_success 'fetching a superproject containing an =
uninitialized sub/sub project' '
> +	# depends on previous test for setup
> +
> +	git -C B/ fetch &&
> +	compare_refs_in_dir A origin/master B origin/master
> +'
> +
> +
> +test_expect_success 'setup recursive fetch with uninit submodule' '
> +	# does not depend on any previous test setups
> +
> +	git init main &&
> +	git init sub &&
> +
> +	>sub/file &&
> +	git -C sub add file &&
> +	git -C sub commit -m "add file" &&
> +	git -C sub rev-parse HEAD >expect &&
> +
> +	git -C main submodule add ../sub &&
> +	git -C main submodule init &&
> +	git -C main submodule update --checkout &&

These two steps are unnecessary as they are implicitly done by 'git =
submodule add'.
I think we could reflect real life a little bit more by cloning the =
superproject, and running
the 'recursive fetch with uninit submodule' test below in the clone.

> +	git -C main submodule status >out &&
> +	sed -e "s/^ //" -e "s/ sub .*$//" out >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'recursive fetch with uninit submodule' '
> +	# depends on previous test for setup
> +
> +	git -C main submodule deinit -f sub &&

Here you are deiniting the submodule, such that=20
the Git directory will stay in .git/modules/sub. This is not the same =
thing
as a submodule that was never initialized ("uninitialized"), for which =
.git/modules/sub
will not yet exist. So maybe we could harden the tests by also testing
for that scenario ? I don't know... maybe the infinite loop only happens
if .git/modules/sub actually already exists. If so, the test name should =
be
"recursive fetch with deinitialized submodule", I think.

> +
> +	# In a regression the following git call will run into infinite =
recursion.
> +	# To handle that, we connect the grep command to the git call by =
a pipe
> +	# so that grep can kill the infinite recusion when detected.
> +	# The recursion creates git output like:
> +	# Fetching submodule sub
> +	# Fetching submodule sub/sub              <-- [1]
> +	# Fetching submodule sub/sub/sub
> +	# ...
> +	# [1] grep will trigger here and kill git by exiting and closing =
its stdin
> +
> +	! git -C main fetch --recurse-submodules 2>&1 |
> +		grep -v -m1 "Fetching submodule sub$" &&
> +	git -C main submodule status >out &&
> +	sed -e "s/^-//" -e "s/ sub$//" out >actual &&
> +	test_cmp expect actual
> +'
> +
> test_done


Thanks for working on that, and sorry for not having the time to comment =
before
you sent v2.

Cheers,

Philippe.=
