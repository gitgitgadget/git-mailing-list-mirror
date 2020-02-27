Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E2DC3F2C6
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 23:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F03D246A4
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 23:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fgS5O4Xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgB0XMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:12:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:55393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbgB0XMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 18:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582845131;
        bh=n2d8yUgl6MzilYYNoCKz6kn1fQdlQeRvj6nXpLYS4iE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fgS5O4XrEpS7Hsc+xEV4cWvQi/FZS2PZ8EVyF5l20HXCES7vbzpiM6EWjp3BpqRRy
         vYo6iel9/VPVm4iNyaUtXQNsaeWOjGAPSvGPoxPe6M/dv0DU6IXgt2Iyg6j8FLCLm8
         eTjyh46GZXCpTAJz9eDICqf0rDRMbooW//2fSXNA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1jdmPO2AUv-00fCMO; Fri, 28
 Feb 2020 00:12:11 +0100
Date:   Fri, 28 Feb 2020 00:12:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH 07/10] bisect--helper: reimplement `bisect_state` &
 `bisect_head` shell functions in C
In-Reply-To: <20200226101429.81327-8-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002272244150.9783@tvgsbejvaqbjf.bet>
References: <20200226101429.81327-1-mirucam@gmail.com> <20200226101429.81327-8-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BIdM68PY4fTomywuHbyeM90U865gzzn3Xo5l/zymEBV7BxuZ19w
 2sSj+ej2riScPgQEHjek1T99X35oMAo/va8HI78Oj7lb4zDC8qiNG8nheeOqo3ouRLfcU09
 SMhDx0wiyRoRg8N9Ynt+xhLVBjtSTUfj4MzYEUZm0T7J38L/ZDXQi4jFn7+1PVesYXOYrM2
 cbZw4EvNyOGpwGk4Y6l5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oclHz+C+2Ww=:jpThrXLRnZD8ZY9lxMpAF4
 30q9qw6K4eoYSiYynmZdwIY0gSw9ZrhMqdCMjyvZmVTbf8duBusTYWDCy8EPNZ/D6kr6vZSgl
 Y9ydCC3gIHlqZ4wWTCRRtbGYdvW3ADayYm8RpjbIoDCNr5ijRSJkcmIWu4b6En5af0i3LlkLZ
 HPbJQH9EYmbZ1YVfeVCOQD77M+Ml/PpCZN/N2BmvNXZ5+slO5OGVwSNoQtx8D6yv06X7iw06M
 NafnkUeDk9KlYF5QRR7M6bN8Ox7G8UKNntoXzzaxASCRvIX3GTFbWeVdDgY+aJeO/9iRTVcYV
 qhvAITPr338OcmCvox0f3Z8rWsUuxF1nb+UNsa/GrDAo5yVkgXbhfJ4dtQ6AmmKB07HNz30iw
 DePIe+UKkiubGu09YJSO+CPkYBo9YTKDzrUutFPgK+SjV+fB/EHF7vrokJgcqMdnTQHznxRSV
 GNR+gUsER/neN00vnwzQwb9m4joN2kF+pFZ2Dsv9NDhS3soHzbIO64u+Lwc8ER4gq9Lmmqm8i
 RNBLpylG3gl1o9mvxA/JTHlmc98hbpbai6YlY3/S25QPE3bkGRmfU+1uvBx1vz5sDz4/vfAV/
 tvzY3bUoqQ2503vK99Ee2TX1w1ytfmYX3aEbhGNuL20H7CcnLIjRplQd7CjlIDJVQ991hNDlk
 u8B/7m5oxGVxb6iVTypWbqRPeDvHfLvNm15Gv6oQzpcS1Drb8o5MQFoi/2xMTs5PO5GYRG5Wc
 EpmGuTc7gXiLo79kHnBkv4X4DAxpec6Rzy5Fu1W90YLwB2giNxoEyquMbfcoCZfA9ynhY3uMR
 cs6Lk5inJ3XlxjgOT1DkT4DlrFB8w+NEzZFIoN3CYTBRnbuZeYjqsz6lsZpc1TGczQa+Pal13
 L3YeZrQR3AIeth590p1BZh3erJCrvBHUKyreoxd2NIPaCQHKzRtWTRB03fL146GRWm9PneHGL
 TXb6I9IUULQR+THQnUmoo+IfPSBjIMDNyvZjo3bCahGYHv/PAGm/B+vzm+oBTnSoa/Fy1crN8
 PvzUeWN4oLXeWnY05zY1XlmFJI6vBP3kvFUjGufKccQfPPwLBHXUzRNXx6qj16jI9Mfsg0qhn
 LIVchI8gh7hIZy069A7H/b/bfJdKXG3NIloPOALbOyvngTESNPmQ7zuT+yp8+20H/S1r7v4R2
 keReMvvveABKxdx8NfPuWaUyBK6cT71+VjriyAtymocfLtHrGF7kRais0ffHB7axN7y+NL64W
 DjeWjQFSarAA4l81k
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 26 Feb 2020, Miriam Rubio wrote:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index f9b04bee23..fedcad4d9b 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -833,6 +835,74 @@ static int bisect_autostart(struct bisect_terms *te=
rms)
>  	return BISECT_OK;
>  }
>
> +static char *bisect_head(void)
> +{
> +	if (is_empty_or_missing_file(git_path_bisect_head()))
> +		return "HEAD";
> +	else
> +		return "BISECT_HEAD";

It is relatively common, and makes it easier to read at least to me, to
omit the `else` here: the conditional `return` already leaves the function
early.

> +}
> +
> +static enum bisect_error bisect_state(struct bisect_terms *terms, const=
 char **argv,
> +			int argc)
> +{
> +	const char *state =3D argv[0];
> +
> +	if (check_and_set_terms(terms, state))
> +		return BISECT_FAILED;
> +
> +	if (!argc)
> +		return error(_("Please call `--bisect-state` with at least one argume=
nt"));
> +
> +	if (argc =3D=3D 1 && one_of(state, terms->term_good,
> +	    terms->term_bad, "skip", NULL)) {
> +		const char *bisected_head =3D xstrdup(bisect_head());

Do we really want to `strdup()` it? That would leak memory, no? And I
don't think that we need this to be allocated anywhere. It's not like we
are trying to modify the characters or that we need to take custody of the
string: `bisect_head()` will return a static, immutable string.

But then, it is not very natural for C code to let `bisect_head()` return
a string. Why not return the already-parsed object ID? That would also
make that function more robust: instead of expecting `BISECT_HEAD` to be
stored in the file `BISECT_HEAD` in the `.git/` directory, you could
simply call `get_oid("BISECT_HEAD", &oid)` and if that fails, fall back to
do the same with `HEAD`. That way, you tap into the refs machinery and the
bisect code would be less dependent on implementation details.

> +		const char *hex[1];
> +		struct object_id oid;
> +
> +		if (get_oid(bisected_head, &oid))
> +			return error(_("Bad rev input: %s"), bisected_head);
> +		if (bisect_write(state, oid_to_hex(&oid), terms, 0))
> +			return BISECT_FAILED;
> +
> +		*hex =3D xstrdup(oid_to_hex(&oid));
> +		check_expected_revs(hex, 1);

Hmm. Do we expect `check_expected_revs()` to modify what is passed into
it? If not, we could probably simplify this a lot (and avoid another
memory leak) by something like this:

		const char *hex;

		[...]
		hex =3D oid_to_hex(&oid);
		check_expected_revs(&hex, 1);

However, taking a step back, I wonder whether it makes sense for
`check_expected_revs()` to accept `const char **revs` instead of `struct
object_id *oids`.

Looking at the definition of `check_expected_revs()`, I would think that
it would be better to pass object IDs in, rather than strings:

static int is_expected_rev(const char *expected_hex)
{
        struct strbuf actual_hex =3D STRBUF_INIT;
        int res =3D 0;
        if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), =
0) >=3D 40) {
                strbuf_trim(&actual_hex);
                res =3D !strcmp(actual_hex.buf, expected_hex);
        }
        strbuf_release(&actual_hex);
        return res;
}

static void check_expected_revs(const char **revs, int rev_nr)
{
        int i;

        for (i =3D 0; i < rev_nr; i++) {
                if (!is_expected_rev(revs[i])) {
                        unlink_or_warn(git_path_bisect_ancestors_ok());
                        unlink_or_warn(git_path_bisect_expected_rev());
                }
        }
}

There are a couple of observation that immediately come to my mind:

- Reading the bisect_expected_rev file for each rev, only to immediately
  release it before the next iteration, is wasteful

- We can break out of the loop immediately once `is_expected_rev()`
  returns 0 because we are then unlinking the very file that
  `is_expected_rev()` checks against.

- As I suspected above, a much cleaner interface would use `struct
  object_id **revs`.

- Keeping the code of `is_expected_rev()` separate from
  `check_expected_revs()` does not make the code more readable for me, but
  actually less readable instead.

- Why are we hard-coding the 40? At this time and age, we've _got_ to use
  `the_hash_algo->hexsz` instead.

In other words, I would do something like this instead:

static void check_expected_revs(struct object_id **revs, int rev_nr)
{
	struct object_id expected;
	struct strbuf buf =3D STRBUF_INIT;
	int i;

	if (!rev_nr)
		return;

        if (strbuf_read_file(&buf, git_path_bisect_expected_rev(), 0)
	      < the_hash_algo->hexsz ||
	    get_oid_hex(buf.buf, &expected) < 0)
		return; /* Ignore invalid file contents */

	for (i =3D 0; i < rev_nr; i++)
		if (!oideq(revs[i], &expected)) {
			... unlink ...
			return;
		}
}

However, taking _yet_ another step back, it seems a bit silly to compare
many revs (that need to be provided as 40-digit hex strings) to the
contents of a file that we expect to contain exactly one 40-digit hex
string. Surely, we do not want to take an arbitrary number of revisions,
then expect all of them to be identical to the _same_ rev, and otherwise
delete that file from where that rev came from?

We could even skip reading that file if two or more revisions were passed
to `check_expected_revs()` unless _all_ of them are identical!

So let's look at the actual caller of this thing:

bisect_state() {
        bisect_autostart
        state=3D$1
        git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_B=
AD || exit
        get_terms
        case "$#,$state" in
        0,*)
                die "Please call 'bisect_state' with at least one argument=
." ;;
        1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
                bisected_head=3D$(bisect_head)
                rev=3D$(git rev-parse --verify "$bisected_head") ||
                        die "$(eval_gettext "Bad rev input: \$bisected_hea=
d")"
                git bisect--helper --bisect-write "$state" "$rev" "$TERM_G=
OOD" "$TERM_BAD" || exit
                git bisect--helper --check-expected-revs "$rev" ;;
        2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
                shift
                hash_list=3D''
                for rev in "$@"
                do
                        sha=3D$(git rev-parse --verify "$rev^{commit}") ||
                                die "$(eval_gettext "Bad rev input: \$rev"=
)"
                        hash_list=3D"$hash_list $sha"
                done
                for rev in $hash_list
                do
                        git bisect--helper --bisect-write "$state" "$rev" =
