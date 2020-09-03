Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD6EC43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 20:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A482C206C0
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 20:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EhTflKI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgICU1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:27:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:51221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbgICU1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 16:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599164860;
        bh=xNDHbkyNa3iGcpQhf/ZDwPmMRrVVPMawtMufLMNqrdA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EhTflKI1N7i4IY1zhtiPxCmeZWyacXTBykgluM0aV2rFQCCaz0LLLtvc/idxHCOd7
         7ydGrw5D0n89CUP4/6KOkA/Wnk1tHflaGNdSLiGlUOkJUpV2wLz0mIZ/d33kdBAHAi
         rRSTo/vIsZ5s0mAw2jDICJGlSHTTciIcsV3HsidQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([213.196.212.246]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVDM-1jyTNU1j2W-00JvHY; Thu, 03
 Sep 2020 22:27:40 +0200
Date:   Thu, 3 Sep 2020 14:03:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v7 10/13] bisect--helper: reimplement `bisect_state` &
 `bisect_head` shell functions in C
In-Reply-To: <20200831105043.97665-11-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009031158080.56@tvgsbejvaqbjf.bet>
References: <20200831105043.97665-1-mirucam@gmail.com> <20200831105043.97665-11-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DW6JW+aPhQ8JqFYJmb7opWY5m9xAUuCs5IXPNTaBQUtSwu4xsKn
 8C1j8fDgOiFANxi58zt2U6o3QnuSciOO5kgB3NtVObM3/bjBqS05kZ7x/UpZYfTZKKftzqu
 AtngDt8k3SLbyK2/YLtwyY+bqmnWVBmc+kABVPKqZjH5i1Mm0/3ukxEg5bdYLNzL9pNy030
 JYRHtXVzeUBce8/rkz3Aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:knf4gkusQ+U=:kjyNkLdKazqXYD+Q56GjBQ
 B0Bq6V3o9ccyzFH5nP2ezfXRokB8iKHTXZ5cn57PyYIHiOTJF/HTePq00Ea2XNYxTUa7cLZAZ
 shQ7kkcXQ63oCOMXLeK7fURZv0Pxyz5ad146+/g1XoH4Yp3H4QEjWDcWjTbbHddjSYso7IPaB
 JB/3tzIJAu1pMwm19h46VBWS8fhXHge1O8pJ+wENBGjEMJCZ1+30dVWUjt7gO8JnEhsEaDYfx
 kQxHZ8J9kreyBbZ3GNjPuvNMWsLUQpcFB6CmzMGO98sR+lr1vRXx24LXz4QWZ1FrqY2qTI9EO
 XuCVVyeTOraAxsaA5HDJYAPGcJDAPLNCyXmga7qG6BCa0g1S0lUsfl9tiwdqf1jUWUQgGYZxj
 X/K2wdeGrAqFPwRikjxFOHLVjADkxiNj1Z6FTyWRIerrTDlvlfBvYfRp5eahUye/QDendnQhm
 vUKnz04vG2G8hJhOIcOWia4cM15QBg+G7EhOwHvhEbmLoq0QSwQZ1w4Ern2rWCDVYf1VbxXMs
 4v8BUa7mHj+ZOPIdu6Jr+bUQMLHpJLm4fvzwLGYj0ZgnFat6d9NyDaDK3GP1ggavuL6CSSzuD
 dzC2f+lCUG49xV8bVKh+vsPRcp7NnWHf2RrzrA4V8t+vHN+9TQkxX5gGxZGjnXfGCUBrALbwn
 giaJKIGww7qJFS6TNyYPMWVlzDc5R/gaqBHBMS3g5MI6AIXNQiH8MWOZ1rnWyblLDLewRJD8Z
 4YQHURgbOTATHSB6qu80QNxWRL1/PRJR39wzlYRXg/CdMrCBUp6dYxNkb7kEL+3kv7Z0um44E
 KJ0oclRbE/e6SuH2T0/bon/hl68Lp48DQiUBRzVPsr0V9YzhwOFTELP1QHcyMOYZsYAPV2MGN
 AX43uJa2RKlrRsRAmxJcF4Ox1T7sWmVowZB5oSp3bcvj8FXBDEIO42DwReo26phsXZ+cEHh+F
 qDj9JXOmVsO18pkX1DKlr9hWsbqNn/edYnyCXqid67SctUf3IBCYDuCmfNo8KcqYr27NpENwN
 DEyfKELJrfH1s7jlB/qMKzBisd5rTTaSKTM5r5qY5+22Qu/p0s1KK4dmfxnpkbunGhQ0hCquf
 ErBUOJPyl4JNTLf/5qR3Riu6FzbvVsf+EpkaIc6A5BuxPyBijD7/IUb7vbN+Q7GRo1uz6nN9w
 vSM2HWJC2lvXeaPVQ/tM6PeRUmlZQdcWfdYdux8sJ49by8PlJO/3gGm9bo3h/pxuW4Tvj6Z7o
 zc5M9/huaQQ0ZE3DwKo1EUbi9EQdLNHhWWlU/rw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Mon, 31 Aug 2020, Miriam Rubio wrote:

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
>  builtin/bisect--helper.c | 78 +++++++++++++++++++++++++++++++++++++++-
>  git-bisect.sh            | 55 +++-------------------------
>  2 files changed, 81 insertions(+), 52 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 0796e51672..a976f4739c 100644
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
> @@ -862,6 +864,72 @@ static int bisect_autostart(struct bisect_terms *te=
rms)
>  	return res;
>  }
>
> +static enum bisect_error bisect_state(struct bisect_terms *terms, const=
 char **argv,
> +				      int argc)
> +{
> +	const char *state;
> +	int i, verify_expected =3D 1;
> +	struct object_id oid, expected;
> +	struct strbuf buf =3D STRBUF_INIT;
> +	struct oid_array revs =3D OID_ARRAY_INIT;
> +
> +	if (!argc)
> +		return error(_("Please call `--bisect-state` with at least one argume=
nt"));

Good. Technically, this is a deviation from the scripted version, but it
is good not to check and set the terms first, only to then error out
anyway.

However, I think we will need a call to `bisect_autostart()` somewhere
around here, as that is what the scripted version did first thing.

> +
> +	state =3D argv[0];
> +	if (check_and_set_terms(terms, state) ||
> +	    !one_of(state, terms->term_good, terms->term_bad, "skip", NULL))
> +		return BISECT_FAILED;
> +
> +	argv++;
> +	argc--;
> +	if (argc > 1 && !strcmp(state, terms->term_bad))
> +		return error(_("'git bisect %s' can take only one argument."), terms-=
>term_bad);
> +
> +	if (argc =3D=3D 0) {
> +		enum get_oid_result res_head =3D get_oid("BISECT_HEAD", &oid);
> +		if (res_head =3D=3D MISSING_OBJECT)
> +			res_head =3D get_oid("HEAD", &oid);
> +		if (res_head) {
> +			error(_("Bad bisect_head rev input"));

If I am not mistaken, we should convert this shell command more faithfully
here:

			die "$(eval_gettext "Bad rev input: \$bisected_head")"

i.e. something like this:

		const char *head =3D "BISECT_HEAD";
		enum get_oid_result res_head =3D get_oid(head, &oid);

		if (res_head =3D=3D MISSING_OBJECT) {
			head =3D "HEAD";
			res_head =3D get_oid(head, &oid);
		}

		if (res_head)
			error(_("Bad rev input: %s"), head);

> +			return BISECT_FAILED;
> +		}
> +		oid_array_append(&revs, &oid);
> +	}
> +
> +	/*
> +	 * All input revs must be checked before executing bisect_write()
> +	 * to discard junk revs.
> +	 */
> +
> +	for (; argc; argc--, argv++) {
> +		if (get_oid(*argv, &oid)){
> +			error(_("Bad rev input: %s"), *argv);
> +			return BISECT_FAILED;
> +		}
> +		oid_array_append(&revs, &oid);
> +	}
> +
> +	if (strbuf_read_file(&buf, git_path_bisect_expected_rev(), 0) < the_ha=
sh_algo->hexsz ||
> +	    get_oid_hex(buf.buf, &expected) < 0)
> +		verify_expected =3D 0; /* Ignore invalid file contents */
> +	strbuf_release(&buf);
> +
> +	for (i =3D 0; i < revs.nr; i++) {
> +		if (bisect_write(state, oid_to_hex(&revs.oid[i]), terms, 0))
> +			return BISECT_FAILED;
> +
> +		if (verify_expected && !oideq(&revs.oid[i], &expected)) {
> +			unlink_or_warn(git_path_bisect_ancestors_ok());
> +			unlink_or_warn(git_path_bisect_expected_rev());
> +			verify_expected =3D 0;
> +		}
> +	}

Nice! This reads so much easier than the shell script version.

> +
> +	oid_array_clear(&revs);
> +	return bisect_auto_next(terms, NULL);
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -875,7 +943,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  		BISECT_START,
>  		BISECT_NEXT,
>  		BISECT_AUTO_NEXT,
> -		BISECT_AUTOSTART
> +		BISECT_AUTOSTART,
> +		BISECT_STATE
>  	} cmdmode =3D 0;
>  	int res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -901,6 +970,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  			 N_("verify the next bisection state then checkout the next bisectio=
n commit"), BISECT_AUTO_NEXT),
>  		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
>  			 N_("start the bisection if it has not yet been started"), BISECT_AU=
TOSTART),
> +		OPT_CMDMODE(0, "bisect-state", &cmdmode,
> +			 N_("mark the state of ref (or refs)"), BISECT_STATE),
>  		OPT_BOOL(0, "no-log", &nolog,
>  			 N_("no log for BISECT_WRITE")),
>  		OPT_END()
> @@ -971,6 +1042,11 @@ int cmd_bisect__helper(int argc, const char **argv=
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
>  		BUG("unknown subcommand %d", cmdmode);
>  	}
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 356264caf0..7a8f796251 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -39,16 +39,6 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>  TERM_BAD=3Dbad
>  TERM_GOOD=3Dgood
>
> -bisect_head()
> -{
> -	if git rev-parse --verify -q BISECT_HEAD > /dev/null
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

Since `bisect--helper` cannot cause the shell script to `exit`, the `eval`
should no longer be necessary.

>  }
>
>  bisect_visualize() {
> @@ -187,8 +141,7 @@ exit code \$res from '\$command' is < 0 or >=3D 128"=
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
> @@ -203,7 +156,7 @@ exit code \$res from '\$command' is < 0 or >=3D 128"=
 >&2
>  		if [ $res -ne 0 ]
>  		then
>  			eval_gettextln "bisect run failed:
> -'bisect_state \$state' exited with error code \$res" >&2
> +'git bisect--helper --bisect-state \$state' exited with error code \$re=
s" >&2

I don't think we should include implementation details such as the use of
`bisect--helper` in the error message. Personally, I would either keep
`bisect_state` or paraphrase what failed in English to begin with.

Thank you,
Johannes

>  			exit $res
>  		fi
>
> @@ -244,7 +197,7 @@ case "$#" in
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
