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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02119C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF196206D5
	for <git@archiver.kernel.org>; Fri, 22 May 2020 19:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JhbGNuai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbgEVT17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 15:27:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:51119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730866AbgEVT16 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 15:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590175675;
        bh=zHy1t7q1PTj/wThifjwlQZvn19H3b2UdmpjlqtvsoMA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JhbGNuaiTTFBezE3LzUwAzlHtsFsLyMi93fNV7U8ICbIm13PxulhHcLTS0+dCowx9
         tKhIZqDi7zz9Z0Va8jEE6kQlnrr1/7lUppqTaejzoic5V78SijiVqQnWPpQxj74pzR
         Wxrp7+fc7B41HNlMbPiwzVjo9w4ZpUeGkY0ViW2U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([213.196.213.226]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowKc-1jFmrs3cTu-00qUxT; Fri, 22
 May 2020 21:27:54 +0200
Date:   Fri, 22 May 2020 21:27:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v3 04/12] bisect--helper: reimplement `bisect_autostart`
 shell function in C
In-Reply-To: <20200423070704.39872-5-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005222058380.56@tvgsbejvaqbjf.bet>
References: <20200423070704.39872-1-mirucam@gmail.com> <20200423070704.39872-5-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6Zn9PMSyv2zwbKilRqe/BQpRB1n5J/AUcZmMkSXGfp+oS3JiMDH
 tftCOcOSlnxwdmElUckJNHtIPBXhSU5kxKymnxMTjbYfUPc62rLpSmBmqAHTjgoWsGzKv5k
 1jmGFiX7S8/lIYYXzBRrLVd+6jpyuS9c/DfMMzIpiC7CDHR093qzajx+NnLrQjMpIpwO3I+
 2TIP7cgpp0EpVx+aTN7aQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UbAVAxpB1fE=:VSgG1MRzd99D8gYZcFwW3D
 /G9X5BcYwFELwU6KvdRJo6VvHKYrHsdroa4mJeXnJAgiSBLvSvLxVSStZDSMKechmVEas6XVm
 AeGk0wG8QiUe4BeRHOK5p/XfzprWxt1+2clgmAK2hv2TqI3XLB7+Z0nbSq7bzb8/DzJTd6eOM
 grCOgNv/WBhMXGawUlByJW8Zezkql8hCk2uEdJ4MZp5H1QTMomblbxifRMeggbFQVQ/x4+smE
 n3L8VOTv60v0MJ4g6CGmAxoVHCp4hUl+ajqkia09U4G+xJ+jYu7ODdZDNZWcYLCssLL0bADl1
 IbSs8ct0RtDNNsyNzbCbI3Sl7kEmqYgx35YqrFgDeFTWKLaUJdwppZ58WHoMnO28e9UPoGhTC
 3GCBFMjvqicZQi6lxaO6ZIdHURJIg3hE1nS3k7ayhmN7k7krUoug4hm+OdSMztw/F+ji0kVUw
 1z7uCvd7IoZHuOyUR4LCvFZ4c1tu9viV3xfqT8/mNLhwLf5UpCbLLxSj2daCMkKy6YqRiIW2L
 5jx0DpSud6QZkwkKa+4XR2tTZKk4bETqYnMsuLd9bXJ4jJWCb+tvGCaOKXDQ+sbvulcEBekbB
 4ukeFnRHa/DDxdSaMjVrL8KDQNLY1e1qCYyaOHebgM784CqD9pKgjH39/O76yfjUimQfUv6gb
 /wxd5bW5l4Y8viivF454rq9+X3v6KOifyYjfImKpQ9i3+vKc9B7i5rX0K3wBzW5HLVwHjhaOp
 61lzD5dSm0nLlq6d7Kt/dqMDGIujQY0YFszUseRktimVwDpzd81z26geHYQQ+iSrOeRHxaxuM
 iC88UOcVjH1UbkfAIzDUnDMbPWx7ZROrb+Rd0Si1ZCZUu7HGS0tfhMxStmGxBpSHyKF0cgEbr
 Cvui4SIb7RtJsTwrtXXdmFZh0NpU1r74nP18LsuWe11ee2qu/bbZ+djyMNf2Pl+6HtT30oRIH
 NJ3W4qzuv81PCxl8ffsBGw4P6IBVjsCuzfvXsELAKWEQ4MTBEv67EnueUQVyJzh988WcJ95IJ
 p+5qJh2Y3CN0yAaoDyYdJbkj0I09P8TNR5CT82Uyhum/lOcjxhEnJUqs2Q2Wyn7FSAayHLHmM
 wM9tsJ0PAArdCa7VdC8+BMoEVDFfeYhiJEE0OWqsHVk4r2LrWhjfL7r4AHSp+frDlWhYThxoH
 /AtJQVKGmirUj2cupoKXyntZFQlz47wf/FA8j0oRjLpFp5QiUKiGgTJkKwJl0IGdRS4H/hJyK
 jMoyqbZg3V012iQew
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Thu, 23 Apr 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Reimplement the `bisect_autostart()` shell function in C and add the
> C implementation from `bisect_next()` which was previously left
> uncovered. Also add a subcommand `--bisect-autostart` to
> `git bisect--helper` be called from `bisect_state()` from
> git-bisect.sh .

