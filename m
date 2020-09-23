Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D29C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1482371F
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DgrbrGNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgIWSnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 14:43:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:35383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgIWSnj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 14:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600886615;
        bh=5YuPBnsB2nsXTXxtSZxfHR9jKCTXxM3w39koBmysrNY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DgrbrGNsxf2+Xrd66e94qF7GVaFCkFLlZ/3H3JsbUqE2CEuBnclarASgbigvd4A8+
         DnYZDkIwjWY1iUr+wCu9PbBmTmyWfcTJ7KZIZrVi/5Byir5JYDQFQSxpqQRtbR1yjP
         asTGE884ltOF5MC5AyHJf4q7tPMtbagtQA1e+Vps=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0G1n-1khKuu1f9D-00xIty; Wed, 23
 Sep 2020 20:43:35 +0200
Date:   Wed, 23 Sep 2020 16:41:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v8 4/6] bisect--helper: reimplement `bisect_autostart`
 shell function in C
In-Reply-To: <20200923072740.20772-5-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009231640370.5061@tvgsbejvaqbjf.bet>
References: <20200923072740.20772-1-mirucam@gmail.com> <20200923072740.20772-5-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nugz5Bunb2sxhjCYq0STvMJMvyxjiBFC5bA1x5QhPkOlNZfPe5t
 Bxk+mcuZqFXFUiw5BuIMof3GZle0yATADT4KG7lLEzyHYGQb4y+uNaQ+Rm94ZiogJThv6/S
 UxXEHmmK5ry6KEePgXjCKlkLot5+rvUTsbog7cb0Hde/75dbsWL6vgjaQmX+RiPe8XIPui8
 C1aS6cDW1e+sUyTZDKKGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sATVdWiGC+I=:5My7VYDIMcojh9tF92Yrs7
 xDrYDic4riEt6JClqm33lShUJEO/N8YMVLbQxhe1yL5czGyhfVaIhnK5KtvTmnb7abqch8Fl0
 lnuQPLbw0PuhEVUfBg8bI7FTc1EeMAjyBKze4Z1qSCHjvvRPxt/qfvbjb21HfPRDndI+v4bZj
 5zLRtcR+PR1jo4/Q8Ba07otNGTSsj1idiag5HNPLcGFq95nadFyxchddyz26nbMDzxwME2bxR
 hsBpz+HNuDGcTALdObKgNcMiRGaR1I8ijrlq2XYDLMVKYIEb6IX6SmIqvF7X7eB/gaul9voRn
 3eJ74UuJR/gC8+VLHRJD8f6d0TC37j3BlsbIxfXcG0n04I8fltigxz043IlVspEVYAXIOPBU0
 h/iwE1KXKl/KAPKjJ6zEbzpMZfFtuZA56XnteCXmQXCf0Hn3LVT4qAGEpotZK3LvXWOUxv83w
 k/sgaK/Mbpe5wvbs4OV22ajaNtg11hI1vKYnpXbMaZQLBGivwPWMGR6gpt8tts/NQofAOdbiS
 QF2xH4iJ8qzoVmsruwgjtwnimkvS0FqJ0W2jdJiml8PfPsNzs+mUqpZYTV/EhogSK7IeTdKMu
 2pVrAhbZX0gRwriUKkogM/fTW1wVT3szz4JhP985SZHL/GKopmnGpfF+YLXdmj0SuLelXRr+9
 Wc6z+1iKwkjDXqVwLzVrVcWXy36MCRzkW2moqfBnVLd1rFRDxsdEQo4npvSB/XFi1BYPvTO/f
 tgz3OkQ1i6q/MVEwqu14LPG1dLJ2oXxLsSzpMmey0InLJjSA99+QxkB8xglvtVcrtiQnIJSYV
 TioFA3ddE2+pdRlQUDG3+sMS/Q7wI2TyObQ4uMxvtLQ0dBq1wGGQff0XvtoAySu6LzUnPX9Ii
 bCUV55kBs+QiT0J7acA1VFEP4CyuHGh1SSCsGdVpGCGxzCRiCf+6tvjDI+RmVRevydeqJ8+IL
 8Z1I8Y4VNIUaA+RNl5d69rYrHaCdDHHQz9q9oYY/QDl+lKX6dCV7/V/rtUdhY+Vw6dLOL2pTC
 SzIlMd2ZGZeKALgPlIbDk+jKjM7fwek/uCItydyH4/O4LOj95lgDNw2/98qtXKopZKSAUdbWp
 XmNB6Q6n3LqHldZYVTJXoDREZpCY8HpQmFea2SB7orzvOEq+mWb9y3Taa/aneOnPA+EaSJBno
 OFjyZ/DExC7W0//8Adws1oqneMrL9vGXYqxksB63stIrtqtxmp/knsMomaL4xzrSS0i8CSKvU
 rtehg1l2QY9RqDlawBUKJGfq8HByYBLqiPlkWNg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Wed, 23 Sep 2020, Miriam Rubio wrote:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 46d2abb36f..ab27a8dff6 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -29,6 +29,7 @@ static const char * const git_bisect_helper_usage[] =
