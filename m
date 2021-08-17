Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D909FC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03CC60EBD
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbhHQLbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 07:31:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:48047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239751AbhHQLbU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 07:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629199844;
        bh=9wy1vG0t0iRxQD5eI8XCM+2helekTzlIBihYSNJN/Jc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VnQY3GNO81dzJ1C4nvOLGZ2VkVGc+fMQ9il/y3V0gqlLiMARcmYUgy0TqHtSAp3nh
         1EV7+OLw9mhNrJTR9J5Vun8Xq0/jqbT1AodLUjBywGpSHJNHY+HpD5wMNBYb90lQlU
         HAOfDJT/gf5FHOTXsK5udpPoK5vpFFbPjt6LwdWU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1n6xEJ137H-00swAq; Tue, 17
 Aug 2021 13:30:44 +0200
Date:   Tue, 17 Aug 2021 13:30:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v4 4/6] bisect--helper: reimplement `bisect_visualize()`shell
 function in C
In-Reply-To: <20210817081458.53136-5-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108171329241.55@tvgsbejvaqbjf.bet>
References: <20210817081458.53136-1-mirucam@gmail.com> <20210817081458.53136-5-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6BkSP5lclT0mF0W7Vh07bNVWM+FpzjfCmtFyuoTCRSsVtauCRWC
 aZMCXSJdmJ+k4v6k8SGrVpZ9p43HbRdcbUA64ykkJfVPQpyxJJNJgdWpJ/82A1BCe/Ixgu2
 695oif4FB0Kph1QVTErp4g5useFY2PIUC/lk8dCPg3lMxk+LBlahlt8bM4SspUnzsd0fyV8
 b+SWJNxarRz2A9c0V9m8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m8bI7u3JXqA=:CYowgTFB1NdcYMRiIyfcxS
 qhxXb6ALyALG04E6rdKx5u0CHamSQsk3uzR3L3SXeOPzVBoGsQNSYVOyEViSU04suScq3MMBx
 vqRY01O26P9RaCfBVphEAi0sySb9pZ0yNLQIhATFWLSa5popDjdBdXZie8ZkhDb9201U731Tv
 84pCyTEJ7X3zHDqj7BsM3ZBnqyrLNS6zbImxvH+UdJYa6ufhu/aZE91W54W3Ji9m9qKTdevxa
 SWE3eJaDLkHjZ9Q1k11vBkbXusqG65URGi+dsrKSCTjIvm8Dfgyhadh2YH6cePdU8u1jd+RfF
 AmmocqghDWPKZ2Y5MBJo/ELPpH9CTBTtHwvnL8kqUxKYmqkh24roBEdTcMwUtF8lNXFqV8VX3
 sSrNK1/cyx+wOTlMX4/DhIGFZIrujBJoBJwEK4ezLoi9quBrYuGHenMOTJ8/jrkrABJi8c4md
 HuQMnU+sE486Pl1gVg/o2kjJ92GwJa3FCiN7ePclugFujwntg8/+pHZi4pqodiAonzMPIt0Oc
 HIyJB+Z736kw/OdH+RZ7x67VpYNwxo1wtMV1UimDxCmm3f3sbXptylxmXv1k/lm1DMVLIS9dO
 pe4ABz+xeKiIP+AnxcNk8AEaG599VZQUMqaC38r1C4dszLNJTMEV+sBM4EXUMTUr+qj+JZvBk
 ZDDiR16L81B5c57owbaBX3EdXPN1HKDOSdXDp2KImGzEYdeHKO/GrPLqUi4aLzfwEtkcKfyck
 /xHo5jznUZqgmRJoHNXCQzf9x98/kIG5O7f132YTKsQdQrn8KvxO4+XwvyEUj1603ntuIcVmC
 iZp2eTtRTJ3liC71AC+ONuJgQdY2rP8hpP10Ig99f3iSz6sZZSvW9fUgQeFY68HOvXqPcsmlK
 aHAZucm9BbcPJHy4HK66qaXHoZJUS41GedhZgVsCqsByZQCnjvAJD0WmB4WDaJFthtJTukV+d
 04MfQfA2YR8Ihoqt4s4Wvj/8F3QsL0ZHZtFnspz5wVKLPjD3ccXlhIIm8i7UEtn/V0VJdPbpA
 1qK/GDt5xZZA4a150q+Xzyx/I5/89/g0d1KWJmF0Vqe3oD2Wyb/pF2fwEBD3PzXXk/Bo4+wSC
 tf5CT/DhKpC4WdG4gzM5qQ5qoIaYaGhcaNOCZrD0HnvsJevj3HNiCip7Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

