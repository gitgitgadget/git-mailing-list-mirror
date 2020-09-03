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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEB2C433E9
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 18:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC052078E
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 18:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CDOoq+jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgICSVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:21:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:53987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgICSVT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 14:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599157275;
        bh=IQHyulR9iDDQGq0QaTCfTnR0ed/vLHqxJ3no4/cWBrA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CDOoq+jDpabQaA2FJkEHubD/LyrrpyJxMVaHt2Mibk62k4UXQBWv+2qw1M2fhWwUJ
         KkCZKVAOh8gMGompNDQRJEEOBZxf2eJqSW4lDDslOFx3M0MaWhmbYlVMRBRVGzT4Gh
         ygHdEmjtGK0RXNS4SGhg/c+LlnpdSCNOBhDiFD80=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([213.196.212.246]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1kEB6e1LiF-000rbv; Thu, 03
 Sep 2020 20:21:15 +0200
Date:   Thu, 3 Sep 2020 11:56:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v7 07/13] bisect--helper: finish porting `bisect_start()`
 to C
In-Reply-To: <20200831105043.97665-8-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009031151500.56@tvgsbejvaqbjf.bet>
References: <20200831105043.97665-1-mirucam@gmail.com> <20200831105043.97665-8-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FxZtqVHriD7tp1qbmJWDdP7VnkT6LaO2c9TxDa15PG2RVQnICl0
 skNEdYWxjoEvF6D+++w7336omXGJGbf85UewivlqA6WD+czH5qUGApzfmMk8gPxXZs8Gx+p
 FmKSPH+/Oc9Z3aRlOleKLPYUSsXp8KcAto7c1xmUYqzZrSXtaERnSg4nx1OBbTk5FBkVGlv
 E6BQVbq4J62K15yhpyZkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D4cQGC25UNw=:5+YPrDvuVWh5HugZUEIOJR
 oAJg6iTEJauJhQgLnv9ISxacvBHU9JzCijLZnuV2e9zSpg7cYc8PncKOEHdwdlIqLKHKDdD7o
 gS7U4ARHaYYDL0+CfMLcJ7o0mV1mlE3dubQwIjwjPK65YUDhq2M0ivqUwyd4olq+6JC+9q8Oy
 9OaYYS266yJXNMTot949EgNR9l3hoiLrSpqTKXAEUyP+YZdcyIQCVPEjGp3Q/fmYyNglY4rGj
 SKJxORJuwbGz71aWborpZxKAtuP1LGVp/MipEVcxCK0PFdqwzCH/JH2gyHiTzrK3hnuKQ7e4q
 ZtdOLDg0ZwkoSNRnvN1AEFFJApDbD+xXjzFxFWRMO/Aii9RzyjOzWqLrvm7fTkpwzspBGfUp+
 BAyuDxw2tJ00P5K9BWhtBqczIkvQdBc8g0KnP5UzhLj9nAEHm0lD9NTOCJbtLSvR/Vfi9ToCM
 Tugca+QDeVTMMQLaYhT1ZdsXqdHwfjg+sefiBrKkPNi1CTHO8/EXRz70DnrvCIvvoHlf6QPNH
 33QYlg1tAiOkLKIYwu77vqwyKfo0sATLghRMqGvIfU+q8jqLNcHhPLHvro7FqDd5qSP7N96rb
 fQjy/ZLlapBl9AfiGrcX1nBKz7QkxZYkQDtg5lpuKN3376kW9jJitOfsV9i0Z931Zsed94573
 rk6v8FWx8nGS8KI8nOlK/wR6btudAnq8LqpMaFS+cEArrFYaTGlqBAfdJq1PGotLeZdY1mWqy
 QPUqnqTPH+W8rWAuWPNC0WT86hxs17x/DauiB/PPCvXHZXMOlh47wMLxWNIT+rk6EO6VC6mik
 331bIaOA9GWtS2oAAM1sw4tXrrVGEKoHVnk5fnc3LyPDn6R2u7T7ZhUB+fGsGZFxE7u/+88iV
 sVRfzjoSenzukQYO+IGIDimbh6IGEASZY2Zum83Dd9LzZ2/q4gHQOrMhHOgMtPly95zTQ2aXQ
 FAnrzV+v42vkSXdsvoaBmKFpt582dtKHgsP9qhsLeT0bnZVzxbjLu+k6buTeCv8X3ydBPKUBI
 3Ng0DAYtL2/J13XUuTa7AUqcL9KoG6yqrGlOVyoQ8KtSLTKNhvTn5bAT1H5xuhW8hi45I/DKi
 Y3PBTnJYkfJxIMi2n6jXTFgFv6sXZUDFEAMsWij/JkTTpfKFmA5M7A+jbw6bCI0I093lD3bUq
 2Vj3MjdNd+YIdoCk/9rCwyASNw0yEWcP1QoZbG401KQipswmbiHrTT3lLRzYo+fJA/08irIo1
 Z4BgNzFzefdj7fpiLHwN2V3DGJSbiKruQy3rdAw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Mon, 31 Aug 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Add the subcommand to `git bisect--helper` and call it from
