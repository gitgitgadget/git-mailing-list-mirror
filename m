Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B35C3F2C2
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 21:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34ECA24690
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 21:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="F8QaOmFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgB0Vkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:40:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:49675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgB0Vkw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 16:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582839648;
        bh=Rb4F+nwZDV1GLERTANCJdUYA9y87sumor5j0Q9bKcaU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F8QaOmFxyDCyFVloVSUCd98x4+HzlEjykyFZEhtm04rx9VDWizgu3MVZkWf8L8AYz
         pyuKpDqc4lMylQjECSCVTtvIg5xOdFPOA+LUfB24iRvjcvm3jd9linmnULKvLccho7
         5Jxyl9DJ7iMYqjH0/mq6YzDF/Bvi2Ej/jSclcS/A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1jD9OP0PWH-00EhNv; Thu, 27
 Feb 2020 22:40:48 +0100
Date:   Thu, 27 Feb 2020 22:40:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH 06/10] bisect--helper: reimplement `bisect_autostart`
 shell function in C
In-Reply-To: <20200226101429.81327-7-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002272239330.46@tvgsbejvaqbjf.bet>
References: <20200226101429.81327-1-mirucam@gmail.com> <20200226101429.81327-7-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jkV8i/JRDyAQKyMPr/VFG+/ch2VkRGDXIrMl/YAdjB0eFznkW1c
 0Y3KwPpFj10rGVE4REIb6/abTRNSVxi/8GvUfDuKP1eByIo65ijfm6NcSvU1uqr6dQ3g3oS
 t/HNqNr+Mu+33vm2IkIxKIfQiQSYGyoMq71FEwxrfAL3kbVsRNbRlJV0C5PjfLBSsZoM/Zl
 xiHsBlbzl+BprEktbkmmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YF45DQBgD+I=:r/g8jsa7T7xBuRxYsp78A0
 yIjh+KND/ZZvK2liTXdJ98j8SQ8HP9FiTzRgqGQcCUIOt339kOT2gBco2V9sJvQfgT4XoZBDm
 1LZFydy9Y3hptHaGUgDAJSFUvx0/L4+eMogCFfiH3mPLUpY0Rai9O5yl+XZ9vdHs5cfdQ9X5N
 UxWahGv/3tZVZfR3qL8EgLIx+r4pwMvUS5mL2ZJvp0PSMFYv5Yt8ebPTx4TLrNCc2ryUCZuRE
 l116TYvIvPMElSNBcgdgWzmxJHE1f0Z71fs0AUBVXlhnVXdQH8A7HRB8D/3s44zKqp8b6Zbla
 +iZ+uNJtA2VkQaEkDkbulWyfRyreuzUJ5fh/piyWMQIpAuyOQD6Hziyd+K9ojrgiYvGB403EO
 FTo+u/mFqUTprcjIe6q5Mguq2h6al7bBgR5nelq2yspFEa6hlj5gYeSRRSEEy8W0GwAabSdvP
 seGFJC3h1MRWCJI51jzOpgFrr7Mxd12X92xKIXo7XvjLGvShB0IXxXl4LEzrR/Vl1kma9N1um
 dr1RCTA9vtO1vAL242amSgg9hcsR5lv55TmOazqb3JfMyeO/LpY5QyUMNXSxp5X7u8uyEP/Fr
 G6DX7cjrG8nYTcN+MRtWoCtb9dUBFcMSyRC+Wba+AGgATB1+cF773lgIOmpmHI3Gm3P69829H
 xicHI0TzC7HSIJct99i2V/PODbfDKx+L/GsjqIh1NlTug9W5SGv/hatJ5d6MxbcC6pZfbE2sl
 /4vV6U9mL616IsT30XlF0uPLe1sFvWdt8i8f/v1mBsN0Ow/IFZ/5hQ5T2AdhQkO/nJzhZ07Va
 uXPewl2++cL/6RSINQt4KQ5eqhYqQomIbt6KZaJ4ftP4Skyy18UIw4z891Ai0UKibo6gg+Ir7
 DR+qxGFN7oBHOqQj/90M7HK8mlFUtdaA6Am5RTeB+tNEG6BlT3U1s1Kl1XNUSxSbVep3tIpl1
 Ji0q4mJrNAuMYWlWLRpuFcLV0iAxGdPvdv5gqvTrRPAfzsqgP+vmph5wl/J6SIZUu65YwjXFO
 x2XuzMS8XivuUoAaXAycFYL8b+F6BCfzSyunBdAzTNVDTs4hJtqST9y81sY+uXVPsfkone8Ue
 +T4XxJHViXIkhWYXUdoidzEvxtuuOSYO4x5Rh34pyEsuQ+yelXBaipS+GReNdG4K3CiO8FbS3
 he7/Ln+Ay4DP1qjLNEoImial903cZNTYcTSjfmOG+8tc2ucy2afVl7bvrylKq8SlTX9np2qg6
 yMGxLlwT1k7jYfq07
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 26 Feb 2020, Miriam Rubio wrote:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index c3bb936a40..f9b04bee23 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -56,6 +57,8 @@ static void set_terms(struct bisect_terms *terms, cons=
t char *bad,
>  static const char vocab_bad[] =3D "bad|new";
>  static const char vocab_good[] =3D "good|old";
>
> +static int bisect_autostart(struct bisect_terms *terms);
> +

Can we move the definition of said function here? If so, we can save
ourselves the forward-declaration of it.

>  /*
>   * Check whether the string `term` belongs to the set of strings
>   * included in the variable arguments.
> @@ -555,6 +558,7 @@ static enum bisect_error bisect_next(struct bisect_t=
erms *terms, const char *pre
>  	int no_checkout;
>  	enum bisect_error res;
>
> +	bisect_autostart(terms);
>  	if (bisect_next_check(terms, terms->term_good))
>  		return BISECT_FAILED;
>
> @@ -803,6 +807,32 @@ static enum bisect_error bisect_start(struct bisect=
_terms *terms, int no_checkou
>  	return res;
>  }
>
> +static int bisect_autostart(struct bisect_terms *terms)
> +{
> +	if (is_empty_or_missing_file(git_path_bisect_start())) {

As a rule, we do prefer to handle early exits first. In other words, I
would suggest starting this function by:

	if (!is_empty_or_missing_file(git_path_bisect_start()))
		return BISECT_OK;

That way, not only can you save on indentation, but it also frees one slot
of the readers' working memory.

(Of course you would still need to ove the declarations before this
statement.)

> +		const char *yesno;
> +		const char *argv[] =3D {NULL};

Please separate declarations and statements with an empty line. I would
also prefer spaces around the curly brackets, i.e. `{ NULL }` instead of
`{NULL}`.

> +		fprintf(stderr, _("You need to start by \"git bisect "
> +				  "start\"\n"));
> +
> +		if (!isatty(STDIN_FILENO))
> +			return 1;
> +
> +		/*
> +		 * TRANSLATORS: Make sure to include [Y] and [n] in your
> +		 * translation. The program will only accept English input
> +		 * at this point.
> +		 */
> +		yesno =3D git_prompt(_("Do you want me to do it for you "
> +				     "[Y/n]? "), PROMPT_ECHO);
> +		if (starts_with(yesno, _("n")) || starts_with(yesno, _("N")))
> +			return 1;
> +
> +		return bisect_start(terms, 0, argv, 0);

Do we really need this `argv`, or can we pass `NULL` directly? We say that
there are zero arguments, after all, therefore `bisect_start()` should not
even look at `argv`.

The rest of the patch looks good to me.

Thank you,
Dscho

> +	}
> +	return BISECT_OK;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -816,6 +846,7 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  		BISECT_START,
>  		BISECT_NEXT,
>  		BISECT_AUTO_NEXT,
> +		BISECT_AUTOSTART,
>  	} cmdmode =3D 0;
>  	int no_checkout =3D 0, res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -839,6 +870,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  			 N_("find the next bisection commit"), BISECT_NEXT),
>  		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
>  			 N_("verify the next bisection state then checkout the next bisectio=
n commit"), BISECT_AUTO_NEXT),
> +		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
> +			 N_("start the bisection if BISECT_START is empty or missing"), BISE=
CT_AUTOSTART),
>  		OPT_BOOL(0, "no-checkout", &no_checkout,
>  			 N_("update BISECT_HEAD instead of checking out the current commit")=
),
>  		OPT_BOOL(0, "no-log", &nolog,
> @@ -905,6 +938,12 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
>  		get_terms(&terms);
>  		res =3D bisect_auto_next(&terms, prefix);
>  		break;
> +	case BISECT_AUTOSTART:
> +		if (argc)
> +			return error(_("--bisect-autostart requires 0 arguments"));
> +		set_terms(&terms, "bad", "good");
> +		res =3D bisect_autostart(&terms);
> +		break;
>  	default:
>  		return error("BUG: unknown subcommand '%d'", cmdmode);
>  	}
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 166f6a64dd..049ffacdff 100755
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
> -			git bisect--helper --bisect-start
> -		else
> -			exit 1
> -		fi
> -	}
> -}
> -
>  bisect_skip() {
>  	all=3D''
>  	for arg in "$@"
> @@ -86,7 +65,7 @@ bisect_skip() {
>  }
>
>  bisect_state() {
> -	bisect_autostart
> +	git bisect--helper --bisect-autostart
>  	state=3D$1
>  	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD |=
| exit
>  	get_terms
> --
> 2.25.0
>
>
