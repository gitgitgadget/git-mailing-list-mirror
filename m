Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE88C433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 09:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562C2619AB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 09:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhC3JzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 05:55:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:33069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbhC3Jyp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 05:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617098074;
        bh=3gKBnyzfO5jSj8S39xfVSez49IYiBXP+XS0JSWBnNyc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=O8HDT4h6efRvL55AChO8HO3MOLUW5PoogaI5Zlr9nMi9gxR2/egKFYuA7KShm4cjS
         7GIg5NcK1hN/S/4uzKV28xb/oT6GzX0/PzBKpLgnEoioNp/Wd3tWkymDZz7kuhkjwm
         IduiilosLdbG4U3GyeeBrwy3zRZZlmFNOKyD0d6c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.127.121] ([213.196.213.200]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1ld2bV40fU-0137iY; Tue, 30
 Mar 2021 11:54:34 +0200
Date:   Tue, 30 Mar 2021 11:54:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Li Linchao <lilinchao@oschina.cn>,
        lilinchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v8] builtin/clone.c: add --reject-shallow option
In-Reply-To: <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103301110040.52@tvgsbejvaqbjf.bet>
References: <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com> <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uv7Y0zorvapZVug/wimT3/SQbNfVKfYBsDfzFY9fiHZT5Gnycsi
 8BL9Wo1K8q26OHavxHx88hBAmtH+Wjgy+29p8Ue51WhRtZXDZDyWAGBwiXe5VnThSRf/6aE
 BaW5oaZO83DMIsAYggZ2qswLHYv64+UUUhYfuNRPbeN/Lk0h2OO9zZZxuPufYvw4IrMGx8Q
 +BTTn8W6MgSypoJfxjxNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0://faCBGmZpI=:N9+bjZVtzujexdVj4cXRX7
 mIkdlerNqzBfDeW3YFXnq+J4JAO+OFSQfeN1Oe83Cq9lVFdeQkXqWI4LkTyTu04Y+ZZZTkk3k
 S/3ABt6GOYM9XmHISHZnw/fmnGOQejUdNbY4Fo2MW8wY8sGVaCS618/kmbEXV6tRqRl2Q1/hB
 Yft6lQyQWK+H0NgVxLeGS1EXs8k9HtzBmlL10puY05oFoq7FL9wMotPLA87dKLwhzy/GhQcjN
 s36m2eMZ7RX8vqe8QKrpMbLm6bv2JM4cLzbt8ZOdcOurrQ6viwQC2JCI5KsMsSfJa8+UxPlkp
 WRJYdP7w54YpyZ67X62RNI1fwCQnve9tFid5OBuMZqtw0neiMDvWntdTf7LhmB72dn7S7t5ud
 hVf8DV8wM5mREPjFfpRr1gA7kNgzF6qK4P/XI0+JkO9daO8C7RKxrUxA96hv74Bbmhy6SpoF7
 EPbi1s/mb8q59A8ef4RFIK2nDNtkdxVNUNIujx2neLij2Mi+JEfnsvGzqDTiCY1W+zB1U0/4M
 kbm/yW6vicSy8MZ/AJJcW1tk7A13vHtAT/+rMsGZJyt4GZ7x8FhFc+k5yuu/oaad5G99BZcs7
 +9SaK0mQo7dnKDvidEe1QJynZRnBsNoR0C17v2LKgM37ty6ChV9zLjk/FQpvuE8gIwLRRNuV4
 hrX+Nts+Xr4GWehqvD/6r/+G5aPJReKSdB9/gkJQ8EnM+leZqeDZ5wHKjzWrW6x7KQXg3IKEc
 0KLdDTePsMlLlDcoHVyvK6H8kruIJm6wMFhdeorxJJo97J/VYTFkTtCKBYMIitB+9UmxYxYjH
 iyYxVNtn8mqzmBudePlu1mZepcN14bqJlkigBb6F1IJA1A0NRIMNEvmpUK2eg+LPuugu3hnE5
 MIzezSxv/+koFRQ0ZZ7SAKiIhCSDPgJqEqjsGfvT+T7tkHivLzoImfBH02rtnRnmSnMWTVofn
 veSMK8jE2a8Lp9mgJIXuqIg/zRwKb388674LaVHqXTsNKNJGf8PCOTFk487wuamln38uA1sLp
 rxTLNZHSG8Lm3sCCOhsGn7xmJ4sDBLt4g5JOsmHfl2OjpcNZkWkJU10nWER+u+fK9BJ+8nheQ
 3x5ay5gI2Ppg7EuD/F6GETTqtyn745Ud5ozEzOF3k8C++B42xPpFHqFWoH3C4XaFLEs8jazl1
 VV9VceAVvVOF/HQV9bIhSS4j2VCfvI6bps3GOtj2B8f1M3xY0y61Zr9iFb23JxSghGbusPrDQ
 jK6pXzgZKDCeOF1Dc
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 29 Mar 2021, Li Linchao via GitGitGadget wrote:

