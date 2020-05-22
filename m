Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C4C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 22:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A653A20723
	for <git@archiver.kernel.org>; Fri, 22 May 2020 22:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g0NO7vXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbgEVWHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 18:07:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:46387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731051AbgEVWHD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 18:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590185217;
        bh=3NjqixAXA4TDwamjHWvm9yJAeMOxgyWrShgVPGDG/Kk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g0NO7vXMYi/JHzfUCVeEmc1FcQN52CJSa3+MzELzlbjMs2kt5bdqKH2lyPGUZ608g
         sM/urkHIfm33yLMskaDbiybXaOWEJ76r5Ws7P+KCFmmwc4mxHaZIWKwqtmMOL85iUm
         Y3QY1phd7kreFVsUmCks2RpNDA2lTIbcrsfSj2UY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.131]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1ioYsk15ml-00ySag; Sat, 23
 May 2020 00:06:57 +0200
Date:   Sat, 23 May 2020 00:06:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v3 09/12] bisect--helper: reimplement `bisect_state` &
 `bisect_head` shell functions in C
In-Reply-To: <20200423070704.39872-10-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005222311120.56@tvgsbejvaqbjf.bet>
References: <20200423070704.39872-1-mirucam@gmail.com> <20200423070704.39872-10-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qTO4s+5wqQZjROqyjaXVIskAMl9jKHbwGDdWSZH615Lw8g23a4U
 0ISBYTcm94PRq98YQ+m+BOnkhAmcooJLB14ivoU4eynNWyyfs9p2pn5AnA9HupJ1grBrcRu
 79AEvDQEfym88rt1RWrWBfUs86W03MmlYC9rWWCZnDM7iJZwFxBPPJB37XtfIaIyGAc82e4
 +r1zMmJnN/GfgVyXMFs/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ubET++EUQzM=:YsTrdC+IBx5ZXmsHx3DusI
 Tz5ZtN2ljXPxZuAqPmW20jlHTDItrHnnBXdE+gwgKuWGlVJSJrCC8ESBGa8i81s5jA4tA+A1x
 7H2m2wDiRKF8WhzDKKpJa+7gZmRNah1LQ75IcsK3OY7wWKvHSaf4M7UIIhogwkNL/AjEIV/Ej
 RIOwcnWeqpEloU6OX8AIryW3oxns107TTEO4/wWp7H5Wmyzlwr8Mqd+Z0kly0C2Of4DXhw+Jk
 VpcPsMhV4egzaNGPNqkVYNICNXhlyjW9GsGt+N1fmxfkl3vW3d1lztT8NuYVg0dvouEo4lfkc
 AejzrSHWvlSX2Mc4eruj19eRtcWDLPtzrx6cmJtR8Ip43SqrGIwR5fSzA4SXJbVswuKYxTOmA
 gWz2tWo5s4f5fcI9M20iwTYrd3DzKv6B0yoleG+xf2L7/SuqvImlCO2emhKC8oIRCkF3MAoAG
 HLWnh4y4h9Z66d+eJbIo1OgP5tn1lXu0EW5DZGUli9ZrwxFlyZjPWEN533tCYQTN0hANXEiA4
 Pj1rptvORHDJUUZL5atPjKeTNFa2z8hEy2jU1O0StCUd+1FpG6eaTsYGSX61poVtIF5AApAfX
 FanOTccQgSgcqBctK9+ycGX8C9jiCKdfAzcsKqb1P40cXYqUY+/W8/gLLccdcMAzGKwkg9/5n
 B0kIyq4ROy3ztR+qmH1IwFaxYblWM1mDKm0jhfmTQgUQVB9l3o9nI1nP8M2kUybmKmmIqr/lN
 jYZHPo79RIRk+umsUTYCfFHE2OwsDdaMMaS6q8IuucRPbBsuvDYiylMFYLntdfP4IJlMAY1am
 70p8lbHm7CyaVFoIETpuhhU8HQJxMLtvGi+IyjTohXL6o0QoubW/FbYfZIDaYBTI8Flcr3Ksq
 EZD3Vi63s4SyxwXunXaDrA75yoRrT6QUkIEUP/pso9o3vsSqjnuyZY/RNMq7Zt3CDvV9Bpdan
 u6xQU2UiPCN+wlzhW4ZU7txGvplsKhQfwRIOxkehj92068F50WysciA88i+zmzw3bVWU5QY1g
 ukyqDtMJ4+xFchxDufn9+kLvYJBf2Umfiqh3NUiGOG5fHDLL+h+0PmojhdTpK9b9HWCi/uMHv
 S4IPneEUuazzy/BCndhHJhjTVZviKXRWx9WbS0MdhGLpz07xZYoqt3BERQkOSDICt2KBwBYBr
 cPqlVq1S6Pbb3xq70ZsJFxikIJXq4MPw2AP9Op7Spg/XGcAvzX/iEvEO9rZXNrIj3g++UbCUT
 KphmgIhd+WRAxaCHx
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Thu, 23 Apr 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Reimplement the `bisect_state()` shell functions in C and also add a
> subcommand `--bisect-state` to `git-bisect--helper` to call them from
> git-bisect.sh .
>
> Using `--bisect-state` subcommand is a temporary measure to port shell
> function to C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired and will be called by some
> other methods.
>
> `bisect_head()` is only called from `bisect_state()`, thus it is not
> required to introduce another subcommand.
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 70 +++++++++++++++++++++++++++++++++++++++-
>  git-bisect.sh            | 55 +++----------------------------
>  2 files changed, 73 insertions(+), 52 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 2d8660c79f..9db72f5891 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -31,6 +31,8 @@ static const char * const git_bisect_helper_usage[] =
=3D {
>  	N_("git bisect--helper --bisect-next"),
>  	N_("git bisect--helper --bisect-auto-next"),
>  	N_("git bisect--helper --bisect-autostart"),
> +	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
> +	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
>  	NULL
>  };
>
> @@ -834,6 +836,64 @@ static int bisect_autostart(struct bisect_terms *te=
rms)
>  	return bisect_start(terms, 0, NULL, 0);
>  }
>
> +static int bisect_head(struct object_id *oid)
> +{
> +	if (!file_exists(git_path_bisect_head()))
> +		return get_oid("HEAD", oid);
> +
> +	return get_oid("BISECT_HEAD", oid);

This can be easily reduced to

	return get_oid(file_exists(git_path_bisect_head()) ?
		       "BISECT_HEAD" : "HEAD", oid);

At the same time, it is wrong, just like the shell script version was
wrong: in particular in light of the `hn/reftable` effort, we do _not_
want to assume that all refs are backed by files!

So really, what this should do instead is this:

	enum get_oid_result res =3D get_oid("BISECT_HEAD", oid);

	if (res =3D=3D MISSING_OBJECT)
		res =3D get_oid("HEAD", oid);

Given that this is still only three lines long, the overhead of having it
in its own function for just a _single_ call seems excessive. I'd prefer
it to be inlined in `bisect_state()`.

> +}
> +
> +static enum bisect_error bisect_state(struct bisect_terms *terms, const=
 char **argv,
> +			int argc)
> +{

I offered a lengthy discussion about this function in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2002272244150.9783@tvgsbejva=
qbjf.bet/

It does not look, however, as if v3 benefitted from the entirety of my
analysis: All the `check_expected_revs()` function does is to verify that
the passed list of revs matches exactly the contents of the
`BISECT_EXPECTED_REV` file.

That can be done in a much simpler way, though, by first reading the file
and parsing the contents into an OID, and then comparing to that parsed
OID instead.

Besides, `check_expected_revs()` is only used to check one rev at a time.

In other words, it could be simplified to something like this:

static void check_expected_rev(struct object_id *oid)
{
	struct object_id expected;
	struct strbuf buf =3D STRBUF_INIT;

        if (strbuf_read_file(&buf, git_path_bisect_expected_rev(), 0)
	      < the_hash_algo->hexsz ||
	    get_oid_hex(buf.buf, &expected) < 0)
		return; /* Ignore invalid file contents */

	if (!oideq(oid, &expected)) {
		... unlink ...
		return;
	}
}

But even that would be wasteful, as we would read the file over and over
and over again.

The good news is that we do not even _need_ `check_expected_rev()`.
Because we do not need to have two call sites, we can simplify the code
much further. See below:

> +	const char *state;
> +	const char *hex;
> +	int i;
> +	struct oid_array revs =3D OID_ARRAY_INIT;
> +	struct object_id oid;
> +
> +	if (!argc)
> +		return error(_("Please call `--bisect-state` with at least one argume=
nt"));
> +	state =3D argv[0];
> +	if (check_and_set_terms(terms, state) ||
> +	    !one_of(state, terms->term_good,terms->term_bad, "skip", NULL))
> +		return BISECT_FAILED;
> +	argv++;
> +	argc--;
> +	if (!strcmp(state, terms->term_bad) && (argc > 1))
> +		return error(_("'git bisect %s' can take only one argument."),terms->=
term_bad);
> +	if (argc =3D=3D 0) {
> +		if (bisect_head(&oid))
> +			return error(_("Bad bisect_head rev input"));
> +		hex =3D oid_to_hex(&oid);
> +		if (bisect_write(state, hex, terms, 0))
> +			return BISECT_FAILED;
> +		check_expected_revs(&hex, 1);
> +		return bisect_auto_next(terms, NULL);
> +	}
> +
> +	/* Here argc > 0 */
> +	for (; argc; argc--, argv++) {
> +		struct object_id oid;
> +		if (get_oid(*argv, &oid))
> +			return error(_("Bad rev input: %s"), *argv);
> +		oid_array_append(&revs, &oid);
> +	}

It really does not make sense to parse the arguments into an OID array,
_then_ iterate over the array once, and then immediately releasing it.
That OID array is not needed at all.

So we'll end up with this loop in case `argc > 0` (where we now call
`get_oid()`, too), and note how the loop body looks _eerily_ similar to
the conditional `argc =3D=3D 0` code block above?

> +
> +	for (i =3D 0; i < revs.nr; i++) {
> +		hex =3D oid_to_hex(&revs.oid[i]);
> +		if (bisect_write(state, hex, terms, 0)) {
> +			oid_array_clear(&revs);
> +			return BISECT_FAILED;
> +		}
> +		check_expected_revs(&hex, 1);
> +	}
> +
> +	oid_array_clear(&revs);
> +	return bisect_auto_next(terms, NULL);
> +}

So really, this function pretty much _wants_ to look this way (modulo
bugs, as I did not even test-compile the code):

static enum bisect_error bisect_state(struct bisect_terms *terms,
				      const char **argv, int argc)
{
	const char *state;
	int i, verify_expected =3D 1;
	struct object_id oid, expected;
	struct strbuf buf =3D STRBUF_INIT;

	if (!argc)
		return error(_("Please call `--bisect-state` with at least one argument"=
));

	state =3D argv[0];
	if (check_and_set_terms(terms, state) ||
	    !one_of(state, terms->term_good, terms->term_bad, "skip", NULL))
		return BISECT_FAILED;

	argv++;
	argc--;
	if (argc > 1 && !strcmp(state, terms->term_bad))
		return error(_("'git bisect %s' can take only one argument."), terms->te=
rm_bad);

        if (strbuf_read_file(&buf, git_path_bisect_expected_rev(), 0) < th=
e_hash_algo->hexsz ||
	    get_oid_hex(buf.buf, &expected) < 0)
		verify_expected =3D 0; /* Ignore invalid file contents */


	for (i =3D 0; i < argc + !argc; i++) {
		if (argc) {
			if (get_oid(argv[i], &oid)) {
				error(_("Bad rev input: %s"), *argv);
				return BISECT_FAILED;
			}
		} else {
			enum get_oid_result res =3D get_oid("BISECT_HEAD", &oid);

			if (res =3D=3D MISSING_OBJECT)
				res =3D get_oid("HEAD", &oid);
			if (res) {
				error(_("Bad bisect_head rev input"));
				return BISECT_FAILED;
			}
		}

		if (bisect_write(state, oid_to_hex(&oid), terms, 0))
			return BISECT_FAILED;

		if (verify_expected && !oideq(&oid, &expected)) {
			unlink_or_warn(git_path_bisect_ancestors_ok());
			unlink_or_warn(git_path_bisect_expected_rev());
			verify_expected =3D 0;
		}
	}

	return bisect_auto_next(terms, NULL);
}

There, not bad, is it?

> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -847,7 +907,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  		BISECT_START,
>  		BISECT_NEXT,
>  		BISECT_AUTO_NEXT,
> -		BISECT_AUTOSTART
> +		BISECT_AUTOSTART,
> +		BISECT_STATE
>  	} cmdmode =3D 0;
>  	int no_checkout =3D 0, res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -873,6 +934,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  			 N_("verify the next bisection state then checkout the next bisectio=
n commit"), BISECT_AUTO_NEXT),
>  		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
>  			 N_("start the bisection if BISECT_START is empty or missing"), BISE=
CT_AUTOSTART),
> +		OPT_CMDMODE(0, "bisect-state", &cmdmode,
> +			 N_("mark the state of ref (or refs)"), BISECT_STATE),
>  		OPT_BOOL(0, "no-checkout", &no_checkout,
>  			 N_("update BISECT_HEAD instead of checking out the current commit")=
),
>  		OPT_BOOL(0, "no-log", &nolog,
> @@ -945,6 +1008,11 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
>  		set_terms(&terms, "bad", "good");
>  		res =3D bisect_autostart(&terms);
>  		break;
> +	case BISECT_STATE:
> +		set_terms(&terms, "bad", "good");
> +		get_terms(&terms);
> +		res =3D bisect_state(&terms, argv, argc);
> +		break;
>  	default:
>  		BUG("unknown subcommand %d", (int)cmdmode);
>  	}
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 049ffacdff..2da0810b1a 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -39,16 +39,6 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>  TERM_BAD=3Dbad
>  TERM_GOOD=3Dgood
>
> -bisect_head()
> -{
> -	if test -f "$GIT_DIR/BISECT_HEAD"
> -	then
> -		echo BISECT_HEAD
> -	else
> -		echo HEAD
> -	fi
> -}
> -
>  bisect_skip() {
>  	all=3D''
>  	for arg in "$@"
> @@ -61,43 +51,7 @@ bisect_skip() {
>  		esac
>  		all=3D"$all $revs"
>  	done
> -	eval bisect_state 'skip' $all
> -}
> -
> -bisect_state() {
> -	git bisect--helper --bisect-autostart
> -	state=3D$1
> -	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD |=
| exit
> -	get_terms
> -	case "$#,$state" in
> -	0,*)
> -		die "Please call 'bisect_state' with at least one argument." ;;
> -	1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
> -		bisected_head=3D$(bisect_head)
> -		rev=3D$(git rev-parse --verify "$bisected_head") ||
> -			die "$(eval_gettext "Bad rev input: \$bisected_head")"
> -		git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM=
_BAD" || exit
> -		git bisect--helper --check-expected-revs "$rev" ;;
> -	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
> -		shift
> -		hash_list=3D''
> -		for rev in "$@"
> -		do
> -			sha=3D$(git rev-parse --verify "$rev^{commit}") ||
> -				die "$(eval_gettext "Bad rev input: \$rev")"
> -			hash_list=3D"$hash_list $sha"
> -		done
> -		for rev in $hash_list
> -		do
> -			git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TER=
M_BAD" || exit
> -		done
> -		git bisect--helper --check-expected-revs $hash_list ;;
> -	*,"$TERM_BAD")
> -		die "$(eval_gettext "'git bisect \$TERM_BAD' can take only one argume=
nt.")" ;;
> -	*)
> -		usage ;;
> -	esac
> -	git bisect--helper --bisect-auto-next
> +	eval git bisect--helper --bisect-state 'skip' $all
>  }
>
>  bisect_visualize() {
> @@ -185,8 +139,7 @@ exit code \$res from '\$command' is < 0 or >=3D 128"=
 >&2
>  			state=3D"$TERM_GOOD"
>  		fi
>
> -		# We have to use a subshell because "bisect_state" can exit.
> -		( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
> +		git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN"
>  		res=3D$?
>
>  		cat "$GIT_DIR/BISECT_RUN"
> @@ -201,7 +154,7 @@ exit code \$res from '\$command' is < 0 or >=3D 128"=
 >&2
>  		if [ $res -ne 0 ]
>  		then
>  			eval_gettextln "bisect run failed:
> -'bisect_state \$state' exited with error code \$res" >&2
> +'git bisect--helper --bisect-state \$state' exited with error code \$re=
s" >&2

This is not your fault, of course, but it does make me shudder to see such
an obvious implementation detail in a user-facing error message.

Maybe something to fix up in a follow-up?

Ciao,
Dscho

>  			exit $res
>  		fi
>
> @@ -242,7 +195,7 @@ case "$#" in
>  	start)
>  		git bisect--helper --bisect-start "$@" ;;
>  	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
> -		bisect_state "$cmd" "$@" ;;
> +		git bisect--helper --bisect-state "$cmd" "$@" ;;
>  	skip)
>  		bisect_skip "$@" ;;
>  	next)
> --
> 2.25.0
>
>
