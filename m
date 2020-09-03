Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE53C433E9
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 14:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DD52072A
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 14:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MvkVNo9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgICOvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:51:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:51813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729226AbgICOPV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 10:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599142491;
        bh=prODP4Nv37MnK5tQV2v/eWV1GCqKoWRAa3ihqu7T9GI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MvkVNo9Vi8dDtvbfoyPIC4TIXlQFItNVQif+iEm86d8VhShkcs+0///7zjONlXPWl
         o06v5I1q7xE+IZbwi7FM6vFpWHouxVRyE4Ie7HB1WByQYmKK/ZpHNWUcXBWr5F43m/
         3AE7cddeFNBxuFW//t6fS+6sbO+oTAl2xDYrJmnI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([213.196.212.246]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQj7-1kLl2M11gL-00Gnec; Thu, 03
 Sep 2020 16:14:51 +0200
Date:   Thu, 3 Sep 2020 07:50:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v7 04/13] bisect--helper: reimplement `bisect_autostart`
 shell function in C
In-Reply-To: <20200831105043.97665-5-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009030737080.56@tvgsbejvaqbjf.bet>
References: <20200831105043.97665-1-mirucam@gmail.com> <20200831105043.97665-5-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t6RM/fls86pQI0977faEs2wICNlDrA/mgiBEoHNRP23s8iuvVma
 j6TdWCkDGs/CriXaMc0DphhCfbRybrNhRztmkXBHJ8mJ5T6HaDhps7GZnMVE2bU4VZsQvpT
 qEjlqYdXOAo4ERAnNmlb7VGo3cSe+rlI6J71Vx+mVV67zxJbXDeCWgs1CWyq3VMndMeGz4Q
 JJdHYvWhMblqUraCNBxSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jnpxKu69qdg=:ldZrRc1htR6EFxdebOzUgS
 rNGDfkhSXs9izdna9dfHRk4t2pg8CM9lilP6nbLZuUBceWwcrKKkya8hw5cMzMrCOFFIc0WXH
 OkOfpKokav8oetUtHrjO7SMm2JyGO2MMicAo8R9/mS7qLBnH+RSClgJOTGIhPMZziGcwNJif2
 7UAJAujLZ44sJklU57kZN7tpTD23Wf5X4lCYZduTnTqbwIeRFCjHhCMBXiZykXzl/r55teHue
 G4gODAPphl1OeaUESPqnThDuT6QPVSvVI38fYmQksfSRlmNfHOCm+PFAwXLNsDIueZLWRJeUw
 HYyIfZaDsjdodvMvhsgNRvG1G56LFVkEPllkW/REcWtvrXqrRCP8s79fGC7PyyTvvIgxxC1IP
 v/HGMgdSQwG4wITgAMYvQWmEBm7rL7hrLw3i9grpPkmsDstR3zmkQae/J9DmnsnhT+9wEXXnC
 jXg+DHng8hfZvW4MOrOlZ3YTNet2DHpVHEvzv/9fw7zx0CzUKujIBGFWAb3uJXyR9nYYGaWye
 pDlPn9gbWaNGkvOi4pD5ADvRo6zx3G8sStFe6xH8gQNQIN8E9sisTvKjVRvJY8y1e5xAUdPDR
 LHhX7Qx0zZx2+ZVHPjLmtHzVxmA8yqhqyOVBtM79W+uGVJU4KL0IJQBJfHw7HwJVzrbFlllOW
 vXDMN1oMjtc9z7K47aIlCZQUSgQMxMWz5vVo8m4LOMPzaxzyUwmrs1FypN2Bp8NRWj0xrCFzE
 T0HYWfkrqohobPkEmxPQ41zGyvGPgjRdbbF1bthjWAFIHbqCx6KpmTGfkyDi6pF4ItAFoCn5C
 DB/sJJiyZuS3P06UBeAXKeRBpB/8uBWQgDt9oDY1IUeH4NYWAV1hW45FqmQZlYo4cp3c943eX
 pzRq15SAYNeRfD2ID/tPUFlzdLBzXjpHiBxmBLoucCpNxgLmEHUGwYTSbWuupm0/PzZbc3Qpb
 vJHtt4kap4FSqZc8RrU4ukaR4hBEJeCIzgyJInhigSIEHweYpfxx0qu9sl2IMw4xrwYL0fS3l
 2cyyh7ujwsXSEnKvuuu5XKgV7X0Xq4PUuKu4O1oK9JjXrmSTcmIi2CvNNCkI5fXIfyhD0FiiX
 UQD27F/w6EoyBfjw4/O2xxikMCKMMqKA7s4XyQEmtCmtLAiAci2bOKHEglUruQCDPNCJGBFmI
 dpaexy5whzAPosMakTz4AE0Mj0/LZJi9UPvYYRvlzekliW2VoQ/UNn1+60515LsbTuDRhSZ6J
 sP07IetLU1Hkfxm5TkeCHF0SWxhI3njn0wqbN0w==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Mon, 31 Aug 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Reimplement the `bisect_autostart()` shell function in C and add the
> C implementation from `bisect_next()` which was previously left
> uncovered.
>
> Add `--bisect-autostart` subcommand to be called from git-bisect.sh.
> Using `--bisect-autostart` subcommand is a temporary measure to port
> the shell function to C so as to use the existing test suite. As more
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
>  builtin/bisect--helper.c | 44 +++++++++++++++++++++++++++++++++++++++-
>  git-bisect.sh            | 25 ++---------------------
>  2 files changed, 45 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index bae09ce65d..f71e8e54d2 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -29,6 +29,7 @@ static const char * const git_bisect_helper_usage[] =
=3D {
>  	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --te=
rm-bad | --term-new]"),
>  	N_("git bisect--helper --bisect-start [--term-{old,good}=3D<term> --te=
rm-{new,bad}=3D<term>]"
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

Not a big deal, but we have only two callers to `isatty()` that use the
`_FILENO` constants, and neither of them is about stdin. But that is not a
big deal.

> +		return 0;

However, when we cannot auto-start, the shell script version calls `exit
1` to cause a failure. I think we need to do the same here, i.e. `return
-1;`.

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

The corresponding shell script code reads like this:

                        read yesno
                        case "$yesno" in
                        [Nn]*)
                                exit ;;
                        esac

That is, if the user does not want to start, the command exits. With exit
code 0, i.e. success.

However, we do not do that here.

Now, you could argue (in the commit message) that this actually fixes a
bug (because if the bisection was aborted, that does not count for
success), and I'd be fine with that.

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
> index c7580e51a0..9ca583d964 100755
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

This (and the change below as well) is insufficient, as it won't `exit` in
case of an error (or in case the user aborted). I think you need to append
`|| exit` as is done two lines below this line.

Ciao,
Dscho

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