> From: lilinchao <lilinchao@oschina.cn>

I see "Li Linchao" in the email, but "lilinchao" in the author
information. Maybe you want to align them? Or maybe even use Unicode to
write your non-Latinized name?

> In some scenarios, users may want more history than the repository
> offered for cloning, which happens to be a shallow repository, can
> give them. But because users don't know it is a shallow repository
> until they download it to local, users should have the option to
> refuse to clone this kind of repository, and may want to exit the
> process immediately without creating any unnecessary files.
>
> Althought there is an option '--depth=3Dx' for users to decide how
> deep history they can fetch, but as the unshallow cloning's depth
> is INFINITY, we can't know exactly the minimun 'x' value that can
> satisfy the minimum integrity, so we can't pass 'x' value to --depth,
> and expect this can obtain a complete history of a repository.
>
> In other scenarios, if we have an API that allow us to import external
> repository, and then perform various operations on the repo.
> But if the imported is a shallow one(which is actually possible), it
> will affect the subsequent operations. So we can choose to refuse to
> clone, and let's just import a normal repository.
>
> This patch offers a new option '--reject-shallow' that can reject to
> clone a shallow repository.

Good.

I like most of the patch, and will only point out a couple of things that
I think can be improved even further.

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 02d9c19cec75..0adc98fa7eee 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -149,6 +149,11 @@ objects from the source repository into a pack in t=
he cloned repository.
>  --no-checkout::
>  	No checkout of HEAD is performed after the clone is complete.
>
> +--[no-]reject-shallow::
> +	Fail if the source repository is a shallow repository.
> +	The 'clone.rejectShallow' configuration variable can be used to
> +	give the default.

I am not a native speaker, either, but I believe that it would "roll off
the tongue" a bit better to say "to specify the default".

> +
>  --bare::
>  	Make a 'bare' Git repository.  That is, instead of
>  	creating `<directory>` and placing the administrative
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 51e844a2de0a..eeddd68a51f4 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -50,6 +50,8 @@ static int option_no_checkout, option_bare, option_mir=
ror, option_single_branch
>  static int option_local =3D -1, option_no_hardlinks, option_shared;
>  static int option_no_tags;
>  static int option_shallow_submodules;
> +static int option_shallow =3D -1;    /* unspecified */
> +static int config_shallow =3D -1;    /* unspecified */

I would much prefer those variable names to include an indicator that this
is about _rejecting_ shallow clones. I.e. `option_reject_shallow`.

Also, I think that we can do with just a single `option_reject_shallow`
(we do not even need that `reject_shallow` variable in `cmd_clone()`):

- in `git_clone_config()`, only override it if it is still unspecified:

	if (!strcmp(k, "clone.rejectshallow") && option_reject_shallow < 0)
		option_reject_shallow =3D git_config_bool(k,v);

- in `cmd_clone()`, test for a _positive_ value:

	if (option_reject_shallow > 0)
		die(_("source repository is shallow, reject to clone."));

  and

	if (option_reject_shallow > 0)
 		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");

One thing to note (in the commit message, would be my preference) is that
`cmd_clone()` is _particular_ in that it runs `git_config()` _twice_. Once
before the command-line options are parsed, and once after the new Git
repository has been initialized. Note that my suggestion still works with
that: if either the original config, or the new config set
`clone.rejectShallow`, it is picked up correctly, with the latter
overriding the former if both configs want to set it.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index fb04a76ca263..34d0c2896e2e 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1129,9 +1129,11 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
>  	if (args->deepen)
>  		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
>  					NULL);
> -	else if (si->nr_ours || si->nr_theirs)
> +	else if (si->nr_ours || si->nr_theirs) {
> +		if (args->remote_shallow)

Even as a non-casual reader, this name `remote_shallow` leads me to assume
incorrect things. This option is not about wanting a remote shallow
repository, it is about rejecting a remote shallow repository.

Please name this attribute `reject_shallow` instead of `remote_shallow`.
That will prevent future puzzlement.

> +			die(_("source repository is shallow, reject to clone."));
>  		alternate_shallow_file =3D setup_temporary_shallow(si->shallow);
> -	else
> +	} else
>  		alternate_shallow_file =3D NULL;
>  	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
>  		     &gitmodules_oids))
> [...]
> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index 428b0aac93fa..de1cd85983ed 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -5,6 +5,8 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd

