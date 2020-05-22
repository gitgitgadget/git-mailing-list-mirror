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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6716C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 20:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949112073B
	for <git@archiver.kernel.org>; Fri, 22 May 2020 20:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gS2wlZ6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgEVUrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 16:47:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:49457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730946AbgEVUrN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 16:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590180427;
        bh=onvfAhlz2yfaSLBEraSdgKcnaje4xQF01YeJBotg+xQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gS2wlZ6xFmAiiB1Lm1wNEhBb/34jGsYRxvvCcQCiFogAQKQtjY3NIBgX3boLFDOa6
         y+rJ4e+k1d4nWFcgrkFowgIp8GIPC0VY4QQBLp6HBxsd/c8a1WUTHX0nI4Uz1pUait
         GjBc6AAkxM4MtkBNYjNp5z+GVPnH/g/PohrM1mNM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.131]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiacR-1j9U8D3s3T-00fmUv; Fri, 22
 May 2020 22:47:07 +0200
Date:   Fri, 22 May 2020 22:47:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v3 05/12] bisect--helper: reimplement `bisect_next` and
 `bisect_auto_next` shell functions in C
In-Reply-To: <20200423070704.39872-6-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005222129130.56@tvgsbejvaqbjf.bet>
References: <20200423070704.39872-1-mirucam@gmail.com> <20200423070704.39872-6-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9fc8NOgrWMEaeNKHXN9XgLl1LD8cvxxdcsXzpPXehjrx9xpz9CM
 kFHMr8qSBUhGqc7PWOgEO/d9l0WYaNzJVFJqB32rel+AEldDJmo9xbG0ChjbXwwtsLoKhPw
 IKFR6iU2COjAmmENca9XQNONMB1nxUcHMVrhxB62mxP6g/nHSwGims0Wzzjhx296OVRJWBv
 KXoxwD+TxrDAW1ENzcASg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TUfs1JHwMVM=:EgLBmIXfFnWlYJe3cN53dr
 Ebi3sa/XEUBs5HOPF1FgrHMG2GDIxDYN1sx0YAZ48FfHOcgbTKGSDDmBVuzzU0N8P/kkkBEAo
 iss+DcWCCRMGjPz86JzjcdqJ/93oCN/GfB29jYiwrwnJsD43UXJ70EZW6CKQiRZ2Dy08uo3GB
 FWRewr3JCSgwUFhArBK2SUwdwHJ65iZ3VBSwvRwZW/GX1Y1DV0dAvF2wZxVY/Q6Ya1qAWEeOJ
 MC9zsFuBEhJTXFR7axKfUVFfW/aj3MXZHOhsuNuWqPuhtsduhuF6dzpvktDTEO9MPD12cslIM
 iTx8+5WaiTcf78YhyeKzoForUvdRbVE1CZBP+SIpXCYegMfccc3xMB+yA6u+YWE8H6YYnSnjT
 JBE86zLVU+whnQOk8RLSHBrI6wrWOcZvjVMt4s/YpLq0we4WKiSjj7d+qQElQI6SkE9IdNgjn
 hY0laxDv0WoZZ8AOaSvBNYYytWMJYI8ADN9krDWRTOoBnw4JiqeGgrbk/0LIMfLq7AHj/EmkP
 DF7MwRiGWq2/DxITB6i7y5Odb3Gq0GkGCFW1CpBw/QMuX5wfglR9a9DiEMjJbRAhN8TpLcVE5
 ov2iQ0qA8lhyMsYVpDZFfGhoLo1oZKQu27/6CC7CNqZ+zNrAw1Sgskbirk7bOhyvWM4scUu4r
 83wRXrNP8poFnbbpca5q5bZRHTWYgRdRti4FCXJW3+we4EYhQRkRLHmUVN1LBZl0sJNiTtb6/
 mtuALip1vKi5RvlvkJul5w8z0OPYuXdmr00DeVb+OQfHDzSH1JFX7HZNHKFTMl0csGsoESptW
 /fIwt/joyyfsw0dzhXYYglr9E3xhCshhhRB/SsfzxKfBnmI8wN2nqSOAaoEWgS42wDmDviMvt
 YJXvnGjs1SZzQCRF0kNyzuSCl/vz/9h+V6QpOvlITMB9i6uCpXm9qV6u6O7aJZXi2fBWIp69i
 0E6AnXLisjgppBni4wT/txj5te4ZFrK7Cndirlh03iBI9jZhbd1fJmABtUCupXhHxZO8EhqP9
 YeyK3QG51UWbG2Pz/TUeWqSJ+HesbFCS90/Dbb0FYvaomwbQbfQKSoPwxV3KB2lp3j3K0cQql
 VXZP1Q+hNYTlhZcjsi0BrWN1kCglyPHgpphLUT4yesBbsAtmenJED5/1bZkNBHm5PzdDWOR6v
 s9XkVtNts/tJ8lj2e+jLaGL4v/HgwWQPy1m+i9S9CFIe+pSEF3ncNN7DqGlx4XPvWamVnw6qm
 /egp5zKPxblUuDp1u
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Thu, 23 Apr 2020, Miriam Rubio wrote:

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
>  bisect.c                 |   8 ++
>  builtin/bisect--helper.c | 169 ++++++++++++++++++++++++++++++++++++++-
>  git-bisect.sh            |  47 +----------
>  3 files changed, 179 insertions(+), 45 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 9154f810f7..31cab3f0b0 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -980,6 +980,12 @@ void read_bisect_terms(const char **read_bad, const=
 char **read_good)
