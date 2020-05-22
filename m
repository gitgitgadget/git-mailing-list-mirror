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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12990C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 21:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26512078D
	for <git@archiver.kernel.org>; Fri, 22 May 2020 21:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Iv145NKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgEVVIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 17:08:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:53629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbgEVVIS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 17:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590181695;
        bh=upHvQ2DNhtlGzrpLqFf6wTOCn72J4fQPbw1GCtB3TFA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Iv145NKkon9GikYvkNi4iFdoSJ4nXDeg78Znl5rM0iM/c63KkZUuOPayr4ytJIV9J
         SVIl7XU6M00B8erJEUpNXXLX7QNUrIFVisIx3KhpK0+e42FvzdepU9Lqilpypl2NPF
         XznZDmgaYOTLsGD4lixcMGeIDi89auri6ZxTml4I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.131]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1jQBgp09HI-00N8qD; Fri, 22
 May 2020 23:08:15 +0200
Date:   Fri, 22 May 2020 23:08:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v3 06/12] bisect--helper: finish porting `bisect_start()`
 to C
In-Reply-To: <20200423070704.39872-7-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005222256130.56@tvgsbejvaqbjf.bet>
References: <20200423070704.39872-1-mirucam@gmail.com> <20200423070704.39872-7-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Vn//0LkScVwn+yHsxeXx5Hu4OQsQl0m5t2LpSyE9TwJ1DLVKE6r
 qPJIIzWyZSS9Myvz+bEIbVO32nTRLfGXpFk+7IteRZSg/RN6WVDbZA2pzjSz5ebgIdopi/7
 VILrjTb4Nu5VPUZqF+CN9BJKds4G3Ks4qioxCvtQJEzcsRjk+DmQ3+cvi6HoZWOGBe4hEPS
 bhVbhWKqFF7BtkXne+wYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B1HoLQKWnCI=:5EmInNAr7w+aObUB5RBx/t
 vqxn4smSBPfMD1h+jsdAQBhHEQibfQuVWMX9D5Wv4EUfHxz64GdBcNNEFPXoHMMkdMFpgs5Ah
 yoy05CAmih50Y8jA5yCSmGeiJmu6JLHVmb53WXgbVjBwVk/efVxQNf9Sf7mSx1ojeFlJMD+iD
 sf9VFpO5IM+JYyGl5NMDlXceEHwplmfjaZMrqnQDWQSMXjmiYEkXmi/QwfUtS99SHSBeNHZ1e
 xg68XCruEe/3o7DD03oVz2QrmigGjl9EeglKVmMUD9mS0ysCGXzg0tuBw3vGdeZhFE7ctPrwn
 fo02cubZQq/YcH7/v3uXfpvfmtWtR8bcHXoVLpXAb6Id/v22A1kdLIfOR351yhfv146JHPjCi
 zkRi06oTY9eJlmqM+mL1IAhaStuBP+BCnlXu22uZ9hIAsqAz0XJWOkLe1GZWPLpiL6JqHoc5A
 GwTJIsq6g3J/7/gzCPUb1VE/ee4ynWlOvQx9E723QCjFQ12lxt3qkuHGAGBX+mWt+lPohJt8o
 997gZEzAqt7zsZOPu9WFPWluHKI2zHWuTYr6IAAOI4yjCjPLHufGhSV+UeV0ym9THENwMWDMs
 g/kuyd5pUVdY5dEi6yOu5pHQJTk7OOZbX5bOTnzJeXcaDOB3xJW+z5aB3HE8UHCEsXgpe0mSJ
 T6rTYj2DV7zQ2Kn0RiewBGINqIkBv2q5eoVOWSNAS6PqalRAl1D/Dg/Kpvq1H21/Zc0uTQK3f
 VuFK/ZPY4zgCA8cBxIxKLwg47bJ54reAKDxzyoONOTHKHeVTx/rXPGLq+JLpPvPwP1Y8q9vUP
 Qb4WTsZybSlaAyw3YMa6kFyb9lp/FV5dgo2lDclwi/QVFWhkEzkFBaA0BSO2IdHIAZM18Iqzs
 rAzWbnLYIayvvnsEkf8Hi9LiNFkXt3LhFr8pwonjxfBqRWUm4Cx51nybvGuQMru6OM0aaCN1M
 7SEwpkgfN1QURb2e1A5gUCGKs+KJ4s6juOutRtmLduZPJFNRJJUUMEFgTntmkGc6qAa4XPxia
 IIZVF0Hpz0ZH6Ac+LX46OcmNBQqMyrghI2f2NnX41oPrBLU6seCCbF6dWEZfhCYZoryNkpf3m
 TwsUtW3PXszyjAXA5zbynSFWGnLXeQVfacGs5qrXJz59dPN4XDYpGeXNd3MySUHDWH8Vt2aSx
 myMXGuNG/B1PWSipSDC7bZ35J+EUVOjUAPLTZmbzJ61VrOJpeseCRYseXHC6nb+Ub/ZZyHX+w
 x3QwEyXEeIiq4Xs4l
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Thu, 23 Apr 2020, Miriam Rubio wrote:

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
> This removes the signal handling we had in `bisect_start()` as we
> don't really need it. While at it, "trap" is changed to "handle".

I do not see any "handle" in the diff...