> git-bisect.sh.
>
> With the conversion of `bisect_auto_next()` from shell to C in a
> previous commit, `bisect_start()` can now be fully ported to C.
>
> So let's complete the `--bisect-start` subcommand of
> `git bisect--helper` so that it fully implements `bisect_start()`,
> and let's use this subcommand in `git-bisect.sh` instead of
> `bisect_start()`.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 56 ++++++++++++++++++++++++++++------------
>  git-bisect.sh            | 26 ++-----------------
>  2 files changed, 41 insertions(+), 41 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index e29e86142a..b40369e8aa 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -85,6 +85,19 @@ static int one_of(const char *term, ...)
>  	return res;
>  }
>
> +/*
> + * return code BISECT_INTERNAL_SUCCESS_MERGE_BASE
> + * and BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND are codes
> + * that indicate special success.
> + */
> +
> +static int is_bisect_success(enum bisect_error res)
> +{
> +	return !res ||
> +		res =3D=3D BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND ||
> +		res =3D=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE;
> +}
> +
>  static int write_in_file(const char *path, const char *mode, const char=
 *format, va_list args)
>  {
>  	FILE *fp =3D NULL;
> @@ -607,12 +620,13 @@ static enum bisect_error bisect_auto_next(struct b=
isect_terms *terms, const char
>  	return bisect_next(terms, prefix);
>  }
>
> -static int bisect_start(struct bisect_terms *terms, const char **argv, =
int argc)
> +static enum bisect_error bisect_start(struct bisect_terms *terms, const=
 char **argv, int argc)
>  {
>  	int no_checkout =3D 0;
>  	int first_parent_only =3D 0;
>  	int i, has_double_dash =3D 0, must_write_terms =3D 0, bad_seen =3D 0;
> -	int flags, pathspec_pos, res =3D 0;
> +	int flags, pathspec_pos;
> +	enum bisect_error res =3D BISECT_OK;
>  	struct string_list revs =3D STRING_LIST_INIT_DUP;
>  	struct string_list states =3D STRING_LIST_INIT_DUP;
>  	struct strbuf start_head =3D STRBUF_INIT;
> @@ -672,9 +686,12 @@ static int bisect_start(struct bisect_terms *terms,=
 const char **argv, int argc)
>  			return error(_("unrecognized option: '%s'"), arg);
>  		} else {
>  			char *commit_id =3D xstrfmt("%s^{commit}", arg);
> -			if (get_oid(commit_id, &oid) && has_double_dash)
> -				die(_("'%s' does not appear to be a valid "
> -				      "revision"), arg);
> +			if (get_oid(commit_id, &oid) && has_double_dash) {
> +				error(_("'%s' does not appear to be a valid "
> +					"revision"), arg);
> +				free(commit_id);
> +				return BISECT_FAILED;
> +			}
>
>  			string_list_append(&revs, oid_to_hex(&oid));
>  			free(commit_id);
> @@ -752,14 +769,7 @@ static int bisect_start(struct bisect_terms *terms,=
 const char **argv, int argc)
>  	 * Get rid of any old bisect state.
>  	 */
>  	if (bisect_clean_state())
> -		return -1;
> -
> -	/*
> -	 * In case of mistaken revs or checkout error, or signals received,
> -	 * "bisect_auto_next" below may exit or misbehave.
> -	 * We have to trap this to be able to clean up using
> -	 * "bisect_clean_state".
> -	 */
> +		return BISECT_FAILED;
>
>  	/*
>  	 * Write new start state
> @@ -776,7 +786,7 @@ static int bisect_start(struct bisect_terms *terms, =
const char **argv, int argc)
>  		}
>  		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
>  			       UPDATE_REFS_MSG_ON_ERR)) {
> -			res =3D -1;
> +			res =3D BISECT_FAILED;
>  			goto finish;
>  		}
>  	}
> @@ -788,25 +798,37 @@ static int bisect_start(struct bisect_terms *terms=
, const char **argv, int argc)
>  	for (i =3D 0; i < states.nr; i++)
>  		if (bisect_write(states.items[i].string,
>  				 revs.items[i].string, terms, 1)) {
> -			res =3D -1;
> +			res =3D BISECT_FAILED;
>  			goto finish;
>  		}
>
>  	if (must_write_terms && write_terms(terms->term_bad,
>  					    terms->term_good)) {
> -		res =3D -1;
> +		res =3D BISECT_FAILED;
>  		goto finish;
>  	}
>
>  	res =3D bisect_append_log_quoted(argv);
>  	if (res)
> -		res =3D -1;
> +		res =3D BISECT_FAILED;
>
>  finish:
>  	string_list_clear(&revs, 0);
>  	string_list_clear(&states, 0);
>  	strbuf_release(&start_head);
>  	strbuf_release(&bisect_names);
> +	if (res)
> +		return res;
> +
> +	res =3D bisect_auto_next(terms, NULL);
> +	/*
> +	 * In case of mistaken revs or checkout error,
> +	 * "bisect_auto_next" above may exit or misbehave.
> +	 * We have to handle this to be able to clean up using
> +	 * "bisect_clean_state".
> +	 */

Is this comment still correct in the C version? I thought we had succeeded
in removing that shell scripting wart by turning all the `exit`s into
`return`s...

> +	if (!is_bisect_success(res))
> +		bisect_clean_state();
>  	return res;
>  }
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 59424f5b37..356264caf0 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -49,27 +49,6 @@ bisect_head()
>  	fi
>  }
>
> -bisect_start() {
> -	git bisect--helper --bisect-start $@ || exit
> -
> -	#
> -	# Change state.
> -	# In case of mistaken revs or checkout error, or signals received,
> -	# "bisect_auto_next" below may exit or misbehave.
> -	# We have to trap this to be able to clean up using
> -	# "bisect_clean_state".
> -	#
> -	trap 'git bisect--helper --bisect-clean-state' 0
> -	trap 'exit 255' 1 2 3 15
> -
> -	#
> -	# Check if we can proceed to the next bisect state.
> -	#
> -	git bisect--helper --bisect-auto-next || exit
> -
> -	trap '-' 0
> -}
> -
>  bisect_skip() {
>  	all=3D''
>  	for arg in "$@"
> @@ -163,8 +142,7 @@ bisect_replay () {
>  		get_terms
>  		case "$command" in
>  		start)
> -			cmd=3D"bisect_start $rev $tail"
> -			eval "$cmd" ;;
> +			eval "git bisect--helper --bisect-start $rev $tail" ;;

I think we need to append something like `test 0 =3D $? || exit $?` here, =
as
the `eval`ed command can no longer exit.

In fact, I think that the `eval` here no longer makes sense, as the only
reason we did that before was that `bisect_start` could `exit` and we did
not want that here.

>  		"$TERM_GOOD"|"$TERM_BAD"|skip)
>  			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$T=
ERM_BAD" || exit;;
>  		terms)
> @@ -264,7 +242,7 @@ case "$#" in
>  	help)
>  		git bisect -h ;;
>  	start)
> -		bisect_start "$@" ;;
> +		git bisect--helper --bisect-start "$@" ;;

I guess we do not need to append `|| exit` here because this will be the
last command in the script to be executed anyway, therefore its exit
status will become the exit status of the script.

Thank you,
Johannes

>  	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
>  		bisect_state "$cmd" "$@" ;;
>  	skip)
> --
> 2.25.0
>
>
