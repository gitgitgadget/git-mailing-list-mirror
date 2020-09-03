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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237AAC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 18:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77E82083B
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 18:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aNnK0PfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgICSNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:13:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:37237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgICSNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 14:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599156790;
        bh=4j+LacTPQwQxqjK9gtqEY1ZIS9SnV1ZYYcvQS24DVc4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aNnK0PfR2P77AEqHp1dvUIwvxqNXbSER2bqPEsUR/SxDXMQZ6xHu//+PTvfqVQHHt
         LK+mnKUjI5stX08+m1cn+fRC5NABRb8MYa0ijhJjEPcxqSexBDPhAbrsYrMNRVeYc+
         EICTdQSbnTlH5WwdH+UNQiX7+dJYTB+bhaV+2RSg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([213.196.212.246]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1kxvv524yX-00kgo1; Thu, 03
 Sep 2020 20:13:10 +0200
Date:   Thu, 3 Sep 2020 11:48:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v7 06/13] bisect--helper: reimplement `bisect_next` and
 `bisect_auto_next` shell functions in C
In-Reply-To: <20200831105043.97665-7-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009030800000.56@tvgsbejvaqbjf.bet>
References: <20200831105043.97665-1-mirucam@gmail.com> <20200831105043.97665-7-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:feLJRCSpPyQJVeUoWIABtsNfqB7JmDPJ2mBDrnzyzgGiG2jMiGz
 /jmAE4Tq9og4Ng03EXznrMeSu4GzndvxupGqywqi/UEBdkJZ28vKKUbqc/QYmYrTgRIgL1R
 V0ajlS3dyMn/OhvnD4BAgxXkrCsb9MRcqsNNgo5ZpCjHG+/r8+1rCW7DdT/O2n/dHcqrOT1
 8TR8d/iTsn61UWpn/yjBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uXkp1l+SiL0=:s8qp0ibZCcu+LoKqgEY7Tf
 nsta48ycHF5QsRdad+kwmaw37ovRRw2UOFB6DihC89D22glXU4GHnTbOhMayF8rK9EzVOgfjR
 ZAeNsP9YyI4eazP468yTuS5EBfqekNbaIsgQ1qL43e5+dCgO8a0q+Q0NWt+4vbIzb0zeq6Ssq
 1Rk0gSIDgA3MdEIYmJqdX4AOiQKlTN8HOA2/HXHNWzLE700cXECx3yb5oMXATCha/k/2Pq4sv
 RWwBY+qB4dI0ESqn/hi1yaAZz86J1ykB1/MiFaNgCxtJL8Wy8eQedE3KqmuAIgeory+5azz3B
 5JtrUsQO0HZwkFeG3iLAECFWUytAzArkQot59uQMjqRQ+5FoR8tLosQUKMXK7hYfRrWf/uaP9
 6f5aLv0CCyfUFhjd7aA99ZmLnpBTWl9/9YAdrgG4z6CYjX1wewrq/IPVGBPkO9h/wZxtgi9s+
 7jFf3amNQQx8H4TLwnAOXVBSvD5HUU9+hq+LWZiGOwjz/mNkFrgSC02F1Hbx+CGdRW+Mhi3gc
 d6rAQFbq7IyztDd7nmPDQKPZdoCs9g/rG98CDvWN1iQCRe7Pdwri4mwB9U824L9h3R3jgxWTI
 zkPUMf8p/y+sctaIM/eMZVCQ1pWZZ9jgkI8ZM2l6XPctKR8oZJdnU3tHRCvCHPcL9ho2Ju+LI
 At28W7jSOGNwug+LAm12v2pLxFvptjgRZvcRE1s/vMev3keVgq4Pd6rdkTJWitiAC/XxonaFY
 YZ/BUIWmN6Q9W6vRvvJNPlgdEGrIwegCLtOQCKTkWYP3BslUgk4Tg48npphND2A5Hbo1FzR1T
 mWAdqpAqtsvVUgq3zDmJrKNkODND6Q6P1LeaWbgTfx29UMfko3Xxfnhb1Ux0gww0U3PVfb3hN
 OEkaPV/qV++EgfDD+Wf6XuK7NRvKmGdZpeNa8/MfLWbxc21LgJOhiSHU0pPU1REx3O0dEeqyX
 FSbC3BV8wOaipZyAXvwMc/294xHWZoidb1zztIDxjwc+R/LIUKrH6LJQHRQaj5/BV3bTyqPAw
 5Sl7Bldwp4mwxvSaq4kFglK/XDY6KNiS+TcgX9aBh33cGxBJ+l/F1jKSdJY5bYql11DrvywUV
 yk87D1QmjfyIwd8jucWGp+5NjCmTwBykYUmufFixlvS2Ql13DfzGYFSCEB4Oif5tcC9O1kjSU
 b5UnECceadqD6OBx3+/WpBqt2fi3x/SW4PpmpZpdvIWavbrZu+XayPlArZHiUq2N2hup8EZ6S
 q9p39rCsIM5TIvIPeF6utTr/dazpcMPFB8+H91Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Mon, 31 Aug 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Reimplement the `bisect_next()` and the `bisect_auto_next()` shell funct=
