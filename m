Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00439C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E5860238
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhHQLmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 07:42:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:60559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236781AbhHQLmn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 07:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629200527;
        bh=P2KZKTHSKirpa2JNnXb4jNFpvzVEW7kOrfa1hmOxHXU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C1edckzxhiU2f49fvDnYrFsIfMzQGzuS4yb5mCSK8Y+t6qQ0kH2UcWmdIodC5SwQV
         e/YK92nJMoFI1giufahpsCFd3E/SV5qxsW4BhtD3cfoRckx0iGckuufPiKVkCUx4sk
         9RToDJdotGb+iJNPwVegOB2JX/IiLNibvMjhvedw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbVu-1mIhqT2XeQ-00H6Ad; Tue, 17
 Aug 2021 13:42:07 +0200
Date:   Tue, 17 Aug 2021 13:42:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 5/6] bisect--helper: reimplement `bisect_run` shell
 function in C
In-Reply-To: <20210817081458.53136-6-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108171332370.55@tvgsbejvaqbjf.bet>
References: <20210817081458.53136-1-mirucam@gmail.com> <20210817081458.53136-6-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VEY7ALUxjh+YVzBHP5NdRyc6y+mvUmgKlZWDfRxf9u3KDDPlzXO
 PYdvpqScOauRi4fuapWZhxzzzJUNwmtTlxGtrtgkeB1L9YUBt2n5UlCczuVbqtLBBjTBFGy
 BQP+KYzd9Wq8UhRQaHUQ7q4j1QvwETh2QRLfd5PraPBzppBlipLemksvNFE2bJHsbkYuaUq
 pQYUrDTg2UhhCPhgCs72w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H/xZWFxTzPE=:kotfPgkNdWHrqUODucWdFR
 aQEYOTmrh4NMGW1xDOPkgwgMl0/BFEfNnbcoy4YPf5hly/1pSadi/ImLTex+YGQMW3nTyxScC
 anf/RXBZ3tSE4dME1RmjteQlVZ4r3xVs/eKxl1uWjg2vMttWnCVEu/5k+Hjl+TK8gPOlOA6Wg
 wELn1qiTPx88dEiknot68a2zknofr1wsazbPmFV6fnGkIwYAz91zBKPuU3ZRlJ9beOrl4YnjX
 HU3XaRD+J6bmD/RrAqIYFq4QIkGXO3JHPAXvWhb9IrKNZefSTIB3IYgW7NOwKFentWwxJSxtl
 06WZJ4ySMPOYWL6F3T8AQFLxg55sv9FRfvsYaJlPRcn9AYu1GpZVPUXP5efhNI/L0L+K0AhdV
 Wdjnv0tlBPCycRCB91D9x1hx57FuYr1gjVYZ4lpH1CrooNrTfIXY+0Qgh3VH6zBSRG3WAGn8h
 56hrAac1n4AFnOhvL+fgCSsRG8LCjfNd32wnyaf4nmgd17K/h5Cd0xZ0rvcXIvbdEW7c4TJaG
 mNz2JcsJzIurlAUdAlWHacWF0a/Rm30wmSUuqPLfyzWG4DnD5kjXc0URLer7ZqFwSFTiBoby2
 mXFy/1rC+8jG4PDln62iQN2qqgwIeQOMAVhraw/FkH4DqYA9SXWJRuL6Qi/r+aM1q8YVma4to
 lYgm3YwHIAZh5vCaYhs/vg5xk+RtKijoTe8QfmGmaWschAocBQI7IaGU9yoxZLvNc/AnsZYSv
 h/zTbdCrzXbrTJDc5/a6X5LLQBdvtLisgp7+0uS+FQ3WUXUommIvrQmnAsX6/GkCTIAkEVPJs
 Mhu/wUdDwlzRwg0vs1MKBo3HtuYEQ7vaBTLq5AVZSCWFgtP16uex338OyzIRbHGdFupUDpkqj
 OGEfIPBzhlFGXw0bSo3KJQShrdISPGE31/H+H81qyC2c5g3ZKUCX21AS8Sk3bTOYIILznbSBr
 wm4eCTCTcPAsLQx/IvTQC3VP0lMSTuBm7gc59brP4mj20H0bmV1VIquyPj1rRCrI77buwktpD
 2ALNILsY+eTSSBKPjMu5kSpXoeevRMB4x1gsoQz1TSyAAHDktPUJ44GSTIEd78uL6u/T72+/q
 IbgQBsUHdSWRpoTCLbaD9SJK4COQUvXBVyZ89siitDdLarYq/mPvzKHBA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Tue, 17 Aug 2021, Miriam Rubio wrote:

> From: Tanushree Tumane <tanushreetumane@gmail.com>
>
> Reimplement the `bisect_run()` shell function
> in C and also add `--bisect-run` subcommand to
> `git bisect--helper` to call it from git-bisect.sh.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 75 ++++++++++++++++++++++++++++++++++++++++
>  git-bisect.sh            | 62 +--------------------------------
>  2 files changed, 76 insertions(+), 61 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 4258429c1c..852e0a30fb 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -31,6 +31,7 @@ static const char * const git_bisect_helper_usage[] =
=3D {
>  	N_("git bisect--helper --bisect-replay <filename>"),
>  	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
>  	N_("git bisect--helper --bisect-visualize"),
> +	N_("git bisect--helper --bisect-run <cmd>..."),
>  	NULL
>  };
>
> @@ -1075,6 +1076,71 @@ static int bisect_visualize(struct bisect_terms *=
terms, const char **argv, int a
>  	return res;
>  }
>
> +static int bisect_run(struct bisect_terms *terms, const char **argv, in=
t argc)
> +{
> +	int res =3D BISECT_OK;
> +	struct strbuf command =3D STRBUF_INIT;
> +	struct strvec args =3D STRVEC_INIT;
> +	struct strvec run_args =3D STRVEC_INIT;
> +	int exit =3D 0;
> +
> +	if (bisect_next_check(terms, NULL))
> +		return BISECT_FAILED;
> +
> +	if (argc)
> +		sq_quote_argv(&command, argv);
> +	else
> +		return BISECT_FAILED;

Do we want to say something helpful here, e.g. _("bisect run failed: no
command provided.")?

> +
> +	strvec_push(&run_args, command.buf);
> +
> +	while (1) {
> +		strvec_clear(&args);
> +		exit =3D 1;
> +
> +		printf(_("running %s"), command.buf);
> +		res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);
> +
> +		if (res < 0 || 128 <=3D res) {
> +			error(_("bisect run failed: exit code %d from"
> +				" '%s' is < 0 or >=3D 128"), res, command.buf);
> +			strbuf_release(&command);
> +			return res;
> +		}
> +
> +		if (res =3D=3D 125)
> +			strvec_push(&args, "skip");
> +		else if (res > 0)
> +			strvec_push(&args, terms->term_bad);
> +		else
> +			strvec_push(&args, terms->term_good);
> +
> +		res =3D bisect_state(terms, args.v, args.nr);

Since `args.nr` will always be 1, it would probably be better to use
something like this:

		const char *new_state;

		[...]
		if (res =3D=3D 125)
			new_state =3D "skip";
		else
			new_state =3D res > 0 ?
				terms->term_bad : terms->term_good;

		res =3D bisect_state(terms, &new_state, 1);

Also: I think at this stage, an equivalent to `cat "$GIT_DIR/BISECT_RUN"`
is missing.

> +
> +		if (res =3D=3D BISECT_ONLY_SKIPPED_LEFT)
> +			error(_("bisect run cannot continue any more"));
> +		else if (res =3D=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
> +			printf(_("bisect run success"));
> +			res =3D BISECT_OK;
> +		} else if (res =3D=3D BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> +			printf(_("bisect found first bad commit"));
> +			res =3D BISECT_OK;
> +		} else if (res) {
> +			error(_("bisect run failed:'git bisect--helper --bisect-state"
> +			" %s' exited with error code %d"), args.v[0], res);
> +		} else {
> +			exit =3D 0;

Since the only purpose of `exit` seems to be that the loop should continue
if `exit` is set to 0, and it is only set here, how about doing away with
the variable altogether and writing `continue;` instead of `exit =3D 0;`?
Then the conditional block below does not need to be conditional.

Other than that: well done!

Ciao,
Dscho

> +		}
> +
> +		if (exit) {
> +			strbuf_release(&command);
> +			strvec_clear(&args);
> +			strvec_clear(&run_args);
> +			return res;
> +		}
> +	}
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -1089,6 +1155,7 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
>  		BISECT_REPLAY,
>  		BISECT_SKIP,
>  		BISECT_VISUALIZE,
> +		BISECT_RUN,
>  	} cmdmode =3D 0;
>  	int res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -1112,6 +1179,8 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
>  			 N_("skip some commits for checkout"), BISECT_SKIP),
>  		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
>  			 N_("visualize the bisection"), BISECT_VISUALIZE),
> +		OPT_CMDMODE(0, "bisect-run", &cmdmode,
> +			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
>  		OPT_BOOL(0, "no-log", &nolog,
>  			 N_("no log for BISECT_WRITE")),
>  		OPT_END()
> @@ -1177,6 +1246,12 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
>  		get_terms(&terms);
>  		res =3D bisect_visualize(&terms, argv, argc);
>  		break;
> +	case BISECT_RUN:
> +		if (!argc)
> +			return error(_("bisect run failed: no command provided."));
> +		get_terms(&terms);
> +		res =3D bisect_run(&terms, argv, argc);
> +		break;
>  	default:
>  		BUG("unknown subcommand %d", cmdmode);
>  	}
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 95f7f3fb8c..e83d011e17 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -39,66 +39,6 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>  TERM_BAD=3Dbad
>  TERM_GOOD=3Dgood
>
> -bisect_run () {
> -	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || ex=
it
> -
> -	test -n "$*" || die "$(gettext "bisect run failed: no command provided=
.")"
> -
> -	while true
> -	do
> -		command=3D"$@"
> -		eval_gettextln "running \$command"
> -		"$@"
> -		res=3D$?
> -
> -		# Check for really bad run error.
> -		if [ $res -lt 0 -o $res -ge 128 ]
> -		then
> -			eval_gettextln "bisect run failed:
> -exit code \$res from '\$command' is < 0 or >=3D 128" >&2
> -			exit $res
> -		fi
> -
> -		# Find current state depending on run success or failure.
> -		# A special exit code of 125 means cannot test.
> -		if [ $res -eq 125 ]
> -		then
> -			state=3D'skip'
> -		elif [ $res -gt 0 ]
> -		then
> -			state=3D"$TERM_BAD"
> -		else
> -			state=3D"$TERM_GOOD"
> -		fi
> -
> -		git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN"
> -		res=3D$?
> -
> -		cat "$GIT_DIR/BISECT_RUN"
> -
> -		if sane_grep "first $TERM_BAD commit could be any of" "$GIT_DIR/BISEC=
T_RUN" \
> -			>/dev/null
> -		then
> -			gettextln "bisect run cannot continue any more" >&2
> -			exit $res
> -		fi
> -
> -		if [ $res -ne 0 ]
> -		then
> -			eval_gettextln "bisect run failed:
> -'bisect-state \$state' exited with error code \$res" >&2
> -			exit $res
> -		fi
> -
> -		if sane_grep "is the first $TERM_BAD commit" "$GIT_DIR/BISECT_RUN" >/=
dev/null
> -		then
> -			gettextln "bisect run success"
> -			exit 0;
> -		fi
> -
> -	done
> -}
> -
>  get_terms () {
>  	if test -s "$GIT_DIR/BISECT_TERMS"
>  	then
> @@ -137,7 +77,7 @@ case "$#" in
>  	log)
>  		git bisect--helper --bisect-log || exit ;;
>  	run)
> -		bisect_run "$@" ;;
> +		git bisect--helper --bisect-run "$@" || exit;;
>  	terms)
>  		git bisect--helper --bisect-terms "$@" || exit;;
>  	*)
> --
> 2.29.2
>
>