"$TERM_GOOD" "$TERM_BAD" || exit
                done
                git bisect--helper --check-expected-revs $hash_list ;;
        *,"$TERM_BAD")
                die "$(eval_gettext "'git bisect \$TERM_BAD' can take only=
 one argument.")" ;;
        *)
                usage ;;
        esac
        bisect_auto_next
}

So there are actually two callers: the first one in the 1,* arm, the
second one in the 2,* arm. The first one is easy: it only passes a single
rev to `git bisect--helper --check-expected-revs`.

The second caller indeed can pass multiple arguments to
`check_expected_revs()`, but only if the first argument was not `bad`.

But this whole shell function is super ugly, and I do not believe that
we're served well by translating it verbatim to even super uglier C code.

I propose to instead rewrite it substantially, in the following way:

- Handle the `argc =3D=3D 0` case first thing: in this case, die, complain=
ing
  that we need at least one argument.

  (You already did that. Although `state` was already assigned to
   `argv[0]` at that stage, and I think we don't really want that, just in
   case that _one_ call chain ends up using `NULL, 0` for `argv, argc`.)

- Next, assign `state =3D argv[0]` and verify that it is one of `good`,
  `bad` or `skip`, otherwise erroring out.

- At this stage, we should do the equivalent of a `shift`: `argv++;
  argc--;`