ions
> in C and add the subcommands to `git bisect--helper` to call them from
> git-bisect.sh .
>
> bisect_auto_next() function returns an enum bisect_error type as whole
> `git bisect` can exit with an error code when bisect_next() does.
>
> Using `--bisect-next` and `--bisect-auto-next` subcommands is a
> temporary measure to port shell function to C so as to use the existing
> test suite. As more functions are ported, `--bisect-auto-next`
> subcommand will be retired and will be called by some other methods.
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  bisect.c                 |  11 ++-
>  builtin/bisect--helper.c | 180 ++++++++++++++++++++++++++++++++++++++-
>  git-bisect.sh            |  47 +---------
>  3 files changed, 190 insertions(+), 48 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index c6aba2b9f2..f5b1368128 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -988,8 +988,11 @@ void read_bisect_terms(const char **read_bad, const=
 char **read_good)
>   * the bisection process finished successfully.
>   * In this case the calling function or command should not turn a
>   * BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND return code into an error or a=
 non zero exit code.
> - * If no_checkout is non-zero, the bisection process does not
> - * checkout the trial commit but instead simply updates BISECT_HEAD.
> + *
> + * Checking BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND
> + * in bisect_helper::bisect_next() and only transforming it to 0 at
> + * the end of bisect_helper::cmd_bisect__helper() helps bypassing
> + * all the code related to finding a commit to test.
>   */
>  enum bisect_error bisect_next_all(struct repository *r, const char *pre=
fix)
>  {
> @@ -999,6 +1002,10 @@ enum bisect_error bisect_next_all(struct repositor=
y *r, const char *prefix)
>  	enum bisect_error res =3D BISECT_OK;
>  	struct object_id *bisect_rev;
>  	char *steps_msg;
> +	/*
> +	 * If no_checkout is non-zero, the bisection process does not
> +	 * checkout the trial commit but instead simply updates BISECT_HEAD.
> +	 */
>  	int no_checkout =3D ref_exists("BISECT_HEAD");
>  	unsigned bisect_flags =3D 0;
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index f71e8e54d2..e29e86142a 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -8,6 +8,7 @@
>  #include "run-command.h"
>  #include "prompt.h"
>  #include "quote.h"
> +#include "revision.h"
>
>  static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
>  static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV=
")
> @@ -29,10 +30,17 @@ static const char * const git_bisect_helper_usage[] =
=3D {
>  	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --te=
rm-bad | --term-new]"),
>  	N_("git bisect--helper --bisect-start [--term-{old,good}=3D<term> --te=
rm-{new,bad}=3D<term>]"
>  					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<=
paths>...]"),
> +	N_("git bisect--helper --bisect-next"),
> +	N_("git bisect--helper --bisect-auto-next"),
>  	N_("git bisect--helper --bisect-autostart"),
>  	NULL
>  };
>
> +struct add_bisect_ref_data {
> +	struct rev_info *revs;
> +	unsigned int object_flags;
> +};
> +
>  struct bisect_terms {
>  	char *term_good;
>  	char *term_bad;
> @@ -56,6 +64,8 @@ static void set_terms(struct bisect_terms *terms, cons=
t char *bad,
>  static const char vocab_bad[] =3D "bad|new";
>  static const char vocab_good[] =3D "good|old";
>
> +static int bisect_autostart(struct bisect_terms *terms);
> +
>  /*
>   * Check whether the string `term` belongs to the set of strings
>   * included in the variable arguments.
> @@ -80,7 +90,7 @@ static int write_in_file(const char *path, const char =
*mode, const char *format,
>  	FILE *fp =3D NULL;
>  	int res =3D 0;
>
> -	if (strcmp(mode, "w"))
> +	if (strcmp(mode, "w") && strcmp(mode, "a"))
>  		BUG("write-in-file does not support '%s' mode", mode);
>  	fp =3D fopen(path, mode);
>  	if (!fp)
> @@ -109,6 +119,18 @@ static int write_to_file(const char *path, const ch=
ar *format, ...)
>  	return res;
>  }
>
> +static int append_to_file(const char *path, const char *format, ...)
> +{
> +	int res;
> +	va_list args;
> +
> +	va_start(args, format);
> +	res =3D write_in_file(path, "a", format, args);
> +	va_end(args);
> +
> +	return res;
> +}
> +
>  static int check_term_format(const char *term, const char *orig_term)
>  {
>  	int res;
> @@ -451,6 +473,140 @@ static int bisect_append_log_quoted(const char **a=
rgv)
>  	return res;
>  }
>
> +static int add_bisect_ref(const char *refname, const struct object_id *=
oid,
> +			  int flags, void *cb)
> +{
> +	struct add_bisect_ref_data *data =3D cb;
> +
> +	add_pending_oid(data->revs, refname, oid, data->object_flags);
> +
> +	return 0;
> +}
> +
> +static int prepare_revs(struct bisect_terms *terms, struct rev_info *re=
vs)
> +{
> +	int res =3D 0;
> +	struct add_bisect_ref_data cb =3D { revs };
> +	char *good =3D xstrfmt("%s-*", terms->term_good);
> +
> +	/*
> +	 * We cannot use terms->term_bad directly in
> +	 * for_each_glob_ref_in() and we have to append a '*' to it,
> +	 * otherwise for_each_glob_ref_in() will append '/' and '*'.
> +	 */
> +	char *bad =3D xstrfmt("%s*", terms->term_bad);
> +
> +	/*
> +	 * It is important to reset the flags used by revision walks
> +	 * as the previous call to bisect_next_all() in turn
> +	 * sets up a revision walk.
> +	 */
> +	reset_revision_walk();
> +	init_revisions(revs, NULL);
> +	setup_revisions(0, NULL, revs, NULL);
> +	for_each_glob_ref_in(add_bisect_ref, bad, "refs/bisect/", &cb);
> +	cb.object_flags =3D UNINTERESTING;
> +	for_each_glob_ref_in(add_bisect_ref, good, "refs/bisect/", &cb);
> +	if (prepare_revision_walk(revs))
> +		res =3D error(_("revision walk setup failed\n"));
> +
> +	free(good);
> +	free(bad);
> +	return res;
> +}
> +
> +static int bisect_skipped_commits(struct bisect_terms *terms)
> +{
> +	int res;
> +	FILE *fp =3D NULL;
> +	struct rev_info revs;
> +	struct commit *commit;
> +	struct pretty_print_context pp =3D {0};
> +	struct strbuf commit_name =3D STRBUF_INIT;
> +
> +	res =3D prepare_revs(terms, &revs);
> +	if (res)
> +		return res;
> +
> +	fp =3D fopen(git_path_bisect_log(), "a");
> +	if (!fp)
> +		return error_errno(_("could not open '%s' for appending"),
> +				  git_path_bisect_log());
> +
> +	if (fprintf(fp, "# only skipped commits left to test\n") < 0)
> +		return error_errno(_("failed to write to '%s'"), git_path_bisect_log(=
));
> +
> +	while ((commit =3D get_revision(&revs)) !=3D NULL) {
> +		strbuf_reset(&commit_name);
> +		format_commit_message(commit, "%s",
> +				      &commit_name, &pp);
> +		fprintf(fp, "# possible first %s commit: [%s] %s\n",
> +			terms->term_bad, oid_to_hex(&commit->object.oid),
> +			commit_name.buf);
> +	}
> +
> +	/*
> +	 * Reset the flags used by revision walks in case
> +	 * there is another revision walk after this one.
> +	 */
> +	reset_revision_walk();
> +
> +	strbuf_release(&commit_name);
> +	fclose(fp);
> +	return 0;
> +}
> +
> +static int bisect_successful(struct bisect_terms *terms)
> +{
> +	struct object_id oid;
> +	struct commit *commit;
> +	struct pretty_print_context pp =3D {0};
> +	struct strbuf commit_name =3D STRBUF_INIT;
> +	char *bad_ref =3D xstrfmt("refs/bisect/%s",terms->term_bad);
> +	int res;
> +
> +	read_ref(bad_ref, &oid);
> +	commit =3D lookup_commit_reference_by_name(bad_ref);
> +	format_commit_message(commit, "%s", &commit_name, &pp);
> +
> +	res =3D append_to_file(git_path_bisect_log(), "# first %s commit: [%s]=
 %s\n",
> +			    terms->term_bad, oid_to_hex(&commit->object.oid),
> +			    commit_name.buf);
> +
> +	strbuf_release(&commit_name);
> +	free(bad_ref);
> +	return res;
> +}
> +
> +static enum bisect_error bisect_next(struct bisect_terms *terms, const =
char *prefix)
> +{
> +	enum bisect_error res;
> +
> +	bisect_autostart(terms);

We need to handle a negative value returned by `bisect_autostart()` by
aborting, e.g. `return BISECT_FAILED;`.

> +	if (bisect_next_check(terms, terms->term_good))
> +		return BISECT_FAILED;
> +
> +	/* Perform all bisection computation */
> +	res =3D bisect_next_all(the_repository, prefix);
> +
> +	if (res =3D=3D BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> +		res =3D bisect_successful(terms);
> +		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
> +	} else if (res =3D=3D BISECT_ONLY_SKIPPED_LEFT) {
> +		res =3D bisect_skipped_commits(terms);
> +		return res ? res : BISECT_ONLY_SKIPPED_LEFT;
> +	}
> +	return res;
> +}
> +
> +static enum bisect_error bisect_auto_next(struct bisect_terms *terms, c=
onst char *prefix)
> +{
> +	if (bisect_next_check(terms, NULL))
> +		return BISECT_OK;
> +
> +	return bisect_next(terms, prefix);

This returns an error when `bisect_next()` failed, which is different from
what the shell script version did:

	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bisect_nex=
t || :

(note the trailing `|| :`, which will always return success).

I think this is a bug fix, though, so the change is good. But it probably
deserves to be called out in the commit message.

> +}
> +
>  static int bisect_start(struct bisect_terms *terms, const char **argv, =
int argc)
>  {
>  	int no_checkout =3D 0;
> @@ -699,7 +855,9 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  		BISECT_NEXT_CHECK,
>  		BISECT_TERMS,
>  		BISECT_START,
> -		BISECT_AUTOSTART,
> +		BISECT_NEXT,
> +		BISECT_AUTO_NEXT,
> +		BISECT_AUTOSTART

I am curious: what is the reason not to use a trailing comma, and what is
the reason to force AUTOSTART to stay at the end (instead of appending the
new modes, which strikes me as more natural)?

>  	} cmdmode =3D 0;
>  	int res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -723,6 +881,10 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
>  			 N_("print out the bisect terms"), BISECT_TERMS),
>  		OPT_CMDMODE(0, "bisect-start", &cmdmode,
>  			 N_("start the bisect session"), BISECT_START),
> +		OPT_CMDMODE(0, "bisect-next", &cmdmode,
> +			 N_("find the next bisection commit"), BISECT_NEXT),
> +		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
> +			 N_("verify the next bisection state then checkout the next bisectio=
n commit"), BISECT_AUTO_NEXT),
>  		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
>  			 N_("start the bisection if it has not yet been started"), BISECT_AU=
TOSTART),
>  		OPT_BOOL(0, "no-log", &nolog,
> @@ -784,6 +946,18 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
>  		set_terms(&terms, "bad", "good");
>  		res =3D bisect_start(&terms, argv, argc);
>  		break;
> +	case BISECT_NEXT:
> +		if (argc)
> +			return error(_("--bisect-next requires 0 arguments"));
> +		get_terms(&terms);
> +		res =3D bisect_next(&terms, prefix);
> +		break;
> +	case BISECT_AUTO_NEXT:
> +		if (argc)
> +			return error(_("--bisect-auto-next requires 0 arguments"));
> +		get_terms(&terms);
> +		res =3D bisect_auto_next(&terms, prefix);
> +		break;
>  	case BISECT_AUTOSTART:
>  		if (argc)
>  			return error(_("--bisect-autostart does not accept arguments"));
> @@ -799,7 +973,7 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  	 * Handle early success
>  	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_n=
ext_all
>  	 */
> -	if (res =3D=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE)
> +	if ((res =3D=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE) || (res =3D=3D BIS=
ECT_INTERNAL_SUCCESS_1ST_BAD_FOUND))
>  		res =3D BISECT_OK;
>
>  	return -res;
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 9ca583d964..59424f5b37 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -65,8 +65,7 @@ bisect_start() {
>  	#
>  	# Check if we can proceed to the next bisect state.
>  	#
> -	get_terms
> -	bisect_auto_next
> +	git bisect--helper --bisect-auto-next || exit
>
>  	trap '-' 0
>  }
> @@ -119,45 +118,7 @@ bisect_state() {
>  	*)
>  		usage ;;
>  	esac
> -	bisect_auto_next
> -}
> -
> -bisect_auto_next() {
> -	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bisect_=
next || :
> -}
> -
> -bisect_next() {
> -	case "$#" in 0) ;; *) usage ;; esac
> -	git bisect--helper --bisect-autostart
> -	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD=
|| exit
> -
> -	# Perform all bisection computation, display and checkout
> -	git bisect--helper --next-all
> -	res=3D$?
> -
> -	# Check if we should exit because bisection is finished
> -	if test $res -eq 10
> -	then
> -		bad_rev=3D$(git show-ref --hash --verify refs/bisect/$TERM_BAD)
> -		bad_commit=3D$(git show-branch $bad_rev)
> -		echo "# first $TERM_BAD commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"
> -		exit 0
> -	elif test $res -eq 2
> -	then
> -		echo "# only skipped commits left to test" >>"$GIT_DIR/BISECT_LOG"
> -		good_revs=3D$(git for-each-ref --format=3D"%(objectname)" "refs/bisec=
t/$TERM_GOOD-*")
> -		for skipped in $(git rev-list refs/bisect/$TERM_BAD --not $good_revs)
> -		do
> -			skipped_commit=3D$(git show-branch $skipped)
> -			echo "# possible first $TERM_BAD commit: $skipped_commit" >>"$GIT_DI=
R/BISECT_LOG"
> -		done
> -		exit $res
> -	fi
> -
> -	# Check for an error in the bisection process
> -	test $res -ne 0 && exit $res
> -
> -	return 0
> +	git bisect--helper --bisect-auto-next
>  }
>
>  bisect_visualize() {
> @@ -213,7 +174,7 @@ bisect_replay () {
>  		esac
>  	done <"$file"
>  	IFS=3D"$oIFS"
> -	bisect_auto_next
> +	git bisect--helper --bisect-auto-next

We probably need to append `|| exit` here.

Thank you,
Johannes

>  }
>
>  bisect_run () {
> @@ -310,7 +271,7 @@ case "$#" in
>  		bisect_skip "$@" ;;
>  	next)
>  		# Not sure we want "next" at the UI level anymore.
> -		bisect_next "$@" ;;
> +		git bisect--helper --bisect-next "$@" || exit ;;
>  	visualize|view)
>  		bisect_visualize "$@" ;;
>  	reset)
> --
> 2.25.0
>
>