> As "trap" is a reference to the shell "trap" builtin, which isn't
> used anymore.

Otherwise, the commit message looks good to me!

>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 54 +++++++++++++++++++++++++++++++---------
>  git-bisect.sh            | 26 ++-----------------
>  2 files changed, 44 insertions(+), 36 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index c6aaa8eb15..f2ec7f89e4 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -588,11 +588,12 @@ static enum bisect_error bisect_auto_next(struct b=
isect_terms *terms, const char
>  	return bisect_next(terms, prefix);
>  }
>
> -static int bisect_start(struct bisect_terms *terms, int no_checkout,
> +static enum bisect_error bisect_start(struct bisect_terms *terms, int n=
o_checkout,
>  			const char **argv, int argc)
>  {
>  	int i, has_double_dash =3D 0, must_write_terms =3D 0, bad_seen =3D 0;
> -	int flags, pathspec_pos, res =3D 0;
> +	int flags, pathspec_pos;
> +	enum bisect_error res =3D BISECT_OK;
>  	struct string_list revs =3D STRING_LIST_INIT_DUP;
>  	struct string_list states =3D STRING_LIST_INIT_DUP;
>  	struct strbuf start_head =3D STRBUF_INIT;
> @@ -645,9 +646,12 @@ static int bisect_start(struct bisect_terms *terms,=
 int no_checkout,
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

Makes sense.

>
>  			string_list_append(&revs, oid_to_hex(&oid));
>  			free(commit_id);
> @@ -725,12 +729,12 @@ static int bisect_start(struct bisect_terms *terms=
, int no_checkout,
>  	 * Get rid of any old bisect state.
>  	 */
>  	if (bisect_clean_state())
> -		return -1;
> +		return BISECT_FAILED;
>
>  	/*
> -	 * In case of mistaken revs or checkout error, or signals received,
> +	 * In case of mistaken revs or checkout error,
>  	 * "bisect_auto_next" below may exit or misbehave.
> -	 * We have to trap this to be able to clean up using
> +	 * We have to handle this to be able to clean up using
>  	 * "bisect_clean_state".
>  	 */
>
> @@ -746,7 +750,7 @@ static int bisect_start(struct bisect_terms *terms, =
int no_checkout,
>  		}
>  		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
>  			       UPDATE_REFS_MSG_ON_ERR)) {
> -			res =3D -1;
> +			res =3D BISECT_FAILED;
>  			goto finish;
>  		}
>  	}
> @@ -758,25 +762,51 @@ static int bisect_start(struct bisect_terms *terms=
, int no_checkout,
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
> +	 * In case of mistaken revs or checkout error, or signals received,
> +	 * "bisect_auto_next" below may exit or misbehave.

This "below" was true in the shell script version, but now it should be
"above".

> +	 * We have to handle this to be able to clean up using
> +	 * "bisect_clean_state".
> +	 * return code BISECT_INTERNAL_SUCCESS_MERGE_BASE is special code
> +	 * that indicates special success.

Maybe we should have a helper function and use it here:

	static int is_bisect_success(enum bisect_error res)
	{
		return !res ||
			res =3D=3D BISECT_INTERNAL_1ST_BAD_FOUND ||
			res =3D=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE;
	}

(Note that I added the `_1ST_BAD_FOUND` case here.)

> +	 *	-> bisect_start()
> +	 *	   . res =3D bisect_auto_next()
> +	 *	    -> bisect_auto_next()
> +	 *	       . return bisect_next()
> +	 *	       -> bisect_next()
> +	 *		  . res =3D bisect_next_all()
> +	 *		  -> bisect_next_all()
> +	 *		     . res =3D check_good_are_ancestors_of_bad()
> +	 *		     -> check_good_are_ancestors_of_bad()
> +	 *			. res =3D check_merge_bases()
> +	 *			-> check_merge_bases()
> +	 *			   . res =3D BISECT_INTERNAL_SUCCESS_MERGE_BASE

While this might be an interesting tidbit for the commit message, I do not
think that it is a good idea to keep this as a code comment; It is prone
to become stale/incorrect over time.

> +	 */
> +	if (res && res !=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE)
> +		bisect_clean_state();
>  	return res;
>  }
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 897825b675..049ffacdff 100755
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
> @@ -162,8 +141,7 @@ bisect_replay () {
>  		get_terms
>  		case "$command" in
>  		start)
> -			cmd=3D"bisect_start $rev"
> -			eval "$cmd" ;;
> +			eval "git bisect--helper --bisect-start $rev" ;;

The original code _had_ to use `eval` because `bisect_start` could cause
the code to `exit` and we did _not_ want to let that exit the `replay`
process.

However, we are calling `git bisect--helper` here, which runs in its own
process anyway, so the `eval` should be dropped now.

Otherwise, the patch looks fine to me,
Dscho

>  		"$TERM_GOOD"|"$TERM_BAD"|skip)
>  			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$T=
ERM_BAD" || exit;;
>  		terms)
> @@ -262,7 +240,7 @@ case "$#" in
>  	help)
>  		git bisect -h ;;
>  	start)
> -		bisect_start "$@" ;;
> +		git bisect--helper --bisect-start "$@" ;;
>  	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
>  		bisect_state "$cmd" "$@" ;;
>  	skip)
> --
> 2.25.0
>
>