this looks good!

Just one suggestion (but I won't insist on it):

On Tue, 17 Aug 2021, Miriam Rubio wrote:

> @@ -1036,6 +1037,44 @@ static enum bisect_error bisect_skip(struct bisec=
t_terms *terms, const char **ar
>  	return res;
>  }
>
> +static int bisect_visualize(struct bisect_terms *terms, const char **ar=
gv, int argc)
> +{
> +	struct strvec args =3D STRVEC_INIT;
> +	int flags =3D RUN_COMMAND_NO_STDIN, res =3D 0;
> +	struct strbuf sb =3D STRBUF_INIT;
> +
> +	if (bisect_next_check(terms, NULL) !=3D 0)
> +		return BISECT_FAILED;
> +
> +	if (!argc) {
> +		if ((getenv("DISPLAY") || getenv("SESSIONNAME") || getenv("MSYSTEM") =
||
> +		     getenv("SECURITYSESSIONID")) && exists_in_PATH("gitk"))
> +			strvec_push(&args, "gitk");
> +		else {
> +			strvec_pushl(&args, "log", NULL);

This could be written more concisely as `strvec_push(&args, "log")`.

> +			flags |=3D RUN_GIT_CMD;
> +		}
> +	} else {
> +		if (argv[0][0] =3D=3D '-') {
> +			strvec_pushl(&args, "log", NULL);

Same here.

Otherwise, it looks good to me!

Thank you,
Dscho

> +			flags |=3D RUN_GIT_CMD;
> +		} else if (strcmp(argv[0], "tig") && !starts_with(argv[0], "git"))
> +			flags |=3D RUN_GIT_CMD;
> +
> +		strvec_pushv(&args, argv);
> +	}
> +
> +	strvec_pushl(&args, "--bisect", "--", NULL);
> +
> +	strbuf_read_file(&sb, git_path_bisect_names(), 0);
> +	sq_dequote_to_strvec(sb.buf, &args);
> +	strbuf_release(&sb);
> +
> +	res =3D run_command_v_opt(args.v, flags);
> +	strvec_clear(&args);
> +	return res;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -1048,7 +1087,8 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
>  		BISECT_STATE,
>  		BISECT_LOG,
>  		BISECT_REPLAY,
> -		BISECT_SKIP
> +		BISECT_SKIP,
> +		BISECT_VISUALIZE,
>  	} cmdmode =3D 0;
>  	int res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -1070,6 +1110,8 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
>  			 N_("replay the bisection process from the given file"), BISECT_REPL=
AY),
>  		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
>  			 N_("skip some commits for checkout"), BISECT_SKIP),
> +		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
> +			 N_("visualize the bisection"), BISECT_VISUALIZE),
>  		OPT_BOOL(0, "no-log", &nolog,
>  			 N_("no log for BISECT_WRITE")),
>  		OPT_END()
> @@ -1131,6 +1173,10 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
>  		get_terms(&terms);
>  		res =3D bisect_skip(&terms, argv, argc);
>  		break;
> +	case BISECT_VISUALIZE:
> +		get_terms(&terms);
> +		res =3D bisect_visualize(&terms, argv, argc);
> +		break;
>  	default:
>  		BUG("unknown subcommand %d", cmdmode);
>  	}
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 6a7afaea8d..95f7f3fb8c 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -39,29 +39,6 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>  TERM_BAD=3Dbad
>  TERM_GOOD=3Dgood
>
> -bisect_visualize() {
> -	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || ex=
it
> -
> -	if test $# =3D 0
> -	then
> -		if test -n "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYS=
ESSIONID+set}" &&
> -			type gitk >/dev/null 2>&1
> -		then
> -			set gitk
> -		else
> -			set git log
> -		fi
> -	else
> -		case "$1" in
> -		git*|tig) ;;
> -		-*)	set git log "$@" ;;
> -		*)	set git "$@" ;;
> -		esac
> -	fi
> -
> -	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
> -}
> -
>  bisect_run () {
>  	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || ex=
it
>
> @@ -152,7 +129,7 @@ case "$#" in
>  		# Not sure we want "next" at the UI level anymore.
>  		git bisect--helper --bisect-next "$@" || exit ;;
>  	visualize|view)
> -		bisect_visualize "$@" ;;
> +		git bisect--helper --bisect-visualize "$@" || exit;;
>  	reset)
>  		git bisect--helper --bisect-reset "$@" ;;
>  	replay)
> --
> 2.29.2
>
>
