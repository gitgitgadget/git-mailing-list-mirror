Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80341C35249
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 20:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEFC20679
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 20:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YGFHQEjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBBUyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 15:54:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:35937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgBBUyk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 15:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580676872;
        bh=IEwLf/9Rl+0F/RUsybTZBLD3dtHqc1RQAwXJ74GN4cI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YGFHQEjITTOrBMj22YhGytusfqFZ7v99xbdbyKJssjiWqZ0ftUGj7WFgbSALzt2+Y
         vND0LaF/hVgSDI9uqoBjVmbWN9T4ct7yWNG+QtG+/mkgzY/YJEn5fsVReJmKhe19/f
         UR/PR0as16lSlGrBj5XRkQ4nOUCotOaRYcQIVuNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUosT-1j6urp0h73-00Qfo0; Sun, 02
 Feb 2020 21:54:32 +0100
Date:   Sun, 2 Feb 2020 21:54:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bert Wesarg <bert.wesarg@googlemail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v4] remote rename/remove: gently handle remote.pushDefault
 config
In-Reply-To: <04a8673c3cb80802ee20fa4376872cb5ee464264.1580549512.git.bert.wesarg@googlemail.com>
Message-ID: <nycvar.QRO.7.76.6.2002021911260.46@tvgsbejvaqbjf.bet>
References: <04a8673c3cb80802ee20fa4376872cb5ee464264.1580549512.git.bert.wesarg@googlemail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DQfzYe6oQ2vdy9ZehrLulkEb0l9SFnMVa0RzxEMU+1kXfBdkwdk
 1Udv5MVLr2NPTGa2aDLtDnBVdJOp/SPFaoVOnfbZ4NVzk27hMC6RDkDpbUgjuvAdnxhYfo/
 gnnNPROiY0xsXkKNVjpuH6zrTMaPQt8vB6FXDGxINydaCDLToN1nlZZIkXXI97y01Mlb5GQ
 lTsGUWXfedhHZ03eIozyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2myGu+3oTkE=:nzcGKF0lUIUxi+rS5SQw/9
 9V6lJVitXQcl8b85ucgfwK7f4B5DeH+Pg8rM1qu6g3Y9TW/I9+VExHYLEk+wWxTcJane8tp+Q
 2ioM8tRx7DEODH6rfKNzEigB4jk/bTcwZD4tRQYiBk1fd58h3rJ4rGjfZMTXqFGP1ZbmheSdJ
 y9WrELGRZsdsmT00YIr27BydU1mF9yQkkLtg1GDM4UMW13gzqpPaaRhZGP9xpyjKtQbAzweBN
 VUKlAKY3iROUy6Cs4JyybxzTCoIN2xDWCVMNfZCZCgM7WXT9FxcOyC2XHkCCL0QirFVOyF3GW
 mKvDSiYTQ0hALRrDL/zoY0Q7xLLwj5BvtDhfbiOokLzM3ntN0dB2RREclhfQfy3SJ7AXdvGJA
 Isr6U/4s4zvtRn4aWUWv50VOGjUugZtzihDQZTUJdxMVeTQgXaBBimq426bbJqyKl4BKl8Ofp
 /UgxtCtmR/cQZO60WYK5TwRy9l/LT6qKuY3AfdDbyWp+grO4UcqkpcdPD7QwNDimxU+3ReFEe
 cPzFla2z4YT68GBKW1YjFzfRzjGQRhByP+F+sVnh65bYJhGDctAKBVbjksd5qIB0ffjj6Mcnq
 xOqMe86UG1Ff+s//ma0Uy8lu+ObD7d9xzCVyw2iNSp9SbGkTfhRLzyqhIunnWeUd4Q0/xNe/M
 V58SEVkyTqkKNg2aUgDF2/PFoQwyuPaPGy6XxU82i2h0nMEfyoOM8gqlYTL5wDPeKggsVVkM4
 wBGgQjB+33coo/tYWV1WQexmAEzTpfNCCCoJKdFhZ5MhIkScrJZUj3u4cbtiS81ZYuFg2YsIV
 EOoQDvCLs9+QCbWlCxSxCbtCOnzIzyAKBTuokk2s942E98R9MH5DRrtn0umj4ga8zB5C41mue
 rLVpV28w6HRZoBjnkdOxkPSudVmHBLktX064y3jdmazAuZ63fZmzB9rDcV0YvLWk8HV2Zqifp
 wm+OLz+aH/bQb/w3HT9A5qFnd1V2c9Lp+XvHYIbUnljKZI4fx0rxPojBtPM1HfzWsYZlUlJVq
 ORl+pDmJSHC037YepKD+diYZTACpYJmqsDWkeTYcxUi5IEW/RywsSDHLI33FJC2AUg0KrjUz5
 Klm2rEJU2QGt7TvKUocFG7iNSJoJKzfrZtJ+HhsOrL14fq6ZoRw0FFtRT+BdCIXx8vKVQ159D
 dWkSvYWAu2zRvMp7FUrLU+SJZlzHLi04rEiaKkkvRpLI7ppSlSUaxy6KOaQfi5MeSs/lmkOZr
 mJtXocEIQM+haViAx
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,