I know you did not author this, but maybe I can still ask you to address a
couple of concerns I have? I kind of stumble when I read "Also add a
subcommand ... be called from ... from ...".

Also, why the funny space before the full stop?

> Using `--bisect-autostart` subcommand is a temporary measure to port
> shell function to C so as to use the existing test suite. As more

Likewise, "... to port shell function..." might benefit from inserting
"the" in the middle?

> functions are ported, this subcommand will be retired and
> bisect_autostart() will be called directly by `bisect_state()`.
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  git-bisect.sh            | 25 ++-----------------------
>  2 files changed, 41 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index d3b2b33df0..9df69800e3 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -29,6 +29,7 @@ static const char * const git_bisect_helper_usage[] =
=3D {
>  	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --te=
rm-bad | --term-new]"),
>  	N_("git bisect--helper --bisect-start [--term-{old,good}=3D<term> --te=
rm-{new,bad}=3D<term>]"
>  					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
> +	N_("git bisect--helper --bisect-autostart"),
>  	NULL
>  };
>
> @@ -55,6 +56,8 @@ static void set_terms(struct bisect_terms *terms, cons=
t char *bad,
>  static const char vocab_bad[] =3D "bad|new";
>  static const char vocab_good[] =3D "good|old";
>
> +static int bisect_autostart(struct bisect_terms *terms);
> +

Why forward-declare it? There is no reference before it is defined below,
so I think this forward-declaration can be removed without any problem.

>  /*
>   * Check whether the string `term` belongs to the set of strings
>   * included in the variable arguments.
> @@ -630,6 +633,32 @@ static int bisect_start(struct bisect_terms *terms,=
 int no_checkout,
>  	return res;
>  }
>
> +static int bisect_autostart(struct bisect_terms *terms)
> +{
> +	const char *yesno;
> +
> +	if (!is_empty_or_missing_file(git_path_bisect_start()))
> +		return 0;

This is a bit more convoluted to read than the shell script:

	bisect_autostart() {
		test -s "$GIT_DIR/BISECT_START" || {
			gettextln "You need to start by \"git bisect start\"" >&2
			[...]
		}
	}

The `test -s <file>` command succeeds if the file exists and is non-empty.
Which makes sense: either the file exists and is non-empty, or we need to
do something.

When I read the C version, it takes me a bit more time to figure out what
is going on here. Maybe we could introduce a helper function like this and
use it here?

	static inline int file_is_not_empty(const char *path)
	{
		return !is_empty_or_missing_file(path);
	}

> +
> +	fprintf(stderr, _("You need to start by \"git bisect "
> +			  "start\"\n"));

If you use `fprintf_ln()` here, you can keep the string identical to the
shell script version, i.e. without the trailing newline. That will allow
the translations to be re-used, lessening the burden of the i18n team.

> +
> +	if (!isatty(STDIN_FILENO))
> +		return 1;

I would prefer it if only `cmd_*()` functions return positive values for
the error case.
> +
> +	/*
> +	 * TRANSLATORS: Make sure to include [Y] and [n] in your
> +	 * translation. The program will only accept English input
> +	 * at this point.
> +	 */
> +	yesno =3D git_prompt(_("Do you want me to do it for you "
> +			     "[Y/n]? "), PROMPT_ECHO);

Technically, `PROMPT_ECHO` is not required here as `git_prompt()` adds
that flag implicitly unless you pass in `PASS_ASKPASS`, but I guess it
does not hurt here.

However, I cannot fail to note that this constitutes a change of behavior,
as `git_prompt()` does _not_ read from `stdin`.

Maybe we should call `git_read_line_interactively()` instead, after
writing the prompt to `stderr` explicitly?

> +	if (starts_with(yesno, _("n")) || starts_with(yesno, _("N")))

This is wrong: "n" and "N" should not be translated, as they are not
translated in the shell script version, either:

			case "$yesno" in
			[Nn]*)
				exit ;;
			esac