That's not good. What happens if there is no `httpd`? Then the rest of the
tests are either skipped, or if `GIT_TEST_HTTPD` is set to `true`, we
fail. The failure is intentional, but the skipping is not. There are many
tests in t5606 that do not require a running HTTP daemon, and we should
not skip them (for example, in our CI runs, there are quite a few jobs
that run without any working `httpd`).

A much better alternative, I think, would be to move those new test cases
that require `httpd` to be running to t5601 (which _already_ calls
`start_httpd`, near the end, so as to not skip any tests that do not
require `httpd`).

>
>  test_expect_success 'setup' '
>
> @@ -45,6 +47,51 @@ test_expect_success 'disallows --bare with --separate=
-git-dir' '
>
>  '
>
> +test_expect_success 'reject cloning http shallow repository' '
> +	git clone --depth=3D1 --no-local parent shallow-repo &&
> +	git clone --bare --no-local shallow-repo "$HTTPD_DOCUMENT_ROOT_PATH/re=
po.git" &&
> +	test_must_fail git clone --reject-shallow $HTTPD_URL/smart/repo.git ou=
t 2>err &&
> +	test_i18ngrep -e "source repository is shallow, reject to clone." err
> +
> +'
> +
> +test_expect_success 'reject cloning shallow repository' '
> +	rm -rf shallow-repo &&

Should this line not come immediately after the bare clone into
<DOCUMENT_ROOT>/repo.git? Or even better, as a `test_when_finished`
command.

And maybe you want to extract this preparatory step into its own test
case:

test_expect_success 'set up shallow http repository' '
	test_when_finished "rm -rf shallow-repo" &&
	git clone --depth=3D1 --no-local parent shallow-repo &&
	git clone --bare --no-local shallow-repo "$HTTPD_DOCUMENT_ROOT_PATH/repo.=
git"
'

> +	git clone --depth=3D1 --no-local parent shallow-repo &&
> +	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
> +	test_i18ngrep -e "source repository is shallow, reject to clone." err
> +

Please remove the extra empty line. (This goes for at least a couple test
cases added by this patch.)

> +'

This test case does not require `start_httpd`, and should therefore come
before the test cases that do require it (actually, it should come before
the `start_httpd` call, even).

> +
> +test_expect_success 'reject cloning non-local shallow repository' '
> +	rm -rf shallow-repo &&
> +	git clone --depth=3D1 --no-local parent shallow-repo &&
> +	test_must_fail git clone --reject-shallow --no-local shallow-repo out =
2>err &&
> +	test_i18ngrep -e "source repository is shallow, reject to clone." err
> +
> +'

Hmm. Reading through three test cases that all create `shallow-repo` in
the same way, I wonder whether we should not simply set it up once, and
then not even bother removing it. I think that would simplify not only the
patch, it would also simplify debugging later on.

> +
> +test_expect_success 'clone shallow repository with --no-reject-shallow'=
 '
> +	rm -rf shallow-repo &&
> +	git clone --depth=3D1 --no-local parent shallow-repo &&
> +	git clone --no-reject-shallow --no-local shallow-repo clone-repo
> +
> +'
> +
> +test_expect_success 'clone normal repository with --reject-shallow' '
> +	rm -rf clone-repo &&
> +	git clone --no-local parent normal-repo &&
> +	git clone --reject-shallow --no-local normal-repo clone-repo
> +
> +'
> +
> +test_expect_success 'unspecified any configs or options' '
> +	rm -rf shallow-repo clone-repo &&
> +	git clone --depth=3D1 --no-local parent shallow-repo &&
> +	git clone shallow-repo clone-repo
> +
> +'
> +

Having read through these test cases, I think they can be simplified by

- first setting up `shallow-repo`

- then testing in the same test case whether `--reject-shallow` fails and
  `--no-reject-shallow` succeeds, without `--no-local`

- then testing the same _with_ `--no-local`

These can go to t5606, no problem.