- Now, we probably need to special-case the `bad` case and verify that
  `argc <=3D 1`, otherwise error out.

  Side note: I do _not_ understand this restriction. Why shouldn't it be
  valid to pass several revisions to `git bisect bad <revisions>...`?

- At this point, if `argc =3D=3D 0`, we should parse `bisect_head()` into =
a
  `struct object_id` and use that as `revs`, setting `argc =3D 0`.
  Otherwise, if `argc > 0`, we should populate a `struct object_array` and
  use that as `revs`.

- And finally, we should iterate over these revs and call `bisect_write()`
  with them, and in the same loop we can also take care of the expected
  rev. It does not make sense to keep those separate from one another
  (i.e. to have _two_ loops).

That would be a much more natural, and readable, flow, at least to me.

> +	}
> +
> +	if ((argc =3D=3D 2 && !strcmp(state, terms->term_bad)) ||
> +			one_of(state, terms->term_good, "skip", NULL)) {
> +		int i;
> +		struct string_list hex =3D STRING_LIST_INIT_DUP;
> +
> +		for (i =3D 1; i < argc; i++) {
> +			struct object_id oid;
> +
> +			if (get_oid(argv[i], &oid)) {

The original does `git rev-parse --verify "$rev^{commit}"` here, so I
think we really want `get_oid_commit()` here, not just `get_oid()`.

> +				string_list_clear(&hex, 0);
> +				return error(_("Bad rev input: %s"), argv[i]);
> +			}
> +			string_list_append(&hex, oid_to_hex(&oid));

Converting the parsed object ID to hex and storing _that_ as a string and
throwing away the parsed object ID looks not very much like C, but much
more like shell script. Let's not do that. Let's store the parsed data in
a proper `struct object_array`, and only resort to `oid_to_hex()` when we
_have_ to.

> +		}
> +		for (i =3D 0; i < hex.nr; i++) {
> +			const char **hex_string =3D (const char **) &hex.items[i].string;
> +			if (bisect_write(state, *hex_string, terms, 0)) {
> +				string_list_clear(&hex, 0);
> +				return BISECT_FAILED;
> +			}
> +			check_expected_revs(hex_string, 1);
> +		string_list_clear(&hex, 0);
> +		return bisect_auto_next(terms, NULL);
> +	}
> +
> +	if (!strcmp(state, terms->term_bad))
> +		return error(_("'git bisect %s' can take only one argument."),
> +		      terms->term_bad);

That is an awful late time in the function for a reviewer to read about a
condition that should be an early error.

> +
> +	return BISECT_FAILED;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> [...]
> @@ -944,6 +1017,13 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
>  		set_terms(&terms, "bad", "good");
>  		res =3D bisect_autostart(&terms);
>  		break;
> +	case BISECT_STATE:
> +		if (!argc)
> +			return error(_("--bisect-state requires at least one revision"));

Wait, we _already_ test for that here? Then we do not need the very same
check in `bisect_state()`.

I'd rather have it in `bisect_state()`.

Besides, we're in a `cmd_*()` function, so we cannot return `error()`
because that translates to `-1` and `cmd_*()` functions need to return
exit codes, i.e. numbers between 0 and 127.

> +		set_terms(&terms, "bad", "good");
> +		get_terms(&terms);
> +		res =3D bisect_state(&terms, argv, argc);
> +		break;
>  	default:
>  		return error("BUG: unknown subcommand '%d'", cmdmode);

Granted, this incorrect `return error()` in a `cmd_*()` function was there
before your patch. It is just as incorrect, though.

>  	}
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 049ffacdff..7f10187055 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> [...]
> @@ -185,8 +139,7 @@ exit code \$res from '\$command' is < 0 or >=3D 128"=
 >&2
>  			state=3D"$TERM_GOOD"
>  		fi
>
> -		# We have to use a subshell because "bisect_state" can exit.
> -		( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
> +		( git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN" )

This subshell looks pointless. Before, we wanted to be able to catch the
`die` in `bisect_state`. But since the `bisect--helper` cannot cause the
_shell script_ to exit, we can just drop the subshell here.

Phew, that was quite a lot, and the review of this patch also took two
hours. I'll have to stop here, once again, and hope that I will find time
soon to continue the review.

I left you quite a bit of work here, but I hope that all of my suggestions
are clear enough to act on. If not, please holler.

Ciao,
Dscho

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
