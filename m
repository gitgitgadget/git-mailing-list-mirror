Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12627C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 22:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D702F217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 22:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fkA0Xvco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgATWJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:09:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:50225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgATWJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 17:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579558193;
        bh=22uax/1NS0oANNySIVvbsfOtiz12Ko89yVmB2Xr3268=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fkA0XvcoTRbHV9JpKUm7EOuH9055OJHMTCVoAoNU1cdnf74I9YyTiMWDnp+LoovsJ
         ZHRAXuzLopZc9JztSPwb1MdGoDrIpKR/FsoH4qz76Z2Ta54bcjGDMIu2HPzT7UC4iC
         nwMW/vz5W9oYNznRsrWTmhqDjvPLlcVygDXn7xmo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwfWU-1jqkH507a6-00y5wm; Mon, 20
 Jan 2020 23:09:53 +0100
Date:   Mon, 20 Jan 2020 23:09:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH 08/29] bisect: libify `check_merge_bases` and its
 dependents
In-Reply-To: <20200120143800.900-9-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001202308050.46@tvgsbejvaqbjf.bet>
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-9-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c6cYGxxrF6q1Pypyx0Ri9yaiThAqA5Azat6wc6vwS5dluJ2Y7N/
 7OLwBSOFWby1NyFTWxZzy/boFncB79oQTlDHR3dUkm1HlZx3UiQSv/VCI3gMBpMlrMbZhYz
 behTlzVmk2d99scREPFMOWMMD+TKwtk/k0ywhiI4iUd13FZCfm+tt/YDmpJWd+EAeBJGH68
 miugOWuz6sg4zi+MiCIYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XNJgi0w7c7w=:SG5IJRxNviJq8XEdIcqOBI
 LBVMoW0v3A6YbpdN0cLMgq0lCtetpX2hzBohTKO5lM0Bixt2pBJu7nvlFHyF0uLTbOakUwNcu
 wTls2z5zAYU+uMDdRXHz5WybBJVLczBkYZPzvT/yYkWgixK0tXRc9VqQsn6QByWpMoHuOOghT
 TJqOR6VlEc3oLrvuwiFvkM8m0CgteOASClpH9GdUP4DZBn9YpJoe5aN9kuyccNBeSYvBPSGG2
 2wP+jkTtmapf9uJ0GbFuH0mkgbkr8lCIgQ5+dMlh0+MVKI0vrATY2Ohdiwp80KyW6KEOdm5lM
 WqiurlFuuZiF/orN/l2W8G8uEkLg0mVFF39TbYfv8Y6mJVsb8BnvhI6TT0vLXAzFtsHhudydJ
 6Vt608k5oArXXe9VVYmIkJFg9tJ8cT0OOlene2sS7kE8P5r2pS4odYI8r6M8Gk0ffODrIR3bQ
 3tNyMZsBILVgs5p5+FGuoI1km3PkdhjFKyjxuA7qnvo7o4dus89+2+G9Y5o0aYebdsOtIwzOV
 gjo3Yh8JZKuSmw+uEDXrfwF1QY0leK6X60WTGklynUk5TDvAQ+smF1tULicvE3rhIcYVR9Z14
 6M0QcrqMtinwh+hokkE7fq2UCiq/9CFhGeaVx8GXZF+CIs0t906nl8a/L5SfQb3x2CcW9q8fC
 WZvgQNS08uo1S2uYBbOE5oM+i4fISA3BS6XIxoxMu+tWwM3hPRKj+WHPy7CqXo/wYHmhdxrUP
 0SGbhZg6UTOXvjCbEbUrlsODhUxeJktq5VqL6G5xaMRY0w1b7Hzd+HnOu5aPji7Q+L8B+yOK/
 LPKEvolTdE9SPN6BDQbpoejocqJUtoaTSmDmlL8PY4+acl4SXmJuLywSI3SXiJVv7VeSiFbh/
 TPY0lnIkJXheiUSrb2R5puOgNxsbXz9rBqf/LguTy9uAAYOOzBTP6ArQhgebzcySpZwdpPiZX
 zH3ldTIvUlOYoeCmGEHCLigeWzrW8IZbN0hfgLJottDY6u95S5PIV8+FKC0wydtEjKP0yWl3D
 OuHPBMEdd9AvTHR+h8zqCd2xZtdN8GsRdvNCcAxrHj9hMH7iJkARAKgs4LrN5SwShaKiElX1F
 N2/MiPKUay4ECF7RwTdb/a/LBgFc1H8PJ+0w+MUHA6B/rpRC1RuNBOTH9rx9gsEw2x5Yd/I4E
 +fFgh4/rumPXOIZLa23Rtb9ASnJXp930UVRCwOJXhzewe2HdVTdLKSZXv8ivgJ/Fw7hqvg4sg
 U8YzUP8WcGaF+VuvV/7lczls2sQVmKyN+ec+rSF2fLSeNTmGyJYHtg7/HeGI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 20 Jan 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Since we want to get rid of git-bisect.sh it would be necessary to