=3D {
>  	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --te=
rm-bad | --term-new]"),
>  	N_("git bisect--helper --bisect-start [--term-{new,bad}=3D<term> --ter=
m-{old,good}=3D<term>]"
>  					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<=
paths>...]"),
> +	N_("git bisect--helper --bisect-autostart"),
>  	NULL
>  };
>
> @@ -653,6 +654,38 @@ static int bisect_start(struct bisect_terms *terms,=
 const char **argv, int argc)
>  	return res;
>  }
>
> +static inline int file_is_not_empty(const char *path)
> +{
> +	return !is_empty_or_missing_file(path);
> +}
> +
> +static int bisect_autostart(struct bisect_terms *terms)
> +{
> +	int res;
> +	const char *yesno;
> +
> +	if (file_is_not_empty(git_path_bisect_start()))
> +		return 0;
> +
> +	fprintf_ln(stderr, _("You need to start by \"git bisect "
> +			  "start\"\n"));
> +
> +	if (!isatty(STDIN_FILENO))
> +		return -1;
> +
> +	/*
> +	 * TRANSLATORS: Make sure to include [Y] and [n] in your
> +	 * translation. The program will only accept English input
> +	 * at this point.
> +	 */
> +	yesno =3D git_prompt(_("Do you want me to do it for you "
> +			     "[Y/n]? "), PROMPT_ECHO);
> +	res =3D tolower(*yesno) =3D=3D 'n' ?
> +		-1 : bisect_start(terms, empty_strvec, 0);
> +
> +	return res;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -665,7 +698,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  		CHECK_AND_SET_TERMS,
>  		BISECT_NEXT_CHECK,
>  		BISECT_TERMS,
> -		BISECT_START
> +		BISECT_START,
> +		BISECT_AUTOSTART,
>  	} cmdmode =3D 0;
>  	int res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -689,6 +723,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  			 N_("print out the bisect terms"), BISECT_TERMS),
>  		OPT_CMDMODE(0, "bisect-start", &cmdmode,
>  			 N_("start the bisect session"), BISECT_START),
> +		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
> +			 N_("start the bisection if it has not yet been started"), BISECT_AU=
TOSTART),
>  		OPT_BOOL(0, "no-log", &nolog,
>  			 N_("no log for BISECT_WRITE")),
>  		OPT_END()
> @@ -748,6 +784,12 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
>  		set_terms(&terms, "bad", "good");
>  		res =3D bisect_start(&terms, argv, argc);
>  		break;
> +	case BISECT_AUTOSTART:
> +		if (argc)
> +			return error(_("--bisect-autostart does not accept arguments"));
> +		set_terms(&terms, "bad", "good");
> +		res =3D bisect_autostart(&terms);
> +		break;
>  	default:
>  		BUG("unknown subcommand %d", cmdmode);
>  	}
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 2f60fefcfa..4e9b2d36cb 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -49,27 +49,6 @@ bisect_head()
>  	fi
>  }
>
> -bisect_autostart() {
> -	test -s "$GIT_DIR/BISECT_START" || {
> -		gettextln "You need to start by \"git bisect start\"" >&2
> -		if test -t 0
> -		then
> -			# TRANSLATORS: Make sure to include [Y] and [n] in your
> -			# translation. The program will only accept English input
> -			# at this point.
> -			gettext "Do you want me to do it for you [Y/n]? " >&2
> -			read yesno
> -			case "$yesno" in
> -			[Nn]*)
> -				exit ;;
> -			esac
> -			bisect_start
> -		else
> -			exit 1
> -		fi
> -	}
> -}
> -
>  bisect_start() {
>  	git bisect--helper --bisect-start $@ || exit
>
> @@ -108,7 +87,7 @@ bisect_skip() {
>  }
>
>  bisect_state() {
> -	bisect_autostart
> +	git bisect--helper --bisect-autostart || exit
>  	state=3D$1
>  	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD |=
| exit
>  	get_terms
> @@ -149,7 +128,7 @@ bisect_auto_next() {
>
>  bisect_next() {
>  	case "$#" in 0) ;; *) usage ;; esac
> -	bisect_autostart
> +	git bisect--helper --bisect-autostart

Just like above, we need an `|| exit` here.

Other than that, this patch looks good to me.

Thanks,
Dscho

>  	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD=
|| exit
>
>  	# Perform all bisection computation, display and checkout
> --
> 2.25.0
>
>
