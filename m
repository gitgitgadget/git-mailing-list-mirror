Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D6C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 10:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94803208FE
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 10:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LH5LN+lV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbgJLKpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 06:45:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:39681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387568AbgJLKpl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 06:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602499536;
        bh=FBP2FSSOx1W0b1NxTEx9L1HO+POQANKVZIqWyRUyWz8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LH5LN+lV9y13C0iAfxBWqyqxUl6q5daDN4V8IhGJlAb42cHEPu2narl2eLzts9XOB
         YRBdsWFJSum7gXPGWWVEMYcldn4+z9LdfFLRBZYeuIoIoGQR9p078KcUVN/L0HC+bh
         bzKwf1E+C4vSEqhp6oGtT6Th0oWDEyXet58OsSc4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.146]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Ed-1kKgMX2mHV-013RGO; Mon, 12
 Oct 2020 12:45:36 +0200
Date:   Mon, 12 Oct 2020 12:45:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v10 4/7] bisect--helper: reimplement `bisect_state` &
 `bisect_head` shell functions in C
In-Reply-To: <20201010140743.580-5-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010121242000.50@tvgsbejvaqbjf.bet>
References: <20201010140743.580-1-mirucam@gmail.com> <20201010140743.580-5-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EOgGA/4RasB9Gm+IwiHcDVbQs7hw1wHhM0A3iRiGr3hOZyXJJnv
 ycpjiRBweICSZDo0tAp4cug/kfV1u9mQisAigO8nbNABNi4wj4WirjRnQ14oGdUccPCmHRi
 7gIpsYI0R3zvku0Mz23AGYoxqd22r6GZtFykGeLyrHvfV4K7c9ZMflv9QVLkOfiKF2uGK2Z
 X/LNZp6cUUJccPSH1B8CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fMfBh+kYEjo=:21PZc5srN+vFtIWtnXntH0
 uNTEh1+PQasARWx3U0DH9Bc+Svc0UGsnokUlyrqC8Wvp04c30/KvCqos4NbMFF+3OYS1BYXCR
 8vekHk2Quwukg9B8gyPnFOSknXju2sxmuUH47OOdFjp21ulz2Lms0ofkQlE0b69SeWJG0r783
 YcKewA8FM2fIx6g9/jgvG0CEPW/84Ao8H3WL8jUC7+JmSyhJSoKKKcmNnNzSxy1JY5f/CvLZ8
 EgQGw0JDUJbWJ3H+AUb0DxmnxezVycy2RTEMu8D29SPLcYxFQSVum9N5gQZVW25qqV/yfDYM4
 KtL4IDdtPsVaKfl9RJd0mLC78fuJafLSst8/C8rfKTlsO20ehiKogWPVxD/6Od4bgBKaS176v
 YgDBvFhLb3RLv01YAEv67tDpDDzyNyTshgPnjdCTHIwTahmDnoskKkJP1/P77VCTN/exmwZpx
 u0usePhs7C95iVeNSzU5LXzzQ2yjKco9IIRuNYOB6e8VcvxlgCk3ycC7h8aWF6dj2Jcn3zTGK
 pSUIAC281FhjQlFYyFV6gJhFwKOs7oZHFZx+Tah5gwccXqMFcG/tFzbi/Wbp0KUAnnr5I8BHI
 PJMdR+WzyQgD0gsRo4hN7PDVx1iDx8fuemMmlsL5zj3YWfwLSpyUVD1jU0FDgtUUbkAwKRQii
 MBJypgbwSucjGb7eB2xf8UmYJKDROqm5W3wRDHrngHXB25YOiysIs047B6vO76Gu8NLO7Ja6R
 CESZ4im0h6fDK3IDZjEXGztaqnIOLhRsTbgjbJ2E1JXtnxV+gDNIO6/M8byQ/kiYfBtXQoaeL
 4qHCtfDfQPDLELXdgwv45I/MsVuHhwLESvBB9ErIn1+rBrmU2QHHBF3bSsZCCe0bh726EzVGW
 9OL30as9cF9lskY48/IbC/kNlxv8Ac8f/S0C7rMLtgOEs90qA/cSyAJxFNUjd/ViukVAikRPO
 Qvb+aXwZnIFp0zOpZ0r2aGlMgr850KlgshTqu4eHO9zrhw1zaxIjulMqDgsghWl7ybJtw3je3
 IW11DdUYy3TbTZOKWOfR12WxzbobOJFKF/uCU9ZVvjaIcF3OT/b4/vDm2dJWDCCM8cxmTAliX
 7CVgP2jaYNc+8EMFatZXBZqgmZ+ZuUMbYidMbArfd8Z8bQc+mKPDPPveyT3spzCA7qNhZaFTx
 Z5SKg2dWj9UfvLjAjdXBHXYoC0l20Dn7v4Mk6tlhM19TAvVHBBH3BUKS0BeMQqxGsHDxXNJXQ
 Lj+ISONFXvOLNph9kJ8i2//BaZ0p+cYHqkg5WLA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

I read through the entire patch series, and have only _tiny_ nitpicks
left. Well done!

On Sat, 10 Oct 2020, Miriam Rubio wrote:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index f1a7cfbfaf..66b5346e42 100644
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
> @@ -854,6 +856,78 @@ static int bisect_autostart(struct bisect_terms *te=
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
> +
> +	if (bisect_autostart(terms))
> +		return BISECT_FAILED;
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
> +		const char *head =3D "BISECT_HEAD";
> +		enum get_oid_result res_head =3D get_oid(head, &oid);
> +
> +		if (res_head =3D=3D MISSING_OBJECT) {
> +			head =3D "HEAD";
> +			res_head =3D get_oid(head, &oid);
> +		}
> +
> +		if (res_head)
> +			error(_("Bad rev input: %s"), head);
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

Here, we leak `revs`. Maybe

			oid_array_clear(&revs);

?

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

Same here.

It is not exactly clear to me how problematic this leak would be, as we're
only calling this function from `cmd_*()` and return immediately
afterwards. It might be worth cleaning up memory, though, in case we want
to move this code into `libgit.a` and potentially call it from elsewhere
(where we would _not_ necessarily `exit()` immediately upon seeing a
failure).

Otherwise, the patch series looks good to me!

Thank you for your patient efforts,
Dscho

> +			return BISECT_FAILED;
> +
> +		if (verify_expected && !oideq(&revs.oid[i], &expected)) {
> +			unlink_or_warn(git_path_bisect_ancestors_ok());
> +			unlink_or_warn(git_path_bisect_expected_rev());
> +			verify_expected =3D 0;
> +		}
> +	}
> +
> +	oid_array_clear(&revs);
> +	return bisect_auto_next(terms, NULL);
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -867,7 +941,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  		BISECT_START,
>  		BISECT_AUTOSTART,
>  		BISECT_NEXT,
> -		BISECT_AUTO_NEXT
> +		BISECT_AUTO_NEXT,
> +		BISECT_STATE
>  	} cmdmode =3D 0;
>  	int res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -893,6 +968,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
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
> @@ -963,6 +1040,11 @@ int cmd_bisect__helper(int argc, const char **argv=
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
> index dda386bc3a..1f3f6e9fc5 100755
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
> -	git bisect--helper --bisect-autostart || exit
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
> +'bisect-state \$state' exited with error code \$res" >&2
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