>   * the bisection process finished successfully.
>   * In this case the calling function or command should not turn a
>   * BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND return code into an error or a=
 non zero exit code.
> + *
> + * Checking BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND
> + * in bisect_helper::bisect_next() and only transforming it to 0 at
> + * the end of bisect_helper::cmd_bisect__helper() helps bypassing
> + * all the code related to finding a commit to test.

Nice!

> + *
>   * If no_checkout is non-zero, the bisection process does not
>   * checkout the trial commit but instead simply updates BISECT_HEAD.
>   */
> @@ -1064,6 +1070,8 @@ enum bisect_error bisect_next_all(struct repositor=
y *r, const char *prefix, int
>  		  "Bisecting: %d revisions left to test after this %s\n",
>  		  nr), nr, steps_msg);
>  	free(steps_msg);
> +	/* Clean up objects used, as they will be reused. */
> +	clear_commit_marks_all(ALL_REV_FLAGS);

That strikes me as a change that is orthogonal to the purpose claimed by
the commit message. As such, I think it wants to live in its own commit.

>
>  	return bisect_checkout(bisect_rev, no_checkout);
>  }
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 9df69800e3..c6aaa8eb15 100644
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
> @@ -29,6 +30,8 @@ static const char * const git_bisect_helper_usage[] =
=3D {
>  	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --te=
rm-bad | --term-new]"),
>  	N_("git bisect--helper --bisect-start [--term-{old,good}=3D<term> --te=
rm-{new,bad}=3D<term>]"
>  					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
> +	N_("git bisect--helper --bisect-next"),
> +	N_("git bisect--helper --bisect-auto-next"),
>  	N_("git bisect--helper --bisect-autostart"),
>  	NULL
>  };
> @@ -441,6 +444,150 @@ static int bisect_append_log_quoted(const char **a=
rgv)
>  	return res;
>  }
>
> +static int register_good_ref(const char *refname,
> +			     const struct object_id *oid, int flags,
> +			     void *cb_data)
> +{
> +	struct argv_array *rev_argv =3D cb_data;
> +
> +	argv_array_push(rev_argv, oid_to_hex(oid));
> +	return 0;
> +}
> +
> +static void prepare_rev_argv(struct bisect_terms *terms, struct argv_ar=
ray *rev_argv)
> +{
> +	char *term_good =3D xstrfmt("%s-*", terms->term_good);

This could be `xstrfmt("refs/bisect/%s-*", terms->term_good)` instead, and
that would have avoided some head-scratching on my side. The
"refs/bisect/" prefix passed to `for_each_glob_ref_in()` makes this
correct, of course.

> +
> +	argv_array_pushl(rev_argv, "skipped_commits", "refs/bisect/bad", "--no=
t", NULL);

This hard-codes `bad` where the shell script version uses
`refs/bisect/$TERM_BAD`.

> +	for_each_glob_ref_in(register_good_ref, term_good, "refs/bisect/", rev=
_argv);
> +
> +	free(term_good);
> +}
> +
> +static int prepare_revs(struct bisect_terms *terms, struct rev_info *re=
vs)
> +{
> +	int res =3D 0;
> +	struct argv_array rev_argv =3D ARGV_ARRAY_INIT;
> +
> +	prepare_rev_argv(terms, &rev_argv);
> +
> +	/*
> +	 * It is important to reset the flags used by revision walks
> +	 * as the previous call to bisect_next_all() in turn
> +	 * sets up a revision walk.
> +	 */
> +	reset_revision_walk();
> +	init_revisions(revs, NULL);
> +	rev_argv.argc =3D setup_revisions(rev_argv.argc, rev_argv.argv, revs, =
NULL);

I have not heard any valid argument against my suggestion in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301619340.46@tvgsbejvaqb=
jf.bet/
to render into the pending objects directly. Yes, there was a hand-waving
"but the shell script version does not do that" but that's just not a
valid argument because if the shell script version could, it would, but it
cannot: it's shell script, for crying out loud. It has no way to use the
appropriate data structures. C code does. And should. We're not in the
business of converting OIDs into strings that are appended to string lists
so that they can be re-parsed into OIDs.

Therefore, I would suggest (and now that almost four months have passed
since my initial suggestion, rather strongly) to do something like this:

	struct add_bisect_ref_data {
		struct rev_info *revs;
		int object_flags;
	};

	static int add_bisect_ref(const char *refname, const struct object_id *oi=
d,
				  int flags, void *cb)
	{
		struct add_bisect_ref_data *data =3D cb;

		add_pending_oid(data->revs, refname, oid, data->object_flags);

		return 0;
	}

	[...]
		struct add_bisect_ref_data cb =3D { &revs };
		char *good =3D xstrfmt("%s-*", terms->term_good);

		[...]
		setup_revisions(0, NULL, revs, NULL);
		for_each_glob_ref_in(add_bisect_ref, terms->term_bad, "refs/bisect/", &c=
b);
		cb.object_flags =3D UNINTERESTING;
		for_each_glob_ref_in(add_bisect_ref, good, "refs/bisect/", &cb);

This would remove one (unnecessary) level of indirection, and converting
OIDs from/to/from strings.

> +	if (prepare_revision_walk(revs))
> +		res =3D error(_("revision walk setup failed\n"));
> +
> +	argv_array_clear(&rev_argv);
> +	return res;
> +}
> +
> +static int process_skipped_commits(FILE *fp, struct bisect_terms *terms=
, struct rev_info *revs)
> +{
> +	struct commit *commit;
> +	struct pretty_print_context pp =3D {0};
> +
> +	if (fprintf(fp, "# only skipped commits left to test\n") < 0)
> +		return error_errno(_("failed to write to '%s'"), git_path_bisect_log(=
));
> +
> +	while ((commit =3D get_revision(revs)) !=3D NULL) {
> +		struct strbuf commit_name =3D STRBUF_INIT;

I missed this in my review end of January: it is an anti-pattern to create
a new `strbuf` and releasing it right away in the same loop iteration.
Let's instead move the declaration of `commit_name` to the top of the
function, then call `strbuf_reset()` at the beginning of the loop, and
finally call `strbuf_release()` only _once_, at the end of the function.

> +		format_commit_message(commit, "%s",
> +				      &commit_name, &pp);
> +		fprintf(fp, "# possible first %s commit: [%s] %s\n",
> +			terms->term_bad, oid_to_hex(&commit->object.oid),
> +			commit_name.buf);
> +		strbuf_release(&commit_name);
> +	}
> +
> +	/*
> +	 * Reset the flags used by revision walks in case
> +	 * there is another revision walk after this one.
> +	 */
> +	reset_revision_walk();
> +
> +	return 0;
> +}
> +
> +static int bisect_skipped_commits(struct bisect_terms *terms)
> +{
> +	int res =3D 0;
> +	FILE *fp =3D NULL;
> +	struct rev_info revs;
> +
> +	fp =3D fopen(git_path_bisect_log(), "a");
> +	if (!fp)
> +		return error_errno(_("could not open '%s' for appending"),
> +				  git_path_bisect_log());
> +
> +	res =3D prepare_revs(terms, &revs);
> +
> +	if (!res)
> +		res =3D process_skipped_commits(fp, terms, &revs);
> +
> +	fclose(fp);
> +	return res;

It would make the code easier to follow if `prepare_revs()` was called
before opening the file and returning early in case of an error.

Further, I do not see the point of having the code in
`process_skipped_commits()` there is only this caller, in a tiny function.
It would be better to fold the code into a single function.

I did point that out already in my review at the end of this past January.

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
> +	printf("%s\n", bad_ref);

I missed this in January: is this a left-over debug printf? I cannot find
the equivalent in the shell script version.

> +	commit =3D lookup_commit_reference(the_repository, &oid);

There is a relatively recent convention to initialize a local variable
`struct repository *r =3D the_repository;` at the beginning of the functio=
n
and then using `r` throughout the function. I think I'd like to use that
here, too, even if it is only used once.

Any reason not to use `lookup_commit_reference_by_name(r, bad_ref)`
directly instead? You can still reference `commit->object.oid` instead of
`oid` later on.

> +	format_commit_message(commit, "%s", &commit_name, &pp);
> +
> +	res =3D write_in_file(git_path_bisect_log(), "a", "# first %s commit: =
[%s] %s\n",
> +			    terms->term_bad, oid_to_hex(&oid),
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
> +	int no_checkout;
> +	enum bisect_error res;
> +
> +	bisect_autostart(terms);
> +	if (bisect_next_check(terms, terms->term_good))
> +		return BISECT_FAILED;
> +
> +	no_checkout =3D file_exists(git_path_bisect_head());
> +
> +	/* Perform all bisection computation, display and checkout */
> +	res =3D bisect_next_all(the_repository, prefix, no_checkout);
> +
> +	if (res =3D=3D BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> +		res =3D bisect_successful(terms);
> +		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
> +	} else if (res =3D=3D BISECT_ONLY_SKIPPED_LEFT) {
> +		res =3D bisect_skipped_commits(terms);
> +		return res ? res : BISECT_ONLY_SKIPPED_LEFT;
> +	}

This looks much, much nicer than the equivalent code I reviewed almost
four months ago.

Personally, I would have used the idiom

		if (!res)
			return BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;

but I can live with the current version.

> +	return res;
> +}
> +
> +static enum bisect_error bisect_auto_next(struct bisect_terms *terms, c=
onst char *prefix)
> +{
> +	if (bisect_next_check(terms, NULL))
> +		return BISECT_OK;

This is a straight-forward translation from the shell code.

I would like to take a step back, though: the only two differences between=
 the
`bisect_next_check()` call here and the one in `bisect_next()` are:

- the return value if `bisect_next_check()` failed: the "auto" version
  seems to report success, the non-"auto" version failure

- the "auto" version seems not to accept missing "good" commits

Seeing this, it does strike me odd that `bisect_next()` is called from
`bisect_auto_next()`, and I would have rather expected an `int auto`
parameter to the `bisect_next()` function, where the `bisect_autostart()`
call is skipped in case `auto !=3D 0`.

The rest of the patch looks fine to me.

Ciao,
Dscho

> +
> +	return bisect_next(terms, prefix);
> +}
> +
>  static int bisect_start(struct bisect_terms *terms, int no_checkout,
>  			const char **argv, int argc)
>  {
> @@ -672,7 +819,9 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  		BISECT_NEXT_CHECK,
>  		BISECT_TERMS,
>  		BISECT_START,
> -		BISECT_AUTOSTART,
> +		BISECT_NEXT,
> +		BISECT_AUTO_NEXT,
> +		BISECT_AUTOSTART
>  	} cmdmode =3D 0;
>  	int no_checkout =3D 0, res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -696,6 +845,10 @@ int cmd_bisect__helper(int argc, const char **argv,=
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
>  			 N_("start the bisection if BISECT_START is empty or missing"), BISE=
CT_AUTOSTART),
>  		OPT_BOOL(0, "no-checkout", &no_checkout,
> @@ -759,6 +912,18 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
>  		set_terms(&terms, "bad", "good");
>  		res =3D bisect_start(&terms, no_checkout, argv, argc);
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
>  			return error(_("--bisect-autostart requires 0 arguments"));
> @@ -774,7 +939,7 @@ int cmd_bisect__helper(int argc, const char **argv, =
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
> index 426d443e7e..897825b675 100755
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
> -	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo=
 --no-checkout)
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
> @@ -211,7 +172,7 @@ bisect_replay () {
>  			die "$(gettext "?? what are you talking about?")" ;;
>  		esac
>  	done <"$file"
> -	bisect_auto_next
> +	git bisect--helper --bisect-auto-next
>  }
>
>  bisect_run () {
> @@ -308,7 +269,7 @@ case "$#" in
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