In light of this, a much, much shorter version would be:

	if (tolower(*yesno) =3D=3D 'n')
		return -1;

(I use `-1` here because this is not within a `cmd_*()` function.)

However, I still think that we need to call `free(yesno);` or we leak
memory. My preferred way would be:

		int ret;
		[...]

		ret =3D tolower(*yesno) =3D=3D 'n' ?
			-1 : bisect_start(terms, 0, NULL, 0);

		free(yesno);
		return ret;

> +		return 1;
> +
> +	return bisect_start(terms, 0, NULL, 0);
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -642,7 +671,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  		CHECK_AND_SET_TERMS,
>  		BISECT_NEXT_CHECK,
>  		BISECT_TERMS,
> -		BISECT_START
> +		BISECT_START,
> +		BISECT_AUTOSTART,
>  	} cmdmode =3D 0;
>  	int no_checkout =3D 0, res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -666,6 +696,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  			 N_("print out the bisect terms"), BISECT_TERMS),
>  		OPT_CMDMODE(0, "bisect-start", &cmdmode,
>  			 N_("start the bisect session"), BISECT_START),
> +		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
> +			 N_("start the bisection if BISECT_START is empty or missing"), BISE=
CT_AUTOSTART),

Not that it matters a lot because this command mode will go away soon
thereafter, but this describes an implementation detail rather than the
purpose of the function. I would much rather read "start the bisection if
it has not yet been started" instead.

>  		OPT_BOOL(0, "no-checkout", &no_checkout,
>  			 N_("update BISECT_HEAD instead of checking out the current commit")=
),
>  		OPT_BOOL(0, "no-log", &nolog,
> @@ -727,6 +759,12 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
>  		set_terms(&terms, "bad", "good");
>  		res =3D bisect_start(&terms, no_checkout, argv, argc);
>  		break;
> +	case BISECT_AUTOSTART:
> +		if (argc)
> +			return error(_("--bisect-autostart requires 0 arguments"));

Maybe "--bisect-autostart does not accept arguments" instead?

Ciao,
Dscho

> +		set_terms(&terms, "bad", "good");
> +		res =3D bisect_autostart(&terms);
> +		break;
>  	default:
>  		BUG("unknown subcommand %d", (int)cmdmode);
>  	}
> diff --git a/git-bisect.sh b/git-bisect.sh
> index efee12b8b1..426d443e7e 100755
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
> +	git bisect--helper --bisect-autostart
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
>  	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD=
|| exit
>
>  	# Perform all bisection computation, display and checkout
> --
> 2.25.0
>
>