On Sat, 1 Feb 2020, Bert Wesarg wrote:

> When renaming a remote with
>
>     git remote rename X Y
>     git remote remove X
>
> Git already renames or removes any branch.<name>.remote and
> branch.<name>.pushRemote configurations if their value is X.
>
> However remote.pushDefault needs a more gentle approach, as this may be
> set in a non-repo configuration file. In such a case only a warning is
> printed, such as:
>
> warning: The global configuration remote.pushDefault in:
> 	$HOME/.gitconfig:35
> now names the non-existent remote origin
>
> It is changed to remote.pushDefault =3D Y or removed when set in a repo
> configuration though.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

Very clear commit message. Thank you!

> diff --git a/builtin/remote.c b/builtin/remote.c
> index a2379a14bf..5af06b74a7 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -615,6 +615,55 @@ static int migrate_file(struct remote *remote)
>  	return 0;
>  }
>
> +struct push_default_info
> +{
> +	const char *old_name;
> +	enum config_scope scope;
> +	struct strbuf origin;
> +	int linenr;
> +};
> +
> +static int config_read_push_default(const char *key, const char *value,
> +	void *cb)
> +{
> +	struct push_default_info* info =3D cb;
> +	if (strcmp(key, "remote.pushdefault") || strcmp(value, info->old_name)=
)
> +		return 0;

We will have to be careful to not segfault if a user has this in their
config:

	[remote]
		pushDefault

i.e. we have to insert `!value || ` before the call to `strcmp()`.

It does not make much sense not to specify a value, of course, but we
should not segfault in such a case, either.

> +
> +	info->scope =3D current_config_scope();

Do we want to care about the case where above-mentioned invalid
`remote.pushDefault` is configured _and_ overrides an otherwise-valid
setting in `~/.gitconfig`?

Or for that matter, shouldn't we be careful to handle the case where `git
config --global remote.pushDefault` returns `old_name` but that is
overridden by a different `git config --local remote.pushDefault`?

Concretely, I believe that the patched code will misbehave in this
scenario:

	git config --global remote.pushDefault january
	git config remote.pushDefault february
	git remote rename january march

If I read the patch right, this will incorrectly warn about the
`pushDefault` setting in the user-wide config.

> +	strbuf_reset(&info->origin);
> +	strbuf_addstr(&info->origin, current_config_name());
> +	info->linenr =3D current_config_line();
> +
> +	return 0;
> +}
> +
> +static void handle_push_default(const char* old_name, const char* new_n=
ame)

That name probably wants to convey better that the push default is handled
in the `mv`/`rm` commands here, not in any other command. Maybe
`handle_modified_push_default_remote()`?

> +{
> +	struct push_default_info push_default =3D {
> +		old_name, CONFIG_SCOPE_UNKNOWN, STRBUF_INIT, -1 };

Personally, I would prefer the closing bracket to be on a new line,
followed by an empty line to separate the variable declaration from the
following statements.

> +	git_config(config_read_push_default, &push_default);
> +	if (push_default.scope >=3D CONFIG_SCOPE_COMMAND)
> +		; /* pass */
> +	else if (push_default.scope >=3D CONFIG_SCOPE_LOCAL) {
> +		int result =3D git_config_set_gently("remote.pushDefault",
> +						   new_name);
> +		if (new_name && result && result !=3D CONFIG_NOTHING_SET)
> +			die(_("could not set '%s'"), "remote.pushDefault");

Isn't this more like a `BUG()`? Or do you see any valid scenario where
this could happen? If you do, it may make a lot of sense to call
`die_errno()` here, to give the user _some_ sort of an actionable insight
as to what went wrong.

> +		else if (!new_name && result && result !=3D CONFIG_NOTHING_SET)
> +			die(_("could not unset '%s'"), "remote.pushDefault");

Same here.

> +	} else if (push_default.scope >=3D CONFIG_SCOPE_SYSTEM) {
> +		/* warn */
> +		warning(_("The %s configuration remote.pushDefault in:\n"
> +			  "\t%s:%d\n"
> +			  "now names the non-existent remote '%s'"),
> +			config_scope_name(push_default.scope),
> +			push_default.origin.buf, push_default.linenr,
> +			old_name);
> +	}
> +}
> +
> +
>  static int mv(int argc, const char **argv)
>  {
>  	struct option options[] =3D {
> @@ -750,6 +799,9 @@ static int mv(int argc, const char **argv)
>  			die(_("creating '%s' failed"), buf.buf);
>  	}
>  	string_list_clear(&remote_branches, 1);
> +
> +	handle_push_default(rename.old_name, rename.new_name);
> +
>  	return 0;
>  }
>
> @@ -835,6 +887,8 @@ static int rm(int argc, const char **argv)
>  		strbuf_addf(&buf, "remote.%s", remote->name);
>  		if (git_config_rename_section(buf.buf, NULL) < 1)
>  			return error(_("Could not remove config section '%s'"), buf.buf);
> +
> +		handle_push_default(remote->name, NULL);
>  	}
>
>  	return result;
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 082042b05a..dda81b7d07 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -734,6 +734,7 @@ test_expect_success 'reject adding remote with an in=
valid name' '
>  # the last two ones check if the config is updated.
>
>  test_expect_success 'rename a remote' '
> +	test_config_global remote.pushDefault origin &&
>  	git clone one four &&
>  	(
>  		cd four &&
> @@ -744,7 +745,42 @@ test_expect_success 'rename a remote' '
>  		test "$(git rev-parse upstream/master)" =3D "$(git rev-parse master)"=
 &&
>  		test "$(git config remote.upstream.fetch)" =3D "+refs/heads/*:refs/re=
motes/upstream/*" &&
>  		test "$(git config branch.master.remote)" =3D "upstream" &&
> -		test "$(git config branch.master.pushRemote)" =3D "upstream"
> +		test "$(git config branch.master.pushRemote)" =3D "upstream" &&
> +		test "$(git config --global remote.pushDefault)" =3D "origin"
> +	)
> +'
> +
> +test_expect_success 'rename a remote renames repo remote.pushDefault' '
> +	git clone one four.1 &&

I am not sure that a full clone is warranted here. Maybe use
`--no-checkout` here and in the subsequent test cases? Omitting that
option makes the tests only slower for no gain.

> +	(
> +		cd four.1 &&
> +		git config remote.pushDefault origin &&
> +		git remote rename origin upstream &&
> +		test "$(git config --local remote.pushDefault)" =3D "upstream"
> +	)
> +'
> +
> +test_expect_success 'rename a remote renames repo remote.pushDefault bu=
t ignores global' '
> +	test_config_global remote.pushDefault other &&
> +	git clone one four.2 &&
> +	(
> +		cd four.2 &&
> +		git config remote.pushDefault origin &&
> +		git remote rename origin upstream &&
> +		test "$(git config --global remote.pushDefault)" =3D "other" &&
> +		test "$(git config --local remote.pushDefault)" =3D "upstream"
> +	)
> +'
> +
> +test_expect_success 'rename a remote renames repo remote.pushDefault bu=
t keeps global' '
> +	test_config_global remote.pushDefault origin &&
> +	git clone one four.3 &&
> +	(
> +		cd four.3 &&
> +		git config remote.pushDefault origin &&
> +		git remote rename origin upstream &&
> +		test "$(git config --global remote.pushDefault)" =3D "origin" &&
> +		test "$(git config --local remote.pushDefault)" =3D "upstream"

A lot of tests added. Personally, I would have probably only extended the
existing `rename a remote` to verify that a repository-local
`remote.pushDefault` _is_ renamed, and then added one test case that
verifies that not only is a user-wide `remote.pushDefault` left alone but
also warned about.

>  	)
>  '
>
> @@ -787,6 +823,7 @@ test_expect_success 'rename succeeds with existing r=
emote.<target>.prune' '
>  '
>
>  test_expect_success 'remove a remote' '
> +	test_config_global remote.pushDefault origin &&
>  	git clone one four.five &&
>  	(
>  		cd four.five &&
> @@ -794,7 +831,42 @@ test_expect_success 'remove a remote' '
>  		git remote remove origin &&
>  		test -z "$(git for-each-ref refs/remotes/origin)" &&
>  		test_must_fail git config branch.master.remote &&
> -		test_must_fail git config branch.master.pushRemote
> +		test_must_fail git config branch.master.pushRemote &&
> +		test "$(git config --global remote.pushDefault)" =3D "origin"
> +	)
> +'
> +
> +test_expect_success 'remove a remote removes repo remote.pushDefault' '
> +	git clone one four.five.1 &&
> +	(
> +		cd four.five.1 &&
> +		git config remote.pushDefault origin &&
> +		git remote remove origin &&
> +		test_must_fail git config --local remote.pushDefault

Now that I see this sort of "in action", I have to wonder whether I would
be okay with a `remote.pushDefault` simply vanishing. I think that would
puzzle me ("Didn't I set a push default before? I must be getting old and
delusional."). In the least, I would want to see a warning here ("As the
remote 'xyz' was deleted, so was the `remote.pushDefault =3D xyz` setting"
or some such).

It strikes me as a fundamentally different thing whether we simply
re-target or delete a `pushDefault` setting. The former needs no further
warning, but the latter does.

> +	)
> +'
> +
> +test_expect_success 'remove a remote removes repo remote.pushDefault bu=
t ignores global' '
> +	test_config_global remote.pushDefault other &&
> +	git clone one four.five.2 &&
> +	(
> +		cd four.five.2 &&
> +		git config remote.pushDefault origin &&
> +		git remote remove origin &&
> +		test "$(git config --global remote.pushDefault)" =3D "other" &&
> +		test_must_fail git config --local remote.pushDefault
> +	)
> +'
> +
> +test_expect_success 'remove a remote removes repo remote.pushDefault bu=
t keeps global' '
> +	test_config_global remote.pushDefault origin &&
> +	git clone one four.five.3 &&
> +	(
> +		cd four.five.3 &&
> +		git config remote.pushDefault origin &&
> +		git remote remove origin &&
> +		test "$(git config --global remote.pushDefault)" =3D "origin" &&
> +		test_must_fail git config --local remote.pushDefault

Since the `mv` case already covers those code paths, I would be a lot more
parsimonious in adding test cases for `rm`.

There are voices claiming that adding regression tests is always a good
thing, but I would counter that it has to strike a balance between
coverage and runtime. We see a more and more contributions -- even from
long-time contributors -- where the test suite obviously has not been run
(because the CI builds are failing, and there is no doubt that seasoned
contributors in particular would fix those failures before contributing
their patches, _if_ they were aware of those test failures), proving just
how costly our test suite has become.

Other than that, the patch looks fine to me. Thank you,
Dscho

>  	)
>  '
>
> --
> 2.25.0.30.g00ce2e43d4
>
>