> convert those exit() calls to return statements so that errors can be
> reported.
>
> Emulate try catch in C by converting `exit(<positive-value>)` to
> `return <negative-value>`. Follow POSIX conventions to return
> <negative-value> to indicate error.
>
> Turn `exit()` to `return` calls in `check_merge_bases()`.
>
> In `check_merge_bases()` there is an early success special case,
> so we have introduced special error code `-11` which indicates early
> success. This `-11` is converted back to `0` in `check_good_are_ancestor=
s_of_bad()`.
>
> Handle the return value in dependent function `check_good_are_ancestors_=
of_bad()`.

This is a lot of repeated text from earlier commit messages. It might make
sense to condense it a bit, and while at it, to remove sentences that
essentially repeat what the diff says.

>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  bisect.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 385afaf875..367258b0dd 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -806,13 +806,16 @@ static void handle_skipped_merge_base(const struct=
 object_id *mb)
>   * "check_merge_bases" checks that merge bases are not "bad" (or "new")=
.
>   *
>   * - If one is "bad" (or "new"), it means the user assumed something wr=
ong
> - * and we must exit with a non 0 error code.
> + * and we must return error with a non 0 error code.
>   * - If one is "good" (or "old"), that's good, we have nothing to do.
>   * - If one is "skipped", we can't know but we should warn.
>   * - If we don't know, we should check it out and ask the user to test.
> + * - If a merge base must be tested, on success return -11 a special co=
ndition
> + * for early success, this will be converted back to 0 in check_good_ar=
e_ancestors_of_bad().
>   */
> -static void check_merge_bases(int rev_nr, struct commit **rev, int no_c=
heckout)
> +static int check_merge_bases(int rev_nr, struct commit **rev, int no_ch=
eckout)
>  {
> +	int res =3D 0;
>  	struct commit_list *result;
>
>  	result =3D get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
> @@ -827,11 +830,16 @@ static void check_merge_bases(int rev_nr, struct c=
ommit **rev, int no_checkout)
>  			handle_skipped_merge_base(mb);
>  		} else {
>  			printf(_("Bisecting: a merge base must be tested\n"));
> -			exit(bisect_checkout(mb, no_checkout));
> +			res =3D bisect_checkout(mb, no_checkout);
> +			if (!res)
> +				/* indicate early success */
> +				res =3D -11;

This is yet another good candidate for an `enum`.

> +			break;
>  		}
>  	}
>
>  	free_commit_list(result);
> +	return res;
>  }
>
>  static int check_ancestors(struct repository *r, int rev_nr,
> @@ -865,7 +873,7 @@ static void check_good_are_ancestors_of_bad(struct r=
epository *r,
>  {
>  	char *filename =3D git_pathdup("BISECT_ANCESTORS_OK");
>  	struct stat st;
> -	int fd, rev_nr;
> +	int fd, rev_nr, res =3D 0;
>  	struct commit **rev;
>
>  	if (!current_bad_oid)
> @@ -880,10 +888,13 @@ static void check_good_are_ancestors_of_bad(struct=
 repository *r,
>  		goto done;
>
>  	/* Check if all good revs are ancestor of the bad rev. */
> +
>  	rev =3D get_bad_and_good_commits(r, &rev_nr);
>  	if (check_ancestors(r, rev_nr, rev, prefix))
> -		check_merge_bases(rev_nr, rev, no_checkout);
> +		res =3D check_merge_bases(rev_nr, rev, no_checkout);
>  	free(rev);
> +	if(res)

Please put a space between the `if` keyword and the `(` following it.

Thanks,
Johannes

> +		exit(res =3D=3D -11 ? 0 : -res);
>
>  	/* Create file BISECT_ANCESTORS_OK. */
>  	fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> --
> 2.21.1 (Apple Git-122.3)
>
>