Then, in t5601, after the `start_httpd` call, add a single test case that

- sets up the shallow clone _directly_, i.e.

	git clone --bare --no-local --depth=3D1 parent \
		"$HTTPD_DOCUMENT_ROOT_PATH/repo.git"

- verifies that `--reject-shallow` fails as expected, and

- verifies that `--no-reject-shallow` works as expected.

>  test_expect_success 'uses "origin" for default remote name' '
>
>  	git clone parent clone-default-origin &&
> diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
> index 9f555b87ecdf..adf873f60300 100755
> --- a/t/t5611-clone-config.sh
> +++ b/t/t5611-clone-config.sh
> @@ -95,6 +95,38 @@ test_expect_success 'clone -c remote.<remote>.fetch=
=3D<refspec> --origin=3D<name>' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'clone.rejectshallow=3Dtrue should reject cloning' =
'
> +	rm -rf child &&
> +	git clone --depth=3D1 --no-local . child &&

In the following, this shallow repository is needed a couple of times.
Better set it up once, in a dedicated `set up shallow repository` test
case.

And `shallow-repo` would probably make for a much better name than
`child`.

> +	test_must_fail git -c clone.rejectshallow=3Dtrue clone --no-local chil=
d out 2>err &&
> +	test_i18ngrep -e "source repository is shallow, reject to clone." err
> +'
> +
> +test_expect_success 'clone.rejectshallow=3Dfalse should succeed' '
> +	rm -rf child out &&
> +	git clone --depth=3D1 --no-local . child &&
> +	git -c clone.rejectshallow=3Dfalse clone --no-local child out
> +'

These two can be combined (and should, if you ask me, to simplify things).

> +
> +test_expect_success 'clone.rejectshallow=3Dtrue should succeed with nor=
mal repo' '
> +	rm -rf child out &&
> +	git clone --no-local . child &&
> +	git -c clone.rejectshallow=3Dtrue clone --no-local child out
> +'
> +
> +test_expect_success 'option --reject-shallow override clone.rejectshall=
ow' '
> +	rm -rf child out &&
> +	git clone --depth=3D1 --no-local . child &&
> +	test_must_fail git -c clone.rejectshallow=3Dfalse clone --reject-shall=
ow --no-local child out 2>err &&
> +	test_i18ngrep -e "source repository is shallow, reject to clone." err
> +'
> +
> +test_expect_success 'option --no-reject-shallow override clone.rejectsh=
allow' '
> +	rm -rf child out &&
> +	git clone --depth=3D1 --no-local . child &&
> +	git -c clone.rejectshallow=3Dtrue clone --no-reject-shallow --no-local=
 child out
> +'
> +

Personally, I think this is overkill. What I would do is to have a single
test case that verifies that

- `clone.rejectShallow=3Dtrue` fails as expected,

- `clone.rejectShallow=3Dfalse [...] --reject-shallow` fails as expected, =
and

- `clone.rejectShallow=3Dfalse` succeeds.

If we do this, we do not even need a preparatory test case setting up the
shallow repository.

>  test_expect_success MINGW 'clone -c core.hideDotFiles' '
>  	test_commit attributes .gitattributes "" &&
>  	rm -rf child &&
> diff --git a/transport.c b/transport.c
> index 1c4ab676d1b1..a6b9f404d86a 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -236,6 +236,9 @@ static int set_git_option(struct git_transport_optio=
ns *opts,
>  		list_objects_filter_die_if_populated(&opts->filter_options);
>  		parse_list_objects_filter(&opts->filter_options, value);
>  		return 0;
> +	} else if (!strcmp(name, TRANS_OPT_REJECT_SHALLOW)) {
> +		opts->reject_shallow =3D !!value;

I see that this is the established pattern (I am so grateful that I have
https://github.com/gitgitgadget/git/pull/865/files to look at the context,
something with which a pure mail-only patch contribution would not bless
me!), that those Boolean options are `NULL` vs non-`NULL`. So while you
pass `"1"` as the `value` parameter to `set_git_option()`, the parameter
`"0"` would _enable that option just the same_, you would have to pass
`NULL` to turn it off. I find that highly unintuitive, but that's not the
fault of your patch. The pattern is established, and you did the right
thing by following it.

> +		return 0;
>  	}
>  	return 1;
>  }

As I said, the rest of the patch looks good to me. With the few
suggestions I offered, I would be totally fine with this patch entering
`next`.

Thank you,
Dscho
